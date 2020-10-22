    /* Ve tablas de usuario */
    select * from user_tables;
    
    create table
                ALUMNOS( DNI varchar (10), NOMBRE varchar (10));
    insert into
                ALUMNOS values('1','Pepe');
    insert into
                ALUMNOS values('2','Juan');
    insert into
                ALUMNOS values('3','María');
                
                select * from bermudez.carreras;
   
             
insert into carreras values (20 , '01/12/18', 'Manolo');
 /* Bloqueo con un FOR UPDATE */ 
select id_circuito from carreras for update;

/* bloqueo de TODA la TABLA */
lock table carreras in exclusive mode;
select * from carreras;
/* Bloqueo automatico de tabla */
set transaction isolation level serializable;