create table alumnos (
    id_alumno varchar(255),
    nombre varchar(255),
    DNI char(9),
    primary key(id_alumno)
);

create table materia (
    id_materia varchar(255),
    nombre varchar(255),
    primary key(id_materia)
);

create table curso (
    id_curso varchar(255),
    id_materia varchar(255),
    nombre varchar(255),
    primary key(id_curso,id_materia),
    foreign key(id_materia) references materia(id_materia)
);

create table matriculas (
    id_materia varchar(255),
    id_curso varchar(255),
    id_alumno varchar(255),
    anio numeric,
    nota numeric,
    primary key(id_materia,id_curso),
    foreign key(id_alumno) references alumnos(id_alumno),
    foreign key(id_curso,id_materia) references curso(id_curso,id_materia)
);

--CREACION DE VISTAS
create or replace view V_ALUMNOS(idalumno,nombre,dni)
as 
select 
    id_alumno,
    nombre,
    DNI
from
    alumnos;


create view V_CURSOS (idcurso,year,nombremateria)
as
select
    m.id_curso, 
    m.anio, 
    mm.nombre
from 
    matriculas m, 
    materia mm
where 
    mm.id_materia=m.id_materia;

create view V_NOTAS (idalumno,idcurso,nota)
as
select 
    id_alumno,
    id_curso, 
    nota
from 
    matriculas;



create view V_MATERIAS_APROBADAS (idalumno,nombremateria)
as
select
    mm.id_alumno,
    m.nombre
from
    matriculas mm, 
    materia m
where 
    mm.id_materia=m.id_materia AND 
    mm.nota >= 5;

--Crear proceso para conseguir un id al cada alumno que añadas

create or replace function EXISTEALUMNO(
    ALUMNO VARCHAR
)
return number
as
    SIEXISTE number;
begin
    select 
        count(DNI)
    into 
        SIEXISTE
    from
        ALUMNOS
    where 
        ALUMNO = DNI;
    
    if(SIEXISTE=1) then
        return 1;
        
    else
    
        return 0;
        
    end if;
end;
/


create sequence conseguir_id;

create  or replace procedure CREAR_ALUMNO(
	procnombrealumno in varchar,
    procdni char,
    procid_alumno out numeric

)
as
    alumnoexiste number;
	nuevoid number;
 
begin

    if ( existealumno(procdni) = 1) then

		raise_application_error(-20001,'DNIYAEXISTE');
	
    else
        nuevoid := conseguir_id.nextval;
        procid_alumno := nuevoid;
        
        insert into
            alumnos(id_alumno,nombre,DNI)
        values
            (procid_alumno,procnombrealumno,procdni);
    end if;
end;
/
/*
declare
    nombre varchar(255);
    dni char(9);
    vid numeric;
    
begin
    nombre:='juan';
    dni:='12346678A';
    crear_alumno(nombre,dni,vid);
end;
/

*/


create or replace function estamatriculado(
    alumno varchar
)
return number
as
    siestamatriculado number;
begin
    select 
        count(id_alumno)
    into
        siestamatriculado
    from 
        matriculas
    where
        alumno = id_alumno;
    
    if(siestamatriculado=1) then
    
        return 1;
        
    else
    
        return 0;
    
    end if;
end;
/

create or replace function yaaprobado(
    alumno varchar   
)
return number 
as
    estaaprobado number;
begin
    select 
        count(id_alumno)
    into
        estaaprobado
    from
        matriculas
    where
        alumno=id_alumno and
        nota >= 5;

    if (estaaprobado>=1) then
        
        return 1;
    
    else

        return 0;
    
    end if;
end;
/

create or replace function cursolleno(
    alumno varchar,
    curso varchar
)
return number
as
    cursollenito number;
begin
    select 
        count(id_alumno)
    into
        cursollenito
    from
        matriculas,
        curso
    where
        alumno=id_alumno and curso=id_curso;

    if (cursollenito>=3) then

        return 1;
    else

        return 0;

    end if;        
end
;
/



CREATE OR REPLACE PROCEDURE MATRICULAR_ALUMNO(
    procidalumno numeric,
    procyear numeric, 
    procnombremateria varchar
    )
as
    cursito varchar(255);
    materialitas varchar(255);

begin

    select
        id_curso
      into 
        cursito
      from 
        curso c, 
        materia m
     where 
        c.id_materia=m.id_materia and 
        m.nombre=procnombremateria

    if (estamatriculado(procidalumno)=1)then

        raise_application_error(-20003,'YAMATRICULADO');

    end if;

    if (yaaprobado(procidalumno)=1)then

        raise_application_error(-20004, 'YAAPROBADO');

    end if;

    if (cursolleno(procidalumno)=1)then

        raise_application_error(-20005, 'CURSOLLENO');

    end if;


    select 
        id_materia
      into 
        materialitas
      from
        materia
     where 
        procnombremateria=nombre;

    insert into 
       matriculas (id_alumno,anio, id_materia)
    values
        (procidalumno, procyear, procnombremateria);
end;
/

create or replace function nomatriculado(
    alumno varchar,
    materia varchar,
    fanio number
)

return number

as
    noloesta number;
begin
    select
       count(id_alumno)
    into
        noloesta
    from 
        matriculas
    where
        alumno=id_alumno and
        materia=id_materia and 
        fanio=anio;

    if(noloesta=1) then
        return 1;
    else
        return 0;
    end if;
end;
/

create or replace function notayaasignada(
    alumno varchar,
    materia varchar,
    funanio number
)
return number
as
    yaasignada number;
begin
    select
       count(nota)
    into
        yaasignada
    from 
        matriculas
    where

        alumno=id_alumno and 
        materia=id_materia and 
        anio=funanio;

    if(yaasignada>=1) then
        return 1;
    else
        return 0;
    end if;
end;
/

create or replace function alumnonoexiste(
    alumno varchar
)
return number
as
    noexiste number;
begin
    select
        count(id_alumno)
    into
        noexiste
    from 
        alumnos
    where
        alumno=id_alumno;

    if(noexiste=1) then

        return 1;
    
    else
    
        return 0;
    
    end if;
end;
/

CREATE OR REPLACE PROCEDURE ASIGNAR_NOTA(
    idalumno numeric,
    year numeric,
    nombremateria varchar,
    nota numeric
)
as
    materia varchar(255)
begin

    select 
        id_materia
      into
        materia
      from 
        matriculas
     where 
        nombremateria=nombre;
    
    select 
        id_curso
      into 
        curso
      from 
        matriculas
     where 
        id_materia=materia;

    if (alumnonoexiste(idalumno)=0)then

        raise_application_error('ALUMNONOEXISTE');
    
    end if;
    
    if (nomatriculado(idalumno,materia,year)=0)then
    
        raise_application_error('NOMATRICULADO');
    
    end if;

    if (notayaasignada(idalumno,materia,year)=1)then
    
        raise_application_error('NOTAYAASIGNADA');
    
    end if;
    
    insert into
        matriculas (id_materia, id_curso,id_alumno, anio, nota )
    values
        (idalumno, nombremateria, year, nota);
    
end;
/

