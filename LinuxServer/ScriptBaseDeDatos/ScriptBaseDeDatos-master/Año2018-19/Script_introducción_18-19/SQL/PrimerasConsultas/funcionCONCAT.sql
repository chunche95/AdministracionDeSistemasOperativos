select 'ESTA ES UNA CADENA' || 'esta es otra cadena ' from dual;

-- concatenación de x e y.
SELECT CONCAT('Esta es una cadena','otra cadena') from dual;
select concat(('uno','dos'), 'tres') from dual;

select concat(concat(first_name, ' '), last_name) employee_name, first_name ||  ' ' || last_name as employee_name_2
from employees 
where department_id=30;
