-- letura no repetible --> Hasta que no se confirman los datos no se ven los cambios
CREATE TABLE TABLA (NUMERO NUMBER(2), TEXTO VARCHAR(10));
INSERT INTO TABLA VALUES (1,'NOMBRE');
SELECT * FROM TABLA;
COMMIT;

-- lectura fila fantasma --> ve mas informacion en el segundo select
set transaction isolation level  read committed;
select * from tabla;
ROLLBACK;
-- Lectura no repetible evitada --> No ve los cambios aunque se confirmen
set transaction isolation level serializable;
select * from tabla;
rollback;
/* No veo los cambios del 44 aunque se hayan confirmado */


-- BLOQUEOS NO AUTOMATICOS 
--lock table ***** in exclusive mode [nowait];
-- NOTA: Si ponemos un bloqueo con la opcion NOWAIT, Oracle desbloquea la tabla si alguien la necesita.
lock table tabla in exclusive mode;
select * from tabla;
update tabla set numero=2;
commit;

