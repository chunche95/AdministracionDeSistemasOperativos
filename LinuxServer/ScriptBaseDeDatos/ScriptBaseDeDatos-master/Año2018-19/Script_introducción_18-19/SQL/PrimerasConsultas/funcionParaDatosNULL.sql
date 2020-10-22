select last_name, NVL(deparment_id, 0)
from employees
order by 2;

select first_name, salary, NVL(commission_pct,0), 
        salary + ( salary * NVL(commission_pct,0)) "Comisiones"
from employees
where first_name like 'T%';

-- Uso de NVL2

select first_name, salary, commission_pct, 
        NVL2(commission_pct, salary + salary * commission_pct, salary) "Comisiones"
from employees
where first_name like 'T%';

-- Uso de coalsce(lista)
select last_name, salary, commission_pct as comision
        coalesce(salary + salary * commission_pct, salary +100, 900) "Comisiones"
from employees
where last_name like 'T%';

