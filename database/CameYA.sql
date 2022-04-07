-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.24-MariaDB - mariadb.org binary distribution
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
  `fecha_nacimiento` datetime DEFAULT NULL,
  `password` char(60) NOT NULL,
  `puntuacion` float DEFAULT NULL,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cameya.clientes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla cameya.servicios
CREATE TABLE IF NOT EXISTS `servicios` (
  `id` char(20) NOT NULL,
  `fecha_asignacion` datetime NOT NULL,
  `direccion` text NOT NULL,
  `fecha_programada` datetime NOT NULL,
  `horas` int(11) NOT NULL,
  `total` bigint(20) NOT NULL,
  `estado` char(20) NOT NULL,
  `cliente_id` char(20) NOT NULL,
  `cliente_email` char(45) NOT NULL,
  `trabajador_id` char(20) NOT NULL,
  `trabajador_email` char(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_109` (`cliente_id`,`cliente_email`),
  KEY `FK_117` (`trabajador_id`,`trabajador_email`),
  CONSTRAINT `FK_106` FOREIGN KEY (`cliente_id`, `cliente_email`) REFERENCES `clientes` (`id`, `email`),
  CONSTRAINT `FK_114` FOREIGN KEY (`trabajador_id`, `trabajador_email`) REFERENCES `trabajadores` (`id`, `email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla cameya.servicios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;

-- Volcando estructura para tabla cameya.trabajadores
CREATE TABLE IF NOT EXISTS `trabajadores` (
  `id` char(20) NOT NULL,
  `email` char(45) NOT NULL,
  `tipo_documento` char(20) NOT NULL,
  `nombres` char(45) NOT NULL,
  `apellidos` char(45) NOT NULL,
  `fecha_nacimiento` datetime DEFAULT NULL,
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
INSERT INTO `trabajadores` (`id`, `email`, `tipo_documento`, `nombres`, `apellidos`, `fecha_nacimiento`, `password`, `tipo_servicio`, `detalle_servicio`, `tarifa_hora`, `puntuacion`, `telefono`) VALUES
	('1041972363', 'jaimenavarro@gmail.com', 'CC', 'Jaime', 'Nvarro', '0000-00-00 00:00:00', '$2a$10$ZZX2nfhjlDzryNuHrX6fzOyHMzjZOudmMuoAOwNTtMtVjmNfPZfPK', 'null', NULL, NULL, NULL, '3043582857'),
	('1143413517', 'kmartinez0624@gmail.com', 'CC', 'Kevin', 'Martinez', '0000-00-00 00:00:00', '$2a$10$f7Qwfwm1pYswyex4PsUxkOrzMh//Kh6wXaJANP.54SMSIbSeSV/5u', 'null', NULL, NULL, NULL, '3174998447');
/*!40000 ALTER TABLE `trabajadores` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
