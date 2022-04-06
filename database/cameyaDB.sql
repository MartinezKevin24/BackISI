-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for cameya
CREATE DATABASE IF NOT EXISTS `cameya` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `cameya`;

-- Dumping structure for table cameya.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` char(20) NOT NULL,
  `email` char(45) NOT NULL,
  `tipo_documento` char(20) NOT NULL,
  `nombres` char(45) NOT NULL,
  `apellidos` char(45) NOT NULL,
  `telefono` char(20) NOT NULL,
  `fecha_nacimiento` datetime NOT NULL,
  `password` char(60) NOT NULL,
  `puntuacion` float NOT NULL,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table cameya.servicios
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

-- Data exporting was unselected.

-- Dumping structure for table cameya.trabajadores
CREATE TABLE IF NOT EXISTS `trabajadores` (
  `id` char(20) NOT NULL,
  `email` char(45) NOT NULL,
  `tipo_documento` char(20) NOT NULL,
  `nombres` char(45) NOT NULL,
  `apellidos` char(45) NOT NULL,
  `fecha_nacimiento` datetime NOT NULL,
  `password` char(60) NOT NULL,
  `tipo_servicio` text NOT NULL,
  `tarifa_hora` double NOT NULL,
  `puntuacion` float NOT NULL,
  `telefono` char(20) NOT NULL,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
