/* ver informacion general de la base de datos */
select * from dict;
/* ver informacion de usuarios en la BD */
select * from dict  where comments like '%user%';
/* ver usuarios de registrados en la BD */
select * from all_users order by username;
/* ver los ficheros de datos (.dbf) de la BD */
select * from dba_data_files;

