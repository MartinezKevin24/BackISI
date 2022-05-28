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
    telefono         char(20)     not null,
    foto_perfil      varchar(200) null,
    primary key (id, email)
);

create table if not exists servicios
(
    id                    int auto_increment
        primary key,
    fecha_asignacion      datetime                        not null,
    direccion             text                            not null,
    fecha_programada      datetime                        not null,
    horas                 int                             not null,
    total                 bigint                          not null,
    cliente_id            char(20)                        not null,
    trabajador_id         char(20)                        not null,
    estado_solicitud      varchar(20) default 'pendiente' not null,
    estado_servicio       bit         default b'0'        null,
    puntuacion_cliente    float       default 0           null,
    puntuacion_trabajador float       default 0           null,
    descripcion_servicio  text                            null,
    foreign key (cliente_id) references clientes (id),
    foreign key (trabajador_id) references trabajadores (id)
);

create index if not exists FK_109
    on servicios (cliente_id);

create index if not exists trabajador_id
    on servicios (trabajador_id);

INSERT INTO cameya.clientes (id, email, tipo_documento, nombres, apellidos, telefono, fecha_nacimiento, password, foto_perfil) VALUES ('123456', 'multirecplay@gmail.com', 'CC', 'Pedro', 'Perez', '3167489874', '2022-04-14', '$2a$10$pFu9OYHi99DuFzpqthRB7ODdNglH6VAxx3hHxLpchVsKct9rbkKtC', 'https://res.cloudinary.com/aarnedoe/image/upload/v1653173445/gs86vxyjq6y5xwyb1aoa.png');
INSERT INTO cameya.clientes (id, email, tipo_documento, nombres, apellidos, telefono, fecha_nacimiento, password, foto_perfil) VALUES ('0222010021', 'chicogel@gmail.com', 'CC', 'Chico', 'Gel', '3163673501', '1999-05-22', '$2a$10$FDnRFntO.zmNFA3kTky3kOaSpKNTWQrV2nMUms4zpPJAd114VYYPi', 'https://res.cloudinary.com/aarnedoe/image/upload/v1653281369/su4pqb5g09ekya5ynokm.jpg');

INSERT INTO cameya.trabajadores (id, email, tipo_documento, nombres, apellidos, fecha_nacimiento, password, tipo_servicio, detalle_servicio, tarifa_hora, telefono, foto_perfil) VALUES ('0222010020', 'jaimenavarro1@gmail.com', 'CC', 'Chico', 'Gel', '1999-12-31', '$2a$10$hpsX5MVNYXTF98fsEFxVdOZ8sNk6UuzzyoJK2qNLzccPaPEF8bNwm', 'Arte', 'Arte Furro', 90000, '3167489874', 'https://res.cloudinary.com/aarnedoe/image/upload/v1653191579/xoy37ondpjfimebnqvlq.jpg');
INSERT INTO cameya.trabajadores (id, email, tipo_documento, nombres, apellidos, fecha_nacimiento, password, tipo_servicio, detalle_servicio, tarifa_hora, telefono, foto_perfil) VALUES ('1041972363', 'jaimenavarro@gmail.com', 'CC', 'Jaime', 'Nvarro', '2000-10-10', '$2a$10$ZZX2nfhjlDzryNuHrX6fzOyHMzjZOudmMuoAOwNTtMtVjmNfPZfPK', 'Culinario', 'Cocinero de comida mediterranea', 3000, '3043582857', null);
INSERT INTO cameya.trabajadores (id, email, tipo_documento, nombres, apellidos, fecha_nacimiento, password, tipo_servicio, detalle_servicio, tarifa_hora, telefono, foto_perfil) VALUES ('1143413517', 'kmartinez0624@gmail.com', 'CC', 'Kevin', 'Martinez', '2000-09-20', '$2a$10$f7Qwfwm1pYswyex4PsUxkOrzMh//Kh6wXaJANP.54SMSIbSeSV/5u', 'Arte', 'Pintar casas', 20000, '3174998447', null);

INSERT INTO cameya.servicios (id, fecha_asignacion, direccion, fecha_programada, horas, total, cliente_id, trabajador_id, estado_solicitud, estado_servicio, puntuacion_cliente, puntuacion_trabajador) VALUES (9, '2000-10-01 01:01:01', 'carrea 24', '2022-04-11 18:30:00', 3, 35000, '123456', '0222010020', 'pendiente', true, 0, 0);
