select REPLACE('downtown', 'down', 'up') from dual;
/*                 ^         ^       ^
 *                 |         |       |
 *             Buscamos Coincidencia  Sustituimos
 *              esto                  down por up
 */


 select last_name, salary replace(salary, '0', '000') "Salario deseado"
 from employees
where job_id = 'SA_MAN';
