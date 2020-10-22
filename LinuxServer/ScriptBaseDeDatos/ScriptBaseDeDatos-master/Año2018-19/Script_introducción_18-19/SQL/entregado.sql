-- Creo la tabla Productos -------------------
create table productos
(idproducto INTEGER,
nombreproducto VARCHAR(200),
cantidad INTEGER,
PRIMARY KEY (idproducto));

-- Creo la tabla Entrada_Producto -------------------
create table entrada
(fecha timestamp,
cantidad INTEGER,
preciopagado integer,
idproducto_fk INTEGER,
PRIMARY KEY (fecha),
FOREIGN KEY (idproducto_fk) REFERENCES productos (idproducto));


-- Creo la tabla Salida_Producto -------------------
create table salida
(fecha timestamp,
cantidad INTEGER,
preciocobrado integer,
idproducto_fk INTEGER,
PRIMARY KEY (fecha),
FOREIGN KEY (idproducto_fk) REFERENCES productos (idproducto));


-- Creo la secuencia SECUENCIA_PRODUCTO_ID

create sequence SECUENCIA_PRODUCTO_ID start with 1;


create or replace procedure CREAR_PRODUCTO (p_nombre_producto IN VARCHAR, p_id_producto OUT number)
as
begin
-- CONSIGUE EL NUEVO ID CON LA SECUENCIA CREADA
p_id_producto := (SECUENCIA_PRODUCTO_ID.nextval);
-- INSERTA EL PRODUCTO CON ESE ID
insert into productos (idproducto, nombreproducto, cantidad) values (p_id_producto, p_nombre_producto, 0);
-- DEVUELVO EL NUEVO ID EN idproducto
--dbms_output.put_line (id_producto);
end;
/

create  or replace view V_PRODUCTOS(nombreproducto,idproducto)as
select nombreproducto,idproducto from productos;
select * from V_PRODUCTOS;

create or replace procedure ENTRADA_PRODUCTO
(p_idproducto IN number, p_cantidad IN number, p_preciopagado IN NUMBER, p_fecha IN timestamp default systimestamp)
as
consulta_idproducto number;
begin
    select count (*) into consulta_idproducto from productos where idproducto=p_idproducto;
    if (consulta_idproducto = 0) then
        raise_application_error(-20102, 'El articulo no existe');
    elsif (p_fecha > systimestamp) then
        raise_application_error(-20103, 'La fecha no puede ser del FUTURO....');
    else
     insert into ENTRADA (idproducto_fk, fecha, cantidad, preciopagado) 
     values (p_idproducto, p_fecha, p_cantidad, p_preciopagado);
     update productos set cantidad=(cantidad + p_cantidad)
     where 
     idproducto=p_idproducto;
    end if;
end;
/



create or replace procedure SALIDA_PRODUCTO
(p_idproducto IN number, p_cantidad IN number, p_preciocobrado IN NUMBER, p_fecha IN timestamp default systimestamp)
as
consulta_idproducto number;
begin
    select count (*) into consulta_idproducto from productos where idproducto=p_idproducto;
    if (consulta_idproducto = 0) then
        raise_application_error(-20102, 'El articulo no existe');
    elsif (p_fecha > systimestamp) then
        raise_application_error(-20103, 'La fecha no puede ser del FUTURO....');
    else
     insert into SALIDA (idproducto_fk, fecha, cantidad, preciocobrado) 
     values (p_idproducto, p_fecha, p_cantidad, p_preciocobrado);
     update productos set cantidad=(cantidad - p_cantidad)
     where 
     idproducto=p_idproducto;
    end if;
end;
/


create or replace function EXISTENCIAS_PRODUCTO(p_idproducto IN number)
return number
as
stock number;
consulta_idproducto number;
BEGIN
    select count (*) into consulta_idproducto from productos where idproducto=p_idproducto;
    if (consulta_idproducto = 0) then
        stock := -1;
        return stock;
    else
        select cantidad into stock from productos where idproducto=p_idproducto;
        return stock;
    end if;
    
END;
/

create or replace procedure SALIDA_PRODUCTO_CON_STOCK(
p_idproducto IN number,
p_cantidad IN number,
p_preciocobrado IN number
)
as
p_fecha date default systimestamp;
consulta_idproducto number;
stock number;
begin
    select count (*) into consulta_idproducto from productos where idproducto=p_idproducto;
    SELECT EXISTENCIAS_PRODUCTO (p_idproducto) into stock FROM productos; 
    if (consulta_idproducto = 0) then
        raise_application_error(-20102, 'El articulo no existe');
    elsif (p_fecha > systimestamp) then
        raise_application_error(-20103, 'La fecha no puede ser del FUTURO....');
    elsif (stock < p_cantidad) then
        raise_application_error(-20101, 'ROTURA DE STOCK');
      
    else
     -- cambiar por SALIDA_PRODUCTO
     insert into SALIDA (idproducto_fk, fecha, cantidad, preciocobrado) 
     values (p_idproducto, p_fecha, p_cantidad, p_preciocobrado);
     update productos set cantidad=(cantidad - p_cantidad)
     where 
     idproducto=p_idproducto;
    end if;
end;
/

create or replace function PRECIO_ULTIMA_COMPRA (p_idproducto in number)
return number
as
f_max timestamp;
precio number;
begin
    select max(fecha) into f_max from entrada where p_idproducto = idproducto_fk;
    select preciopagado into precio from entrada where p_idproducto = idproducto_fk and fecha=f_max;
    return precio;
end;
/  

create or replace function PRECIO_ULTIMA_VENTA (p_idproducto in number)
return number
as
f_max timestamp;
precio number;
begin
    select max(fecha) into f_max from salida where p_idproducto = idproducto_fk;
    select preciocobrado into precio from salida where p_idproducto = idproducto_fk and fecha=f_max;
    return precio;
end;
/  

create or replace view V_EXISTENCIAS (idproducto, existencias, ultimopreciocompra, ultimoprecioventa)
as
select idproducto, EXISTENCIAS_PRODUCTO(idproducto), PRECIO_ULTIMA_COMPRA(idproducto), PRECIO_ULTIMA_VENTA(idproducto)
from productos group by idproducto;



select * from V_EXISTENCIAS