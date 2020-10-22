--------------------------------------------------------
-- Archivo creado  - lunes-enero-13-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table PRODUCTOS
--------------------------------------------------------

  CREATE TABLE "BERMUDEZ"."PRODUCTOS" 
   (	"NOMBRE" VARCHAR2(100 BYTE), 
	"ID" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into BERMUDEZ.PRODUCTOS
SET DEFINE OFF;
Insert into BERMUDEZ.PRODUCTOS (NOMBRE,ID) values ('Porras','a1234');
Insert into BERMUDEZ.PRODUCTOS (NOMBRE,ID) values ('Churros','a4321');
Insert into BERMUDEZ.PRODUCTOS (NOMBRE,ID) values ('Patatas','P899184e');
Insert into BERMUDEZ.PRODUCTOS (NOMBRE,ID) values ('BERMUDEZ','a9876');
