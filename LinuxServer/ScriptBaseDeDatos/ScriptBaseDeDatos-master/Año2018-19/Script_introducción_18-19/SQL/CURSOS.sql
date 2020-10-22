create table alumno
(idalumno NUMERIC(10,0),
nombre VARCHAR(1024),
dni VARCHAR(1024),
PRIMARY KEY (idalumno));

create table asignatura
(idcurso NUMERIC(10,0),
nombremateria VARCHAR(1024),
year NUMERIC(10,0),
PRIMARY KEY (idcurso));

create table nota
(idcurso_fk NUMERIC(10,0),
idalumno_fk NUMERIC(10,0),
nota NUMERIC(4,2),
FOREIGN KEY (idcurso_fk) REFERENCES asignatura (idcurso),
FOREIGN KEY (idalumno_fk) REFERENCES alumno (idalumno));

create or replace view V_ALUMNOS
as
select idalumno, nombre, dni from alumno;

select * from v_alumnos;

create or replace view V_CURSOS
as
select idcurso, year, nombremateria from asignatura;

select * from v_cursos;


create or replace view V_NOTAS
as
select idalumno_fk, idcurso_fk, nota from nota;

select * from v_notas;

-- Vista de alumnos con materias aprobadas (nota ? 5 ), sin duplicados: V MATERIAS APROBADAS(idalumno,nombremateria)

create or replace view V_MATERIAS_APROBADAS as
select idalumno_fk, nombremateria from nota, asignatura where nota >=5 and idcurso=idcurso_fk group by NOMBREMATERIA, idalumno_fk;

select * from V_MATERIAS_APROBADAS;
select * from nota;






--create or replace view V_MATERIAS_APROBADAS
--as
--select distinct nota.idalumno_fk, asignatura.nombremateria, asignatura.idcurso, nota from nota, asignatura where nota>=5;

-- -------------------------------------------------------------------------------------- 
create sequence SECUENCIA_IDALUMNO start with 1;
create sequence SECUENCIA_IDCURSO start with 10;
-- --------------------------------------------------------------------------------------

create or replace procedure ALTA_ALUMNO (p_nombre IN VARCHAR, p_dni IN VARCHAR, p_idalumno OUT NUMERIC)
as
begin
p_idalumno := (SECUENCIA_IDALUMNO.nextval);
insert into ALUMNO (idalumno, nombre, dni) values (p_idalumno, p_nombre, p_dni);
end;
/

declare nuevo_idalumno numeric;
begin 
ALTA_ALUMNO ('Maria','x3066165n', nuevo_idalumno);
dbms_output.put_line (nuevo_idalumno);
end;
/

select * from V_ALUMNOS;

-- --------------------------------------------------------------------------------------

create or replace procedure ALTA_ASIGNATURA (p_nombremateria IN VARCHAR, p_year IN NUMERIC, p_idcurso OUT NUMERIC)
as
begin
p_idcurso := (SECUENCIA_IDCURSO.NEXTVAL);
    insert into ASIGNATURA (idcurso, nombremateria, year) values (p_idcurso, p_nombremateria, p_year);
end;
/

declare nuevo_idcurso numeric;
begin 
ALTA_ASIGNATURA ('Ciencias',2017, nuevo_idcurso);
dbms_output.put_line (nuevo_idcurso);
end;
/

select * from ASIGNATURA;
-- -----------------------------------------------------------------------------------------
--Existe ese alumno

create or replace function EXISTE_ALUMNO(p_idalumno IN NUMERIC)
return numeric
as
consulta_idalumno numeric;
existe numeric;
BEGIN
    select count(idalumno) into consulta_idalumno from alumno where idalumno=p_idalumno;
    if (consulta_idalumno = 0) then
        raise_application_error(-20105, 'El Alumno no existe');
    else
        return existe;
    end if;
end;
/
--Cantidad ALumnos matriculados en un curso

create or replace function MATRICULAS_CURSO(p_idcurso IN numeric)
return numeric
as
matriculados numeric;
consulta_idcurso numeric;
BEGIN
    select count (idcurso) into consulta_idcurso from asignatura where idcurso=p_idcurso;
    if (consulta_idcurso = 0) then
        raise_application_error(-20102, 'El curso no existe');
    else
        select count(idcurso_fk) into matriculados from nota where idcurso_fk=p_idcurso;
        return matriculados;
    end if;
END;
/
-- -----------------------------------------------------------------------------------------
--Mirar si la asignatura esta creada
create or replace function EXISTE_ASIGNATURA(p_idcurso IN NUMERIC)
return numeric
as
consulta_idcurso numeric;
existe_c numeric;
BEGIN
    select count(idcurso) into consulta_idcurso from asignatura where idcurso=p_idcurso;
    if (consulta_idcurso = 0) then
        raise_application_error(-20505, 'La asignatura no existe');
    else
        return existe_c;
    end if;
end;
/

 -- -----------------------------------------------------------------------------------------
-- no mas de 4 alumnos

create or replace procedure ALTA_ALUMNO_CURSO (p_idalumno IN NUMERIC, p_idcurso IN numeric)
as
matriculados NUMERIC;
existe NUMERIC;
existe_c NUMERIC;
begin
existe :=EXISTE_ALUMNO(p_idalumno);
matriculados :=MATRICULAS_CURSO(p_idcurso);
existe_c :=EXISTE_ASIGNATURA(p_idcurso);
if (existe=1) then
    if (existe_c=1)then
        if (matriculados>=4) then
           raise_application_error(-20202, 'El curso no admite mas matriculaciones, CURSO LLENO!!');
        else
        insert into NOTA (idalumno_fk, idcurso_fk) values (p_idalumno, p_idcurso);
        end if;
    end if;
end if;
end;
/

begin
ALTA_ALUMNO_CURSO (5,11);
end;
/

select * from NOTA;
-- ---------------------------------------------------------------------------------------

create or replace procedure ASIGNAR_NOTA (p_idalumno IN NUMERIC, p_idcurso IN VARCHAR, p_nota IN NUMERIC)
as
begin
UPDATE NOTA  
    SET nota = p_nota  
    WHERE p_idalumno=idalumno_fk and p_idcurso=idcurso_fk;
end;
/

select * from nota;

begin 
ASIGNAR_NOTA (2,10,2);
end;
/

-- ---------------------------------------------------------------------------------------

-- DAR DE BAJA UN ALUMNO de un curso

create or replace procedure BAJA_ALUMNO (p_idalumno IN NUMERIC, p_idcurso IN NUMERIC)
as
begin
    delete from nota where idalumno_fk=p_idalumno and p_idcurso=idcurso_fk;
end;
/

begin
    baja_alumno(1,10);
end;
/

select * from nota;