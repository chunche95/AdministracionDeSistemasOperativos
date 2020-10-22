SELECT * FROM CARRERAS;
CREATE TABLE test (uno INTEGER, dos VARCHAR2(10));



/* Ahora vamos a insertar algunos registros de prueba y ejecutamos commit.*/

 INSERT INTO test VALUES(1,'AAAAAAAAAA');
 INSERT INTO test VALUES(2,'BBBBBBBBBB');
 INSERT INTO test VALUES(3,'CCCCCCCCCC');
 INSERT INTO test VALUES(4,'DDDDDDDDDD');
 INSERT INTO test VALUES(5,'EEEEEEEEEE');
 commit;


/* Identificamos nuestro SID con el cual estamos bloqueando la tabla.*/

select sys_context('USERENV','SID') SID from dual;

/* Colocamos un bloqueo exclusivo en la tabla.*/
LOCK TABLE test IN EXCLUSIVE MODE;

