-- lectura no repetible --> Hasta que no se confirman los datos no se ven los cambios
set transaction isolation level 
read committed;
SELECT * FROM TABLA;
UPDATE TABLA SET NUMERO=3 WHERE numero=2;
commit;

-- fila fantasma --> ve mas informacion en el segundo select
set transaction isolation level
read committed;

insert into tabla values(2 ,'apellido');
insert into tabla values(2 ,'apellido');
insert into tabla values(2 ,'apellido');
commit;

UPDATE TABLA SET NUMERO=3 WHERE numero=2;
commit;

-- Lectura no repetible --> No se ven los cambios aunque se confirmen

UPDATE TABLA SET NUMERO=44 WHERE texto='NOMBRE';
commit;
select * from tabla;


-- BLOQUEOS NO AUTOMATICOS
-- LOCK TABLE ***** IN EXCLUSIVE MODE;
LOCK TABLE tabla IN EXCLUSIVE MODE;
SELECT * FROM TABLA;
UPDATE TABLA SET TEXTO='PAPARUCHAS' WHERE NUMERO=2;
ROLLBACK;