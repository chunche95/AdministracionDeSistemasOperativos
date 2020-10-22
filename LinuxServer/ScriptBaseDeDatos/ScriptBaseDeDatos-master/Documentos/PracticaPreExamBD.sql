create table tabla1 ( nombre varchar(255), apellido varchar(255), telefono number, direccion varchar(255));
create table tabla2 ( marca varchar(255), modelo varchar(255), iden number, tutor varchar(255));
create table tabla3 ( nombre varchar(255), marca varchar(255), iden number, direccion varchar(255));

insert into tabla1 values ('pepe', 'martinez', 1234, 'Calle 1  nº 2');
insert into tabla1 values ('papa', 'gonzales', 2341, 'Calle 2  nº 2');
insert into tabla1 values ('pipi', 'rodriguez', 3412, 'Calle 3  nº 2');
insert into tabla1 values ('popo', 'sanchez', 4123, 'Calle 4 nº 2');
insert into tabla1 values ('pupu', 'soto', 1234, 'Calle 5 nº 2');


/* LOCK TABLE [esquema.] table [opciones] IN lockmode MODE [NOWAIT] */ 




 /* Se pueden bloquear varias tablas en un solo comando si las escribimos separadas por comas. */

LOCK TABLE tabla1,tabla2,tabla3 IN ROW EXCLUSIVE MODE;


/*********************************************************************************************************/
/* 

    ROW SHARE = Permite hacer bloqueos de tipo ROW EXCLUSIVE o ROW SHARE o SHARE sobre las filas bloqueadas.
    ROW EXCLUSIVE = Permite hacer bloqueos de tipo ROW EXCLUSIVE o ROW SHARE sobre las filas bloqueadas.
    SHARE ROW EXCLUSIVE = Permite hacer bloqueos de tipo ROW SHARE sobre las filas bloqueadas.
    SHARE = Permite hacer bloqueos de tipo ROW SHARE or SHARE sobre las filas bloqueadas.
    EXCLUSIVE = Solo permite hacer SELECT sobre las filas bloqueadas.

*/
/*********************************************************************************************************/
