--rellenos left or right contents

select LPAD('cadena', 10 ), RPAD('ORACION', 10 ) FROM dual;

select LPAD('AAA', 5, '*'), RPAD(123, 5, '*') from dual;

select LPAD(last_name, 10) lpad_name, 
    LPAD(salary, 8, '*') lpad_salary
from employees
where last_name LIKE 'J%';

/* RESULTADO
     +-------------------------+
     |LPAD_NAME  | LPAD_SALARY |
     |-------------------------|
    1|       Juan| *******3200 |
    2|       José| *******5500 |
     +-------------------------+
*/
