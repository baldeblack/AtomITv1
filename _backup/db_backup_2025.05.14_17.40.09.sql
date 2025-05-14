-- -------------------------------------------
SET AUTOCOMMIT=0;
START TRANSACTION;
SET SQL_QUOTE_SHOW_CREATE = 1;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- -------------------------------------------
-- -------------------------------------------
-- START BACKUP
-- -------------------------------------------
-- -------------------------------------------
-- TABLE `accesorios`
-- -------------------------------------------
DROP TABLE IF EXISTS `accesorios`;
CREATE TABLE IF NOT EXISTS `accesorios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `authassignment`
-- -------------------------------------------
DROP TABLE IF EXISTS `authassignment`;
CREATE TABLE IF NOT EXISTS `authassignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`),
  CONSTRAINT `authassignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `authitem`
-- -------------------------------------------
DROP TABLE IF EXISTS `authitem`;
CREATE TABLE IF NOT EXISTS `authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `authitemchild`
-- -------------------------------------------
DROP TABLE IF EXISTS `authitemchild`;
CREATE TABLE IF NOT EXISTS `authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `authitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `authitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `barrio`
-- -------------------------------------------
DROP TABLE IF EXISTS `barrio`;
CREATE TABLE IF NOT EXISTS `barrio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CIUDAD` (`id_ciudad`),
  KEY `FK_DEPTO` (`id_departamento`),
  CONSTRAINT `fk_cuidad_barrio` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_depto_barrio` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `ciudad`
-- -------------------------------------------
DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE IF NOT EXISTS `ciudad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DEPTO` (`id_departamento`),
  CONSTRAINT `fk_depto_ciudad` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `clientes`
-- -------------------------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `rut` varchar(30) DEFAULT NULL,
  `razon_social` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `web` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `agencia` varchar(50) DEFAULT NULL,
  `nota` text,
  `id_departamento` int(11) NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  `id_barrio` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_BARRIO` (`id_barrio`),
  KEY `FK_CIUDAD` (`id_ciudad`),
  KEY `FK_DEPART` (`id_departamento`),
  CONSTRAINT `fk_barrio_cliente` FOREIGN KEY (`id_barrio`) REFERENCES `barrio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `contactos`
-- -------------------------------------------
DROP TABLE IF EXISTS `contactos`;
CREATE TABLE IF NOT EXISTS `contactos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CLIENTES` (`id_cliente`),
  CONSTRAINT `fk_clientes_contactos` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `departamento`
-- -------------------------------------------
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE IF NOT EXISTS `departamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `empresa`
-- -------------------------------------------
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(300) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `imagen` blob,
  `ruta` varchar(255) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `equipo_accesorio`
-- -------------------------------------------
DROP TABLE IF EXISTS `equipo_accesorio`;
CREATE TABLE IF NOT EXISTS `equipo_accesorio` (
  `id_equipo` int(11) NOT NULL,
  `id_accesorio` int(11) NOT NULL,
  PRIMARY KEY (`id_equipo`,`id_accesorio`),
  KEY `FK_EQUIPO` (`id_equipo`),
  KEY `FK_ACCESORIO` (`id_accesorio`),
  CONSTRAINT `fk_accesorio_equipo` FOREIGN KEY (`id_accesorio`) REFERENCES `accesorios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_equipo_accesorio` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `equipos`
-- -------------------------------------------
DROP TABLE IF EXISTS `equipos`;
CREATE TABLE IF NOT EXISTS `equipos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `nro_serie` varchar(50) DEFAULT NULL,
  `tipo` enum('PC','Notebook','Servidor','Switch','Cámara','DVR','Otros') DEFAULT NULL,
  `id_marca` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_marca` (`id_marca`),
  CONSTRAINT `fk_equipo_marca` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `historial`
-- -------------------------------------------
DROP TABLE IF EXISTS `historial`;
CREATE TABLE IF NOT EXISTS `historial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estilo` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8_spanish_ci DEFAULT NULL,
  `visto` tinyint(1) DEFAULT '0',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_historial` (`id_usuario`),
  CONSTRAINT `historial_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=945 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- -------------------------------------------
-- TABLE `marcas`
-- -------------------------------------------
DROP TABLE IF EXISTS `marcas`;
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `ordenes`
-- -------------------------------------------
DROP TABLE IF EXISTS `ordenes`;
CREATE TABLE IF NOT EXISTS `ordenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT NULL,
  `id_equipo` int(11) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `fecha_cierre` date DEFAULT NULL,
  `fecha_retiro` date DEFAULT NULL,
  `falla` text,
  `diagnostico` text,
  `solucion` text,
  `nota` text,
  `condicion` enum('Presupuesto','Garantia','Garantia Reparacion','Cliente abonado') DEFAULT NULL,
  `estado` enum('Ingresado','En Reparación','Reparado con Cargo','No Fallo','Reparado sin Cargo','Retiran sin Reparar','Plazo Vencido') DEFAULT NULL,
  `transporte` enum('(Ninguna)','Enviado','Entregado','Avisado') DEFAULT NULL,
  `finalizada` tinyint(4) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_EQUIPO` (`id_equipo`),
  KEY `FK_CLIENTE` (`id_cliente`),
  CONSTRAINT `fk_cliente_orden` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_orden` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1168 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `parametros`
-- -------------------------------------------
DROP TABLE IF EXISTS `parametros`;
CREATE TABLE IF NOT EXISTS `parametros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` enum('Imagen','Texto','Otros','') DEFAULT NULL,
  `nombre` varchar(10) DEFAULT NULL,
  `descripcion` text,
  `valor` varchar(255) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `presupuesto`
-- -------------------------------------------
DROP TABLE IF EXISTS `presupuesto`;
CREATE TABLE IF NOT EXISTS `presupuesto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_orden` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `usuarios`
-- -------------------------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT NULL,
  `nick` varchar(20) NOT NULL,
  `pass` varchar(125) NOT NULL,
  `pin` int(10) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `foto` blob,
  `estado` tinyint(1) NOT NULL,
  `sesion` varchar(255) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE DATA accesorios
-- -------------------------------------------
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('1','Cable de Corriente');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('2','Fuente de Poder');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('3','Mouse');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('4','Cable USB');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('5','Cable VGA');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('6','Antena');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('7','Modem USB');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('8','Ficha Adaptadora ');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('9','Protector');



-- -------------------------------------------
-- TABLE DATA authassignment
-- -------------------------------------------
INSERT INTO `authassignment` (`itemname`,`userid`,`bizrule`,`data`) VALUES
('admin','1','','N;');



-- -------------------------------------------
-- TABLE DATA authitem
-- -------------------------------------------
INSERT INTO `authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('admin','2','','','N;');
INSERT INTO `authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('super','2','','','N;');



-- -------------------------------------------
-- TABLE DATA barrio
-- -------------------------------------------
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('2','Nuevo Paris','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('3','Reducto','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('4','Centro','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('5','Paso de la Arena','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('6','Belvedere','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('7','Aires Puros','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('8','Prado','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('9','Ciudad Vieja','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('10','Los Aromos','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('11','Jardines del Hipodromo','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('12','Lezica','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('13','Cerro','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('14','Capurro','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('15','Parque Rodo','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('16','Pocitos','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('17','Malvin','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('18','Carrasco','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('19','Barrio Sur','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('20','Los Bulveres','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('21','Barra Santa Lucia','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('22','La Paz','2','2');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('23','Las Piedras','2','2');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('24','Pando','2','2');



-- -------------------------------------------
-- TABLE DATA ciudad
-- -------------------------------------------
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('1','Montevideo','1');
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('2','Canelones','2');
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('3','Melo','10');



-- -------------------------------------------
-- TABLE DATA clientes
-- -------------------------------------------
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('1','','Gaston Baldenegro','44534681','Gilums','Continuacion abayuba 2582/201 Block L','gbg933@hotmail.com','www.gilums.com','99394334','Nossar','Todo Ok','1','1','3','2015-11-14 00:10:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('2','','Centro Salesiano Aires Puros','211756580011','Centro Salesiano Aires Puros - Kera MIta','Bulevar Batlle y Ordoñez 5020','cenrosalesianoairespuros@gmail.com','','23555684','','Contacto - Cristina Pascual','1','1','7','2015-11-14 00:51:49');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('3','','Cristina Garcia','.','.','Sin especificar','cgarcia@teleton.org.uy','.','99416062','.','','1','1','4','2015-11-16 12:42:00');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('4','','Ismael Benitez','','','3 De Abril','','','94296471','','','1','1','5','2015-11-26 02:03:16');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('5','','Diseño Electrónico','','','Constituyente esq Carlos Roxlo','diseñoelectronico@gmail.com','','94382892','','Cliente preferencial','1','1','4','2015-12-10 01:30:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('6','','Darwin Costa','','Automecanica Darwin','Julian Laguna','automecanicadarwin@hotmail.com','','94452883','','','1','1','2','2015-12-16 19:13:45');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('7','','Adriana Lopez','','','Coronel Alegre 1246','','','99918863','','','1','1','16','2015-12-30 16:27:16');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('8','','Toto','','','','','','93853820','','','1','1','5','2016-01-12 00:00:58');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('9','','Teresa - Tia de Daniel Bustos','.','','3 De Abril','','','94741358','','','1','1','','2016-01-21 23:33:44');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('10','','Jannet Easton ','000','','Islas Canarias 4214 ','eastonyanet@hotmail.com','','98818824','','','1','1','','2016-01-24 15:25:28');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('11','','Gustavo G.','000','','Cordoba','','','','','','1','1','','2016-01-31 18:31:43');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('12','','Andres Neyra','000','','Zapicán 1016 / 001','egonzalezpersak@hotmail.com','','99152527','','','1','1','','2016-02-12 20:23:23');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('13','','Rosi','000','','Cooperativa 3 de Abril','No tiene','No tiene','95663382','','','1','1','','2016-02-17 00:14:32');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('14','','Eduardo','000','','José Llupes S/N','','','94862870','','','1','1','','2016-02-20 14:33:42');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('15','','Laura Peralta','000','','Luis Alberto de Herrera esq 26 de Marzo','','','91441315','','','1','1','','2016-02-23 01:38:12');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('16','','Marcelo Inverso','1111111111','','Sancho Panza','','','95306805','','','1','1','','2016-03-08 04:24:29');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('17','','Adriana Guerrini','1111111111','','Luis Batlle Berres esq Tomkinson','adriguerrini@gmail.com','','99537419','','','1','1','','2016-03-14 15:21:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('18','','Gustavo Falero','1111111111','','','gfalero@adinet.com.uy','','23087651','','','1','1','','2016-03-14 15:22:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('19','','Silvana Radelli','1111111111','','Santa Lucia 5668','silvia131971@hotmail.com','','97082836','','','1','1','','2016-03-14 17:55:11');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('20','','Maria Jose Alonso','1111111111','','Ramón Estomba 3435','','','91072268','','','1','1','','2016-03-14 18:08:04');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('21','','Raquel Villamarin','1111111111','','19 de Abril 1120','','','23365450','','','1','1','','2016-03-14 20:42:54');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('22','','Eliana Ferro','.','','Ramón del Valle Inclán 2584','elianaferro23@gmail.com','22045753','','','','1','1','','2016-03-14 20:44:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('23','','Emery Lopez','*','','Parque Posadas S/N','.','','99509895','','','1','1','','2016-04-11 21:33:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('24','','Maria Cabral','.','','Francisco Pla 4161','miki-ale@hotmail.com','','94206397','','','1','1','','2016-04-14 01:27:04');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('25','','Mirtha Cardozo','.','','Lucio Rodriguez 4842 esq Cno de las Tropas','mirthateamo7@gmail.com','','92726879','','','1','1','','2016-04-14 02:18:29');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('26','','Dinorah Espósito','.','','Julián Laguna 5789','','','23077281','','','1','1','','2016-04-22 00:01:44');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('27','','Rosa Acher','.','','','','','97076869','','','1','1','','2016-05-05 00:16:01');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('28','','Gladys Mena','1111111111','','','','','22084198','','','1','1','','2016-05-07 15:25:36');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('29','','Mariela Camino','.','','','','','98815870','','','1','1','','2016-05-12 01:41:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('30','','Ana Pellatón','.','.','','.','','099652275','','','1','1','','2016-06-07 01:45:41');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('31','','Gonzalo Mendez','.','.','18 de Julio / Edificio Palacio Salvo','gmendez@teleton.org.uy','','099909453','','','1','1','4','2016-07-08 03:12:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('32','','Guillermo Rivero','.','','Mangoré','.','','23074615','','Es medio Maraca','1','1','6','2016-07-12 02:52:57');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('33','','Yanet Barreiro','.','','Julian Laguna 5993','.','','095512599','','','1','1','5','2016-07-18 16:06:37');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('34','','Paola Muzzio','.','.','Gestido 2784','lolamalvin@gmail.com','','099706441','','','1','1','16','2016-08-28 02:55:01');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('35','','Maria Victoria Diaz','.','.','.','.','.','22155761','.','','1','1','','2016-09-04 20:00:07');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('36','','Fernanda Cardozo','.','','Canelones 1357 esq Ejido','.','','099451604','','','1','1','','2016-09-07 03:22:51');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('37','','Guillermina  Suarez','..','.','Neyra 3704','escguillerminasuarez@gmail.com','','098181904','','','1','1','','2016-09-17 12:16:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('38','','Leonardo Girona','.','','Santa Lucia ','leonardo@lacasadeltornillo.com.uy','','094998598','','','1','1','2','2016-09-19 23:00:03');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('39','','Guillermo Ifrán','.','','Marcelino Sosa 2771/03','guillermoifran@gmail.com','','099655146','','','1','1','','2016-09-19 23:01:45');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('40','','Rodrigo Perez','210153800011','Radio Oriental S.A','Cerrito 475','rodripf@gmail.com','','098772728','','','1','1','','2016-09-22 02:34:32');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('41','','Washinton Lima','.','','Luis Battle Berres 6585','washinton1967@hotmail.com','','23123753','','','1','1','','2016-10-11 00:34:40');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('42','','Sofia Meroni','.','','','smeroni@teleton.org.uy','','099329534','','','1','1','','2016-10-18 23:36:48');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('43','','Estudio Reyes Lavega','.','','Canelones 1357','estudio@reyeslavega.com.uy','','29026033','','CONTACTO: 
FERNANDA CARDOZO - GUILLERMINA SUAREZ
','1','1','','2016-10-21 02:04:02');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('44','','Monica Bonilla','.','','','mbonilla@teleton.org.uy','','093418889','','','1','1','','2016-11-04 00:16:14');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('45','','Alejandra Matarredona','.','','','amatarredona@teleton.org.uy','','099132812','','','1','1','','2016-11-04 00:18:27');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('46','','Comision Fomento Villa Sarandi','.','.','Barrio Villa Sarandi','.','','098746484','','','1','1','','2016-11-16 16:38:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('47','','Maria Isabel Gandini','1111111111','','Julian Laguna 5993','Isabela_737@hotmail.com','','094083972','','','1','1','','2016-12-01 18:14:07');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('48','','Walter Chiruzzo','.','Vitrimac S.A','.Avda Capurro','vitrimac@gmail.com','','096872433','','','1','1','14','2016-12-19 16:51:58');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('49','','Alejandro Silva','.','','Carlos Maria de Pena 5811','hyraluminios@vera.com.uy','','23085008','','','1','1','2','2016-12-20 02:40:16');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('50','','Santiago Scattone','.','','Fraternidad 4261 esq Rubato','srscattone@gmail.com','','091293708','','','1','1','6','2016-12-30 19:38:53');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('51','','Dairi','.','','Pasaje de la escuela 3322 esq camino santa catalin','.','','091743621','','','1','1','13','2017-01-04 01:27:45');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('52','','Fabián Gardalina','.','.','Luis Battlle Berres ','.','','23124552','','','1','1','5','2017-01-16 16:46:28');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('53','','Pablo Arévalo','.','.','Santa Lucia','.','','095164042','.','','1','1','2','2017-02-03 19:53:41');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('54','','Luiselena Mesias','.','.','Carlos Brussa 2854','.','','099138303','','','1','1','','2017-03-17 21:41:11');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('55','','Rosalia Alvez','.','','Barrio Cerro','.','','****','','','1','1','','2017-03-24 01:31:54');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('56','','Andrea Balduzzo','.','','Bulevar Artigas 4365','.','.','2203 3244','','','1','1','14','2017-03-24 02:38:24');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('57','','Rosicler Severo','.','.','Luis Batlle Berres 5834 ','.','','23181843','','','1','1','5','2017-03-31 23:57:05');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('58','','Ligia Bacchetta','1111111111','','Asamblea 4144 esq Propios','lbacchetta@teleton.org.uy','','099370926','','','1','1','','2017-05-02 18:26:22');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('59','','Franca Pizzorno','.','','Luis Batlle Berres ','.','','23124552','','','1','1','5','2017-05-29 21:24:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('60','','DECOS','.','Tecnovil S.A','Cerrito 475','brianrs.90@gmail.com','','098896407','','','1','1','9','2017-06-28 16:35:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('61','','IMAN','.','','Gonzalo Ramirez 1676 Oficina 1','fiorella@iman.com.uy','','091937321','','','1','1','','2017-07-10 15:39:14');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('62','','Matias Rodriguez','.','.','3 De abril','.','','099051770','','','1','0','','2017-07-25 00:43:25');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('63','','Romina Curbelo','1111111111','','Jose Arechavaleta 3883','romicurbelo2010@hotmail.com','','098458907','','','1','1','','2017-07-31 16:53:12');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('64','','Sarah Dodero','.','.','','.','','099103003','.','','1','1','6','2017-09-18 23:11:43');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('65','','Silvia Pereira','.','.','Carlos Brussa 2854','spereira@teleton.org.uy','','099144553','','','1','1','2','2017-10-18 02:43:40');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('66','','Centro Monseñor Lasagna','.','','Gaboto 1527','psluzardo@gmail.com','','098867162','','','1','1','','2017-11-08 04:28:55');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('67','','Mariela Tardaguila','.','','Montero Vidarrueta 1342','.','','094958408','','','1','1','','2017-11-21 00:11:12');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('68','','Anibal Medina','.','','Jhon Milton 4644','anibal.medina@akzonobel.com','','092361968','.','','1','1','','2017-11-23 16:50:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('69','','Juan José Solari','.','','','juanjose.solari@gmail.com','','099553137','','','1','1','','2017-12-27 16:09:12');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('70','','Federico Bolazzi','1111111111','','Julian Laguna ','.','','00000','','','0','0','','2017-12-29 19:59:52');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('71','','Roberto Gil','.','','','.','','099940520','.','','1','1','','2018-01-09 02:34:35');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('72','','TACURU','.','','','casajoventacuru@gmail.com','','091839897','','','1','1','','2018-01-09 02:42:11');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('73','','Unpub S.A','.','','Cebollatí 1563','obarreto@unidadpublicitaria.com.uy','','24194821','','','1','1','','2018-01-22 12:07:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('74','','Bar Clavel','.','','Conciliación 3952','.','','23078663','','','1','1','','2018-03-21 15:29:58');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('75','','Roberto Alonso','.','','Amarales ','.','','099607562','','','1','1','8','2018-03-22 23:12:04');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('76','','Andrea Gómez','.','.','Julio Sosa 4548','Andre.g73@hotmail.com','','26130952','','','1','1','17','2018-06-06 23:56:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('77','','Eloisa Gonzalez','.','','Avenida a la playa nº 48 esquina oficial 8','egonzalezpersak@hotmail.com','','099436425','','','1','1','','2018-06-07 01:14:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('78','','Mariana Bica','.','','','mbica@teleton.org.uy','',' 099555016','','','1','1','','2018-12-14 02:08:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('79','','Giuliana Venturino','.','','Carlos Brussa 2854','gventurino@teleton.org.uy','','098470720','','','1','1','','2018-12-14 03:02:46');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('80','','Sonia Fernandez','.','','Manuel Herrera y Obes 4598','.','','099056422','','','1','1','','2018-12-14 17:06:23');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('81','','Gloria Dávila','.','.','Jose Yupes 5703','.','','094549381','','','1','1','','2018-12-14 17:24:29');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('82','','Alejandro Lorenzo','.','','Acasubi','.','.','094605265','','','1','1','','2018-12-30 21:44:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('83','','Juan Carlos Mateu','.','','Las Toscas km48 calle 13 d y e','.','','095529271','','','2','2','','2019-01-18 05:22:53');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('84','','Cynthia Guedes','.','','Luis Batlle Berres esq cno de las Tropas','.','','098372110','','','1','1','','2019-01-19 16:18:52');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('85','','CIAN','.','','Gestido 2833','ewojnaro@gmail.com','','27083316','','','1','1','','2019-02-13 02:42:38');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('86','','Carmen Dominguez ','.','','Ambrosio Velazco 1408','.','','099112388','.','','1','1','','2019-02-13 03:04:00');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('87','','Juan Carlos Canessa','.','','Costa Rica 1616','conqui@adinet.com.uy','','099620025','','','1','1','18','2008-03-11 06:16:39');



-- -------------------------------------------
-- TABLE DATA departamento
-- -------------------------------------------
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('1','Montevideo');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('2','Canelones');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('3','San José');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('4','Salto');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('5','Rivera');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('6','Paysandú');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('7','Tacuarembó');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('8','Maldonado');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('9','Rio Negro');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('10','Cerro Largo');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('11','Colonia');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('12','Durazno');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('13','Lavalleja');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('14','Rocha');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('15','Flores');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('16','Florida');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('17','Artigas');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('18','Treinta Y Tres');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('19','Soriano');



-- -------------------------------------------
-- TABLE DATA equipos
-- -------------------------------------------
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('2','','CR610','JJJSDSD','Notebook','5');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('3','','CR610','JJJSDSD','Notebook','5');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('4','','CR610','JJJSDSD','Notebook','5');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('5','','CR610','JJJJDDD','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('8','','CQ43','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('9','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('10','','DC 5700 MICROTOWER','MXJ8040DTP','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('11','','Compaq 8000 Elite','mxl0210z6w','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('12','','Abono Mensual','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('14','','Panavox','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('15','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('16','','HP COMPAQ ELITE 8200','MXL0210Z4M','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('17','','Instalación','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('18','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('19','','PC','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('20','','Fujitsu Siemens','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('21','','Satellite L45-B4202WL','7E098165S','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('22','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('23','','Aspier 5742-6415','LXR4F0107111621D3F1601','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('24','','LED TV KDL-48W605B','7011579','Otros','16');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('25','','Elitebook 2530p','cnd019101t','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('26','','X551M','E4N0CXIRR0M4187','Notebook','6');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('27','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('28','','PC-9890166','h2931090904215','Notebook','3');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('29','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('30','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('31','','Visita Técnica ','','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('32','','.','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('33','','.','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('34','','CLON','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('35','','CLON','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('36','','DC7700P','CZC7423565','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('37','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('38','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('39','','Satellite L45-B4202WL','.','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('40','','Satellite L305D-SP6805R','Y8099184Q','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('41','','prueba','sss','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('42','','Satellite L305D-SP6805R','Y8099184Q','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('43','','Satellite C855D-S5320','8C184251Q','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('44','','Optiplex GX620','BLGYN2J','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('45','','Aspire One NAV50','LUSAL080130043C19F1601','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('46','','CLON','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('47','','KAWF0','LXN320200700427F571601','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('48','','CLON','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('49','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('50','','Aspire 5732Z','LXPGU080049423217C1601','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('51','','Clon','','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('52','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('53','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('54','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('55','','Mantenimiento','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('56','','Pavilion dv5','cnu0395hcs','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('57','','x401a','D7N0BCKRR0A7280','Notebook','6');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('59','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('60','','Dell Inspiron M731R-5735','3c10ry1','Notebook','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('61','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('62','','Pavilion DV5','CNU11123RN','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('63','','pc','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('64','','PC','.','PC','3');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('65','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('66','','CLON',',','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('67','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('68','','Satellite Pro C650-SP6005L','6A460265Q','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('69','','Pavilion','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('70','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('71','','Compaq Elite 8000 SFF','mxl0210z6w','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('72','','Compaq NC6320','.','Otros','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('73','','CLON','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('74','','Pavilion DV4','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('75','','Satellite L755D-S7107','.','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('76','','Aspire E5-571','NXMLTAL021434033743400','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('77','','NV57H94U','NXWZGAA012120349B1601','Notebook','10');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('78','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('79','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('80','','PC','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('81','','Stream 11-d001dx Notebook PC','5CD51617S4','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('82','','CLON I3','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('83','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('84','','Aspire 5738-6197','509afb2000','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('85','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('86','','Visita Técnica ','.','Otros','18');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('87','','ELITE 8000','HP800KN118138','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('88','','Acer','E1-431-2405','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('89','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('90','','VSL-8204HWI-SH','436503300','DVR','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('91','','NP-R440L','.','Notebook','8');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('92','','Compaq 610','CNU9254G4M','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('93','','Instalación','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('94','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('95','','CR610','.','Notebook','5');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('96','','300V','S/N','Notebook','8');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('97','','ELITE 8200','CZC1431Y9H','Otros','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('98','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('99','','PC','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('100','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('101','','DC7700p','HUB7370CSN','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('102','','Dell Latitude E6430','.','Notebook','18');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('103','','Vaio VPCEG','275451283001743','Notebook','16');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('104','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('105','','Pavilion G6','5CD2112S2H','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('106','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('107','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('108','','Visita Técnica ','1111','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('109','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('110','','Visita Técnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('111','','DELL LATITUDE E 6420','2VK16Q1','Notebook','18');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('112','','Aspire V3-571-6813','NXRYFAL028323011CB3400','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('113','','DC5800','MXJ8200S1','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('114','','DC5800','MXJ8200S1','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('115','','Hp 15','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('116','','Gateway','1111','Notebook','17');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('117','','PC','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('118','','Pendrive','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('119','','SVF142C29U','.','Notebook','16');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('120','','Satellite U505-S2002','z9022366r','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('121','','Pavilion DV7','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('122','','PC','1111','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('123','','Sony','1111','Notebook','16');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('124','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('125','','Notebook Samsung','.','Notebook','8');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('126','','Acer Aspire ES1-512-C2FW','MS2394','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('127','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('128','','15-F019DX','6CF44505GW','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('129','','PC','.','Otros','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('130','','Hp ','CND019101T','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('131','','x551m','e4n0cxirr0m41b7','Notebook','6');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('132','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('133','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('134','','PC','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('135','','Notebook Dell','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('136','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('137','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('138','','PC','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('139','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('140','','PC','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('141','','Lenovo G515','.','Notebook','7');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('142','','Satellite C-55-C5201K','8F160274C','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('143','','HP','HPC2D233772652','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('144','','Visita Técnica','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('145','','Visita Técnica','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('146','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('147','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('148','','Disco Duro','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('149','','Satellite L45-B4202WL','7E144605S','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('150','','LINETHINK 6008-LM','6008-LM','DVR','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('151','','Lenovo All in One','.','PC','7');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('152','','Asus','.','Notebook','6');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('153','','Elite 8300 SFF','CZC3471B9B','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('154','','Elite 800 G1 SFF','MXL4150DNY','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('155','','Visita Técnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('156','','Instalación de Cámaras','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('157','','NP-RV411-A04AR','ezva93hb600004m','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('158','','15-R011DX','CND4162Y8J','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('159','','HP 15','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('160','','HP-D079WM','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('161','','DELL ','.','Notebook','18');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('162','','Epson XP-211','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('163','','Toshiba External Drive','.','Otros','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('164','','Aspire E15','NXMLTAA027505194C63400','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('165','','Idealpad 320-15iap','PF123V13','Notebook','7');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('166','','Aspire ES1-512-C2FA','NXMRWAA01745209C2A6600','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('167','','CAMARAS ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('168','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('169','','INSPIRON N5010','63L1VP1','Notebook','18');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('170','','Visita Técnica - Cámaras','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('171','','VISITA TECNICA','.','Otros','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('172','','Visita - Instalación','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('173','','.','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('174','','Visita','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('175','','Night Owl','203D-030308','DVR','15');



-- -------------------------------------------
-- TABLE DATA historial
-- -------------------------------------------
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('1','','1','Create','Success','Creo el ciudad: Montevideo','0','2015-11-13 23:52:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('2','','1','Create','Success','Creo el accesorio: Protector','0','2015-11-13 23:53:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('3','','1','Create','Success','Creo el barrio: Nuevo Paris','0','2015-11-14 00:07:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('4','','1','Create','Success','Creo el barrio: Reducto','0','2015-11-14 00:07:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('5','','1','Create','Success','Creo el barrio: Centro','0','2015-11-14 00:07:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('6','','1','Delete','Error','Elimino el equipo: Elitebook 820','0','2015-11-14 00:08:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('7','','1','Delete','Error','Elimino el equipo: CR610','0','2015-11-14 00:08:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('8','','1','Create','Success','Creo el cliente: Gaston Baldenegro','0','2015-11-14 00:10:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('9','','1','Create','Success','Creo la orden: ','0','2015-11-14 00:17:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('10','','1','Create','Success','Creo el cliente: Centro Salesiano Aires Puros','0','2015-11-14 00:51:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('11','','1','Update','Warning','Modifico la orden: 1000','0','2015-11-14 01:00:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('12','','1','Update','Warning','Modifico la orden: 1001','0','2015-11-14 01:06:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('13','','1','Update','Warning','Modifico la orden: 1001','0','2015-11-14 01:12:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('14','','1','Create','Success','Creo la orden: ','0','2015-11-14 21:14:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('15','','1','Create','Success','Creo el cliente: Cristina Garcia','0','2015-11-16 12:42:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('16','','1','Create','Success','Creo la orden: ','0','2015-11-16 12:43:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('17','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:45:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('18','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:53:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('19','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:53:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('20','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:53:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('21','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:53:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('22','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:55:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('23','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:55:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('24','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:55:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('25','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:55:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('26','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 12:56:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('27','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-16 13:06:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('28','','1','Create','Success','Creo el barrio: Paso de la Arena','0','2015-11-16 15:00:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('29','','1','Create','Success','Creo el barrio: Belvedere','0','2015-11-16 15:01:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('30','','1','Create','Success','Creo el barrio: Aires Puros','0','2015-11-16 15:01:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('31','','1','Create','Success','Creo el barrio: Prado','0','2015-11-16 15:01:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('32','','1','Create','Success','Creo el barrio: Ciudad Vieja','0','2015-11-16 15:01:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('33','','1','Create','Success','Creo el barrio: Los Aromos','0','2015-11-16 15:01:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('34','','1','Create','Success','Creo el barrio: Jardines del Hipodromo','0','2015-11-16 15:02:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('35','','1','Create','Success','Creo el barrio: Lezica','0','2015-11-16 15:02:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('36','','1','Create','Success','Creo el barrio: Cerro','0','2015-11-16 15:02:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('37','','1','Create','Success','Creo el barrio: Capurro','0','2015-11-16 15:02:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('38','','1','Create','Success','Creo el barrio: Parque Rodo','0','2015-11-16 15:02:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('39','','1','Create','Success','Creo el barrio: Pocitos','0','2015-11-16 15:03:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('40','','1','Create','Success','Creo el barrio: Malvin','0','2015-11-16 15:03:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('41','','1','Create','Success','Creo el barrio: Carrasco','0','2015-11-16 15:03:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('42','','1','Create','Success','Creo el barrio: Barrio Sur','0','2015-11-16 15:03:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('43','','1','Create','Success','Creo el barrio: Los Bulveres','0','2015-11-16 15:04:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('44','','1','Create','Success','Creo el barrio: Barra Santa Lucia','0','2015-11-16 15:04:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('45','','1','Create','Success','Creo el ciudad: Canelones','0','2015-11-16 15:05:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('46','','1','Create','Success','Creo el barrio: La Paz','0','2015-11-16 15:06:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('47','','1','Create','Success','Creo el barrio: Las Piedras','0','2015-11-16 15:06:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('48','','1','Create','Success','Creo el barrio: Pando','0','2015-11-16 15:06:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('49','','1','Create','Success','Creo el ciudad: Melo','0','2015-11-16 15:07:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('50','','1','Update','Warning','Modifico la orden: 1003','0','2015-11-17 02:32:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('51','','1','Create','Success','Creo el cliente: Ismael Benitez','0','2015-11-26 02:03:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('52','','1','Create','Success','Creo la orden: ','0','2015-11-26 02:04:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('53','','1','Update','Warning','Modifico la orden: 1004','0','2015-11-26 02:22:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('54','','1','Create','Success','Creo la orden: ','0','2015-11-26 02:26:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('55','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 02:40:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('56','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 03:00:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('57','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 03:09:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('58','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 03:09:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('59','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 03:09:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('60','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 03:09:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('61','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 03:10:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('62','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 23:24:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('63','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 23:24:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('64','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 23:25:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('65','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 23:25:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('66','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 23:25:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('67','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-26 23:26:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('68','','1','Update','Warning','Modifico la orden: 1002','0','2015-11-27 01:04:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('69','','1','Delete','Error','Elimino la orden: 1001','0','2015-11-27 01:16:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('70','','1','Delete','Error','Elimino la orden: 1000','0','2015-11-27 01:16:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('71','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 01:16:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('72','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 01:17:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('73','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 01:19:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('74','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 01:19:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('75','','1','Update','Warning','Modifico el cliente: Centro Salesiano Aires Puros','0','2015-11-27 01:22:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('76','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 01:22:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('77','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 01:25:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('78','','1','Update','Warning','Modifico la orden: 1005','0','2015-11-27 02:17:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('79','','1','Create','Success','Creo la orden: ','0','2015-12-01 01:38:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('80','','1','Update','Warning','Modifico la orden: 1005','0','2015-12-01 01:39:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('81','','1','Update','Warning','Modifico la orden: 1005','0','2015-12-01 01:39:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('82','','1','Update','Warning','Modifico la orden: 1005','0','2015-12-01 01:39:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('83','','1','Update','Warning','Modifico la orden: 1005','0','2015-12-01 01:39:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('84','','1','Update','Warning','Modifico la orden: 1005','0','2015-12-01 01:40:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('85','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-01 01:40:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('86','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-01 01:40:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('87','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-01 01:40:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('88','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-01 01:40:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('89','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-01 01:40:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('90','','1','Delete','Error','Elimino la orden: 1002','0','2015-12-01 01:40:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('91','','1','Create','Success','Creo la orden: ','0','2015-12-01 11:31:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('92','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:31:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('93','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:31:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('94','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:31:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('95','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:32:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('96','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:32:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('97','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:32:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('98','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:32:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('99','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-01 11:38:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('100','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-03 01:45:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('101','','1','Update','Warning','Modifico la orden: 1007','0','2015-12-03 01:45:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('102','','1','Update','Warning','Modifico la orden: 1005','0','2015-12-03 01:45:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('103','','1','Create','Success','Creo la orden: ','0','2015-12-04 01:32:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('104','','1','Update','Warning','Modifico la orden: 1008','0','2015-12-04 01:32:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('105','','1','Update','Warning','Modifico la orden: 1008','0','2015-12-04 01:33:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('106','','1','Update','Warning','Modifico la orden: 1008','0','2015-12-04 01:33:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('107','','1','Update','Warning','Modifico la orden: 1008','0','2015-12-04 01:33:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('108','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-08 22:51:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('109','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-08 23:42:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('110','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-08 23:43:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('111','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-08 23:43:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('112','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-08 23:43:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('113','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-08 23:43:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('114','','1','Update','Warning','Modifico el cliente: Cristina Garcia','0','2015-12-08 23:45:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('115','','1','Update','Warning','Modifico la orden: 1003','0','2015-12-08 23:46:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('116','','1','Create','Success','Creo el cliente: Diseño Electrónico','0','2015-12-10 01:30:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('117','','1','Create','Success','Creo la orden: ','0','2015-12-10 01:31:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('118','','1','Update','Warning','Modifico la orden: 1009','0','2015-12-10 01:31:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('119','','1','Update','Warning','Modifico el cliente: Diseño Electrónico','0','2015-12-10 01:32:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('120','','1','Update','Warning','Modifico el cliente: Diseño Electrónico','0','2015-12-10 01:32:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('121','','1','Delete','Error','Elimino la orden: 1008','0','2015-12-16 19:05:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('122','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:05:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('123','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:05:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('124','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:05:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('125','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:06:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('126','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:06:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('127','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:07:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('128','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:07:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('129','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-16 19:07:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('130','','1','Create','Success','Creo el cliente: Darwin Costa','0','2015-12-16 19:13:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('131','','1','Create','Success','Creo la orden: ','0','2015-12-16 19:14:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('132','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-18 12:54:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('133','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-18 12:55:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('134','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-18 12:55:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('135','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-18 12:55:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('136','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-18 12:55:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('137','','1','Update','Warning','Modifico la orden: 1004','0','2015-12-18 12:55:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('138','','1','Create','Success','Creo la orden: ','0','2015-12-21 19:23:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('139','','1','Update','Warning','Modifico la orden: 1011','0','2015-12-21 19:24:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('140','','1','Update','Warning','Modifico la orden: 1011','0','2015-12-21 19:25:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('141','','1','Update','Warning','Modifico la orden: 1011','0','2015-12-21 19:25:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('142','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-21 19:25:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('143','','1','Update','Warning','Modifico la orden: 1006','0','2015-12-21 19:25:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('144','','1','Update','Warning','Modifico la orden: 1011','0','2015-12-21 19:26:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('145','','1','Create','Success','Creo el cliente: Adriana Lopez','0','2015-12-30 16:27:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('146','','1','Create','Success','Creo la orden: ','0','2015-12-30 16:28:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('147','','1','Update','Warning','Modifico la orden: 1012','0','2015-12-30 16:32:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('148','','1','Update','Warning','Modifico la orden: 1012','0','2015-12-30 16:33:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('149','','1','Update','Warning','Modifico la orden: 1012','0','2015-12-30 16:33:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('150','','1','Update','Warning','Modifico la orden: 1012','0','2015-12-30 16:33:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('151','','1','Update','Warning','Modifico la orden: 1012','0','2015-12-30 16:34:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('152','','1','Create','Success','Creo la orden: ','0','2015-12-30 16:35:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('153','','1','Update','Warning','Modifico la orden: 1013','0','2015-12-30 16:36:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('154','','1','Update','Warning','Modifico la orden: 1013','0','2015-12-30 16:36:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('155','','1','Update','Warning','Modifico la orden: 1013','0','2015-12-30 16:36:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('156','','1','Update','Warning','Modifico la orden: 1013','0','2015-12-30 16:36:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('157','','1','Update','Warning','Modifico la orden: 1013','0','2015-12-30 16:36:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('158','','1','Create','Success','Creo el cliente: Toto','0','2016-01-12 00:00:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('159','','1','Create','Success','Creo la orden: ','0','2016-01-12 00:02:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('160','','1','Update','Warning','Modifico la orden: 1014','0','2016-01-12 00:03:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('161','','1','Update','Warning','Modifico la orden: 1014','0','2016-01-12 00:03:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('162','','1','Update','Warning','Modifico la orden: 1014','0','2016-01-12 00:04:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('163','','1','Update','Warning','Modifico la orden: 1014','0','2016-01-12 00:04:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('164','','1','Update','Warning','Modifico la orden: 1014','0','2016-01-12 00:05:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('165','','1','Update','Warning','Modifico la orden: 1003','0','2016-01-20 23:15:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('166','','1','Update','Warning','Modifico la orden: 1009','0','2016-01-20 23:16:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('167','','1','Update','Warning','Modifico la orden: 1005','0','2016-01-20 23:17:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('168','','1','Update','Warning','Modifico la orden: 1005','0','2016-01-20 23:18:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('169','','1','Create','Success','Creo el cliente: Teresa - Tia de Daniel Bustos','0','2016-01-21 23:33:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('170','','1','Create','Success','Creo la orden: ','0','2016-01-21 23:35:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('171','','1','Update','Warning','Modifico la orden: 1015','0','2016-01-21 23:38:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('172','','1','Update','Warning','Modifico la orden: 1015','0','2016-01-21 23:38:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('173','','1','Update','Warning','Modifico la orden: 1015','0','2016-01-21 23:38:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('174','','1','Create','Success','Creo el cliente: Jannet Easton ','0','2016-01-24 15:25:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('175','','1','Create','Success','Creo la orden: ','0','2016-01-24 15:36:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('176','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:37:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('177','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:38:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('178','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:38:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('179','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:38:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('180','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:38:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('181','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:38:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('182','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:39:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('183','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-24 15:39:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('184','','1','Create','Success','Creo la orden: ','0','2016-01-24 15:45:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('185','','1','Update','Warning','Modifico la orden: 1017','0','2016-01-24 15:46:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('186','','1','Update','Warning','Modifico la orden: 1017','0','2016-01-24 15:47:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('187','','1','Update','Warning','Modifico la orden: 1017','0','2016-01-24 15:47:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('188','','1','Update','Warning','Modifico la orden: 1016','0','2016-01-27 01:39:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('189','','1','Update','Warning','Modifico la orden: 1017','0','2016-01-27 01:42:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('190','','1','Create','Success','Creo el cliente: Gustavo G.','0','2016-01-31 18:31:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('191','','1','Create','Success','Creo la orden: ','0','2016-01-31 18:34:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('192','','1','Update','Warning','Modifico la orden: 1018','0','2016-01-31 18:35:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('193','','1','Update','Warning','Modifico la orden: 1018','0','2016-01-31 18:35:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('194','','1','Update','Warning','Modifico la orden: 1018','0','2016-01-31 18:35:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('195','','1','Update','Warning','Modifico la orden: 1018','0','2016-01-31 18:36:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('196','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:26:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('197','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:26:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('198','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:27:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('199','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:27:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('200','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:27:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('201','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:27:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('202','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:28:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('203','','1','Update','Warning','Modifico la orden: 1015','0','2016-02-08 12:28:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('204','','1','Create','Success','Creo el cliente: Andres Neyra','0','2016-02-12 20:23:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('205','','1','Create','Success','Creo la marca: Sony','0','2016-02-12 20:26:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('206','','1','Create','Success','Creo la orden: ','0','2016-02-12 20:28:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('207','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-12 20:31:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('208','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-12 20:31:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('209','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-12 20:35:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('210','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-12 20:35:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('211','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-15 11:57:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('212','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-15 11:57:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('213','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-15 11:58:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('214','','1','Update','Warning','Modifico la orden: 1019','0','2016-02-15 12:02:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('215','','1','Create','Success','Creo la orden: ','0','2016-02-17 00:11:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('216','','1','Create','Success','Creo el cliente: Rosi','0','2016-02-17 00:14:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('217','','1','Create','Success','Creo la orden: ','0','2016-02-17 00:16:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('218','','1','Create','Success','Creo el cliente: Eduardo','0','2016-02-20 14:33:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('219','','1','Create','Success','Creo la orden: ','0','2016-02-20 14:34:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('220','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:37:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('221','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:37:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('222','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:37:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('223','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:37:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('224','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:38:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('225','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:38:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('226','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:39:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('227','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:39:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('228','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:39:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('229','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:39:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('230','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:39:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('231','','1','Update','Warning','Modifico la orden: 1022','0','2016-02-20 14:40:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('232','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:24:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('233','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:24:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('234','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:24:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('235','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:24:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('236','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:24:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('237','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:28:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('238','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:29:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('239','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:29:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('240','','1','Update','Warning','Modifico la orden: 1021','0','2016-02-22 00:29:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('241','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:33:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('242','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('243','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('244','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('245','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('246','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('247','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('248','','1','Update','Warning','Modifico la orden: 1020','0','2016-02-22 00:34:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('249','','1','Create','Success','Creo el cliente: Laura Peralta','0','2016-02-23 01:38:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('250','','1','Create','Success','Creo la orden: ','0','2016-02-23 01:40:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('251','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:41:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('252','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:43:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('253','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:43:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('254','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:43:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('255','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:45:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('256','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:45:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('257','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:45:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('258','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:45:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('259','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:45:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('260','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:48:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('261','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:48:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('262','','1','Update','Warning','Modifico la orden: 1023','0','2016-02-23 01:49:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('263','','1','Create','Success','Creo la orden: ','0','2016-02-26 01:36:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('264','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:37:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('265','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:37:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('266','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:37:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('267','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:37:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('268','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:37:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('269','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:37:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('270','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:38:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('271','','1','Update','Warning','Modifico la orden: 1024','0','2016-02-26 01:38:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('272','','1','Create','Success','Creo la orden: ','0','2016-02-26 01:39:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('273','','1','Update','Warning','Modifico la orden: 1025','0','2016-02-26 01:40:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('274','','1','Delete','Error','Elimino la orden: 1025','0','2016-02-26 01:40:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('275','','1','Create','Success','Creo la orden: ','0','2016-03-08 04:17:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('276','','1','Create','Success','Creo el cliente: Marcelo Inverso','0','2016-03-08 04:24:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('277','','1','Update','Warning','Modifico el cliente: Marcelo Inverso','0','2016-03-08 04:34:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('278','','1','Create','Success','Creo la orden: ','0','2016-03-08 04:42:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('279','','1','Update','Warning','Modifico la orden: 1026','0','2016-03-08 04:46:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('280','','1','Update','Warning','Modifico la orden: 1026','0','2016-03-08 04:46:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('281','','1','Create','Success','Creo el cliente: Adriana Guerrini','0','2016-03-14 15:21:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('282','','1','Create','Success','Creo el cliente: Gustavo Falero','0','2016-03-14 15:22:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('283','','1','Create','Success','Creo el cliente: Silvana Radelli','0','2016-03-14 17:55:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('284','','1','Create','Success','Creo la orden: ','0','2016-03-14 18:02:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('285','','1','Create','Success','Creo la orden: ','0','2016-03-14 18:03:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('286','','1','Create','Success','Creo el cliente: Maria Jose Alonso','0','2016-03-14 18:08:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('287','','1','Create','Success','Creo la orden: ','0','2016-03-14 18:09:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('288','','1','Create','Success','Creo el cliente: Raquel Villamarin','0','2016-03-14 20:42:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('289','','1','Create','Success','Creo el cliente: Eliana Ferro','0','2016-03-14 20:44:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('290','','1','Create','Success','Creo la orden: ','0','2016-03-14 20:45:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('291','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 20:59:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('292','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 21:00:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('293','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 21:00:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('294','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 21:00:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('295','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 21:00:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('296','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 21:00:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('297','','1','Update','Warning','Modifico la orden: 1028','0','2016-03-14 21:00:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('298','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:01:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('299','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:02:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('300','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:02:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('301','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:04:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('302','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:04:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('303','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:04:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('304','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:04:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('305','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:08:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('306','','1','Update','Warning','Modifico la orden: 1027','0','2016-03-14 21:08:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('307','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:09:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('308','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:09:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('309','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:10:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('310','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:11:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('311','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:11:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('312','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:11:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('313','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:11:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('314','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:11:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('315','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-14 21:12:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('316','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:32:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('317','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:32:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('318','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:35:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('319','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:35:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('320','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:36:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('321','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:36:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('322','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:36:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('323','','1','Update','Warning','Modifico la orden: 1030','0','2016-03-17 22:36:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('324','','1','Create','Success','Creo la orden: ','0','2016-03-17 22:40:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('325','','1','Update','Warning','Modifico la orden: 1031','0','2016-03-17 22:40:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('326','','1','Update','Warning','Modifico la orden: 1031','0','2016-03-17 22:40:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('327','','1','Update','Warning','Modifico la orden: 1031','0','2016-03-17 22:41:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('328','','1','Update','Warning','Modifico la orden: 1031','0','2016-03-17 22:41:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('329','','1','Update','Warning','Modifico la orden: 1031','0','2016-03-17 22:41:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('330','','1','Update','Warning','Modifico el cliente: Eliana Ferro','0','2016-03-17 22:42:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('331','','1','Update','Warning','Modifico la orden: 1031','0','2016-03-17 22:42:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('332','','1','Create','Success','Creo la orden: ','0','2016-03-31 01:51:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('333','','1','Update','Warning','Modifico la orden: 1032','0','2016-03-31 01:52:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('334','','1','Update','Warning','Modifico la orden: 1032','0','2016-03-31 01:52:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('335','','1','Update','Warning','Modifico la orden: 1032','0','2016-03-31 01:52:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('336','','1','Update','Warning','Modifico la orden: 1032','0','2016-03-31 01:52:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('337','','1','Update','Warning','Modifico la orden: 1032','0','2016-03-31 01:52:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('338','','1','Update','Warning','Modifico la orden: 1032','0','2016-03-31 01:52:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('339','','1','Create','Success','Creo la orden: ','0','2016-03-31 01:55:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('340','','1','Update','Warning','Modifico la orden: 1033','0','2016-03-31 01:56:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('341','','1','Update','Warning','Modifico la orden: 1033','0','2016-03-31 01:57:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('342','','1','Update','Warning','Modifico la orden: 1033','0','2016-03-31 01:57:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('343','','1','Update','Warning','Modifico la orden: 1033','0','2016-03-31 01:57:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('344','','1','Update','Warning','Modifico la orden: 1033','0','2016-03-31 01:57:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('345','','1','Create','Success','Creo la orden: ','0','2016-03-31 01:59:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('346','','1','Update','Warning','Modifico la orden: 1034','0','2016-03-31 02:02:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('347','','1','Update','Warning','Modifico la orden: 1034','0','2016-03-31 02:02:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('348','','1','Update','Warning','Modifico la orden: 1034','0','2016-03-31 02:02:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('349','','1','Update','Warning','Modifico la orden: 1034','0','2016-03-31 02:03:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('350','','1','Update','Warning','Modifico la orden: 1034','0','2016-03-31 02:03:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('351','','1','Update','Warning','Modifico la orden: 1034','0','2016-03-31 02:03:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('352','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:10:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('353','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:12:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('354','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:13:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('355','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:13:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('356','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:13:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('357','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:13:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('358','','1','Update','Warning','Modifico la orden: 1029','0','2016-03-31 02:13:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('359','','1','Create','Success','Creo el cliente: Emery Lopez','0','2016-04-11 21:33:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('360','','1','Create','Success','Creo la orden: ','0','2016-04-11 21:34:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('361','','1','Create','Success','Creo la orden: ','0','2016-04-11 21:37:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('362','','1','Create','Success','Creo la orden: ','0','2016-04-11 21:39:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('363','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-11 21:40:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('364','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-11 21:40:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('365','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-11 21:41:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('366','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-11 21:41:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('367','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:26:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('368','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:26:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('369','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:26:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('370','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:29:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('371','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('372','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('373','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('374','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('375','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('376','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('377','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-13 02:30:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('378','','1','Create','Success','Creo la orden: ','0','2016-04-14 01:19:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('379','','1','Update','Warning','Modifico la orden: 1038','0','2016-04-14 01:20:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('380','','1','Update','Warning','Modifico la orden: 1038','0','2016-04-14 01:21:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('381','','1','Update','Warning','Modifico la orden: 1038','0','2016-04-14 01:21:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('382','','1','Create','Success','Creo el cliente: Maria Cabral','0','2016-04-14 01:27:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('383','','1','Create','Success','Creo la orden: ','0','2016-04-14 01:27:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('384','','1','Update','Warning','Modifico la orden: 1039','0','2016-04-14 01:29:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('385','','1','Update','Warning','Modifico la orden: 1039','0','2016-04-14 01:29:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('386','','1','Update','Warning','Modifico la orden: 1039','0','2016-04-14 01:30:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('387','','1','Update','Warning','Modifico la orden: 1039','0','2016-04-14 01:30:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('388','','1','Create','Success','Creo la orden: ','0','2016-04-14 02:08:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('389','','1','Update','Warning','Modifico la orden: 1040','0','2016-04-14 02:09:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('390','','1','Update','Warning','Modifico la orden: 1040','0','2016-04-14 02:10:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('391','','1','Update','Warning','Modifico la orden: 1040','0','2016-04-14 02:11:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('392','','1','Update','Warning','Modifico la orden: 1040','0','2016-04-14 02:12:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('393','','1','Update','Warning','Modifico la orden: 1037','0','2016-04-14 02:14:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('394','','1','Create','Success','Creo el cliente: Mirtha Cardozo','0','2016-04-14 02:18:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('395','','1','Create','Success','Creo la orden: ','0','2016-04-14 02:19:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('396','','1','Update','Warning','Modifico la orden: 1041','0','2016-04-14 02:20:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('397','','1','Update','Warning','Modifico la orden: 1041','0','2016-04-14 02:20:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('398','','1','Update','Warning','Modifico la orden: 1041','0','2016-04-14 02:20:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('399','','1','Create','Success','Creo el cliente: Dinorah Espóstio','0','2016-04-22 00:01:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('400','','1','Update','Warning','Modifico el cliente: Dinorah Espósito','0','2016-04-22 00:04:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('401','','1','Create','Success','Creo la orden: ','0','2016-04-22 00:06:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('402','','1','Update','Warning','Modifico la orden: 1042','0','2016-04-22 00:08:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('403','','1','Update','Warning','Modifico la orden: 1042','0','2016-04-22 00:08:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('404','','1','Update','Warning','Modifico la orden: 1042','0','2016-04-22 00:12:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('405','','1','Update','Warning','Modifico la orden: 1042','0','2016-04-22 00:12:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('406','','1','Create','Success','Creo la orden: ','0','2016-04-22 00:19:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('407','','1','Update','Warning','Modifico la orden: 1043','0','2016-04-22 00:21:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('408','','1','Update','Warning','Modifico la orden: 1043','0','2016-04-22 00:21:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('409','','1','Update','Warning','Modifico la orden: 1043','0','2016-04-22 00:21:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('410','','1','Create','Success','Creo la orden: ','0','2016-05-02 01:07:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('411','','1','Update','Warning','Modifico la orden: 1044','0','2016-05-02 01:07:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('412','','1','Update','Warning','Modifico la orden: 1044','0','2016-05-02 01:07:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('413','','1','Update','Warning','Modifico la orden: 1044','0','2016-05-02 01:07:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('414','','1','Update','Warning','Modifico la orden: 1044','0','2016-05-02 01:07:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('415','','1','Update','Warning','Modifico la orden: 1044','0','2016-05-02 01:08:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('416','','1','Update','Warning','Modifico la orden: 1044','0','2016-05-02 01:08:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('417','','1','Create','Success','Creo el cliente: Rosa Acher','0','2016-05-05 00:16:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('418','','1','Create','Success','Creo la orden: ','0','2016-05-05 00:17:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('419','','1','Update','Warning','Modifico la orden: 1045','0','2016-05-05 00:18:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('420','','1','Update','Warning','Modifico la orden: 1045','0','2016-05-05 00:20:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('421','','1','Update','Warning','Modifico la orden: 1045','0','2016-05-05 00:20:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('422','','1','Update','Warning','Modifico la orden: 1045','0','2016-05-05 00:20:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('423','','1','Update','Warning','Modifico la orden: 1045','0','2016-05-05 00:20:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('424','','1','Create','Success','Creo el cliente: Gladys Mena','0','2016-05-07 15:25:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('425','','1','Create','Success','Creo la orden: ','0','2016-05-07 15:30:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('426','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:31:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('427','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:36:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('428','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:36:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('429','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:52:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('430','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:53:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('431','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:53:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('432','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:53:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('433','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:53:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('434','','1','Update','Warning','Modifico la orden: 1046','0','2016-05-07 15:53:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('435','','1','Create','Success','Creo el cliente: Mariela Camino','0','2016-05-12 01:41:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('436','','1','Create','Success','Creo la orden: ','0','2016-05-12 01:45:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('437','','1','Update','Warning','Modifico la orden: 1047','0','2016-05-12 01:47:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('438','','1','Update','Warning','Modifico la orden: 1047','0','2016-05-12 01:48:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('439','','1','Update','Warning','Modifico la orden: 1047','0','2016-05-12 01:48:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('440','','1','Create','Success','Creo la orden: ','0','2016-05-12 02:06:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('441','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-12 02:07:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('442','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-12 02:07:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('443','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-12 02:07:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('444','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-12 02:08:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('445','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-12 02:08:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('446','','1','Update','Warning','Modifico la orden: 1047','0','2016-05-17 01:17:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('447','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-18 01:39:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('448','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-18 01:40:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('449','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-18 01:40:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('450','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-18 01:40:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('451','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-18 01:40:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('452','','1','Update','Warning','Modifico la orden: 1048','0','2016-05-18 01:41:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('453','','1','Update','Warning','Modifico el usuario: admin','0','2016-05-27 22:51:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('454','','1','Update','Warning','Modifico el usuario: admin','0','2016-05-27 22:51:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('455','','1','Update','Warning','Modifico la orden: 1047','0','2016-06-01 04:09:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('456','','1','Update','Warning','Modifico la orden: 1047','0','2016-06-01 04:10:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('457','','1','Update','Warning','Modifico la orden: 1047','0','2016-06-01 04:11:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('458','','1','Update','Warning','Modifico la orden: 1047','0','2016-06-01 04:11:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('459','','1','Create','Success','Creo la orden: ','0','2016-06-03 20:26:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('460','','1','Update','Warning','Modifico la orden: 1049','0','2016-06-03 20:28:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('461','','1','Update','Warning','Modifico la orden: 1049','0','2016-06-03 20:28:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('462','','1','Create','Success','Creo la orden: ','0','2016-06-03 20:30:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('463','','1','Update','Warning','Modifico la orden: 1050','0','2016-06-03 20:30:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('464','','1','Update','Warning','Modifico la orden: 1050','0','2016-06-03 20:31:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('465','','1','Update','Warning','Modifico la orden: 1049','0','2016-06-03 20:32:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('466','','1','Update','Warning','Modifico la orden: 1049','0','2016-06-03 20:32:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('467','','1','Create','Success','Creo el cliente: Ana Pellatón','0','2016-06-07 01:45:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('468','','1','Create','Success','Creo la orden: ','0','2016-06-07 01:52:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('469','','1','Update','Warning','Modifico la orden: 1051','0','2016-06-07 01:54:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('470','','1','Create','Success','Creo la orden: ','0','2016-06-15 02:05:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('471','','1','Update','Warning','Modifico la orden: 1052','0','2016-06-15 02:07:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('472','','1','Create','Success','Creo la orden: ','0','2016-07-01 19:33:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('473','','1','Delete','Error','Elimino la orden: 1053','0','2016-07-01 19:35:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('474','','1','Create','Success','Creo la orden: ','0','2016-07-01 19:37:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('475','','1','Update','Warning','Modifico la orden: 1054','0','2016-07-01 19:39:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('476','','1','Update','Warning','Modifico la orden: 1054','0','2016-07-01 19:43:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('477','','1','Update','Warning','Modifico la orden: 1054','0','2016-07-01 19:44:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('478','','1','Create','Success','Creo la orden: ','0','2016-07-08 02:24:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('479','','1','Update','Warning','Modifico la orden: 1055','0','2016-07-08 02:24:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('480','','1','Update','Warning','Modifico la orden: 1055','0','2016-07-08 03:09:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('481','','1','Create','Success','Creo la orden: ','0','2016-07-08 03:10:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('482','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-08 03:11:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('483','','1','Create','Success','Creo el cliente: Gonzalo Mendez','0','2016-07-08 03:12:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('484','','1','Create','Success','Creo la orden: ','0','2016-07-08 03:14:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('485','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-12 01:14:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('486','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-12 01:16:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('487','','1','Create','Success','Creo el cliente: Guillermo Rivero','0','2016-07-12 02:52:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('488','','1','Create','Success','Creo la orden: ','0','2016-07-12 02:53:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('489','','1','Update','Warning','Modifico la orden: 1058','0','2016-07-12 02:53:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('490','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-15 00:09:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('491','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-15 00:09:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('492','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-15 00:09:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('493','','1','Update','Warning','Modifico la orden: 1057','0','2016-07-18 02:46:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('494','','1','Create','Success','Creo el cliente: Yanet Barreiro','0','2016-07-18 16:06:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('495','','1','Create','Success','Creo la orden: ','0','2016-07-18 16:07:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('496','','1','Update','Warning','Modifico la orden: 1059','0','2016-07-18 16:09:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('497','','1','Update','Warning','Modifico la orden: 1059','0','2016-07-18 16:10:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('498','','1','Update','Warning','Modifico la orden: 1052','0','2016-07-22 20:40:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('499','','1','Create','Success','Creo la orden: ','0','2016-07-22 21:25:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('500','','1','Update','Warning','Modifico la orden: 1060','0','2016-07-22 21:33:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('501','','1','Update','Warning','Modifico la orden: 1060','0','2016-07-22 21:34:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('502','','1','Update','Warning','Modifico la orden: 1060','0','2016-07-22 21:38:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('503','','1','Update','Warning','Modifico la orden: 1060','0','2016-07-22 21:59:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('504','','1','Update','Warning','Modifico la orden: 1046','0','2016-07-27 01:06:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('505','','1','Create','Success','Creo la orden: ','0','2016-07-27 01:09:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('506','','1','Update','Warning','Modifico la orden: 1014','0','2016-07-27 01:12:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('507','','1','Update','Warning','Modifico la orden: 1046','0','2016-07-27 01:21:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('508','','1','Create','Success','Creo la orden: ','0','2016-07-29 19:06:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('509','','1','Update','Warning','Modifico la orden: 1062','0','2016-07-29 19:07:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('510','','1','Update','Warning','Modifico la orden: 1056','0','2016-07-29 19:08:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('511','','1','Create','Success','Creo la orden: ','0','2016-08-28 01:11:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('512','','1','Update','Warning','Modifico la orden: 1063','0','2016-08-28 01:23:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('513','','1','Update','Warning','Modifico la orden: 1063','0','2016-08-28 02:51:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('514','','1','Update','Warning','Modifico la orden: 1063','0','2016-08-28 02:52:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('515','','1','Create','Success','Creo el cliente: Paola Muzzio','0','2016-08-28 02:55:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('516','','1','Create','Success','Creo la orden: ','0','2016-08-28 03:05:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('517','','1','Update','Warning','Modifico la orden: 1064','0','2016-08-28 03:09:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('518','','1','Update','Warning','Modifico la orden: 1064','0','2016-08-28 03:11:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('519','','1','Update','Warning','Modifico la orden: 1064','0','2016-08-28 03:12:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('520','','1','Update','Warning','Modifico la orden: 1064','0','2016-08-28 03:14:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('521','','1','Update','Warning','Modifico la orden: 1064','0','2016-08-28 03:14:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('522','','1','Create','Success','Creo la orden: ','0','2016-08-31 02:25:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('523','','1','Update','Warning','Modifico la orden: 1065','0','2016-08-31 02:25:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('524','','1','Update','Warning','Modifico la orden: 1065','0','2016-08-31 02:26:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('525','','1','Create','Success','Creo la orden: ','0','2016-08-31 02:30:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('526','','1','Update','Warning','Modifico la orden: 1066','0','2016-08-31 02:31:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('527','','1','Update','Warning','Modifico la orden: 1066','0','2016-08-31 02:31:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('528','','1','Update','Warning','Modifico la orden: 1066','0','2016-08-31 02:31:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('529','','1','Create','Success','Creo el cliente: Maria Victoria Diaz','0','2016-09-04 20:00:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('530','','1','Create','Success','Creo la orden: ','0','2016-09-04 20:00:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('531','','1','Update','Warning','Modifico la orden: 1067','0','2016-09-04 20:01:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('532','','1','Create','Success','Creo el cliente: Fernanda Cardozo','0','2016-09-07 03:22:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('533','','1','Update','Warning','Modifico el cliente: Fernanda Cardozo','0','2016-09-07 03:23:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('534','','1','Create','Success','Creo la orden: ','0','2016-09-07 03:24:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('535','','1','Update','Warning','Modifico la orden: 1068','0','2016-09-07 03:30:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('536','','1','Update','Warning','Modifico la orden: 1068','0','2016-09-07 03:30:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('537','','1','Update','Warning','Modifico la orden: 1068','0','2016-09-07 03:32:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('538','','1','Update','Warning','Modifico la orden: 1068','0','2016-09-07 03:38:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('539','','1','Create','Success','Creo la orden: ','0','2016-09-15 03:30:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('540','','1','Update','Warning','Modifico la orden: 1069','0','2016-09-15 03:33:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('541','','1','Update','Warning','Modifico la orden: 1069','0','2016-09-15 12:22:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('542','','1','Create','Success','Creo el cliente: Guillermina  Suarez','0','2016-09-17 12:16:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('543','','1','Create','Success','Creo la orden: ','0','2016-09-17 12:18:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('544','','1','Update','Warning','Modifico la orden: 1070','0','2016-09-17 12:19:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('545','','1','Update','Warning','Modifico la orden: 1070','0','2016-09-17 12:20:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('546','','1','Create','Success','Creo el cliente: Leonardo Girona','0','2016-09-19 23:00:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('547','','1','Create','Success','Creo el cliente: Guillermo Ifrán','0','2016-09-19 23:01:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('548','','1','Create','Success','Creo la orden: ','0','2016-09-19 23:02:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('549','','1','Update','Warning','Modifico la orden: 1071','0','2016-09-19 23:07:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('550','','1','Create','Success','Creo la marca: Gateway','0','2016-09-19 23:17:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('551','','1','Create','Success','Creo la marca: Dell','0','2016-09-19 23:17:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('552','','1','Create','Success','Creo la orden: ','0','2016-09-19 23:19:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('553','','1','Update','Warning','Modifico la orden: 1072','0','2016-09-19 23:25:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('554','','1','Update','Warning','Modifico la orden: 1072','0','2016-09-19 23:25:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('555','','1','Create','Success','Creo el cliente: Rodrigo Perez','0','2016-09-22 02:34:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('556','','1','Create','Success','Creo la orden: ','0','2016-09-22 02:35:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('557','','1','Update','Warning','Modifico la orden: 1073','0','2016-09-22 02:40:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('558','','1','Update','Warning','Modifico la orden: 1073','0','2016-09-22 02:41:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('559','','1','Update','Warning','Modifico la orden: 1069','0','2016-09-22 02:46:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('560','','1','Create','Success','Creo la orden: ','0','2016-09-28 11:49:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('561','','1','Update','Warning','Modifico la orden: 1074','0','2016-09-28 11:49:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('562','','1','Create','Success','Creo el cliente: Washinton Lima','0','2016-10-11 00:34:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('563','','1','Create','Success','Creo la orden: ','0','2016-10-11 00:35:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('564','','1','Update','Warning','Modifico la orden: 1075','0','2016-10-11 00:39:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('565','','1','Create','Success','Creo el cliente: Sofia Meroni','0','2016-10-18 23:36:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('566','','1','Create','Success','Creo la orden: ','0','2016-10-18 23:38:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('567','','1','Update','Warning','Modifico la orden: 1076','0','2016-10-18 23:40:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('568','','1','Update','Warning','Modifico la orden: 1076','0','2016-10-18 23:41:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('569','','1','Create','Success','Creo el cliente: Estudio Reyes Lavega','0','2016-10-21 02:04:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('570','','1','Create','Success','Creo la orden: ','0','2016-10-21 02:04:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('571','','1','Update','Warning','Modifico la orden: 1077','0','2016-10-21 02:18:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('572','','1','Update','Warning','Modifico la orden: 1077','0','2016-10-21 02:18:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('573','','1','Update','Warning','Modifico la orden: 1077','0','2016-10-21 02:19:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('574','','1','Create','Success','Creo el cliente: Monica Bonilla','0','2016-11-04 00:16:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('575','','1','Create','Success','Creo la orden: ','0','2016-11-04 00:17:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('576','','1','Create','Success','Creo el cliente: Alejandra Matarredona','0','2016-11-04 00:18:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('577','','1','Create','Success','Creo la orden: ','0','2016-11-04 00:20:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('578','','1','Create','Success','Creo la orden: ','0','2016-11-04 00:24:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('579','','1','Update','Warning','Modifico la orden: 1080','0','2016-11-05 00:02:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('580','','1','Update','Warning','Modifico la orden: 1080','0','2016-11-05 00:02:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('581','','1','Update','Warning','Modifico la orden: 1080','0','2016-11-05 00:02:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('582','','1','Update','Warning','Modifico la orden: 1079','0','2016-11-08 03:31:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('583','','1','Update','Warning','Modifico la orden: 1079','0','2016-11-08 03:32:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('584','','1','Update','Warning','Modifico la orden: 1079','0','2016-11-08 03:32:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('585','','1','Update','Warning','Modifico la orden: 1079','0','2016-11-08 03:33:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('586','','1','Update','Warning','Modifico la orden: 1079','0','2016-11-08 03:33:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('587','','1','Update','Warning','Modifico la orden: 1079','0','2016-11-08 03:33:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('588','','1','Update','Warning','Modifico la orden: 1078','0','2016-11-10 01:36:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('589','','1','Update','Warning','Modifico la orden: 1078','0','2016-11-10 01:37:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('590','','1','Create','Success','Creo el cliente: Comision Fomento Villa Sarandi','0','2016-11-16 16:38:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('591','','1','Create','Success','Creo la orden: ','0','2016-11-16 16:38:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('592','','1','Update','Warning','Modifico la orden: 1081','0','2016-11-16 16:41:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('593','','1','Update','Warning','Modifico la orden: 1081','0','2016-11-16 16:42:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('594','','1','Create','Success','Creo la orden: ','0','2016-11-18 16:47:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('595','','1','Update','Warning','Modifico la orden: 1082','0','2016-11-18 16:50:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('596','','1','Update','Warning','Modifico la orden: 1082','0','2016-11-18 16:51:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('597','','1','Create','Success','Creo el cliente: Maria Isabel Gandini','0','2016-12-01 18:14:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('598','','1','Update','Warning','Modifico el cliente: Maria Isabel Gandini','0','2016-12-01 18:16:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('599','','1','Create','Success','Creo la orden: ','0','2016-12-04 19:45:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('600','','1','Update','Warning','Modifico la orden: 1083','0','2016-12-04 19:47:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('601','','1','Update','Warning','Modifico la orden: 1083','0','2016-12-04 19:48:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('602','','1','Create','Success','Creo la orden: ','0','2016-12-09 23:21:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('603','','1','Update','Warning','Modifico la orden: 1084','0','2016-12-09 23:27:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('604','','1','Update','Warning','Modifico la orden: 1084','0','2016-12-09 23:27:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('605','','1','Create','Success','Creo el cliente: Walter Chiruzzo','0','2016-12-19 16:51:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('606','','1','Create','Success','Creo la orden: ','0','2016-12-19 16:53:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('607','','1','Update','Warning','Modifico la orden: 1085','0','2016-12-19 16:54:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('608','','1','Create','Success','Creo el cliente: Alejandro Silva','0','2016-12-20 02:40:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('609','','1','Create','Success','Creo la orden: ','0','2016-12-20 02:41:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('610','','1','Update','Warning','Modifico la orden: 1086','0','2016-12-20 02:51:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('611','','1','Update','Warning','Modifico la orden: 1086','0','2016-12-20 02:51:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('612','','1','Update','Warning','Modifico la orden: 1086','0','2016-12-20 02:53:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('613','','1','Update','Warning','Modifico la orden: 1086','0','2016-12-20 02:53:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('614','','1','Create','Success','Creo la orden: ','0','2016-12-20 02:56:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('615','','1','Update','Warning','Modifico la orden: 1087','0','2016-12-20 02:59:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('616','','1','Update','Warning','Modifico la orden: 1087','0','2016-12-20 03:00:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('617','','1','Create','Success','Creo el cliente: Santiago Scattone','0','2016-12-30 19:38:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('618','','1','Create','Success','Creo la orden: ','0','2016-12-30 19:39:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('619','','1','Update','Warning','Modifico la orden: 1088','0','2016-12-30 19:43:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('620','','1','Update','Warning','Modifico la orden: 1088','0','2016-12-30 19:43:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('621','','1','Create','Success','Creo el cliente: Dairi','0','2017-01-04 01:27:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('622','','1','Create','Success','Creo la orden: ','0','2017-01-04 01:28:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('623','','1','Update','Warning','Modifico la orden: 1089','0','2017-01-04 01:31:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('624','','1','Create','Success','Creo el cliente: Fabián Gardalina','0','2017-01-16 16:46:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('625','','1','Create','Success','Creo la orden: ','0','2017-01-16 16:47:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('626','','1','Update','Warning','Modifico la orden: 1090','0','2017-01-16 16:50:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('627','','1','Update','Warning','Modifico la orden: 1090','0','2017-01-16 16:50:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('628','','1','Create','Success','Creo la orden: ','0','2017-01-30 23:37:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('629','','1','Update','Warning','Modifico la orden: 1091','0','2017-01-30 23:39:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('630','','1','Update','Warning','Modifico la orden: 1091','0','2017-01-30 23:40:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('631','','1','Create','Success','Creo la orden: ','0','2017-01-30 23:43:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('632','','1','Update','Warning','Modifico la orden: 1092','0','2017-01-30 23:48:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('633','','1','Update','Warning','Modifico la orden: 1092','0','2017-01-30 23:48:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('634','','1','Create','Success','Creo la orden: ','0','2017-02-03 19:49:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('635','','1','Update','Warning','Modifico la orden: 1093','0','2017-02-03 19:50:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('636','','1','Create','Success','Creo el cliente: Pablo Arévalo','0','2017-02-03 19:53:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('637','','1','Create','Success','Creo la orden: ','0','2017-02-03 19:54:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('638','','1','Update','Warning','Modifico la orden: 1094','0','2017-02-03 19:59:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('639','','1','Update','Warning','Modifico la orden: 1094','0','2017-02-03 19:59:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('640','','1','Update','Warning','Modifico la orden: 1094','0','2017-02-05 15:38:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('641','','1','Create','Success','Creo la orden: ','0','2017-03-02 02:08:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('642','','1','Update','Warning','Modifico la orden: 1095','0','2017-03-02 02:09:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('643','','1','Update','Warning','Modifico la orden: 1095','0','2017-03-02 02:10:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('644','','1','Create','Success','Creo la orden: ','0','2017-03-13 23:50:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('645','','1','Update','Warning','Modifico la orden: 1096','0','2017-03-13 23:53:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('646','','1','Update','Warning','Modifico la orden: 1096','0','2017-03-13 23:53:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('647','','1','Create','Success','Creo el cliente: Luiselena Mesias','0','2017-03-17 21:41:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('648','','1','Create','Success','Creo la orden: ','0','2017-03-17 21:42:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('649','','1','Update','Warning','Modifico la orden: 1097','0','2017-03-17 21:45:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('650','','1','Update','Warning','Modifico la orden: 1097','0','2017-03-17 21:45:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('651','','1','Create','Success','Creo el cliente: Rosalia Alvez','0','2017-03-24 01:31:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('652','','1','Create','Success','Creo la orden: ','0','2017-03-24 01:33:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('653','','1','Update','Warning','Modifico la orden: 1098','0','2017-03-24 01:38:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('654','','1','Update','Warning','Modifico la orden: 1098','0','2017-03-24 01:38:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('655','','1','Create','Success','Creo la orden: ','0','2017-03-24 01:40:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('656','','1','Update','Warning','Modifico la orden: 1099','0','2017-03-24 01:46:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('657','','1','Update','Warning','Modifico la orden: 1099','0','2017-03-24 01:46:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('658','','1','Create','Success','Creo el cliente: Andrea Balduzzo','0','2017-03-24 02:38:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('659','','1','Create','Success','Creo la orden: ','0','2017-03-24 02:40:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('660','','1','Update','Warning','Modifico la orden: 1100','0','2017-03-24 02:44:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('661','','1','Update','Warning','Modifico la orden: 1100','0','2017-03-24 02:44:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('662','','1','Create','Success','Creo el cliente: Rosicler Severo','0','2017-03-31 23:57:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('663','','1','Create','Success','Creo la orden: ','0','2017-03-31 23:58:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('664','','1','Update','Warning','Modifico la orden: 1101','0','2017-04-01 00:07:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('665','','1','Update','Warning','Modifico la orden: 1101','0','2017-04-01 00:07:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('666','','1','Update','Warning','Modifico la orden: 1101','0','2017-04-01 00:07:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('667','','1','Update','Warning','Modifico la orden: 1101','0','2017-04-01 00:07:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('668','','1','Update','Warning','Modifico la orden: 1101','0','2017-04-01 00:08:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('669','','1','Create','Success','Creo la orden: ','0','2017-04-03 13:36:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('670','','1','Update','Warning','Modifico la orden: 1102','0','2017-04-03 13:39:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('671','','1','Update','Warning','Modifico la orden: 1102','0','2017-04-03 13:39:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('672','','1','Update','Warning','Modifico la orden: 1102','0','2017-04-03 13:41:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('673','','1','Update','Warning','Modifico la orden: 1102','0','2017-04-03 13:41:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('674','','1','Update','Warning','Modifico la orden: 1102','0','2017-04-03 16:50:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('675','','1','Create','Success','Creo la orden: ','0','2017-04-06 12:15:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('676','','1','Update','Warning','Modifico la orden: 1103','0','2017-04-06 12:19:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('677','','1','Update','Warning','Modifico la orden: 1103','0','2017-04-06 12:19:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('678','','1','Update','Warning','Modifico la orden: 1103','0','2017-04-06 12:21:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('679','','1','Create','Success','Creo la orden: ','0','2017-04-28 17:16:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('680','','1','Update','Warning','Modifico la orden: 1104','0','2017-04-28 17:23:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('681','','1','Create','Success','Creo la orden: ','0','2017-04-28 17:25:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('682','','1','Update','Warning','Modifico la orden: 1105','0','2017-04-28 17:26:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('683','','1','Update','Warning','Modifico la orden: 1105','0','2017-04-28 17:26:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('684','','1','Create','Success','Creo el cliente: Ligia Bacchetta','0','2017-05-02 18:26:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('685','','1','Create','Success','Creo la orden: ','0','2017-05-02 20:30:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('686','','1','Update','Warning','Modifico la orden: 1106','0','2017-05-02 20:37:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('687','','1','Update','Warning','Modifico la orden: 1106','0','2017-05-02 20:41:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('688','','1','Update','Warning','Modifico la orden: 1106','0','2017-05-02 20:42:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('689','','1','Update','Warning','Modifico la orden: 1106','0','2017-05-02 20:43:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('690','','1','Update','Warning','Modifico la orden: 1106','0','2017-05-02 21:52:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('691','','1','Update','Warning','Modifico el cliente: Ligia Bacchetta','0','2017-05-02 21:54:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('692','','1','Update','Warning','Modifico la orden: 1106','0','2017-05-02 21:54:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('693','','1','Create','Success','Creo la orden: ','0','2017-05-04 02:13:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('694','','1','Update','Warning','Modifico la orden: 1107','0','2017-05-04 02:18:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('695','','1','Create','Success','Creo la orden: ','0','2017-05-05 16:45:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('696','','1','Update','Warning','Modifico la orden: 1108','0','2017-05-05 16:46:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('697','','1','Update','Warning','Modifico la orden: 1108','0','2017-05-05 16:46:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('698','','1','Create','Success','Creo el cliente: Franca Pizzorno','0','2017-05-29 21:24:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('699','','1','Create','Success','Creo la orden: ','0','2017-05-29 21:28:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('700','','1','Update','Warning','Modifico la orden: 1109','0','2017-05-29 21:36:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('701','','1','Create','Success','Creo la orden: ','0','2017-06-14 17:07:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('702','','1','Update','Warning','Modifico la orden: 1110','0','2017-06-14 17:10:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('703','','1','Update','Warning','Modifico la orden: 1110','0','2017-06-14 19:00:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('704','','1','Update','Warning','Modifico la orden: 1110','0','2017-06-15 19:04:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('705','','1','Create','Success','Creo el cliente: DECOS','0','2017-06-28 16:35:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('706','','1','Create','Success','Creo la orden: ','0','2017-06-28 16:36:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('707','','1','Update','Warning','Modifico la orden: 1111','0','2017-06-28 16:38:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('708','','1','Create','Success','Creo la orden: ','0','2017-06-28 16:40:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('709','','1','Update','Warning','Modifico la orden: 1112','0','2017-06-28 16:42:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('710','','1','Create','Success','Creo el cliente: IMAN','0','2017-07-10 15:39:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('711','','1','Create','Success','Creo la orden: ','0','2017-07-10 15:40:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('712','','1','Update','Warning','Modifico la orden: 1113','0','2017-07-10 15:45:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('713','','1','Update','Warning','Modifico la orden: 1113','0','2017-07-10 15:45:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('714','','1','Create','Success','Creo la orden: ','0','2017-07-10 15:46:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('715','','1','Update','Warning','Modifico la orden: 1114','0','2017-07-10 15:49:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('716','','1','Create','Success','Creo la orden: ','0','2017-07-10 15:51:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('717','','1','Update','Warning','Modifico la orden: 1115','0','2017-07-10 15:53:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('718','','1','Create','Success','Creo la orden: ','0','2017-07-21 19:43:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('719','','1','Update','Warning','Modifico la orden: 1116','0','2017-07-21 19:51:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('720','','1','Create','Success','Creo la orden: ','0','2017-07-21 19:54:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('721','','1','Update','Warning','Modifico la orden: 1117','0','2017-07-21 19:55:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('722','','1','Create','Success','Creo el cliente: Matias Rodriguez','0','2017-07-25 00:43:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('723','','1','Create','Success','Creo la orden: ','0','2017-07-25 00:44:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('724','','1','Update','Warning','Modifico la orden: 1118','0','2017-07-25 00:47:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('725','','1','Create','Success','Creo la orden: ','0','2017-07-25 00:49:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('726','','1','Update','Warning','Modifico la orden: 1119','0','2017-07-25 00:55:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('727','','1','Update','Warning','Modifico la orden: 1119','0','2017-07-25 00:57:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('728','','1','Update','Warning','Modifico la orden: 1117','0','2017-07-25 01:00:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('729','','1','Update','Warning','Modifico la orden: 1117','0','2017-07-25 01:00:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('730','','1','Update','Warning','Modifico la orden: 1117','0','2017-07-25 01:00:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('731','','1','Update','Warning','Modifico la orden: 1117','0','2017-07-25 01:00:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('732','','1','Update','Warning','Modifico la orden: 1117','0','2017-07-25 01:01:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('733','','1','Create','Success','Creo el cliente: Romina Curbelo','0','2017-07-31 16:53:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('734','','1','Create','Success','Creo la orden: ','0','2017-07-31 16:56:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('735','','1','Update','Warning','Modifico la orden: 1120','0','2017-07-31 16:59:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('736','','1','Create','Success','Creo el cliente: Sarah Dodero','0','2017-09-18 23:11:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('737','','1','Create','Success','Creo la orden: ','0','2017-09-18 23:13:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('738','','1','Update','Warning','Modifico la orden: 1121','0','2017-09-18 23:15:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('739','','1','Update','Warning','Modifico la orden: 1121','0','2017-09-18 23:16:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('740','','1','Create','Success','Creo la orden: ','0','2017-10-01 23:40:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('741','','1','Update','Warning','Modifico la orden: 1122','0','2017-10-01 23:42:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('742','','1','Update','Warning','Modifico la orden: 1122','0','2017-10-01 23:43:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('743','','1','Update','Warning','Modifico la orden: 1122','0','2017-10-01 23:43:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('744','','1','Create','Success','Creo la orden: ','0','2017-10-09 14:41:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('745','','1','Update','Warning','Modifico la orden: 1123','0','2017-10-16 22:35:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('746','','1','Update','Warning','Modifico la orden: 1123','0','2017-10-16 22:36:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('747','','1','Create','Success','Creo el cliente: Silvia Pereira','0','2017-10-18 02:43:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('748','','1','Create','Success','Creo la orden: ','0','2017-10-20 14:45:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('749','','1','Update','Warning','Modifico la orden: 1124','0','2017-10-20 14:46:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('750','','1','Update','Warning','Modifico la orden: 1123','0','2017-10-24 03:43:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('751','','1','Create','Success','Creo la orden: ','0','2017-10-25 02:33:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('752','','1','Update','Warning','Modifico la orden: 1125','0','2017-10-25 02:47:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('753','','1','Update','Warning','Modifico la orden: 1125','0','2017-10-25 02:48:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('754','','1','Update','Warning','Modifico la orden: 1125','0','2017-10-25 02:48:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('755','','1','Create','Success','Creo la orden: ','0','2017-10-31 02:08:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('756','','1','Update','Warning','Modifico la orden: 1126','0','2017-10-31 02:47:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('757','','1','Update','Warning','Modifico la orden: 1126','0','2017-10-31 02:47:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('758','','1','Update','Warning','Modifico la orden: 1125','0','2017-10-31 03:03:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('759','','1','Update','Warning','Modifico la orden: 1126','0','2017-10-31 03:03:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('760','','1','Update','Warning','Modifico la orden: 1126','0','2017-10-31 03:03:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('761','','1','Create','Success','Creo la orden: ','0','2017-11-06 15:41:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('762','','1','Update','Warning','Modifico la orden: 1127','0','2017-11-06 15:44:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('763','','1','Update','Warning','Modifico la orden: 1127','0','2017-11-06 15:44:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('764','','1','Create','Success','Creo la orden: ','0','2017-11-06 15:45:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('765','','1','Update','Warning','Modifico la orden: 1128','0','2017-11-06 15:46:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('766','','1','Create','Success','Creo el cliente: Centro Monseñor Lasagna','0','2017-11-08 04:28:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('767','','1','Create','Success','Creo la orden: ','0','2017-11-08 04:29:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('768','','1','Update','Warning','Modifico la orden: 1129','0','2017-11-08 04:33:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('769','','1','Update','Warning','Modifico la orden: 1129','0','2017-11-08 04:33:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('770','','1','Create','Success','Creo el cliente: Mariela Tardaguila','0','2017-11-21 00:11:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('771','','1','Create','Success','Creo la orden: ','0','2017-11-21 00:13:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('772','','1','Update','Warning','Modifico la orden: 1130','0','2017-11-21 00:18:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('773','','1','Update','Warning','Modifico la orden: 1130','0','2017-11-21 00:19:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('774','','1','Update','Warning','Modifico la orden: 1130','0','2017-11-21 00:19:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('775','','1','Create','Success','Creo el cliente: Anibal Medina','0','2017-11-23 16:50:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('776','','1','Create','Success','Creo la orden: ','0','2017-11-23 16:51:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('777','','1','Update','Warning','Modifico la orden: 1131','0','2017-11-23 16:54:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('778','','1','Update','Warning','Modifico la orden: 1131','0','2017-11-23 16:54:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('779','','1','Update','Warning','Modifico la orden: 1131','0','2017-11-23 16:55:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('780','','1','Update','Warning','Modifico la orden: 1131','0','2017-11-23 16:55:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('781','','1','Create','Success','Creo la orden: ','0','2017-11-23 16:57:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('782','','1','Update','Warning','Modifico la orden: 1132','0','2017-11-23 16:58:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('783','','1','Update','Warning','Modifico la orden: 1132','0','2017-11-23 16:58:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('784','','1','Update','Warning','Modifico la orden: 1094','0','2017-12-13 16:37:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('785','','1','Create','Success','Creo la orden: ','0','2017-12-19 16:13:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('786','','1','Update','Warning','Modifico la orden: 1133','0','2017-12-19 16:16:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('787','','1','Update','Warning','Modifico la orden: 1133','0','2017-12-19 16:17:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('788','','1','Create','Success','Creo el cliente: Juan José Solari','0','2017-12-27 16:09:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('789','','1','Create','Success','Creo la orden: ','0','2017-12-27 16:09:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('790','','1','Update','Warning','Modifico la orden: 1134','0','2017-12-27 16:12:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('791','','1','Update','Warning','Modifico la orden: 1134','0','2017-12-27 16:12:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('792','','1','Create','Success','Creo el cliente: Federico Bolazzi','0','2017-12-29 19:59:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('793','','1','Create','Success','Creo la orden: ','0','2017-12-29 20:02:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('794','','1','Update','Warning','Modifico la orden: 1135','0','2017-12-29 20:06:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('795','','1','Update','Warning','Modifico la orden: 1135','0','2017-12-29 20:07:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('796','','1','Create','Success','Creo el cliente: Roberto Gil','0','2018-01-09 02:34:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('797','','1','Create','Success','Creo la orden: ','0','2018-01-09 02:36:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('798','','1','Update','Warning','Modifico la orden: 1136','0','2018-01-09 02:38:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('799','','1','Update','Warning','Modifico la orden: 1136','0','2018-01-09 02:38:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('800','','1','Update','Warning','Modifico la orden: 1136','0','2018-01-09 02:38:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('801','','1','Create','Success','Creo el cliente: TACURU','0','2018-01-09 02:42:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('802','','1','Create','Success','Creo la orden: ','0','2018-01-09 02:42:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('803','','1','Update','Warning','Modifico la orden: 1137','0','2018-01-09 02:48:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('804','','1','Update','Warning','Modifico la orden: 1137','0','2018-01-09 02:49:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('805','','1','Update','Warning','Modifico la orden: 1136','0','2018-01-09 02:49:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('806','','1','Update','Warning','Modifico la orden: 1136','0','2018-01-09 02:50:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('807','','1','Create','Success','Creo el cliente: Unpub S.A','0','2018-01-22 12:07:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('808','','1','Create','Success','Creo la orden: ','0','2018-01-22 13:32:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('809','','1','Update','Warning','Modifico la orden: 1138','0','2018-01-22 14:15:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('810','','1','Update','Warning','Modifico la orden: 1138','0','2018-01-22 14:15:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('811','','1','Update','Warning','Modifico la orden: 1138','0','2018-01-22 14:26:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('812','','1','Update','Warning','Modifico la orden: 1138','0','2018-01-22 14:26:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('813','','1','Create','Success','Creo la orden: ','0','2018-01-30 14:20:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('814','','1','Update','Warning','Modifico la orden: 1139','0','2018-01-30 14:28:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('815','','1','Update','Warning','Modifico la orden: 1139','0','2018-01-30 14:28:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('816','','1','Create','Success','Creo la orden: ','0','2018-02-05 16:14:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('817','','1','Update','Warning','Modifico la orden: 1140','0','2018-02-05 16:15:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('818','','1','Update','Warning','Modifico la orden: 1140','0','2018-02-05 16:15:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('819','','1','Create','Success','Creo la orden: ','0','2018-03-12 17:31:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('820','','1','Update','Warning','Modifico la orden: 1141','0','2018-03-12 17:34:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('821','','1','Create','Success','Creo el cliente: Bar Clavel','0','2018-03-21 15:29:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('822','','1','Create','Success','Creo la orden: ','0','2018-03-21 15:31:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('823','','1','Update','Warning','Modifico la orden: 1142','0','2018-03-21 15:33:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('824','','1','Update','Warning','Modifico la orden: 1142','0','2018-03-21 15:33:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('825','','1','Update','Warning','Modifico la orden: 1142','0','2018-03-21 15:33:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('826','','1','Update','Warning','Modifico la orden: 1142','0','2018-03-21 15:33:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('827','','1','Create','Success','Creo el cliente: Roberto Alonso','0','2018-03-22 23:12:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('828','','1','Create','Success','Creo la orden: ','0','2018-03-22 23:12:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('829','','1','Update','Warning','Modifico la orden: 1143','0','2018-03-22 23:14:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('830','','1','Update','Warning','Modifico la orden: 1143','0','2018-03-22 23:15:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('831','','1','Create','Success','Creo la orden: ','0','2018-04-11 17:06:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('832','','1','Update','Warning','Modifico la orden: 1144','0','2018-04-11 17:09:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('833','','1','Update','Warning','Modifico la orden: 1144','0','2018-04-11 17:53:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('834','','1','Create','Success','Creo la orden: ','0','2018-06-06 15:58:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('835','','1','Update','Warning','Modifico la orden: 1145','0','2018-06-06 16:00:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('836','','1','Update','Warning','Modifico la orden: 1145','0','2018-06-06 16:00:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('837','','1','Create','Success','Creo la orden: ','0','2018-06-06 16:03:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('838','','1','Update','Warning','Modifico la orden: 1146','0','2018-06-06 16:03:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('839','','1','Update','Warning','Modifico la orden: 1146','0','2018-06-06 16:03:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('840','','1','Update','Warning','Modifico la orden: 1145','0','2018-06-06 16:04:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('841','','1','Update','Warning','Modifico la orden: 1146','0','2018-06-06 16:10:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('842','','1','Update','Warning','Modifico la orden: 1145','0','2018-06-06 16:11:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('843','','1','Create','Success','Creo la orden: ','0','2018-06-06 23:10:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('844','','1','Update','Warning','Modifico la orden: 1147','0','2018-06-06 23:12:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('845','','1','Update','Warning','Modifico la orden: 1147','0','2018-06-06 23:13:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('846','','1','Create','Success','Creo el cliente: Andrea Gómez','0','2018-06-06 23:56:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('847','','1','Create','Success','Creo la orden: ','0','2018-06-06 23:57:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('848','','1','Update','Warning','Modifico la orden: 1148','0','2018-06-07 00:00:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('849','','1','Update','Warning','Modifico la orden: 1148','0','2018-06-07 00:01:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('850','','1','Update','Warning','Modifico el usuario: admin','0','2018-06-07 00:38:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('851','','1','Update','Warning','Modifico el usuario: admin','0','2018-06-07 00:39:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('852','','1','Update','Warning','Modifico el usuario: admin','0','2018-06-07 00:40:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('853','','1','Create','Success','Creo el cliente: Eloisa Gonzalez','0','2018-06-07 01:14:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('854','','1','Create','Success','Creo la orden: ','0','2018-06-07 01:16:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('855','','1','Update','Warning','Modifico la orden: 1149','0','2018-06-07 01:22:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('856','','1','Update','Warning','Modifico la orden: 1149','0','2018-06-07 01:25:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('857','','1','Update','Warning','Modifico la orden: 1149','0','2018-06-07 01:25:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('858','','1','Update','Warning','Modifico la orden: 1149','0','2018-06-07 02:21:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('859','','1','Create','Success','Creo la orden: ','0','2018-12-13 23:21:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('860','','1','Update','Warning','Modifico la orden: 1150','0','2018-12-13 23:22:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('861','','1','Update','Warning','Modifico la orden: 1150','0','2018-12-13 23:23:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('862','','1','Update','Warning','Modifico la orden: 1150','0','2018-12-13 23:23:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('863','','1','Update','Warning','Modifico la orden: 1150','0','2018-12-13 23:26:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('864','','1','Update','Warning','Modifico la orden: 1150','0','2018-12-13 23:28:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('865','','1','Update','Warning','Modifico la orden: 1150','0','2018-12-13 23:58:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('866','','1','Update','Warning','Modifico el cliente: Franca Pizzorno','0','2018-12-14 00:32:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('867','','1','Create','Success','Creo la orden: ','0','2018-12-14 00:35:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('868','','1','Update','Warning','Modifico la orden: 1151','0','2018-12-14 00:36:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('869','','1','Update','Warning','Modifico la orden: 1151','0','2018-12-14 00:37:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('870','','1','Update','Warning','Modifico la orden: 1151','0','2018-12-14 00:37:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('871','','1','Update','Warning','Modifico la orden: 1151','0','2018-12-14 00:37:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('872','','1','Create','Success','Creo el cliente: Mariana Bica','0','2018-12-14 02:08:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('873','','1','Create','Success','Creo la orden: ','0','2018-12-14 02:13:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('874','','1','Update','Warning','Modifico la orden: 1152','0','2018-12-14 02:15:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('875','','1','Update','Warning','Modifico la orden: 1152','0','2018-12-14 02:16:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('876','','1','Update','Warning','Modifico la orden: 1152','0','2018-12-14 02:16:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('877','','1','Create','Success','Creo el cliente: Giuliana Venturino','0','2018-12-14 03:02:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('878','','1','Create','Success','Creo la orden: ','0','2018-12-14 03:03:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('879','','1','Update','Warning','Modifico la orden: 1153','0','2018-12-14 03:06:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('880','','1','Update','Warning','Modifico la orden: 1153','0','2018-12-14 03:06:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('881','','1','Update','Warning','Modifico la orden: 1153','0','2018-12-14 03:07:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('882','','1','Update','Warning','Modifico la orden: 1153','0','2018-12-14 03:07:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('883','','1','Create','Success','Creo el cliente: Sonia Fernandez','0','2018-12-14 17:06:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('884','','1','Create','Success','Creo la orden: ','0','2018-12-14 17:07:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('885','','1','Update','Warning','Modifico la orden: 1154','0','2018-12-14 17:07:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('886','','1','Update','Warning','Modifico la orden: 1154','0','2018-12-14 17:07:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('887','','1','Update','Warning','Modifico la orden: 1154','0','2018-12-14 17:08:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('888','','1','Update','Warning','Modifico la orden: 1154','0','2018-12-14 17:08:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('889','','1','Create','Success','Creo la orden: ','0','2018-12-14 17:15:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('890','','1','Update','Warning','Modifico la orden: 1155','0','2018-12-14 17:17:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('891','','1','Update','Warning','Modifico la orden: 1155','0','2018-12-14 17:17:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('892','','1','Create','Success','Creo el cliente: Gloria','0','2018-12-14 17:24:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('893','','1','Create','Success','Creo la orden: ','0','2018-12-14 17:25:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('894','','1','Update','Warning','Modifico la orden: 1156','0','2018-12-14 17:30:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('895','','1','Update','Warning','Modifico la orden: 1156','0','2018-12-14 17:30:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('896','','1','Update','Warning','Modifico la orden: 1156','0','2018-12-14 17:31:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('897','','1','Update','Warning','Modifico el cliente: Gloria Dávila','0','2018-12-14 17:33:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('898','','1','Update','Warning','Modifico la orden: 1156','0','2018-12-14 17:34:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('899','','1','Create','Success','Creo la orden: ','0','2018-12-15 05:01:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('900','','1','Update','Warning','Modifico la orden: 1157','0','2018-12-15 05:04:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('901','','1','Update','Warning','Modifico la orden: 1157','0','2018-12-15 05:04:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('902','','1','Update','Warning','Modifico la orden: 1157','0','2018-12-15 05:04:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('903','','1','Create','Success','Creo el cliente: Alejandro Lorenzo','0','2018-12-30 21:44:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('904','','1','Create','Success','Creo la orden: ','0','2018-12-30 21:45:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('905','','1','Update','Warning','Modifico la orden: 1158','0','2018-12-30 21:47:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('906','','1','Update','Warning','Modifico la orden: 1158','0','2018-12-30 21:47:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('907','','1','Update','Warning','Modifico la orden: 1158','0','2018-12-30 21:48:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('908','','1','Create','Success','Creo el cliente: Juan Carlos Mateu','0','2019-01-18 05:22:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('909','','1','Create','Success','Creo la orden: ','0','2019-01-18 05:23:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('910','','1','Update','Warning','Modifico la orden: 1159','0','2019-01-18 05:28:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('911','','1','Update','Warning','Modifico la orden: 1159','0','2019-01-18 05:28:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('912','','1','Update','Warning','Modifico la orden: 1159','0','2019-01-18 05:29:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('913','','1','Create','Success','Creo el cliente: Cynthia Guedes','0','2019-01-19 16:18:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('914','','1','Create','Success','Creo la orden: ','0','2019-01-19 16:19:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('915','','1','Update','Warning','Modifico la orden: 1160','0','2019-01-19 16:23:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('916','','1','Update','Warning','Modifico la orden: 1160','0','2019-01-19 16:27:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('917','','1','Update','Warning','Modifico la orden: 1159','0','2019-01-19 16:30:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('918','','1','Create','Success','Creo la orden: ','0','2019-01-27 21:05:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('919','','1','Update','Warning','Modifico la orden: 1161','0','2019-01-27 21:09:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('920','','1','Update','Warning','Modifico la orden: 1161','0','2019-01-27 21:09:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('921','','1','Create','Success','Creo la orden: ','0','2019-02-13 02:24:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('922','','1','Update','Warning','Modifico la orden: 1162','0','2019-02-13 02:34:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('923','','1','Update','Warning','Modifico la orden: 1162','0','2019-02-13 02:34:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('924','','1','Update','Warning','Modifico la orden: 1162','0','2019-02-13 02:35:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('925','','1','Create','Success','Creo el cliente: CIAN','0','2019-02-13 02:42:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('926','','1','Create','Success','Creo la orden: ','0','2019-02-13 02:43:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('927','','1','Update','Warning','Modifico la orden: 1163','0','2019-02-13 02:56:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('928','','1','Update','Warning','Modifico la orden: 1163','0','2019-02-13 02:56:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('929','','1','Update','Warning','Modifico la orden: 1163','0','2019-02-13 02:56:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('930','','1','Create','Success','Creo el cliente: CARMEN DOMINGUEZ','0','2019-02-13 03:04:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('931','','1','Create','Success','Creo la orden: ','0','2019-02-13 03:04:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('932','','1','Update','Warning','Modifico la orden: 1164','0','2019-02-13 03:11:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('933','','1','Update','Warning','Modifico el cliente: Carmen Dominguez ','0','2019-02-13 03:12:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('934','','1','Update','Warning','Modifico la orden: 1164','0','2019-02-13 03:12:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('935','','1','Create','Success','Creo la orden: ','0','2019-04-06 22:29:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('936','','1','Update','Warning','Modifico la orden: 1165','0','2019-04-06 22:30:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('937','','1','Update','Warning','Modifico la orden: 1165','0','2019-04-06 22:30:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('938','','1','Create','Success','Creo el cliente: Juan Carlos Canessa','0','2008-03-11 06:16:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('939','','1','Create','Success','Creo la orden: ','0','2008-03-11 06:17:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('940','','1','Update','Warning','Modifico la orden: 1166','0','2008-03-11 06:26:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('941','','1','Update','Warning','Modifico la orden: 1166','0','2019-11-05 06:28:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('942','','1','Create','Success','Creo la orden: ','0','2019-11-05 06:33:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('943','','1','Update','Warning','Modifico la orden: 1167','0','2019-11-05 06:36:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('944','','1','Update','Warning','Modifico la orden: 1167','0','2019-11-05 06:36:47');



-- -------------------------------------------
-- TABLE DATA marcas
-- -------------------------------------------
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('1','HP');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('2','Toshiba');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('3','Olidata');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('4','Acer');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('5','MSI');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('6','Asus');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('7','Lenovo');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('8','Samsung');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('9','IBM');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('10','Gateway');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('11','MAC');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('12','Panavox');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('13','LG');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('14','BLU SENS');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('15','Otros');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('16','Sony');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('17','Gateway');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('18','Dell');



-- -------------------------------------------
-- TABLE DATA ordenes
-- -------------------------------------------
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1003','','8','2015-11-16','','','Equipo lento','El equipo se encuentra con el sistema operativo inestable. 
Notamos que cuenta con poca memoria RAM.
El adaptador wifi está fallando.

Se presupuestará ampliación de memoria RAM, reinstalación de sistema operativo y adaptador wifi.','Se amplia memoria RAM a 6 GB.
Instalamos sistema operativo y programas adicionales.
Sustituimos adaptador wifi, estuvo a prueba y funciona correctamente.','','Presupuesto','Reparado con Cargo','(Ninguna)','0','3');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1004','','9','2015-11-26','','','En ocasiones se apaga, no corren los juegos, chequear placa de video y realizar un mantenimiento general.
','El equipo se reinicia automáticamente, el sistema operativo se encuentra inestable, notamos que el sistema de refrigeración está obstruido por suciedad.
','Se realiza mantenimiento al sistema de refrigeración, actualizamos bios, reinstalamos sistema operativo y se migra información del usuario.
Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','4');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1005','','10','2015-11-26','','','No da señal de video, hace varios pitidos y no arranca.','El equipo se encuentra con un falso contacto en uno de los módulos de memoria ram. 
Su capacidad de memoria ram es de 1 GB, lo cual es muy poco para un funcionamiento óptimo.

','Se reconecta memoria ram, realizamos mantenimiento al sistema de refrigeración, actualizamos antivirus,  se hace limpieza de virus y corregimos errores en el sistema operativo. 

Estuvo a prueba y funciona correctamente','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1006','','11','2015-12-01','','','Testear, realizar respaldo de información y reinstalar sistema operativo con licencia Windows 7 Pro original del equipo.','El equipo posee bastante suciedad interna, se deberá realizar un mantenimiento al sistema de refrigeración.
','Se reinstala sistema operativo y se migra información del usuario.
Estuvo a prueba durante 48 hs y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1007','','12','2015-12-01','','','-','-','Costo de Mantenimiento Mensual.

$ 3500 + iva.','','Cliente abonado','Reparado con Cargo','(Ninguna)','0','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1009','','14','2015-12-10','','','Aleatoriamente se apaga o se reinicia sola.','','','','Presupuesto','Ingresado','(Ninguna)','0','5');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1010','','15','2015-12-16','','','No carga el sistema operativo.
Da rayas en la imagen.','','','','Presupuesto','Ingresado','(Ninguna)','0','6');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1011','','16','2015-12-21','2015-12-21','2015-12-21','Reinstalar sistema operativo con licencia windows 7 pro propia del equipo.
Realizar respaldo de información.','El equipo se encuentra con bastante suciedad interna, se debe realizar un mantenimiento al sistema de refrigeración.
Reinstalar sistema y realizar respaldo.','Se realiza mantenimiento al sistema de refrigeración, reinstalamos sistema operativo y migramos información.
Estuvo a prueba durante 48 hs y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1012','','17','2015-12-30','','','Instalación kit cámaras de seguridad','','','Venta e instalación kit de cámaras de seguridad.

Incluye: 1 DVR - 1 HDD Sata 1 TB - Monitor LCD AOC - Mouse - 3 Cámaras de Exterior - Mouse - Cables

Se instala y configura kit, acceso desde smartphone y grabación de las mismas.

Costo: $ 12500


Garantía : 6 meses','Presupuesto','Reparado con Cargo','(Ninguna)','0','7');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1013','','18','2015-12-30','2015-12-30','','Abono Mensual','','','Costo de mantenimiento mensual.

$ 3500 + iva','Cliente abonado','Reparado con Cargo','(Ninguna)','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1014','','19','2016-01-12','2016-01-12','2016-01-12','NO DA IMAGEN','','Se actualiza bios a la ultima versión disponible, y se corrigen errores en el sistema operativo.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.','','Presupuesto','Reparado con Cargo','Entregado','1','8');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1015','','20','2016-01-21','','','Equipo no da señal de video','El equipo se encuentra con una memoria ram dañada, notamos que el sistema operativo se encuentra inestable y que es necesario un mantenimiento al sistema de refrigeración.

Se presupuesta:
Módulo de memoria ram de 1 GB, reinstalación de sistema operativo y mantenimiento al sistema de refrigeración.','Se reemplaza módulo de memoria ram, reinstalamos sistema operativo y realizamos mantenimiento al sistema de refrigeración.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1700','Retirado','Presupuesto','En Reparación','(Ninguna)','1','9');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1016','','21','2016-01-24','','','Funciona lento, se le borraron todos los programas.','Se realizan testeos de hardware y no detectamos inconvenientes.

Reinstalaremos sistema operativo y programas adicionales.','Se reinstala sistema operativo Windows 7 y se migra información del usuario.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1017','','22','2016-01-24','2016-01-24','2016-01-24','Chequear,  aleatoriamente no enciende.
','Se realizan testeos de hardware y detectamos que el botón de encendido está dañado. Deberá ser reemplazado.
','Se reemplaza botón de encendido y se corrigen errores en el sistema operativo.

Estuvo a prueba durante 48 hs y funciona correctamente.','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1018','','23','2016-01-31','2016-01-31','2016-01-31','El equipo se encuentra lento y se tranca.','Se realizan testeos de hardware y detectamos que el disco duro se encuentra dañado.
Error de SMART.

Se presupuestará reemplazo de disco duro, instalación de sistema operativo y migración de la información.','Se sustituye disco duro, instalamos sistema operativo y programas adicionales.
Por último se migra información del usuario.
Estuvo a prueba y funciona correctamente.

Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','1','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1019','','24','2016-02-12','','','No funcionan los puertos HDMI','Debido a una descarga eléctrica se daño la placa principal, ésta se deberá reemplazar.

Se presupeustará reemplazo de placa principal.

Costo: $ 6470 + iva
','','Se presupeustará reemplazo de placa principal.

Costo: $ 6470 + iva','Presupuesto','Ingresado','(Ninguna)','0','12');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1020','','25','2016-02-17','','','Recalienta, realizar testeo general.','Se realizan testeos de hardware y notamos que el equipo presenta exceso de temperatura.
Esto es debido a suciedad en el sistema de refrigeración y pasta reseca.
','Se realiza mantenimiento al sistema de refrigeración.
Estuvo a prueba durante 48 hs y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1021','','26','2016-02-17','','','Chequear, realizar respaldo e instalar Windows 7','Se realizan testeos de hardware y no presenta inconvenientes.

Es necesario actualizar el BIOS para Instalar Windows 7','Se actualiza Bios.
Instalamos sistema operativo Windows 7, Antivirus, Office, etc.
Migramos información del usuario.
Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','13');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1022','','27','2016-02-20','','','VENTA DE EQUIPO NUEVO','','Se vende equipo de las siguientes características:

Intel Atom D525 Dual Core /2 GB de RAM DDR3 Sodimm/ HDD Sata 250 GB/ DVD-RW/ Video Intel Graphics HD

Garantía: 90 días.','','Presupuesto','Reparado con Cargo','Entregado','1','14');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1023','','28','2016-02-23','2016-02-23','','No permite entrar a algunas paginas de internet.
El teclado está desconectado, funciona lenta.','El equipo posee el teclado desconectado.
Hemos notado inestabilidad en el sistema operativo.
Se recomienda ampliar memoria ram. Posee 1 GB, lo cual es limitado para un buen funcionamiento del Sistema.','Se conecta teclado, ampliamos memoria ram a 2 GB.
Instalamos sistema operativo Windows 7, Antivirus, Office, programas adicionales y migramos información del usuario.

Estuvo a prueba durante 48 hs y funciona correctamente.
Costo: $ 2600','','Presupuesto','Reparado con Cargo','Entregado','1','15');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1024','','29','2016-02-26','2016-02-26','2016-02-26','Mantenimiento Abonados.','','Costo de mantenimiento mensual

$ 4270 iva inc.','','Cliente abonado','Reparado con Cargo','(Ninguna)','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1025','','30','2016-03-08','','','No funciona puerto usb','','','','Presupuesto','Ingresado','(Ninguna)','0','1');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1026','','31','2016-03-08','2016-03-08','','Realizar cableado de red, aprox 30 mts.
Instalar swich, configurar access point e impresora de red.
','','Se realiza cableado de dormitorio de bruno, exterior hasta dormitorio de Mauro.
Se configura impresora,access point y swich.

Costo: $3500 ','','Presupuesto','Reparado con Cargo','(Ninguna)','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1027','','32','2016-03-14','2016-03-14','','Disco Duro dañado




','Se realizan testeos de hardware, detectamos que el disco duro se encuentra dañado. Por otra parte el equipo posee bastante suciedad interna lo cual afecta al sistema de refrigeración.','Se sustituye disco duro proporcionado por el cliente, instalamos sistema operativo mas programas adicionales, migramos información del usuario y realizamos mantenimiento al sistema de refrigeración

Estuvo a prueba durante 48 hs y funciona correctamente. ','Costo $1500','Presupuesto','Reparado con Cargo','(Ninguna)','1','19');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1028','','33','2016-03-14','2016-03-14','','Hemos notado fallas en el sistema operativo.

','Se realizan diversos testeos de hardware y no presenta inconvenientes.','Se repara sistema operativo, estuvo a prueba y funciona ok.','Sin cargo','Presupuesto','Reparado sin Cargo','(Ninguna)','1','18');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1029','','34','2016-03-14','','','Chequeo general, poner a punto, no funciona wifi

 ',' El equipo posee el sistema operativo inestable, se deberá reinstalar.
Es necesario realizar un mantenimiento al sistema de refrigeración.
Placa wifi no funciona correctamente debido a la falta de su antena.
Recomendamos actualizar el procesador

','Se reinstala sistema operativo y programas adicionales, instalamos procesador Core 2 duo, realizamos mantenimiento al sistema de refrigeración e instalamos placa wifi usb.
Finalmente migramos información del usuario.

Estuvo a prueba y funciona correctamente. 

Costo: $ 2500','Instalación de sistema operativo, mantenimiento al sistema de refrigeración e instalación de placa wifi.

Costo : $ 2500','Presupuesto','Reparado con Cargo','Entregado','1','20');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1030','','35','2016-03-14','','','Chequear','El equipo se encuentra con el disco duro dañado, ','Se sustituye disco duro proporcionado por el cliente.
Clonamos información y actualizamos antivirus.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','22');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1031','','36','2016-03-17','2016-03-17','','El equipo se cuelga ni bien inicia.','Se realizan testeos de hardware , notamos que el disco duro se encuentra dañado, éste se deberá reemplazar.','Se sustituye disco duro proporcionado por el cliente.
Clonamos información y actualizamos antivirus.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','22');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1032','','37','2016-03-31','2016-03-31','','No enciende','El equipo se encuentra con un falso contacto en el botón de encendido.','Se repara falso contacto, estuvo a prueba y funciona correctamente. 

Sin costo.','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1033','','38','2016-03-31','2016-03-31','2016-03-31','Mantenimiento Mensual - Abonados.','','Costo de mantenimiento Mensual
Marzo 2016

$ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1034','','39','2016-03-31','2016-03-31','2016-03-31','No funcionan Algunas teclas del teclado, chequear si tiene virus, los puertos usb no funcionan.','Hemos realizado diversas pruebas, las teclas de subir volumen, aumentar o disminuir brillo funcionan ok.
El cliente deberá tener en cuenta que para activar el uso de las mismas se debe mantener pulsada la tecla \"FN\"
Los puertos usb todos han sido testeados y funcionan correctamente.
El touchpad se encuentra deshabilitado desde las teclas de función.
Hemos notado presencia de virus.','Se realiza limpieza de virus, habilitamos touch pad, realizamos diversas pruebas y funciona correctamente.

','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1035','','40','2016-04-11','','','El equipo no da señal de video, chequear.','','','','Presupuesto','Ingresado','(Ninguna)','0','');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1036','','41','2016-04-11','','2016-04-11','sdsd','','','','Presupuesto','Ingresado','Entregado','0','1');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1037','','42','2016-04-11','','','No da imagen, no incia.
Chequear.','El equipo se encuentra con un banco de memoria dañado,  
El sistema operativo contiene algunos errores.

Hemos notado que la capacidad del disco duro está casi completa por su información, lo cual genera lentitud de procesamiento.
','Se instala módulo de memoria ram de 2 GB en el zócalo operativo, se corrigen errores en el sistema operativo y se limpia registro de archivos temporales para liberar espacio en disco duro.
Estuvo a prueba y funciona correctamente.

Costo: $ 2500','','Presupuesto','Reparado con Cargo','Entregado','1','23');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1038','','43','2016-04-14','2016-04-14','2016-04-14','Instalar sistema operativo Windows 7, Antivirus y Office','El equipo fue comprado con 4 GB de memoria, el Bios reconoce solamente 2 GB, se deberá reclamar en garantía al lugar de compra.','Se instala sistema operativo, Office,  Antivirus y programas adicionales.
Migramos información respaldada.

Estuvo a prueba y funciona correctamente.

Costo: $ 1350','','Presupuesto','Reparado con Cargo','Entregado','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1039','','44','2016-04-14','2016-04-14','2016-04-14','VENTA DE EQUIPO','','Se vende equipo 
S/N: blgyn2j

DELL GX620
RAM 2 GB,/HDD 80 GB SAT/ PENTIUM D DUAL CORE/ W7

Garantía 6  meses.

Costo: $ 3000','','Presupuesto','Reparado con Cargo','Entregado','1','24');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1040','','45','2016-04-14','2016-04-14','2016-04-14','Chequear.','El equipo aleatorimente no emite señal de video.
La falla radica en la placa principal.
No justifica su reparación debido al alto costo.','Sin cargo.','','Presupuesto','Retiran sin Reparar','Entregado','1','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1041','','46','2016-04-14','','','Posible problema en placa de video, realizar chequeo general.','Se retira equipo para chequear en taller.
','','','Presupuesto','Ingresado','(Ninguna)','0','25');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1042','','47','2016-04-22','2016-04-22','2016-04-22','Chequear, no funcionan los puertos usb, migrar información del equipo viejo.','Se realizan testeos de hardware sin presentar inconvenientes.
Notamos que los puertos usb están hundidos.
El sistema operativo y algunos programas se encuentran muy desactualizados.
Hemos detectado varios virus los cuales afectan al funcionamiento del sistema operativo.','Se corrige posición de los puertos usb, realizamos limpieza de virus, desinstalamos toolbars.
Instalamos office 2010, Antivirus Avast Free, Adobe Reader DC, VLC Media Player.
Actualizamos sistema operativo y por último migramos información respaldada.
El precio incluye la venta de un cable VGA.

Costo: $1500','','Presupuesto','Reparado con Cargo','Entregado','1','26');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1043','','48','2016-04-22','2016-04-22','2016-04-22','No da señal de video.','El equipo se encuentra con el motherboard dañado.
No se justifica su reparación debido a que el hardware es muy antiguo.
','Sin cargo.','','Presupuesto','En Reparación','Entregado','1','26');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1044','','49','2016-05-02','2016-05-02','2016-05-02','Abono mensual y venta.','','Costo de Mantenimiento Mensual y venta de Access Pöint TP- Link Tl-wa701nd y Switch TP-Link de 5 puertos.

Costo: $ 5098 + iva
','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1045','','50','2016-05-05','2016-05-05','2016-05-05','No detecta el disco duro','Se realizan testeos de hardware y notamos que el disco duro se encuentra dañado.
Éste se deberá rememplazar..
','Se instala disco duro nuevo de 500 GB, instalamos sistema operativo y programas adicionales,
Antivirus, Office, etc.
Estuvo a prueba durante 48 hs y funciona correctamente.

Lamentablemente no es accesible a la información del disco dañado para poder migrarla.

 
Costo: $ 3800','','Presupuesto','Reparado con Cargo','Entregado','1','27');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1046','','51','2016-05-07','','','Posible Problema de Disco Duro','Se realizan diversas pruebas, y el disco duro se encuentra dañado.<br/>Se presupuestará el reemplazo del mismo.<br/>Notamos que el equipo posee bastante suciedad interna, lo cual afecta al sistema de refrigeración.','Se instala disco duro de 250GB, instalamos Windows 7 y programas adicionales.<br/>Realizamos mantenimiento al sistema de refrigeración.<br/>Estuvo a prueba y funciona Correctamente.<br/>Costo $2300<br/>Garantía 6 meses<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','28');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1047','','52','2016-05-12','','','Está lenta, algunos juegos no se pueden instalar, resetear password de windows.','Se realizan testeos de hardware, detectamos que el motherboard se encuentra dañado.<br/>Lamentablemente no se consigue el mism.  Se presupuestará Motherboard y Microprocesador I3.','Se instala Motherboard y Microprocesador Intel  I3, <br/>Configuramos sistema operativo de cero, instalamos juegos, antivirus y programas adicionales.<br/>Realizamos lubricación al fan de la fuente.<br/>Por último se migra información respaldada.<br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Costo: $ 3150<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','29');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1048','','53','2016-05-12','','','Está lento, se cuelga, chequear si tiene virus hacer limpieza.','Se realizan testos de hardware y hemos notado que un módulo de memoria se encuentra dañado.
Por otra parte el fan del microprocesador está suelto.
El equipo tiene software malicioso instalado, virus y toolbars que generan lentitud.','Se sujeta fan de microprocesador correctamente, colocamos módulo de memoria de 1 GB, Instalamos sistema operativo y programas adicionales.
Por úlitmo se migra información respaldada.
Estuvo a prueba y funciona correctamente.

Costo: $1300','','Presupuesto','En Reparación','Entregado','1','8');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1049','','54','2016-06-03','2016-06-03','2016-06-03','Mudar equipos de salón.','','Se vende Switch TP-LINK de 5 Bocas y Zapatilla para instalación de equipos en salón.<br/><br/>Costo: $ 742 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1050','','55','2016-06-03','2016-06-03','2016-06-03','','','Mantenimiento Mensual del Centro.<br/><br/>Costo: $ 3500 + iva.','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1051','','56','2016-06-07','2016-06-07','2016-06-07','No inicia, problema de teclado.
Chequear.','Se realizan diversas pruebas de hardware.<br/>El teclado se encuentra en corto, se deberá reemplazar.<br/>Hemos detectado inestabilidad en el sistema operativo y presencia de virus.','Se reemplaza teclado, instalamos sistema operativo y programas adicionales.<br/>Migramos información respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','1','30');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1052','','57','2016-06-15','','','No incia','El equipo sufrió un golpe.<br/>Presenta un corto en el motherboard, intentamos recuperarlo pero sin éxito.<br/>Se presupuestará reemplazo de motherboard.<br/><br/>Costo: $ 6500 ','Presupuesto rechazado.<br/>Costo de diagnóstico. $ 200','Link Ebay

http://www.ebay.com/itm/Asus-X401A-Intel-Motherboard-60-N3OMB1103-A05-31XJ1MB00N0-/381666201602?hash=item58dd141002:g:xzMAAOSwPc9Ww5y9','Presupuesto','Retiran sin Reparar','Entregado','1','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1054','','59','2016-07-01','','','','','Mantenimiento Mensual abonados<br/>Costo $3500 + IVA','','Cliente abonado','Ingresado','(Ninguna)','0','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1055','','60','2016-07-08','','','Chequear','Estamos realizando diversas pruebas..<br/>Hemos detectado hasta el momento que el equipo posee el disco duro dañado...<br/>','','','Cliente abonado','En Reparación','(Ninguna)','0','1');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1056','','61','2016-07-08','','','En ocasiones deja de dar señal de video.','El equipo presenta el motherboard dañado, se deberá reemplazar.<br/><br/>El costo del Motherboard es de $ 2477 + iva<br/>1 Año de garantía.<br/>* Mano de Obra no tiene costo - Cliente Abonado.<br/><br/>','Se reemplaza Motherboard, se mantiene a prueba y funciona correctamente.<br/><br/>Costo: $ 2477 + iva','El costo por reemplazo de Motherboard es de $ 2677 + iva
Motherboard Gigabyte GA-A55M-DS2 - Banifox','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1057','','62','2016-07-08','','','El equipo no da señal de video, posible problema en el chip de video.','El equipo presenta problemas en el chip de video.','Se recuperan pistas del chip de video, realizamos mantenimiento al sistema de refrigeración.<br/>Activamos windows, instalamos antivirus AVAST FREE y se realiza limpieza de virus.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','0','31');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1058','','63','2016-07-12','','','El equipo no emite señal de video','El equipo presenta el motherbaord dañado, se deberá reemplazar..','','','Presupuesto','En Reparación','(Ninguna)','0','32');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1059','','64','2016-07-18','2016-07-18','2016-07-18','El equipo aleatoriamente se apaga, chequear','Se realizan diversos testos de hardware.<br/>Hemos detectado la fuente de poder dañada y bastante suciedad interna, lo cual afecta al sistema de refrigeración generando recalentamiento y provocando apagados inesperados.','Se realiza mantenimiento al sistema de refrigeración, cambiamos fuente de poder, reparamos sistema operativo y se hace una limpieza profunda de virus.<br/>Estuvo a prueba y funciona correctamente. <br/><br/>Costo: $ 2000','','Presupuesto','Reparado con Cargo','Entregado','1','33');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1060','','65','2016-07-22','2016-07-22','2016-07-22','Problema con internet','El router se encuentra con las configuraciones de fábrica, Es necesario reconfigurarlo.<br/>Se ha detectado el cable que conecta el módem con el router en mal estado.<br/>','Se reconfigura router y se sustituye cable de red.<br/>Por seguridad se restringe con clave de acceso al mismo evitando así cambios en su configuración sin autorización previa.<br/><br/>Usuario y Clave para acceder al Router.<br/>Usuario: admin<br/>Contraseña: d4r50luc10n35<br/><br/>Garantía: 3 meses.<br/><br/>Costo: $ 1500<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1061','','66','2016-07-27','','','Posible problema de disco duro.','','','','Garantia Reparacion','Ingresado','(Ninguna)','0','28');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1062','','67','2016-07-29','2016-07-29','2016-07-29','Manteniminento','','Mantenimiento mensual Abonados.<br/><br/>Costo: $ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1063','','68','2016-08-28','','2016-08-28','Chequear, realizar mantenimiento general.','El equipo presenta el sistema operativo inestable. Es necesario realizar mantenimiento al sistema de refrigeración.<br/>Notamos que cuenta con poca memoria ram para un óptimo funcionamiento.<br/>Es necesario reparar plástico de bisagra, lo cual dificulta abrir y cerrar la tapa del equipo.','Se realiza mantenimiento al sistema de refrigeración. <br/>Reparamos plástico de bisagra.<br/>Ampliamos memoria ram a 6 GB, instalamos sistema operativo y programas adicionales, por último se migra información respaldada.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Costo: $ 3600 ','','Presupuesto','Reparado con Cargo','Entregado','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1064','','69','2016-08-28','2016-08-28','2016-08-28','Instalar Ubuntu, Corel y migrar información del equipo viejo.','El antivirus y office pre instalados son de prueba.<br/>Están obsoletos.','Se instala Ubuntu Ver 16.04, Instalamos Office 2010, Corel y Antivirus.<br/>Creamos partición en el disco duro llamada \" Datos \"<br/>Por último se migra información del equipo viejo.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1300<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','34');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1065','','70','2016-08-31','2016-08-31','2016-08-31','Mantenimiento','','Mantenimiento mensual abonados.<br/><br/>Costo: $ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1066','','71','2016-08-31','','2016-08-31','No da señal de video, hace 5 pitidos.','Se realizan testeos de hardware y notamos que el equipo presenta el microprocesador dañado.<br/>','Se sustituye microprocesador, estuvo a prueba y funciona correctamente.<br/><br/>El repuesto va en calidad de donación.<br/>Sin cargo.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1067','','72','2016-09-04','2016-09-04','','Venta de Notebook','','Se vende Notebook HP Compaq NC6320<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','1','35');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1068','','73','2016-09-07','2016-09-07','2016-09-07','El servidor se encuentra muy lento, chequear.','El equipo presenta el sistema de refrigeración obstruido por suciedad  y requiere mantenimiento. Ésto puede provocar recalentamiento, apagados inesperados e inclusive hasta daños en el propio hardware.<br/>El sistema operativo instalado es inestable y obsoleto. Cuenta con windows xp versión UE.<br/>Para su correcto funcionamiento como \" servidor \" es necesario al menos ampliar la memoria ram a 4 GB . sustituir el microprocesador celeron por un Core 2 Duo e instalar windows 7 pro.<br/><br/>','Se enviará por mail presupuesto por la reparación del mismo y por otras posibles soluciones.','','Presupuesto','Retiran sin Reparar','Entregado','1','36');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1069','','74','2016-09-15','','2016-09-15','Hace ruido el fan, chequear.','El equipo presenta soportes de bisagra de plástico dañados, los restos de plástico obstruyen el sistema de refrigeración.<br/>Notamos que es necesario realizar una limpieza de virus y mantenimiento al sistema operativo.','Se realiza reparación de plásticos de bisagra, mantenimiento al sistema de refrigeración.<br/><br/>Corregimos errores en el sistema operativo, realizamos limpieza de virus e instalamos antivirus avast free 2016.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2000','','Presupuesto','En Reparación','Entregado','0','31');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1070','','75','2016-09-17','','2016-09-17','Por momentos se dispara el cursor y se va al final de la hoja, han probado desabilitando el touchpad y la falla persiste.','Se realizan diversas pruebas de hardware y detectamos que el teclado se encuentra en corto.<br/>Es necesario reemplazarlo.','Se reemplaza teclado, se realizan pruebas respondiendo de manera satisfactoria.<br/><br/>Costo: $ 2580','','Cliente abonado','Reparado con Cargo','Entregado','1','37');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1071','','76','2016-09-19','2016-09-19','2016-09-19','Reinstalar sistema operativo.','Se testea todo el hardware del equipo satisfactoriamente.<br/>A pedido del cliente instalaremos sistema operativo Windows 7.','Se instala windows 7 pro y actualizaciones de seguridad.<br/>Instalamos Antivirus Avast Free, Office 2010, Reproductor VLC Media Player, Net Framework, Java, Winrar, etc.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Costo: $ 1350 ','','Presupuesto','Reparado con Cargo','Entregado','1','38');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1072','','77','2016-09-19','2016-09-19','2016-09-19','El equipo no termina de cargar el sistema operativo, ver la posibilidad de ampliar la memoria ram.','Se realizan testeos de hardware, notamos que el equipo cuenta con el disco duro dañado.<br/>Es necesario reemplazarlo.<br/>Se cotizará ampliación de memoria ram a 8 GB.','Se sustituye disco duro y se amplia memoria ram a 8 GB.<br/>Instalamos sistema operativo Windows 7 pro SP1, antivirus Avast Free, Office 2010, Corel X7 y programas adicionales.<br/>Por último se migra información recuperada del disco duro defectuoso.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Garantía: <br/>6 meses mano de obra.<br/>1 año memoria ram  y disco duro.<br/><br/>Costo: $ 5760<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','39');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1073','','78','2016-09-22','2016-09-22','2016-09-22','Puesta a punto Inicial','','Montaje, instalación y configuración de todo el equipamiento informático de la red DECOS.<br/><br/>Costo: U$S 850 + iva<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','40');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1074','','79','2016-09-28','2016-09-28','2016-09-28','','','Mantenimiento mensual abonados.<br/><br/>Costo: $ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1075','','80','2016-10-11','','2016-10-11','Chequear y actualizar.','Se realizan testeos de hardware sin presentar inconvenientes.<br/>El equipo cuenta con un sistema operativo obsoleto, <br/>Se recomienda actualizar a windows 7, para ello va a ser necesario ampliar memoria ram y reemplazar el disco duro por uno sata para un funcionamiento optimo.','Se reemplaza disco duro por un sata de 250 GB, ampliamos memoria ram a 2 GB y por último se instala windows 7 pro, antivirus, office, etc.<br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/>Garantía 6 meses.<br/><br/>Costo: $ 3200','','Presupuesto','Reparado con Cargo','Entregado','1','41');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1076','','81','2016-10-18','','','Chequear, está lenta, instalar programas, office, etc.','Se realizan diversas pruebas sin presentar inconvenientes.<br/>Hemos verificado y lamentablemente no se puede migrar a windows 7, no existen controladores homologados por hp para este modelo.<br/><br/>Se instalarán aplicaciones faltantes, office, antivirus, adobe reader, etc.','Se instala Office 2010, Antivirus, Adobe Reader DC y Do PDF.<br/><br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 800<br/><br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','1','42');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1077','','82','2016-10-21','2016-10-21','2016-10-21','Instalar Sistema Operativo y Configurar como servidor','Instalar Sistema Operativo Windows 7 y configurar como servidor.','Se instala Sistema Operativo, actualizaciones de Windows, controladores,  antivirus y cliente de acceso remoto, <br/>Creación del grupo de trabajo y carpetas compartidas.<br/>Configuramos Cobian Backup Gravity 11 para backup de compartidas.<br/>Migramos información del viejo servidor de archivos.<br/>Se incluyen todos los equipos de la red dentro del grupo de trabajo, unificamos antivirus e instalamos nuevo puesto de trabajo.<br/>Verificamos configuraciones de red de todos los dispositivos.<br/><br/>Costo: $ 5370 <br/>','','Presupuesto','Reparado con Cargo','Entregado','1','43');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1078','','83','2016-11-04','','','Chequear..','Se realizan diversos testeos de hardware, notamos que la fuente de poder se encuentra dañada.<br/>Por otra parte detectamos que  el sistema de refrigeración está obstruido por suciedad, su pasta disipadora está reseca.','Se reemplaza fuente de poder, se realiza mantenimiento al sistema de refrigeración, realizando una limpieza interna general e insertando nuevamente su pasta disipadora en el microprocesador.<br/><br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1900','','Presupuesto','Reparado con Cargo','Entregado','1','44');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1079','','84','2016-11-04','','','Chequear','El equipo emite señal de video sin brillo.<br/>Se realizan diversas pruebas de hardware y detectamos un fallo en el display.<br/>Notamos también que es necesario realizar un mantenimiento general, sistema de refrigeración, limpieza de sofware para liberar espacio en disco el cual se encuentra bastante lleno y provoca lentitud.','Se realiza mantenimiento general, limpieza de software, sistema de refrigeración y reparación de display (corto en tubo de iluminación).<br/>Por último se actualiza paquete de office y antivirus.<br/>Estuvo a prueba y funciona ok.<br/><br/>Garantía 90 días.<br/><br/>Costo: $ 2000','','Presupuesto','Reparado con Cargo','Entregado','1','45');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1080','','85','2016-11-04','','','Venta de equipo.

','','Venta de equipo.<br/><br/>Características:<br/><br/>Intel Pentium G2020 2.9 GHZ<br/>Ram: 8 GB<br/>HDD Sata 500 GB<br/>Motherboard Asrock B75M-GL<br/>Windows 7 Profesional<br/><br/>Garantía: 6 meses.<br/>Costo: $ 4500','','Presupuesto','Reparado con Cargo','(Ninguna)','0','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1081','','86','2016-11-16','2016-11-16','','Venta de equipo','','Venta e instalación de equipo.<br/>El mismo cuenta con las siguientes características:<br/>Dell Optiplex GX620/Pentium D/HDD 80 GB/DVD/W7<br/><br/>Garantía del equipo : 6 Meses<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','(Ninguna)','1','46');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1082','','87','2016-11-18','2016-11-18','','VENTA DE EQUIPO','','Venta de equipo.<br/><br/>Hp Elite 8000 - Serie: CZC04922PH<br/>Core 2 Duo E7500<br/>HDD 250 GB<br/>4 GB de RAM <br/>Windows 7 Pro.<br/>Garantía 1 año.<br/><br/>Se migra información del equipo antiguo.<br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1083','','88','2016-12-04','2016-12-04','2016-12-04','Chequear.','Se realizan diversas pruebas de hardware sin presentar inconvenientes.<br/>El sistema operativo está inestable, es recomendable realizar una reinstalación del mismo.<br/>A su vez recomendamos ampliar la memoria ram ya que cuenta con muy poca para un correcto funcionamiento.','Se amplia memoria ram a 4 GB, reinstalamos sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $2600','','Presupuesto','Reparado con Cargo','Entregado','1','47');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1084','','89','2016-12-09','2016-12-09','2016-12-09','No da señal de video','El equipo presenta falso contacto en el modulo de memoria ram.<br/>Notamos suciedad en sistema de refrigeración.<br/>El sistema operativo se encuentra inestable y posee aplicaciones de riesgo las cuales provocan lentitud en el sistema.','Se realiza mantenimiento al sistema de refrigeración, desinstalamos aplicaciones de riesgo y se realiza limpieza de virus.<br/>Por último se corrigen errores en el sistema operativo.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','6');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1085','','90','2016-12-19','2016-12-19','2016-12-19','NO ENCIENDE','Se realizan diversas pruebas y el dvr presenta la fuente de poder dañada.','Se sustituyen componentes dañados de fuente de poder.<br/>Realizamos una limpieza interna al dvr e instalamos correctamente su disco duro, el cual se encontraba suelto.<br/><br/>Costo: $ 1600','','Presupuesto','Reparado con Cargo','Entregado','1','48');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1086','','91','2016-12-20','2016-12-20','2016-12-20','No se conecta a internet','Se realizan testeos de hardware.<br/>Detectamos un fallo en el disco duro y presencia de virus.<br/>Va a ser necesario realizar un mantenimiento al sistema de refrigeración.','Se sustituye disco duro, <br/>Aplicamos imagen del sistema operativo limpio e instalamos programas adicionales, office, antivirus,etc.<br/>Migramos información respaldada.<br/>Por último se realiza mantenimiento al sistema de refrigeración.<br/><br/>Estuvo a prueba y funciona correctamente.<br/>Garantía: <br/>                    Mano de obra 3 meses.<br/>                    Repuesto 1 año.<br/><br/>Costo: $ 3540<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','49');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1087','','92','2016-12-20','2016-12-20','2016-12-20','No enciende.','Se realizan testeos de hardware.<br/>Detectamos que el equipo presenta un corto en su placa principal, no detecta entrada de corriente.<br/>','Se intenta recuperar placa principal pero lamentablemente sin éxito.<br/>El costo de éste repuesto es muy elevado y no justifica su reparación.<br/><br/>Se instala disco duro en bahía usb y se verifica integridad de los datos.<br/><br/>Costo: $ 1900','','Presupuesto','Retiran sin Reparar','Entregado','1','36');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1088','','93','2016-12-30','2016-12-30','','Instalación de sistema de video vigilancia.','','Se instala nuevo sistema de video vigilancia.<br/>Configuración: <br/>3 cámaras Linethink HD 720p exteriores. <br/>DVR Linethink 4 CH AHD.<br/>Fuente de poder 5A 12V.<br/>HDD 500 GB<br/><br/>Garantía: 6 meses.<br/><br/>Costo: $15900','','Presupuesto','Reparado con Cargo','(Ninguna)','1','50');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1089','','94','2017-01-04','2017-01-04','2017-01-04','Venta de Computadora','','Venta de Computadora<br/><br/>Amd AThlon X2 2.9 GHZ<br/>Ram 2 GB DDR3<br/>HDD 160 GB<br/>Opticos DVD<br/>Windows 8 Pro<br/><br/>Incluye teclado y mouse.<br/><br/>Garantía: 6 meses.<br/>La garantía no incluye servicio on-site.<br/><br/>Costo: $ 4000','','Presupuesto','Reparado con Cargo','Entregado','1','51');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1090','','95','2017-01-16','2017-01-16','2017-01-16','Chequear','Se realizan diversos testeos de hardware y detectamos que el disco duro se encuentra dañado.<br/>El equipo cuenta con poca memoria ram para un correcto funcionamiento del sistema operativo, se recomienda ampliar la memoria ram a 4 GB.','Se amplia memoria ram a 4 GB, se sustituye disco duro, se instala sistema operativo y porgramas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>** Lamentablemnte no es posible acceder a la información del disco duro viejo, ya que se encuentra muy dañado.<br/><br/>Costo: $ 3800','Garantía 3 meses mano de obra y 1 año repuestos - 16/01/16','Presupuesto','Reparado con Cargo','Entregado','1','52');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1091','','96','2017-01-30','2017-01-30','2017-01-30','Venta de Notebook','','Se vende Notebook Samsung 300V.<br/>INTEL I5/HDD 320 GB/RAM 4 GB/ 15.6\"/ WINDOWS 10<br/><br/>Garantía: 3 meses.<br/><br/>Costo: U$S 300 ','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1092','','97','2017-01-30','','','Venta de equipo','','SE VENDE EQUIPO HP ELITE 8200/INTEL I3/HDD 250GB/RAM 4GB/DVD-RW/W7 PRO<br/><br/>Migramos información del equipo viejo y se instalan programas adicionales.<br/><br/>Garantía 1 año.<br/><br/>Costo: U$S 300<br/><br/><br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1093','','98','2017-02-03','2017-02-03','2017-02-03','En ocasiones no enciende.','Se realizan diversos testeos de hardware y detectamos que la placa principal se encuentra dañada.','Se sustituye placa principal y micro procesador en garantía.<br/>Estuvo a prueba y funciona correctamente.<br/>Sin cargo.','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1094','','99','2017-02-03','2017-02-03','','Chequear.','Se realizan diversas pruebas y detectamos que la placa de video se encuentra dañada.<br/>Es necesario realizar un mantenimiento general al sistema de refrigeración y reinstalar el sistema operativo que se encuentra inestable.<br/>','Se realiza mantenimiento al sistema de refrigeración.<br/>Instalamos placa de video, quedando instalada una Geforce G210.<br/>Instalamos sistema operativo y programas adicionales.<br/>Por último migramos información respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3090 <br/>','','Presupuesto','Reparado con Cargo','Entregado','1','53');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1095','','100','2017-03-02','2017-03-02','','No inicia','El equipo presenta un falso contacto en modulo de memoria ram.','Se reconecta modulo de memoria ram, realizamos pruebas y funciona ok.<br/>Garantía de reparación.','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','29');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1096','','101','2017-03-13','','2017-03-13','No enciende','Se realizan diversos testos y detectamos que la placa principal se encuentra dañada.<br/>Deberá ser reemplazada.','Se sustituye placa principal.<br/>Realizamos diversas pruebas y funciona correctamente.<br/><br/>Costo: $1500<br/><br/>Garantía:<br/>Mano de obra 3 meses<br/>Repuesto:  3 Meses.','','Presupuesto','Reparado con Cargo','Entregado','1','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1097','','102','2017-03-17','','2017-03-17','Venta de equipo','','Se vende equipo Dell Latitude E6430<br/>Recertificado.<br/>S/N: 4XF49A01<br/><br/>Garantía: 1 Año.<br/>En el costo queda incluida visita técnica, migración de información y configuraciones.<br/><br/><br/>Costo: $12500','','Presupuesto','Reparado con Cargo','Entregado','0','54');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1098','','103','2017-03-24','2017-03-24','2017-03-24','Chequear','Se realizan diversos testeos de hardware.<br/>Notamos que el equipo presenta el disco duro dañado.<br/>También una de las bisagras de pantalla se encuentra dañada.<br/><br/>','Se reemplaza disco duro, <br/>Instalamos sistema operativo, office, antivirus, etc.<br/><br/>* Lamentablemente el disco duro antiguo se encuentra muy dañado, la información es inaccesible.<br/>No es posible migrar archivos antiguos.<br/><br/>Costo: $ 3800<br/><br/>Nota: <br/>Informamos al cliente que algunas teclas del teclado se encuentran dañadas, Tomamos los datos correspondientes del teclado por si mas adelante confirman realizar el cambio del mismo.<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','55');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1099','','104','2017-03-24','2017-03-24','2017-03-24','Chequear','Se realizan testos de hardware.<br/>Detectamos que presenta el disco duro dañado, deberá ser reemplazado.<br/>También es necesario realizar un mantenimiento al sistema de refrigeración.<br/>Cliente solicita volcado de información a 2 pendrives de 32 GB.<br/><br/>Costo del presupuesto: $ 3770<br/><br/>* Aceptan migración de información a  2 pendrives, quedando pendiente la reparación del equipo.<br/>','Se migra información a 2 pendrives de 32 GB.<br/><br/>Costo: $ 1500<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','55');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1100','','105','2017-03-24','2017-03-24','2017-03-24','Chequear, no conecta a internet.','Se realizan testeos de hardware.<br/>Detectamos que el disco duro se encuentra dañado, va a ser necesario su reemplazo.<br/>Por otra parte notamos que el equipo recalienta, esto es debido a obstrucción en el sistema de refrigeración.<br/>','Reemplazamos disco duro, instalamos sistema operativo, office, antivirus, etc.<br/>Se migra información del usuario.<br/>Por último se realiza mantenimiento al sistema de refrigeración.<br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/>Realizamos diversas pruebas de conexión a internet satisfactorias.<br/><br/>Costo: $ 3800','','Presupuesto','Reparado con Cargo','Entregado','1','56');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1101','','106','2017-03-31','2017-03-31','2017-03-31','No da imagen, revisar audio.','Se realizan diversos testeos. Detectamos que presenta 2 módulos de memoria dañados.<br/>Deberán ser reemplazados.<br/>Por otra parte identificamos un desperfecto en el panel frontal de audio y un corto en la salida trasera de audio. <br/>Por otra parte consideramos que es necesario realizar un mantenimiento al sistema de refrigeración.<br/><br/>','Se instalan 2 módulos de memoria ram de 1 GB.<br/>Instalamos placa de sonido.<br/>Realizamos mantenimiento al sistema de refrigeración.<br/>De modo preventivo se realiza comprobación de disco con chkdsk y se ejecuta analisis profundo en busca de virus.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2000<br/><br/>Garantía: 6 meses.','','Presupuesto','Reparado con Cargo','Entregado','1','57');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1102','','107','2017-04-03','2017-04-03','2017-04-03','No da imagen,.','Se realizan diversos testeos y detectamos un falso contacto en módulos de memoria.<br/>Hemos notado una versión muy desactualizada de bios.','Se reconectan módulos de memoria  y actualizamos bios.<br/>De modo preventivo se realiza comprobación de disco con chkdsk , se actualiza antivirus y se ejecuta analisis profundo en busca de virus.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $800<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','20');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1103','','108','2017-04-06','','','Visita Técnica ','','Se vende placa Wifi usb, 2 cables de corriente, un cable vga y mouse.<br/><br/>Se instala equipo físicamente y actualizamos antivirus.<br/>Se mantiene a prueba satisfactoriamente<br/>.Costo de Visita Técnica y Repuestos: $2655<br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','0','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1104','','109','2017-04-28','','','Mantenimiento Mensual','','Se detallan los repuestos venidos para  la reparación de 2 computadoras de escritorio.<br/>Incluida el costo de mantenimiento mensual del centro.<br/><br/>Detalle:<br/> <br/>2  Memorias DRR2 de 1GB - $ 480 + iva<br/>7 Cables de Corriente 3 en línea - 420 +iva<br/>1  HDD Sata 80 GB -  $ 350 + iva<br/>Mantenimiento Mensual Abonados - $ 3500 +<br/><br/>Total: $ 4750 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1105','','110','2017-04-28','2017-04-28','2017-04-28','Donación','Se entrega en calidad de donación 2 computadoras de escritorio.','Se entrega en calidad de donación 2 computadoras de escritorio.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1106','','111','2017-05-02','','','','','Se vende equipo Dell  1 año de Garantía<br/>Garantía de la Batería 6 meses<br/>Costo u$s 420<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','58');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1107','','112','2017-05-04','2017-05-04','2017-05-04','El equipo presenta problemas de audio.','Se realizan diversos testeos de hardware.<br/>Detectamos que presenta problemas de audio.<br/>La falla es provocada por la placa principal.<br/>El costo de reemplazo de la parte es muy costo por lo cual se ofrece una solución alternativa.','Se instala placa de audio usb y se vende parlante Logitech Z51.<br/>De modo preventivo se realiza un mantenimiento al sistema operativo, instalamos un nuevo antivirus dado que el anterior se encontraba obsoleto.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2200 ','','Presupuesto','Reparado con Cargo','Entregado','1','48');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1108','','114','2017-05-05','2017-05-05','2017-05-05','El equipo no se conecta a internet.','Se realizan diversos testeos de hardware sin presentar inconvenientes.<br/>Notamos que la falla es proveniente de un error en el sistema operativo. <br/>Deberá ser reinstalado.<br/>Hemos notado también que cuenta muy poca memoria ram.','Se instala sistema operativo y programas adicionales.<br/>Ampliamos memoria ram a 2 GB.<br/>Estuvo a prueba y funciona correctamente.<br/>','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1109','','115','2017-05-29','','','No funcionan los juegos del Facebook
Solicita cambiar idioma de Ingles a Español
','Se realizan testeos de hardware<br/>Sin presentar inconveniente<br/>Se actualiza el Sistema Operativo a Windows 10 Español<br/>Se corrige conflicto de Adobe Flash Player con aplicaciones del Facebook<br/>Por ultimo se activa Windows Defender <br/>Estuvo a prueba y funciona todo perfecto<br/>Costo$1000<br/>','','','Presupuesto','Reparado con Cargo','(Ninguna)','0','59');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1110','','116','2017-06-14','','2017-06-14','Disco Duro','Se realizan diversas pruebas, y se detecta que el equipo presenta en disco duro dañado.<br/>Deberá ser reemplazado','Se instala disco duro nuevo,instalamos sistema operativo y programas adicionales.<br/>Se logro recuperar gran parte de la información del disco dañado.<br/>Estuvo a prueba y funciona correctamente<br/>Costo $3800','','Presupuesto','Reparado con Cargo','Entregado','1','22');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1111','','117','2017-06-28','2017-06-28','2017-06-28','Restaurar Password de Administrador','','Se restaura Password administrador local y se cambia nombre al usuario antiguo.<br/><br/>Usuario: DECOS<br/>Contraseña: d3c05475Cerrito','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1112','','118','2017-06-28','2017-06-28','2017-06-28','Tiene Virus','El pendrive tiene virus.<br/>','Fueron recuperados los documentos ocultos por el virus.<br/>Se formatea pendrive quedando limpio  y se vuelca respaldo de los archivos.<br/>','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1113','','119','2017-07-10','2017-07-10','2017-07-10','Chequear, funciona mal en internet.','Se realiza testeo de memoria ram y hdd sin presentar fallos.<br/>Notamos que el equipo cuenta con 2 antivirus instalados lo cual puede provocar lentitud al sistema.<br/>Se recomienda actualizar a windows 10 ya que la versión instalada no se encuentra estable.','Se corrigen conflictos con antivirus, instalando una versión nueva de avast quedando como único en el sistema.<br/>Actualizamos sistema operativo a Windows 10, se prueba y funciona correctamente.<br/><br/>Costo: $ 1500<br/>Incluido retiro y entrega del mismo.','','Presupuesto','Reparado con Cargo','Entregado','1','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1114','','120','2017-07-10','2017-07-10','2017-07-10','El equipo se encuentra muy lento. 
Chequear.','Se realizan testeos de disco duro y memoria pasando los mismos de manera satisfactoria.<br/>El sistema operativo se encuentra inestable, se deberá reinstalar el mismo.<br/>Debido al tiempo de uso que tiene el equipo recomendamos realizar un mantenimiento al sistema de refrigeración.','Se instala sistema operativo y programas adicionales, incluido el pasaje de la información del usuario.<br/>Realizamos mantenimiento al sistema de refrigeración.<br/><br/>Estuvo a prueba y funciona correcamente.<br/>Costo: $ 2000','','Presupuesto','Reparado con Cargo','Entregado','1','7');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1115','','121','2017-07-10','2017-07-10','2017-07-10','El equipo no enciende, posible problema de placa principal','Se realizan diversas pruebas de hardware y notamos que el equipo no detecta entrada de corriente.<br/>El cargador del mismo se encuentra dañado.','Se descarga placa principal y se restablece configuracion de bios.<br/>Probamos con un cargador de prueba y el equipo responde de manera satisfactoria.<br/>El cliente deberá comprar un adaptador de corriente.<br/><br/>Sin costo.','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1116','','122','2017-07-21','','','','Se realizan testeos de hardware, sin presentar inconvenientes.<br/>Notamos exceso de suciedad interno,lo cual afecta al sistema de refrigeración.<br/>Solicitan reinstalacion y ampliación  de memoria RAM<br/>','Se realiza mantenimiento al sistema de refrigeración.<br/>Ampliamos memoria RAM a 8 GB.<br/>Instalamos sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona Correctamente<br/>Costo: $3300<br/><br/>GARANTÍA DE REPUESTO 1 AÑO','','Presupuesto','Reparado con Cargo','Entregado','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1117','','123','2017-07-21','','','','Se realizan testeos de hardware sin presentar inconvenientes.<br/>El sistema operativo se encuentra inestable por el cual es recomendable reinstalar el mismo.','Se instala sistema operativo,antivirus y programas adicionales.<br/>Por último se migra perfil de la usuaria.<br/>Estuvo a prueba y funciona correctamente','','Cliente abonado','Reparado sin Cargo','Entregado','1','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1118','','124','2017-07-25','2017-07-25','2017-07-25','Hace un ruido raro, chequear','El equipo presenta cucarachas en su interior, fuente de poder, placa, etc.<br/>Presenta la fuente de poder dañada, recomendamos actualizar a windows 10.','Se realiza limpieza interna, y reemplazamos fuente de poder.<br/>Por último se actualiza sistema operativo a Windows 10 y se instala antivirus actualizado.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1950<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','62');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1119','','125','2017-07-25','2017-07-25','2017-07-25','Chequear esta muy lenta','Se realizan testeos de hardware sin presentar inconvenientes.<br/>Notamos que el sistema operativo se encuentra inestable y con presencia de virus.<br/>El equipo cuenta con 2 antivirus instalados, lo cual consume recursos innecesariamente. ','Se realiza limpieza al sistema de refrigeración.<br/>Corregimos errores en el sistema operativo y actualizamos a Windows 10, <br/>Realizamos limpieza de virus satisfactoria con la última versión de Avast Free la cual quedará instalada en el equipo.<br/>Se desinstalan aplicaciones que afectan al rendimiento (Toolbars, etc)<br/>Estuvo a prueba y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1120','','126','2017-07-31','','','','Se realizan testeos de Hardware y no presenta inconvenientes.<br/>Se recomienda actualizar Sistema Operativo a Windows 10','Se instala Windows 10 , Office, Antivirus y programas Adicionales.<br/>El equipo se encontró a prueba y funciono correctamente<br/><br/>Costo $1350','','Presupuesto','Reparado con Cargo','(Ninguna)','0','63');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1121','','127','2017-09-18','2017-09-18','2017-09-18','NO INICIA WINDOWS. CHEQUEAR','Se realizan testeos de hardware.<br/>Notamos que el fan del microprocesador cuenta con un soporte dañado, va a ser necesario su reemplazo.<br/>Notamos que el sistema de refrigeracion se encuentra obstruido por suciedad, recomendamos mantenimiento al mismo.<br/>El sistema operativo no incia.','Se instala fan de microprocesador nuevo, realizamos mantenimiento al sistema de refrigeración.<br/>Instalamos sistema operativo y programas adicionales, por ultimo se migra información respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1850 ','','Presupuesto','Reparado con Cargo','Entregado','1','64');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1122','','128','2017-10-01','','2017-10-01','DERRAME DE LIQUIDO','EL EQUIPO SUFRIO DERRAME DE LIQUIDO.','SE REALIZA DESARME COMPLETO DEL EQUIPO REMOVIENDO EL AGUA DERRAMADA DERRAMADA EN CADA PIEZA, TECLADO, MOTHERBOARD, MEMORIAS, PARLANTES, ETC.<br/>SE REALIZAN TESTEOS DE HARDWARE PASANDO LAS PRUEBAS SATISFACTORIAMENTE.<br/>ESTUVO A PRUEBA Y FUNCIONA CORRECTAMENTE.<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','64');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1123','','129','2017-10-09','2017-10-09','2017-10-09','Chequear.','El equipo presenta el motherboard dañado.<br/>Lamentablemente el repuesto esta discontinuado y no se consigue.<br/>Se cotizará equipo nuevo.','Se vende equipo recertificado HP Elite 8200<br/>Garantía 1 año.<br/>Windows 7 Original<br/>Core I3/ RAM 4 GB/250 HDD/DVD RW.<br/>N° de Serie: HP8200I3P0147','','Presupuesto','Reparado con Cargo','Entregado','1','20');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1124','','130','2017-10-20','','','Recalienta','','Se realiza mantenimiento al sistema de refrigeración.<br/>Se mantiene a prueba y funciona correctamente. ','','Cliente abonado','Reparado sin Cargo','(Ninguna)','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1125','','131','2017-10-25','2017-10-25','2017-10-25','No enciende','El equipo no enciende, posible problema de placa principal o corto en batería.<br/>','Desarme de equipo, efectuamos descarga de mainboard obteniendo los resultados esperados.<br/>Testeamos HDD y Memoria Ram sin encontrar inconvenientes.<br/>Se ejecuta herramienta para la correción del sistema de archivos CHKDSK.<br/>Chequeamos antivirus. El mismo se encuentra activo y actualizado.<br/>Configuramos análisis programado de Avast Antivirus los días Lunes a las 19:00.<br/><br/>Estuvo a prueba y funciona correctamente.<br/>Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','57');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1126','','133','2017-10-31','2017-10-31','2017-10-31','Chequear, está muy lento.','Se realizan testeos de hardware sin presentar inconvenientes.<br/>Notamos que el sistema operativo se encuentra inestable con lentitud de procesamiento. Es conveniente reinstalar el sistema.<br/>Consideramos necesario realizar un mantenimiento al sistema de refrigeración, el cual se encuentra obstruido por suciedad.<br/>','Se realiza instalación del sistema operativo y programas adicionales.<br/>Migramos información respaldada del usuario.<br/>Efectuamos mantenimiento al sistema de refrigeración.<br/>Configuramos un análisis programado del antivirus todos los Lunes a las 20:00 hs.<br/>Estuvo a prueba y funciona correctamente.<br/>Gtia: 6 meses<br/><br/>Costo: $ 1500','','Presupuesto','Reparado con Cargo','Entregado','1','57');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1127','','134','2017-11-06','2017-11-06','2017-11-06','Chequear','Se realizan testeos de hardware sin detectar inconvenientes.<br/>Notamos que el sistema de refrigeración esta obstruido por suciedad, lo cual puede provocar recalentamiento.<br/>El equipo cuenta con sistema operativo windows xp, aconsejamos ampliar memoria ram e instalar windows 7.','Se realiza mantenimiento al sistema de refrifgeración.<br/>Ampliamos memoria ram a 3 GB e instalamos sistema operativo windows 7 y programas adicionales.<br/>Costo: $ 2000<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','65');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1128','','135','2017-11-06','2017-11-06','2017-11-06','Venta de Notebook','','Se vende equipo Dell Inspiron E6410 Recerfificado.<br/>Intel Core I5 / 4 GB de RAM / HDD 160 GB / DVD-RW<br/>Garantía 1 año.<br/><br/>Costo: U$S 400','','Presupuesto','Reparado con Cargo','Entregado','1','65');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1129','','136','2017-11-08','2017-11-08','','Esta muy lento, chequear.','Se realizan testeos de hardware sin presentar inconvenientes, notamos que el sistema<br/>de refrigeración está obstruido por suciedad, es necesario realizar mantenimiento al<br/>mismo.<br/>Por otra parte detectamos que la memoria ram no es suficiente para correr<br/>la plataforma de Windows 10.<br/>Se evaluará el funcionamiento del sistema operativo con la ampliación de memoria,<br/>en caso de no ser el correcto se reinstalará el sistema y se migrarán los datos.<br/>','Se realiza mantenimiento al sistema de refrigeración, ampliamos memoria ram a 6 GB.<br/>Instalamos sistema operativo Windows 10  Office, Antivirus y programas adicionales.<br/>Por último se migra información respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3950','','Presupuesto','Reparado con Cargo','(Ninguna)','1','66');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1130','','137','2017-11-21','2017-11-21','2017-11-21','Chequear y de las 2 armar una','Se realizan todos los testeos del hardware.<br/>Detectamos el botón de encendido dañado. Es necesario realizar mantenimiento al sistema de refrigeración ya que se encuentra obstruido por suciedad.<br/>Recomendamos hacer una instalación limpia del sistema operativo para un correcto funcionamiento.<br/>','Se repara botón de encendido.<br/>Realizamos mantenimiento al sistema de refrigeración, armamos equipo con 2 discos duros.<br/>Instalamos sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Garantía: 6 meses mano de obra.<br/>Costo: $ 1700','','Presupuesto','Reparado con Cargo','Entregado','1','67');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1131','','138','2017-11-23','2017-11-23','2017-11-23','Chequear, no da imagen.','Se realizan testeos de hardware, notamos que la placa de video esta suelta.<br/>Esto es debido a que no tiene el soporte correspondiente para su fijación.<br/>Notamos comportamiento extraño en el disco duro y consideramos que es necesario realizar un mantenimiento al sistema de refrigeración.','Se instala placa de vídeo con un soporte correspondiente para el modelo.<br/>Realizamos mantenimiento al sistema de refrigeración y reemplazamos el disco duro.<br/>Por último se clona información.<br/>Efectuamos análisis completos en busca de virus y actualizamos base de datos del programa.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3500<br/>Garantía: 6 meses.','','Presupuesto','Reparado con Cargo','Entregado','1','68');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1132','','139','2017-11-23','2017-11-23','2017-11-23','El booteo está seteado en el disco secundario.','La partición de booteo está configurada en un disco duro secundario.','Se crea partición de booteo en la unidad donde se encuentra alojado el sistema operativo.<br/>Estuvo a prueba y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1133','','140','2017-12-19','2017-12-19','2017-12-19','NO DA IMAGEN','Se realizan testeos de hardware y detectamos un falso contacto en la memoria ram.<br/>Consideramos necesario realizar mantenimiento al sistema de refrigeración.<br/>Los puertos usb frontales no funcionan.','Se soluciona falso contacto en módulos de memoria ram.<br/>Realizamos mantenimiento al sistema de refrigeración y reparamos puertos usb frontales.<br/>Por ultimo se realiza mantenimiento preventivo al sistema operativo.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','53');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1134','','141','2017-12-27','2017-12-27','2017-12-27','Esta muy lenta, chequear','Se realizan testeos de hardware y no detectamos inconvenientes.<br/>El sistema de refrigeración está bastante obstruido por suciedad, lo cual provoca recalentamiento.<br/>El sistema operativo está inestable, es necesario efectuar la instalación limpia del mismo','Se realiza mantenimiento al sistema de refrigeración, instalamos sistema operativo y programas adicionales,<br/>Por último se migra información respaldada.<br/><br/>Costo: $ 2950','','Presupuesto','Reparado con Cargo','Entregado','1','69');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1135','','142','2017-12-29','','','Sistema Operativo','Se realiza testeo de Hardware, no se detectan inconvenientes.<br/>El equipo presenta una falla en el Sistema Operativo, el mismo necesita ser reinstalado.','Se realiza backup de la información,se reinstala Sistema Operativo, y programas adicionales.<br/>Estuvo a prueba y funciona correctamente<br/>Costo $1500  ','','Presupuesto','Reparado con Cargo','(Ninguna)','0','70');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1136','','143','2018-01-09','2018-01-09','2018-01-09','Venta de Equipo','','Se vende equipo HP XW4600 Workstation<br/><br/>Características: Intel Core 2 duo 3.0 GHZ/HDD 500 GB/4 GB de RAM/ DVD-RW/ Geforce GT430 1 GB<br/>Garantía: 30 días<br/><br/>Costo: $3000<br/>Abonado por Mercado Pago.','','Presupuesto','Reparado con Cargo','Entregado','1','71');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1137','','145','2018-01-09','','2018-01-09','Cotizacion','El presupuesto consiste en proveer e instalar el sistema completo de audio y proyector para el salón multimedia de casa joven.<br/>Se suministrará un proyector View Sonic HD Modelo ... y se instalará una barra de sonido marca ... modelo ....<br/>Queda incluido dentro del trabajo, el cableado necesario, fijación y configuración de cualquiera de los dispositivos.<br/>Una vez finalizado el mismo se capacitará al personal para su uso.','','','Presupuesto','Ingresado','Entregado','0','72');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1138','','146','2018-01-22','2018-01-22','2018-01-22','Falla botón de encendido, hacer revisión general.','Se realizan testeos de memoria y hdd sin presentar inconvenientes.<br/>Detectamos una falla en el botón de encendido. El sistema de refrigeración se encuentra bastante obstruido por suciedad.','Se reemplaza botón de encendido, realizamos mantenimiento al sistema de refrigeración.<br/>Verificamos integridad de sistema operativo pasando todas las pruebas.<br/>Ejecutamos análisis profundo del antivirus con resultados satisfactorios.<br/>Configuramos cobian backup quedando programado un backup automatizado diario de la unidad.<br/><br/>Costo: $ 2000 sin imp','','Presupuesto','Reparado con Cargo','Entregado','1','73');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1139','','147','2018-01-30','2018-01-30','2018-01-30','Chequear, problema de booteo','Se realizan testeos de hardware , detectamos que el disco WD de 1 TB da una alerta de fallo. Recomendamos reemplazarlo.<br/>El resto de los discos y memorias han pasado las pruebas satisfactorias.<br/>Notamos el sistema de refrigeración está bastante obstruido por suciedad y un problema de configuración en el booteo. <br/>Recomendamos instalar un antivirus.<br/>','Se realiza mantenimiento al sistema de refrigeración, corregimos configuración de booteo.<br/>Instalamos antivirus Avast Free y efectuamos análisis satisfactorio.<br/>Chequeamos integridad del sistema operativo pasando todas las pruebas.<br/><br/>Costo:  $ 1890 + iva<br/><br/>Nota: Se recomienda hacer backup de información del disco WD de 1 TB,','','Presupuesto','Reparado con Cargo','Entregado','1','73');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1140','','148','2018-02-05','2018-02-05','2018-02-05','Backup de Información','Recuperar información de equipo viejo','Se recupera la información de equipo viejo, esta se migra a un disco externo de 1 TB.<br/>Costo: $3300','','Presupuesto','Reparado con Cargo','Entregado','1','69');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1141','','149','2018-03-12','','','Chequear','Se realizan diversas pruebas y detectamos que el equipo cuenta con Ac Adapter y disco duro ambos dañados','Se reemplaza Ac Adapter y disco duro.<br/>Instalamos Sistema Operativo y programas adicionales<br/>Por último se migra la información<br/>Estuvo a prueba y funciona correctamente Costo: $4500<br/><br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','1','68');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1142','','150','2018-03-21','2018-03-21','2018-03-21','DVR DAÑADO','El dvr presenta la placa dañada, se cotizará uno nuevo.','Se vende DVR Linethink 6008T-LM.<br/>Realizamos las configuraciones correspondientes.<br/><br/>Costo: $ 6150 ','','Presupuesto','Reparado con Cargo','Entregado','1','74');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1143','','151','2018-03-22','2018-03-22','2018-03-22','Falla Wifi, chequear.','Se realizan testeos de todo el hardware y detectamos una falla en el adaptador wifi.<br/>Es recomendable actualizar el sistema operativo a Windows 10.','Se actualiza sistema operativo a Windows 10 y se instala adaptador wifi usb.<br/>Mantuvimos a prueba y funciona correctamente.<br/><br/>Costo: $ 3300','','Presupuesto','Reparado con Cargo','Entregado','1','75');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1144','','152','2018-04-11','','','Equipo sufrió una caída ','','Se realiza desarme, se re-conecta la batería y repara cover extremo de puerto usb.<br/>Se carga el equipo y funciona correctamente<br/><br/>*Va incluido en el costo, asistencia remota para solucionar inconvenientes con ILUSTRATOR y se configura el perfil de Carolina <br/>Costo $ 2800','','Presupuesto','Reparado con Cargo','(Ninguna)','0','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1145','','153','2018-06-06','2018-06-06','2018-06-06','Chequear e instalar.','Se realizan testeos de hardware sin presentar inconvenientes.','Instamos sistema operativo original, utilizando licencia del equipo. También se instalan programas adicionales, Office, Antivirus, etc.<br/>Se realiza mantenimiento preventivo al sistema de refrigeración.<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','66');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1146','','154','2018-06-06','2018-06-06','2018-06-06','Chequear e instalar.','Se realizan testeos de hardware sin presentar inconvenientes.','Instamos sistema operativo original, utilizando licencia del equipo. También se instalan programas adicionales, Office, Antivirus, etc.<br/>Se realiza mantenimiento preventivo al sistema de refrigeración.','','Presupuesto','Reparado con Cargo','Enviado','1','66');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1147','','155','2018-06-06','2018-06-06','2018-06-06','Constancia de Servicio','Problemas de cobertura Wifi en apartamento.','Se instala Router TP-LINK WR941 HP 450 Mbps.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: U$S 130','','Presupuesto','Reparado con Cargo','Entregado','1','75');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1148','','156','2018-06-06','2018-06-06','2018-06-06','Instalación de Cámaras de Vigilancia ','Instalación de cámaras','Se instalan 4 cámaras de vigilancia. (3 de éstas las provee el cliente)<br/><br/>DVR TVT 4 Canales/ 1 Micrófono/ HDD 1 TB. / 1 Cámara Qihan 720 P.<br/>Garantía 1 año.<br/><br/>Costo: U$S 430 <br/><br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','76');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1149','','157','2018-06-07','2018-06-07','2018-06-07','Chequear','Se realizan testeos.<br/>El equipo presenta el disco duro dañado.<br/>Notamos que cuenta con poca memoria ram para un óptimo funcionamiento del sistema operativo.<br/>Versión de BIOS desactualizada.<br/>','Se instala Disco Duro Wenstern Digital de 500 GB,  Actualizamos BIOS y ampliamos memoria ram a 4GB.<br/>Instalamos sistema operativo Windows 7 Profesional y programas adicionales.<br/>Por último se migra información respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo:  $ 4900','','Presupuesto','Reparado con Cargo','Entregado','1','77');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1150','','158','2018-12-13','2018-12-13','2018-12-13','Bisagra y plásticos dañados.','El equipo presenta la bisagra partida y plásticos del cover dañados.','Se repara bisagra y plásticos del cover.<br/>Garantía 6 meses.<br/><br/>Costo: $ 1800','','Presupuesto','Reparado con Cargo','Entregado','1','44');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1151','','159','2018-12-14','2018-12-14','2018-12-14','Chequear, posible falla de disco duro.','El equipo presenta el disco duro dañado.<br/>Se cotizará disco ssd mas instalación del sistema y programas.<br/><br/>','Se instala sistema operativo y programas adicionales en disco nuevo ssd.<br/><br/>Costo: $ 3800<br/><br/><br/>Garantía: 1 año repuestos 6 meses mano de obra.<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','59');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1152','','160','2018-12-14','2018-12-14','2018-12-14','Chequear','Se realizan testeos de hardware y no se encuentran inconvenientes.<br/>Notamos que el disco duro se exige al 100% constantemente.<br/>Esto es debido a una falla en el sistema operativo.<br/>Es necesario reinstalar el sistema.','Se instala sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1350<br/><br/> ','','Presupuesto','Reparado con Cargo','Entregado','1','78');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1153','','161','2018-12-14','2018-12-14','2018-12-14','Venta de equipo','','Venta de Notebook Dell<br/>Caracteristicas: I5/ 250 HDD / Windows 7 PRO/ 4GB<br/><br/>Costo: U$S 360<br/><br/>Garantía: 1 año.<br/>Entregada el 29/11/18','','Presupuesto','Reparado con Cargo','Entregado','1','79');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1154','','162','2018-12-14','2018-12-14','2018-12-14','Atasco','La impresora presenta un atasco y requiere mantenimiento.','Se retira atasco y se realiza mantenimiento general.<br/><br/>Costo: $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','80');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1155','','163','2018-12-14','','','Esta dañado.','El disco duro está dañado mecánicamente.<br/>Se intenta con varios softwares de recuperación pero sin éxito.<br/>Lamentablemente no es posible recuperar la información.<br/>','Sin costo.','','Presupuesto','Reparado con Cargo','(Ninguna)','0','80');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1156','','164','2018-12-14','2018-12-14','2018-12-14','Chequear.','Se realizan testeos de hardware.<br/>Identificamos que el disco duro se encuentra dañado.<br/>Cotizaremos el reemplazo del mismo.<br/>Por otra parte notamos que un plástico soporte de la bisagra se encuentra dañado.<br/>','Se instala disco duro ssd nuevo. Instalamos sistema operativo y programas adicionales.<br/>Reparamos plástico de bisagra.<br/><br/>Lamentablemente no se puede migrar la información del disco duro viejo ya que tiene un fallo mecánico.<br/><br/>Costo: $ 5600<br/><br/>Garantía: 6 meses mano de obra<br/>                1 año disco ssd.','','Presupuesto','Reparado con Cargo','Entregado','1','81');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1157','','165','2018-12-15','2018-12-15','2018-12-15','Instalar','Instalar lo solicitado por el cliente','Se pasa sistema operativo Windows 10 a español.<br/>Instalamos programas adicionales, office, antivirus, etc.<br/>Queda configurado como acceso directo en el escritorio la enciclopedia de wikipedia y video de santa.<br/><br/>Juegos instalados: <br/><br/>Minecraft - NFS U2 - SIMS 4 - ASPHALT 8 - PES 2013<br/><br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2000<br/><br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','49');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1158','','166','2018-12-30','2018-12-30','2018-12-30','No funciona la pantalla','El equipo no da imagen por la pantalla.<br/><br/>','Se reconecta cable en ambos extremos , pantalla y motherboard.<br/>Estuvo a prueba y funciona correctamente.<br/><br/><br/>Garantía: 6 meses. <br/>Costo: $ 1500','','Presupuesto','Reparado con Cargo','Entregado','1','82');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1159','','167','2019-01-18','2019-01-18','2019-01-18','INSTALACION','','SE INSTALAN 4 CÁMARAS LINETHINK FULL HD Y DVR TVT 4 CH FULL. CADA CAMARA LLEVA SU RESPECTIVA CAJA DE REGISTRO PARA LOS TERMINALES.<br/>DISCO DURO DE 500 GB PARA GRABACIONES.<br/>CABLEADO EN COAXIL BLANCO.<br/>GARANTÍA: 1 AÑO.<br/><br/>COSTO: 18600','','Presupuesto','Reparado con Cargo','Entregado','1','83');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1160','','168','2019-01-19','2019-01-19','2019-01-19','Chequear','Se realizan testeos de hardware y no se encuentra inconvenientes.<br/>Notamos que el sistema de refrigeración requiere de mantenimiento.<br/>El sistema operativo está corrupto, es necesario reinstalar.','Se efectúa mantenimiento al sistema de refrigeración. <br/>Instalamos sistema operativo y programas adicionales, por último se migra información respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/>Costo: $ 2000<br/>Garantía 6 meses.','','Presupuesto','Reparado con Cargo','Entregado','1','84');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1161','','169','2019-01-27','2019-01-27','2019-01-27','Chequear.','Se realizan testeos de hardware.<br/>Detectamos que la pila CMOS se encuentra totalmente descargada lo cual provoca que se desconfigure la fecha y hora del equipo.<br/>Consideramos necesario instalar un disco duro sólido para mejorar el rendimiento de la computadora. ','Se instala disco duro sólido y se clona información del usuario.<br/>Efectuamos mantenimiento  al sistema operativo.<br/>Reemplazamos pila CMOS.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2400 + iva<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','73');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1162','','170','2019-02-13','','2019-02-13','2 cámaras dañadas, reemplazar.
Mantenimiento.','Se identificaron 2 cámaras del sistema dañadas.<br/>Cotización por reemplazo de las mismas y mantenimiento general.','Se instalan 2 cámaras hd nuevas.<br/>Verificación de conectores bnc y conectores de corriente en caja estanco. (Los que estaban en mal estado fueron reemplazados)<br/>Fueron selladas todas las cajas estanco con silicona para evitar filtraciones de agua.<br/>Costo:  100 USD <br/>Garantía: 1 año.','','Presupuesto','Reparado con Cargo','Entregado','1','21');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1163','','171','2019-02-13','2019-02-13','2019-02-13','Visita técnica','','- Equipo de María - PC<br/>Se provee e instala cable usb y cable de corriente para impresora.<br/>Configuración de  impresora y actualización de antivirus<br/><br/>- Equipo de María: Notebook<br/>Se activa office y configura impresora.<br/><br/>- Primer consultorio frente<br/>Sistema operativo XP Obsoleto, sin soporte (Aconsejamos instalar windows 7)<br/>Se configura fecha y hora.<br/><br/>- Segundo consultorio izquierda:<br/>El antivirus está desactualizado, se actualiza el mismo. Activación de windows.<br/>Configuración de opciones gráficas para mejor rendimiento.<br/>Se testea disco duro y pasa las pruebas satisfactorias.<br/><br/>- Tercer consultorio izquierda:<br/>El antivirus se encuentra desactualizado, se actualiza.<br/>Disco duro pasa las pruebas satisfactorias.<br/>Configuración de opciones gráficas para mejor rendimiento.<br/><br/>- Consultorio Fondo Arriba:<br/>Instalación de antivirus<br/>Chequeo de disco OK<br/>Configuración de opciones gráficas para mejor rendimiento.<br/><br/>- Consultorio derecha fondo:<br/>Activación de Windows<br/>Se ajusta cable de monitor porque se ve opaco (la falla está en el cable y este no se cambia <br/>porque es un monitor CRT)<br/>Actualización de antivirus<br/>Disco duro verificado OK<br/>Se verifica impresora, hay que cambiarle el tóner.<br/><br/>- Consultorio fondo izquierda.<br/>Activación de Windows<br/>Verificación de disco duro OK<br/>Se instala Antivirus<br/>Configuración de opciones gráficas para mejor rendimiento.<br/><br/>- Computadora de Elizabeth<br/>Actualización de antivirus<br/>Activación de Windows OK<br/><br/>- Computadora de recepción:<br/>Instalación de antivirus Avast<br/>Verificación de disco duro OK<br/>Configurada comprobación del sistema para próximo arranque.<br/><br/>Costo : $ 2500 <br/>','','Presupuesto','Reparado con Cargo','Entregado','1','85');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1164','','172','2019-02-13','2019-02-13','2019-02-13','Visita técnica - Instalación.','','Se instala dvr de 4 canales Hikvision y 4 cámaras domo exteriores full hd Hikvision.<br/>El sistema cuenta con un disco duro western digital purple de 1 tb para las grabaciones.<br/>Cableado efectuado en cable coaxial rg59 + corriente.<br/><br/>Costo: $ 16500 <br/>Garantía 1 año todo el sistema , salvo el DVR que cuenta con 2 años de garantía.<br/><br/>NOTA: <br/>Aplicación para el celular: IVMS 4500<br/>Usuario de Hik Connect:  CDominguez1234<br/>Contraseña: Camaras1234<br/><br/>Usuario DVR: admin<br/>Contraseña: Camaras1234<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','86');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1165','','173','2019-04-06','','2019-04-06','Venta de Monitor','','Se vende monitor LCD AOC 19\"<br/>Garantía: 3 meses<br/><br/>Costo: USD 50','','Presupuesto','Reparado con Cargo','Entregado','0','14');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1166','','174','2008-03-11','','2008-03-11','El dvr no enciende','Se realizan pruebas y el dvr presenta la placa principal dañada.<br/>Cotizaremos el reemplazo del mismo.','Se instala DVR nuevo Hikvision de 8 canales.<br/>Garantía del dispositivo: 2 años.<br/><br/>Costo: U$S 175 + iva.','','Presupuesto','Reparado con Cargo','Entregado','1','87');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1167','','175','2019-11-05','','2019-11-05','No enciende','Se realizan pruebas y el DVR presenta la placa principal dañada. Lamentablemente no es posible su reparación ya que no se encuentran partes disponibles para su reemplazo.<br/>Cotizaremos el reemplazo del mismo.<br/>','Se vende y configura DVR Hikvision de 8 canales.<br/>Garantía del dispositivo: 2 años.<br/><br/>Costo: U$S 175 + iva','','Presupuesto','Reparado con Cargo','Entregado','1','87');



-- -------------------------------------------
-- TABLE DATA usuarios
-- -------------------------------------------
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('1','','admin','d033e22ae348aeb5660fc2140aec35850c4da997','1234','Super','Admin','','','','�PNG

\0\0\0IHDR\0\0�\0\0i\0\0\0M�[�\0\0\0	pHYs\0\0\0\0\0��\0\0\0 cHRM\0\0z%\0\0��\0\0��\0\0��\0\0R\0X\0\0:�\0\0o�Z�\0�MIDATx��w����?Sҳ���T�`��)\"
b��E�����S��]�{G���\"`GAE�낈H݅ei[ғI������eE�j���,�d2�|��9�=�+�A6���ld#��cC�^�ld#��F6����ld#��F6����ld#��F����ld#��F����ld#��r6���ld#����� ٫��l�=�<��\0��5{i�\\�[�k�`�Y@�F6��Q<m���F\0˲�)����3�_�/�2{������T�x$D<\"�$�fλ���Js�s�I�Gg��<>�y�|������WW�nf��ZB�hv��F6~��������h�F2\'�͜w�z���1C~TW��ݗ����_��3O�\0��rr�����re/b6���ld#�6]GIĈ��`��iU�ϊ����i���`�Q�\"1����������~�7��]\"���, g#��u�l��$J,� �\"+Wo���\00oA%3f�!??�����vx��~�~.�#�/�F6����ld�׃���i;��Ǚ�W�~�:U�5���s|^������p�r�����!��%��AQE�\\\0�u��1�,�&�rS!�DIs����A��<��֖��1�P:����u!��A~�wjIa%�$S)����e�ld#�!���XE�N9>/�y��Ҫ����
rs�z<8dy;Xg#?��%�n7n�� �yK���FdY�uy>���o����N���o��G�գ�� �6�%���v�!{�e#����a���q�Vf,I>���/�r�%#B�(�X%��^�ߠ:!I���DAM��tM��t}�g�g\0dI�����/�ݾ�^���3�7W��F��z�>7n��-���[�+����W̘�A9�L��;�ui1��B\"�D�4�d6K�F6���d]GSUtME����z�p<&#�
����S�T�n7�$c���R��J�cSdg|�$�r��]x�n��$
��J,�K$H(IR����EQ��v�����5���uj��\'cTU�� �,�Ș����1�qT.YNUu��>=�M����QeI�B*���t��T������;�����D�D4�G/=W��K���n�g�K/y��eŅ����gI6��3�55�\"�L�H($S)A��r���Cyq��hSZBIA>9>/��ϔ�#;]x�9��_֊���ZԺ�P��m���+y��i����ƣ����xH��J
�hUJia>�Y���_6��͐�*��NJI�
J���p����g�ē�RUUϋ/�ü���\0_�w��]�}c��xB!W�������h��Y��5�My�p�U�hT[���}c�b�ˉ(�h�������\'�cI�pz<����p�p���ME#0���������ڴJ���6C����n��n\0x�������OWǭҵ�i��	4]�f���F6C�s���$�1��\0������.���Ɲ��ם΀~=9��2��79��S�RP������p�������8�($�b��_�[`�����W���ZRRX@�ߏ,�y���(\"����<�J�(mׁ��@(j]�\00EUu�}_����y�\\�:��z׋y9>Z��к����\\\\��|r6��� k:J<N,�]A�c�2֬����̠��H�=�@`��ۇ�;u���t�pȈ���W\\�d<F,d��7m0��z�v�m��٬��ƌ>�>䫳�ql���<���\\�)A@�$d���GNaE�+(k��~ȅ��h�V�qѕ�0�_1����ޭ@�=�O.�ˡMi	������qf[\'��F������&�(�x��.֬�����J aҋ3�����sп7@�޿�\"(Xsв$���,I�q+MSID�D�\0�\0�ݻ���\'/7����C���,c.?�>�
�׃���!K��.�\"�ÉǟK~i+
��PԺ\"b�r|����s����sod�3�����:���ږ�QVT���������, ����c�0��H$),�I��C���JU��WUJ2���i\0�DQD�vqfTdI��t���R��KIa�������zp9�HП{�5�ʐ�MNa��o�]�aC�d��y�(����Yr?\0�Á$I��/�\"�Ӊ7\'���r����X�X�����7ߢ[���>�����UVXHE�R��M���l|6��[\"K��CVDQJ��\0������<�\';�q�!�pxO���Ė4\\�ЋS�5���\'I�%;��U�H�T�|��ě��7�Yh4A�%
�].r|^�n7YN�x\"��D%�D�t`�z�S400tS��>��I2t-�$��ەdY`ɷ��a���+���=��pxo�������:�%	�ۍ/���d��8E�+&����������賟�}�RN8�Dƌ>��}����6⭏���
	%��j$-K��F6����[-%���pS��:�>7\07�8���?�o�,㪫�=�y�h�P$B\\I�2\"N������q�ՔR�J$\'�K$H&[��5tM��uA������@G�X�����d�X<N4�0�SM�;�_;��3,�0�u�d*E2�\"���TM���^K�h�H$q�m��ٸ)л{���׍��5�ëcqk3b͍�@���SXLJQشvE�+F���t�D��W��ƥ���é���ϥ���+*�|�x2?\'��֥%�s\\L�u��I4ľW2�f�{ǼL��ݽ��F6���WdI������PԺbq}m���s+V��v�������>���/L�����@�P$��THY�����\0U����:�0Gc4�B4C��J2�,KTS)R���J���W��3��Nw�e�FL}굩�%Q�!�8��_L�r�$�dk�57�x�p4J$\'n�	��rfj<���ҹS	�zwf�ɽ8��0�?��}؂`�<�?���Ͻ������W\\BJIPW�`�e]C������o������{O�i�c	�������}5VI&M���I�����$�t8p����NdI2�C���L�P�$��o���F6���
Ap�=x�f��*��)b����}ʉ�f�ň��l�o@�EI%��ʣV6��~���OY<4a�̩N�YW5UUQ3\\tM3�I\"R�L��������ї��۲d�f̜_\\v�)\'��N��j�Է�)�$�p��� �� �Xl���(K��^\\/����5��\0���>{�����	<���a��QB�(I5��-�W�I�J��\05��5��7W��hq&����
���C:�<��z���~>\'�XJ^�J$�M@��ԬUUq:d�S�����t��H,N(%�O(YS�ld9?����.\'.���e����H4�fI	�#D�Q�q�|{�d;��~@k��r�Z�@���}���t�ɓf̞��:�x�h<��5MC��������v`h^����>�SNHNn>�Y��AC�&�l!{��⼓�������<dY�:v(�����Ǔ�kW(���m��Ћ$A咵�`|��_^�����_(Cμ�)�YX���\'O���y�lيm���R��;�[n��[�x�����2s�\'5qEAI��,����-$uM5��uDQd��$�u�*�}c��h<���BEb��N��iRd�i�&��w6����\0dI�q8]����L��2��	7�S����#=n��s�:�@n��O�Ǖ�=���\'_����V7����d����$���\0�\0�}����.̄��Y�s�e�r���0�;x����N�2�݄.3�@�����z�P��ӆ=bڇsk����[@Y�$\\n/��\\�B����f�]�0�����?a����p%�\"�P�2=������_PD��~���ښ=�:�������xj	�?�y�,f�\'_u�)���,+!�(()S�KI�v# 먩$)%��L�p��
���Ќ�p�?O�\\���7j\0Rjj�}�e�ae�.��$Y��T
%ir�Yv6���WeQD�e$���Vn�)�͏)nlH�a�>�������8�1��fɷk���p����u����n���J$HD�`��q{��_���>�/\0�>Y��{r��>?� �,,C�0���������e�\0�FƏ� �@p�|�K���~�G����������W(�-T(@��&��!KH���j����
�&���[\\BRI�m}�����.���7�]�����M�CϢ�z��~�z<���G+���mJE�#���n�D#|1k���һuy!�{ݻ���2饷B��� ���D��u2c�����d�aȒ��� ��5���N�q�`4B$#�9��F��G���7�nG�YDtCG��X��W��n������d-S�}��?c��q��2�X�<$K�c��,s�̨�7����()�P�)DќU�b���u�ۉ����s�v9,�w4� M�+$�*�n �N������w�t:̑�DY�hӺ�<�r�;�5>%��:|����
�����ss\\l����p9�H���;!��l%��?���2R�t?�r�ê!*�m�Ggs��b��v=p٠Cz����ES��wm��~mfi���D���a0u�{�./�G/瘡#H��q���:z4���COz��/̘�@�ߋ��Yn/}�)q���3\'\0<���9q%�\'�^��P����ld�o�(��JBZ����V�mH?�j�3{շ���)Mo�(��ֆ`!�7����c�N��b
��L�ҵ����,�r%���#IIEI\"�	�>7~��ǅh���1�h4A<��H�%CY��x���#@\"�\"W�u�A��ګ�I^n��y��e��EQ��Z��,�����(���hJl���QS�I&\0s�kk�\0nZ�CSgt��-�8�,��wW^{/�KC�����W��b^k���_�O6ÜH&ID#v5��I\'��%q��=ͼ�s��s8����8�q��\0��n����,OSJ5�DK��t�k��ajv����]�§_�V#
\"���$���ld�6�����W=7Be_�\\X\0�@0���:.��>�ټ-ƃ������i����(J]o�|�0�5=�z�&�w�D�6�\0x�N��7�/$��.�������7���ث/s������6�,X}�Rdy�뿝��G�g��y�%�j=�\'�����iZ�G�[��$	�ۃ������$����5{��>r��|h1v-⊋Oe��Lzi�x1��?�uI1�3����$�䮃�nf������P�qRI,󏒒|֬���f\0p���3��!����TM3Ex{NY\'�4ME���ߛ�&F�y�Atl_��&ϣ�z�P�ˋF�x�ӯM�I(���uY�F��g@�&�Ȳ��xN��4������)m�U�DQ��rSҶ��mC�`���F��\\���瑻�F�H�a��9�>lA8#��jj�E�����˧�C��[����{/�r��
�e��M�To؆��\0��2a�!Y����pg�=p�{���ª����Ηl���m�Q\'1w��|�o�-�O�2#��$	�˙q:i�XB!��g�w����\'.���\"s>yK�Z0��\"�T��UA.�f>�O(c�=R�d%�KW��w`��s�X<��D!����P��L7t�,w[D.%���?��hV��i]D����c��s�ϕ	4n��%�Rjz^^�t��8�p�o>zo00��vp�MC��̞x� �s���q�Ew3c������~߱y9~\\�fK&�!g�7�Pe/��,�Y? �^����ʊ
�(+�MY)e�E����xv�辀�3�����\0�⛷FY��V�7���ut���t�>0�	�x�H,��i;\0����#�����R0� f��F��:����ru��S��{<�b�}Ǖ�m?x��[T��E���E�n�`�����A��3n�~�Ƶ٫�8�~�	�G�r���t�>c�y~����)��Q�t-?>��?O�?��9/ӽ���s�~ܠ�+*�Ji׺�����z�l�_�����l�:���O%�$,�5A����R^RLE�2�K�)��7��nt_2���~�KZQЪ�mBq9@ͦ(?��㞇��f��7���0r�!��+�˥���\\��g�U�*[��Z@%	���Y�K���
���Of�=��{�L�rc.��s��83f�NoF��(�D���Y��J,B�,}��խ5�>>�b���U7<OA^.��%�i�<�(��tb2����l��ǂ��c�0PP5����q�\0��=��:�Á�LGh�	Fb����[I��������ښ��oA�H4	�H��:�(�|�BH(�9���;d�\"N�o^\0�ҧ&�~���0�t�@\0Xp�\'-%33�<�$��Gk��LN<�He�w�����6���_����3�W�-�x�Ɯv�\\{��v��|�S<ʖe\\c���ʥkS��ګ�o1S~���5����I��D�?�55��J�k*��1��Oζ>�< �ٺ���ק�vg��TMk2o�kA��t��ͣ�U����������k#L���}��~�1�ޫ8�[vx�/&�~oY��Ƕ�\0��(�f��S�B2GI��ꝷ.8䠽�좡tޣ^��+�i׶��G�CJ��{s���O9�1\"5+\'���L�ٶ��о\"�W`���	��[��nt�ӏg@���[P��an�@#Y@��H5�BU�rޔ����g]{��y/�|g����M �]��(J�Y�PԺbY}mM�7-I�4��@�dʔ�w$uY���K����9��,K��������t{DA���l\\�����v�_��l���mw�BUM����c��k�7�����͛cg$ڗQP�g�k���9�_��/�O�H�·��:��K�}H&(\\s�̝��&���A�GL���EIW�(�䯾���	�NRQH�b��$�fM=	xs���Y�#.q���O���� �$�	����N�p�\\��Q�����kkTU}�5n���~�٧�������\'�O?�ϰ��7�Z*ERI����l��Mf�/>(��ڟv%$��~�w��&^��x<ɚu[짜rḻ��a��8�x��()%��%_?jߏ��n:����\"2�h[	�3�\0����F6���+�5���c�	>{��
�H��<?���TU����qܰ#�O�:�FUMŢ_患5˔%Q��q�4�w<S��1�T�Ҭ����Q�dNs��r���ESUC7��e��Dr8�#\"������(�`0�Է1g�\0�8��|��{3o��`�k���������c��&�1�S

J8��Qt�/�K��_:���m��oԆ�5e�Kf���� z��|ҐA#^��NM(%��P�Z�!]�H�bDCA���N�G�ד[oJ~�\"~���E&�4�|p��u}���u�~�������YNa1�D���Vg�P����m=�|̀����n`�K3�J��֙�Y�	�@�T�d�d�ck�(P^\\�ǭ7��#�SѦ�h,���r�o�&v|�ρ�N����F�q� ���h�E��6����Ё�h����SO����m�r�>���5�T~[P}�ė+��8ɔJ�{��, ���j5���HD�X_���*�y������ ��p%W^s7�K���,��=6�HP�����d�4�R̑!��D�h�z������t�H���Oe@�(\"ɲɸ6�raQDK�҆;n��lmr.)kSa��69\"����6\0���\\�e�;G���d��N��N<���y����i��3�9�
�r�\\�@(��,C7���c���+�5\0��ս��oM,�r�r�������N g�̏ʁqy9��y~_���;K�� ��d�����uD��3�U�����ӭ��%ߥ��*uÔ�l��n��4UEM������;3n�jmt���y�(z�ڛ�<?�h�.}�i3���)l�Wo�ʙ�n�Ϭ��*�T�x��/���`��KA�����䰃[Ӫ�Ŷ� ~��=��SҨ]���Y`�Ƃ�@%i*~e	]����)%A,dق����>��c��n�5s!�;�À�����T:v>�@ 4���Gv~��i��NW���4$�jN������!8-P�KܦkR:����}P�l�ٿ��>D�Ne��S\\�OiI17�t)*+�K/�J,f�?����c���Gbسg���ۘ7X�тV�l�^��U���4�މ�0��i��5���C���q�ԙ�nӂ��}�L�ZtMC�ǈ�C`���^����ʱ�(t���b*��}3f~���q����q�B��	l�5<�|y6 W���y[���=��hf�i����`%��U`����s�Q\\q�0����C`ٲ��z�x���F�>��	�e*�DI�0@M%QT�d,F\"���� �w�\"n����]��e������fӖ��L|��F��q_G�v���F��0@�I)
�H$]�-)�c՚Z�?:���`��Op���r�qG1��7\0����Z������f���Ǟ]$���mk?/L$�}��o�C��vW^>�R&��&3f��,P����X���E&��Ǯ`�}����sϿ!���8�qu��uW�c��o��h���qoLٗ��th_AU��n�s���D�\\����,�(��H Z��F�`S��5��U�f2��{�nr��4�Z�dEIBr8����w\"?ׁ$�a���`y�sL�L��&3��x��2K�J<Ƣ�o��i���������|Bo:u,T^�����@(�A��#N?oY�s�� ��N2���c|:��& ?��.\\}Ɂ��>Y����\\r�笮
��u�ow6p�i׍�Db1R���YKf#��h�M�g%���I���7���9ḣ�о��Uǔ�5/;��E0vռ�\0T��p~VNn��V�����z+����vF0tz����~���W�g|ݢ�>��uŜ�ښ)���\\�ߕ���D��yбTUo��]7p9���PԺ��ښ&��u�Z��j����\\\'I��~����2���]E�������g���@^J����{h��O�?���0��/����N��~�����@�F�q�ݝ)7����pI�A��4�PO��i�`��9Υ�J&Mu<ƗoO����>m��3�u�ޔ��(1n�u2<���S��^0:\"Y#^��w�\'�1>7A���������{�G;/��2��5��\\��t&|��i\0Xp��-vy�$,E:s+K��F�����2S0���������(��z+�y~��t�Y�]�}�LO$�,�/s)d�ON.ns�jN}m͑����J8$���}�mϾ1}º�Z$�AmPm�WӚ���\0?�ҫ55���:n����2۶����U���zwo�ŋүR�2�~���>�L1SmKL�p�#J����:��3���yVb���o��}�<��[�,¥gu�T�@�_۷O�n��}��Ⲣ\"�AR�����כ؞�n�!;�X�1��HgȚ��L�PR)tMK�����N͏��	0��^���T�ݧ->�����q��,�j��|�u�%�\'�ƺa��oMEU�(��x�/fOK�|���<z�`�^JY��d2�w}��g�6����GD���t�Jh�T
�z�ld#�4�$�kqd�FZ�����x��1ܟ��v̛��3?L�iC�	%i��v4��rA�d�׋��\'h��V0��{{8\\.\'�É�p43q��M���f�S�F�tUՐ<99�r�	�okrl�z�q�h�q�Q�ݐ!g��-}�v9q;��X�J*��$��:o=z�`�
����1NՆ ��S�:\\�?�%{t�����d��3y��^p��Cf�[P�&Rj<h�����5��}��dС���6���qE�Ǝ�$�fO��w޲U�z{=.�sg���[�,����K���}���Ȏ�m�b-�������ݷ�r���c��;{���J�l�g�����4	񎁣��y���d���i7(���4�����( �\\��>�o:��c�oјB~����­w>m6��\'\'�5C��_Ȼ������I�����ƹ����O�T�!˸d��E�g�t���Y�dS�T׭Yigf�2���\"
��so�k�e14AD����(����t��R��u�r�Z�HZ��fS��M�Wq���\\Ȕg��yT.���&~2��?�Mi	�B2����I(��l�(Y���i��	�̼��7ɐc	�����,���y�#M��6����s����q{����7�2�~���%C/]#;H��������M�5?��w0梃8�}سC��1����y���l��A��s/�#ɲMT��b���-�����DV(�t�q�s�dG�>f #�Lo͚K �������5L}�dr�K]��x� ��˂  J�����}^\'d���,�;uU��u��4y|SW%�b��������?ʿ<C6,�A��ּ)/����Y���\\q�)�嗀�d��r�5w���������|��V�����-f��wѱˉ����z����E_�M$�$SGZ���BH��-ױ�Y�M+������jC0d~���,[�q:{ݷK;���p�yBodW+��ι�nf���~�ǆ�s�h��@�M�nM3�妴�be�q��=-����s��3tp\'*��(J���X�-�}j?ﻘ}�4�c�D{>���Ò��%�QBv:L�*Oڝ-�ǌ��;�U<��a.��_ꝺ������3���=��&��C[$Z�<�&��f����G��]�_��`���(��p���1��;�O��7����{���:�9�`������8`��\0�ϭf⋳�u�0��4��A�4�����V����$���\\Z*�9����ĉ˝G岴�C�a��i���FY���^�HY��g�
�ۧ-�����B*�V��l0��|�EW�v��8d�(XY��䕈D���b����s�g`�vLz�N?yo*Z�ش9�	g���ǆ�sɰa]^��F�;S��w��&5��C�q:��Tŝz�g#�!���X0U�\\n�nqs64�8�R�3)�,c����FB�����H���KQ��`�<�̄�w�|?�]X�g��Gn	��z�����˘���{�� X%x�ްYb$2�ʥ������櫷8��8�k\0�~��<�|���nZ��1���uL��=��3��}�`ܿ/�[\'/շ����.�ɔ���؛H���$��5�.��|�E���> ��W���B?�Ve�*�g[]UM1镹\\u�v�]���ﺿ&�K$��#;+ND#�BA��������Ӻrͥ�hWQ�|�ߕ�}��[�`���ϻt�d��Q�Ѝt��ΊeI��q9�8�t#��(��s*��vR^6����.!����t6�?�ǁ9���7uX�_�E���sJ�Y��-YίO[���)e��?���WhZR3�mo�ׁq,d�{3�`ܶM�s�e���@���jѨbYw�x}^*��6-f��9��V8� �}�@��{�97�����頪��e?�s���`J�?�%KW2c��r�����6�%$%�B�4��/�O65�DK��t���(̗�*�]k?t�,�3�v?�Y���Ve�}.V���!d�1����7��>dæ��n�#�Z�W\'�H����|\0����\\|Vw�?�+���i���媛?\"J�9�4b����HG��뿮Dmg��  ��� Z�vP�b�iN�(�Ȳ�������u�q�2����	E#Dbq⊂�eA9������I37���)x�bƤ�/U���&��&;��t��ͲJ�w����PP�ov;z�me@���kr�t������gW�
�[�pǸS��6��xX�l>��U�7Q���HĜq����_��9�+|���];r�1��ظ�� ���uW�\0p	�G ��R]�ܫ��m��ԵT.]IU�ơ�z�xt��G\'����d*E@��b�hۉJ�5��U�.��I��z����.N��ˉ�墴]��[ׯ33��k9����;�[�s����[n��G>������m%en$]\'�$l��\'���B��SBEk?{v*��^�(���糧���Q���(
M�ſ�d�ˢ(��e�9�0KΒd�jv��UMM�o&�)4]�{o�tV[,|��i�#��I
��q]�r����x�خ����\"�2Nف�!�Pe�M�12\0-MZj�y�m�a��\0�q�Hy�����t{[����f���۶�77�9���kZ����/��j�xMCӵ����[?�w��y�?Gd����Uw�|
��m��3\'��/���ټ��.{W����>���>����������j=E�mH%5��5�Vm���������2��z7=z�	p��CzU~��		E!�$��,�E�����9N��P�>=�V�����(��csn��\\�ZWX��6|���t�ڞ�,��Ϧr�Jf���x&/�7�uI1�x��ELS�1�d����#����o�btQ�6�9�ܱT~�,i�+�z`B0!�PH�)��+�b3�װ���j����KpH.�7����%)��J���h� ��r�Wf�7�a�Z�L��*�ǴF6���\'i�����>
�siUTDLIX����J��t_L�t�w����Ы���>=�U,X�MMYQ!y8\\n����@GH�Uj��T����ak��L��jb�(
�Ok�1��uR�J\\1Փv,��(B�M�	����~�H-\\!����
�[��s��uD7�[��o9�m0����9#�D�ʥ��q6mj`��������7�c�%��ť���dz�|�����Őc�f��c9������o�_�:�e�l���d�&��n\0~����qHU���n�\\�q�����PQVƆ��䕔��lf��h����x���rāL|�*�,���fhߞ������m�J��[�h�6{�n���w�0�|,_YG~�N���|���~oB0f�ml�VG0��[��_U�O��,��;ybgL���TG���|�}�1���P�~3f�#�<m��Ly��Q��K$G��T5��f9?��Z�ҙ�en���\\?~͛.a�3�	\"��X�h<a*7�Л��`�]G�n]l������1⽅���پ?��n��я��t��h�(�*r�Ʃ����&�m��x�s�zt퀩p���LR��F0t��ښ�@�Cf��@t7qUJ(�Gu~���\0@�����g
Fw����Ս��B��\\���	�BS�2ʜ���F����\0^�D��-_ϲ��3O)w������q�9���A�7�&^�C#�<�-�g�z:�g{����ֺ���E��u�p�+�� ��`�N����TTUfŊ����-\\A ٻ{�5��zl��2��G��BA��}�6�s��}���p��L�qz|�������ES�B\\Q�#8�.[��!���u�sdt�j��ҿtܽ\07�6���o~�ќ���1&��*0�5�T\"A\"�瞗�_�\\ݻv��w裂�5^}\\�m�J 9�>�8mք��,G�.�Y@�Ə�75�m��?���-<�q�ԙ����Di���C��T0��5��\\�s���G]b�:�~t��#�{sFMay6�[ӴЪ��d����K�߇��4=�(g�q\"jZ٭�����/Ͼ{��[O)�8�@��h�YW��x8D�򥓁�N��e��ԓ�@#H��ñ�X�g��%�_ƺ��5��,)t\"�E ����z��s�x���)--�r�j{�P`��Q�R�
N���G<ƛ�W�L��R��j���$B�p�W��+
�`�[;�nr�Lo�-Uk\0.:D�j��U.��s�N(a���R��*��л߁�\'����QJ2�.᪚�K�dQp�ܸ�>�ܮX]#?��Ó6�Ľ�1}�X�\07�?����/�|Ξ���DI�͹a+���i��q�$�1��G������+���!}]bg��H�`C=S�uj}m�c�e�~��^}k7\\Յ[�?�[�y����1��צ�x\\.s��W�5�F\"%��\0p��٭-�w)��u>����V��n��^K;��u� �������`	W�>�N8����9��t:&�];���F�������\\Z��LB��;{��N:�s�����pY�ϋ�� �ј�gk�.\0�_�j���p�4��ܖ��?����O���\'�0��n�Y��w��֤ᩮ�����r���QZX@} HC0�ˠ�#�BA���n���Rέ7ˀ���I/��Ǧڇ/XU���͵,�?�c�����g���\'�XϠ���~|0&��L��_��}xS�䎥�6^��2F��һ�\\����+��ET.]àc�$h
fL~ɕ�l�EON��J,���Ģ䕔= ��Ӊ��ś��\'\'MSI&DQD�u$I���_Zf�E���MQ�^���3��o�`�S�1p������ќϿ�`��ȲL8K���f2�w\"�!�N�_~ASP\\��?��!���-7��-w�\0��Q}{���\'5�x�P4�7�ZW�����CU��˾��]�C�n�����,Y��I/Nm��G�1�56n�\'�m�ݏ�#��C�� �:g�����Ƽ�˘��.�3�,s:��5ӫ:jW���<=��<�\'E�A��eV~����\0�1b�n�y.�!R�t5��9���}��ƭ�1������u1;���l��H�{�u�Q�-[F�����Z`!\0�`�ʥ+{_�2�ȃg��d��!�L�hll$�t�D<]z�����ƾ½w^���g��sӠ<��q#zwrM�wKl�����;d���y�~�dB��b\"��ɮ�rK`l��|	x�І��=�aG���I����K��?����]����|6����H���苎��S���^�1K��u`��#Q(��oS��c�r�,���G�o��غ���4˼J2��`|�	�P�t-����V��r��׍rZ#q)UC�ed���K*\'���H�&EA4m]�4�@ӷ�Q��t���#���D`q}m���s����?o=��ɉ�<���^�9�	����/�=o�bM�q:���ɬjh�F�6��tӠ�\"��ARpy��i��\0Ec�U
w?]���w�5�[��y*�\0����к�H,N4C��ٸ����^�zm=�_�oL�g���S�d9�K�������}���v�E���!b� �֮��� Ju��������e3m����C�;����?�غ�q��F2���\0�#
�VoE�yz�:�m��7K׳yk%��yK�h,���&����u�r��ϓ��#
F<����&�]���;CM���eS�G�����=����A*4�|l$͝��C�r8�»���[���~�;�|�L�u\"��H�6���9���]��ȍם��?���̳yA����O\\�9�>�\\���x�W��[��s@����g���r�0���ˤ�>���^I������?0wʤ��H���՗��b�.�	B~7�K�l0q�m���b���S�l���`�Pb��t�ĿGw��fJ�N����Dbq\"��O�qJK
�UME7DQBpH�	̆�� ��ҙ�&�51��$.��BT�ΰ�uń�ښ#TU�bm���[��{��Y�<�%KO���xd��~C&�~/���\"
�i���9Y�r���8�j�R)b������$bQ6�]��Z��
ߴ�	Lc��W���k���<�_�w~����Ѷ��ia�Kn��k���rכ�zS����C�\'�p����(�c1�	s3Ef?�&��6�s_��o�jC��w=3qݶ��na)�鏞�ve�fBqdIdа[\0�X<E(\'N�L��:͈�ڗЫG\'N;�?�����N\'ϟ`��϶W�\"��r6����3#iN�2X�v+W�8����I�*�x�7D�4�vt����L|�VD&�8�|9��>��ɧ�T��J$X�<���m��a�p���W�����a�QP����,�����cϛ���N>�k9���\0�t�A|��2���@������m���a�.��I�|̹�MN��i׍��z�*>~e��N��|#O>�}�nG a��{���׏����T%�����ϕm	�c� �?���ޝc�ߓ�Gv\0��@�&��1����Q���P`���KK�\\��A��k�U��B�H�J���3ؕlH�e\\9�E�	6�]e�?f?�:��7.a�Wy��Ә���ʥ�{�F?�
��1h�\0*�yvR�a��Pɚ�0Gw�	��P��������Q�˓<����������n�q�!��������������d���xw�t��-N<�t��w�\\86�ٿ�ɧ�c��H�d<f�����_��{��vezC7�1&�$~�(�O�Gz�lh:\\N��B_���O��5[��ܴ�(��cFI���ϸꚴ꼆`�H4�36�����*Cq��xs��R
�T�7�h��7�hq9~�(��P�*�(��Ō��h�ӟ���LzqZ�ߞofʪ%����eMAyY�+��x�ET.Y�����mI��/װg�78��s��|�a��,P���UE!7���֖[o���o��/K;���k&�TU1���L0v��>{�!3�;���ρ�^}cM�.�Z�`�e���o�d��%Ɯ�\'���eee�1hĻT~����?>v[C#j7n�k�Od�Qݬ�xg`,��X�$\\N�Y������7�S��>�)x����WRJRIP�q�����ے�7��W|�ԧ�M:���$������s^��X=ͺ�,��za��uy9�<DQ4��f����V%���D�}�d�ї����q����b��5�D�P�ʔ㱦���zz�< ��O=�%KO��^xd��}���h^��G��$�Á���iͪ=T�i��&`��w��@(��L�i�n���UǚDYi���_��g�3M�^��j֬��굛xm�\"�,MW֧\\t����5��e�, g#���\".�A!�<��@0�%���k��^��E�Tqť\'0��Ҡ|L��l_����3���?�����	��7oKz~�����Gƽ�Y�<��s.��g��-��R��!��\0K�~Фg<�#|�8]�f`<�����l���Y@\'3�_Grʉ�L0ś��)W�Xcf�*���j�0\'jh��L?�n���vb�q��թ�@0ĠS>���9��l�VG��Z�x{z��Jr�Ǜ`\\ZB巫4�?X�D�R���n������]8d�0�H�Qs.�(?[�ö����RPVN*�\0X]_[s�ɂvp��oxd\\��WQ��EUM�ʥk	�,�v5�T.�D ��9[ˎ�}�	��.�4}V�,Kf_=��ձ��5�U�^�}�[Oҳ�]���>��0f���x}��~}�~���	GM2ۆ�gd��ޫ�\\|�ޙ�����e�\'��\\�Co�����Q��h���b�H,�G~I�Q�/Zp9&�j��s.�FL��f��u/v\'�^]�kRq�ߗ�����6԰�z-�z�0�
�8I%���U#�\'UU�is�M������\'��~t,G�ݷ��F��R�ۍ�����T�-��`}�*n^�j+OO����<x�iL|��A9󠝁�,������\\j/TiP��(��׬�ٻ�ᬓ��朋h���!$�PLy?5E\"&�����s�����A9po���f`|Թ�Lh�TˢYS���������d�}:Et����X�2�.��O&2��\0c�k/����*�g�R!�A�Υ���9�v�ؚ���а����z#��E~���as�~��S���E06��c�0�.�=xw�S��ɯ�	%Ic0DC(D �D\"}M~r�(I8\\n|y���&������v�ic�2��-�0�����1�g)�
���Zt�}^H�_��`D��ۍTmP�~�P��V%��ʲ��j��q�x��Ui9ϢHLｦZ炛^}�)�t4U�Q�tUo�����Q�ڶ!33d%ck����֨\'?�����p�%L�z�>��\'��9���eE��*+ESU�/Z*�aǏ���t�ˍ h�J�%�_]i�e	�Cz��(�����Da^.߈\"�Y�VS�	�X����%;����\"����ν�NI�����ڏ��_��}���ڛ���$`��w7��Oș\"���M��-W�;�\\A��t��� =U��T\"1G�T�\'���;a��J}m�z��L�nh�s<�ș<������s5v��>N9�D�~��\\l��l���ے����QW�b�Cv
ʶ��fxRj*��t��bL�~O���ٓ��:��0i�Mz�G�w����,�5�j`�,��/G�=�u N1�{��vC�F^��I�0tY2��ݖ&���3����iz��v�?��m�f�/���Bi?^�K���:3�r�ٳ��S�Q�<�d��D	n�Jæ�`:���qs�)�0�𽨨hK�4���8�H����jJ��_��X|\0��lԈ�^���h{�T׍]v%	��CNA)%���uMY�+��*�y�L{+��YM�R��2%�ʊ��P��$�C���!8ہ\\F0V@Ǯ�	#Ï����?�b��i��x<�c?���-�|������k>䥧ϣ��wFF8���>��	��W�F-�W���GϭX��x��ٜz�˚o���>��7��)��!�A��B�`��D��>M%kMۣ�������%�v�tQ~> P`:�a2���i�Ģ$�1
�Z�FV�s�����w�����F�/ʲNopw�}_��`T6C����$����ec��DTM#�J�$S�T�i�ffȢ,�t{�d�ǋ/����4�K���L$����n��cd�������<��u-���e�n�j:�n�~Ŏ�\\��B�n���0�~���ae�_�=�SǬ�Շ�⬓/bǞ��.�`��+J���ӳF:�a��wݯ��SJIi9/L��s��B�������uv߲�>��(/��琎\"s�߮�\0�j�dn�pʦ�����!���b1z�	�x4
-�i��������h0@4����/�\\c�k��c�ػs	�@�A#�lƆa��F�m��������׆=;��u�T~[àcnK��+oe{@��\\ӆ1�H���i����<t��	pأA]N?v聯���a\0J2E$CI&w� ����+*EWU{N�bA�]!0u�����WD�Er�.\'�.u�t�*�zD�j������g�^���d��t��\07y�!��[���X{S�1�H3��r�?��=ߠ�^os��y��8���=�C�x{�����c����ff�V�cߙ�?�h�]�On���q�(�q9��]N�ꖲFcwd�?2�ޮm��d��یnI��{Z�e$��9c�ASSh��� �H���H+��܍��K��S�պ����>։X�%s?x�ݾ\"�n�?���h��Vr����G�/�zwt͖��ݰ���?�j��m���N8�[�M����r8��y).ȧuY	m��hSZJiQ!y���}�<�_����������#������K[QЪ������~��PRю��iձ3������V����7p�/`Ŀ�������<L	�/���w�����eo�tދ�{�e�[W����N�Zn��#�Tyyi���c.�����mI~X��+��y��N��Dk\0<7�ϡ��SZT��� ������~7N�ȁ�Z�%�{�si0>�\0\"�F�۶��.%�\"��>��Kt�mM��珽����p�ToJ�H����Iv�J)/.� 7��lq�,���5�	ssi�O���!p�im1��}�,%J2h�W��X�j�D4J4�i�A�,���eT.k`�1��
\\��k���L�6%�I��9����i���\0\'ߓ�����o����=�7_�I�n]\0z�2��Grs����r:wZ�L��˶���4��f�=��䗶��]��{@�պ�^���Db:����Z�UU
���!^�`����D��O�����g�����t�49�o�R��ԁ��:Pھ#N����\0ST�`�Z��_�����Zs�iC�{��c��ڶ*c�N)k۞��%�����w�ʊ�Q�z��Ȗ�wY�\0�=��;��\'��d�n����u�C∁����0�o�v&k[�:�<�\\|y�����������.DINk���2c�0�
\\(Ȓ����N�7m+rY���64p��3��I�aG�~�P�������C6C�#?X]G�T�|d� �z���^L���-N�Tr�̴,��]6L�.Q�7��j$�ɴ`D�RHg�ֈ��p J�6T��)_|��<���矾�I/�0�~�k�~�,�L<#��ϑΔ?��R5��>����棆/����f�\\�{ �iW�0��I�u�h�Fι�.��xx��Y�N���L Qf����/E�e�8ef��=�̄P$ʦ�ۈ��hj�y� �S�4�;��ǟ��TWG0&�H��R̝<�$�l+�γ�G�^|��!���Ac(�$;v�#SU�D$B���_|�(0R�N8������_+��F�o�3��k�R*I%N\"i��wݯ=�M�o{�Q�X�:M#�PP5MM��.\"q�]��g+V����g?��~x�����r��/�Cn�X/Bss{IB0{��BT6��vUǛ�����	�D|��J��]�~����.�>	�j����<�b=��(��ĸk�e��%�[�m���~��dD�q\"�(J,F��N:Dbz�5�E.�Mg�S���#�P��~r����$����u���/���nc�N:�g=OՆ��[�xv]} h[A�f��έ;$.��#��0�B2?*+B�3�錄e�:I%A<NW�J�<��j��ǿ�Y+������\0�pH��,g��Cլ^��b�zw|�e�F�.yp�+5���Y��U�\0{t8d��#	%I8%13�xb;36�|�礟gg�|��q��^&>s�=���)C����kS�j۴&\\���͵h�|����Wlb��E�+�Ji��>ԬX�lK��4(�4�������.g�<����\\u�S\0��^���Q����aW^Z�A���Z[��k2�S�b�co��<w�7Ͼ1�&�����h @2��o������y�1G\0#�zmjM} ���n�f`g򙚪��	���}���g�n��C0^��ө\\l�UUK��RI�	{=N��
-\0�
�s�k�`��i#������w+j��旬�����dп�m$���!Gt��+��Gê������t��3+?N����Dcq��(��l���xsrQ�&�AM*h�
�AY����$#J�\\���U�D,F���-Ukm�~<Һ��X�)ý7�ʴ/��;���<x�(?��Nm�DM���l��֘$�:ݳf\\��3�M^z�\\�}\'�`dd���z��_>й]E�x5�A��߸�L��u5
c��L<�|\\�O$~ь��[w:%.>��y.O>���:���]����\0�a���-���`Ha�����_xy�ʀ�{�>��4]��3B]���>�՟MD¤���Ϛ���\\�cXg:u� Ҙ4�s��p�誳O��78�/̘=\'�Ph�R�@} h�L�(O��q���qj1���@ ̌�sʁ~y~��������������$��#Mܒr|^�ݣ�:uFM%���֤A��!F��A����N�!�����2�Z���M������^�k�����EnKd��)��`�pC���ہ�^�������WC~�^��������Ka^ް���L�&��3-kMM��FH�`h�߽��8��mtʬ&`|���(�dƷa�c`;�2����[�W\'��#��[D9���[3ݙ���iK0������� S:Ѻ�)UmBF��C�5˶s�f���ϼ>}q4��r�.c�HD�p�ݸ�9h����gie���Gn��ǃ 4�l۸_^~cp�ֹ��-����˘�
���Up�u\0:�ׇ|�h����Ŭ�n2HZk����`��1��N<��%�x�}\0��}��w>�tq��m	F\"�II��)(�S�lɑ��>��x��kn��>��{ϭˌ��0Nq0{���T�;v|&O�7������w�V9l�lV��:m�1���2�������+���\0Y�PbQ�	|�����}8sDW�[�T��7�Π�Q�tmo���vK�u��)3>�?*����t\"�\"[��V�m
ʫ��?sq� �ҽ��̘9������xp��8��f�S��Ȭ�;2����mϖ�5���A���u:����a��(h�%q:dDQl��l���\0\\M\0��t�}.�h����@�~�A�X(h{�p��N�=�#)*�V1��>���7=9���ڡ#�|��/�:��j���e�����m{w�P�\"I�w�i0�q��5�� �D���;iQ��N�M��.���c�h� ڬ�J�$�����A���������Ӈ��m6*c�D��h�C%QUM���Wvjn��.yb�5�(�M#�e�b�������b`���X<t���~��5k�|���]���VjL~�`��o0xx[��\\���y���f�[�:��@8j*i)����l�������YN8bc.=��������y��95ڴ�!���OAY�A����w
�yA���M_���6����� 
��fW*{2C�tTU5�7�0�p(cTN����{����	�P�	�]���A�( ɲMr[\0�yk����^/>:����C��|S��y���!�(	%��Gײ���3d%��r\'\0�ٱ�pX��׾��9�8��ތ��L��r/�2��7�ЬlrW>T[�QA6˔����A y�����E�\\�	h𓠬k�֬lʛ�E���r�ߛL�Qq9�����!�M]�$Q��qSRZJ~i+;#_f�B-�!���\0�{�B�#Z�-����{���%�ɵt9hX�$�j:�h�U_����9i$��i5g\\��P�1�:�������Ε����!�S�<������;n_�X!��.��U�)oք�QC��B7����|N;��DQDv:�N{��j}=�Jr�\"�q	�{�I�n&�\0,���I���0J2i�}v�;���ׁ�9>�փ��2�a���<��p�����0]7���Ñ4�+�����o��?�X[yK-����w��/�:��Ӗ��w}mMGU3F�X+r�3:�� cλ��ˆ0�<�����3�Ï�h<N(b2�7���~r~B1���N�{t�{�^��*��c��e]�\'}����y�*.$�(8=&�P�e���Ս�~_Z�L�5l+I�%�$��2�$Y}u���N���AJӈ\'U��Ti�2�K��чs�I��g��`�}���I��J��ޣ)sj�|������M�����Yq�\\��^�ZW̩��y7��C+���>��(*�ѡ]!3f-���\0���3jc0LBQ0�, �o�!l��h$ݗ��u����x�c�@����?�\0�wݗq�m-�2�
�a�LQ˹IA�!�� q±G0�����C��ǋ��	X?�y%���lO�4�iq�F�o�Ȱ�3k�oa��0��Z΂\0�$���Ǘ�϶�MI�\0m��&n��n�%[�&aW-QP�e������`��>�b=���Wz��7y���5MT��zs�a�K�#�;����b����%s���l��
���d3�ҵD	�ۛ��;[U�ዾ�b�}ʩ�\'�z33f-\0��D�	��J��)���\"�-��v�wi�����g��]p��F��2��x��T.Y�{�уo����|82�n��x��ߛiϘ�z`&>2����	��<�����G޼�SO�wS����٠j������ƣO���cv i��Ц5a��I��0tݨ��1IZ�z����s���6i�\\G ~L���?�ƌ�^��鴾7�L�f��G���+
�H��]��1�D1Mts9�����S�a�H&QUպ�4���ۓ�������\'��^{�!�0�ǩ\\�9ƿ�����c�C��r�v�p:Ȓ��(�$q�$��6�(������K�f.^�DS��b�&B�r����\'�2z[c�p4J\"�͐��\0��~RX}�<MӉF\\N	%i.��֬��@!I��~)l�!��e�dJ#KaPR�����{�}��������ᑃ=���X�d�}g����`i����EM��\04�\'��AIs��F��z��i�q��A��*��,F@n-�\0�j����%���SUUe��*�H���]>/��r�(�4�l�.\'YJ���[��$�̐���<6ׂ�b������i�\'8m08���,۴��H,N�zϺ�fV�\0�k�GuM��O��9n�\0���R��w=��0��8�$)���&㻼m�N8�N��y�.�C\'�+F���+������ʦ�o�kkH)	#S���q���?h\"�a{.\'ڷ�HZ�Lg����k���<{�8.�i�cЉS��\0V55���:�>�hZ1���/����_:���A�x]U�����fo7�X<�;�=���K�ve��f`|�U7�H��n��!�,�dK�D��d$[�Ǵ��-e:��]�}^|n�$�P��4B(#�(M�s�k��t���p����������-ˢ%��j�Iv�0��QѸٺ����&��? ��(I���} �PV�e�N�l����V�n�0��/���*4ͼ�TU\'����P7�ڦɒș#�����m�MA��^iP�_�%P�dG�a]3�q!c��������(\"J�ɜ�dC#��*�n�4��ա����v�ZWT���|�&{�	��\\�qC;do
z�[�L��-�#�>�:/ks���,I�����LCn���g/@����&ME&&͘�,���K	��1��/�bV���}2_,�����yW2p�\0�K�\"���vG)]�̑��Ӫ,��fI-����o��J~��oM��gq�O���<樂�&���}�N�n�g�5���Ԡ���8�N��ig��%����j^���&��5س������6�����rbǓ�\\�.
���W�`|�^{Q�R�qc�k�=���G��T�Ib�\0�N�3~�������2�����+$�2�\'���,�B7�n ��5�0\'3$IٝCN���(f�P���7��<��`w����5��q�t8�cutK���^����t����\0~��+�O8K�[O���l����(�t�q��`�<�����Q-.tQ\\�\"�/�ruo�����b���yi	K�m�;���������2eQҦ������#jUd�;6�]ڱ����9�\"PJ����C4{����P�>���Db8����[9��G�Z�`��{a��M[H6�]?/�j�0�Z�b X�r�\'{rz��<��}��MN����*����v���^��\\\'��	�D��&;MK���oo.�l����fFF�1�C��b�w�¼O��^ZX8wώhܼ	%iB�Z�Vd��:��g�t;K��IZ�;�O��3b�E�qՊ&&/�ޚ��`Xx��[�Y�|��`����SNa�ԩ�q#@���BM*|:��ہ��en��e|	�[�c-�Y�Z������£�:��_��/�`���=͒�(Z�l)�� Y\\Y��$	Y������)QE�����hi��?p�y\'?��Y$	Mӈ+I������̈́D��/v���fDЄ��_������%	�χ/?��=���iͪ#TU�x�fZ��p�$�k��n��(�����n<�;#�T�/���%�}�m�Epĉ�}�	}i3P�KU����;�]��~�����K ���!)����������ً������\"V\0�&�eނe`͚�A8m6��K��@�0���*;�NW����qb�׷g�%���_l.b���-�n��U����E^���;��������-E�D��˔��Z=f�A�R��F��ur֨>�j�1���?�*ڰ���h����C��<��v;��H��rsF�o]N8#7	e���%��0]^�e�R`
p��U���ڋi0>�ؽ;�m���9	�\0ڕ��{P>u��ntl��Q���0Dy; ���Q=	FCW��̲p8�$2|���~K0��-��u~����y�3�3����x��ѡSg��\'��G&�F�~��5/�|glBQ�#Db�]���,YSg|�(��4�.p:Lr��-�|�����/D�4�Q�kV��m��qXu6pI���kt]CK�h��K���:jR!
��)�kkF`*��������R*C���NAy��uJ���/b��b������Y�����}~�t����7��1oL��ֲm���D���L���t���K���{NN�Ym�,Y�ͦ�sQ�p�=v�c�׮
�\\)��q�;@e�2������P4J8#�R������5��zػs�9�:���j�E������<�ѭKK�w���M$���G^\\}O=��z��+Z�DI)
�$��/����Ϻb�����r愔�ࣗ\'���0�sg(+k���$��l���Y�4��U1��6D�.!ڶ��i1�M@�2� \")� �GU�I	�[�锹��9����Gb�r\"��i���,�7��<0����s@p1p���?��G��3�v���P�.�n��Q���q:��U�O�<ȿa���r��͵+��;�jY��l��\\,�s⩫%ّ�RmQ�]Y�CGM&�G¶^sMP^^�~��i5��A�0�L�A����f6�w%A�0��Xlݰ_C߅�J6{/� ��q�8Om$*��j�%�ђ;�����������u��f-
��݈�$���q�lm�\\lU�zuk��m�������r&�D�1TM3[=�=z�0p^ ��仭t�\'3�U�:9�V�}�iz:
�>=�͛���S;�oK�fNǛ:3��r|����8��=x���9����X2�ùs*�J�kl��u�>��>N�5u�(IA$�m����}�р�����^�`.K�h�?\0�7oS0�3���Qf|��ہ����a�c�9�lXc���6Ӱ������^�H��@�Os}�c���U��=�(��O$/��,�Z.f&�Bʸ\'�f���lP�ɽ�����$?�K��{0c�ι�\0��y��{3��a̛�Y`��!�q:i����-\0�h�Q6���$޿��\0Y�2n�);���~r��V��Zv8LU\"���gH���%la��������#׺Z��Q02ts�{��G_����J<a0B��N7��u��m��o��5��]��jͮ� X-�oDW3@E�$�5���y������ŵ�틉��S�W�!?�� J.�on.�-�l=��@UՑ$�@(�;��ܛ3F#Q�d�h<������ŗ_H�n=յK�;x=LtY�d���\"jJ�W��u�\'��Ξtp�=oAM47%!�1�X�� \\�l��So��w\'��qן̭��	�ȉG��Sk�
GcH�L*i��$Sy/��=p$�S3v�:�lȲU-�4̸�v8���s`ı�^��#�|�Ό4��(��{GпO\\���
�aj ����L���@,�����Rغ5����|n4M#l��Ǧ��˭����i��������s�X흭�������݃:���ekQBp6 ���=�EӂNr8�g8���҇�V���J�04ϔ�
�4�Y�����G��qB�������ٮ����Ʈ�\"kͳH�*�EBG�� 8�yq�ƔeD��6R�z^�n�VƮ��N��\\Gz1޾h-lBͪ���G�͌<��IMq��9�)Z�%_^���G�^��T.��讪:�V6p�͟��K9\\q�?���W̘5�x&��֮u+��5c�6��hg�~��Ϋ`�W3�^��te�I�,���\\h)Ӷ4�k$�f`|����\0=z��	�(dTJ�Lnn.�Y�d�]3*d�;�?��9k~6�����q��|��8�޳.��X���Uۨ�PO���s,Ӱ6_靴�|C&���T�B�&��}�n\'�%��oל?���0�h��X�\"������a�[nV��u=�!�YJײ(\"I����v��$�\\ ���4�L\0Ɯi-��������M�|ŋm�t��T�����@ <�辽��������~Ru��}
���K�\"�,6c��k������.&�d�~�=eڄ6�p:$���M޳���љ�u�a�D8�n�HS@v:�fS&9LBӵ��v��훼W�C��-�F�F}mM�A �tY�����s1�k�\\����C���1y��Gu�hM47�*�1tMk\"���2x`������gө�����O>���i���a�p�I��c?�{}i�vЦ��+M��dI� /�ܢb�8ru\"Y�&��)�a������#��gn�|x�98�.��Дx�h��	�������尃���,��}�I�?A$��]�sn��^=�����8���ԫg��K�a=3�JK�/E��e�vvw���z��9������ff�Y@���Xf�\\I�6>w9Ȣ9c�L�G��_���L��K�_Ȼ/�}�����z2��������r�l%(:���Z��e[C��~�.g��f��BFh�]��%�}��k��;[|�,)
;$�;<޴	5�v\\\0��\\��yM�QJ5�-ZRx�}t���|k7g��l]r���.���q�p�q�\\����3�g_�l���k�������z7���`x��Cz}����&�Ѯ�p����߃3��6��9�u��,�~�@00��g&6�n�#�H��D����Z�R;;��H$`\'2I������ J2j*igX#2i��]Z��Er�&��L��\'�qb� _��V�[��rǿ�rԠ}(oU��E+9��\'70H$�,[^����W[8oL��=�M�U�f_{�ë���D�9���}w��3�Z�=O�< ��#��ihw9Mk�\\��׃C�I�*�h�˽�q(��?�j=�c�����]�7�(�x\\N-��䮗O������By�׾w�{�-,En���u�H���`�J*(���R_[�?p-��@*����T��?�v�������8��DAL{w��IV_^�2@�ǋ��a��u��X\\_[sp���f}PM�}����f��c8������o��tu,���ɦ�#�	��M_/��A�oW�]�&5C�#Z8��`��Lf���`��FEE�N\'���i�r2�T���Ϩ�!��@j*E2a��5��r̐�)--��ʵ��0��G�R�Q�R2բ�/�/5ռ�0��Ս@�ˢ/����3c֧�iyܴ�������!g8��H��L/_,FM��F`l����k&���\'�����1Y�o=����h���C���LY�4(�6k=W\\�mwȾe���s�5���{������ޕ���9�]Ȑ�{�������$���d��9����TUE�3�06- #���4�t߿���}8��-�h�\'�ty��%�]�A�Jni��`����x����@U�G.����<�-=�{��N=���c�K3=�����3dڇs#&�+��J\"98=���֬�CU��߮T6�O�n��M[�۶�HC�O��^@��.���%��̵=�]N������p�&��]�0H�*�X��@MM���ӛ���q(�e�q��|�Ä�	�)����QI%���&�L���^~=��.|RI�p�j6�[s0�X�`0j;wU[k�%#��!�����h�y�+��5ϒ��^ٱ�p�5���i��o}�d<�?p��\'�0��ї_��by��CD�v�/	�(Z�ٷ])L�uS��9��*���?T1�T�TҼ\'��o\'\0�,�m��f�ɔj��e�q,d����s@���?�ږ�g�˳�Xh��~���  �2N����bR���u�������WWG���ż5���w�C��^���9�*Z��
��D�x(D~I�Q�/Zp���]p����74�R����o�$�((\0Q43�dI�f�*%�I��!˸��v��_�#��:� ͑�O^9����=���{QZZB�ҵ:��$e�1]1
LCMM�7��+�3ts3����E�-.���3\0�}�Mw x������py�(�dZ��W�2��������k@�T��1	�ջ3;��A=Z3�����\0f��²���(.��j�X�P$�/7���Loy��\0{�2�(��(�<x�RU��45��G�LR�d�ğz����-����������M	5�.w�/�\'12Ϋ����y��~���H����u}�y�s\0+g��e`$MU\';�M$Һ`���I�O��J��Cл��4���j��GE�(��/�����3]Ȓ�8@$-��-�Y�N榻�q��VL��oz���==��̏?y�Uq[J�T�Ǉ�Jr��#�DY�.;��$�H�X(������W����x�h$̇���ݠ:����H�w���<�����{o����`l�ʧ�x�u��s�>�j���&���ʞ�J�U��)%��i���������_�?n;)�q��������l��\"�.8��,����s����0�+.;���\"�y�Q=?m���ۍ�r�t{v\0d���\"�����j	\\F�e�`Pu+艦��t���.u]C��f�7-i�\\�Lԃj�e�n���_��!ڶ&�a�bۋ���e[�����װl�������~�����^���X���i0>戶�xy7�rAk`���C+C��H�x<�\"��Z��W��ۂ�eҫ_s������s���(�X�\'Jֿ([��ޜ<
Z����Ӣ���|��Vz�N�ǩL|�Z�1�f���t���_���0/�`8�$�蚞n�蚊�V��c�Y����VU��P���a�e�٩��=�{���Ρri5���wc�;g�dف�㱲pKn�Mw�Q���8w:[,��5�u)[���dȩ�h��?_ [%6J������W�.��/73�39�Ss�m\0��<��r���dK6��\"�֦��$Ͳ����8����k(���i)T�\\�E��U�%�����d��h��b�z@۔q^IR)����kl����&�x2en.����7�!Y����;/c���/g�/Y�pn��P�e��K�}[��rg�;K��.��lkl$7��q۵1�o�N?��,��+?J����mB$\'�J�PvN��-C�$n7��|
�[�Lě���X��g��c�Y�p�\\2���|`�(
�\\\'.����\"Jf]U�(�8�P��]c�����ruC0�����>~:w�RV줤ȋ ��%��M���گ�d�n;ACCESS���N�I�v8d���^ː��J��/0�q3%�\"�E2L����ߝ����E�jZ1����&�}�2���y�y4f��-���K�s֙\'ӡ]�}d3;�ؘ���\\ͦ8F�z{Y37�HuQn�)�໕Aз�,㊂bY���5�lS0��3^#ABQP�����\0�

���W<��^Co�5�5($\"�`$��WJUA\0In>���6����M�������Hp������G\"D|�p^�֚3��G�+��yWLg�k�ā!W�g|��m��m�F���0>��}Z�t����W�{��4�rՍ�T
]7	D���a�E[\'>���\'oZ��V����W����K��v�<x�!L��1�`����G���?Ҹ}?f�7��`�������T�x,jwE���^��5�^��f�K8h�em��vs	K	+SAK���Sߨ��D�U7�����/~=M��#�xg������ӼU�/UU鵬J׍�*�fϋ�ؔ��z������V�4��,���u0�}�����ffbJ2e�#tKiG}f`����g��H�x��*3�x�._m��r(%�H�a�p��w�kT�P�%�5\"(�����zv��`wM����h���k�)�,6)\'�#1�J����5C3�{������y�gP��D��iZ����j2I,仅�d�j�}��a�a%qX	��Ϲc����{ǲ�u�lۺ���MMz�=�/d�U=Է����}��O���&����j����?j1�ˠn����RJ����\0#�/���ne�NN^��_���[�x���1Д��3��9���Pޯ��S�1���:Vl��d=�����32eð��l�,1�Ak�@$�$S�t�d��\\��>:ߞ3�r���e���`�����	�������)
�G�|�OՆ�ZV�i��\"sDK�a,JH��=�_w۫��r�v;q��Č�j$�IS�8��C��k@Sʱ�uEe}mMe$��������}��o[�Y��\0z��f/�[�ň%h���,ܦ�^Z��������1�ATU%�Rq8��M��*���Q�1��77�L/2Ca�qp.7ޜ<�5�R,^b��5M^C�u�T
I����D\\.�l��ka�\\X��H\0,h�0G\"�_c��<[���@z����	DQl�޷ԥ���7=��M�����i�׼̽v�f�������Ү^A;�꒟렬�þ{�).)��+?jƧ]7vYc(L����͵M2�]
���>�Nw/���;2�n�O�qf	Tv8���_�
�d|�X��7X�q��\'t�,2��$�������7��}W�<�{_�)CϿl�,�Y0��R���&�dz]��(H��K@�4�l���bGQI�E�o3G���a��=+�Л|.�8>��׋��� O�D��EI&��k��d+#pz����B���U[��bTUc�U=�U�����\'޲�|+���PU��>?�E�l\\�]�~�$�|�^$nm�0���r��+�S�׭]���	�ZU��&�!~���f���dA!�<��@H�R�<L�Btk d�=�J!9xr��-*a�5�b�(Um��8�Bc(D2i�������ʵ�y�w/���u�H���!7{�u�gs]�o�\'�����e}�������ِQ�N�@�����ct�7��o��I�}��o�{Y0!ز��~�N���G�.9so�)��.b�k�5����qf��Խ�G�5N\'��©��-=8;�ЇcY��z��5��x�����L�J������]�`.�\0L��o����g\\0Z�es\0N�P3�J��,
�(�-�)=�����|;�P�1R��֮����;�0�����n������Q����� ��;	k���h즉�Ӭ��$��C��`/H�DEE؅��������{gf��Hs?�s�-s��{�y�O{��w\05�Q����wʢ�&�ĲK-c���\"�$BH׊B4�K�\'<_�|A�e��]�_�o������O>�	�P�sE:sX~�Y(GiD������K�d�!�~��XL���%������G����y5�\\^�D�P4FEM-��`�̩��g���k��39?��h:��*\0v�g��<����L`��W��n�f�m$	-&^݅A���릾���\0�s�O��Қ�!K�V��⸵]�g�)�̚~t����Yg����>�P|��#��}��6�q�O�����P�=�[�o��d=	<�6��ߞJ!�l�l��e�~�S[y��
�]w��n�g��N����7/�N����l*�r�Dzt�0��ԅ��x��9\\t�k�����PA4=���Qյ����s��^}��s[���l��_��e��N���X����>.�I6,�(Nj\',�i�|U׋�[�x%��3v|�p��g���(蚊�i�>��㸘��iZ~\'Ǝ�a��,#�%�N3oִb?wm�07_7��Do?-X�J3�<BC��;e�!�?��]�~����eY���Ra�$#KO�u�����?��?��O?7[�$L˦`�[�g[�Q�VDȨ��\"�EP���up4�H��hE%�d�1@Z쮂PI�s�#�^ߒj�`�E
�@I\'Z�@E8��3\0�P�p��h,^���TU�D*+����w��$M����1��JVd�uH%�k����#Ɯo��;EQ�)�h�H$J4n��*�B�8�Q��Y��\0ST=D8#����TUNɲX,�b�	��<�u�)��LѣQ���h�p(�$Ih����h�N(!���g�p��TM�W,���ڔ������ڎmM�ey�
��#ȊR�v\\���)gC�ix�c�z��O�Qגj%�p}�m{��!�m�.P����1��$WanztQY�2h�.<2�6`|�/oo���\0ƛ_P/�s�#M(��6��2b��-��#ɒ���6�L�Lrˁ�;�tI����X���;m�6�EZK�u�����B!MՐeY�yy��8��yE�?�R��u\\�%W0�䲤�9��۬�^�S��eZ��f�ec&��l��q��y��6V)���sEP�Z�����vT�����S�)��L�l./�J�����XoOz�%������+��Q�����.����I$j���I&M~�\'����<��\'N���H�����C��Y0�$YB�4b�0�p�����2����HK2��9Mjz��4/m,{=�]�L�F��F�~���7j����F�T���&Zw�R� o��?=O�i�Z̋7EP���7���@�\'�!�M������q��#	UU��(��<�%]�����E��\"��������������A(I*�w6⻗>�[�L	�h_�QV|E.�X�`̪���4Y��0:g>̙e[3W���\"8��	�.2�� �ʙ�ͅXh�X�n�>=#���+�P�_�y��T&CK*��`�yk���H i�~���\'+�&B؞��z%�wI}ۆI!�!�J�є����֮�Ǩ�����
է�T�3�����>�_Jr;�{-��vD�P�0��ğn�Qyt��?5>�˳:��y\"��Z�&o�ʫ�eI|��\"��Jc�H�Zz<X=rӴ���(�ֹi�cmˤ�{Ƴ_yn`\"0�G�(7^s0g�+�h����b���
��˻Lg��z�V�@.����^<
8��K��z\'������_�o(����߅�/�Fuu/��xr���Gq�u�sϽ��FN��E�խ�; {����$��P]ӄ2L4\"���dk��P$*���M2�3+�dE��!*�X������������,{����{Im~7�x��>gE�=@A״~�����@�=�~�`Q��(�ⅈB����<\\ǥ����Ѩ���kܻ�?M�\"X���5�~:�D����Ii󁅰@��Y�����[��:�\\Y�����3>o�c��8�g�A��2r��-6S�Ǜ*
W(,���S�ٌ��
�t��0a]�d���i���U�6�l3��?�Sv����}�#�^+Ib�/r��7�N��+���U}rMUJ���?�(ݧ�9b�UȾ❮iX�M2�����dk����_yj�q,��ql�|.\0���حo%7]s0ǎ܅��]��x��x�d����-���(��L�:��s�j~��a�rܾt���jqx�hm��gа��E�p�]�� ������Gy��ϴ)Oq�W�<LQĺ�v�&�*��H��>��Z�ְ`��/�y��矎�B����y�
�Q4=P�)K�E����VJ��:X$]�����w��\'n-[�;m�[��H�\00�O��A\"��r��d���g�q�D�%B�^����@�V��ڶp�����6�\\0�b��]���ES�r/�x4R\\�6�����V9��E�l�C�͵�ݒ�M�2ô��o	���e20&Q�;�I��k�H2�:��Nj~迓.�R��\\n�a�`N)>�*�ڤ(mCВϗ�%`�m�U�J��j �b�r����I�4U�?����|x��L�����a���r�Շ0�^TTVQ7o	���/�V�Bv�����
�)bZ��Ƕ1��\0�hI���RF�;]�;E�,8iҙH
ͫ3��
t��E�<���#��\"v�s�3i�K\\p�Y8��9�U�>�Aw?�ﺭ���1<d��6�\\�4xg��}�׀���
����\'<��+c%I´,MoC1W��Z�i+�k[&�l#����^x�5�:m���=p���K�\0]�v0�·�e#�*[�Ųl
�I.�G�4��֠��h����)��^�TF����Ri�tYXY�����c�2������t�]�V!���$\0d[l6���6�e����b���Ӟy���1�px,�Р\'��X�\'��Kj�Jr�x��w�w��}�߿�=w�٧���g�e�yV�n��x�Og�Bz1j���q]7X��\"�~�+�\\wC�I,V��Wr�/�����˯�8��ֲ�l���q��<�L۶�e�[q]�{��<���C�5Â�-|�`9ɤ�Ф��9���=�W���c���߳7���DU�C��s3�7S���\\u�F�뺘�9Q8�\"
zr�^<����� Wr�������\'�ls�I�}������򨪶Q+��y�P\"��n꫃�!]�t�SN�����.t�֭B7�{\\_OC�p���$uu�A�>}:}���A��X�ATq�xp�\\O��-ۦ��MQ�m�/>xg&~k�o�捷V/�0����|ADR��V\'�([��<�Ƃ���a�4|2�Xӭ6������sK�����Hnv4ϸ<�D�[�_�=jU�vѐ�K.�Lt�
��\"nێ6����v?��W:\0M�|�����=FqW_w\'�d����{4p��|2h̉��˿����LHE�
T=O|�:5��w�����[���%$�A����7\\�
����^��G��jk���\0�HTT�5r�/��^���umv�B!�> 2bH~�����~=}�>䢫g�M8�g׌�,�}{/((+�W���$A��(W����0=�W���w��:x�����2y�s$�i�Yx�L.�eu����`�s�H���n��rҡ�t��3�p�����ӯ�n�~֏\0N���wƣm����T�:�,^���vۍ�ݻs�!��1��6�\0]WWGCCuuuP^��\0�}z����L~p�v����~�/�ЗZ����_�d����u��J[��@kK��9���2��F��}�6�w�2����<�dK���\\�L>��z(�)0n��&�J&���E8dP�V�i;���2��t�$T<I�AXA�}:M)`�R�P��-Ε���TN���O�$�\\B�`8�D._�q�l�=y��n��D�XoP��@,��{��e�x��{x��!�3;��� Ib�,�OU��(���UU�\"�^�`��`�=�O�*��А�#I���.ՏNX�%;��>�{��s�0�>�!]�f����;u]CB�>�6-d��w?i �n]+��i�ug��c��._�\"ֱm�A��E+���I������&�N�R0�o����v�F�ܨݺ&����\\>k���!�D}�\"��z4������q�����}�zr����`���=��뺼�����԰�n�ѧO�N���H$1b#F�h��\0�g̘���ө��\0�2 u�٧�&��ylB����ju˰խ�eb�_�-*�eEAGP��g�����g������byc���]�[M�[u8g��;HQ��>梟�<}f2�!��<�Qۨg��/�X�,ɻ��{�^�W�ij[\0��\"����t�t��38G*{������c.=GB&՚#�5�5�|�B�uN?�PUq��}w�B��巖����z\0�
Z/?t�����i�#B��_����k���	�:h�\0_]o�8+�С��[x�m6Aͤ���;�����g�_��T���D>�>i\'.>g�P�x艏���E�����k����4�����rؚ����{�\\J1����F4-_�ʆEd�-~���ּ��(����U�7�b���l*�B���p�on�3�k�����	^Q��(AUd�nb�̏}�)ͣ�=�M㮠_��AΠ�㺋6�}�k<�N��3g��_\' oe4h��.(���ә<y2ӧO�N�[�<o����&���e��l>O*�!�ˑ���<��a��R��E_��XАcAC��g�\'���ZE������]��t���q�n�\"5�}��Q��\'�+]w�_�l͈� ��4@��x&0����*�����fUڞ������o�7k�k��y���8²e�\\{ՙ�[/<w5���hJ�i
�3�{ח�|���N\0..�J�X�`�k�?t�,�^��(cY.�$@�K��T�e��e�xX�i����g��`�]��WT�y��v,�%[����>掿\\��.�v���%��q:�����10���@-��ߓ��
@\"[)���cF.��jSV.^t�A�|E��,�5�ԟ]sg��/���e�B�A���+us�HTp����gR�P�	
����l����}�ZxO?��s�͛ǐ!CP:�B촭�W^y%�d�I�&1y�d&M���!���N=1i����^k�W�s9ZZ[iI�\"I�؁[&�{��wf��/T��8���Ƶf�~��i���H�6ml����S!�i�ݢ�z�!�|�n���R��׌:��b��On�}l&�ð,��B��gG��/�����Gfr�vUD��Kp�Fk�u���7,����ߢL.G2��(pl����A>��_�ZW�:�YU!j��X��u�!\\�\0[�r��C��f�N�!�\\�\"��u���B�cםb��\'R�$�pX��*�}���7K`|���uUC��:�v0���?�اo$9^��.�{�D0,�������,�l��ڮSlӜR?�.�ۭ;���D+*�m��a K��uk����,I�_Q�`�|j}�
j�TЯo7~�yz�P���r�}�7���?�(�ڊcٰq���~ϯ���E����w\"�6���������gҤI�{����������c�\0n~���T�cTWVR�	�U��t��O;����t�qL�$�p���΄tA��(�7;��c�&�m������g����N<�/ݺ�P��bF��T��\\{�؂/U��l삲=�1@M���N}�ۓ�D1��M����~{�%j����_A�dk���[hjj��=8ۏ�Ĉ�\"��Be\0�� ���\0��Q��a��{�+�s5M����]&3�+��*��\"\0{Χ�ģ
�F(��e�Q�֌E�\'�A���r�O���?؎�a+�h)uqmǴ��E��J�Ҷ^-��ģQ�++I�3Ź�8�x�P�Q�c]z��eY���Bh����jT.��B�:y�MVd�H=��W�;��6������x��ݗ�=�P��s�m��[(��|�T&�m[����B�@�,��iۮ��׏+���+����ӧs���{�g~����n~�)*cQ��V\'�z�*ZZZ0y<�CQ��Mn��/ױ��\"I��]�o���z�,�yo>��\"����:����C�n��}��Qg>Y��<�_�0-�m��F,(��TUQݣ��<���I�U�o+���-k�a��Loinn���
�r�E����/�3��w�W��#8\"����o��!�Bm�`�+��m�@7\0ص͏|^<ϲ�{���h$��O���}GD\'J��d�tH7�8���/�����@��C0v���e0
9<ϥyi�5���R����`�҉e��6�S(�F�s�>YV�UYV��{�#��N@���,@�VT�ڴ��d23 ���sJ+��yl���W5��fql��:���a����|��<��#�\0�Gw����_���Ke%=jkX��̪�$�l��V�F�\\ҚrA���h`H��*������=����n��6`|�ϯ��
�m�����\0��
v��#�����⟍\\H}�*��S\"-����ykȮ�G7y�|�D��S�)_�~7��gs������6@��(���p��(�XӄG,Z^LS\0��<��.�$���\'���{�[���G\'�&�H0���/i
���yo-a����`�r�ϛSd8;����臇�!�\\�y�\\��}�6z*!)�`��J���M����aB�z(B8G�ejz��׼�q%~Y�i�m��G\'��t:��rD��s\\��z��穊���\\Ъ�c���vڎ�5?����t�Mk\0���5�j�o�ՕԶ$YՒdu2U�p|�3�bQ~�������s�
��$�ۿ��|��QgNl�A��w�E�R�����D�B8�7q�$pXЦ�4��O�Ȳ�7�m��0-_`�����\\A!i�Zіa��6�pj��(���3G���W��n~���v ���o%���}k\0ܑ���HT��փ}������i�
w��((��
�FE�&G�4$IZ��d�vl��1�Ϥ�7s꿁1!]e�i����#���7�E?�7x��T:Ck&�A�J�Je�dYF�4�H=����<n��5�
���Z�k+��[�o��iѵ�ôH�3������ˀ#�>����O�yg,�\"&T�V�N
Ř��Y�c���	�������[m��*]�YH
x�)q�y�ѧW<I�n�F}��\"��w��E5�ۚ[$͐%Y�?�Wu��<�kC1��2�H�x4J<!�*
�e���h�d���c��<�C
��d�-m�oOz*��s�!>��Q�*�JDW<gIj�o�H�$�u�v�&�ڍX\"�ki�b��+���khzU�Q5nY�h�0���ϓϤ�g�̙�ڿ�1��?9��q �������y��o��M_��dHgsߨ߿���ɢ(���-m��H���t]C5��Y��v�</�F�^�E�I�3�Z�=�Ӿ[�|�Wp�UW1}���\'�v$p�7f̎G⊦f��)�9!���<�.	�����}��s�8z(Dk�9ǑY�\"�g�s��o�Jw���\"X�,��*a]/*��>eiG�O��aY�iQ07��:<����S	��Y�x��L�����G.��\0�+��c^��ۓ���Q�;��T�{�>W�G�;.zu��EA��&H�T*b��-W�
6?E�����n�%;��k�a��fڂqX�W�S�π�$S�N����0��[�8/��P����7�d�e��b��ʊH���*�P_b�9�Bn5x������g��z;�u\"�w�ĴiӘ4iW]u����ǟv���^~��q�P�h8L4&�/�jZ���\'_d���,��i�o�������JTV����?~H:kL8��k;���l��0ML��s=��,Ih��N�\'�u��EVx�/��K[f���?��w>��K�4U,Kέ�����Ʈ��Y���������q�X^��e��@\\�s��e�#[9�)B�%5)M��p�������N��w���zk����t6K����>��bAc$��kF��3�k�^>�%\0�w�K��ō�2���b�&�f�p��MC���?��p��������H�&�s80��)�=�?����#�uB�w�N;�4F���7��=��p��Gv p�sSߜ����d��tK3\"��s>+���}��7���SU]WYٔ\'��&�𓟏��N0.�rs��L���Ǧ�>]D������@
Ӱ$�#O�n8�����/�s\\�L.G:���Y�Wl�&�����x��g��zF�s���q��A88*��k��n�(D��/��9,[��4(��r�Em�M��_4�y��A�0�<�7\'��������7��Nٗ�v�N*���Sdμ\"�>��_6��.}@.�����%\';y�����9/NYď؝C�-���$�x.�g�\0<��;��ÖH$���9��S������)�����Y��)K�ea	��K������|�	G_�A��}�ضY����&�>]������$�;(�HJ�?o4#��1�?<���N|vv<EUZ�h�$e�:�o?�d�\'~��>���j�+N ��k����+ކ��Ɔ���ռ��_7Df�H���$%�T��C������a��NMM�T�������,/��W��Qhb��{A�%T���xxkl
6�%_mKW�N@�V\0Y��t���~�����\'�!�\"���P��eF�:`hG`�i�=1b}�Q��|�qC�\\��_��K���?�g�4��F���E񽎀��� ��M-I�U���+����t�ӭ&��T�ed���}�S����� �����������G������85��C!YVڀ���88����S�ey�g�	#�!
������ W�3m���mK��l����������=�ص�G�?���E����x1���K��`|�U�lTU\\?�EVUTUAS�OE�}�����n��Y\\�v�<�`Ϸ��y(o~��N$A��(м�c?�9u���đ�1��
к�\\	JQ���$�贶����ù��I&�c�~?<��K�~m꼪x�h��^ٸxZ���P�uQ�((��LEc���5������� �P
�,��FQ$�Q��Up��X���9�{5\"�I��w2�����J����y�%\0N��/X42��84\0�a��T�j�BԢ ���(d��~�k�;\0z �=�\\q5�ϸ�?�A�X�F�⶛ ��T+�0N;�{�e�]���7ZwPE���zRi�û��R���.��9�\"*���Dv�[��Gs�u�C�W���%g]��Ơ%�q<@�Dj8��TE)]�2P@W*�vۀq�^v?n�Ԛ�e�L���\'�q[�*I3=ϛ�	ț
ȊJ$^A(� ����`{ĜO�xr�WT�T��hDAS�nV{��N��N;�A�q��SWW7x��cF��қo=][]���,X��Lk
�P(I��������%!w#�m;8��X�l�~�������ވ����$�
M�B&k����0\\����NUe�e˒���g7�y�\\�`�`oGbQ�f�h��E���L1������QD�X�Ɓ��x�-�i���ZR���j�������
@�A�q�~��\'qMl���[{xn�âP��Tk�9�.��>��S~v�X]U�$|9SKIJ��C���!�������\\��Q�Xy�y�r��,�����?��&�.��p��y�������iD+*��ڍ�_}!r|)�M�/�*����g���L�s;m�ׯ}�^xaз���8��)�g<�{m/[���-�|O��P�N0.w\\$A��>-hȣ��6�Sxyz�*���EIC����o���|o��>u/V���c�Z�c�O
�=�5�%oX~߭����{�>�\"}|Ay����W�����I-Էy0����u��LN�M��w>L���+��Y�����軖eM��5�߮i*����
���K�pۢ�QY\"�Z�q������z�ؐ��y��0�9�B�O>֦r}mv�������,�Y���@C���\'�b�v�p��ۉT2�#�O&�l=ɿu��4YQ	��T�te�Î����onh�o�\'�i/����A촵��?����ꪫ\0�8j����7{��Љ�tV�n)�{m�J��AT�\"Q�<xȸ/>x��L��$էϾ\\���^{�r��;�j���Óy�߳@��>�L��Ԩ�i��t+�_ynw�1`H��;��Z�.�
چ���l.�t=\0�A~���W�\\���qMU|o�vLP���0!]!��T��>^I6\'��O��cC���D.�+���3yb�\"��\"��\"��K�V߰���+�������5r���vg�k�_��|R�07��+F9��9�H�t��y�:y�\0YFG�I��q�Q��f>7���\"�硨*��S�E�����Fˊek�_�N��+��_�~ż�Cb��UE��+�V���6(��`��*��J*�k�u��[8���xէ\'�V�{Ξ����g��e3w�c6K����䷿_�̤I���W�kM��k/ǴA��/������q����^#��(T�ct�ɗ�~��\0���9����cŪlG��p�E��U�0u6�\'�i%�L�QB۵_-���r�G���G@\'*�`�?�=I产���R��R9G}��44,m�D?b��܃�{����2�{&\\pw�u+#�<�<{\' oL�K�Q5Y� �X\\����_ �ڵ��UE�t_9���N� ;���ׯ#G�$�L�~������M}�Q�d�*��&���\0��̚$I\"Z���Mc�T�\\��6�B����q�`���>~��$���`��~5>��a������)2�$My�8�{\0��p���w*� _,o�@\\dY�2����ݿ7��B6�c���%Y)�%����}���R��\'���ιh�����G6�#�N�M������`�S�j�����U�X�\0^+ټASs�|��R=\"��D�at]E�tTUf��}���nI���>tO���<ᐎ����͢��\\t�-\0L����ψ�7������1K�i�p���2��\"^B�U]|f��%�ܸ�pK6�G��N�������/���:e����6�� �\0��0���X�he��wl\\�� �\'�sqL����f��R�h�\'4~��A�TU�9��O	�+(���0
dSI2�>��rqLw�W�
D_qo\\{����Ř��cQ�k�����p,!,�n���\\_��u��R[��-+��e�YU���B (�@�4�<�B#�%�J��K��E�������=��ߙ��Sg���?�%�#�Γ�����zh�FMME�QTEQPd��(L��T��QUY�N���Wp���V�9���Չ8�X��De��U��6��f�YU����6>���U�cx�G��J�u�A�.�������JgH�Z��w�r�}sP9rd�O9l��g6��MК���;�x��Q�4��������y��*Lf!���a�T��9[��ٚ��Ɛ<�(�)B�-|4�壀��.�Ꝉ�}�]}︺ݘJ����%�H(L��j2�����x#���\"I���m�+ۜ�+�t��*�TMG�el�,���q�	���8l7�u�b��/9�������wWU�x��=ӧw-��ӏ�w�?�s���L�׃�Ӌd���
 W�c�q��h�h���]���B�e-�;�{-�m�چ��(�t�����G�2ǒ��E;��;�Y\"�X�O!@��D���	�F�^?%�w	�K�/!	(��7�܁L���|�E��YU�Za(d2d�����jQ>�p(\"]�(���������YY��H�X�]|ւ�F)�+�C���:�@����R4���۶m���-�Ϥۀ���ۙ�u�ԏDU3���3~X�	��|�*֓���Zۃ��L��[3�ީOWN>aZ(�����~|kp��o��PN=�͠)x�w�n�ݶڅy�ٍ��z#�P�bs��`�1-�?,�����O�oP����������̋o�m��xE\'�t�f�禽���O����N0�\\`.��%Yԏ�<쒹��m��i2-��3�}}Ϙ�����X��{�](1o�Hc*�R��#�q%]\'�kDBaB�����\\���������oϥ`����Fǲ����m���_��!��Fy}�|�>��b{�AǞ<�(�0������:kh/�u�r����qYQ�Uy��Ŷ팙��/h�z�������������^ޘ
��k�o�-ˀ7�����8��a���Gؼ7M@^.(�D�9�(MgsE�R����i�6u������_�7�G��-7p��Ǎ��:m3��)#�8f�32���\"?��:�xv��1HmE=�}�k���@d\'D�q��~��g�(*;�Z�MKk+��zgGd3o��;I�囟v�q�k�u�����p&�89�]����q���E�<�i\\t�S�KN8���um��]�m�%�� t�B�m>�6/��4�p�!VU�b��ӬBǶ�5/ml~�|EKd����1�\0\\��㫮��\0��ތ:b?�\'��»=zڻ������s�n�ӓ[��-��4��hN���\"����E�y�������HRL��n����ym��j&������@�#�q�B �<�Z��v��:m���?kUc]��v�C�%_0ڰuu���\0�-C�o��>����4\0��0��8���v���7����mW\\���h��\\�)	R�p��=���\'���=Q�0�<1��o;�ҫ��n���sN^.	Kxms��!�8X���S����U�/��ɽ�T��<�[�)c�6@>*\0�~v4W��(z��J�K����R7w�֔#�\"��3O����S�V�c�\"Ef��Ҫ�
u�����4?:�HN:v ��9�f�+n[���,$����$��se��:��ԀZ�$E���P����N�@��g�� �L�v� ޜ��X�v�,۱q]��i������Ȯ�e�$W3g�kA�M�7%����g��?�;j���l���~�����\"��(Hr���|������:��q�Gqե�нkW�$���7����|�Ϯ�뚿a�p���oZd,�2���i*�,#K2�+R��B�X�m�0\'��X0wƔ�s��u��u\'�k�6�S�Θș��S��?]�-�{Dx�b(ı�8����i�C�;PlQ����d*3挣G�ʬwƆC!��9�j%�#�k~�T*�]y�_~��w�A�$
۲\0[�p�<<ϳ�?��v��g�0���k�*�z_�\'��N�$�ׯ_�SN&�c�8���7�N˶1m�vpZ]
��	�ߊ�`[F.G6��n�q�$a�0�����W�����\'!Q8d`%�P߫͡f�>����D I�I�/][����Ɣ�V����GMR�s������,��՛�O�Mp�ӹ�7�����n�u\\�ò-,�O���g�����Y�<_Ox�n�gBBU\"��H�h$��iH@�4���f���!�p�H�Ǳ7����Ģ:s?i䞿�N>o����L}1ƈ#3��|I3Yx�n^�@򜶀x^Y5�� ����.���E\\`!��a���0��#O�5�Tf�qC��ƻ�Z�����MT�te�������|��3?��c8+ך�\\�:m�ؠA�x��9����y�A�)�?޴,ä`�
�N0�<cǲ1�9r�$������Ɓ}}0�A���h7��w`L}�7��u���˩�4���ٷ3�]�h���B�!=��*2}�k���\0���ᡁ,�D%	F�=��l�\"g�,[�&3���Wx���`|������K�|��a�I_.�Ut������y���a���i�ԣ���J�6���?�b��t�����
������J��z���9�|�t!>�h>C�W�e[>�D&�c��4��UȮ\0�\0�}p�.n�s���V<l�\"��ql��j�}���ڛ���ô��b�	אL��y��L}o�X\0�4iiMc�x�;n�AP�����,�Qq	/�h-;���I�=Pc��>��P�X���#�i����?̅^p�QC���̷��
R�,�[��l\'o�{��2���)�-�|1��[�1��Q����]v�1���&Ų�0���rD�l=@�ph�Z�`44xmf3��J��ᐊ�v,E�U���5�n]�(r��C��q\\0Mϓ�u�X,L��U<��<^x����>���Oێ#Z-!�)ՙD����Zd�\"2��0LK�y.��] T1�����Ǝ~��O=�@�#�����~,�k�z`x�`A�ߣ-�;��&U���7yc�|,K,�iQ(X؎K;������]Z������a�x@$�p��_��2p�QL{�F�p-�Tz̨Cb�{�Ǻ��aYX�-TFB�q���i��0���Mo!YQ�B!B�(��Jb�jB�(�U+��W���d����I��$�I��4�\\�4�k�^ ���KUU4MC�4B�P���i>�����W����1cF����v��W��,[ل�:�3�N0�LsMq�Ӣ�����>��2ϸ
����?���6�\")� �M�(���g�AϞ`�P]���8\\��[=��_.�����5^��/6�3V�C�B
��\"�ty:\0����q���
M�̲��+���C�T�>n �ʜ���g~p�y�c������du���V���ѽ��+ITE���r^��	_|�r�O�?��S��_wߴ��{���5$S��~0���\"!񱮡G�d�I�B׶�;��Y��ZU��#U�u],�?w[3EQ�,���&-Z��_��իimm�܆�0�=��wE	v�*����F��b1***���\"�HPUUEEE�x�pX���{�ۓ=������+�+bѱ�Hǲڐ%t�񦅪m���f�$[���7�\0\0���GpS�h-�hyҶ�1��#\0��2�����,6MF��
�����p\0�v���x̉\'|�ڋGѱ\"�@��f�%�Hg�m%�������}c���و�v�G/ Q��]Hf4���?x���\"��ʊayà�%��Bo�um�<8Ҷ�1u/�G�*TU&ne��iM@�#?���љ�=d��+��������ʹ��,��3���J�D8��0QŲ�M��_
��[��_1`�e��ķ�p������+����ԄU��^MQt]\'�PQQA\"�����nݺѣG�u�FMM���D�QB�� .h�1��[y��qC�|x���|����0��7�����ɶ
�jD޸g-�QN���=|`���8\0a��B�!8R@�����K���;�ږ�w��k�EXש��e�Î�b��S.k�����;�b:��SJ4�+��$H��
���+L����Of��*���[�\\�u���ūihl�G\"(
n����ҧ�<rU�]xd��$[���\"~�v��9����C�>�ȣ�8iJ(�k���r�cŮ�Ӹ���c�� ��|�߄mo�ܤ�zؖI!��s]��6><���C�>k�7��
8���L}�ό:�\"(Oy�}�C�V\'h�dE�a>_��gP( ��#H�((�b1$I\"�˱z�j�-[��,�AH>�ϳz�j�@ݭ[7z��M�>}�i���ݻ7]�v����h4Z���`�ׯ_�\"�q��h�&���㍊��ƹ����,���[���@��ڲq�	!��o�c����.;0N��rp| ^��}Y��%K�g�*�s���tNt��m��ql���k*L�H�Q�*
�΢��q�����s]}�QQ�)�y��=�w�( 1��~�����\"�W�@R>�7����$��LR�����W��)����y
���%n���\0,^���w���=����w�a�,MQ}Q�-�(�EI%gO	N����m����\0ٱ-
����\0��KG���m�ϛ�����/��Q\'\\O2�sԐ�L�:cle,�e�(��a����{Ȳߣ��!PY�H�3�Z�=�f��\'�x��w�=Z\"Q����qTU]\'P/[��e˖1{�l�v�ʮ���n��F�~��ݻ7�����qt]�.����N��+��{�!\0�C�yy����U�3i2��|��{G����cETT�Z���T�|�a�I�}Ϸ�o��qK`xŁe����D�oi?�5���lb�NUu�zkp���	8|o��SlX.�eb���,�x�ƽ�k�u��%�,�j���4#EuU�M6-)���+��AA��,�h���)B@k����
.M�<ϣ�K�pH#Q�K]9us惓�A[�i��J1׆2�l���*�v�w<l^@��s�B�he���_wʿ��+\\gǟx�^���\'��d*;��Q��!��g]�;�o�����p���8�D�h�۪U�X�j��>{�\'���g�=��o߾���RQQ�]\0�M7�ĤI����������`��j�BN��eE��d�L���\"�m��)�����{��>�6��n\0�I��W����?V������t�/��<�f��>��y@�����_�ΐ�t���`N�s��ς��z_;V���btSPt�wW�nţBbQU�߻+{욠���p�m���˨�/���l>/dQ�o�Se�՞4=�v7���J�B�uUE\\�k������\\�?�y�qL{~#O��d*;��лmF����q��CG��֡[���S�m�� �*�ɐ�d�x�A����p8��\\���������u�]�o��0`\0}���k׮�b1t]�fs̉D��~�G�>�����C�b�g\'���늪��V2-�Y�ټ������?Jy㞈\"�mb\\���y�e��*�����/����>(���(�V&�9���k~=%�/�������V��i�������[T}��<~�@>�f�+��<V��8zH�����|���~�1���kȺ�*_���MޑL�$UEfu���ڗ���NXKS���y�����Y��4���I��o��͞VI\"�z8B���nq;P�r�ËY�j?��`�N����M����������ʹ3%�\"��8T���t\0�@8��/B�斛/^�҃m�}�,�K���%��W4/m�Gj���k�L&I&�,X��x<N�=�ѣ�!��p�B�ϟ���{��N;�D�.]�D\"��m�F����o��/gg� ��Vw��7��l�r����� ����e;���w��7��E\\�|BԞG�Gώ�8����,D��ˬ��9��W���H��BU=��ƉUV���`�W�T����iatM����Z��u�2�\\!�X0���Q�2
|�RI٩ww�?^ߝc��Sӥ��s��|�\0�\'\0��yС��Ƕ����~�z���v)�c���A��/h&�Z��]������Oy�\"3������t�|���l������eX�W3���L��!�Ԉ�:���3��eK����WHJW�ZoP��F�>`��j��B�ߞ�S�!��mY.�k[�:.�c��%�bl�$�����B�U(<�y�KU�T�4`X&��`�,X@�=�ׯ�^���_|����9���s�=�ٳ\'���ۮ����_�B�y��m��7�yp�RUuy���R=U�N��#L�Nw낱,���x�v^q�G���j+ھ�,`0��!�ϖYV��1\"�2�$#+�ЉքV��i8�C���0Uޱ�;94t��s��v$EYF�Ŷ$ �/�9.oOz��C�\\��yx��*��4���͡5�\0L>�ܱ�Q�����,�ڕ5]y����M������4�uh^ڸ�o��ld��,o��X���Ϲn���\\N���&o׀��@�S��u��z�
��W]�ąs<<����\0�G��S	��HZ?�z�-s��>=��5��<�e;X<)�x�[�m�e��	�sYbU	���<���Ӿ}&pp����#˗/\'�Hп�6��y��v�a�����ׯ�-os��
���3Π*������7�;6L�V2�����<�����
�@�;\"7e+�ˁ���ץ�\'�� ���uYzp��#�^��*��\"�*������\"��~�~\0�\0�cc�&f.ǌ��8�5��gR6���~������un���SE(c�;K9��/I��p��c�$\"��(I,���ݶ�\\��.Svr����e)d��c��_9F��7�|�%?��7!��yX���]ru{��6�sO��vQY�8��HD�2�*�yv�����@4���4]�|@��E��aV>����/��D#��(Z(��z8�yΎc�Xb�e��͕Ϥ�ş�n^ڸ;p0,�L�}��w�ѣ��{�P����y�gX�|9�r{�ݻw\'�m{!�c��!C��MC�n:�v�ޱmc�E!�W}���O3�\"o���U�MQJ��mC��>�f��~wI[o���s�c�Q��*�\0dYV�I�����s�,oOzjw��:j)�,����vf�~�c<�t#��>xx�)?�flHׄ
�#�I�-���	J���M~/�*n�������=NQU�p�p��hE��9���*N��!��eEAV��UK����}[k�Eh~�9�n�\\���b�2�*:^�%��p*��4��O��M����Ƕ�m^�Gp՞�|��HSS����O�>m���ߦ���t:�~��G�޽�-R�(����	���;�L�\\�5U߄��pQE�\\�����K�\0cE��5MR�W��#^��6-0�\0?�3S5E�@\\MK8f�%ZO�X�=���:�f���G_�z1c��5�`�8$��k��%-���/����D��WW�ǭ=�WT���F~��\"�v�Ϯ���$	0vw��ubݦ�*�ϼ�W`[��Q�$EE�uT=�,KbC����#P���TT6�ZS�55.^�۷a3;m��Es?�\\��|�e�UTMC�����ĪTt���&Ezu3��f�>�yi���ݶm��`�����c��$�I2�x ;�3UUU�(��+��&tN��-�\\�\\*I��9q�Lh[�3\"T��O�*�jIq\0ƀW(	>R���݈~bk���N��8�aUӅ\'��k����~x�
hD$Ӳ�|�#Ч��R���\"y�p�4qG�$�Ԟ\"��N
Ǒ�<\\R�Y�x>��7/>ƏO����&��v��������$D04]�n�钐ڄ�m �n�=(K����c2i�zLq,k��:�s%I��;K�E��
�ŉVV��B$W,�4
���6Β��hZ)�T� ޥ�֦�\0�����dr��ٳ�߿?�����Z�r%�=��a`�6���Db������7�;6?j�ď�HP�9��`���Uظʽ� ����J)O���WK�z�tĘ5]��E(ZnS���`�	I�2s=��q�<v걊Xd�
�V:T�k(~
\\����N���c���#K�ʼ;�������~ϳ��mƐqyԍm��F�^o�rPVT�P8��H���m�����&�]�%@��V�v�9��0K�� �
�*v����V&H�XFM�>O7/m|��m�c�͛G�>}�}�݋����<y2�e�.��۶�}�7�-�t^�uzǶ/W�d�g�v�����݀�$���\'�\0bM+�q�@��� h-�W\"z�}Gy�1��;�MU��X�Ԕ�v�X�ֻ橨b��	P��8��KW�d4�-F��I8�@��*d	$��IG�AWsD�����ϋ<�?>�ҫ�뚆$I�
o��n�^�$$7�j����T�TF�)=l�N
�hn�������6l�� i2aa�#±8�U+𝎱�K?�hll�P(п�b��뺼��E��m������	�\"w\\V�w>�������*�B!W9�B��|ò� D\"\0� ص������pH\0�mcZ��zn���$A�Q�=��Rn	�]��q\\
����W9b�g�y4\"���Ғ��sX��@`��>ˀq�����z1L�`����= wv��\"˨�BH��u�-�F�/�R��JgH�\\��v����q��������(M_/��W�;��6�\0�kjj�YWWǠA��Ta���Kō�n����	3�3t�sm3�#�J�d�\'j��(;g\'D��[��+\0c]`�i`x�9�& � }0�\0\\�	��Ȳ�aZ��01-�ZE\'�䤖\0�甖����m˶���4�j1Ҹ�aGLɵ����BQP\"�>�Sh�p���ED��̣λ�IQ<l��q���0�\\��M��O<YF�E�UU�(@VdM��5U��2��9�-[N(�\\��`��8dYFVT]G�h�z	��楍���2�̐�@��_,�+��$�m�%�3����ئY�_A�ܱ��Έ6�-��piD\"�-
�>��U��/��~:��I��	t7�����W��%�~PMU�΋$I�I��J��c,�����	,��m�����rT�t��hM.��x��l1r鳂Ɋ�
�D	���(���ƛ��#i���4��]�=�$���]q=��_�8eѶ�|�ik�CH����ևfʥ�����K/����躎��TTTl}�};�䎼c��(�ȥS�3i,n�7�������5�Q��u�wl���m��e6�����_���S���	/�:�KU��
*bQ�����d�M���r�r��C�u��[���eY0�)���	Z�$I*漽�P��v��wl�(`�����O��o_\\���x����8zJ���y˪�!�q$Y�w��zAٶm^{�5��(�pUU���[�~�N@n�.ؖ��͒kM�Ը�<`h�q\\�� B�U[�;<�HD���y0M�Q������V���P[5	��*��s>�������7���4C�u��U�I�1|̉�	�~�)��P�������t6��8H/�$e�����Ӎ���f����F>O!��4
������d.SA49.�!P�Ͱn���n�0(U W��;)���pS(����I\"���ǭ�[[[�6m���E1�p8�uAy�p���.��b.�4ɥ[���\08�JD�SPY�E�XU�b\"wl��pf\0?o�K��oc;У��LRQ����zr(��
���%	��m>RpI���}��׸
P���7�P�q����5��)��T��ydryl�)~�N���8 ��|��|&�������7n\'F���	O��7�J�,_j�Y��Z!.!G@*�J�L�^A9h��D���6�<o�<T|pɒ%���[$������ɿ�-\\rI�EE�#�m+/��O]u-;�7\"w�`VVE\\�\0�HD��-l�:���ٷ�s�c�\'<:R\024�����ݹ0�]��B�T-,�\0khj�PU���i
�G�#�t	]�����aB�j�P7�̴�ȓn�n��!�S�5�IoL�8������r�}��#0ΥS|<�c\"a�/����D\"8�I�|��+����Ԓ�`�]t��:�G���Ǜ�ꑀP$}��cf!�9�vP.�Is#\0�ג����S�裏�޽;UUU���b>y���gw��>8>壟;>��m����{��-��\0�X��v����KR�9ᔟ]3.ռ
��n&\'1g~i�z�#Q�z|e��EQn�U�T5���eYN�8�C�5���9h�.8�;UUg2��?2���P7��!�?�++ƺ> {����-�����$I�A�,�[E�K��<����pH�W��;��з�ƒe6�]�����`x����D�6x�T� I��G8���Y�\\�;(\'��<7�^nl^�x�Acc#�D�������ٳ\'�D�P(�uCם-P�^��4
�3i�\\�b�ԁu��-�E\\�K���x�&�b}|��_�46W0�e��G�2w��l���PǦ�ߵ���g�u�?M<�lw�:���ͳ���3��̘����?�A���*�����	�� }����u���3�8��aZ�4�lv0���O�q�1��Ub�*�c/j`���-6��3��\\\' �X���<\\��2Mjz��ݼ��Z�����s�A�����=z�����o�ۊ���#7��ugn�B�u0�y�4���P�����^@[�1Q�WV
�X,j�y<hL�,���F�0QT�p,΀C����ݙ?��^������)�wI��A��1�V~��|�8��1L}�O�:�z��̘�d�{�ǖؿ\\��
��_zC�������1�X�d�O컾g��
�H��h�p(T�g��rd���mC�I�#�m�4q,�(�W��]ܝ�؅�v�$ْ䘋3����7����<��3����:�lG�.5ԚK|��h�������\'ϟ?���:�u�F4%�o=/yc�־ޮ8�j���,�[M��Wg�U��TV����żc]�x\\xǺ.�cϣ�q��$����w��-K0S��F��Y�4�����f[� �p]���{|�jg��n����o���_��6��v�1u�f��X���r�X��t\'#O��d*=f�!1���z��,I�S��@C x������原�i�t͗�t����e[ؾǾ��&�ex���/������Àz|����xʮ��������F�z���4�R8��e��pH�����NL��n��F�W�\'_0=�Գ-��6��u���m��Z\'��&���S8^��i��X�m�tڎʊ��D���Y(��a!�%��d29�����t�;��.��Bmm-�p�\'���1a뀀�=��;9냲�W�?�m��	�E�B6�%T��ܿ�*]�l�\"���+�q4Z�e.\\�:8���n��c��`قSAQ5±Z(D��׶q]�qD��f�o�6���!�[���1\0�L��B&MM�>c��6V؎wR�gY�xp��$ǟ|���P>��^{��q��(2�p�l>�m;E�Nq=���n0w@�Y�v�����\0+*�Y&
Q��	�:��Ak&[t�L���yȅlǲx{�S��^|v�9�G�����M)�R�ޠ�̧r���\\f��\\��놟��Y�%�c�.$�)F��9s��x̵74j���-KPÙ��Q��-\\�];(�qE)�hz�S�Yvڎʪ���It�x[�楍������ �LRWWG߾}���ں��$l����mc8)���
���#A)�톫]�B�B6K��F����Q�X�b\"��\0��J1֦	�ă���\"�w��w^�y�a�ަ+_e.�墒E��u�d�h�y���FG��o�hM�\\����\0.j2Y{H�gY~��D\"O2���xv�-�<�*��9���g�L_�a�6��[���vz����SX���p\\��iR(��Ӳ�ϝ���G>v	\"�N|v�aZ��Ҝ,��[����\\*ɇž_�s�ڇ�G�M}��s/�c���\0�_q���?���XD�O�܍S��B��$3�~�)u��`���no�C�F$\"���m������d�
�Q��h���y�l.PB��eM����GOr��@%j�m�c����߿�����~�ѻw�b�V�c���`���8���@B� ��DJ���6Ȏ���c���*�n����W+��\'�ܱm��_�\"8�甆�3
��ڶ�9��Pm$\"
��5UA�d<O�aZ�
���in�(��8�\"�P(��/����|�_���1���~=��?<t�Q#\0���ϼ��쀵K^�zZ��D(�u=l�A�d�����?B����O�\\���g�)�쇰��|�W�_{�L`LHW�����}�s���p�OO���\'�F�7���Ɍ��^�0�+�h�d�ɨ1o��s��ؔL����տ9��Y��<�̸HX��؁9���0��+�=<���M��B�N�ڑA9&��B��������i˗/���уD\"�a,X����ۏ��ڭ�}���$�=kn:M�ƟS����p��A�j�m�D}I#��}*��[:\\x�UU%�jY����I���_�y�c�eaů�SL������ﴦ*�\"B���ھ(D�5CKk+�\\ӴpY{�VV�P�XeBxծ�(�r���Go�yxWq�w<��!��u�v6 қ벙���=�(���oߝA�y�_�R߰t(���g���?�zvA�0i�f����v�\'�*��G?��>��#v�ߟ�]��Cߝ�P��#H9��P���\'���^\\<�*p����\0I#��0b�m��\']zU�U�x푿���3����g	����5*��\"�k���rT8��i����p,F��kEQ	GcT�֒^�DM�>��6�	�P__ߦ��믿&�J�uc��l�𵇭;\0��;n�=���w�e��N\0�l��J��\\.�׈���\0�o�p����q��2�.���=˗g�,�_-�)�^]ǲ�LǶx�EI�p�XH;�G����x�pHGn^M*�Yoݎ$+h�0�Duy^�(/h���?��-9�����Kxl�����e���*L���z���%P�p6�_U��/\\Ϡ����\0)�oo��/��G��N����Z1,�]�A\0�h�O����-�P�x�?u�O���I�t�(1�%E�c9I<7 �p�\0,y��Q֞��䶂�!�͑Θ����+
�s���ӹ�����^ticj�Jf������k�D���8w��T3��e\\��\'j�%�^�Í�K:l^\'t��^��iD�T��������L&d2��8\0�L�\\.��ymy䵀1�,i |��w!-�~�¶Ȟ�e0r� <�= ����-B�PdVT�8c�(ܼxqpֿn���s��B�4��ĶeP�fxg�ģ�KR�P���9��?���y�PI\"������m��\"1Q1���]�ʌ@��Z�g_��=��̳@���:m<��aEF��2\'K�T��V_R�oXA��f��+
P��1sNq�4p�گu/��_�Ơ������r�7��c����c��������vG�٣6jٶ�2,�r���aXȲG&k�rU�l�l�{>�*^[��sp=�|�$�wp\\E�xT&�[���/닭M�O�������=�Z�
�cG�F��(o��@<���b�7�����L�6���TV��vpP.y��NM�>v���7�����\\rP���w����y�&�h������Il&*��\\1r�>\\]� ѷԇ
��w�p��ǤU���1�D�0EKO�mZA1�0�����\'�@��o�*��V�T�� W����\'^�\0�q���/L�9O�cE�nI��-)����h`�/M���Uy?w���f7q��/�{ݺ��u����i*���(\"է�*����Dx]�TE�oO�~�b��\'k�㦁�!I*���PdE#�0-��N�5�T��3?�oߞ\\��Kq�`���~�?^��2��� ��/_�!Qf�]I�Mzv�a��O���\'�L.��x؎��*�� �/K�*�&��Y4\'�\"���ks�4��M�$�Y�%���3<5i���\'\0�t�(n������ERv�7�{�����FR*@�ER���
�t����Z���kG6�u��
V$	-fE��}�%�|9���0ݻw\'�l���o�o�9�c�~x�#˭��s���ID�:\0�-��� G\"�^�+V�-9/��χdsy�Ѧ㖐R�wJ1�����ӛحo$���B���z!��9|(H�����I#�����7����$�i
�鯥%U�`����iU�W�W��G��yM������Y���u���TB!U��B�i�ãG�8�\"��BY�{��[�2����#�\"m��
�� �2��Z�y�a�.�Q���v��\"*:SU�:��n�7m�s�{}���k���F�a�w��-��j|��j^����M�*����%\'��F@�>�]��!�,g�����W�~�M�~	��/1��8�I�x����x�U��DI��t�Z(>���;m�c�qDn2��*�i���}���H�?@K=��=v�e����.�u`Go��A`\\\\��.0��KM6��}��e����m+�%?dcUW�UWV�����ۿ(�U\'łR����Ԧ� ���߼_,����U����������3]w:���
�x�_/F��Nu��	/�ژ��#d���`��O\0�A�]ۅl�n��փ�}�Ҽ��y�fN�3����qPX���h��LTE�?��ߋSOܟ��6r�A�p��\'����o~B�yf&�ò��n��d@ީ�>����r���i\\�FUe4UfUs1�m1e�1��E�дu\\W4����db�_t��^]ym�|>����28��i:���9�Dt]Fx]Y!�s���Qٹw�^�C�
�L\'r��`\\�dȥ�|���5��x1�.���vۍ���m�G���37��D䏁	>9���-���?��J�|�7\\���p�����c��׭^M}6Pw�#O<��D�S��+IBVU4�V9���#Ǧ�G����_�m׷p���p��/�n(�ScN<v]ko�y��sge�MU	�B$*☽{��������+{s�!���R���� ���z
���|�g8�c��ލ}��ٟ�+-Flu�_��t����NrUm7����?��G��9���2]���#3�#�ǆo:P~>@Q5�P=!����(~n�s�b���eM��=3��.Q=��Ua*bo���?��
�&{��;��w|0ΦZ��W�`�AF	�ϳO<N�~�����6\0�O����5v�W_l���6�R�WD���*��\"�����p��?~�����0-�|����6�,��X(c�ÇO��GSbA�_���������i~q��L}�FF�t3us�L]�G����lKJ�M����=���E������&
�4�e�d$%B�u�v�%>^̣��jl^v���r���be��o~��_� �5���T:�e�\\QS������x�(�o�dn�s�y�i�mE�J9�Afc�ے,!ٲ4�P��vv�_x�{�M_����eu��`�~��t�`�.�>kb����؄�?s�Yc�-��a\'�}��xg`����o���͟O�رD\"�m��������_2v�g��kf�&�iм�q0\0��-$&�(%f���I���G=�`�cON�CW8�cߡ#��ҩ)f��mXF)�߼��G�C�J���h\\�<�ܼ���]�E?O�5�G���Ri���x	�Tv�>emG��ݕ?=p�o�����|�����Kȵ&�Ǳ���E@.�`�.
Z�\0�=����4�TV�f>7�2�i�K}��2g^c�gz�t�u74fr9,���X�6 G+�����aPݽg��(�z�P$����:���E����?$���\\n�\"RYI�Q��{\\�l�5�펙����|�d�itlǲ���k�]d5����D�qb�j�p����N=��
����~�n���x�؝wn]��6�����/�nl&݊���e�����?z�Yb[
���q4*��u��d�\"���ٙ\\�\\���;hG*��P-!Z� ��7yr���=n|���~��>O�*
g����������)���J��HR|�mF�$ڑ$I�$�$��>^\"*��(���Kn������>�����{c{�ְ�WO}��M��!҆E^�i;��J��J�S��۵m�|�BN��īk�;�5���O���E���λxA(�`�Ȓ$(A�C��M^9�pU�	����\'\08�eEEV�bI��9@�~�
\\�ABBѴ����p���pѤCN:���kw�v|�^�\'�P|�	?��c[�|��A0���k�𧟢f2H���Η�@0�5׶���S(�u,��ŵzȑ-�a$ITU�Ǫ
���_]��I��e�B��q;\\od��W�T�Hϭ*��mK�D�V�`Ւjz�׼�q7�v��}*�*n�c6v����vc׾	*+� �(�������\"�H����h�N(�
i�8���~PZ����t�٧�e��L��}�!L}o�XEQ�5�pH��%I.��r��r��Q���,�aХG�)��N��aBј���Z\0�wT~1�U)�P����:@�x��$�bW���bTT׌w]g�����0�X�p<������ᓵ^H���$YEd��$�tZ\'G|�K�;Wx�ۊ
���i������,K�~�+ �f1��Wu�U�^�)�
��B!��$^jh�x��\\���$	YR�t�������m��{O*k����+���K	@9U��I�L_B8���
�Hr��b,�RQEQdT�oO�%,[�`X8�Ǿzr��]9����o\0�^{��ǜG2�*�ߛ=6�#���c�@Y�$$ߙ�U�U�8B��UC�E�����\'��&K2r�}���]������Zߣ�(����I�k��MmF<��)�\\��e��c�$M%��F	�t�C�C%���`:��t�d8�	��A0�Qڥ��Nݶ\0YU�;�y�kc�vp{������]��ۃ��8[��K�EAW,&Bת
�K]�d&x��V���;��TU�r$\"
��}�w#ٻ\'�{�fՒb�걋?��v�$[E�#��)����	?��^��ݿ?����A��(���X(�57{I
��ɞ�$�B�JQ��Z�����|���{I���(����i�u�����8.�e�kb���]T�ڒ�� ǁ�f�;�x�(����m.N_�z���s�(Q��A.c=/˲��a$Y�H�3�Z�=�Ӿ{`\\���O߶����0c�
��kc۱}b��3�����k3�?ޢ֑�H�2Ià>�H=6��E���\0��pai���o<�PQJ����i�c-;��A�^{������u�/M�\"t���������o-,��c�|��}�0�{�2�1�
P>���x��;��)��թ���Nq�o�1�N%jݾY�ƽ,�dTJQ� 		�	��$c;69_S9�SX���9����0j� ������s���� hi*�m��˿���̳�����;��;
�j���֗�D����z5I�G_���A�.\0c���X���#�)�
��Be��o�t]\0r(T�P�y�u�$a;�e�U��u,��U(0�	�O::����:����=4��n{�,_\\?-�j�lv����f�W��^K�cۘB5�楍}��2YcH�Ǎ\\~��ӭ�~\"?�GN?�R�;�<���w����=<����y@������y��GVd&����Z���=8���e��ehN�N���dq-k�}����\00�g�.���s�iCѴ8H���\\t�r[�!����q��CGv�Kt���uIn��<F.]JR,(.��cS0C�(`p�������dM��A�;�e*<��$IŴ����u\\���5X���7JEL!Q��0H!�>YU��?x�Ɵ�x�y�W�����W���e����Ϟ��e=�^ۊ�\0��-���էL��R��b�7����q�\'��C��_��QC��[�w]W�5y-)����y^�޶MǶ���������]|��/\07?6���!]�[���-������+--~�u�}�s~~�����I%�L~~Fq�U:�X�ַ�]�J�����u:����kJ4�P�>����x�S\\��K�а&��V��{�@5��<<6o�ji�5��q���p]o�����HD\0�ߏ�����m��-�sE�x!�\0-��c��*X́�v���.��jP�p������F��x�񃟛�漚�*�Z�H㊕d��b<���ʸ�)K��ǻ�в|��c4����k���x���3
(��1��ko�;��ۗ<ϣ��u��̛iB`[&�L�B.��W�+��U�QN?u(}���ARhhXΤ禒L�ON:��~�Wf[�M&�#�/�N�-ȃ���x�\\����>����`�so�z��\\q���������	�[��b�[�5�k����q��s��F
����N�9��������s����RaP�K�!W�J��ǕjP{�Zr�� U�
0TQ�N�����o3�\\n��	��M-����u��r���4��i%���G�v,�^�&ö˙�H�m^����>I�G���j�����wE
���\\��X��QG�~a��FEVi:˛�I�r���<�P4�sI�DQU	�_K�r���_��{������^��Δ���d:����뺘F�lk����\\�H�F����
�$А$$��）�o����!���9�����3M��#(J
��W��Q���b���м��x,L�`�(�$�zu+��Z�l�@n��ޫ��r`�:\0d�\\��EAl��a���E9G����r�^> {6=j5v����P���g;����o��a��E)�&ގƔ�\\�]+K��%�]����E@�[�,x�Nx�Ei�������\0熯�7/͓/,E��s��s��Ͽd������n���~>x��F?7��F�{^�G:�b��\'�h��\\]^�����W�\"\0c�w�yB�K��e�����;v����zg�[Oe2krwo���b
dSI�󁞵5�~�\0\\�dƛu�寓�������/;��#���n���k&M~�\'pEX�ǅB:���h�y&�J&3U��ҽ{5�e�ښc���0����싯�;�+\\W�xä`X���6\"��ow폭������6�5�w��iw��hX�KB�kͧ����CE�Y�t��:��d_|�m�>��{X����\\���V�B�� �ԁwP����m�뒠�d-\"���ޱ�|�0͜ϒ���i�c2�?3�늠|ʨ#FOzcF�[��T�F^�<%2�����W�H�A��<����rӯ/����G��?n��/���� |�z��Yk�צ��Bh�\"�\0z���Gs�b�=zs�/*҅�7,g�so���)�K���\"&M~`��y~WΖۂ��[�����}���N}��*2�h�7g}O��0,:��ݜ����rkl�&�!h���.p�7y��%Y��r�\"�v�T�{	EFG�VV���ç�ﭣ�}In��U�?��cV4\\u�YL{�Fm�O;r��IoLo�)�������wW�TT%�WYI$^A(�׀_��:�>&��Z~�\0EP>����8�yA$�u\\�lf�<���x�`�\"HX6�i3���� bI$*HTU�W �,JE&s���3��m2����Mͭ=���szt�F����,jX�����e^D;m��Es?��N0u�����m�k(��#.�v�W����K(h�0�
IV�wب)F.;�6Ml����}��K���f���zl�i��Jf�+�2�+P�g���\0\\TU�9)z�K�����','1','test','2015-11-13 23:32:41');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------
