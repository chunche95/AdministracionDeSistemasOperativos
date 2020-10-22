--------------------------------------------------------
--  DDL for Table TABLA1
--------------------------------------------------------

  CREATE TABLE "CASA"."TABLA1" 
   (	"NOMBRE" VARCHAR2(255 BYTE), 
	"APELLIDO" VARCHAR2(255 BYTE), 
	"TELEFONO" NUMBER, 
	"DIRECCION" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
