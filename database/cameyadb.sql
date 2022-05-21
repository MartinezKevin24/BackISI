CREATE DATABASE IF NOT EXISTS `cameya`;
USE `cameya`;

create table if not exists clientes
(
    id               char(20)     not null,
    email            char(45)     not null,
    tipo_documento   char(20)     not null,
    nombres          char(45)     not null,
    apellidos        char(45)     not null,
    telefono         char(20)     not null,
    fecha_nacimiento date         null,
    password         char(60)     not null,
    puntuacion       float        null,
    foto_perfil      varchar(200) null,
    primary key (id, email)
);

create table if not exists trabajadores
(
    id               char(20)     not null,
    email            char(45)     not null,
    tipo_documento   char(20)     not null,
    nombres          char(45)     not null,
    apellidos        char(45)     not null,
    fecha_nacimiento date         null,
    password         char(60)     not null,
    tipo_servicio    char(50)     null,
    detalle_servicio char(50)     null,
    tarifa_hora      double       null,
    puntuacion       float        null,
    telefono         char(20)     not null,
    foto_perfil      varchar(200) null,
    primary key (id, email)
);

create table if not exists servicios
(
    id               int auto_increment
        primary key,
    fecha_asignacion datetime not null,
    direccion        text     not null,
    fecha_programada datetime not null,
    horas            int      not null,
    total            bigint   not null,
    estado           char(20) not null,
    cliente_id       char(20) not null,
    trabajador_id    char(20) not null,
    foreign key (cliente_id) references clientes (id),
    foreign key (trabajador_id) references trabajadores (id)
);

create index if not exists FK_109
    on servicios (cliente_id);

INSERT INTO `clientes` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `telefono`, `fecha_nacimiento`, `password`, `puntuacion`) VALUES
	('123456', 'multirecplay@gmail.com', 'CC', 'Pedro', 'Perez', '3127499843', '2022-04-14', '$2a$10$t/3S9Z1JqwYNiYGq2EshiO.4.13DtacfDpv9wn/rMR7zeb/t4SwPO', NULL);

INSERT INTO `trabajadores` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `fecha_nacimiento`, `password`, `tipo_servicio`, `detalle_servicio`, `tarifa_hora`, `puntuacion`, `telefono`) VALUES
	('1041972363', 'jaimenavarro@gmail.com', 'CC', 'Jaime', 'Nvarro', '2000-10-10', '$2a$10$ZZX2nfhjlDzryNuHrX6fzOyHMzjZOudmMuoAOwNTtMtVjmNfPZfPK', 'Culinario', 'Cocinero de comida mediterranea', 3000, NULL, '3043582857'),
	('1143413517', 'kmartinez0624@gmail.com', 'CC', 'Kevin', 'Martinez', '2000-09-20', '$2a$10$f7Qwfwm1pYswyex4PsUxkOrzMh//Kh6wXaJANP.54SMSIbSeSV/5u', 'Arte', 'Pintar casas', 20000, NULL, '3174998447');

INSERT INTO `servicios` (`id`, `fecha_asignacion`, `direccion`, `fecha_programada`, `horas`, `total`, `estado`, `cliente_id`, `trabajador_id`) VALUES
	(9, '2000-10-01 01:01:01', 'carrea 24', '2022-04-11 18:30:00', 3, 35000, 'false', '123456', '1143413517');


