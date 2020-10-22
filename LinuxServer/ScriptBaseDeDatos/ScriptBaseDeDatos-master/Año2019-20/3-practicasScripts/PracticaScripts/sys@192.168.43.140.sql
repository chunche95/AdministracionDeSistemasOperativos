select * from dba_users
where lower(username)=lower('usuario'); 

drop user usuario cascade;

create table DF(
hora varchar(40),
sistema varchar(40),
tamano varchar(40),
usado varchar(40),
montado varchar(40)
);

select * from df;