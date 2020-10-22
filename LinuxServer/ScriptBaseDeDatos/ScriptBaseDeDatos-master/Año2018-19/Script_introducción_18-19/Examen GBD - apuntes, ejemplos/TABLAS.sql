
-- drop table alumno cascade constraints;
-- drop table curso cascade constraints;
-- drop table nota cascade constraints;
-- drop view V_alumnos cascade constraints;
-- drop view V_CURSOS cascade constraints;
-- drop view V_materias_aprobadas cascade constraints;
-- drop view V_notas cascade constraints;
-- drop procedure procedimiento*;
-- drop function funcion*;
-- drop sequence secuencia*;

CREATE TABLE alumno 
(
    id_alumno                 numeric (10,0) NOT NULL,
    nombre_alumno             VARCHAR2(1024) NOT NULL,
	dni						  VARCHAR2(1024) NOT NULL UNIQUE
);
CREATE TABLE curso 
(
    id_curso           numeric (10,0) NOT NULL,
	nombre_materia     VARCHAR2(1024) NOT NULL,
    anno          	   numeric (10,0) NOT NULL
     
);
CREATE TABLE nota 
(
    id_alumno        numeric (10,0) NOT NULL,
    id_curso         numeric (10,0) NOT NULL,
    notas            numeric (4,2) 
);
ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY (id_alumno);
ALTER TABLE nota ADD CONSTRAINT notas_FK FOREIGN KEY (id_curso) REFERENCES curso (id_curso);
ALTER TABLE nota ADD CONSTRAINT notas_FK FOREIGN KEY (id_alumno) REFERENCES alumno (id_alumno);
ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY (id_curso);
ALTER TABLE nota ADD CONSTRAINT notas_pk PRIMARY KEY (id_alumno,id_curso);

commit;
