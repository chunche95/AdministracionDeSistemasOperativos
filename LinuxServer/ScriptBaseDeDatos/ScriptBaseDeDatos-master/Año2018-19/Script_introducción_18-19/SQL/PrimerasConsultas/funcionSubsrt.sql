select SUBSTR('1#3#5#7#9', 5 ) from dual;

select substr ('1#3#5#7#9', 2, 6 ) from dual;

select ' Nombre: ' || SUBSTR(first_name, 1,1)
    || '. ' || last_name "Nombre"
from employees
where subsrt(job_id, 1, 2) = 'AD';

select instr('HOLA MUNDO', 'MU') form dual;

select sysdate, instr(sysdate, '15') from dual;

select instr (('1#3#5#7#9', '#', 3, 4 ) from dual;)


select * from departments
where INSTR(department_name, 'on') = 2;
