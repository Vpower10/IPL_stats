
  CREATE TABLE "SRC"."IPL_MRT" 
   (	"ID" NUMBER(7,0) NOT NULL ENABLE, 
	"CITY" VARCHAR2(13 BYTE), 
	"DATE_M" VARCHAR2(19 BYTE), 
	"SEASON" VARCHAR2(7 BYTE), 
	"MATCHNUMBER" VARCHAR2(17 BYTE), 
	"TEAM1" VARCHAR2(27 BYTE), 
	"TM1" VARCHAR2(27 BYTE), 
	"TEAM2" VARCHAR2(27 BYTE), 
	"TM2" VARCHAR2(27 BYTE), 
	"VENUE" VARCHAR2(52 BYTE), 
	"TOSSWINNER" VARCHAR2(27 BYTE), 
	"TOSSDECISION" VARCHAR2(5 BYTE), 
	"SUPEROVER" VARCHAR2(2 BYTE), 
	"WINNINGTEAM" VARCHAR2(27 BYTE), 
	"WONBY" VARCHAR2(9 BYTE), 
	"MARGIN" VARCHAR2(3 BYTE), 
	"METHOD" VARCHAR2(3 BYTE), 
	"PLAYER_OF_MATCH" VARCHAR2(17 BYTE), 
	"TEAM1PLAYERS" VARCHAR2(170 BYTE), 
	"TEAM2PLAYERS" VARCHAR2(174 BYTE), 
	"UMPIRE1" VARCHAR2(21 BYTE), 
	"UMPIRE2" VARCHAR2(21 BYTE), 
	 PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;

