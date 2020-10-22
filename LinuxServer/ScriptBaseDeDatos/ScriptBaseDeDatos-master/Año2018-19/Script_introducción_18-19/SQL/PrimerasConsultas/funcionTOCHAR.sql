select to_char(10) from dual;
select to_char(0000002, '099999') from dual;
select job_title, max_salary, to_char(max_salary, '$99,999.99'),
    to_char(max_salary, '$99,999.99')
from jobs
where UPPER(job_title) LIKE '%PRESIDENT%';

SELECT TO_CHAR(SYSDATE, 'Day Ddspth, Month YYYY', 'nls_date_language=French') from dual;