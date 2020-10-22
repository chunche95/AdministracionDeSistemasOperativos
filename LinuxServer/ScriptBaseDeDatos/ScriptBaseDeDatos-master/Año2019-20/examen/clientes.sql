--------------------------------------------------------
-- Archivo creado  - lunes-enero-13-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CLIENTES
--------------------------------------------------------

  CREATE TABLE "BERMUDEZ"."CLIENTES" 
   (	"NOMBRE" VARCHAR2(100 BYTE), 
	"DNI" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into BERMUDEZ.CLIENTES
SET DEFINE OFF;
Insert into BERMUDEZ.CLIENTES (NOMBRE,DNI) values ('Pepe','1234');
Insert into BERMUDEZ.CLIENTES (NOMBRE,DNI) values ('Juan','4321');
Insert into BERMUDEZ.CLIENTES (NOMBRE,DNI) values ('Manolo','P899184e');
Insert into BERMUDEZ.CLIENTES (NOMBRE,DNI) values ('BERMUDEZ','9876');
