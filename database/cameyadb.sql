/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `cameya` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `cameya`;

CREATE TABLE IF NOT EXISTS `clientes` (
  `id` char(20) NOT NULL,
  `email` char(45) NOT NULL,
  `tipo_documento` char(20) NOT NULL,
  `nombres` char(45) NOT NULL,
  `apellidos` char(45) NOT NULL,
  `telefono` char(20) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `password` char(60) NOT NULL,
  `foto_perfil` varchar(200) DEFAULT NULL,
  puntuacion       float        null,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `telefono`, `fecha_nacimiento`, `password`, `foto_perfil`) VALUES
	('0222010021', 'chicogel@gmail.com', 'CC', 'Chico', 'Gel', '3163673501', '1999-05-22', '$2a$10$FDnRFntO.zmNFA3kTky3kOaSpKNTWQrV2nMUms4zpPJAd114VYYPi', 'https://res.cloudinary.com/aarnedoe/image/upload/v1653281369/su4pqb5g09ekya5ynokm.jpg'),
	('1041972355', 'clienteprueba2@hotmail.com', 'CC', 'Cliente', 'Dos', '3043582829', '2000-06-17', '$2a$10$ARtF5Sdnuch7FxzO.rkUau7yZTCBueabivIrA5iOIwWKRZidh0/hu', NULL),
	('1041972363', 'jaimeurbina@hotmail.com', 'CC', 'Jaime', 'Urbina', '3043582857', '2000-01-01', '$2a$10$QfR3kXwhWvTCOsBevNw13Ow7M0SntziLqRJJsM3wbxaq35UBlNijO', NULL),
	('1041972368', 'clienteprueba1@hotmail.com', 'CC', 'Cliente', 'Uno', '3043582822', '2000-06-11', '$2a$10$6./3Gpv33A3GUQ.umEB2neLp60k8.N9W1tRfB5GAP3.thzkQnv7sC', NULL),
	('123456', 'multirecplay@gmail.com', 'CC', 'Pedro', 'Perez', '3167489874', '2022-04-14', '$2a$10$pFu9OYHi99DuFzpqthRB7ODdNglH6VAxx3hHxLpchVsKct9rbkKtC', 'https://res.cloudinary.com/aarnedoe/image/upload/v1653173445/gs86vxyjq6y5xwyb1aoa.png');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `servicios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_asignacion` datetime NOT NULL,
  `direccion` text NOT NULL,
  `fecha_programada` datetime NOT NULL,
  `horas` int(11) NOT NULL,
  `total` bigint(20) NOT NULL,
  `cliente_id` char(20) NOT NULL,
  `trabajador_id` char(20) NOT NULL,
  `estado_solicitud` varchar(20) NOT NULL DEFAULT 'pendiente',
  `estado_servicio` bit(1) DEFAULT b'0',
  `puntuacion_cliente` float DEFAULT 0,
  `puntuacion_trabajador` float DEFAULT 0,
  `descripcion_servicio` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trabajador_id` (`trabajador_id`),
  KEY `FK_109` (`cliente_id`),
  CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `servicios_ibfk_2` FOREIGN KEY (`trabajador_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` (`id`, `fecha_asignacion`, `direccion`, `fecha_programada`, `horas`, `total`, `cliente_id`, `trabajador_id`, `estado_solicitud`, `estado_servicio`, `puntuacion_cliente`, `puntuacion_trabajador`, `descripcion_servicio`) VALUES
	(9, '2000-10-01 01:01:01', 'carrea 24', '2022-04-11 18:30:00', 3, 35000, '123456', '0222010020', 'pendiente', b'1', 0, 0, NULL),
	(10, '2022-06-06 22:54:44', 'Piedra Bolivar', '2022-06-06 22:56:00', 2, 180000, '1041972363', '0222010020', 'pendiente', b'0', 0, 0, 'Arte Furro'),
	(11, '2022-06-06 23:00:50', 'San José De Los Campanos Carrera 103A 39', '2022-06-06 23:02:00', 10, 200000, '1041972363', '1041972362', 'aceptado', b'0', 0, 0, '¿Qué comiste  #!"#! de mago?');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `trabajadores` (
  `id` char(20) NOT NULL,
  `email` char(45) NOT NULL,
  `tipo_documento` char(20) NOT NULL,
  `nombres` char(45) NOT NULL,
  `apellidos` char(45) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `password` char(60) NOT NULL,
  `tipo_servicio` char(50) DEFAULT NULL,
  `detalle_servicio` char(50) DEFAULT NULL,
  `tarifa_hora` double DEFAULT NULL,
  `telefono` char(20) NOT NULL,
  `foto_perfil` varchar(200) DEFAULT NULL,
  puntuacion       float        null,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `trabajadores` DISABLE KEYS */;
INSERT INTO `trabajadores` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `fecha_nacimiento`, `password`, `tipo_servicio`, `detalle_servicio`, `tarifa_hora`, `telefono`, `foto_perfil`) VALUES
	('0222010020', 'jaimenavarro1@gmail.com', 'CC', 'Chico', 'Gel', '1999-12-31', '$2a$10$hpsX5MVNYXTF98fsEFxVdOZ8sNk6UuzzyoJK2qNLzccPaPEF8bNwm', 'Arte', 'Arte Furro', 90000, '3167489874', 'https://res.cloudinary.com/aarnedoe/image/upload/v1653191579/xoy37ondpjfimebnqvlq.jpg'),
	('1041972362', 'jaimenavarrouwu06@gmail.com', 'CC', 'Icho', 'Y sus dichos', '2000-06-11', '$2a$10$Q8n5WLSKsdNQJVkrBBHtkuDw3s/T3jQO6abBgPfyUdCRC/XVtVDkG', '', '¿Qué comiste  #!"#! de mago?', 20000, '3043582859', NULL),
	('1041972363', 'jaimenavarro@gmail.com', 'CC', 'Jaime', 'Nvarro', '2000-10-10', '$2a$10$ZZX2nfhjlDzryNuHrX6fzOyHMzjZOudmMuoAOwNTtMtVjmNfPZfPK', 'Culinario', 'Cocinero de comida mediterranea', 3000, '3043582857', NULL),
	('1041972654', 'trabajadorprueba1@hotmail.com', 'CC', 'Trabajador', 'Uno', '2000-06-20', '$2a$10$lb/qIwVbBDWzIQZJls/QjO3hHdE6FM8PV2zkQXmlHXkRAY3gRVvvC', '', 'Dibujo', 8000, '3043582978', NULL),
	('1041972853', 'trabajadorprueba2@hotmail.com', 'CC', 'Trabajador', 'Dos', '2000-06-10', '$2a$10$OtUtbw.sLtM7eix0MgNtvevsXk4Kz1gvE127lbuUYDHoHtHY1HwkC', 'Culinario', 'Comidas rapidas', 9000, '3043582886', NULL),
	('1143413517', 'kmartinez0624@gmail.com', 'CC', 'Kevin', 'Martinez', '2000-09-20', '$2a$10$f7Qwfwm1pYswyex4PsUxkOrzMh//Kh6wXaJANP.54SMSIbSeSV/5u', 'Arte', 'Pintar casas', 20000, '3174998447', NULL);
/*!40000 ALTER TABLE `trabajadores` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
