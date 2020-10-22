select LOWER('Hola Mundo') from dual;

select LOWER(30 + 50) from dual;

select LOWER('lA SUMA ' || '10 + 21 ' || '=' || '20') 
from dual;

select lower(first_name, last_name)
from employees
where lower(last_name) LIKE '%ur%';