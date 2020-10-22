alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

select TO_DATE('26-DEC-1999') from dual;

select TO_DATE('26-DEC', 'DD-MON') from dual;

select TO_DATE('26-DEC-1999 20:00:54', 'DD-MON-YYYY HH24:MI:SS') from dual;
