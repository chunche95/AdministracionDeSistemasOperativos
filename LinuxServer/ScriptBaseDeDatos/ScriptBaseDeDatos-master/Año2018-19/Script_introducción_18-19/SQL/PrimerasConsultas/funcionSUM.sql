select sum(salary) from employees;

/* Sumamos 2 por cada empleado */
select sum(2) from employees;

select sum(distinct salary) from employees;

select sum(commission_pct) from employees;


select round(sum(sysdate - hire_date)/365.25, 2) "Total de años trabajados"
from employees;
