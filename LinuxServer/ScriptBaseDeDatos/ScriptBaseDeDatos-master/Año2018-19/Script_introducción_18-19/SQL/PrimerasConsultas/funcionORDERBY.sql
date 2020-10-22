select first_name, last_name, hire_date 
from employees
where hire_date > TO_DATE('02/12/2008' 'MM/DD/YYYY')
ORDER BY hire_date;