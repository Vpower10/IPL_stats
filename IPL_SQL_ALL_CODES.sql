-----------------------------------------------------------------------Dynamic Query Batsman Scorecard------------------------------------------------------------------

-------------V2----IPL_1s_match_ID - 335982-------------
select batter,
decode(wk_typ,'caught','c '||fielders_involved||' b '||bowler,'run out','Run Out('||fielders_involved||')','bowled','b '||bowler,'lbw','lbw b '||bowler,'Not Out') P,
runs R,balls B, fours,Sixes,trunc(runs/balls*100,2) SR from ((select batter,Decode((select fielders_involved from ipl_main i3 
where i3.batter=i1.batter and i3.iswicketdelivery=1 and i3.id=i1.id),'NA',' ',
(select fielders_involved from ipl_main i3 where i3.batter=i1.batter and i3.iswicketdelivery=1 and i3.id=i1.id)) fielders_involved,
nvl((select bowler from ipl_main i3 where i3.batter=i1.batter and i3.iswicketdelivery=1 and i3.id=i1.id),'Not Out') bowler,
(select kind from ipl_main i3 where i3.batter=i1.batter and i3.iswicketdelivery=1 and i3.id=i1.id) wk_typ,
min(innings) inn,min(overs) overs,sum(batsman_run) runs,count(batsman_run) Balls,
(select count(batsman_run) fours from ipl_main i2 where batsman_run=4 and i2.batter=i1.batter and i2.id=i1.id) fours,
(select count(batsman_run) fours from ipl_main i2 where batsman_run=6 and i2.batter=i1.batter and i2.id=i1.id) Sixes
from ipl_main i1 where id=&plz_enter_Match_id and extra_type in ('NA','legbyes','byes','noballs') and i1.innings=&which_innings  group by id,batter ) 
order by inn,overs,balls);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------Bowler_Scorecard---------------------------------------------------------------------------

---------------------------V2---------------------------
select ipl1.*,trunc(r/o,2) economy from (select bowler,
(select trunc(COUNT(total_run)/6,0)||'.'||mod(COUNT(total_run),6) from ipl_main i2 where i2.bowler = i1.bowler and i2.id=i1.id and i2.innings=i1.innings and extra_type in ('legbyes','NA','byes')) O,
(select sum(total_run) from ipl_main i2 where i2.bowler = i1.bowler and i2.id=i1.id and i2.innings=i1.innings and extra_type not in ('legbyes','byes')) R,
(select count(iswicketdelivery) from ipl_main i3 where i3.bowler=i1.bowler and i3.id=i1.id and i3.innings=i1.innings and i3.iswicketdelivery=1) w,
(select count(batsman_run) from ipl_main i4 where i4.bowler=i1.bowler and i4.id=i1.id and i4.innings=i1.innings and i4.batsman_run=4) fours,
(select count(batsman_run) from ipl_main i4 where i4.bowler=i1.bowler and i4.id=i1.id and i4.innings=i1.innings and i4.batsman_run=6) Sixes,
(select count(total_run) from ipl_main i5 where i5.bowler=i1.bowler and i5.id=i1.id and i5.innings=i1.innings and i5.extra_type='wides') wides,
(select count(total_run) from ipl_main i6 where i6.bowler=i1.bowler and i6.id=i1.id and i6.innings=i1.innings and i6.extra_type='no_ball') no_ball
from ipl_main i1 where id=&match_id and i1.innings =&inning group by i1.id,i1.innings,i1.bowler) ipl1;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------FOW-----------------------------------------------------------------------------------------
----------------------------------v2------------------
select rownum||'-'||R wkt,batter,overs||'.'||ballnumber||'ov' overs 
from
	(select overs,ballnumber,batter,
	(select sum(total_run) 
		from 
			ipl_main i2 where i2.id=i1.id and i2.overs<i1.overs and i2.innings=i1.innings or (i2.id=i1.id and i2.overs=i1.overs and i2.ballnumber<=i1.ballnumber and i2.innings=i1.innings)) "R"
				from 
					(select id,overs,ballnumber,batter,innings 
						from ipl_main where iswicketdelivery=1 and id=&Enter_match_id and innings=&enter_inning_number order by overs,innings) i1);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------TEAMS HEAD TO HEAD---------------------------------------------------------------------------------
SELECT 
TO_CHAR(IM1.TEAM1||' vs '||IM1.TEAM2) TEAMS_HEAD_TO_HEAD,
(SELECT COUNT(ID) FROM IPL_MRT IM2 WHERE (IM2.TEAM1=IM1.TEAM1 OR IM2.TEAM1=IM1.TEAM2) AND (IM2.TEAM2=IM1.TEAM2 OR IM2.TEAM2=IM1.TEAM1) ) TOTAL,
TO_CHAR(IM1.TEAM1) TEAM1,
(SELECT COUNT(ID) FROM IPL_MRT IM3 WHERE (IM3.TEAM1=IM1.TEAM1 OR IM3.TEAM1=IM1.TEAM2) AND (IM3.TEAM2=IM1.TEAM2 OR IM3.TEAM2=IM1.TEAM1) AND im3.winningteam=IM1.TEAM1 ) TEAM1_WINS, 
TO_CHAR(IM1.TEAM2) TEAM2,
(SELECT COUNT(ID) FROM IPL_MRT IM4 WHERE (IM4.TEAM1=IM1.TEAM1 OR IM4.TEAM1=IM1.TEAM2) AND (IM4.TEAM2=IM1.TEAM2 OR IM4.TEAM2=IM1.TEAM1) AND im4.winningteam=IM1.TEAM2 ) TEAM2_WINS
FROM IPL_MRT IM1 WHERE lower(TM1)=lower('&TEAM1') AND lower(TM2)=lower('&TEAM2') AND ROWNUM=1;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------Batter Bowler Head to Head------------------------------------------------------------------------------

select DISTINCT Innings,batter,runs,balls,sixes,fours,trunc(runs/innings,2) batter_avg,trunc(runs/balls*100,2) SR,bowler,wkt,dots FROM
(SELECT 
(select count(distinct id) from ipl_main im3 where im3.batter=im1.batter and im3.bowler=im1.bowler) Innings,
to_char(im1.batter) batter,
(select sum(batsman_run) from ipl_main im2 where im2.batter=im1.batter and im2.bowler=im1.bowler) runs,
(select count(1) from ipl_main im4 where im4.batter=im1.batter and im4.bowler=im1.bowler and extra_type not in('wide','WIDE','Wide','wides')) balls,
to_char(im1.bowler) Bowler,
(select count(1) from ipl_main im5 where im5.batter=im1.batter and im5.bowler=im1.bowler and im5.batsman_run=6) sixes,
(select count(1) from ipl_main im6 where im6.batter=im1.batter and im6.bowler=im1.bowler and im6.batsman_run=4) fours,
(select count(1) from ipl_main im2 where im2.batter=im1.batter and im2.bowler=im1.bowler and im2.iswicketdelivery=1 and im2.player_out=im1.batter  and kind not in('run out')) wkt, 
(select count(1) from ipl_main im5 where im5.batter=im1.batter and im5.bowler=im1.bowler and im5.total_run=0) dots
FROM IPL_MAIN im1 WHERE lower(BATTER) like lower('%&Batter%') AND lower(BOWLER) like lower('%&Bowler%'));

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------Point Table for all Seasons---------------------------------------------------------------------------

-------------------v2-------------------
select distinct team,M,W,M-W-nor L,W*2+nor Pts,nor from
(select id,im1.winningteam team,
(select COUNT(1) from ipl_mrt im3 where (im3.team1=im1.winningteam or im3.team2=im1.winningteam) and im3.season=im1.season and im3.matchnumber not in('Qualifier 1','Final','Qualifier 2','Eliminator','Qualifier')) M,
(select COUNT(1) from ipl_mrt im2 where im2.winningteam=im1.winningteam and im2.season=im1.season and im2.matchnumber not in('Qualifier 1','Final','Qualifier 2','Eliminator','Qualifier')) W,
(select count(1) from ipl_mrt im4 where (im4.team1=im1.winningteam or im4.team2=im1.winningteam) and im4.season=im1.season and im4.wonby='NoResults') nor
from ipl_mrt im1 where season like '%&season%' )  where team <>'NA' order by w desc;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------IPL_ALL_100_with_BATTER_&_WINNING_TEAM----------------------------------------------------------------------------

select id,bat,r,b,trunc(r/b*100,2) sr,bt Team,decode(bt,t1,t2,t1) Opposition,wt winning_team,decode(bt,wt,'Y','N') fl from
(select im1.id,batter bat,battingteam bt,runs r,ball b,team1 t1,team2 t2,winningteam wt from
(select id ,batter,battingteam,sum(batsman_run) runs,count(ballnumber) ball 
from ipl_main where extra_type not in ('wides') group by id,batter,battingteam having sum(batsman_run)>=100) IM1 
left outer join 
ipl_mrt Im2 on im1.id=im2.id) order by id;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------