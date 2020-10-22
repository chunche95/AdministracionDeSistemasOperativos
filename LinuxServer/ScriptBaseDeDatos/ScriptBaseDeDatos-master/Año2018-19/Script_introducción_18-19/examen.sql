CREATE TABLE alumno (
    id_alumno                 numeric (10,0) NOT NULL,
    nombre_alumno             VARCHAR2(1024) NOT NULL,
	dni						  VARCHAR2(1024) NOT NULL
);
CREATE TABLE curso (
    id_curso           numeric (10,0) NOT NULL,
    year          	   numeric (10,0) NOT NULL,
    nombre_materia     VARCHAR2(1024) NOT NULL  
);
CREATE TABLE nota (
    id_alumno        numeric (10,0) NOT NULL,
    id_curso         numeric (10,0) NOT NULL,
    nota             numeric (4,2) 
);
CREATE TABLE   materia (
nombre_materia      VARCHAR2(1024) NOT NULL
);
ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY (id_alumno);
ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY (id_curso);
ALTER TABLE materia ADD CONSTRAINT materia_pk PRIMARY KEY (nombre_materia);
ALTER TABLE nota ADD CONSTRAINT nota_pk PRIMARY KEY (id_alumno,id_curso);
ALTER TABLE nota ADD CONSTRAINT notas_FK FOREIGN KEY 
  (id_curso) REFERENCES curso (id_curso);
ALTER TABLE nota ADD CONSTRAINT nota_FK FOREIGN KEY 
  (id_alumno) REFERENCES alumno (id_alumno);
ALTER TABLE curso ADD CONSTRAINT curso_FK FOREIGN KEY 
  (nombre_materia) REFERENCES materia (nombre_materia);
  
  create  or replace view V_ALUMNOS(idalumno, nombre, dni) as
select id_alumno,nombre_alumno,dni
from alumno;

create  or replace view V_CURSOS(idcurso, year, nombremateria) as
select id_curso,year,nombre_materia
from curso;

create  or replace view V_NOTAS(idalumno, idcurso, nota) as
select id_alumno,id_curso,nota
from nota;

create  or replace view V_MATERIAS_APROBADAS(idalumno,nombremateria) as
select n.id_alumno, c.nombre_materia
from nota n, curso c
where n.id_curso=c.id_curso and n.nota >=5;
create sequence sequence_alumno_id;
select sequence_alumno_id.nextval from dual;
create sequence sequence_curso_id;

create  or replace procedure CREAR_ALUMNO(nombre IN varchar, vdni IN varchar, idalumno OUT numeric)
as
    fila alumno%rowtype;
    comdni number;
begin
    fila.nombre_alumno:=nombre;	
    idalumno:=sequence_alumno_id.nextval;
    fila.dni:=vdni;
    select count(*) into comdni from alumno where dni=vdni; 
    if (comdni=1) then
    raise_application_error(-20104,'DNIYAEXISTE');
    end if;
    fila.id_alumno:= idalumno;  
    insert into alumno values fila;
    
end;
/
create  or replace procedure CREAR_CURSO(nombremateria IN varchar, vyear IN numeric, idcurso OUT numeric)
as
    fila curso%rowtype;
begin
    fila.year:=vyear;	
    idcurso:=sequence_curso_id.nextval;
    fila.nombre_materia:=nombremateria;
    fila.id_curso:= idcurso;  
    insert into curso values fila;   
end;
/
declare
    idnuevo numeric;
begin
    crear_curso('conocimiento',2018,idnuevo);
     dbms_output.put_line(idnuevo);
end;
/
select * from curso;
delete from curso where id_curso=4;
create  or replace procedure CREAR_MATERIA(nombremateria IN VARCHAR)
as
    fila materia%rowtype;
    mat number;
begin
    fila.nombre_materia:=nombremateria;
    select count(*) into mat from materia where nombre_materia=nombremateria;
    if(mat=1) then
    raise_application_error(-20100,'MATERIAYAEXISTE');
    end if;
    insert into materia values fila;  
end;
/
begin
    crear_materia('conocimiento');
end;
/
declare 
    nombre varchar(1024);
    dni varchar(1024);
    idalumno numeric;
begin
    crear_alumno('pedro','12345658',idalumno);
     dbms_output.put_line(idalumno);
end;
/
select * from alumno;
insert into curso values(2,2017,'mate');
insert into materia values('mate');
create  or replace procedure MATRICULAR_ALUMNO(vidalumno numeric, vyear numeric, vnombremateria varchar)
as
    fila nota%rowtype;
    idal number;
    idcurso numeric;
    mat number;
    maxalum number;
    aprob number;
    creamat number;
    idcur number;
    idnuevo numeric;
begin
    fila.id_alumno:=vidalumno;
    fila.nota:=null;
    select count(*) into creamat from materia where nombre_materia=vnombremateria;
    if (creamat=0) then
    crear_materia(vnombremateria);
    end if;
    select count(*) into idcur from curso where nombre_materia=vnombremateria and year=vyear;
    if (idcur=1) then
    select id_curso into idcurso from curso where nombre_materia=vnombremateria and year=vyear;
    fila.id_curso:=idcurso;
    else
    crear_curso(vnombremateria,vyear,idnuevo);
    fila.id_curso:=idnuevo;
    end if;
    select count(*) into idal from alumno where id_alumno=vidalumno; 
    if (idal=0) then
    raise_application_error(-20105,'ALUMNONOEXISTE');
    end if;
    select count(*) into aprob from v_materias_aprobadas
        where idalumno=vidalumno and nombremateria=vnombremateria;
    if (aprob=1) then
    raise_application_error(-20107,'YAAPROBADO');
    end if;
    select count(*) into mat from nota where id_alumno=vidalumno and id_curso=fila.id_curso;
    if (mat=1) then
    raise_application_error(-20106,'YAMATRICULADO');
    end if;
    select count(*) into maxalum from nota where id_curso=fila.id_curso;
    if (maxalum=4) then
    raise_application_error(-20102,'CURSOLLENO');
    end if;
    insert into nota values fila;
    
end;
/
begin
    matricular_alumno(17,2018,'lengua');
end;
/
select * from nota;
select * from alumno;
select * from materia;
insert into nota values (17,2,5);
select * from v_materias_aprobadas;

create  or replace procedure ASIGNAR_NOTA(vidalumno numeric, vyear numeric, vnombremateria varchar, vnota numeric)
as
    fila nota%rowtype;
    idal number;
    idcurso number;
    aprob number;
    mat number;
    mat2 number;
    idcur number;
    nonot number;
begin
    select count(*) into idcur from curso where nombre_materia=vnombremateria and year=vyear;
    if (idcur=1) then
    select id_curso into idcurso from curso where nombre_materia=vnombremateria and year=vyear;
    fila.id_curso:=idcurso;
    end if;
    select count(*) into idal from alumno where id_alumno=vidalumno; 
    if (idal=0) then
    raise_application_error(-20105,'ALUMNONOEXISTE');
    end if;
    select count(*) into mat from nota where id_alumno=vidalumno and id_curso=idcurso;
    select count(*) into mat2 from nota, curso where nota.id_alumno=vidalumno and nota.id_curso=curso.id_curso and curso.nombre_materia=vnombremateria;
    if (mat=0 or mat2=0) then
    raise_application_error(-20110,'NOMATRICULADO');
    end if;
    select count(*) into aprob from nota
        where id_alumno=vidalumno and id_curso=idcurso and nota is not null;
    if (aprob>=1) then
    raise_application_error(-20111,'NOTAYAASIGNADA');
    end if;
    select count(*) into nonot from nota
	where id_alumno=vidalumno and id_curso=idcurso and nota is null;
    if (nonot=1) then
	update nota
	set nota=vnota
	where id_curso=idcurso and id_alumno=vidalumno;
    end if;
end;
/
begin
    asignar_nota(17,2017,'mate',7);
end;
/