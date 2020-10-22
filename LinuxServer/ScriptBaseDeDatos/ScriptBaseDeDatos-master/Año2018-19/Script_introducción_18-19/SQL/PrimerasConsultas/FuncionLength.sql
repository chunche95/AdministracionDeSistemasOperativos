select LENGTH('funcion que cuenta la longitud de la cadena') from dual;

select LENGTH('1 + 2 = ' || 3) from dual;

select LENGTH(sysdate) from dual;


select * from countries
where LENGTH(country_name) >= 10;

select * from countries
where LENGTH(country_name) <= 10;