drop table DF;
create table DF(hora varchar(40),sistema varchar(40),tamano varchar(40),usado varchar(40),montado varchar(40));
drop table empleados;
CREATE TABLE empleados(
         empno      NUMBER(5),
         empname      VARCHAR2(15) ,
         empjob        VARCHAR2(10),
         empsal        NUMBER(7,2),
         empdeptno     NUMBER(3) NOT NULL
                    );
/*
   TABLESPACE tablespacePau
   STORAGE ( INITIAL 50K);

COMMENT ON TABLE empleados IS 'tabla de empleados de pruebas';
*/
drop table departamentos;
create table departamentos(
    namedep   varchar(20),
    numerodep  number(3),
    tamanodep    number(3)
);
/*
tablespace tablespacePau
storage (initial 10k);

comment on table departamentos is ' tabla de departamentos de pruebas';
*/
drop table productos;
create table productos(
    nameprod       varchar(20),
    idprod         number(5),
    priceprod      number(4),
    locationprod   varchar(10)    
);
/*
tablespace tablespacePau
storage (initial 1M);

comment on table productos is ' tabla de productos de pruebas';
*/

insert into empleados values(1,'juan','jefe',60000,0);
insert into empleados values(2,'pepe','logistica',15000,3);
insert into empleados values(3,'paqui','jefa',62000,0);
insert into empleados values(4,'mari','marketing',48000,1);
insert into empleados values(5,'isa','Produccion',33000,2);

insert into departamentos values('Logistica',3,250);
insert into departamentos values('Marketing',3,250);
insert into departamentos values('RRHH',0,2);
insert into departamentos values('Administracion',0,2);
insert into departamentos values('Produccion',2,500);
insert into departamentos values('Envios',3,25);


insert into productos values('Boli',1,1,'Boli-1');
insert into productos values('Reloj',2,4,'Reloj-1');
insert into productos values('Raton',3,5,'Raton-1');
insert into productos values('Folios',4,5,'Folios-1');
insert into productos values('Rotulador',2,1,'Rotu-1');


select * from empleados; select * from departamentos; select * from productos;