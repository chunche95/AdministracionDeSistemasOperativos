select count(*)
from employees;


select count(commission_pct) 
from employees;

select count(all commission_pct) from employees;

select count(DISTINCT commission_pct) from employees;


SELECT COUNT(hire_date), count(manager_id) from employees;



select count(*), count(DISTINCT nvl(department_id,0)),
        count(DISTINCT NVL(job_id,0))
from employees;


select count(*) "Paises con A"
from countries 
where country_name like 'A%';
