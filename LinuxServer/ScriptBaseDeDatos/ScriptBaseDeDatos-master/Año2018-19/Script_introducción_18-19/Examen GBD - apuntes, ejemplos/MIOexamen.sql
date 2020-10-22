create table alumnos (
    id_alumno numeric(30),
    DNI varchar(10),
    nombre varchar(50),
    primary key(id_alumno)
);

create table materia (
    id_materia varchar(30),
    nombre varchar(30),
    descripcion varchar(30),
    primary key(id_materia)
);

create table curso (
    id_curso varchar(30),
    nombre varchar(30),
    primary key(id_curso)
);

create table curso_materia (
    id_materia varchar(30),
    id_curso varchar(30),
    anio varchar(30),
    primary key(id_materia,id_curso,anio),
    foreign key(id_materia) references materia(id_materia),
    foreign key(id_curso) references curso(id_curso)
);

create table matricula_curso (
    id_alumno numeric(30),
    id_curso varchar(30),
    nota number,
    primary key(id_alumno,id_curso),
    foreign key(id_alumno) references alumnos(id_alumno),
    foreign key(id_curso) references curso(id_curso)
);

create table matricula_materia (
    id_alumno numeric(30),
    id_materia varchar(30),
    year timestamp,
    primary key(id_alumno,id_materia),
    foreign key(id_alumno) references alumnos(id_alumno),
    foreign key(id_materia) references materia(id_materia)
);
create or replace view V_ALUMNOS (idalumno,nombre,dni)
as
select id_alumno, nombre, DNI
from alumnos;

create or replace view V_CURSOS (idcurso,anio,nombremateria)
as
select c.id_curso, cm.anio, m.nombre
from curso c, materia m, matricula_materia cm
where m.id_materia=cm.id_materia;

create or replace view V_NOTAS (idalumno,idcurso,nota)
as
select id_alumno, id_curso, nota
from matricula_curso;

create or replace view V_MATERIAS_APROBADAS (idalumno,nombremateria)
as
select mm.id_alumno, m.nombre
from matricula_materia mm, materia m
where mm.id_materia=m.id_materia AND mm.nota >= 5;

--EJERCICIO 2

create or replace function existedni(
    dnialumno varchar)
return number
as
    cantidad number;
begin
    select count(*)
    into cantidad
    from alumnos
     where dnialumno = dni;
        
    if(cantidad = 0) then
        return 0;
    else
        return 1;
    end if;
end;
/

create sequence contador;

create  or replace procedure CREAR_ALUMNO(
    nombre varchar,
	dni varchar, 
	idalumno out numeric
)
as
	nuevoid number := contador.nextval;
    id_alumno number := nuevoid;
begin
    if( existedni(id_alumno) = 1) then
        raise_application_error(-20001, 'DNIYAEXISTE');
    end if;
  insert into
    alumnos(id_alumno,dni,nombre)
  values
    (idalumno,dni,nombre);
end;
/

    
--EJERCICIO3

create or replace function notaaprobado(
    aprobado varchar)
return number
as
    sino number;
begin
    select count(*)
    into sino 
    from matricula_curso
    where nota >= 5 and
    aprobado = nota;
    
    if (sino >= 5) then
        return 1;
    else
        return 0;
    end if;
end;
/

create or replace function matriculados(
    numeromatriculados varchar)
return number
as
    numero number;
begin
    select count(id_alumno)
    into numero 
    from matricula_curso
    where numeromatriculados = id_alumno;
    
    if (numero = 4) then
        return 1;
    else
        return 0;
    end if;
end;
/

create  or replace procedure MATRICULAR_ALUMNO(
    id_alumno in numeric,
	id_materia in varchar, 
	year in timestamp
)
as
    nota number;
begin
    if( existeid(id_alumno) = 0) then
        raise_application_error(-20001, 'ALUMNONOEXISTE');
    end if;
    
    if(existeid(id_alumno) = 1) then
    raise_application_error(-20002, 'YAMATRICULADO');
    end if;
    
    if(notaaprobado(nota) = 1 ) then
    raise_application_error(-20003, 'YAAPROBADO');
    end if;
    
    if(matriculados(id_alumno) = 1) then
    raise_application_error(-20004, 'CURSOLLENO');
    end if;
    
    insert into matricula_materia (id_alumno,id_materia,year)
    values(id_alumno,id_materia,year);
end;
/
--EJERCICIO 5

