/* creacion de un directorio para la copia de seguridad */
/*------------------------------------------------------*/
grant create any directory to paulino;
create or replace directory backupsPAU as '/home/alumno/scripts';

/*------------------------------------------------------*/
/* 		privilegios sobre el directorio 	*/
/*------------------------------------------------------*/
GRANT READ, WRITE ON DIRECTORY backupsPAU TO paulino;


/*------------------------------------------------------*/
/*  copia de seguridad de TABLAS de LA BASE DE DATOS	*/
/*------------------------------------------------------*/
expdp paulino/paulino@88.29.75.143/asir tables=matriculas,multas directory=backupsPAU dumpfile=PAUCHINO.dmp logfile=expdpPAUCHINO.log
impdp paulino/paulino@88.29.75.143/asir tables=matriculas,multas directory=backupsPAU dumpfile=PAUCHINO.dmp logfile=impdpPAUCHINO.log

/*----------------------------------------------------------------*/
/* copia de seguridad de TODA EL ESQUEMA DE BASE DE DATOS->schema */
/*----------------------------------------------------------------*/
expdp paulino/paulino@88.29.75.143/asir schemas=PAULINO directory=backupsPAU dumpfile=paulino.dmp logfile=expdpcopiaPAU.log
impdp paulino/paulino@88.29.75.143/asir schemas=PAULINO directory=backupsPAU dumpfile=paulino.dmp logfile=impdpcopiaPAU.log

/*------------------------------------------------------*/
/*	COPIA DE SEGURIDAD DE BASE DE DATOS TOTAL 	*/
/*------------------------------------------------------*/
expdp paulino/paulino@88.29.75.143/asir full=Y directory=backupsPAU dumpfile=paulino.dmp logfile=expdpcopiaPAU.log
impdp paulino/paulino@88.29.75.143/asir full=Y directory=backupsPAU dumpfile=paulino.dmp logfile=expdpcopiaPAU.log

/*-----------------------------------------------------------*/
/* COPIA DE SEGURIDAD DE BASE DE DATOS incluir/excluir datos */
/*-----------------------------------------------------------*/
expdp paulino/paulino@88.29.75.143/asir schemas=PAULINO include=TABLE:"IN ('MULTAS', 'PRUEBAS1')" directory=backupsPAU dumpfile=paulino.dmp logfile=expdpcopiaPAU.log
expdp paulino/paulino@88.29.75.143/asir schemas=PAULINO exclude=TABLE:"= 'MATRICULAS'" directory=backupsPAU dumpfile=paulino.dmp logfile=expdpcopiaPAU.log






/* ************************************************************************* */
/* ********************		NOTAS		**************************** */
/* ************************************************************************* */
/* EL ALMACENAMIENTO DE LOS LOGS ESTÁ POR DEFECTO EN LA CARPETA TEMPORALES DE CENTOS */

/* usando el sql DEVELOPER PODEMOS EJECUTAR (PERSONALIZANDO) LOS PARAMETROS DEL SIGUIENTE PROCEDIMIENTO */
/* EJEMPLO CON LA TABLA MATRICULAS 	*/
DECLARE
  l_REF		VARCHAR(20);
  l_MATRICULA	VARCHAR(10) ;
  l_IMPORTE	NUMBER;
  l_LUGAR	VARCHAR(30);
  l_ESTADO	KU$_STATUS;
BEGIN
  l_REF := DBMS_DATAPUMP.open(
    operation   => 'EXPORT',
    job_mode    => 'SCHEMA',
    remote_link => NULL,
    job_name    => 'MATRICULAS_EXPORT',
    version     => 'LATEST');

  DBMS_DATAPUMP.add_file(
    REF		=> l_REF,
    filename  	=> 'PAULINO.dmp',
    directory 	=> 'backupsPAU');

  DBMS_DATAPUMP.add_file(
    REF		=> l_dp_handle,
    filename  	=> 'PAUCHINO.log',
    directory 	=> 'backupsPAU',
    filetype  	=> DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE);

  DBMS_DATAPUMP.metadata_filter(
    REF		=> l_REF,
    name   	=> 'SCHEMA_EXPR',
    value  	=> '= ''PAULINO''');

  DBMS_DATAPUMP.start_job(l_REF);

  DBMS_DATAPUMP.detach(l_REF);
END;
/

