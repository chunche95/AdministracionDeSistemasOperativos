-- Funcion para calcular promedios
-- AVG([Distinct|All] expression)

select AVG(5) from employees;

select AVG(salary) from employees;

select TRUNC(AVG(salary)) from employees;

select AVG(DISTINCT salary) from employees;

select TRUNC(AVG(DISTINCT salary), 1) from employees;

select AVG(COMMISSION_PCT) from employees;

SELECT last_name, job_id, (sysdate - hire_date) / 365.25 "Años trabajados"
from employees
where job_id = 'IT_PROG';


SELECT ROUND(AVG((sysdate - hire_date) / 365.25),1) "Años trabajados"
from employees
where job_id = 'IT_PROG';