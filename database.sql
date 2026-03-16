CREATE DATABASE app_inventario;

use app_inventario;

create table usuario(
id int primary key auto_increment,
nombre varchar(50) not null,
correo varchar(100) not null unique,
password varchar(100) not null

);


create table productos(
idproducto int auto_increment primary key,
nombre varchar(100) not null,
descripcion text,
precio decimal(10,2) not null,
stock int not null,
usuario_id int not null,
foreign key (usuario_id) references usuario(id)

);