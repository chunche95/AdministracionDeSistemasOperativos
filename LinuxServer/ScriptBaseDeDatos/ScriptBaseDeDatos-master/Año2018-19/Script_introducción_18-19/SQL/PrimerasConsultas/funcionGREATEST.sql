SELECT GREATEST(
    '01-APR-09',
    '02-JAN-10',
    '21-DIC-18'
) FROM dual;


select last_name, salary, GREATEST(salary*0.15, 500) bono
from employees
where deparment_id in (30,10)
order by last_name;