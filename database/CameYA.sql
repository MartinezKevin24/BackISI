-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.22-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para cameya
CREATE DATABASE IF NOT EXISTS `cameya` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `cameya`;

-- Volcando estructura para tabla cameya.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` char(20) NOT NULL,
  `email` char(45) NOT NULL,
  `tipo_documento` char(20) NOT NULL,
  `nombres` char(45) NOT NULL,
  `apellidos` char(45) NOT NULL,
  `telefono` char(20) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `password` char(60) NOT NULL,
  `puntuacion` float DEFAULT NULL,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cameya.clientes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
REPLACE INTO `clientes` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `telefono`, `fecha_nacimiento`, `password`, `puntuacion`) VALUES
	('123456', 'multirecplay@gmail.com', 'CC', 'Pedro', 'Perez', '3127499843', '2022-04-14', '$2a$10$t/3S9Z1JqwYNiYGq2EshiO.4.13DtacfDpv9wn/rMR7zeb/t4SwPO', NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla cameya.servicios
CREATE TABLE IF NOT EXISTS `servicios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_asignacion` datetime NOT NULL,
  `direccion` text NOT NULL,
  `fecha_programada` datetime NOT NULL,
  `horas` int(11) NOT NULL,
  `total` bigint(20) NOT NULL,
  `estado` char(20) NOT NULL,
  `cliente_id` char(20) NOT NULL,
  `trabajador_id` char(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_109` (`cliente_id`),
  KEY `FK_servicios_trabajadores` (`trabajador_id`),
  CONSTRAINT `FK_servicios_clientes` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_servicios_trabajadores` FOREIGN KEY (`trabajador_id`) REFERENCES `trabajadores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cameya.servicios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
REPLACE INTO `servicios` (`id`, `fecha_asignacion`, `direccion`, `fecha_programada`, `horas`, `total`, `estado`, `cliente_id`, `trabajador_id`) VALUES
	(9, '0000-00-00 00:00:00', 'carrea 24', '2022-04-11 18:30:00', 3, 35000, 'false', '123456', '1143413517');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;

-- Volcando estructura para tabla cameya.trabajadores
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
  `puntuacion` float DEFAULT NULL,
  `telefono` char(20) NOT NULL,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cameya.trabajadores: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `trabajadores` DISABLE KEYS */;
REPLACE INTO `trabajadores` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `fecha_nacimiento`, `password`, `tipo_servicio`, `detalle_servicio`, `tarifa_hora`, `puntuacion`, `telefono`) VALUES
	('1041972363', 'jaimenavarro@gmail.com', 'CC', 'Jaime', 'Nvarro', '0000-00-00', '$2a$10$ZZX2nfhjlDzryNuHrX6fzOyHMzjZOudmMuoAOwNTtMtVjmNfPZfPK', 'Culinario', 'Cocinero de comida mediterranea', 3000, NULL, '3043582857'),
	('1143413517', 'kmartinez0624@gmail.com', 'CC', 'Kevin', 'Martinez', '0000-00-00', '$2a$10$f7Qwfwm1pYswyex4PsUxkOrzMh//Kh6wXaJANP.54SMSIbSeSV/5u', 'Arte', 'Pintar casas', 20000, NULL, '3174998447');
/*!40000 ALTER TABLE `trabajadores` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
