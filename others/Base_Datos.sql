drop  database tienda;
create database tienda;
use tienda;

create table clientes(

id int primary key auto_increment,
nombre_cliente text not null,
apellido text not null,
cedula int(10) not null,
telefono text not null,
correo text

);

create table productos (

idproducto int primary key auto_increment,
nombre_producto text not null,
precio double not null,
descripcion text not null,
estado_producto int(3) not null


);

create table ventas(

idventa int primary key auto_increment,
idp int not null,
foreign key (idp) references productos(idproducto),
cantidad int not null

);


create table devoluciones_cambio(

idback int primary key auto_increment,
idp_back int not null,
foreign key (idp_back) references productos(idproducto),
descripcionD text not null

);

create table stock_bodega(

idstock int primary key auto_increment,
idp_bodega int not null,
foreign key (idp_bodega) references productos(idproducto),
almacenado text
);

create table oferta(

idoferta int primary key auto_increment,
idofertaproduct int not null,
foreign key (idofertaproduct) references productos(idproducto),
ofertado text

);


drop TRIGGER  if exists add_codigos;   

DELIMITER |

CREATE TRIGGER add_codigos AFTER INSERT ON productos
  FOR EACH ROW BEGIN

    INSERT INTO ventas(idventa, idp , cantidad) values(null,new.idproducto,0);
    INSERT INTO oferta(idoferta,idofertaproduct,ofertado) values(null,new.idproducto,"No");
    INSERT INTO devoluciones_cambio(idback,idp_back ,descripcionD)values(null,new.idproducto,"");
    INSERT INTO stock_bodega(idstock,idp_bodega,almacenado)values(null,new.idproducto,"No");
   
  END
|

DELIMITER ; 


drop TRIGGER IF EXISTS mover_bodega;   

DELIMITER |

CREATE TRIGGER mover_bodega AFTER INSERT ON productos
  FOR EACH ROW BEGIN

       if (new.estado_producto = 500) then
        
           update stock_bodega set almacenado="Si" where idstock=new.idproducto;
               
        end if;       
   
  END
|

DELIMITER ; 

drop TRIGGER IF EXISTS mover_oferta;   

DELIMITER |

CREATE TRIGGER mover_oferta AFTER INSERT ON productos
  FOR EACH ROW BEGIN

       if (new.estado_producto = 300) then
        
           update oferta set ofertado="En oferta" where idofertaproduct=new.idproducto;
               
        end if;       
   
  END
|

DELIMITER ; 


insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Blusa",1237.99,"Exportado de colombia",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Zapatos",46290.13,"Cosechado en uraba colombia",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Deportiva",45279.66,"Triado del mar pacifico colombiano",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Casual",1000.3,"Para producir azucar doña Pastora",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Pantalon",2880.7,"Para la produccion de proteinas para el cerebro",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Gorra",280080.89,"Para la produccion de vive 100",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Medias",9500.2,"Para la produccion de mermelada",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Gorros",3255.9,"Para la produccion de bebidas para el desayuno",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Guantes",6000.29,"Para la produccion de vive 100",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Camisllas",18000.79,"Para la produccion harina para preparar pan",100);
insert into productos(idproducto , nombre_producto, precio ,descripcion, estado_producto)values(null,"Uniforme",500000.99,"Exportada de colombia",100);


insert into clientes (id,nombre_cliente,apellido,cedula,telefono,correo)values(null,"Romario","Solis",20200127,3113762,"@Aprendizaje");
insert into clientes (id,nombre_cliente,apellido,cedula,telefono,correo)values(null,"Lautharo","Martinez",1253600,3213762,"@InterMilan");
insert into clientes (id,nombre_cliente,apellido,cedula,telefono,correo)values(null,"Camila","Solis Valencia",483746,317390,"@Lokita");
insert into clientes (id,nombre_cliente,apellido,cedula,telefono,correo)values(null,"Coaraje","Marquez",452882009,31300762,"@Valiente");
insert into clientes (id,nombre_cliente,apellido,cedula,telefono,correo)values(null,"Acxel","White",33626,584030,"@Feliz");



select * from productos;
select * from clientes;
select * from stock_bodega;
select * from ventas;
select * from devoluciones_cambio;
select * from oferta;




drop function if exists devolucion_cambio;
delimiter //
create function devolucion_cambio(codigo  int ,descrip text)
returns varchar(50) 
begin
   
     declare m text;

     if (select idp_back from devoluciones_cambio where idp_back=codigo) then

           update productos set estado_producto = 400 where idproducto =codigo;
           update devoluciones_cambio set descripcionD = descrip where idp_back =codigo;
            set m = "Se genero el cambio o devolucion"; 

     else 
                 set m = "No se pudo generar la devolucion"; 
     end if; 

     return m;

end //

delimiter ;

select devolucion_cambio(2 ,"No cumple con las espectativas") as "Motivo";
select devolucion_cambio(7 ,"No cumple con las espectativas") as "Motivo";



drop function if exists ofertar;
delimiter //
create function ofertar(codigo  int)
returns varchar(50) 
begin
   
     declare m text;

     if (select idofertaproduct from oferta where idofertaproduct=codigo) then

           update productos set estado_producto = 300  where idproducto =codigo;
           update oferta set ofertado="En oferta"  where idofertaproduct =codigo;
            set m = "El producto se encuentra en oferta"; 

     else 
                 set m = "Siempre a la orden"; 
     end if; 

     return m;

end //

delimiter ;

select ofertar(2);



drop function if exists almacenar;
delimiter //
create function almacenar(codigo  int)
returns varchar(50) 
begin
   
     declare m text;

     if (select idp_bodega from stock_bodega where idp_bodega=codigo) then

           update productos set estado_producto = 500  where idproducto =codigo;
           update stock_bodega set almacenado="Si"  where idp_bodega =codigo;
            set m = "El producto se encuentra en la bodega"; 

     else 
                 set m = "Siempre a la orden"; 
     end if; 

     return m;

end //

delimiter ;

select almacenar(2);






drop procedure if exists Generar_ventas;
delimiter |
create procedure Generar_ventas(in codigoproducto int , in can int)
begin

    declare num int;

                  select estado_producto into num  from productos where idproducto = codigoproducto;

                        if(num!=500)then 

                          update ventas set cantidad= can  where idp = codigoproducto;
                          update productos set estado_producto= 200  where idproducto = codigoproducto;
                          select concat("Venta realizada!") as "200";
                        

                      else

                        select concat("El prouducto se encuentra en bodega") as "404";

                      end if;
end 
|

delimiter ;
call Generar_ventas(4,4);


drop procedure if exists ver_ventas;
delimiter |
create procedure ver_ventas()
begin
 
   select nombre_producto,cantidad ,(cantidad*precio) as 'total vendido'  from  productos join ventas where idproducto = idp and estado_producto=200;
    
end 
|

delimiter ;
call ver_producto();

drop procedure if exists ver_producto;
delimiter |
create procedure ver_producto()
begin
 
   select *  from  productos;
    
end 
|
delimiter ;
call ver_producto();


drop procedure if exists ver_ofertas;
delimiter |
create procedure  ver_ofertas()
begin
 
   select nombre_producto from oferta join productos where ofertado="En oferta" and  estado_producto=300 and idofertaproduct=idproducto;
    
end 
|
delimiter ;
call ver_ofertas();


drop procedure if exists ver_bodega;
delimiter |
create procedure  ver_bodega()
begin
 
   select nombre_producto from stock_bodega join productos where almacenado="Si" and  estado_producto=500;
    
end 
|
delimiter ;
call ver_bodega();

drop procedure if exists ver_devolucion;
delimiter |
create procedure ver_devolucion()
begin
 
   select nombre_producto,descripcionD from devoluciones_cambio join productos where idp_back=idproducto and estado_producto=400;
    
end 
|
delimiter ;
call ver_devolucion();




