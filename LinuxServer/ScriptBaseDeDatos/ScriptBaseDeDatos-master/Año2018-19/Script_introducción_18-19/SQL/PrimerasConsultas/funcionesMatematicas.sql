-- valor absoluto   => ABS(n)
select ABS(-53) negative, ABS(53) positive, ABS(0) zero from dual;

-- Arco coseno ACOS, arcoseno ASIN, arcotangente ATAN, coseno COS, seno SEN y tangente TAN.
select acos(-1), acos(0), acos(0.54) from dual;

-- CEIL (n) - Entero más pequeño

select CEIL(2.5), CEIL(-31.8), CEIL(0), CEIL(4) from dual;


-- exponencial
select exp(1) "e" from dual;

-- floor
select floor(2.5), floor(-30.2), floor(0), floor(4) from dual;

-- logaritmo neperiano 
select LN(1.7) from dual;

-- Potencias
select power(2,10), power(3,4), power(-3,5)
from dual;

-- SIGN
select sign(2.3), sign(0), sign(32) from dual;