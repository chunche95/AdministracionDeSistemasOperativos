select sysdate from dual;

select sysdate, add_months(sysdate, -1) anterior,
    add_months (sysdate, 12) siguiente
from dual;

-- cantidad de meses existentes entre fechas
select months_between('12/09/10', '31/12/10') f1,
        round(months_between('12/09/10', '31/12/10'),1) f2,
        round(months_between('12/09/10', '31/12/10'),1) f3,
        months_between('12/09/10', '31/12/10') f4
from dual;

select sysdate 
    last_day(sysdate) findemes,
    last_day(sysdate) +1 siguiente
from dual;

-- round and truncate
select sysdate, round(sysdate, 'HH24') ROUND_HOUR,
        round(sysdate) round_date, round(sysdate, 'MM') new_month,
        round(sysdate, 'YY') new_year
from dual;

select sysdate, trunc(sysdate, 'HH24') TRUNC_HOUR,
        trunc(sysdate) round_date, round(sysdate, 'MM') new_month,
        trunc(sysdate, 'YY') new_year
from dual;

