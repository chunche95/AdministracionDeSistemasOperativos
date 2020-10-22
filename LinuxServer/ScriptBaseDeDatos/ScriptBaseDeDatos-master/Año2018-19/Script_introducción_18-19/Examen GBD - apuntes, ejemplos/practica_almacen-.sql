--Ejercicio1--Creacion de tablas
create table productos(
	idproducto varchar (10),
	nombreproducto varchar (50),
	stock number default 0,
	primary key (idproducto)
	
	);

create table entradaproductos(
	idproducto varchar (10),
	cantidadentrada number,
	preciounidadentrada number,
	fechaentrada timestamp,
	primary key (fechaentrada, idproducto),
	foreign key (idproducto) references productos(idproducto)
		
	);


create table salidaproductos(
	fechasalida timestamp,
	idproducto varchar(5),
	cantidadsalida number,
	preciounidadsalida varchar(10),
	primary key (fechasalida,idproducto),
	foreign key (idproducto) references productos(idproducto)
	
	);

create sequence contador;

--Ejercicio2

create  or replace procedure CREAR_PRODUCTO(
	procnombreproducto in varchar, 
	procidproducto OUT number
)
as
	nuevoid number;
begin
  nuevoid := contador.nextval;
  procidproducto := nuevoid;
  insert into
    productos(nombreproducto,idproducto)
  values
    (procnombreproducto,procidproducto);
end;
/



create  or replace view V_PRODUCTOS(nombreproducto,idproducto)
as 
 select 
    nombreproducto,
    idproducto 
 from 
    productos;



create or replace function existeproductos(
    producto number
)
return number
as
    cantidad number;
begin
    select count(*)
    into cantidad
    from productos
    where producto = idproducto;
    
    if(cantidad = 0) then
        return 0;
    else
        return 1;
    end if;
end;
/

 --Ejercicio3

create or replace procedure ENTRADA_PRODUCTO(
  id_producto IN number,
  cantidad IN number,
  preciopagado IN number,
  fecha IN timestamp default systimestamp)
as
    existe number;
begin

	if ( existeproductos(id_producto) = 0) then
		raise_application_error(-20102,'El producto no existe.');
	end if;
  insert into
   entradaproductos (idproducto,cantidadentrada, preciounidadentrada,fechaentrada) 

  	values
	(id_producto,cantidad, preciopagado,fecha);
    
    if( fecha > systimestamp) then
    raise_application_error(-20103,'La fecha no es válida' || fecha );
    end if;
    
    update productos
    set stock =stock + cantidad
    where idproducto=id_producto;
end;
/



create or replace procedure SALIDA_PRODUCTO(
    id_producto in number,
    cantidad in number,
    preciocobrado in number,
    fecha in timestamp default systimestamp)
as
    existe number;
begin
	if ( existeproductos(id_producto) = 0) then
		raise_application_error(-20102,'El producto no existe.');
	end if;
    insert into
    salidaproductos (idproducto,cantidadsalida, preciounidadsalida,fechasalida) 
  	values
	(id_producto,cantidad, preciocobrado,fecha);
    if( fecha > systimestamp) then
         raise_application_error(-20103,'Fecha inválida:' || fecha );
    end if;

	update productos
	set stock = stock - cantidad 
	where idproducto = id_producto;
    
end;
/


create or replace function EXISTENCIAS_PRODUCTO(
  pidproducto IN number)
return number
as
  cantidadentrada number;
  cantidadsalida number;
begin
  if( existeproductos(pidproducto) = 0 ) then
   return -1;
  end if;

  select 
  	nvl(sum(cantidadentrada),0)
  into
  	cantidadentrada
  from
    entradaproductos
  where  
  	idproducto = pidproducto;

  select
  	nvl(sum(cantidadsalida),0)
  into 
  	cantidadsalida
  from 
  	salidaproductos
  where
    idproducto = pidproducto;

  return cantidadentrada-cantidadsalida;
end;
/


create or replace function ultimoPrecioCompra(pidproducto number) return number
as
  n number;
  retprecio number;
begin
  select count(*)
  into n
  from entradaproductos
  where idproducto=pidproducto;
  if( n =0 ) then
    return null;
  end if;

  select 
  	preciounidadentrada
  into 
  	retprecio
  from 
  	entradaproductos en
  where
    pidproducto = en.idproducto and
    fechaentrada = (select
    					max(fechaentrada)
    				from 
    					entradaproductos
    				where 
    					idproducto=en.idproducto);
  return retprecio;
end;
/


create or replace function ultimoPrecioVenta(pidproducto number) return number
as
  n number;
  retprecio number;
begin
  select 
  	count(*)
  into
  	n
  from
  	salidaproductos
  where 
  	idproducto=pidproducto;

  if( n = 0 ) then
    return null;
  end if;

  select
  	preciounidadsalida
  into
  	retprecio
  from 
  	salidaproductos sa
  where
    pidproducto = sa.idproducto and
    fechasalida = (select
    					max(fechasalida) 
    				from 
    					salidaproductos 
    				where 
    					idproducto=sa.idproducto);
  return retprecio;
end;
/


--Ejercicio4

create or replace view V_EXISTENCIAS (idproducto,existencias,ultimopreciocompra,
ultimoprecioventa) 
as
select
  p.idproducto,
  existencias_producto(p.idproducto),
  ultimoPrecioCompra(p.idproducto),
  ultimoPrecioVenta(p.idproducto)
from
  productos p
  ;

--Ejercicio5
create or replace procedure SALIDA_PRODUCTO_CON_STOCK(
  idproducto IN number,
  cantidad IN number,
  preciocobrado IN number
)
as
begin
  if( existencias_producto(idproducto) < cantidad ) then
    RAISE_APPLICATION_ERROR(-20101,' Rotura de stock del producto ' || idproducto );
  end if;
  salida_producto(idproducto,cantidad,preciocobrado,systimestamp);
end;
/
