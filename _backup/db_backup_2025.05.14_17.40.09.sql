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
  `tipo` enum('PC','Notebook','Servidor','Switch','CÃ¡mara','DVR','Otros') DEFAULT NULL,
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
  `estado` enum('Ingresado','En ReparaciÃ³n','Reparado con Cargo','No Fallo','Reparado sin Cargo','Retiran sin Reparar','Plazo Vencido') DEFAULT NULL,
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
('2','','Centro Salesiano Aires Puros','211756580011','Centro Salesiano Aires Puros - Kera MIta','Bulevar Batlle y OrdoÃ±ez 5020','cenrosalesianoairespuros@gmail.com','','23555684','','Contacto - Cristina Pascual','1','1','7','2015-11-14 00:51:49');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('3','','Cristina Garcia','.','.','Sin especificar','cgarcia@teleton.org.uy','.','99416062','.','','1','1','4','2015-11-16 12:42:00');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('4','','Ismael Benitez','','','3 De Abril','','','94296471','','','1','1','5','2015-11-26 02:03:16');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('5','','DiseÃ±o ElectrÃ³nico','','','Constituyente esq Carlos Roxlo','diseÃ±oelectronico@gmail.com','','94382892','','Cliente preferencial','1','1','4','2015-12-10 01:30:18');
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
('12','','Andres Neyra','000','','ZapicÃ¡n 1016 / 001','egonzalezpersak@hotmail.com','','99152527','','','1','1','','2016-02-12 20:23:23');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('13','','Rosi','000','','Cooperativa 3 de Abril','No tiene','No tiene','95663382','','','1','1','','2016-02-17 00:14:32');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('14','','Eduardo','000','','JosÃ© Llupes S/N','','','94862870','','','1','1','','2016-02-20 14:33:42');
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
('20','','Maria Jose Alonso','1111111111','','RamÃ³n Estomba 3435','','','91072268','','','1','1','','2016-03-14 18:08:04');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('21','','Raquel Villamarin','1111111111','','19 de Abril 1120','','','23365450','','','1','1','','2016-03-14 20:42:54');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('22','','Eliana Ferro','.','','RamÃ³n del Valle InclÃ¡n 2584','elianaferro23@gmail.com','22045753','','','','1','1','','2016-03-14 20:44:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('23','','Emery Lopez','*','','Parque Posadas S/N','.','','99509895','','','1','1','','2016-04-11 21:33:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('24','','Maria Cabral','.','','Francisco Pla 4161','miki-ale@hotmail.com','','94206397','','','1','1','','2016-04-14 01:27:04');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('25','','Mirtha Cardozo','.','','Lucio Rodriguez 4842 esq Cno de las Tropas','mirthateamo7@gmail.com','','92726879','','','1','1','','2016-04-14 02:18:29');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('26','','Dinorah EspÃ³sito','.','','JuliÃ¡n Laguna 5789','','','23077281','','','1','1','','2016-04-22 00:01:44');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('27','','Rosa Acher','.','','','','','97076869','','','1','1','','2016-05-05 00:16:01');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('28','','Gladys Mena','1111111111','','','','','22084198','','','1','1','','2016-05-07 15:25:36');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('29','','Mariela Camino','.','','','','','98815870','','','1','1','','2016-05-12 01:41:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('30','','Ana PellatÃ³n','.','.','','.','','099652275','','','1','1','','2016-06-07 01:45:41');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('31','','Gonzalo Mendez','.','.','18 de Julio / Edificio Palacio Salvo','gmendez@teleton.org.uy','','099909453','','','1','1','4','2016-07-08 03:12:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('32','','Guillermo Rivero','.','','MangorÃ©','.','','23074615','','Es medio Maraca','1','1','6','2016-07-12 02:52:57');
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
('39','','Guillermo IfrÃ¡n','.','','Marcelino Sosa 2771/03','guillermoifran@gmail.com','','099655146','','','1','1','','2016-09-19 23:01:45');
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
('52','','FabiÃ¡n Gardalina','.','.','Luis Battlle Berres ','.','','23124552','','','1','1','5','2017-01-16 16:46:28');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('53','','Pablo ArÃ©valo','.','.','Santa Lucia','.','','095164042','.','','1','1','2','2017-02-03 19:53:41');
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
('66','','Centro MonseÃ±or Lasagna','.','','Gaboto 1527','psluzardo@gmail.com','','098867162','','','1','1','','2017-11-08 04:28:55');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('67','','Mariela Tardaguila','.','','Montero Vidarrueta 1342','.','','094958408','','','1','1','','2017-11-21 00:11:12');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('68','','Anibal Medina','.','','Jhon Milton 4644','anibal.medina@akzonobel.com','','092361968','.','','1','1','','2017-11-23 16:50:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('69','','Juan JosÃ© Solari','.','','','juanjose.solari@gmail.com','','099553137','','','1','1','','2017-12-27 16:09:12');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('70','','Federico Bolazzi','1111111111','','Julian Laguna ','.','','00000','','','0','0','','2017-12-29 19:59:52');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('71','','Roberto Gil','.','','','.','','099940520','.','','1','1','','2018-01-09 02:34:35');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('72','','TACURU','.','','','casajoventacuru@gmail.com','','091839897','','','1','1','','2018-01-09 02:42:11');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('73','','Unpub S.A','.','','CebollatÃ­ 1563','obarreto@unidadpublicitaria.com.uy','','24194821','','','1','1','','2018-01-22 12:07:47');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('74','','Bar Clavel','.','','ConciliaciÃ³n 3952','.','','23078663','','','1','1','','2018-03-21 15:29:58');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('75','','Roberto Alonso','.','','Amarales ','.','','099607562','','','1','1','8','2018-03-22 23:12:04');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('76','','Andrea GÃ³mez','.','.','Julio Sosa 4548','Andre.g73@hotmail.com','','26130952','','','1','1','17','2018-06-06 23:56:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('77','','Eloisa Gonzalez','.','','Avenida a la playa nÂº 48 esquina oficial 8','egonzalezpersak@hotmail.com','','099436425','','','1','1','','2018-06-07 01:14:33');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('78','','Mariana Bica','.','','','mbica@teleton.org.uy','',' 099555016','','','1','1','','2018-12-14 02:08:18');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('79','','Giuliana Venturino','.','','Carlos Brussa 2854','gventurino@teleton.org.uy','','098470720','','','1','1','','2018-12-14 03:02:46');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('80','','Sonia Fernandez','.','','Manuel Herrera y Obes 4598','.','','099056422','','','1','1','','2018-12-14 17:06:23');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('81','','Gloria DÃ¡vila','.','.','Jose Yupes 5703','.','','094549381','','','1','1','','2018-12-14 17:24:29');
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
('3','San JosÃ©');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('4','Salto');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('5','Rivera');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('6','PaysandÃº');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('7','TacuarembÃ³');
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
('17','','InstalaciÃ³n','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('18','','Visita TÃ©cnica','.','Otros','15');
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
('29','','Visita TÃ©cnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('30','','PC','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('31','','Visita TÃ©cnica ','','Otros','15');
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
('38','','Visita TÃ©cnica','.','Otros','15');
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
('49','','Visita TÃ©cnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('50','','Aspire 5732Z','LXPGU080049423217C1601','Notebook','4');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('51','','Clon','','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('52','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('53','','Clon','.','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('54','','Visita TÃ©cnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('55','','Mantenimiento','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('56','','Pavilion dv5','cnu0395hcs','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('57','','x401a','D7N0BCKRR0A7280','Notebook','6');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('59','','Visita TÃ©cnica','.','Otros','15');
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
('65','','Visita TÃ©cnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('66','','CLON',',','PC','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('67','','Visita TÃ©cnica ','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('68','','Satellite Pro C650-SP6005L','6A460265Q','Notebook','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('69','','Pavilion','.','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('70','','Visita TÃ©cnica ','.','Otros','15');
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
('78','','Visita TÃ©cnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('79','','Visita TÃ©cnica ','.','Otros','15');
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
('86','','Visita TÃ©cnica ','.','Otros','18');
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
('93','','InstalaciÃ³n','.','Otros','15');
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
('108','','Visita TÃ©cnica ','1111','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('109','','Visita TÃ©cnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('110','','Visita TÃ©cnica ','.','Otros','15');
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
('144','','Visita TÃ©cnica','.','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('145','','Visita TÃ©cnica','.','PC','1');
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
('155','','Visita TÃ©cnica','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('156','','InstalaciÃ³n de CÃ¡maras','.','Otros','15');
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
('170','','Visita TÃ©cnica - CÃ¡maras','.','Otros','15');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('171','','VISITA TECNICA','.','Otros','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('172','','Visita - InstalaciÃ³n','.','Otros','15');
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
('116','','1','Create','Success','Creo el cliente: DiseÃ±o ElectrÃ³nico','0','2015-12-10 01:30:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('117','','1','Create','Success','Creo la orden: ','0','2015-12-10 01:31:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('118','','1','Update','Warning','Modifico la orden: 1009','0','2015-12-10 01:31:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('119','','1','Update','Warning','Modifico el cliente: DiseÃ±o ElectrÃ³nico','0','2015-12-10 01:32:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('120','','1','Update','Warning','Modifico el cliente: DiseÃ±o ElectrÃ³nico','0','2015-12-10 01:32:11');
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
('399','','1','Create','Success','Creo el cliente: Dinorah EspÃ³stio','0','2016-04-22 00:01:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('400','','1','Update','Warning','Modifico el cliente: Dinorah EspÃ³sito','0','2016-04-22 00:04:42');
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
('467','','1','Create','Success','Creo el cliente: Ana PellatÃ³n','0','2016-06-07 01:45:41');
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
('547','','1','Create','Success','Creo el cliente: Guillermo IfrÃ¡n','0','2016-09-19 23:01:45');
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
('624','','1','Create','Success','Creo el cliente: FabiÃ¡n Gardalina','0','2017-01-16 16:46:28');
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
('636','','1','Create','Success','Creo el cliente: Pablo ArÃ©valo','0','2017-02-03 19:53:42');
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
('766','','1','Create','Success','Creo el cliente: Centro MonseÃ±or Lasagna','0','2017-11-08 04:28:55');
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
('788','','1','Create','Success','Creo el cliente: Juan JosÃ© Solari','0','2017-12-27 16:09:12');
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
('846','','1','Create','Success','Creo el cliente: Andrea GÃ³mez','0','2018-06-06 23:56:19');
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
('897','','1','Update','Warning','Modifico el cliente: Gloria DÃ¡vila','0','2018-12-14 17:33:44');
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
El adaptador wifi estÃ¡ fallando.

Se presupuestarÃ¡ ampliaciÃ³n de memoria RAM, reinstalaciÃ³n de sistema operativo y adaptador wifi.','Se amplia memoria RAM a 6 GB.
Instalamos sistema operativo y programas adicionales.
Sustituimos adaptador wifi, estuvo a prueba y funciona correctamente.','','Presupuesto','Reparado con Cargo','(Ninguna)','0','3');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1004','','9','2015-11-26','','','En ocasiones se apaga, no corren los juegos, chequear placa de video y realizar un mantenimiento general.
','El equipo se reinicia automÃ¡ticamente, el sistema operativo se encuentra inestable, notamos que el sistema de refrigeraciÃ³n estÃ¡ obstruido por suciedad.
','Se realiza mantenimiento al sistema de refrigeraciÃ³n, actualizamos bios, reinstalamos sistema operativo y se migra informaciÃ³n del usuario.
Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','4');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1005','','10','2015-11-26','','','No da seÃ±al de video, hace varios pitidos y no arranca.','El equipo se encuentra con un falso contacto en uno de los mÃ³dulos de memoria ram. 
Su capacidad de memoria ram es de 1 GB, lo cual es muy poco para un funcionamiento Ã³ptimo.

','Se reconecta memoria ram, realizamos mantenimiento al sistema de refrigeraciÃ³n, actualizamos antivirus,  se hace limpieza de virus y corregimos errores en el sistema operativo. 

Estuvo a prueba y funciona correctamente','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1006','','11','2015-12-01','','','Testear, realizar respaldo de informaciÃ³n y reinstalar sistema operativo con licencia Windows 7 Pro original del equipo.','El equipo posee bastante suciedad interna, se deberÃ¡ realizar un mantenimiento al sistema de refrigeraciÃ³n.
','Se reinstala sistema operativo y se migra informaciÃ³n del usuario.
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
Realizar respaldo de informaciÃ³n.','El equipo se encuentra con bastante suciedad interna, se debe realizar un mantenimiento al sistema de refrigeraciÃ³n.
Reinstalar sistema y realizar respaldo.','Se realiza mantenimiento al sistema de refrigeraciÃ³n, reinstalamos sistema operativo y migramos informaciÃ³n.
Estuvo a prueba durante 48 hs y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1012','','17','2015-12-30','','','InstalaciÃ³n kit cÃ¡maras de seguridad','','','Venta e instalaciÃ³n kit de cÃ¡maras de seguridad.

Incluye: 1 DVR - 1 HDD Sata 1 TB - Monitor LCD AOC - Mouse - 3 CÃ¡maras de Exterior - Mouse - Cables

Se instala y configura kit, acceso desde smartphone y grabaciÃ³n de las mismas.

Costo: $ 12500


GarantÃ­a : 6 meses','Presupuesto','Reparado con Cargo','(Ninguna)','0','7');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1013','','18','2015-12-30','2015-12-30','','Abono Mensual','','','Costo de mantenimiento mensual.

$ 3500 + iva','Cliente abonado','Reparado con Cargo','(Ninguna)','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1014','','19','2016-01-12','2016-01-12','2016-01-12','NO DA IMAGEN','','Se actualiza bios a la ultima versiÃ³n disponible, y se corrigen errores en el sistema operativo.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.','','Presupuesto','Reparado con Cargo','Entregado','1','8');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1015','','20','2016-01-21','','','Equipo no da seÃ±al de video','El equipo se encuentra con una memoria ram daÃ±ada, notamos que el sistema operativo se encuentra inestable y que es necesario un mantenimiento al sistema de refrigeraciÃ³n.

Se presupuesta:
MÃ³dulo de memoria ram de 1 GB, reinstalaciÃ³n de sistema operativo y mantenimiento al sistema de refrigeraciÃ³n.','Se reemplaza mÃ³dulo de memoria ram, reinstalamos sistema operativo y realizamos mantenimiento al sistema de refrigeraciÃ³n.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1700','Retirado','Presupuesto','En ReparaciÃ³n','(Ninguna)','1','9');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1016','','21','2016-01-24','','','Funciona lento, se le borraron todos los programas.','Se realizan testeos de hardware y no detectamos inconvenientes.

Reinstalaremos sistema operativo y programas adicionales.','Se reinstala sistema operativo Windows 7 y se migra informaciÃ³n del usuario.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1017','','22','2016-01-24','2016-01-24','2016-01-24','Chequear,  aleatoriamente no enciende.
','Se realizan testeos de hardware y detectamos que el botÃ³n de encendido estÃ¡ daÃ±ado. DeberÃ¡ ser reemplazado.
','Se reemplaza botÃ³n de encendido y se corrigen errores en el sistema operativo.

Estuvo a prueba durante 48 hs y funciona correctamente.','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1018','','23','2016-01-31','2016-01-31','2016-01-31','El equipo se encuentra lento y se tranca.','Se realizan testeos de hardware y detectamos que el disco duro se encuentra daÃ±ado.
Error de SMART.

Se presupuestarÃ¡ reemplazo de disco duro, instalaciÃ³n de sistema operativo y migraciÃ³n de la informaciÃ³n.','Se sustituye disco duro, instalamos sistema operativo y programas adicionales.
Por Ãºltimo se migra informaciÃ³n del usuario.
Estuvo a prueba y funciona correctamente.

Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','1','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1019','','24','2016-02-12','','','No funcionan los puertos HDMI','Debido a una descarga elÃ©ctrica se daÃ±o la placa principal, Ã©sta se deberÃ¡ reemplazar.

Se presupeustarÃ¡ reemplazo de placa principal.

Costo: $ 6470 + iva
','','Se presupeustarÃ¡ reemplazo de placa principal.

Costo: $ 6470 + iva','Presupuesto','Ingresado','(Ninguna)','0','12');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1020','','25','2016-02-17','','','Recalienta, realizar testeo general.','Se realizan testeos de hardware y notamos que el equipo presenta exceso de temperatura.
Esto es debido a suciedad en el sistema de refrigeraciÃ³n y pasta reseca.
','Se realiza mantenimiento al sistema de refrigeraciÃ³n.
Estuvo a prueba durante 48 hs y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1021','','26','2016-02-17','','','Chequear, realizar respaldo e instalar Windows 7','Se realizan testeos de hardware y no presenta inconvenientes.

Es necesario actualizar el BIOS para Instalar Windows 7','Se actualiza Bios.
Instalamos sistema operativo Windows 7, Antivirus, Office, etc.
Migramos informaciÃ³n del usuario.
Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','13');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1022','','27','2016-02-20','','','VENTA DE EQUIPO NUEVO','','Se vende equipo de las siguientes caracterÃ­sticas:

Intel Atom D525 Dual Core /2 GB de RAM DDR3 Sodimm/ HDD Sata 250 GB/ DVD-RW/ Video Intel Graphics HD

GarantÃ­a: 90 dÃ­as.','','Presupuesto','Reparado con Cargo','Entregado','1','14');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1023','','28','2016-02-23','2016-02-23','','No permite entrar a algunas paginas de internet.
El teclado estÃ¡ desconectado, funciona lenta.','El equipo posee el teclado desconectado.
Hemos notado inestabilidad en el sistema operativo.
Se recomienda ampliar memoria ram. Posee 1 GB, lo cual es limitado para un buen funcionamiento del Sistema.','Se conecta teclado, ampliamos memoria ram a 2 GB.
Instalamos sistema operativo Windows 7, Antivirus, Office, programas adicionales y migramos informaciÃ³n del usuario.

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
('1027','','32','2016-03-14','2016-03-14','','Disco Duro daÃ±ado




','Se realizan testeos de hardware, detectamos que el disco duro se encuentra daÃ±ado. Por otra parte el equipo posee bastante suciedad interna lo cual afecta al sistema de refrigeraciÃ³n.','Se sustituye disco duro proporcionado por el cliente, instalamos sistema operativo mas programas adicionales, migramos informaciÃ³n del usuario y realizamos mantenimiento al sistema de refrigeraciÃ³n

Estuvo a prueba durante 48 hs y funciona correctamente. ','Costo $1500','Presupuesto','Reparado con Cargo','(Ninguna)','1','19');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1028','','33','2016-03-14','2016-03-14','','Hemos notado fallas en el sistema operativo.

','Se realizan diversos testeos de hardware y no presenta inconvenientes.','Se repara sistema operativo, estuvo a prueba y funciona ok.','Sin cargo','Presupuesto','Reparado sin Cargo','(Ninguna)','1','18');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1029','','34','2016-03-14','','','Chequeo general, poner a punto, no funciona wifi

 ',' El equipo posee el sistema operativo inestable, se deberÃ¡ reinstalar.
Es necesario realizar un mantenimiento al sistema de refrigeraciÃ³n.
Placa wifi no funciona correctamente debido a la falta de su antena.
Recomendamos actualizar el procesador

','Se reinstala sistema operativo y programas adicionales, instalamos procesador Core 2 duo, realizamos mantenimiento al sistema de refrigeraciÃ³n e instalamos placa wifi usb.
Finalmente migramos informaciÃ³n del usuario.

Estuvo a prueba y funciona correctamente. 

Costo: $ 2500','InstalaciÃ³n de sistema operativo, mantenimiento al sistema de refrigeraciÃ³n e instalaciÃ³n de placa wifi.

Costo : $ 2500','Presupuesto','Reparado con Cargo','Entregado','1','20');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1030','','35','2016-03-14','','','Chequear','El equipo se encuentra con el disco duro daÃ±ado, ','Se sustituye disco duro proporcionado por el cliente.
Clonamos informaciÃ³n y actualizamos antivirus.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo: $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','22');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1031','','36','2016-03-17','2016-03-17','','El equipo se cuelga ni bien inicia.','Se realizan testeos de hardware , notamos que el disco duro se encuentra daÃ±ado, Ã©ste se deberÃ¡ reemplazar.','Se sustituye disco duro proporcionado por el cliente.
Clonamos informaciÃ³n y actualizamos antivirus.

Estuvo a prueba durante 48 hs y funciona correctamente.

Costo $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','22');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1032','','37','2016-03-31','2016-03-31','','No enciende','El equipo se encuentra con un falso contacto en el botÃ³n de encendido.','Se repara falso contacto, estuvo a prueba y funciona correctamente. 

Sin costo.','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1033','','38','2016-03-31','2016-03-31','2016-03-31','Mantenimiento Mensual - Abonados.','','Costo de mantenimiento Mensual
Marzo 2016

$ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1034','','39','2016-03-31','2016-03-31','2016-03-31','No funcionan Algunas teclas del teclado, chequear si tiene virus, los puertos usb no funcionan.','Hemos realizado diversas pruebas, las teclas de subir volumen, aumentar o disminuir brillo funcionan ok.
El cliente deberÃ¡ tener en cuenta que para activar el uso de las mismas se debe mantener pulsada la tecla \"FN\"
Los puertos usb todos han sido testeados y funcionan correctamente.
El touchpad se encuentra deshabilitado desde las teclas de funciÃ³n.
Hemos notado presencia de virus.','Se realiza limpieza de virus, habilitamos touch pad, realizamos diversas pruebas y funciona correctamente.

','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1035','','40','2016-04-11','','','El equipo no da seÃ±al de video, chequear.','','','','Presupuesto','Ingresado','(Ninguna)','0','');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1036','','41','2016-04-11','','2016-04-11','sdsd','','','','Presupuesto','Ingresado','Entregado','0','1');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1037','','42','2016-04-11','','','No da imagen, no incia.
Chequear.','El equipo se encuentra con un banco de memoria daÃ±ado,  
El sistema operativo contiene algunos errores.

Hemos notado que la capacidad del disco duro estÃ¡ casi completa por su informaciÃ³n, lo cual genera lentitud de procesamiento.
','Se instala mÃ³dulo de memoria ram de 2 GB en el zÃ³calo operativo, se corrigen errores en el sistema operativo y se limpia registro de archivos temporales para liberar espacio en disco duro.
Estuvo a prueba y funciona correctamente.

Costo: $ 2500','','Presupuesto','Reparado con Cargo','Entregado','1','23');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1038','','43','2016-04-14','2016-04-14','2016-04-14','Instalar sistema operativo Windows 7, Antivirus y Office','El equipo fue comprado con 4 GB de memoria, el Bios reconoce solamente 2 GB, se deberÃ¡ reclamar en garantÃ­a al lugar de compra.','Se instala sistema operativo, Office,  Antivirus y programas adicionales.
Migramos informaciÃ³n respaldada.

Estuvo a prueba y funciona correctamente.

Costo: $ 1350','','Presupuesto','Reparado con Cargo','Entregado','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1039','','44','2016-04-14','2016-04-14','2016-04-14','VENTA DE EQUIPO','','Se vende equipo 
S/N: blgyn2j

DELL GX620
RAM 2 GB,/HDD 80 GB SAT/ PENTIUM D DUAL CORE/ W7

GarantÃ­a 6  meses.

Costo: $ 3000','','Presupuesto','Reparado con Cargo','Entregado','1','24');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1040','','45','2016-04-14','2016-04-14','2016-04-14','Chequear.','El equipo aleatorimente no emite seÃ±al de video.
La falla radica en la placa principal.
No justifica su reparaciÃ³n debido al alto costo.','Sin cargo.','','Presupuesto','Retiran sin Reparar','Entregado','1','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1041','','46','2016-04-14','','','Posible problema en placa de video, realizar chequeo general.','Se retira equipo para chequear en taller.
','','','Presupuesto','Ingresado','(Ninguna)','0','25');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1042','','47','2016-04-22','2016-04-22','2016-04-22','Chequear, no funcionan los puertos usb, migrar informaciÃ³n del equipo viejo.','Se realizan testeos de hardware sin presentar inconvenientes.
Notamos que los puertos usb estÃ¡n hundidos.
El sistema operativo y algunos programas se encuentran muy desactualizados.
Hemos detectado varios virus los cuales afectan al funcionamiento del sistema operativo.','Se corrige posiciÃ³n de los puertos usb, realizamos limpieza de virus, desinstalamos toolbars.
Instalamos office 2010, Antivirus Avast Free, Adobe Reader DC, VLC Media Player.
Actualizamos sistema operativo y por Ãºltimo migramos informaciÃ³n respaldada.
El precio incluye la venta de un cable VGA.

Costo: $1500','','Presupuesto','Reparado con Cargo','Entregado','1','26');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1043','','48','2016-04-22','2016-04-22','2016-04-22','No da seÃ±al de video.','El equipo se encuentra con el motherboard daÃ±ado.
No se justifica su reparaciÃ³n debido a que el hardware es muy antiguo.
','Sin cargo.','','Presupuesto','En ReparaciÃ³n','Entregado','1','26');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1044','','49','2016-05-02','2016-05-02','2016-05-02','Abono mensual y venta.','','Costo de Mantenimiento Mensual y venta de Access PÃ¶int TP- Link Tl-wa701nd y Switch TP-Link de 5 puertos.

Costo: $ 5098 + iva
','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1045','','50','2016-05-05','2016-05-05','2016-05-05','No detecta el disco duro','Se realizan testeos de hardware y notamos que el disco duro se encuentra daÃ±ado.
Ã‰ste se deberÃ¡ rememplazar..
','Se instala disco duro nuevo de 500 GB, instalamos sistema operativo y programas adicionales,
Antivirus, Office, etc.
Estuvo a prueba durante 48 hs y funciona correctamente.

Lamentablemente no es accesible a la informaciÃ³n del disco daÃ±ado para poder migrarla.

 
Costo: $ 3800','','Presupuesto','Reparado con Cargo','Entregado','1','27');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1046','','51','2016-05-07','','','Posible Problema de Disco Duro','Se realizan diversas pruebas, y el disco duro se encuentra daÃ±ado.<br/>Se presupuestarÃ¡ el reemplazo del mismo.<br/>Notamos que el equipo posee bastante suciedad interna, lo cual afecta al sistema de refrigeraciÃ³n.','Se instala disco duro de 250GB, instalamos Windows 7 y programas adicionales.<br/>Realizamos mantenimiento al sistema de refrigeraciÃ³n.<br/>Estuvo a prueba y funciona Correctamente.<br/>Costo $2300<br/>GarantÃ­a 6 meses<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','28');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1047','','52','2016-05-12','','','EstÃ¡ lenta, algunos juegos no se pueden instalar, resetear password de windows.','Se realizan testeos de hardware, detectamos que el motherboard se encuentra daÃ±ado.<br/>Lamentablemente no se consigue el mism.  Se presupuestarÃ¡ Motherboard y Microprocesador I3.','Se instala Motherboard y Microprocesador Intel  I3, <br/>Configuramos sistema operativo de cero, instalamos juegos, antivirus y programas adicionales.<br/>Realizamos lubricaciÃ³n al fan de la fuente.<br/>Por Ãºltimo se migra informaciÃ³n respaldada.<br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Costo: $ 3150<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','29');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1048','','53','2016-05-12','','','EstÃ¡ lento, se cuelga, chequear si tiene virus hacer limpieza.','Se realizan testos de hardware y hemos notado que un mÃ³dulo de memoria se encuentra daÃ±ado.
Por otra parte el fan del microprocesador estÃ¡ suelto.
El equipo tiene software malicioso instalado, virus y toolbars que generan lentitud.','Se sujeta fan de microprocesador correctamente, colocamos mÃ³dulo de memoria de 1 GB, Instalamos sistema operativo y programas adicionales.
Por Ãºlitmo se migra informaciÃ³n respaldada.
Estuvo a prueba y funciona correctamente.

Costo: $1300','','Presupuesto','En ReparaciÃ³n','Entregado','1','8');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1049','','54','2016-06-03','2016-06-03','2016-06-03','Mudar equipos de salÃ³n.','','Se vende Switch TP-LINK de 5 Bocas y Zapatilla para instalaciÃ³n de equipos en salÃ³n.<br/><br/>Costo: $ 742 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1050','','55','2016-06-03','2016-06-03','2016-06-03','','','Mantenimiento Mensual del Centro.<br/><br/>Costo: $ 3500 + iva.','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1051','','56','2016-06-07','2016-06-07','2016-06-07','No inicia, problema de teclado.
Chequear.','Se realizan diversas pruebas de hardware.<br/>El teclado se encuentra en corto, se deberÃ¡ reemplazar.<br/>Hemos detectado inestabilidad en el sistema operativo y presencia de virus.','Se reemplaza teclado, instalamos sistema operativo y programas adicionales.<br/>Migramos informaciÃ³n respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','1','30');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1052','','57','2016-06-15','','','No incia','El equipo sufriÃ³ un golpe.<br/>Presenta un corto en el motherboard, intentamos recuperarlo pero sin Ã©xito.<br/>Se presupuestarÃ¡ reemplazo de motherboard.<br/><br/>Costo: $ 6500 ','Presupuesto rechazado.<br/>Costo de diagnÃ³stico. $ 200','Link Ebay

http://www.ebay.com/itm/Asus-X401A-Intel-Motherboard-60-N3OMB1103-A05-31XJ1MB00N0-/381666201602?hash=item58dd141002:g:xzMAAOSwPc9Ww5y9','Presupuesto','Retiran sin Reparar','Entregado','1','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1054','','59','2016-07-01','','','','','Mantenimiento Mensual abonados<br/>Costo $3500 + IVA','','Cliente abonado','Ingresado','(Ninguna)','0','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1055','','60','2016-07-08','','','Chequear','Estamos realizando diversas pruebas..<br/>Hemos detectado hasta el momento que el equipo posee el disco duro daÃ±ado...<br/>','','','Cliente abonado','En ReparaciÃ³n','(Ninguna)','0','1');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1056','','61','2016-07-08','','','En ocasiones deja de dar seÃ±al de video.','El equipo presenta el motherboard daÃ±ado, se deberÃ¡ reemplazar.<br/><br/>El costo del Motherboard es de $ 2477 + iva<br/>1 AÃ±o de garantÃ­a.<br/>* Mano de Obra no tiene costo - Cliente Abonado.<br/><br/>','Se reemplaza Motherboard, se mantiene a prueba y funciona correctamente.<br/><br/>Costo: $ 2477 + iva','El costo por reemplazo de Motherboard es de $ 2677 + iva
Motherboard Gigabyte GA-A55M-DS2 - Banifox','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1057','','62','2016-07-08','','','El equipo no da seÃ±al de video, posible problema en el chip de video.','El equipo presenta problemas en el chip de video.','Se recuperan pistas del chip de video, realizamos mantenimiento al sistema de refrigeraciÃ³n.<br/>Activamos windows, instalamos antivirus AVAST FREE y se realiza limpieza de virus.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','0','31');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1058','','63','2016-07-12','','','El equipo no emite seÃ±al de video','El equipo presenta el motherbaord daÃ±ado, se deberÃ¡ reemplazar..','','','Presupuesto','En ReparaciÃ³n','(Ninguna)','0','32');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1059','','64','2016-07-18','2016-07-18','2016-07-18','El equipo aleatoriamente se apaga, chequear','Se realizan diversos testos de hardware.<br/>Hemos detectado la fuente de poder daÃ±ada y bastante suciedad interna, lo cual afecta al sistema de refrigeraciÃ³n generando recalentamiento y provocando apagados inesperados.','Se realiza mantenimiento al sistema de refrigeraciÃ³n, cambiamos fuente de poder, reparamos sistema operativo y se hace una limpieza profunda de virus.<br/>Estuvo a prueba y funciona correctamente. <br/><br/>Costo: $ 2000','','Presupuesto','Reparado con Cargo','Entregado','1','33');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1060','','65','2016-07-22','2016-07-22','2016-07-22','Problema con internet','El router se encuentra con las configuraciones de fÃ¡brica, Es necesario reconfigurarlo.<br/>Se ha detectado el cable que conecta el mÃ³dem con el router en mal estado.<br/>','Se reconfigura router y se sustituye cable de red.<br/>Por seguridad se restringe con clave de acceso al mismo evitando asÃ­ cambios en su configuraciÃ³n sin autorizaciÃ³n previa.<br/><br/>Usuario y Clave para acceder al Router.<br/>Usuario: admin<br/>ContraseÃ±a: d4r50luc10n35<br/><br/>GarantÃ­a: 3 meses.<br/><br/>Costo: $ 1500<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1061','','66','2016-07-27','','','Posible problema de disco duro.','','','','Garantia Reparacion','Ingresado','(Ninguna)','0','28');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1062','','67','2016-07-29','2016-07-29','2016-07-29','Manteniminento','','Mantenimiento mensual Abonados.<br/><br/>Costo: $ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1063','','68','2016-08-28','','2016-08-28','Chequear, realizar mantenimiento general.','El equipo presenta el sistema operativo inestable. Es necesario realizar mantenimiento al sistema de refrigeraciÃ³n.<br/>Notamos que cuenta con poca memoria ram para un Ã³ptimo funcionamiento.<br/>Es necesario reparar plÃ¡stico de bisagra, lo cual dificulta abrir y cerrar la tapa del equipo.','Se realiza mantenimiento al sistema de refrigeraciÃ³n. <br/>Reparamos plÃ¡stico de bisagra.<br/>Ampliamos memoria ram a 6 GB, instalamos sistema operativo y programas adicionales, por Ãºltimo se migra informaciÃ³n respaldada.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Costo: $ 3600 ','','Presupuesto','Reparado con Cargo','Entregado','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1064','','69','2016-08-28','2016-08-28','2016-08-28','Instalar Ubuntu, Corel y migrar informaciÃ³n del equipo viejo.','El antivirus y office pre instalados son de prueba.<br/>EstÃ¡n obsoletos.','Se instala Ubuntu Ver 16.04, Instalamos Office 2010, Corel y Antivirus.<br/>Creamos particiÃ³n en el disco duro llamada \" Datos \"<br/>Por Ãºltimo se migra informaciÃ³n del equipo viejo.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1300<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','34');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1065','','70','2016-08-31','2016-08-31','2016-08-31','Mantenimiento','','Mantenimiento mensual abonados.<br/><br/>Costo: $ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1066','','71','2016-08-31','','2016-08-31','No da seÃ±al de video, hace 5 pitidos.','Se realizan testeos de hardware y notamos que el equipo presenta el microprocesador daÃ±ado.<br/>','Se sustituye microprocesador, estuvo a prueba y funciona correctamente.<br/><br/>El repuesto va en calidad de donaciÃ³n.<br/>Sin cargo.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1067','','72','2016-09-04','2016-09-04','','Venta de Notebook','','Se vende Notebook HP Compaq NC6320<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','Entregado','1','35');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1068','','73','2016-09-07','2016-09-07','2016-09-07','El servidor se encuentra muy lento, chequear.','El equipo presenta el sistema de refrigeraciÃ³n obstruido por suciedad  y requiere mantenimiento. Ã‰sto puede provocar recalentamiento, apagados inesperados e inclusive hasta daÃ±os en el propio hardware.<br/>El sistema operativo instalado es inestable y obsoleto. Cuenta con windows xp versiÃ³n UE.<br/>Para su correcto funcionamiento como \" servidor \" es necesario al menos ampliar la memoria ram a 4 GB . sustituir el microprocesador celeron por un Core 2 Duo e instalar windows 7 pro.<br/><br/>','Se enviarÃ¡ por mail presupuesto por la reparaciÃ³n del mismo y por otras posibles soluciones.','','Presupuesto','Retiran sin Reparar','Entregado','1','36');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1069','','74','2016-09-15','','2016-09-15','Hace ruido el fan, chequear.','El equipo presenta soportes de bisagra de plÃ¡stico daÃ±ados, los restos de plÃ¡stico obstruyen el sistema de refrigeraciÃ³n.<br/>Notamos que es necesario realizar una limpieza de virus y mantenimiento al sistema operativo.','Se realiza reparaciÃ³n de plÃ¡sticos de bisagra, mantenimiento al sistema de refrigeraciÃ³n.<br/><br/>Corregimos errores en el sistema operativo, realizamos limpieza de virus e instalamos antivirus avast free 2016.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2000','','Presupuesto','En ReparaciÃ³n','Entregado','0','31');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1070','','75','2016-09-17','','2016-09-17','Por momentos se dispara el cursor y se va al final de la hoja, han probado desabilitando el touchpad y la falla persiste.','Se realizan diversas pruebas de hardware y detectamos que el teclado se encuentra en corto.<br/>Es necesario reemplazarlo.','Se reemplaza teclado, se realizan pruebas respondiendo de manera satisfactoria.<br/><br/>Costo: $ 2580','','Cliente abonado','Reparado con Cargo','Entregado','1','37');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1071','','76','2016-09-19','2016-09-19','2016-09-19','Reinstalar sistema operativo.','Se testea todo el hardware del equipo satisfactoriamente.<br/>A pedido del cliente instalaremos sistema operativo Windows 7.','Se instala windows 7 pro y actualizaciones de seguridad.<br/>Instalamos Antivirus Avast Free, Office 2010, Reproductor VLC Media Player, Net Framework, Java, Winrar, etc.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>Costo: $ 1350 ','','Presupuesto','Reparado con Cargo','Entregado','1','38');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1072','','77','2016-09-19','2016-09-19','2016-09-19','El equipo no termina de cargar el sistema operativo, ver la posibilidad de ampliar la memoria ram.','Se realizan testeos de hardware, notamos que el equipo cuenta con el disco duro daÃ±ado.<br/>Es necesario reemplazarlo.<br/>Se cotizarÃ¡ ampliaciÃ³n de memoria ram a 8 GB.','Se sustituye disco duro y se amplia memoria ram a 8 GB.<br/>Instalamos sistema operativo Windows 7 pro SP1, antivirus Avast Free, Office 2010, Corel X7 y programas adicionales.<br/>Por Ãºltimo se migra informaciÃ³n recuperada del disco duro defectuoso.<br/><br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/><br/>GarantÃ­a: <br/>6 meses mano de obra.<br/>1 aÃ±o memoria ram  y disco duro.<br/><br/>Costo: $ 5760<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','39');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1073','','78','2016-09-22','2016-09-22','2016-09-22','Puesta a punto Inicial','','Montaje, instalaciÃ³n y configuraciÃ³n de todo el equipamiento informÃ¡tico de la red DECOS.<br/><br/>Costo: U$S 850 + iva<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','40');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1074','','79','2016-09-28','2016-09-28','2016-09-28','','','Mantenimiento mensual abonados.<br/><br/>Costo: $ 3500 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1075','','80','2016-10-11','','2016-10-11','Chequear y actualizar.','Se realizan testeos de hardware sin presentar inconvenientes.<br/>El equipo cuenta con un sistema operativo obsoleto, <br/>Se recomienda actualizar a windows 7, para ello va a ser necesario ampliar memoria ram y reemplazar el disco duro por uno sata para un funcionamiento optimo.','Se reemplaza disco duro por un sata de 250 GB, ampliamos memoria ram a 2 GB y por Ãºltimo se instala windows 7 pro, antivirus, office, etc.<br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/>GarantÃ­a 6 meses.<br/><br/>Costo: $ 3200','','Presupuesto','Reparado con Cargo','Entregado','1','41');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1076','','81','2016-10-18','','','Chequear, estÃ¡ lenta, instalar programas, office, etc.','Se realizan diversas pruebas sin presentar inconvenientes.<br/>Hemos verificado y lamentablemente no se puede migrar a windows 7, no existen controladores homologados por hp para este modelo.<br/><br/>Se instalarÃ¡n aplicaciones faltantes, office, antivirus, adobe reader, etc.','Se instala Office 2010, Antivirus, Adobe Reader DC y Do PDF.<br/><br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 800<br/><br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','1','42');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1077','','82','2016-10-21','2016-10-21','2016-10-21','Instalar Sistema Operativo y Configurar como servidor','Instalar Sistema Operativo Windows 7 y configurar como servidor.','Se instala Sistema Operativo, actualizaciones de Windows, controladores,  antivirus y cliente de acceso remoto, <br/>CreaciÃ³n del grupo de trabajo y carpetas compartidas.<br/>Configuramos Cobian Backup Gravity 11 para backup de compartidas.<br/>Migramos informaciÃ³n del viejo servidor de archivos.<br/>Se incluyen todos los equipos de la red dentro del grupo de trabajo, unificamos antivirus e instalamos nuevo puesto de trabajo.<br/>Verificamos configuraciones de red de todos los dispositivos.<br/><br/>Costo: $ 5370 <br/>','','Presupuesto','Reparado con Cargo','Entregado','1','43');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1078','','83','2016-11-04','','','Chequear..','Se realizan diversos testeos de hardware, notamos que la fuente de poder se encuentra daÃ±ada.<br/>Por otra parte detectamos que  el sistema de refrigeraciÃ³n estÃ¡ obstruido por suciedad, su pasta disipadora estÃ¡ reseca.','Se reemplaza fuente de poder, se realiza mantenimiento al sistema de refrigeraciÃ³n, realizando una limpieza interna general e insertando nuevamente su pasta disipadora en el microprocesador.<br/><br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1900','','Presupuesto','Reparado con Cargo','Entregado','1','44');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1079','','84','2016-11-04','','','Chequear','El equipo emite seÃ±al de video sin brillo.<br/>Se realizan diversas pruebas de hardware y detectamos un fallo en el display.<br/>Notamos tambiÃ©n que es necesario realizar un mantenimiento general, sistema de refrigeraciÃ³n, limpieza de sofware para liberar espacio en disco el cual se encuentra bastante lleno y provoca lentitud.','Se realiza mantenimiento general, limpieza de software, sistema de refrigeraciÃ³n y reparaciÃ³n de display (corto en tubo de iluminaciÃ³n).<br/>Por Ãºltimo se actualiza paquete de office y antivirus.<br/>Estuvo a prueba y funciona ok.<br/><br/>GarantÃ­a 90 dÃ­as.<br/><br/>Costo: $ 2000','','Presupuesto','Reparado con Cargo','Entregado','1','45');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1080','','85','2016-11-04','','','Venta de equipo.

','','Venta de equipo.<br/><br/>CaracterÃ­sticas:<br/><br/>Intel Pentium G2020 2.9 GHZ<br/>Ram: 8 GB<br/>HDD Sata 500 GB<br/>Motherboard Asrock B75M-GL<br/>Windows 7 Profesional<br/><br/>GarantÃ­a: 6 meses.<br/>Costo: $ 4500','','Presupuesto','Reparado con Cargo','(Ninguna)','0','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1081','','86','2016-11-16','2016-11-16','','Venta de equipo','','Venta e instalaciÃ³n de equipo.<br/>El mismo cuenta con las siguientes caracterÃ­sticas:<br/>Dell Optiplex GX620/Pentium D/HDD 80 GB/DVD/W7<br/><br/>GarantÃ­a del equipo : 6 Meses<br/><br/>Costo: $ 3500','','Presupuesto','Reparado con Cargo','(Ninguna)','1','46');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1082','','87','2016-11-18','2016-11-18','','VENTA DE EQUIPO','','Venta de equipo.<br/><br/>Hp Elite 8000 - Serie: CZC04922PH<br/>Core 2 Duo E7500<br/>HDD 250 GB<br/>4 GB de RAM <br/>Windows 7 Pro.<br/>GarantÃ­a 1 aÃ±o.<br/><br/>Se migra informaciÃ³n del equipo antiguo.<br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1083','','88','2016-12-04','2016-12-04','2016-12-04','Chequear.','Se realizan diversas pruebas de hardware sin presentar inconvenientes.<br/>El sistema operativo estÃ¡ inestable, es recomendable realizar una reinstalaciÃ³n del mismo.<br/>A su vez recomendamos ampliar la memoria ram ya que cuenta con muy poca para un correcto funcionamiento.','Se amplia memoria ram a 4 GB, reinstalamos sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $2600','','Presupuesto','Reparado con Cargo','Entregado','1','47');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1084','','89','2016-12-09','2016-12-09','2016-12-09','No da seÃ±al de video','El equipo presenta falso contacto en el modulo de memoria ram.<br/>Notamos suciedad en sistema de refrigeraciÃ³n.<br/>El sistema operativo se encuentra inestable y posee aplicaciones de riesgo las cuales provocan lentitud en el sistema.','Se realiza mantenimiento al sistema de refrigeraciÃ³n, desinstalamos aplicaciones de riesgo y se realiza limpieza de virus.<br/>Por Ãºltimo se corrigen errores en el sistema operativo.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','6');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1085','','90','2016-12-19','2016-12-19','2016-12-19','NO ENCIENDE','Se realizan diversas pruebas y el dvr presenta la fuente de poder daÃ±ada.','Se sustituyen componentes daÃ±ados de fuente de poder.<br/>Realizamos una limpieza interna al dvr e instalamos correctamente su disco duro, el cual se encontraba suelto.<br/><br/>Costo: $ 1600','','Presupuesto','Reparado con Cargo','Entregado','1','48');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1086','','91','2016-12-20','2016-12-20','2016-12-20','No se conecta a internet','Se realizan testeos de hardware.<br/>Detectamos un fallo en el disco duro y presencia de virus.<br/>Va a ser necesario realizar un mantenimiento al sistema de refrigeraciÃ³n.','Se sustituye disco duro, <br/>Aplicamos imagen del sistema operativo limpio e instalamos programas adicionales, office, antivirus,etc.<br/>Migramos informaciÃ³n respaldada.<br/>Por Ãºltimo se realiza mantenimiento al sistema de refrigeraciÃ³n.<br/><br/>Estuvo a prueba y funciona correctamente.<br/>GarantÃ­a: <br/>                    Mano de obra 3 meses.<br/>                    Repuesto 1 aÃ±o.<br/><br/>Costo: $ 3540<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','49');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1087','','92','2016-12-20','2016-12-20','2016-12-20','No enciende.','Se realizan testeos de hardware.<br/>Detectamos que el equipo presenta un corto en su placa principal, no detecta entrada de corriente.<br/>','Se intenta recuperar placa principal pero lamentablemente sin Ã©xito.<br/>El costo de Ã©ste repuesto es muy elevado y no justifica su reparaciÃ³n.<br/><br/>Se instala disco duro en bahÃ­a usb y se verifica integridad de los datos.<br/><br/>Costo: $ 1900','','Presupuesto','Retiran sin Reparar','Entregado','1','36');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1088','','93','2016-12-30','2016-12-30','','InstalaciÃ³n de sistema de video vigilancia.','','Se instala nuevo sistema de video vigilancia.<br/>ConfiguraciÃ³n: <br/>3 cÃ¡maras Linethink HD 720p exteriores. <br/>DVR Linethink 4 CH AHD.<br/>Fuente de poder 5A 12V.<br/>HDD 500 GB<br/><br/>GarantÃ­a: 6 meses.<br/><br/>Costo: $15900','','Presupuesto','Reparado con Cargo','(Ninguna)','1','50');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1089','','94','2017-01-04','2017-01-04','2017-01-04','Venta de Computadora','','Venta de Computadora<br/><br/>Amd AThlon X2 2.9 GHZ<br/>Ram 2 GB DDR3<br/>HDD 160 GB<br/>Opticos DVD<br/>Windows 8 Pro<br/><br/>Incluye teclado y mouse.<br/><br/>GarantÃ­a: 6 meses.<br/>La garantÃ­a no incluye servicio on-site.<br/><br/>Costo: $ 4000','','Presupuesto','Reparado con Cargo','Entregado','1','51');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1090','','95','2017-01-16','2017-01-16','2017-01-16','Chequear','Se realizan diversos testeos de hardware y detectamos que el disco duro se encuentra daÃ±ado.<br/>El equipo cuenta con poca memoria ram para un correcto funcionamiento del sistema operativo, se recomienda ampliar la memoria ram a 4 GB.','Se amplia memoria ram a 4 GB, se sustituye disco duro, se instala sistema operativo y porgramas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>** Lamentablemnte no es posible acceder a la informaciÃ³n del disco duro viejo, ya que se encuentra muy daÃ±ado.<br/><br/>Costo: $ 3800','GarantÃ­a 3 meses mano de obra y 1 aÃ±o repuestos - 16/01/16','Presupuesto','Reparado con Cargo','Entregado','1','52');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1091','','96','2017-01-30','2017-01-30','2017-01-30','Venta de Notebook','','Se vende Notebook Samsung 300V.<br/>INTEL I5/HDD 320 GB/RAM 4 GB/ 15.6\"/ WINDOWS 10<br/><br/>GarantÃ­a: 3 meses.<br/><br/>Costo: U$S 300 ','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1092','','97','2017-01-30','','','Venta de equipo','','SE VENDE EQUIPO HP ELITE 8200/INTEL I3/HDD 250GB/RAM 4GB/DVD-RW/W7 PRO<br/><br/>Migramos informaciÃ³n del equipo viejo y se instalan programas adicionales.<br/><br/>GarantÃ­a 1 aÃ±o.<br/><br/>Costo: U$S 300<br/><br/><br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','10');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1093','','98','2017-02-03','2017-02-03','2017-02-03','En ocasiones no enciende.','Se realizan diversos testeos de hardware y detectamos que la placa principal se encuentra daÃ±ada.','Se sustituye placa principal y micro procesador en garantÃ­a.<br/>Estuvo a prueba y funciona correctamente.<br/>Sin cargo.','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1094','','99','2017-02-03','2017-02-03','','Chequear.','Se realizan diversas pruebas y detectamos que la placa de video se encuentra daÃ±ada.<br/>Es necesario realizar un mantenimiento general al sistema de refrigeraciÃ³n y reinstalar el sistema operativo que se encuentra inestable.<br/>','Se realiza mantenimiento al sistema de refrigeraciÃ³n.<br/>Instalamos placa de video, quedando instalada una Geforce G210.<br/>Instalamos sistema operativo y programas adicionales.<br/>Por Ãºltimo migramos informaciÃ³n respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3090 <br/>','','Presupuesto','Reparado con Cargo','Entregado','1','53');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1095','','100','2017-03-02','2017-03-02','','No inicia','El equipo presenta un falso contacto en modulo de memoria ram.','Se reconecta modulo de memoria ram, realizamos pruebas y funciona ok.<br/>GarantÃ­a de reparaciÃ³n.','','Garantia Reparacion','Reparado sin Cargo','Entregado','1','29');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1096','','101','2017-03-13','','2017-03-13','No enciende','Se realizan diversos testos y detectamos que la placa principal se encuentra daÃ±ada.<br/>DeberÃ¡ ser reemplazada.','Se sustituye placa principal.<br/>Realizamos diversas pruebas y funciona correctamente.<br/><br/>Costo: $1500<br/><br/>GarantÃ­a:<br/>Mano de obra 3 meses<br/>Repuesto:  3 Meses.','','Presupuesto','Reparado con Cargo','Entregado','1','11');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1097','','102','2017-03-17','','2017-03-17','Venta de equipo','','Se vende equipo Dell Latitude E6430<br/>Recertificado.<br/>S/N: 4XF49A01<br/><br/>GarantÃ­a: 1 AÃ±o.<br/>En el costo queda incluida visita tÃ©cnica, migraciÃ³n de informaciÃ³n y configuraciones.<br/><br/><br/>Costo: $12500','','Presupuesto','Reparado con Cargo','Entregado','0','54');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1098','','103','2017-03-24','2017-03-24','2017-03-24','Chequear','Se realizan diversos testeos de hardware.<br/>Notamos que el equipo presenta el disco duro daÃ±ado.<br/>TambiÃ©n una de las bisagras de pantalla se encuentra daÃ±ada.<br/><br/>','Se reemplaza disco duro, <br/>Instalamos sistema operativo, office, antivirus, etc.<br/><br/>* Lamentablemente el disco duro antiguo se encuentra muy daÃ±ado, la informaciÃ³n es inaccesible.<br/>No es posible migrar archivos antiguos.<br/><br/>Costo: $ 3800<br/><br/>Nota: <br/>Informamos al cliente que algunas teclas del teclado se encuentran daÃ±adas, Tomamos los datos correspondientes del teclado por si mas adelante confirman realizar el cambio del mismo.<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','55');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1099','','104','2017-03-24','2017-03-24','2017-03-24','Chequear','Se realizan testos de hardware.<br/>Detectamos que presenta el disco duro daÃ±ado, deberÃ¡ ser reemplazado.<br/>TambiÃ©n es necesario realizar un mantenimiento al sistema de refrigeraciÃ³n.<br/>Cliente solicita volcado de informaciÃ³n a 2 pendrives de 32 GB.<br/><br/>Costo del presupuesto: $ 3770<br/><br/>* Aceptan migraciÃ³n de informaciÃ³n a  2 pendrives, quedando pendiente la reparaciÃ³n del equipo.<br/>','Se migra informaciÃ³n a 2 pendrives de 32 GB.<br/><br/>Costo: $ 1500<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','55');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1100','','105','2017-03-24','2017-03-24','2017-03-24','Chequear, no conecta a internet.','Se realizan testeos de hardware.<br/>Detectamos que el disco duro se encuentra daÃ±ado, va a ser necesario su reemplazo.<br/>Por otra parte notamos que el equipo recalienta, esto es debido a obstrucciÃ³n en el sistema de refrigeraciÃ³n.<br/>','Reemplazamos disco duro, instalamos sistema operativo, office, antivirus, etc.<br/>Se migra informaciÃ³n del usuario.<br/>Por Ãºltimo se realiza mantenimiento al sistema de refrigeraciÃ³n.<br/>Estuvo a prueba durante 48 hs y funciona correctamente.<br/>Realizamos diversas pruebas de conexiÃ³n a internet satisfactorias.<br/><br/>Costo: $ 3800','','Presupuesto','Reparado con Cargo','Entregado','1','56');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1101','','106','2017-03-31','2017-03-31','2017-03-31','No da imagen, revisar audio.','Se realizan diversos testeos. Detectamos que presenta 2 mÃ³dulos de memoria daÃ±ados.<br/>DeberÃ¡n ser reemplazados.<br/>Por otra parte identificamos un desperfecto en el panel frontal de audio y un corto en la salida trasera de audio. <br/>Por otra parte consideramos que es necesario realizar un mantenimiento al sistema de refrigeraciÃ³n.<br/><br/>','Se instalan 2 mÃ³dulos de memoria ram de 1 GB.<br/>Instalamos placa de sonido.<br/>Realizamos mantenimiento al sistema de refrigeraciÃ³n.<br/>De modo preventivo se realiza comprobaciÃ³n de disco con chkdsk y se ejecuta analisis profundo en busca de virus.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2000<br/><br/>GarantÃ­a: 6 meses.','','Presupuesto','Reparado con Cargo','Entregado','1','57');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1102','','107','2017-04-03','2017-04-03','2017-04-03','No da imagen,.','Se realizan diversos testeos y detectamos un falso contacto en mÃ³dulos de memoria.<br/>Hemos notado una versiÃ³n muy desactualizada de bios.','Se reconectan mÃ³dulos de memoria  y actualizamos bios.<br/>De modo preventivo se realiza comprobaciÃ³n de disco con chkdsk , se actualiza antivirus y se ejecuta analisis profundo en busca de virus.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $800<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','20');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1103','','108','2017-04-06','','','Visita TÃ©cnica ','','Se vende placa Wifi usb, 2 cables de corriente, un cable vga y mouse.<br/><br/>Se instala equipo fÃ­sicamente y actualizamos antivirus.<br/>Se mantiene a prueba satisfactoriamente<br/>.Costo de Visita TÃ©cnica y Repuestos: $2655<br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','0','17');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1104','','109','2017-04-28','','','Mantenimiento Mensual','','Se detallan los repuestos venidos para  la reparaciÃ³n de 2 computadoras de escritorio.<br/>Incluida el costo de mantenimiento mensual del centro.<br/><br/>Detalle:<br/> <br/>2  Memorias DRR2 de 1GB - $ 480 + iva<br/>7 Cables de Corriente 3 en lÃ­nea - 420 +iva<br/>1  HDD Sata 80 GB -  $ 350 + iva<br/>Mantenimiento Mensual Abonados - $ 3500 +<br/><br/>Total: $ 4750 + iva','','Cliente abonado','Reparado con Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1105','','110','2017-04-28','2017-04-28','2017-04-28','DonaciÃ³n','Se entrega en calidad de donaciÃ³n 2 computadoras de escritorio.','Se entrega en calidad de donaciÃ³n 2 computadoras de escritorio.','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1106','','111','2017-05-02','','','','','Se vende equipo Dell  1 aÃ±o de GarantÃ­a<br/>GarantÃ­a de la BaterÃ­a 6 meses<br/>Costo u$s 420<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','58');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1107','','112','2017-05-04','2017-05-04','2017-05-04','El equipo presenta problemas de audio.','Se realizan diversos testeos de hardware.<br/>Detectamos que presenta problemas de audio.<br/>La falla es provocada por la placa principal.<br/>El costo de reemplazo de la parte es muy costo por lo cual se ofrece una soluciÃ³n alternativa.','Se instala placa de audio usb y se vende parlante Logitech Z51.<br/>De modo preventivo se realiza un mantenimiento al sistema operativo, instalamos un nuevo antivirus dado que el anterior se encontraba obsoleto.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2200 ','','Presupuesto','Reparado con Cargo','Entregado','1','48');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1108','','114','2017-05-05','2017-05-05','2017-05-05','El equipo no se conecta a internet.','Se realizan diversos testeos de hardware sin presentar inconvenientes.<br/>Notamos que la falla es proveniente de un error en el sistema operativo. <br/>DeberÃ¡ ser reinstalado.<br/>Hemos notado tambiÃ©n que cuenta muy poca memoria ram.','Se instala sistema operativo y programas adicionales.<br/>Ampliamos memoria ram a 2 GB.<br/>Estuvo a prueba y funciona correctamente.<br/>','','Cliente abonado','Reparado sin Cargo','Entregado','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1109','','115','2017-05-29','','','No funcionan los juegos del Facebook
Solicita cambiar idioma de Ingles a EspaÃ±ol
','Se realizan testeos de hardware<br/>Sin presentar inconveniente<br/>Se actualiza el Sistema Operativo a Windows 10 EspaÃ±ol<br/>Se corrige conflicto de Adobe Flash Player con aplicaciones del Facebook<br/>Por ultimo se activa Windows Defender <br/>Estuvo a prueba y funciona todo perfecto<br/>Costo$1000<br/>','','','Presupuesto','Reparado con Cargo','(Ninguna)','0','59');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1110','','116','2017-06-14','','2017-06-14','Disco Duro','Se realizan diversas pruebas, y se detecta que el equipo presenta en disco duro daÃ±ado.<br/>DeberÃ¡ ser reemplazado','Se instala disco duro nuevo,instalamos sistema operativo y programas adicionales.<br/>Se logro recuperar gran parte de la informaciÃ³n del disco daÃ±ado.<br/>Estuvo a prueba y funciona correctamente<br/>Costo $3800','','Presupuesto','Reparado con Cargo','Entregado','1','22');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1111','','117','2017-06-28','2017-06-28','2017-06-28','Restaurar Password de Administrador','','Se restaura Password administrador local y se cambia nombre al usuario antiguo.<br/><br/>Usuario: DECOS<br/>ContraseÃ±a: d3c05475Cerrito','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1112','','118','2017-06-28','2017-06-28','2017-06-28','Tiene Virus','El pendrive tiene virus.<br/>','Fueron recuperados los documentos ocultos por el virus.<br/>Se formatea pendrive quedando limpio  y se vuelca respaldo de los archivos.<br/>','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1113','','119','2017-07-10','2017-07-10','2017-07-10','Chequear, funciona mal en internet.','Se realiza testeo de memoria ram y hdd sin presentar fallos.<br/>Notamos que el equipo cuenta con 2 antivirus instalados lo cual puede provocar lentitud al sistema.<br/>Se recomienda actualizar a windows 10 ya que la versiÃ³n instalada no se encuentra estable.','Se corrigen conflictos con antivirus, instalando una versiÃ³n nueva de avast quedando como Ãºnico en el sistema.<br/>Actualizamos sistema operativo a Windows 10, se prueba y funciona correctamente.<br/><br/>Costo: $ 1500<br/>Incluido retiro y entrega del mismo.','','Presupuesto','Reparado con Cargo','Entregado','1','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1114','','120','2017-07-10','2017-07-10','2017-07-10','El equipo se encuentra muy lento. 
Chequear.','Se realizan testeos de disco duro y memoria pasando los mismos de manera satisfactoria.<br/>El sistema operativo se encuentra inestable, se deberÃ¡ reinstalar el mismo.<br/>Debido al tiempo de uso que tiene el equipo recomendamos realizar un mantenimiento al sistema de refrigeraciÃ³n.','Se instala sistema operativo y programas adicionales, incluido el pasaje de la informaciÃ³n del usuario.<br/>Realizamos mantenimiento al sistema de refrigeraciÃ³n.<br/><br/>Estuvo a prueba y funciona correcamente.<br/>Costo: $ 2000','','Presupuesto','Reparado con Cargo','Entregado','1','7');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1115','','121','2017-07-10','2017-07-10','2017-07-10','El equipo no enciende, posible problema de placa principal','Se realizan diversas pruebas de hardware y notamos que el equipo no detecta entrada de corriente.<br/>El cargador del mismo se encuentra daÃ±ado.','Se descarga placa principal y se restablece configuracion de bios.<br/>Probamos con un cargador de prueba y el equipo responde de manera satisfactoria.<br/>El cliente deberÃ¡ comprar un adaptador de corriente.<br/><br/>Sin costo.','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1116','','122','2017-07-21','','','','Se realizan testeos de hardware, sin presentar inconvenientes.<br/>Notamos exceso de suciedad interno,lo cual afecta al sistema de refrigeraciÃ³n.<br/>Solicitan reinstalacion y ampliaciÃ³n  de memoria RAM<br/>','Se realiza mantenimiento al sistema de refrigeraciÃ³n.<br/>Ampliamos memoria RAM a 8 GB.<br/>Instalamos sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona Correctamente<br/>Costo: $3300<br/><br/>GARANTÃA DE REPUESTO 1 AÃ‘O','','Presupuesto','Reparado con Cargo','Entregado','1','16');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1117','','123','2017-07-21','','','','Se realizan testeos de hardware sin presentar inconvenientes.<br/>El sistema operativo se encuentra inestable por el cual es recomendable reinstalar el mismo.','Se instala sistema operativo,antivirus y programas adicionales.<br/>Por Ãºltimo se migra perfil de la usuaria.<br/>Estuvo a prueba y funciona correctamente','','Cliente abonado','Reparado sin Cargo','Entregado','1','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1118','','124','2017-07-25','2017-07-25','2017-07-25','Hace un ruido raro, chequear','El equipo presenta cucarachas en su interior, fuente de poder, placa, etc.<br/>Presenta la fuente de poder daÃ±ada, recomendamos actualizar a windows 10.','Se realiza limpieza interna, y reemplazamos fuente de poder.<br/>Por Ãºltimo se actualiza sistema operativo a Windows 10 y se instala antivirus actualizado.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1950<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','62');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1119','','125','2017-07-25','2017-07-25','2017-07-25','Chequear esta muy lenta','Se realizan testeos de hardware sin presentar inconvenientes.<br/>Notamos que el sistema operativo se encuentra inestable y con presencia de virus.<br/>El equipo cuenta con 2 antivirus instalados, lo cual consume recursos innecesariamente. ','Se realiza limpieza al sistema de refrigeraciÃ³n.<br/>Corregimos errores en el sistema operativo y actualizamos a Windows 10, <br/>Realizamos limpieza de virus satisfactoria con la Ãºltima versiÃ³n de Avast Free la cual quedarÃ¡ instalada en el equipo.<br/>Se desinstalan aplicaciones que afectan al rendimiento (Toolbars, etc)<br/>Estuvo a prueba y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1120','','126','2017-07-31','','','','Se realizan testeos de Hardware y no presenta inconvenientes.<br/>Se recomienda actualizar Sistema Operativo a Windows 10','Se instala Windows 10 , Office, Antivirus y programas Adicionales.<br/>El equipo se encontrÃ³ a prueba y funciono correctamente<br/><br/>Costo $1350','','Presupuesto','Reparado con Cargo','(Ninguna)','0','63');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1121','','127','2017-09-18','2017-09-18','2017-09-18','NO INICIA WINDOWS. CHEQUEAR','Se realizan testeos de hardware.<br/>Notamos que el fan del microprocesador cuenta con un soporte daÃ±ado, va a ser necesario su reemplazo.<br/>Notamos que el sistema de refrigeracion se encuentra obstruido por suciedad, recomendamos mantenimiento al mismo.<br/>El sistema operativo no incia.','Se instala fan de microprocesador nuevo, realizamos mantenimiento al sistema de refrigeraciÃ³n.<br/>Instalamos sistema operativo y programas adicionales, por ultimo se migra informaciÃ³n respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1850 ','','Presupuesto','Reparado con Cargo','Entregado','1','64');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1122','','128','2017-10-01','','2017-10-01','DERRAME DE LIQUIDO','EL EQUIPO SUFRIO DERRAME DE LIQUIDO.','SE REALIZA DESARME COMPLETO DEL EQUIPO REMOVIENDO EL AGUA DERRAMADA DERRAMADA EN CADA PIEZA, TECLADO, MOTHERBOARD, MEMORIAS, PARLANTES, ETC.<br/>SE REALIZAN TESTEOS DE HARDWARE PASANDO LAS PRUEBAS SATISFACTORIAMENTE.<br/>ESTUVO A PRUEBA Y FUNCIONA CORRECTAMENTE.<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','64');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1123','','129','2017-10-09','2017-10-09','2017-10-09','Chequear.','El equipo presenta el motherboard daÃ±ado.<br/>Lamentablemente el repuesto esta discontinuado y no se consigue.<br/>Se cotizarÃ¡ equipo nuevo.','Se vende equipo recertificado HP Elite 8200<br/>GarantÃ­a 1 aÃ±o.<br/>Windows 7 Original<br/>Core I3/ RAM 4 GB/250 HDD/DVD RW.<br/>NÂ° de Serie: HP8200I3P0147','','Presupuesto','Reparado con Cargo','Entregado','1','20');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1124','','130','2017-10-20','','','Recalienta','','Se realiza mantenimiento al sistema de refrigeraciÃ³n.<br/>Se mantiene a prueba y funciona correctamente. ','','Cliente abonado','Reparado sin Cargo','(Ninguna)','1','2');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1125','','131','2017-10-25','2017-10-25','2017-10-25','No enciende','El equipo no enciende, posible problema de placa principal o corto en baterÃ­a.<br/>','Desarme de equipo, efectuamos descarga de mainboard obteniendo los resultados esperados.<br/>Testeamos HDD y Memoria Ram sin encontrar inconvenientes.<br/>Se ejecuta herramienta para la correciÃ³n del sistema de archivos CHKDSK.<br/>Chequeamos antivirus. El mismo se encuentra activo y actualizado.<br/>Configuramos anÃ¡lisis programado de Avast Antivirus los dÃ­as Lunes a las 19:00.<br/><br/>Estuvo a prueba y funciona correctamente.<br/>Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','57');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1126','','133','2017-10-31','2017-10-31','2017-10-31','Chequear, estÃ¡ muy lento.','Se realizan testeos de hardware sin presentar inconvenientes.<br/>Notamos que el sistema operativo se encuentra inestable con lentitud de procesamiento. Es conveniente reinstalar el sistema.<br/>Consideramos necesario realizar un mantenimiento al sistema de refrigeraciÃ³n, el cual se encuentra obstruido por suciedad.<br/>','Se realiza instalaciÃ³n del sistema operativo y programas adicionales.<br/>Migramos informaciÃ³n respaldada del usuario.<br/>Efectuamos mantenimiento al sistema de refrigeraciÃ³n.<br/>Configuramos un anÃ¡lisis programado del antivirus todos los Lunes a las 20:00 hs.<br/>Estuvo a prueba y funciona correctamente.<br/>Gtia: 6 meses<br/><br/>Costo: $ 1500','','Presupuesto','Reparado con Cargo','Entregado','1','57');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1127','','134','2017-11-06','2017-11-06','2017-11-06','Chequear','Se realizan testeos de hardware sin detectar inconvenientes.<br/>Notamos que el sistema de refrigeraciÃ³n esta obstruido por suciedad, lo cual puede provocar recalentamiento.<br/>El equipo cuenta con sistema operativo windows xp, aconsejamos ampliar memoria ram e instalar windows 7.','Se realiza mantenimiento al sistema de refrifgeraciÃ³n.<br/>Ampliamos memoria ram a 3 GB e instalamos sistema operativo windows 7 y programas adicionales.<br/>Costo: $ 2000<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','65');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1128','','135','2017-11-06','2017-11-06','2017-11-06','Venta de Notebook','','Se vende equipo Dell Inspiron E6410 Recerfificado.<br/>Intel Core I5 / 4 GB de RAM / HDD 160 GB / DVD-RW<br/>GarantÃ­a 1 aÃ±o.<br/><br/>Costo: U$S 400','','Presupuesto','Reparado con Cargo','Entregado','1','65');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1129','','136','2017-11-08','2017-11-08','','Esta muy lento, chequear.','Se realizan testeos de hardware sin presentar inconvenientes, notamos que el sistema<br/>de refrigeraciÃ³n estÃ¡ obstruido por suciedad, es necesario realizar mantenimiento al<br/>mismo.<br/>Por otra parte detectamos que la memoria ram no es suficiente para correr<br/>la plataforma de Windows 10.<br/>Se evaluarÃ¡ el funcionamiento del sistema operativo con la ampliaciÃ³n de memoria,<br/>en caso de no ser el correcto se reinstalarÃ¡ el sistema y se migrarÃ¡n los datos.<br/>','Se realiza mantenimiento al sistema de refrigeraciÃ³n, ampliamos memoria ram a 6 GB.<br/>Instalamos sistema operativo Windows 10  Office, Antivirus y programas adicionales.<br/>Por Ãºltimo se migra informaciÃ³n respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3950','','Presupuesto','Reparado con Cargo','(Ninguna)','1','66');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1130','','137','2017-11-21','2017-11-21','2017-11-21','Chequear y de las 2 armar una','Se realizan todos los testeos del hardware.<br/>Detectamos el botÃ³n de encendido daÃ±ado. Es necesario realizar mantenimiento al sistema de refrigeraciÃ³n ya que se encuentra obstruido por suciedad.<br/>Recomendamos hacer una instalaciÃ³n limpia del sistema operativo para un correcto funcionamiento.<br/>','Se repara botÃ³n de encendido.<br/>Realizamos mantenimiento al sistema de refrigeraciÃ³n, armamos equipo con 2 discos duros.<br/>Instalamos sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>GarantÃ­a: 6 meses mano de obra.<br/>Costo: $ 1700','','Presupuesto','Reparado con Cargo','Entregado','1','67');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1131','','138','2017-11-23','2017-11-23','2017-11-23','Chequear, no da imagen.','Se realizan testeos de hardware, notamos que la placa de video esta suelta.<br/>Esto es debido a que no tiene el soporte correspondiente para su fijaciÃ³n.<br/>Notamos comportamiento extraÃ±o en el disco duro y consideramos que es necesario realizar un mantenimiento al sistema de refrigeraciÃ³n.','Se instala placa de vÃ­deo con un soporte correspondiente para el modelo.<br/>Realizamos mantenimiento al sistema de refrigeraciÃ³n y reemplazamos el disco duro.<br/>Por Ãºltimo se clona informaciÃ³n.<br/>Efectuamos anÃ¡lisis completos en busca de virus y actualizamos base de datos del programa.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 3500<br/>GarantÃ­a: 6 meses.','','Presupuesto','Reparado con Cargo','Entregado','1','68');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1132','','139','2017-11-23','2017-11-23','2017-11-23','El booteo estÃ¡ seteado en el disco secundario.','La particiÃ³n de booteo estÃ¡ configurada en un disco duro secundario.','Se crea particiÃ³n de booteo en la unidad donde se encuentra alojado el sistema operativo.<br/>Estuvo a prueba y funciona correctamente.','','Cliente abonado','Reparado sin Cargo','Entregado','1','60');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1133','','140','2017-12-19','2017-12-19','2017-12-19','NO DA IMAGEN','Se realizan testeos de hardware y detectamos un falso contacto en la memoria ram.<br/>Consideramos necesario realizar mantenimiento al sistema de refrigeraciÃ³n.<br/>Los puertos usb frontales no funcionan.','Se soluciona falso contacto en mÃ³dulos de memoria ram.<br/>Realizamos mantenimiento al sistema de refrigeraciÃ³n y reparamos puertos usb frontales.<br/>Por ultimo se realiza mantenimiento preventivo al sistema operativo.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1300','','Presupuesto','Reparado con Cargo','Entregado','1','53');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1134','','141','2017-12-27','2017-12-27','2017-12-27','Esta muy lenta, chequear','Se realizan testeos de hardware y no detectamos inconvenientes.<br/>El sistema de refrigeraciÃ³n estÃ¡ bastante obstruido por suciedad, lo cual provoca recalentamiento.<br/>El sistema operativo estÃ¡ inestable, es necesario efectuar la instalaciÃ³n limpia del mismo','Se realiza mantenimiento al sistema de refrigeraciÃ³n, instalamos sistema operativo y programas adicionales,<br/>Por Ãºltimo se migra informaciÃ³n respaldada.<br/><br/>Costo: $ 2950','','Presupuesto','Reparado con Cargo','Entregado','1','69');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1135','','142','2017-12-29','','','Sistema Operativo','Se realiza testeo de Hardware, no se detectan inconvenientes.<br/>El equipo presenta una falla en el Sistema Operativo, el mismo necesita ser reinstalado.','Se realiza backup de la informaciÃ³n,se reinstala Sistema Operativo, y programas adicionales.<br/>Estuvo a prueba y funciona correctamente<br/>Costo $1500  ','','Presupuesto','Reparado con Cargo','(Ninguna)','0','70');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1136','','143','2018-01-09','2018-01-09','2018-01-09','Venta de Equipo','','Se vende equipo HP XW4600 Workstation<br/><br/>CaracterÃ­sticas: Intel Core 2 duo 3.0 GHZ/HDD 500 GB/4 GB de RAM/ DVD-RW/ Geforce GT430 1 GB<br/>GarantÃ­a: 30 dÃ­as<br/><br/>Costo: $3000<br/>Abonado por Mercado Pago.','','Presupuesto','Reparado con Cargo','Entregado','1','71');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1137','','145','2018-01-09','','2018-01-09','Cotizacion','El presupuesto consiste en proveer e instalar el sistema completo de audio y proyector para el salÃ³n multimedia de casa joven.<br/>Se suministrarÃ¡ un proyector View Sonic HD Modelo ... y se instalarÃ¡ una barra de sonido marca ... modelo ....<br/>Queda incluido dentro del trabajo, el cableado necesario, fijaciÃ³n y configuraciÃ³n de cualquiera de los dispositivos.<br/>Una vez finalizado el mismo se capacitarÃ¡ al personal para su uso.','','','Presupuesto','Ingresado','Entregado','0','72');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1138','','146','2018-01-22','2018-01-22','2018-01-22','Falla botÃ³n de encendido, hacer revisiÃ³n general.','Se realizan testeos de memoria y hdd sin presentar inconvenientes.<br/>Detectamos una falla en el botÃ³n de encendido. El sistema de refrigeraciÃ³n se encuentra bastante obstruido por suciedad.','Se reemplaza botÃ³n de encendido, realizamos mantenimiento al sistema de refrigeraciÃ³n.<br/>Verificamos integridad de sistema operativo pasando todas las pruebas.<br/>Ejecutamos anÃ¡lisis profundo del antivirus con resultados satisfactorios.<br/>Configuramos cobian backup quedando programado un backup automatizado diario de la unidad.<br/><br/>Costo: $ 2000 sin imp','','Presupuesto','Reparado con Cargo','Entregado','1','73');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1139','','147','2018-01-30','2018-01-30','2018-01-30','Chequear, problema de booteo','Se realizan testeos de hardware , detectamos que el disco WD de 1 TB da una alerta de fallo. Recomendamos reemplazarlo.<br/>El resto de los discos y memorias han pasado las pruebas satisfactorias.<br/>Notamos el sistema de refrigeraciÃ³n estÃ¡ bastante obstruido por suciedad y un problema de configuraciÃ³n en el booteo. <br/>Recomendamos instalar un antivirus.<br/>','Se realiza mantenimiento al sistema de refrigeraciÃ³n, corregimos configuraciÃ³n de booteo.<br/>Instalamos antivirus Avast Free y efectuamos anÃ¡lisis satisfactorio.<br/>Chequeamos integridad del sistema operativo pasando todas las pruebas.<br/><br/>Costo:  $ 1890 + iva<br/><br/>Nota: Se recomienda hacer backup de informaciÃ³n del disco WD de 1 TB,','','Presupuesto','Reparado con Cargo','Entregado','1','73');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1140','','148','2018-02-05','2018-02-05','2018-02-05','Backup de InformaciÃ³n','Recuperar informaciÃ³n de equipo viejo','Se recupera la informaciÃ³n de equipo viejo, esta se migra a un disco externo de 1 TB.<br/>Costo: $3300','','Presupuesto','Reparado con Cargo','Entregado','1','69');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1141','','149','2018-03-12','','','Chequear','Se realizan diversas pruebas y detectamos que el equipo cuenta con Ac Adapter y disco duro ambos daÃ±ados','Se reemplaza Ac Adapter y disco duro.<br/>Instalamos Sistema Operativo y programas adicionales<br/>Por Ãºltimo se migra la informaciÃ³n<br/>Estuvo a prueba y funciona correctamente Costo: $4500<br/><br/>','','Presupuesto','Reparado con Cargo','(Ninguna)','1','68');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1142','','150','2018-03-21','2018-03-21','2018-03-21','DVR DAÃ‘ADO','El dvr presenta la placa daÃ±ada, se cotizarÃ¡ uno nuevo.','Se vende DVR Linethink 6008T-LM.<br/>Realizamos las configuraciones correspondientes.<br/><br/>Costo: $ 6150 ','','Presupuesto','Reparado con Cargo','Entregado','1','74');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1143','','151','2018-03-22','2018-03-22','2018-03-22','Falla Wifi, chequear.','Se realizan testeos de todo el hardware y detectamos una falla en el adaptador wifi.<br/>Es recomendable actualizar el sistema operativo a Windows 10.','Se actualiza sistema operativo a Windows 10 y se instala adaptador wifi usb.<br/>Mantuvimos a prueba y funciona correctamente.<br/><br/>Costo: $ 3300','','Presupuesto','Reparado con Cargo','Entregado','1','75');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1144','','152','2018-04-11','','','Equipo sufriÃ³ una caÃ­da ','','Se realiza desarme, se re-conecta la baterÃ­a y repara cover extremo de puerto usb.<br/>Se carga el equipo y funciona correctamente<br/><br/>*Va incluido en el costo, asistencia remota para solucionar inconvenientes con ILUSTRATOR y se configura el perfil de Carolina <br/>Costo $ 2800','','Presupuesto','Reparado con Cargo','(Ninguna)','0','61');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1145','','153','2018-06-06','2018-06-06','2018-06-06','Chequear e instalar.','Se realizan testeos de hardware sin presentar inconvenientes.','Instamos sistema operativo original, utilizando licencia del equipo. TambiÃ©n se instalan programas adicionales, Office, Antivirus, etc.<br/>Se realiza mantenimiento preventivo al sistema de refrigeraciÃ³n.<br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','66');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1146','','154','2018-06-06','2018-06-06','2018-06-06','Chequear e instalar.','Se realizan testeos de hardware sin presentar inconvenientes.','Instamos sistema operativo original, utilizando licencia del equipo. TambiÃ©n se instalan programas adicionales, Office, Antivirus, etc.<br/>Se realiza mantenimiento preventivo al sistema de refrigeraciÃ³n.','','Presupuesto','Reparado con Cargo','Enviado','1','66');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1147','','155','2018-06-06','2018-06-06','2018-06-06','Constancia de Servicio','Problemas de cobertura Wifi en apartamento.','Se instala Router TP-LINK WR941 HP 450 Mbps.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: U$S 130','','Presupuesto','Reparado con Cargo','Entregado','1','75');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1148','','156','2018-06-06','2018-06-06','2018-06-06','InstalaciÃ³n de CÃ¡maras de Vigilancia ','InstalaciÃ³n de cÃ¡maras','Se instalan 4 cÃ¡maras de vigilancia. (3 de Ã©stas las provee el cliente)<br/><br/>DVR TVT 4 Canales/ 1 MicrÃ³fono/ HDD 1 TB. / 1 CÃ¡mara Qihan 720 P.<br/>GarantÃ­a 1 aÃ±o.<br/><br/>Costo: U$S 430 <br/><br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','76');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1149','','157','2018-06-07','2018-06-07','2018-06-07','Chequear','Se realizan testeos.<br/>El equipo presenta el disco duro daÃ±ado.<br/>Notamos que cuenta con poca memoria ram para un Ã³ptimo funcionamiento del sistema operativo.<br/>VersiÃ³n de BIOS desactualizada.<br/>','Se instala Disco Duro Wenstern Digital de 500 GB,  Actualizamos BIOS y ampliamos memoria ram a 4GB.<br/>Instalamos sistema operativo Windows 7 Profesional y programas adicionales.<br/>Por Ãºltimo se migra informaciÃ³n respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo:  $ 4900','','Presupuesto','Reparado con Cargo','Entregado','1','77');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1150','','158','2018-12-13','2018-12-13','2018-12-13','Bisagra y plÃ¡sticos daÃ±ados.','El equipo presenta la bisagra partida y plÃ¡sticos del cover daÃ±ados.','Se repara bisagra y plÃ¡sticos del cover.<br/>GarantÃ­a 6 meses.<br/><br/>Costo: $ 1800','','Presupuesto','Reparado con Cargo','Entregado','1','44');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1151','','159','2018-12-14','2018-12-14','2018-12-14','Chequear, posible falla de disco duro.','El equipo presenta el disco duro daÃ±ado.<br/>Se cotizarÃ¡ disco ssd mas instalaciÃ³n del sistema y programas.<br/><br/>','Se instala sistema operativo y programas adicionales en disco nuevo ssd.<br/><br/>Costo: $ 3800<br/><br/><br/>GarantÃ­a: 1 aÃ±o repuestos 6 meses mano de obra.<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','59');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1152','','160','2018-12-14','2018-12-14','2018-12-14','Chequear','Se realizan testeos de hardware y no se encuentran inconvenientes.<br/>Notamos que el disco duro se exige al 100% constantemente.<br/>Esto es debido a una falla en el sistema operativo.<br/>Es necesario reinstalar el sistema.','Se instala sistema operativo y programas adicionales.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 1350<br/><br/> ','','Presupuesto','Reparado con Cargo','Entregado','1','78');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1153','','161','2018-12-14','2018-12-14','2018-12-14','Venta de equipo','','Venta de Notebook Dell<br/>Caracteristicas: I5/ 250 HDD / Windows 7 PRO/ 4GB<br/><br/>Costo: U$S 360<br/><br/>GarantÃ­a: 1 aÃ±o.<br/>Entregada el 29/11/18','','Presupuesto','Reparado con Cargo','Entregado','1','79');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1154','','162','2018-12-14','2018-12-14','2018-12-14','Atasco','La impresora presenta un atasco y requiere mantenimiento.','Se retira atasco y se realiza mantenimiento general.<br/><br/>Costo: $ 1000','','Presupuesto','Reparado con Cargo','Entregado','1','80');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1155','','163','2018-12-14','','','Esta daÃ±ado.','El disco duro estÃ¡ daÃ±ado mecÃ¡nicamente.<br/>Se intenta con varios softwares de recuperaciÃ³n pero sin Ã©xito.<br/>Lamentablemente no es posible recuperar la informaciÃ³n.<br/>','Sin costo.','','Presupuesto','Reparado con Cargo','(Ninguna)','0','80');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1156','','164','2018-12-14','2018-12-14','2018-12-14','Chequear.','Se realizan testeos de hardware.<br/>Identificamos que el disco duro se encuentra daÃ±ado.<br/>Cotizaremos el reemplazo del mismo.<br/>Por otra parte notamos que un plÃ¡stico soporte de la bisagra se encuentra daÃ±ado.<br/>','Se instala disco duro ssd nuevo. Instalamos sistema operativo y programas adicionales.<br/>Reparamos plÃ¡stico de bisagra.<br/><br/>Lamentablemente no se puede migrar la informaciÃ³n del disco duro viejo ya que tiene un fallo mecÃ¡nico.<br/><br/>Costo: $ 5600<br/><br/>GarantÃ­a: 6 meses mano de obra<br/>                1 aÃ±o disco ssd.','','Presupuesto','Reparado con Cargo','Entregado','1','81');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1157','','165','2018-12-15','2018-12-15','2018-12-15','Instalar','Instalar lo solicitado por el cliente','Se pasa sistema operativo Windows 10 a espaÃ±ol.<br/>Instalamos programas adicionales, office, antivirus, etc.<br/>Queda configurado como acceso directo en el escritorio la enciclopedia de wikipedia y video de santa.<br/><br/>Juegos instalados: <br/><br/>Minecraft - NFS U2 - SIMS 4 - ASPHALT 8 - PES 2013<br/><br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2000<br/><br/><br/>','','Presupuesto','Reparado con Cargo','Entregado','1','49');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1158','','166','2018-12-30','2018-12-30','2018-12-30','No funciona la pantalla','El equipo no da imagen por la pantalla.<br/><br/>','Se reconecta cable en ambos extremos , pantalla y motherboard.<br/>Estuvo a prueba y funciona correctamente.<br/><br/><br/>GarantÃ­a: 6 meses. <br/>Costo: $ 1500','','Presupuesto','Reparado con Cargo','Entregado','1','82');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1159','','167','2019-01-18','2019-01-18','2019-01-18','INSTALACION','','SE INSTALAN 4 CÃMARAS LINETHINK FULL HD Y DVR TVT 4 CH FULL. CADA CAMARA LLEVA SU RESPECTIVA CAJA DE REGISTRO PARA LOS TERMINALES.<br/>DISCO DURO DE 500 GB PARA GRABACIONES.<br/>CABLEADO EN COAXIL BLANCO.<br/>GARANTÃA: 1 AÃ‘O.<br/><br/>COSTO: 18600','','Presupuesto','Reparado con Cargo','Entregado','1','83');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1160','','168','2019-01-19','2019-01-19','2019-01-19','Chequear','Se realizan testeos de hardware y no se encuentra inconvenientes.<br/>Notamos que el sistema de refrigeraciÃ³n requiere de mantenimiento.<br/>El sistema operativo estÃ¡ corrupto, es necesario reinstalar.','Se efectÃºa mantenimiento al sistema de refrigeraciÃ³n. <br/>Instalamos sistema operativo y programas adicionales, por Ãºltimo se migra informaciÃ³n respaldada.<br/>Estuvo a prueba y funciona correctamente.<br/>Costo: $ 2000<br/>GarantÃ­a 6 meses.','','Presupuesto','Reparado con Cargo','Entregado','1','84');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1161','','169','2019-01-27','2019-01-27','2019-01-27','Chequear.','Se realizan testeos de hardware.<br/>Detectamos que la pila CMOS se encuentra totalmente descargada lo cual provoca que se desconfigure la fecha y hora del equipo.<br/>Consideramos necesario instalar un disco duro sÃ³lido para mejorar el rendimiento de la computadora. ','Se instala disco duro sÃ³lido y se clona informaciÃ³n del usuario.<br/>Efectuamos mantenimiento  al sistema operativo.<br/>Reemplazamos pila CMOS.<br/>Estuvo a prueba y funciona correctamente.<br/><br/>Costo: $ 2400 + iva<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','73');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1162','','170','2019-02-13','','2019-02-13','2 cÃ¡maras daÃ±adas, reemplazar.
Mantenimiento.','Se identificaron 2 cÃ¡maras del sistema daÃ±adas.<br/>CotizaciÃ³n por reemplazo de las mismas y mantenimiento general.','Se instalan 2 cÃ¡maras hd nuevas.<br/>VerificaciÃ³n de conectores bnc y conectores de corriente en caja estanco. (Los que estaban en mal estado fueron reemplazados)<br/>Fueron selladas todas las cajas estanco con silicona para evitar filtraciones de agua.<br/>Costo:  100 USD <br/>GarantÃ­a: 1 aÃ±o.','','Presupuesto','Reparado con Cargo','Entregado','1','21');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1163','','171','2019-02-13','2019-02-13','2019-02-13','Visita tÃ©cnica','','- Equipo de MarÃ­a - PC<br/>Se provee e instala cable usb y cable de corriente para impresora.<br/>ConfiguraciÃ³n de  impresora y actualizaciÃ³n de antivirus<br/><br/>- Equipo de MarÃ­a: Notebook<br/>Se activa office y configura impresora.<br/><br/>- Primer consultorio frente<br/>Sistema operativo XP Obsoleto, sin soporte (Aconsejamos instalar windows 7)<br/>Se configura fecha y hora.<br/><br/>- Segundo consultorio izquierda:<br/>El antivirus estÃ¡ desactualizado, se actualiza el mismo. ActivaciÃ³n de windows.<br/>ConfiguraciÃ³n de opciones grÃ¡ficas para mejor rendimiento.<br/>Se testea disco duro y pasa las pruebas satisfactorias.<br/><br/>- Tercer consultorio izquierda:<br/>El antivirus se encuentra desactualizado, se actualiza.<br/>Disco duro pasa las pruebas satisfactorias.<br/>ConfiguraciÃ³n de opciones grÃ¡ficas para mejor rendimiento.<br/><br/>- Consultorio Fondo Arriba:<br/>InstalaciÃ³n de antivirus<br/>Chequeo de disco OK<br/>ConfiguraciÃ³n de opciones grÃ¡ficas para mejor rendimiento.<br/><br/>- Consultorio derecha fondo:<br/>ActivaciÃ³n de Windows<br/>Se ajusta cable de monitor porque se ve opaco (la falla estÃ¡ en el cable y este no se cambia <br/>porque es un monitor CRT)<br/>ActualizaciÃ³n de antivirus<br/>Disco duro verificado OK<br/>Se verifica impresora, hay que cambiarle el tÃ³ner.<br/><br/>- Consultorio fondo izquierda.<br/>ActivaciÃ³n de Windows<br/>VerificaciÃ³n de disco duro OK<br/>Se instala Antivirus<br/>ConfiguraciÃ³n de opciones grÃ¡ficas para mejor rendimiento.<br/><br/>- Computadora de Elizabeth<br/>ActualizaciÃ³n de antivirus<br/>ActivaciÃ³n de Windows OK<br/><br/>- Computadora de recepciÃ³n:<br/>InstalaciÃ³n de antivirus Avast<br/>VerificaciÃ³n de disco duro OK<br/>Configurada comprobaciÃ³n del sistema para prÃ³ximo arranque.<br/><br/>Costo : $ 2500 <br/>','','Presupuesto','Reparado con Cargo','Entregado','1','85');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1164','','172','2019-02-13','2019-02-13','2019-02-13','Visita tÃ©cnica - InstalaciÃ³n.','','Se instala dvr de 4 canales Hikvision y 4 cÃ¡maras domo exteriores full hd Hikvision.<br/>El sistema cuenta con un disco duro western digital purple de 1 tb para las grabaciones.<br/>Cableado efectuado en cable coaxial rg59 + corriente.<br/><br/>Costo: $ 16500 <br/>GarantÃ­a 1 aÃ±o todo el sistema , salvo el DVR que cuenta con 2 aÃ±os de garantÃ­a.<br/><br/>NOTA: <br/>AplicaciÃ³n para el celular: IVMS 4500<br/>Usuario de Hik Connect:  CDominguez1234<br/>ContraseÃ±a: Camaras1234<br/><br/>Usuario DVR: admin<br/>ContraseÃ±a: Camaras1234<br/>','','Presupuesto','Reparado con Cargo','Entregado','1','86');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1165','','173','2019-04-06','','2019-04-06','Venta de Monitor','','Se vende monitor LCD AOC 19\"<br/>GarantÃ­a: 3 meses<br/><br/>Costo: USD 50','','Presupuesto','Reparado con Cargo','Entregado','0','14');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1166','','174','2008-03-11','','2008-03-11','El dvr no enciende','Se realizan pruebas y el dvr presenta la placa principal daÃ±ada.<br/>Cotizaremos el reemplazo del mismo.','Se instala DVR nuevo Hikvision de 8 canales.<br/>GarantÃ­a del dispositivo: 2 aÃ±os.<br/><br/>Costo: U$S 175 + iva.','','Presupuesto','Reparado con Cargo','Entregado','1','87');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1167','','175','2019-11-05','','2019-11-05','No enciende','Se realizan pruebas y el DVR presenta la placa principal daÃ±ada. Lamentablemente no es posible su reparaciÃ³n ya que no se encuentran partes disponibles para su reemplazo.<br/>Cotizaremos el reemplazo del mismo.<br/>','Se vende y configura DVR Hikvision de 8 canales.<br/>GarantÃ­a del dispositivo: 2 aÃ±os.<br/><br/>Costo: U$S 175 + iva','','Presupuesto','Reparado con Cargo','Entregado','1','87');



-- -------------------------------------------
-- TABLE DATA usuarios
-- -------------------------------------------
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('1','','admin','d033e22ae348aeb5660fc2140aec35850c4da997','1234','Super','Admin','','','','‰PNG

\0\0\0IHDR\0\0ä\0\0i\0\0\0M€[ÿ\0\0\0	pHYs\0\0\0\0\0šœ\0\0\0 cHRM\0\0z%\0\0€ƒ\0\0ùÿ\0\0€è\0\0R\0X\0\0:—\0\0o×Z\0ßMIDATxÚìw˜õöÆ?SÒ³½±°T±`¡‰)\"
b¹êEÁÞËÅúS¯ˆ]¯{G°\"`GAEÅë‚ˆHÝ…ei[Ò“I¦üþ˜™eE½jÎóì,™d2™|ßï9ç=ï+†A6²‘ld#ÙøcCÌ^‚ld#ÙÈF6²€œld#ÙÈF6²€œld#ÙÈF³‘ld#ÙÈF³‘ld#ÙÈr6²‘ld#ÙÈÙþ‹ Ù«‘lü=â< Ð\0€‡5{iþ\\‘[ýk…` Y@ÎF6þòQ<máÿ¾F\0Ë²—)ÈÙøƒ3ä_Ã/¹2{³‘ÿÁÐT•x$D<\"©$øfÎ»¯½ËJs¹sìIì±GgÃ<>yŸ|ÕøèúìÓWW×nfÝÆZB‘hvÑÏF6~§Èö³‘¿hèšF2\'ðÍœw¯zúø¿1C~TWú÷Ý—ŽíÏÜ_äì3Oð\0ãórrÈÏÍÁãre/b6²‘äld#¿6]GIÄˆ…ƒ`öŒiU–ÏŠ•›¸ñ¶iˆ¹ÿ`ÐQÿ\"1þþ›íÃúù½òü~¼7’”]\"²‘, g#Ùøu€lè¨É$J, Ë\"+Woáù—\00oA%3fÎ!??îÝöÈvxŸî¹~¹~.‡#Ë/ÉF6²€œldã×ƒ²®i;þ¯Ç™þWÿ~û:UÕ5ö¯ªs|^ŠòòÈñùpÈr”³‘ß!äì%øßAQEÑ\\\0ÐuÝü1Œ,Á&»rS!ÉDIs´©ÿæ­Aòó<ôìÖ–­ÛÂœ1òP:´ªªu!ûÈA~¯wjIa%…$S)ÂÑª¦eï¿ld#›!ÿõÁXEœN9>/…y¹”Òª¤˜ÒÂ
rsðz<8dy;Xg#?õå%œn7nŸà ¾yKˆšÚFdY¢uy>Íûžo¾þŒöNÆßÿoûÐGïÕ£¢¸ Ÿ6¥%åçáv¹!{ïe#Ùù¯†a˜°•qèVf,I>›Ÿ/Ír%#B‘(ÑX%•Ê^Àß :!Iæõ—DAMÓÑtMÓÐt}ûg÷g\0dIÂåõáË/¤Ý¾¬^¿üÛ3€7W¯ÝFÕúzü>7n·Ì-÷¼Í[“+ó¯™ÿÉWÌ˜ùA9ðLŽ×;¬ui1±„B\"™DÓ4Éd6KÎF6²€üd]GSUtME·ú·Ÿz®p<&#¶
³ÌøÂSÞT½n7²$cš®“R³¢J»cSdg|’$ârºðº]xÜn“Ì$
¨ªJ,¡K$H(IR©úŸ”EQÄévãËËÇÐ5ÚïÛujõò¥\'cTUïÆ ß,ÝÈ˜Þä¡ÿä1ñ™qT.YNUuÍÐ>=»MžûÅâQeIŠB*¥¢…t’©T”³‘ßâ;›½«©ÉDœD4ÂG/=WñÑKÏÍ¾núgÏK/yòþeÅ…”æ“ë÷gI6»é3Ð55•\"•L’H($S)AÀãr’Ÿ›Cyq­ÊhSZBIA>9>/‡ãÏ”ú#;]xü9ä“_ÖŠŽô˜ZÔº¢P¨©mäãù+yø‰iäùê˜þÆ£äççŒxH¯óJ
¨hUJia>Y’²÷_6²‘Íÿ*™™NJI›
JÀ“Àp¿ÏÍÙgæÄ“†RUUÏ‹/¿Ã¼ù‹º\0_žwÒñ]Ÿ}cúêxB!W”ì…ü™±¦©h©”Y¥Ð5æMy¡p…UhT[Š‡Ÿ}cúb—Ë‰(Šhš†ª©¨ªö\'ÀcI’pz<ˆ¢„äpàpºÌME#0·¾¶æàþ«·ðÚ´Jºìõ6CŽÁøûnàœn\0xôÈÃ™ÿöüOWÇ­ÒµªiÄâ	4]ÏfÊÙÈF6Cþs‡®ë$ã1¢¡\0ÿýàíó€á.§ƒÛÆÅõ×Î€~=9û¬2÷£79û¬SÀRPÊñùÈñùpþ™²´ÿÑì8¥($¢báÆ_§[`ŒõçéÀWüó½ZRRX@®ß,ýyö±‚(\"Éœ¾Ü<òJË(m×²@(j]ñ\00EUu–}_ËÝãç°yÃ\\Î:­¦z×‹y9>Z—–Ðº´„‚Ü\\\\Îì|r6²‘ä¿ k:J<N,¸]A©c‡2Ö¬ÝÄÓÏÌ °ìHÎ=ÿ@`ü·Û‡õ;uØÙåtàpÈˆÙÅðW\\d<F,dÑÌ7m0æ¤ãz°vÉmèáÙ¬ýþÆŒ>Ó>ä«³ÿql¯¢¼<òüæ\\îŸ)A@”$d§·×GNaE­+(kßÑ~È…Àç‘h’V×qÑ•Ó0â_1þÞËéÞ­@ï¾=»O.ÌË¡Mi	­Š‹Èõûqf[\'ÙÈFÿôš¡£&±(˜x¸Ý.Ö¬ÝÄí÷¼J aÒ‹3˜ôÂòósÐ¿7@žÞ¿Õ\"(XsÐ²$áåô,I©q+MSID£D\0ã\0öÝ»œÁö\'/7Ÿù¾¥C‡Œ¿,c.?×>ì
¿×ƒÏëÁ!KÚ÷.ˆ\"²Ã‰ÇŸK~i+
ËÛPÔº\"br|ó–«ÖÔsÓíÓÉsodâ3·¥ûÉý:ðê’ÂÚ–—QVTˆßëÍö“³‘, ÿéÙìcî0¾”H$),ÈIÿ»Cû¶€JUÕûWUJ2…®éi\0µDQDÊvqfTdIÂít’ãóR—KIaÅùäçæà÷zp9ÖHÐŸ{Ö5ÅÊíMNaŸo¾]ÏaCîdà°èyÈ(ÀàŠíYr?\0§Ã$Iê÷/ˆ\"²Ó‰7\'‚²rü…µ®XŒX½®Žç­æ7ß¢[Ÿ¹Í>ôþÁ½îUVXHE«RŠóM½ëìl|6²±[\"KêúCVDQJ—û\0ýëêƒäçû<¨\';–qè!½pxOæÎûÄ–4\\øÐ‹SÖ5†Âé‘\'I‘%;“•UÓH¥T“|¤™Ä›–È7éYh4AÀ%
¸].r|^¼n7YN“x\"±ÑD%™DÓt`÷zìS400tS¥Ì>ïÝI2t-•$™ˆÛ•dY`É·ëùaÕ€Ï+—®ê=ï“Ïpxoû°öª¦¡ë:è%	‡Û/¿€Âd’‰8E­+&Ô×Ö¡ªúÈ«¶òè³ŸÓ}ÿRN8æDÆŒ>“‡}à‘¡‡6â­ç×Ä
	%‰ªj$-KðÊF6²€ü§[-%‡ÛðpSÍÆ:ü>7\07ß8Šýö?˜o–,ãª«Ó=äyáhŒP$B\\I¢2\"N‡ŒßëÅçq§Õ”RªJ$\'K$H&[ž5tMÕÐuA™ùø¾@G XðØä×ë”dŠX<N4–0ŸSM±;Ö_;±²3,Ã0Ðuƒd*E2•\"¥ª¤TMÛýŒ^Kã¹hŸH$qÈmÊóÙ¸)Ð»{×Îè×ªª5öÃ«cqk3bÍÿ@ÙåñSXLJQØ´vE­+FÕ×ÖtˆD“½W¬ÚÆ¥×ÎæÃ©¥ŒÿÏ¥Ìûä+*—|ßx2?\'çØÖ¥%Äs\\LÓuôßI4Ä¾W2¥fí{Ç¼L™ÙÝ½‘ËF6²€üWdIÂåñâñçPÔºbq}mÍùÀs+VÖàv»¬‘‘žýÃ>äóñ/L»µ¡‘ú@P$‚šTHYÑäûîè\0U¾üÚ:Ý0Gc4†B4C„ŒJ2Ù,KTS)RŠ‚šJ²àWüÀ3ÀÈNwÓe£FL}êµ©£%QÄ!Ë8ä_Lér»$âdk57Ñx‚p4J$\'nÍ	ïŽÖrfj<·¯©Ò¹S	ýzwfäÉ½8ö¸0ô?ú‚}Ø‚`Ä<—?ÃÈÓÏ½ö’ìÀíó‘W\\BJIPW³`ðe]C¼¼º¦‘Ëo˜ÉÃ÷óñ{OÒiŸc	ÃÃûÔóö}5VI&MÁÕ¸I©êï‚²$át8p»œ¸œNdI2«CªŠ’L‘P’$ÕÔo²‘ËF6²€ü
Apº=xüf¿Ø*ž)b–ƒ…í}Ê‰ÓfŽÅˆÆãl«o@‰EI%¼ñÊ£V6ÛÝ~ìèÓOY<4aêÌ©N‡YW5UUQ3\\tM3…I\"RæLóëÀÐ¿‡“þÑ—öíÛ²défÌœ_\\vñ)\'ÏþN—¨jÂÔ·Ö)É$p„úÆ õ áXl·€²(K¸¼^\\/ÀÃÀé5µ\0¨ªÆ>{–†¸íî	<ôØöa‡£QBÑ(I5õº-’WŽIòJÆã\05õµ5£7W¯°hq&Íâüó
™öúC:ê<€›zÐü÷~>\'¡XJ^ªJ$ûM@°‰Ô¬UUq:dœSÿÝïõât˜í•H,N(%O(YSŒld9?–™ˆÈ.\'.¯‡Ëe¢½ôH4ÍfI	†#DëQâq¾|{úd;›í~@kòór©Zß@Õú­}¾çtÜÉ“fÌžªë:±x‚h<Ñ5MC‰™³ÐßÎÿèv`h^žûï>SNHNn>¾YºžACÎ&l!{þÍâ¼“Ž¸ð•ÙïÕø<dY‚:v(‹’„ÛçÇ““kW(¾ª©m¤¸Ð‹$Aå’µ™`|Ðý_^¼¥®žè_(CÎ¼—)±YXÞÚî\'O­¯­y¸lÙŠm¼ðÚRºð;•[nº„[îxà‘£ûö2sî\'5qEAI¦Ð,¾Áî”µ-$uM5ÿÔuDQdÖÆ$Ûu³*óŸ}cÆâh<ŽÇåBEbñøNûÛiRdši¿&ÙÒw6²€ü÷\0dI’q8]ÈÎÙàL¼Ó2‰¯	7ÔSùñû·#=nÝsçŒ:í@nÍÃO¾Ç•×=ðÒÙ\'_òôëÓV7†ÂÔ‚d¾Š®©$¢¢\0À\0€}ö¬ ®.Ì„ßã­YŸsÅe§rÂñÇ0ñ¹;xø‘—ÙNâ2ØÝ„.3í@¨ªª¥ªzãPàõÓ†=bÚ‡sk²Œ€°[@Y”$\\n/žœ\\»B±¸¾¶f¾]¡0³°ôõŸ?aêÌÅÁp%•\"–Pþ2=ä¯‰ÓãÁ_PDÑö~òèúÚš=Š:ô»ê¸ö–ùxj	ã®?•yŸ,fÞ\'_už)ÈÉ–,+!¡(()SÉKI¦v# ë¨©$)%šL±pêä
ÌöÊÐŒ‡pÁ?O˜\\òøä7j\0Rjj§}ÛeÍaeÚ.§‡$YæÉT
%ir²Yv6²€üWeQD”e$¹¹êVn®)Í)nlHèaµ>šÿ¿þ†³Ï8™1£ÏfÉ·k™ôÒp–×íëu»‘¤¦nº¦‘J$HDÂ`–½q{œÌ_¸„÷>ø/\0ó>YÊÚ{rüð>?¼ ™,,CÅ0’€ž¦™ÀÚÒÂe´\0ÀFÆ„ ¸@p©|•K¾ë¼~â‘GÌüø“šô¡¿”·W(¼-T(@×Õ&ïÉ!KH’„ªj¤þ¢Æ
ö&Ñíó‘[\\BRI°m}˜óÉ‚‰.Õ‚œ7æ]ž¬„é¯ÝMCÏ¢ªzãÐ~½z<úñ‹G+­¬ÞmJE×#»­çŸn¯D#|1kš³½Ò»uy!œ{Ý»Àüß2é¥·BÃ©¸ ˜¦ëD­òu2cÄÐÐõôdaÈ’„Ëá Çë5ÇûœNâq…`4B$#¶9ÙÈFÿGÁ–æ7ÝnG“YDtCG‰ÅXóÍW¾n—ŒªéÌùd-S¦}À“?cíïqÖÇ2é¥Xå<$KØcÇÐ,s…Ì¨«7ù÷–Í()’P’)DÑœU†bÔÕÑu·Û‰ÏëÂçsãv9,–w4š M‹+$“*ºn ŠN§ŒÇíÂïwãt:Ì‘™DY–hÓºÄ<òr™;ç5>%ÊÇ:|·òö
…‡ËÝss\\l¬ßþÕp9H’ùè;!û«l%‡?‡ü’2R‰t?ùràÃª!*—mãGgsõ˜b¦¿v=pÙ CzÍûàÓESŠ¥wm‘¼~mfišª¢D£ÄÃa0uß{·./â©G/ç˜¡#H…ÂqŒ»ù:z4ŒªªCOzäÕ/Ì˜ý@Žß‹œñYn/}ë)qö“ã3\'\0<ûÆô9q%‰\'ä¢^–Pš´–ldùoæ(šJBZÙËüèV¯mH?®jý3{Õ·÷ “)Mo¾(ÚÆÖ†`!Ð7Œ’—çcNåÄb
öèLåÒµ¼óþ—,úr%š¦™#IIEI\"‚	È>7~¿¯Ç…h•û¢1…h4A<®H˜%CY–ðxœéÇ#@\"‘\"WÐuƒAýàÚ«þI^næÎyÝåe»”EQ’ZÁ,Ì÷Ž¦²(¥â¯¢hJlúòòQS­I&\0sêkkî\0nZöCSgtßï-Ž8ú,ÆßwW^{/ÀKCúºäíùWÇÅb^kÄâñ_ÜO6ÃœH&ID#v5§ÀI\'†Ë%qõÿ=Í¼ßsÅès8û¬Óÿ8þqòù\0œÇn§É‹²,OSJ5•DK¥øtúkçajv§ã‚þã]àÂ§_ŸV#
\"š¦£$³¥ëldù6»ý±…äW=7Be_Á\\X\0Á@0‘§ª:.§È>Ù¼-Æƒÿ¹ŒÕÕÕiŒŽÅã(J]oú|¶0„5=è»zí&ºwíDÛ6Å\0x½N½’7§/$Šý.×õ“…ßòõ7«¹ñºØ«/sç¼ÊÀÁ§þ6 ,X}ë¦RdyÇë¿ìóGÜg¢µy’%Éj=˜\'£ëª¦£iZºGº[ÆÂ$	‡Ûƒ¿ ”¢Ø$¯±õµ5{¨ª>rÙî|h1v-âŠ‹OeÉÒLzi¦x1×ï?¬uI1¦3”‚ª©$”ä®ƒ±nf°šª’ŒÇPâqRI,ó’’|Ö¬­å¡Çf\0pÎù×3 ÿ!èýýTM3Ex{NY\'•4ME’‰‹ß›™&FžyêAtl_¢—&Ï£ªzóPàË‹FœxðÓ¯M«I(Š¥uYËFÿg@Ø&‚È²”ÖxN—Ö4”ª™™ä¯)mÍU°DQÀárSÒ¶½ºmCõ`øšªFöî\\È‡·ç‘»ŽFðH a·Þ9Ñ>lA8#£jj³E×íõáËË§¬C§±[ªÖ‰Ä{/úr­Ê
e‰ÚMõToØ†¢¤\0ÞÅ2aØ!Yå¾Ìøøpgë=pÐ{‡ßÏÂªªœõÎ—l¨©ãŠmà´Q\'1wÎË|úoÊ-ÇOÚ2#½é“$	·Ë™q:i˜XB!§gwÇû·«\'.Ü\"s>yKÕZ0ûÉ\"ÑTïÕUA.¸f>¯O(cü=R¹d%•KWôîw`÷És¿X<ª¼D!›ãP»ÂL7tÝ,w[D.%ãûÏ?é¼hV‡´i]D‡öÅécòósÈÏ•	4n¶ˆ%¤Rjz^^×t’ñ8ñpˆo>zo00Òívp×MC¸èÌžxü —sÅåçqîEw3cæÇåÀ“¹~ß±y9~\\õfK&›!gã7«Pe/ÁÏ,Y? Ë^·›üœÊŠ
©(+¥MY)eÅEäæàõxv«è¾€¥3íóãòú\0®â›·FYòÝVª7…ªõutÚÿ³tï>0é•	‘xœH,Ž¦i;\0²ŒËç#§ ˆ¼âR0Å f«ªFÍÆ:ªª·°ru­ÆS€{<®bï}Ç•´m?x¸è[T˜ËEçå–ŸE÷nû`íÍÀ‚A§3nÿ~ƒÆµÙ«Ë8ë~»	è½G§rÆýûtÎ>cùy~€á˜åø)ªªQ¹t-?>‹ñ?Ož?ÂÜ9/Ó½Ûþös¿~Ü Ã+*ÊJi×º­Š‹ÈñzÓlô_ÿÿ±€lè:ºÕßO%“$,µ5AñºÝæåR^RLE«2ÊKŠ)ÎÏ7ßÿnt_2ç“¸ý~òKZQÐªµmBq9@Í¦(?¬ªãž‡æç®fâÓ7’Ÿ—0rà!½Î+ÌË¥¤¨€\\¿ïgÛUš*[š¦Z@%	³øýYçKÞå­
ù¿«Ofï=Ëé{è¾LŸrc.û¿sù¾83fÌNoFƒá(ñD‚”ªYåêJ,BÜ,}÷èÕ­5å¥>>ýbƒŽÏU7<OA^.Ÿ¹%i<æ(Ùåtb2ý³‘l†üÇ‚±µcÇ0PP5§ìàÉq×\0ù÷=ÿÒ:§Ã’LGh…	FbÖìï®í¨[Iñùý¶º×êúÚšƒoA…H4	‚HÕú:Á(À|àBH(Š9‡©é;dÜ\"N·o^\0ûÒ§&»~ù·½0ûtù@\0Xpè±\'-%33³<ú$àé¼Gkî¹ýLN<®HeŒw·Þñ·Ü6à‘_™Øõˆ3ÎW—-øx°Æœvê\\{ÕºvÝÄ|ÆS<Ê–e\\còÈÊ¥kS¬ãÚ«Ïo1S~ëãù5º¡£éšIºÚD¢?Œ55…šJ¡k*š¦1ÿÕOÎ¶>—< ˆÙº¸òé×§­vgÎTMk2oþkAÙátáÍÍ£ U¹­ý½¸¾¶æàþk#L§ŠÁ}Þæ ~ç1þÞ«8ç¢[vxŸ/&Ï~oY®ßÇ¶Æ\0‰Ÿ(õf–¨SŠB2GIÄøê·.8ä ½¹ì¢¡tÞ£^¯‹+«i×¶ÓG‚CJòÎ{sëÏÛO9£1\"5+\'š¦’L˜Ù¶ÕïÐ¾\"ŸW`ÄùÓ	ãÌ[¸‚ntæ¬Óg@¿îÌ[P™ôanÖ@#Y@þÃH5™BUÍrÞ”üõÃêg]{îy/Í|g¬×ã¶æˆM Ù]‹£(JäY€PÔºbY}mMŽ7-I¿4óšú@dÊ”Ôw$uYËëK»ÿ¸ý9ä•,K²ŒÓíÁíóát{DA‰…‚l\\µ¢Ð×ív²_—¶lÛÚÈmw½BUMŒñ÷cÜØk˜7óæÞàÏÍ›cg$Ú—QPàgé·k¹åö9¼_®ó/¦OHÇÎ‡ôë:àÈKç}H&(\\sÕÌóŠÞ&ûúøAýGLýàãEIW’(Éä¯¾æ‚ñÇ	èºNRQHÆb¨©$‹fM=	xs‡‡åY…#.qâÁÏO›¹ÌÀ ¡$›	ÀüêûN’p¸\\øóQËÓýäêkkTU}äŠ5n¿”Ù~ÎÙ§Çü…ßØýä\'½O?ÿÏ°«´7¼Z*ERIŒÇølÆëMf/>(§ÚŸv%$”Ÿ~þwÜó&^¯€x<Éšu[ì§œrá¸»¦Âa¢±8ñxÜã()%ÁÚ%_?jßùùn:´õ“Ù\"2´h[	˜3ú\0ÉÔî‘ŠÍF6²€ü+²5¥¢Äc¤	>{ëõ
¬H€ü<?ùù¹TU×öúžqÜ°#€O¾:µFUMÅ¢_æ‚£5Ë”%QÀëqã4åw<S£é1ÙT÷Ò¬Œ©¥ŒQ”dNsÈérãÉÉESUC7õžeÙáDr8Ò#\"ª©‰Ý ¸(—`0ÊÔ·1gî\0Á8Óß|žý{3oþç`’kæØÇäçù©©©câ‹&˜1ëS

J8û¬Qtï¶/•K–·_:ïÃîm÷ÙoÔ†ß5e—Kfô¿ÎÍ z™ |ÒA#^šùNM(%‰P’Zç!]ÓHÆbDCA¾™óNŒGŸ×“[oJ~Ñ\"~®ºñE&½4Û|pî‰Çu}æõéu¶~ùŽºå¿”­ÍYNa1ÉD‚ÍëVg˜P¨½ÿûm=ó|Í€£áù§n`ÒK3úJ¢˜Ö™ÞYõ	Ã@ÓTÔd’dÂckò(P^\\œÇ­7â¨#ºSÑ¦˜h,Ê“çrïo‰&v|ÊÏNºâÿÆFãqÃ ‰šíh„E³¦6ù†îÉÐíhÛÊÅÇSOã¶ûçÑmÿrÎ>©”ª5•T~[P}ÿÄ—+£±8É”J¶{œ, ÿåj5©„HD£X_æÞí*ŠyåùËéÓç ™¿p%W^s7•K–÷ž,ÌË=6–HPŒˆ»®ìdè4³RÌ‘!ÙéD’h™zÊ‚£ÉÇétÈH–àþOe@‚(\"É²É¸6ÃraQDK¥Ò†;nÖ×lmr.)kSa†‹69\"ŒìÀú6\0üü\\ûeí;GÕ×Öd€²N›òN<éæÎyƒƒÿiƒò3¹9Ã
òrÙ\\ß@(ýå¼,C7ÏÝøcôª·+¨5\0ŒèÕ½ÝöoM,£rùrº÷ìÍóÏÜN gÆÌÊqy9þÑy~_º¾;Kö‚ ˜ýdŸŸÜâÂuDƒ€3U›·ÅùøÓ­´‰%ß¥Çð*uÃ”¸l‰¢n·‚4UEMš™·‹ñå;3nÇjmtàžÜyó(zõÚ›ü<?‘h„.}”i3ÓÜÂ)l×WoìÊ™•nŸÏ¬’¨*©T’xÄì/šùæ`à KAž›Ñçõä°ƒ[ÓªÄÅ¶º ~Î=ÿî‰SÒ¨]¿„ÏY`¿Æ‚†@%i*~e	]ÙÈòÈ)%A,dÙ‚¹ƒ¡>¯‹c‡„n¼5s!í;íÃ€þ½™ûÑT:v>„@ 4ü”¡Gv~úµi«ÝNW‹‚¿4$ËjN”¤¦€Œ!8-P¶KÜ¦kR:ù‰×ß}PºlÙ¿¤®>DçNe”çS\\”OiI17ßt)*+¿K/ÌJ,fÓ?ŒŸïcàáÝGbØ³gŸùÛ˜7XýÑ‚Vål©^ÊUÜóÀ4ìÞ‰0÷£iôè5˜ªªC‡è×qÂÔ™ë¼nÓ‚ò×}ðLÉZtMC‰Çˆ…C`±×ý^‹¾®åÊ±Ž(tïºÿýb*ãþ}3f~Ð×çq“ë÷ãq»B»Ÿ	l·5<þ|y6 WÙÿ¿y[´ô=´ hfûi•¨­™`%ã³é¯U`¶‚†œsæQ\\qé0ºìÝ‡C`Ù²•œzöx–¯ØF÷>îä	†e*ÉDIÂ0@M%QT•d,F\"å‹ÙÓÒ ¿wç\"n¾ºûí]ˆÇeÐÐáÖû¿fÓ–ÛåL|ðÉFÂ‘”q_GÒv ÙÈFÿ0@ÖI)
ñH$]¦-)ÉcÕšZÆ?:‹³¿`ú›OpÂñÇrÂqG1éÅ7\0úŠ¢°Z–¥ÝÏÊ„f£³¿Çž]$‡§Ûmk?/L$’}«Öo£C»ŽvW^>¤R&¾ô&3fÎØ,PÍùÑùX¾ÏÅE&‘ì™Ç®`Ÿ}¤±±sÏ¿!‘Ü8þquùÚuW´cýòoíòh”¯¹qoLÙ—ü¼th_AUÕ€n—sËáDþ\\Ãö¬±,Ë(°ìH ZüÍFÂ`SåÒ5åÕUèf2Úº{Ünrý¾4ÛZùdEIBr8ìÙõôw\"?×$‚a¤˜·`yúsL¥L‡±&3ÒÖx –2KÔJ<Æ¢™oöÂiêâõº¸ù†‘œ|Bo:u,T^šü£¯ž@(·AòÂ#N?oYúsÌƒ ˆ†N2® Äc|:íÕ& ?âø.\\}ÉìÑ>YÔùê¿Õ\\rÃç¬®
°è¿u™ow6pÉi×Db1Rªö»YKf#ÈÙh‘MÍg%Ñþ’I••«7¥óÂ‹Ó9á¸£éÐ¾ÜþUÇ”ª5/;ÿ¼E0vÕ¼Á\0TŒßp~VNnŸßV·ºø°ªz+‰„ÂÁvF0tzô®¼ö~û°±Wýg|Ý¢Ï>§¨uÅœúÚš)ªª\\üß•ôê¹ñDèyÐ±TUo´ü]7p9œä—PÔº‚úÚš& üuåZ¢Ájü…­š\\\'I‘¿~ÜÌø2äÌÅ]EÓã×ãÁ››g—ùƒ@^JÕðùä{hÄËO¶?íÛæ0ÿ“/ìÃºNòü~ŠòóØÖ@FÌqŸÝ)7½¶éæpI‘A4¹PO©ªiÌ`‡9Î¥’J&Mu<Æ—oO¿¸ Ë>m¹ïŽ3éuàÞ”– (1nºu2<ò–ýœS€‡^0:\"Y#^éÒwÈ\'ã1>7Aþ ·×ãàæ«ã¤á{±G;/ªª2ýÝ5œÕ\\ÂÑt&|¦i\0XpäÙ-vy¼$,E:s+KêÊFÿÈÜÅ2S0°¾¨¨ª¹Àµ«(¢ªz+ùy~ÆÝt±Y¦]ò}ºLO$Ì,å/s)d§ON.nsôjN}mÍ‘À‡‰„J8$‚Áˆ}ÄmÏ¾1}ÂºšZ$§AmPmôWÓšÀ’Æ\0?üÒ«55›· :n¯Ÿ¼’2Û¶ ™åÂUö¿úzwožÅ‹Ò¯RÕ2¬~¶±›>¹L1SmKLËpÚ#Jªª¢é:š®3ûÉñ²•yVb–ù‡oÜ¦}Û<ºî[‚,Â¥guT@º_Û·OÏn½æ}ùõâ²¢\"êARšŠ‹£é»×›Øž‘nš!;éXá1‡ùHgÈš¦“L¦PR)tMK—¨“ñŸNÍÉÉ	0ìè^Œ»áTöÝ§->Ÿ“š›qúý,új¥ý|×uî%È\'²Æºa˜¥oMEU’(‰Éxœ/fOKƒ|û¶ù<z×`ê^JY‘›d2Æw}Æøg–6ùƒùGD„éöt˜JhÉT
Ñz­ld#È4É$‡kqdó–FZ•åá÷¹xýÅ1ÜŸüÂvÌ›¿€3?L—iCÑ	%iöÐv4øƒrAd—×‹Ûç\'h„æV0µÎ{{8\\.\'²Ã‰ìp43qˆÅM²ú—f¾SŽFÑtUÕ<99øró	Õokrlí–zËqÊh’qî–QÑÝ!g‚ -}év9q;æXœJ*…¢$‰é:o=zß`à
¶Ïƒ©1NÕ† ªªSÑ:\\÷?ñ%{tÈáø¡ÿdÌè3yèÑ^pðCfÏ[PÓ&Rj<h¿å¿óÐ5«}ž²dÐ¡Â¢—6¦éqE±ÆŽâ$ãfO÷«wÞ²U·z{=.®sgŽêÏ[ó,áøÿ±KÔß—}þ¿æÈŽíŒmÍb-µ½ŒÇùêÝ·Òr˜Ç¹c¯êÍ¾{æã÷JÔl¬gÄÅï²èë4	ñŽ£Î›y‹¢d¹°Éi7(½…Ï4ÙÈòï¢( »\\¸½>»o:Åîcî¿oÑ˜B~žŸ‡Â­w>m6áö\'\'Ô5CÄ‰_È»žÇºŠðÏIŠ’„ÓåÆ¹½‡˜³OØTÚ!Ë¸d‡£Eßg“tÖÔ÷Y–dS†T×­YigfÏ2¦£Ñ\"
¿¢soùk®e14ADµú’(¦Íì–ÆtŒÓR£úu¥réZÁHZ’´fS˜šM¦Wq¡‡ï\\È”gÊ÷yT.ùÞö&~2Ïï?¶Mi	ñ„B2™¢ÁÐI(»l(YÑÀï“i×Ú	‚Ì¼…ß7Éc	³Ÿ‰…‚,™ûÁy˜#MžŠ6ÅüçÎsøÇðƒq{ò€÷Ü÷7Þ2Å~ŽÙÀ%C/]#;H’ˆ¡›÷†¦ªM¤5?ëw0æ¢ƒ8í¤}Ø³C¢ 1ïÓõœyù‡ÔlŠ¤Aþ¨s/#É²MTÜÞbÚÁ…-ÄÙÈòÿDV(ât¹qûs‘dG“>f #•LoÍšK ˜òØä×ÇÖ5L}ádr×K]†•xî üúË‚  J²ÃÙìõ}^\'dª²Œ,Ë;uUÊËu›Ç4y|SW%Áb–ï¦½³ñûô?Ê¿<C6,ÞA¦ÚÖ¼)/Øä¢Ìì·YÜòï‘\\qÙ)äå—€àdÒËrÕ5wÛ÷ÖËÖñíëâ|ýíVÆÞý·-fú«wÑ±Ë‰‚ááýzõ¸ýãE_M$“$SGZÓôÝBH²­-×±ŒY M+§­œòöûjC0d~¢Âõ,[ðq:{Ý·K;®ü×pþyBodW+‚ÁÎ¹ànfÌúÜ~ŽÇ†œsÉhÙé@–MínM3Ëå¦´¦beÝq¾˜=-òíÛæsãå3tp\'*ÊÜ(Jœ»žXÆ-÷}j?ï»˜}è4ÈcÐD{>ÀÙøÃ’Àì%øQBv:Lµ*OÚ-ÝÇŒÆâ;äU<ë”ºa.†©_êº«¤®ßó’Û3ŠŒð¤=œ…&°ÙC[$Zù<Î&ÙìŽf™¯ÙÂGóÛ]£_˜Û`¬¦’(±ñpÈã×1™¾;ã³OÀÍ7œ‚‹‡{“êê:Î9óŸŒ`œýûõÐ8`õº\0ïÏ­fâ‹³ÈuÕ0ýµ4‘î¦A‡4¸´°€ŠV¥”àó¸‘$ñ×ë\\Z*•9‹Þ ¬Ä‰ËGå²´±C¥a¨ši¿˜ˆFY¶àã^ÀHY–Øg¯
öÛ§-ååÅÈÎB*—VÑãl0Þœ|ÌEWŒvºÝ8d¢(XY±©ä•ˆDˆ‰ùbö´ÉÀs€g`ŸvLzäN?yo*ZùØ´9À	gÏÊãÇ†œsÉ°a]^ã°äFíŒ;S¯þwùÙ&5’„C–q:äô†TÅz¥g#›!ÿñX0UŠ\\nœnqs64½8¥RÍ3)‡,c€™™ìFBÐø›—H¿KQËç`Ï<ïÌ„Žwú|?¿]XŠg»ØGn	Œ¿z÷­´²ÛË˜ýæ¿Ù{ïö X%xÃÞ°Yb$2šÊ¥«¹õÎçøæ«·8ûŒ8ç¼k\0ú~÷é<¹|½¦nZ³ò1à²ÊåuLœò=ûï3‹þ}Î`Ü¿/²[\'/Õ·÷Á³æ.¨É”Å¿Ø›HÏ«©$õµ5Ü.¢|ÈEÃéÏ> ª¦W’ö”B?€Ve´*Ëg[]UM1é•¹\\uíƒvà]àÂËïº¿&ŽK$Òß#;+ND#ÄBA¾þàí´ê–Çíà¼ÓºrÍ¥½hWQè|ýß•œ}Å¾[Ù`ƒüè£Ï»tªdõ¡QÀÐtë÷ÎŠeIÂéq98Žt#¥ª(ÖÌs*¥îvR^6²€üç.!ˆæì¥ìt6û?¯Ç9ù‘Ñ7uXÐ_üEÒ½ÉsJ’Y¶Ý-YÎ¯O[ü­Ë)e¦®?ã·ûWhZR3Ûmoñ×q,dñ{3Ó`Ü¶MÜsåe¹†¤@±¶jÑ¨bYwêx}^*—®6-fî¼Ï9çÌV8ü æ}ò@¿Ö{ì97®¯­é ªúðe?ÔsÝí‹ø`Jã®?•%KW2cÖÜrà™üÿ°6¥%$%™BÕ4”ä/ŸO65™DK¦ÀtæÂí’(Ì—¤*¿]k?t‰,™3øv?‹Y³±ŽVeø}.V¬ÜÀ!dƒ1Àƒ¯¿7§¦>dÃ¦ÍÔn­#Z×W\'™Høï‡ïì|\0”çøœ\\|VwÎ?½+íÚíi•úßåª›?\"J‚9Ò4bèù—ÕHGš¦ë¿®Dmg°¢  Š¦ç² ZÊvÂŽPÃb„iN‰(ŠÈ²Œ×ãÆçñàu»qÈ2ª¦Å	E#DbqâŠ‚¦eA9ÈÙØþåÛI37Ç‚³)xŠbÆ¤Ô/UÕÉì&¸œ&;×ítš¢Í²Jãw³ÜÙÂPPàov;z†me@ŸçkrítÃÀÐÿø…gWæ
Œ[—pÇ¸SØŸ6äæxXºl>ûžU«7Q½¡ŽHÄœqÏÏ÷±_—¶9¢+|´”î];rÂ1ûÑØ¸Ñã ° °uWÿ\0p	°G ”ìR]æÜ«ðâm˜øÔµT.]IUõÆ¡ýzõxtî‹G\'’¥Ä…d*E@übßhÛ‰J×5°ŒUÜ.§ÀIõ†zû¡ëÜ.N§·Ë‰Ãå¢´]ÇÅ[×¯33û¥k9ô ½˜;ï[®s·Œ½Œ[nàÅG>øíùŸÖØm%en$]\'¥$l…°\'òâBûíSBEk?{v*¹ç^ú(“¦¤ç³§»ðòQö„€(
MúÅ¿èdÜË¢(àe‹9ï0KÎ’d¶jv¸¯UMMËo&“)4]ç•{oÏtV[,|úµi«#±î I
¢ëq]Ér³±ãŽxÇØ®™¿ýË\"Ë2NÙÃ!ãPeëM 12\0-MZjáy·mÐaÏí\0ëq¹Hy½äçæàt{[ëÿíÙfëšÖì¼Û¶É77‡9¾¤¢kZ³¹ÞÜ/²ìjúxMCÓµŸ©ý­[?»w¡²yÚ?Gdå§À¸¼UwÜ|
‡¶mÊ™3\'Žº/Â™á÷¹Ù¼¥‘.{Wðøç±ï>¸¥÷>üºý×Ýÿˆº²j=EåmH%5õµ5—Vmã÷üçá÷¸þê2¦¿z7=zŸ	pÙÀCzU~ðé¢		E!¡$±å,‰E¥‘‘áí9N¡Pµ>=šVíó¸Éõù(ÊÏcsnÞÜ\\ŠZWX™½6|ÙòõtïÚžæ,âæÏ¦rÉJfÌü x&/Ç7¬uI1±x‚¸ELSâ1Ôd’¾ü¬#Ð×í’ÙoŸbtQª6„9ñÜ±T~»,iÍ+îz`B0!žPH©)“ö+²b3Û×°÷Œšj–½²ŒKpH.«7ùýÐ%) ë¦JÙä‡ïh¢ –râ”Wf¿7ÊaŽZ’L™â*¿Ç´F6²€ü\'iš•¬óü>
ósiUTDLIX¦ëªÕJ¥Ôt_L°t©wŒ¥ßÕÐ«÷ö¡>=»U,XüMMYQ!y8\\nÑÈöó@GH”Uj·ˆTöŸ¿šak±šL¢©jb—(
ì·Ok‹1½ýuRªJ\\1Õ“v,´­(BÀM¦	…©¬þ~ŠH-\\!ýÁŠ¿
Œ[•åsÇØuD7Ê[°ð³o9é´m0ž¿ÃÓ9#ÑDïÊ¥Õ‚q6mj`ù¸ÿ‘™¼ýþ7öcŽ%œ¹Å¥„êædzÏ|¿šžû½ÅcÎfâÓc9ç¢ÛÒçÐùoÏ_¸:že“lµ«ýdƒ&•Žn\0~¯ƒÕÕqHU‘Ÿ›në\\àq»ææçæPQVÆ†ÚÍä•”ÙçlföÁh—ªõÛxäÉ÷rÄL|ö*—,§ªºfhßžÝûÅâÑmÊJÓã[Ñhƒ6{î³nãªŠÚwã¦0­|,_YG~ŽNÕúô|ñ¯Ì~oB0fã–mlÚVG0¢¡[•_U²O¥Ð,€œ;ybgL½ñŽ»øTG½óó|œ}Æ1äçåPµ~3fÍ#<møÑLyûýQº®K$G£¤T5»àf9?Š¢ZÚÒ™åen§“ü\\?~Í›.a™3™	\"ÑáXŒh<a*7µÐ›ž·`çž]G÷n]lõ¯×ûõê1â½…Ÿ×ìÙ¾?äån¨ûÑÓétà²Êh’(þ*rˆÆ©¤‚‹¢&¶m¨Þx sÇztí€©p•áò”LR’ˆF0tƒúÚšÉ@‡Cfð€@t7qUJ(ÛGu~Òû\0@Žß¢§Ég
FwªŸÆÇÕÒÒB¾©\\Éðã	›BSº2ÊœËˆF©¯­©\0^D½—-_Ï²åë3O)wæõãæÄâq¼9¹–·A‰7õ&^öC#÷<þ-ðgz:óg{¿˜ë÷Öº¤„„EòÒu“pµ+÷„ ˜®`ÖN´ÊüÌTTUfÅŠŒ¿ëæ-\\A Ù»{×5ó¿úzl»ò2êí‰GÂÄBA€í™}õ6òsÝÜ}ÿ«ÜpÝÅLãqz|¼ÙÏûàÓESŠB\\Q„#8œ.[¤ç! ïêuòsdtêj™öÒ¿tÜ½\076üèùo~ðÑœ„’¤1&‰þ*0Ð5T\"A\"µçž—ž_ò\\Ý»vàãwï¦  5^}\\ñmŸJ 9ò˜£>š8mÖ„Ÿ‡,GÉ.¸Y@ÎÆå75€m’ö?èÀ-<¸qÂÔ™•ªªŒDi©ˆ„C™ãT0ûÇ5µ¬\\ñsßŠG]bÛ:¾~tßÞ#ž{sFMay6¯[Ó´Ðª‡šdê—Ÿ×K®ß‡Ûå4=‚(g‚q\"jZÙ­øâÓý/Ï¾{·âž[O)ô8Á@ºh†YW³‘x8Dõò¥“‘N‡Ìe—åÔ“Å@#H›ÊÃ±‘Xüg¸ê%ë_ÆºŽ®5—È,)t\"àE ³”®£zšôsÀxøÑÝ)--¦réj{¡P`ÊÀQçŒR“
N—×G<Æ››W“LÄÛRµöj¶÷Á$B½pì¥W­Ž+
¢`ú[;ÜnrŠLoâ-Uk\0.:D¢jïÕU.¸îs¦N(aüÝçR¹ä*—þÐ»ßÝ\'ÏÿêëQJ2™.áªš¾KýdQp¸Ü¸½>ûÜ®X]#?×ËÃ“6òÄ½ß1}òXó\07õ?èÀùï/ü|ÎžíÛŠDIÆÍ¹a+³¿¸iÙ÷q»$ê1›ÁGý“ñ÷ÿ›+¯¹à¥!}]bgö¡H”`C=S¶uj}mÍcÀeË~Ðë€^}k7\\Õ…[®?…[îyà‘“‡1äé×¦Õx\\.sÞøWš5éšF\"%ÒØ\0pàéÙ­-ûw)§¢u>—ßâ”ÈV…Ån©£^K;²uÚ òóò¸õÎ™·`	WŒ>›N8ŽñÜÆ9çàt:&¸];÷“ÎFÿž¥é¨ì¨\\ZÚæLBÕÇ;{ŽóN:îsàÂ×ÞýpYŽÏ‹Óé Ñ˜›gkç.\0Ž_±jÝÝÜpë4¦¾Ü–¹ï?ÇÀ£ÎOƒòù\'Ÿ0âìn­YÿýwÔ×Ö¤á©®®žÌÇír‘ç÷QZX@} HC0¸Ë ¼#ÇBA¾™ónŒ÷ïRÎ­7Ë€¾I/Ïæ¡Ç¦Ú‡/XU½žÆÍµ,?Çc§ÌÅçÁgŽËí\'ÐXÏ ¡ÿ—~|0&þL›»_ÈÛ}xS¦äŽ¥ô6^ò2F’ÌÒ»í\\ôóÀ¸+¥¥ET.]Ã cî$h
fL~É•£l‹EON¾¼J,†‹¢Ä¢ä•”= Â²Ó‰ËãÅ›“‡\'\'MSI&DQD×u$IÆíó“_ZfE¬¬ó«šMQü^‘›ÿ3Ûoª`âS×1pèÁðÈþøÑœÏ¿œ`‹„È²L8K×èºf2w\"’!ˆN·_~ASP\\Çí„?ø€!ÇîÅ-7žÅ-w½\0ðÈQ}{™ùñ\'5ÑxœP4Š7ŠZWŒ­¯­ÙCUõ‘Ë¾ßÄ]¼C¯n¥Œù×ñ,Yº‚I/Nm’ÙG¢1¶56n¨\'¸m«ÝÞ#¡¨C—­ Ë:gž¸ˆ›¯Æ¼…Ë˜·ð».À3²,s:ˆâ¯5Ó«:jW§úø<=¨ÿ<¾\'E¥AÌÁeV~ô¨ù§\0è1b‰n—y.º!R¹t5·Ü9Á¬Š}²˜Æ­‡1àðžöËõÓu1;œäl´HÍ{ŠuõQ–-[F÷®íš…¡Z`!\0`”Ê¥+{_ž2ôÈƒgÎýd™Ó!“L¦hll$¿tÉD<]z¬üÖÚëÆ¾Â½w^ÄÜžgàsÓ <éîq#zwrMõwKl”á³Å´Û;dýéºÿyŸ~³dB«’b\"–€É®€rK`l›|	xºÐ†›®=†aGî¢‡I¯ÌãÜKž²?ÿ²Ûï]üÝòå|6ãõÉÀH—ËÁè‹ŽäôSû°÷^‚1KåÒu`ùÎ#QÂ‘(ÉÔoS²ÎcÅrÊ,¥»œGõo¢ÃØº½”ž4Ë¼J2ùã`|Ó	—P¹t-ƒŽ¹ÃV¯šrâå×rZ#q)UC–ed§—ÇK*\'—”’H÷&EA4m]®4Ç@Ó·’QÄátáÍÉ#¿¬ÉD`q}mÍùÀs««£¼?o=ö›É‰ÿ<‡ñ÷^Î9Ý	ðÜàÞ/™=oÁbMÓq:„Â“É¬jhšFÊ6»ÐtÓ Â\"€éºARpy½äi¨Ï\0Ecè²U
w?]ÇÀÞwÍ5Ì[°„y*»\0ÏäæëÐºœH,N4C‰ÇÙ¸òûŒÌ^é½zm=ç_ñoLÊgü½—S¹d9•K¾ïÝïÀî“ç}ùõ¨vå­E¢„‚!b¡ ›Ö®²ÿ Ju©ª‰ñÂëù÷e3mÂ‘ô¼‰ªCÏ;éøŽ×?øØºÝqÿèšF2µ™Þ\0„#
«VoEµyzŒ:¶mÝÊ7K×³yk%©³yKh,‰Ïç&ÇïÁëuãr»ÒÏ“Ÿç#
F<£…£ü&Ž]ÙÈòŸ;CMæeSƒGŸú˜Ûÿ=œÒòÓA*4³|l$Í²àCr8çÂ»˜ôÒ[àËã~ð;Ÿ|ºL×u\"±ñHÈ6¤·¤9·ƒò]÷¾È×Ý”?ŸùæˆÌ³yA³•‰O\\Î9—>ð\\ŸÝøxÑW’­[¥÷s@ù§À¸g·¶Ürý0Ø—ËË¤—>äÜË^Iƒñ…ãîšðý?0wÊ¤ÉÀH·ÛÁÕ—ãÔb¿.í	B~7•K«l0qÉm÷ÔÃbñªöS€lìòòŽ`‡PbÑí¥t§Ä¿Gwá¨æfJßNš‹ÆâDbq\"ÑØO€qJK
ŒUME7DQBpH²	Ì†õ™ ˆ–Ò™˜&Ð51¬$.þüBTËÎ°¨uÅ„úÚš#TU¹bm˜‡ž[Éþ{½ÆYÿ<‹%KOæ¡Çßxdø€~C&Ï~/’ëó\"
‚iÈö9YÝrž²Á8¥j¤R)b‰’„¦ª$bQ6¯]ŠZ—ê
ß´	LcúËWÓãðk©ªÞ<´_¯w~üÅâïÑ¶‘˜iaÙKnÏìkñûÜr×›ÜzSŸ¹…CÎ\'p°™Ùï¡(„c1’	s3Ef?º&Îì6Ós_Öo¤jCÀ»w=3qÝ¶†Àna)ëºéžáveöfBqdIdÐ°[\0X<E(\'NL©è:ÍˆŠÚ—Ð«G\'N;¥?¬ªåîÛN\'ÏŸ`úÌÏ¶WŒ\"Ñôr6²€œ3#iNÀ2Xµv+WÞ8•‡ïI*ðxÔ7DÑ4ƒvtêÔƒöL|öVD&½8Ý|9ìð>¿óÉ§ËT‹ì•J$X¿<ž¡—m²aàp¼ÀµWžÉÜ÷ŸaàQP¹äûÞ,úþ°ÖìcÏ›·ˆ³N>Äk9çâû\0žtèA|øÙ2ÏúÇ@ù§ÀøÀîm¹íÆaê·.·I¯|Ì¹—MNƒñi×°zõ*>~e¢ÆN®½|#O>„}önG aÐð{š€ñ™×«‰Æâ¤T%™ü™ÁÏ•m	Œcá Ë?ûÄÌÞcÎß“óGv\0©€@Ã&®º1ýž„¢Qê¢¡P`œ»ŒKK¨\\º’AÃïkŒUÍÌBÝH‹J¢Øä3Ø•lH”e\\9…E¤	6­]eß?f?¹:ÂÅ7.aæ„WyðŽÓ˜· ’Ê¥«{ËF?º
Óâ1hý\0*ïyvR£a˜›PÉš¿0Gwâ	…üPˆºªÚýàí ¸Qå¿Ë“<ôÌÆü«“ž¼ŒÃn¸qÐ!½þûÁ§‹¦ÆŠ¹±±¬›döëêxwÎtÛ÷-N<ùtÆßwç\\86Ù¿óÉ§‹cñáHŒd<f›•¤ûÑ_ãú{«øvezC7¡1&®$~æ(ÝOÝGz¦lh:\\N™¢B_¦±ÆOÆê5[ðûÜ´«(áÄcFI¤øä“Ï¸êš´ê¼†`ˆH4ö36¨ÙÈòß*Cq¸ÜxsòÀR
ãT­7ýh«Ö7°hq9~¢(§P’*¢(²çÅŒ½öhëÓŸ‰ÏÜLzqZ”ßžofÊª%š¿áûeMAyYÚ+Øå§xÔET.YÑÛ´øæmIÀ“/×°g‡78ëäs€í |äa‡ü,P¶ÞUE!7ë÷ìÖ–[o°ÁØo–©/K;óœÂèk&ÔTU1ÿõ—L0vÉÊ>{µ!3è˜;±²ÿÏ§^}cMÊ.—Zã`¿e™Úãoçd•Ò%Æœ·\'çü³eee·1hÄ»T~·àóÆ?>v[C#j7n¨kŒOdøQÝ¬Ìxg`,¦X’$\\N‡Y²¶úšº¡7éSÿÜ>¿)xáÀíó“WRJRIP¿qÀ™ÀÒÍÛ’¿7ÎéW|ÍÔ§¦M:‡žï$ŒµÇöè¿ãs^ÁÙX=Íº×,À®zaÆìuy9ø<DQ4Ë÷f¦šÅïV%™öD÷}ÞdÀÑ—òàÝçqÕÀ¿úbö¼5±D‚PÔÊ”ã±¦™ýêzzú< Ÿ³O=™%KOã¡Ç^xdØá}†Ìøh^ÄîG«É$’ÃÓã»iÍª=TÕiñ&`ôÿwóÔ@(„’L¡iÚn¸™°UÇšDYiˆ¾Ì_ú‰gº3Mô^ôÕjÖ¬ÛÂêµ›xmú\"–,MWÖ§\\tËÝ¡°5‡­eá, g#‰ˆ\".A!À<àû@0Þ%Œÿä±k«ê¨^ßÀEçTqÅ¥\'0ñéÒ |L”Ól_Öï”®3’¹ï?ÎÀ£þ•	ÊÝ7oKz~âÿþ³ŽGÆ½ÀYÿ<¸†s.¾ÿg²-ø‘RÄÃ!¢Á\0Kæ~Ð¤g<îº#|ø8]žf`<ìÂÑ¶ÕlàÓé¯Y@\'3æ_GrÊ‰½L0Å›ñ)WÝXcfŽ*ªª¡j»0\'jhð®L?Æn—ÄÕvbÔqåìÕ©ˆ@0Ä S>¢ò»†ô9Ö‚lÚVGÃæZ¾x{zŒËJr÷Ç›`\\ZBå·«4ü?X÷DŒR©ª©n…ËáÀã¶å]8dÝ0ÍHÂQs.¡(?[¸Ã¶¨ôääRPVN*‘\0X]_[sð¦É‚vpêèoxd\\œ†WQµÉEUM€Ê¥k	Ã,ùv5T.ÛD ¤€9[ËŽ€}Ö	Ãß.œ4}V,Kf_=§ÆÕ±õµ5ÝUÍ^ù}‚[OÒ³Ë]Œ¹à>ùô0fÌþ¬x}ø€~}¦~ð±‰Å	GM2Û†–gdöÉÞ««\\|ÝÞ™ìçÁ»ÏeÞ\'‹©\\úCoà™üœœQ­Êh…‰Çb¢H,”G~I«Qß/Zp9&ÙjÁs.®FL‚ f•âu/v\'ê^]÷kRqúß—ÞöŸ¹ë6Ô°µz-á†zÃ0Û
‰8I%Á¶õU#€\'UU¾is€M›ö¡›€©\'¹~t,G„Ý·™ÈFÿR²Û¿ ýûT—-˜Û`}ù*n^±j+OOüŒêõ<x÷iL|ú†A9ó ²,‹Œ¹ì”‡\\j/TiPž»(ÈÙ×¬àÙ»žá¬“Ï®æœ‹hÊö !$žPLy?5E\"&ÒØÀÒùsš°©ÿïŠA9poœîüf`|Ô¹—LhØTË¢YSÓýØÎêÃÉÇõdß}:EtÌÝÍÀXÍ2î.ƒñO&2ÆÏ\0ck/êÄÈã*ØgÏR!…A§Î¥ò»Æô9žvÝØš›·Ð°¹–Ïßz#ÆÅE~þïÊasÔ~”–S¹´ªE06‹˜cÙ0¨.¯=xw–S°à±É¯«	%Ic0DC(D ñD\"}M~rÃ(I8\\n|yù”·&™ˆíÀ‚ávÁic–2òØ-œ0¤ˆþÝÚ1 g)Ð
è‚ÃZtæ}^HÌ_´™`D¤òÛTmPµ~ÛPàÉV%ÅÇÊ²ŒªjÄãq”x”ÚUi9Ï¢HLï½¦Zç‚›^}ä)žt4Uë·Q¹tUoà•¢ü¼QÚ¶!33d%ckõºí™ýÖ¨\'?×Áµãæpÿ%Lõzô>×î\'¯™9÷“±eE…´*+ESUœ/Z*ÉaÇ¨“òt‡Ë hªJÒ%÷_]i¡e	ØCzµ©(ýïý÷ìDa^.ßˆ\"®YêVS¤	”X”ÜÂâ%;¶æ‡å™Â\"•À‚£Î½¤NIšóá êÚžû_€}»µ–Ú›À…À$`ÂŸáäw7áîOÈ™\"ïæßM®-W¹;Ü\\AÀátâñç =Uã‘ðœT\"1GÓT«\'†¦›;a“ùJ}mÍzà¹«LÖnhôs<ûÈ™<ÿÔÿí”Ís5vÊå¥>N9åDæ~ð‡\\lƒòlàˆÍÛ’ž¯¿ƒQW®bÊCv
Ê¶¡fxRj*­¼tþœbLñ~O»ŠÎÙ“ý:âò0iò§MzÆGŸwé„À¶­,š5õj`¤,‹¸/G¾=»u N1è˜{¨üvCèF^óïI’0tY2õ¿Ý–&¸®›3¿š¦¡izºÝvè?ªßmèf¿/‰…Bi?^·Kàš‹:3ò¸röÙ³ÀãSæQ¹<ÐdÃŠD	nÛJÃ¦`:õÎÉqsÆ)‡0èð½¨¨hKå·4üÎÁ8–H Äã¨ÉjJå“×_ŒËX|\0¾¿lÔˆ^žõîh{æT×]v%	§ÇCNA)%ÁÖêuMYÐ+£´*–yò•L{+ûïYM«R¹¹2%…ÊŠ¡¤Pæð$ÉCÿƒÚ!8Û\\F0V@Ç®£	#ÃîÛûö?ûb¬ªiæÜx<¶c?ù«š-°|µÁí¯áæk>ä¥§Ï£ßÑwFF8øÀ>üì‹	ÛWŠF-’WÌÎìGÏ­XÀïxõõÙœzŠËšo¾à¦ã>ÿÙ7¦Ï)ÈÍ!ÊA”¥Bœ`’åDÑü>M%kMÛ£¥¹õ¿‹Öå%ÂvÆtQ~> P`:†a2´µ”i©Ä¢$ã1
ÊZ­FVËsÌÍí÷›w¶¦‘„ôFâ/Ê²Nopwø}_ëç`T6Cþ“±$‰¦–¬ecæ°ÆDTM#™J¡$S¤Tõi÷ffÈ¢,ãt{d§Ç‹/¯ÀÚ×4ëK·½›L$ˆ…‚¶n¶ûcd‚ò¹ÿšÄóë<ÿÔu-€òÂeºn j:†n°~ÅŽ \\ËBnåìµß0æ~ð­úaeë_Ú=åSÇ¬äÕ‡žâ¬“/bÇžòŸ.š`‹Ý+J’¨ÕÓ³F:úa‰÷wÝ¯ûïSJIi9/Lù’sÿõBŒÿ×Õ‚õuvß²À>Ë(/óÓçŽ\"s•ß®Ï\0ã›j²dn”pÊ¦²™ËåÄ!™·£b1zã	…x4
-™iüˆŽµ¦ééñ¤h0@4ØÈ÷Ÿ/°\\cÎkÏÈcËØ»s	@˜A#¿lÆ†aˆFÖmµõ“‡ºÝºí×†=;—ÒuÿT~[Ã cnKƒñˆ+oe{@›å\\Ó†1™HðÅìiƒòó<tïÚ	pØ£A]N?vè¯½ûáa\0J2E$CI&wñ» ãòúÈ+*EWU{NÝbA«]!0u´ßÿ¤¿WD–Erý.\'´.uât´*ñzDöj¿‚¡‡ûØgß^äûdÚä›tÌõ\07yØ!óß[øùœX{SÚ1™H3§Ûrž?¬˜=ß Û^osüÉyðî³8÷ÒÇ=ò°C¾x{þ§Ëöî˜°æ“c™ýäîffæ‰VÑcß™ô?ðhÆ]ÿOn½ç€q¢(Îq9¸]Nì¹ê–²FcwdÆ?2·Þ®mˆ¹dÎÄÛŒnI”­{Z’e$‡Œ9cîASShª† ‰H²ÙáH+¡ýÜÄðK®üS¬Õº¦‘ˆš>Ö‰X”%s?xèÝ¾\"‡nÈ?ŽïƒàhÏ¯Vråõ„Gõ/ÏzwtÍ–­¬Ý°‘­õ?»jô§mþÙN8½[ÕM‘›‘ër8Èõy).È§uY	mËËhSZJiQ!y¹äú}ø<ž_üã÷úðçäàÏÍ#§ ¼âòK[QÐªœ‚²Ö¶²~ÊÛPRÑŽ²öiÕ±3—›¢Ö€óV¬ÚÊ‹7pî¥/`Ä¿àù§þ³Ï<L	¾/éßwÿ­ËéÑeoÚtÞ‹Ö{ìeîº[WŒ¦¨ªNå²Zn¿÷#ŒTyyi¥¯¼c.³ÌåøæmI~XåÔ+Ö©yŒ³NîÄDk\0<7¤Ï¡ç•æSZTˆßç ™ˆÛò†Ýü~7N‡ÈÝZóÂ”%œ{ési0>ì\0\"F‚Û¶‚¥.%Ë\"¥Å>Š‹KtÌmMØÔç½£¢ñÁpÄToJ©H’„ßãIv­J)/.¢ 7ÙålqÜ,ƒì5’	ssi¬Oƒ±Ó!pñim1¬Œ}ö,%J2hÔWÍÀX’jŠD4J4Øi«A²,²ßÞeT.k`Ð1·š
\\Ž»k”ÛåL6%“I”¨9³úÅìi™\0\'ß“ÕßÜÉÇoßÊÇï=Ì7_¼I÷n]\0zŸ2ôÈGrsÉÏõãr:wZŽL›ÛË¶¹½Ã4¸·f—=¹¹ä—¶¢¤]Úí{@ÐÕºÿ^ÀÔÑDb:ÊúZ…UU
ó¿óá§!^š`ÂëÜþD€ÃO«á–û¢žgÀ¡Œ»ñtû49ºoïŠŠ²RöéÔÖí:PÚ¾#N—¢Ö\0STÍ`ÅZ‘û_€šïãì“ZsöiCì{ý™cú÷Ú¶*cßN)kÛž²ö%‰¢Ö£wŠÊŠµQžz¹ŠÈ–·wYÚ\0ô=ï¤ã;šÀ\'¤«dÂnÑø©¹u‡Câˆû‚èÃ0¶ožv&k[¹:Ý<þ\\|yùøòðæäáöú.DINkÏÿ•2cÃ0Ì
\\(È’¹†ú¼N¾7m+rYòíª64pÖÇ3÷ýIöaGœ~ìPÙïõàþ‘ïC6Cþ#?X]G×T³|dè ÌzâÁÌ^LÀêË-N¥TrÅÌ´,û¹]6L¥.QÒ7–ªj$’É´`DÊRHgÉÖˆ”äp JÛ6T·˜)_|åË<õƒçŸ¾I/Í0ç”~ðkï~¸,éL<#ØÏ‘Î”?ý²R5àìœ>Õ÷ëÂæ£†/ûúýÙf¦\\§{ ÎiWÕ0ãéIœuÊhàFÎ¹ø.€çŽxxàåYïNÍóûL Qf–“ŽÂ/EÅe¼8efŒÇ=öÌ„P$Ê¦­Ûˆ‡ƒhjªyÖ åS¹4í;âÖÇŸ­ÙTWG0&•H ¦RÌ<ñ$àl+»Î³úGó^|ëí±!¯§ÃAc(„$;vé#SU•D$B¤±ž_|ú(0R–N8²˜¡ýóé¶_+‚ƒFÎoÒ3Îìk§R*I%N\"i–wÝ¯=óMŒo{â¹Q‘XŒ:M#–PP5MM‘Ø.\"q–]þï²g+V®©åýg?£ÿ~xŸ»èërš¤/§Cn±X/Bss{IB0{ºŠBT6™ÝvUÇ›“«ÆÃá	ÉD|‚šJšå] ~ã†î€ÝÏ.´>	è«j™<òb=Á(›Ä¸kÎeþ‚%Ì[ðmà™ã~ÌïdDãq\"Ñ(J,FÍËN:Dbzï5ëE.¾MgÖSðü#·PùíºŒ~rî¨Ž­‰Äã$¬Òõæuéùæ/ë”ò™ncßN:“g=OÕ†ÀÂ[Ÿxv]} h[AþfÿÎ­;$.»°#ÿÑ0ÒB2?*+BÚ3üï¤¿eè:I%A<NWÓJŠ<¬®jäþÇ¿äY+˜ûÞÐÏö\0ïpHò‡,gùñCÕ¬^§íºb³zw|ìe£FÌ.ypÒ+5¦‰¸YÚÞU\0{t8d²ù#	%I8%13½xb;36Í|õç¤Ÿgg |óí¯qûÍ^&>s‚=§üÁ)CìúÔkSëjÛ´&\\¿†Íµhæ|•ýœËWlb¿ÛEç+ÊJi»×>Ô¬X¾lKõÚ4(µ4ÊÿÝý÷Þò.g<…ÆÀÅ\\uýS\0ýü^ÏÔŸQ’ÌçßaW^ZäAý™¿Z[˜—k2‡Sæbµco·¢<wú7Ï¾1½&‹³®¦–h @2ãó™o¶ô¹õúžyü1G\0#žzmjM} ˆÃånéf`gò™šª„	›šÃ}ºïëgÏnúœC0^À Ó©\\lŒUUK÷üRI¥	{=Nòò
-\0«
ós¨k˜`¬éi#‚Ì¨°ÀÇw+j™üæ—¬­ªƒ»ßdî‡“Ð¿m$Òýä!Gtì•×+å©GÃª¨€ÓáÀåtã3+?N‡Œ¦ëDcq‚‘(Ùl¯¸ÜxsrQâ&¯AM*hª
†AYûŽ•¢$#JÒ\\ÃÐÑU•D,F¤±ž-Ukm ~<ÒºÌúXÁ)Ã½7¿Ê´/¤ç€;©ªÞ<x²(?ïâNmˆDMÑ«ŸlÔ×Ö˜$­:Ý³f\\ßþ3öM^zú\\ú}\'`ddÿƒüzÎç_>Ð¹]Eúx5•A¨©ß¸áLàÃu5
cîÜL<¡|\\ÒO$~ÑŒŸš[w:%.>§œy.O>†­:öûð]”€ý›\0²a «ª-õšŽ`HaÕÚÆô¿_xyúÊ€Ã{Ú>àý4]›³3B]ÿÈ>„ÕŸMDÂ¤…ÅïÏšŒôû\\ücXg:uª Ò˜4ùsÁèp èª³Oûð78•/Ì˜=\'–PhÙRß@} h©Lí(O¥qÀ¾³qj1Ÿ¹“@ ÌŒ™sÊ~y~ÿôÒÂªóòñåæªßÖä$êê#MÜ’r|^öÝ£ë:uFM%—Õ×Ö¤Aùå™!F›ÏAúÐý€Nö!Ý²ŒÛå2¡ZèÏä»M÷£Œî†ßë¥^¢kª¹¸ïÅEnKdûã“)•ú`pCÿýðÛ‘^ƒËÎëÁõWC~ñ^Ìû¬–«þï™ôˆKa^Þ°’ÂüLŽ&À¿3-kMM‘ˆFH˜`h–ß½íÛ8ˆëmtÊ¬&`|ö·Ö(©dÆ·a˜c`;ª2åø¦[ÆW\'×ç#‹£[D9›‘«[3Ý™Ñˆ²iK0ýïÊÊïÐï S:Ñºä)UmBF´ÏC×5Ë¶sÖfšÛ€Ï¼>}q4Çír™.c‚HD’p¸Ý¸ý9h©šª¦gie§—×GnŽ¯Çƒ 4‚lÛ¸_^~cpÛÖ¹™¢-‚‡ŸšË˜Ë
™õÚUpèu\0:¤×‡|ºhêžíÛŽÅ¬òn2HZkÖÌýÊ`òë1êôN<ÿÄ%œxÚ}\0÷î}ðüw>ùtqçöm	F\"¨II–É)(œSµlÉ‘Àñ„>“¸xÉÈknªÙ>Òô{Ï­ËŒ¾à0Nq0{ïÙÖT;v|&Oâ7—€ýó†ÐâwëV9lÜlVæÎ:mè1æÍÿ2½ÖÆŠÅøë+–ý¹\0YÓPbQ›	|žýù÷•}8sDWÊ[ƒTÄÍ7œÎ á·Q¹tmoš³øvKœuÂð)3>š?*ÇçÅít\"‰\"[”·V¯m
Ê«ë¹å?sqü •Ò½ëÞÌ˜9 »Ëé˜îóxp¸Ü8Üîf¥SÃÐÈ¬Á;2¥…”´mÏ–ª5µ®°AùÛÍu:¯¿¡×a«À(hò%q:dDQlµl—ë\0\\M\0Ùåt˜}.Ýhñ–—ë¶@Ë~¼A€X(h{âpÔÀNô=´#)*—V1ðð>Ìý 7=9™ªêÚ¡#Ž|ÒÃ/½:ÕéjþÞŒe­©ªÍÚm{wòP¹\"Iåwõi0¾qüã5õ ÑD¼Éø;iQû¼NÜMØß.§åÈcìhÆ Ú¬ÜJ $ªŸç¦÷Aíùº²†ÝöäìÓ‡€³m6*c‰DºÿhªC%QUM±àWvjnáˆÌ.ybÊ5¢(šM#eb›¦ªÌíÅb`¼êí­§X<tû“¦~±´5k—|¦èÇ]ÀËVjL~Û`ÿÎo0xx[¼û\\®ºáy°œ™fÏ[°:–è@8j*i)±ÑÍ¹l•À“¯ôÜ÷YN8bc.=–‡ž˜ðâ°Ãûyý½95Ú´¦!À››OAYùAçü÷Ãw
ŸyA£ËãM_ÕÒÚ6û³¦¢˜ 
éÏfW*{2CÓtTU5Û7‘0ñp(cTNæêõã”{°ÿ¾í	÷P“	‚]“€ýA±( É²Mr[\0°ykŒŠò¼^/>:Œ¾ý§C§Î|S¹„y¾±«!óÂ‘(	%ù«G×²€¼Û3d%³ûr\'\0ìÙ±€pXáÅ×¾áí9ë8¢ÿÞŒ»ñL¦½r/¼2—ô7ÓÐ¬lrW>T[šQA6Ë”‚‹‡ŸA yÂýùàÓE£\\‡	hð“ ¬k›Ö¬lÊ›·E™ýÁr†ß›L±Qq9Í¡ýü™!‰M]¨$QÂçqSRZJ~i+;#_f»B-ù!Ž¡¬\0½{ÆB¤#Z‰-…Çí°Þ{æëˆæ%ÝÉµt9hX’$¢j:‰h„U_Ñèí÷9i$˜÷i5g\\úÁP‚1ÿ:™ñ÷ßÌ—Î•×ÞÐÏ!ËS¥<£ª’¢¦’;n_èX!²º.×þUò‰)oÖ„¢QCáÌB7îôõ›|N;–ÓDQDv:‘N{º¢j}=­Jr\"ï¼q	½{÷Iæœn&Œ\0,¼çÙI¡0J2iÞ}vé;¶³í×Þ9>çÖƒ¼‚2‚a˜ôÊ<Áðp ¨¸ à0]7ˆÅãÃ‘4¨+±©¤Âço½±?æX[yK-ƒ±—œwòÃ/½:õ§Ó–Šüw}mMGU3F®X+rç3:îÿ cÎ»‡¥Ë†0é•<À‹Ãôë3íÃh<N(b2§7¬øÌ~r~B1†þ°NäŠ{tÞ{æ^¼õ*—®cÞÂe]€\'}÷±Åùy´*.$¥(8=&ÙP’eŽû×Õ¹~_ZÝLÕ5l+I‘%Ù$¶É2²$Y}u¡…ÔN¸€†AJÓˆ\'U³“Ti§2·KæÚÑ‡sêIÝÙg¯¶`¼}¶þ—IÀþJ ³Þ£)sjŽ|‰Öïì†­MÞôÞþYq¸\\¸¼^ŠZWÌ©¯­y7¡¨C+¿ÛÊ>‹(*òÑ¡]!3f-´™ø\0Ýòø3jc0LBQ0ô, ÿoõ!lƒðh$Ý—ËËuñõ·›xÿc“@´ð‹õ?ì\0ºwÝ—q×m-ž2è
†a—LQË¹IAô!ˆù qÂ±G0ðèÑ‚á‘CúÊÇ‹¾•	X?Êy%¥„êlOÕ4ëiqåF†oÄÈ°ý3k±oaÁÇ0„¦ZÎ‚\0²$“—ãÇ——Ï¶ÕMI¦\0m¢&n‰ºnö%[Ì&aW-QP›e¯š¦ÙÚÃ`²±>ýb=ÁÙWzèñ7yð¾èÞ5MTë®ëzsò‹a™Kð#æ;–ÒòbÕõÛ%sý¾Œlëç
“è€Öd3ÒÒµD	—Û›éß;[Uõá‹¾®bÿ}Ê©«\'žz33f-\0ˆ—Dã	‚‘JÒô)ÖÒã\"–-øøv wi±‡ûÆõgÄñ]pú÷FÛ2îæ«xÔÅT.YÑ{ÄÑƒoñ­·Çæø|82†n˜£xá‹ß›iÏ˜—z`&>2Œ½÷é	ŽÖ<üä®ü¿GÞ¼âŒSO¾wÂ‹Sƒ„ê¶Ù j‘´à‚±ðÆ£Oðàícv iåêÐ¦5aËÕI‰Å0tÝ¨¯­1IZzùÚŒs÷õ™6i\\G ~Lÿ¾·?ûÆŒ±^·Ùé´¾7ŽLÒfåØGžªŒ+
áH””]²Ö1²D1Mts9ˆ’ø³‰S†aH&QUÕº½4þûÁÛ“‘·ƒÆàŸ\'ìÏ^{¶!Œ0è¸Ç©\\¶9Æ¿µìÎÎÙc‡CÆãráv¹p:È’ˆ®(É$qÅ$µÚ6›(¢€ÃíÁíK·f.^DS½ëbæ&BðrÕíÍé”\'½2z[c€p4J\"™Íÿ÷\0ÃÊ~RX}³<MÓ‰F\\N	%i.ªëÖ¬¡´@!I’´~)lÙ!ÿùe¤dJ#KaPRäåÀî­Ø{ï}é¶ÿ¾–¦ôÅ‚á‘ƒ=ˆ¿XÜdˆ}g ìö™`iòöÇ×EMûµ\04ý\'ˆÍAIsÛåF’åz¼ši—qŒžAúñ*Á®,F@n-\0ªjþ¿–ñ%ó¯ÁˆSUUeÿª*–H ª©]>/½…r¶(ç4ÉlÝ.\'YJƒëÏ[¨Œ$ÉÌÞÜ<6×‚©b…ªêÃ¡¸i×\'8m08ø¡§,Û´­ŽH,NÊzÏº¦fV…\0´k“GuMˆî˜Oåò·9nø\0®¼âRÆßw=‡œ0Àä8‘$)£ÕÓ&ã»¼mëN8¦N§‹yŸ.§C\'™+FŸ¢—+¯ýÀ˜¶­Ê¦°oêkkH)	#SôÃç…q­ç¶ë?h\"úa{.\'Ú·µHZ±Lg¦ÑÀ›kÖ¼ÿ<{ÿ8.‡icÐ‰SÀò\0V55© ë:ï>ûhZ1àöË/þü¾ç_:ÌÐêA”x]U™ýò„îöfo7ÅX<‡;ÿ=„ã‡íKûveƒ±f`|ÊU7ÖH¢„n˜Â!²,ádK¤DÜíd$[ÔÇ´ÅÔ-e:óžóº]ø}^|n’$’P’ñ4B(#¡(M¾s¿k†ìtâöùp¸Ýµ®¨©¯­ùè-Ë¢%¬ä j½Iv0õ­QÑ¸Ùº‰Æ¤þ&ýø? ‚€(IæÒ } ¨PVêeÏN…l«Òó€VÔn‰0þ©/˜þÎ*4Í¼ùTU\'¥îÚîP7šÚ¦É’È™#öãÎûÑmßMAù^iP¶_£%P–dG¬a]3³q!c±ÿñáÎû¨’(\"J’ÉœÎdC#†®*ˆnü4øì‚Õ¡±ÑÑÊvŠZWTÖ×Ö|‰&{ƒ	òò\\ÜqC;do
z„[ïL«æ-„#¶>ó¯:/ks³,I‚ø›”òLCnŸ—×g/@ÿÅêý&ME&&Í˜½,‹™£K	Å†1Ëò/bV…úø}2_,ÞÌÛ™–yW2pÀ\0ôK·\"úêÆvG)]×Ì‘ÓâÓª,¹ùfI-¯¼±”o¿ßJ~žoMáŠÑgqëO†ûŽ<æ¨‚Ç&¿Þø}‡N¶ng¦5ëÞûÔ ûô÷8ñ”N™¢ig¦¨%ú‘Œ›j^ÀÔí&“ß5Ø³Ãç»ëèÐ6ªÁþrbÇ“Ç\\¿.
²àWÒ`|ö^{QR¹qcïkÏ=£û¸GŸ®T’IbÁ\0ŸNí3~®ˆßçâ©û†2ü¨ýÈÉ+$Š2è¸\'š±,™B7ºn ‰¢5î0\'3$IÙCNš®¡(fæ›PÌÑË7½ç<ë³í`w€ù¦¾5Ççqãt8¬cutKšó÷^»íµÏátÙßéî\0~¯Ó+¶O8KÇ[O“÷Œl†ü¿¢(át¹q¹½`š<œ¾ºÊôQ-.tQ\\è\"Ç/³ruoÌúÍÛb»ýžyi	K–må¡;êéÖý˜‚òÎ2eQÒ¦ó™áøŸ„ð#jUdÌ;6ñ]Ú±ïœÍÜò9Ñ\"PJ’ˆËëC4{€½—ýPÇ>‹ˆDb8¬‚ªõ[9÷ÒG©Z¿`áž{aÂúM[H6ä]?/ëj¶0îZòb Xårá\'{rz¼¸<›ñ½}¦ëMNÅ©ÓÝ*›éò¼®é¤vè‰×š^“ü\\\'ÛÝ	«D©ë&;MK¥ìë˜oo.·l‹òí÷fFF™1óC®¸bºwëÂ¼O¾è^ZX8wÏŽhÜ¼	%iBÒZ±VdüË:î÷gŸt;K—¥IZ;¼OŸÍ3bñ¸EòŠ³qÕŠ&&/¿Þš·–`Xx÷’[ïY·|ùò¦`œŸÏÄSNaàÔ©°q#@ÇíBM*|:ýµÛÞåenŠòe|	[Ác-ðYZø¤¤¦ß«Â£ª:·þ_õÛ/`ˆÇ=Í’ïš‚±(Zªl)³Å Y\\Y–$	YÞÞ×Ý¡ª)QEÌìû­Çhi„°?pÓy\'?ååYïŽ’$	MÓˆ+I³Ôÿ‡”­Í„D’›/v¹¹®fDÐ„’Œ_¥²˜äß%	—Ï‡/?Ÿò=öœ°iÍª#TU¹xÉfZ•úp»$ªkÂÔn‰ (šýÅù÷n<…;#ÑTï/¾ÙÄ%×}Äm×EpÄ‰Ì}ï	}i3P¶KU™ ü£;å]½é~¤ú¹K ´«¯!)„œ˜’ŒÛïÇåóÙ‹òªª¬Ù\"V\0™&ÏeÞ‚e`ÍšêºA8m6»øKÎË@Ç0¿ûý*;ÈNW³ÿËËqb²×·g²%³˜©_l.b’ý©-únÞ§U©‡†îE^®“ã;šöíò™øâöÓ-E¢Dãñ´Ë”Ý±Z=fŽA«R›·FÉÏurÖ¨>†jƒ1À‚ü?*Ú°¶¢‰h„š•ßC¢ï<óÞv;ó®H÷“rsFµo]N8#7	e–Ìê%À0]^œeµR`
pÚÊU«˜ÿÚ‹i0>˜Ø½;´m¹Óá°9	ý\0Ú•»è{P>uÍç ntlßÃQžž‡0Dy; ˆ²¹Q=	FCWˆÆÌ²p8’$2|Ô¾ý~K0ˆÆ-½ò”™u~üò„Ûùy¦3»3úççùxðÞÑ¡SgÀÉ\'¾á¡G&„Fž~ìÐ5/Í|glBQ„#Db±]ßËî¦,YSg|‡(Ì÷4Ñ.p:LrÞß-þ|€ìñâÏ/D×4„QµkVÖçmÞÝqXu6pI×þƒkt]CK©hšºK §ë:jR!
¡©)êkkF`*¿ÛÊÍÿùŒ›R*CŽþçNAyÇòuJø‰ô/bïbÂû›²ÖìY–ðùü¸}~»tú¬½«7¹É1oL˜úÖ²mÄÅDùõïLÂÙötù„¾KŸ“°{NNÓYm‡,Y¥Í¦åsQ’pº=v›cÐ×®
¹\\)Æßqí;@eå2®ú¿§ÒðP4J8#•RÓü…Æ÷ñ5›ÂzØ»så9Œ:©ùîjEäçå†Æû<žÑ­KKØwŽÛM$£‰èG^\\}O=Þòz‹¢+ZŒDI)
¢$ãË/¨ùáËÏºbö³ûúŸræ„”’à£—\'¤Á¸0 sg(+kÊô—$óûl…’ÔY¼4ÄòU1¾þ6D×.!Ú¶©Ái1ôM@›2‚ \")Í ÕGU’I	[Æé”¹ö–9ü°º®Gbæœr\"åÓi¯îÌ,á7ü<0žÝöÇs@p1pàôï?€Güà¤3Žvëã“ßPÝ.çnÍÖQ´ðÕq:ÅÊU»O<È¿aÉÃárãÉÍµ+§Ç;ºjYåÃl—Î\\,ìsâ©«%Ù‘ÎRmQ…]YÃCGM&‰GÂ¶^sMP^^Ç~‰®i5ìä–AÙ0§L†A¢¥ò«Åf6çŠw%AÖ0ôßXlÝ°_Cß…óJ6{/¢ âó¸qî8Om$*†žjò%´Ñ’;óƒÝåóÒÀˆïžÕÄØuµ·f-
éçÝˆ’$áöùq›lm³\\lU…zuk…©m¾‰žý®·™rï„—&ÔD¢1TM3[==z÷0p^ ˜è²ä»­tîß\'3ó½U”:9í´VÌ}ÿiz:
à²>=»Í›óù—S;·oKÈfNÇ›:3ý°r|ðÊëó8íô=xþ‰‹9ñ´ûÁýX2íÃ¹s*ÊJ¨klÄÐuÜ>½Ž>NÕ5u‚(IA$¸m•¿Ÿã}€Ñ€§¬öÙ¼^È`.K’h·?\0ý7oS0Í3àûÕQf|¸Û½¬ý—aßc‚9¯lXc†Õ6Ó°Æí–ñûœ¬^×Hõ†@ŒOs}Œc¡ ­Užã=÷(å¾ÛO$/¯È,ÁZ.f&»BÊ¸\'šf†°³lPÚÉ½¬š÷¾è$?ÏK®{0cæÎ¹ð\0æÎyý{3 ÿaÌ›ÿY`€Ó!Ïq:iÞÄ†Ç-\0¬hÎQ6ùž™$Þ¿ÿù\0Y2n«);¸ý~rŠŠVº±Zv8LU\"¯—ÇgHæÏø%la“åêÍËÇí÷#×ºZå»þQ02tsß{ŒG_Ö”“ªJ<a0BáðN7‚uþüm¦Îo»Ù5¬Ÿ]ÛüjÍ®µ X-”oDW3@EÑ$¶5ûïúy™„¶º–øÅµ‚í‹‰¾ŸSËWÉ!?«• J.¯on.-›l=óÖ@UÕ‘$‘@(Ý;žÿÜ›3F#Q”d’h<ªš²ËëÅ—_H§n=ÕµKþ;x=LtY¼d³¹È\"jJ£W·ºuý\'ãï»Îžtpïƒ¿˜=oAM47%!ã1”XÔÞ \\´l•ÀSoôÜw\'º–q×ŸÌ­÷¼	ðÈ‰Gòä«SkŠ
GcH²L*iŠ$Sy/Ó»=p$¦S3v¹:™lÈ²U-Ã4Ì¸Úv8ûâs`Ä±—^ÕŒ#|ùÎŒ4·«(äÑ{GÐ¿O\\ž¢Œ
ˆaj Å€Ó…LÄæ@,ˆˆ€šRØº5„¦éø|n4M#läáÇ¦˜ëË­·ÝÏôiÐÿæÍÿ Ÿ®sþXí­Ã‡Ôä÷†±Ýƒ:ÈÿËekQBp6 ûü¤=‰EÓ‚Nr8g8Àü’Ò‡ÉV–­çJ04Ï”ú
·4²Y¦üÞÂÏGÅâqB‘›ëê¤º«Ù®öŽá¼Æ®Î\"kÍ³HË*³EBGŽŒ 8ÍyqûÆ”eDáÇ6R»z^ÆnºVÆ®½îNî¹ü\\Gz1Þ¾h-lBÍªÛçG’ÍŒ<Ìñ±¦IMqŠ”9»)Z•%_^†¡³G÷^ËÖT.îŠ©ÔÕè®ª:ËV6påÍŸðöK9\\qñ?˜ÿÉWÌ˜5·x&ÏïÖ®u+¢ñ„5cœ6‘¸hg‹~Üò„Î«`ÜW3Á^ÌûteàI‡,ëó¸ñ¸\\h)Ó¶4©k$ã±f`|¦ÓÈÞ\0=z€Ó	Ñ(dTJ²Lnn.ÝY½dî]3*d»;ô?õÌ9k~6‹„›q›ò|î¼ù8öÞ³.—“X´µUÛ¨ÞPOíæõs,Ó°6_é´Ø|C&´›æT×Bá&ðú}Ün\'¥%ù”o×œ?îØÃ0ôhæáºXÂ\"—þÁõê–Öa[nVÔu=›!ÿYJ×²(\"I¸Ü‹övðÍ$ü\\ ¶ÁÛ4£L\0Æœi-µ¬Œòã ÜÈM÷|Å‹mütÛ÷Tæ¾ÿ¾@ <òè¾½ëßüà£Ñ¹¹¸~RuêÏ}
è†¶K‚\"²,6cÀšk’°ÛÏî×.&’dµ~Æ=eÚ„6×p:$ÊËüMÞ³®ëéÑ™ïuÉašD8Ün´HS@v:›fS&9LBÓµ´®væ¼í›¼W¯CÕÆ-›FëšF}mMðA ¨tY¶¢žó¯™Ës1ñ©k¨\\º’ªêCûõê1yî‹Gu¬hM47Í*â1tMk\"úñÕ2x`’ÎÕç¿À´gÓ©÷ÁøðóO>¡àºûiÔôíªañp¨I™Úc?¦{}i»vÐ¦™+MÇÄdI¢ /‡Ü¢bº8ru\"Y­&“èš)ìaˆ»ô‘›„#“ˆgn‚|xü98œ.°ÜÐ”xŒh ±	—·Êãö›Žå°ƒ÷ ¼,—ç}ÇI§?A$šü]¾sn·“^=÷¤ËÞí8ûŒÁÔ«gŒìK a=3ÞJKù/E£Äe—vvw†ÜÒzì÷9™¿ðÛô¹ffÉY@þóîXf›\\IÂ6>w9È¢9c˜L¥G£¦_©¸³L¹K®_È»/Ó}ÿ“™ûþz2 ¯×íÆïóâr´l%(:èÚÏZèÓe[CÝå~æ.gƒ†fþìBFh©]‚ÿ%ï}—Ïk‹Ô;[|É,)
;$Á;<Þ´	5£v\\\0óó\\øüyM®QJ5-ZRx²}tåîÂ|k7gÃl]rš“Ã.·Õêqáp»q¸\\Ô×ÖØ3Òg_ÕlŠòÕk¹ç¡÷¸áš¦¿z7þ`xäÀCz}ôÁ§‹&ìÑ®‚pÌýˆÛßƒ3«6ÂÔ9Ðu¯­,¯~›@00û®g&6Ön­#‘HˆDˆùæ£÷ZãR;;îÚH$`\'2I’Èóûñå J2j*igX#2i±›]Z„ô†ErÈ&ÎéLÏó\'ãqbá _½óVŒ[•årÇ¿‡rÔ }(oUÄÂE+9ùŒ\'70H$’,[^ªêì½W[Â‘8oL›Ï=÷M±U¯f_{ßÃ«ƒá‰Dò9£‰þ}wŒ¢3£Z€=Oè¿< ï–û#Áihw9Mk»\\ŸŸ×ƒC–I©*áhË½ãq(«½?ýj=ócÆô¢ûþ]Ò7ž(Šx\\N-éÞä®—OëÖø¯£îByø×¾wã·{ß-,EnÀÑ¼uÃH«ƒÙ`œJ*(‰šªR_[³?p-Àò@*´®“ÉTÊÒ?Öv’½µ¬øäõ8š„DAL{wï˜ýIV_^²2@—Ç‹ÃíaÛúuµ®X\\_[spÿŠµf}PM×}Þâ˜ãÎfü½c8ç¢ÛÒçÐùoÏÿtu,‘°úÉ¦¥#¦	ÅÀM_/¸öA‰oW¦]­&5C¦#Z8ø“`ÜØLfµ¦™`¼ÃFEEÜN\'Þí³íiïr2ÚT»¼ÉÏ¨’!˜Â@j*E2aº‡5ã‡rÌý)--æëÊµñáˆ0å€þGŒR¢QËR2Õ¢Ë/¹/5Õ¼·0ŒíÕ@¤Ë¢/¿çûÖ3cÖ§ƒiyÜ´•®ëæÔÂœ!g8¨åH²ØL/_,FMÿF`lÝš¦¢k&û£—\'ÈÀñ˜ãÝ1Yœo=÷æŒÅáhÌÔÈCÇÐõLYÀ4(¿6k=W\\¼mwÈ¾e²´“s±5’õŸ{ò¦îµ¡ý–ÈÒÖÞ•×ÐÍ9ä]Èñ{ÿúç¦ýžé$´ãÌd‡¶9æâ‘ñþTUE³3³06- #¬ùæ«4øtß¿”»ÿ}8‚à-½h‹\'Ètyú¹%÷]ÅAÓJniÓÃ`óºÕµ®x ¾¶æ@UÕG.û¡‘ÿ<ö-=ö{“³N=‡ùcÒK3=À‹Çôï3dÚ‡s#&É+†šJ\"98=ž±›Ö¬ÚCU‘ß®T6£O»nìÔM[ë¨Û¶•HCýO‚ñ^@±ß.¨ª™%·ÄÌµ=Î]N²ŒÛéÄáp¤&Äç§]Ý0H©*‘XŒÆ@MMñÅÛÓ›”©ï¸q(Çe‚qå·ë|üÃ„Â	€)‡ÿóôQI%Óå&•L¢§Å^~=Àè–.|RIàp¹j6¯[s0¦X¿`0j;wU[k×%#®¼!ÅÑý÷hÞyÖ+µô5Ï’ºþ^Ù±¹p¦5•äÓi¯îo}áºd<¬?pÓù\'Ÿ0¸ðÑ—_‹€byËæ‡CDvÙ/	 (Z¢Ù·])L×uS¥ë9ø®*¿ˆö?T1ÑT•TÒ¼\'¬òo\'\0‡,Òmß›f·É”jŽ¶e€q,dÉÜÒàs@—¼µ?íÚ–ƒgÒË³ì§Xhêÿ~¦ö‚  Ê2N—œ¢bRŠÂæu«Áýï‰ª½WWG¸ø†Å¼5©œñwŸCå’Ò^Õù¹9£*Z•Ò
ÇD‘x(D~I«Qß/Zp¹µ¡]päÙÕÕ74’R„ê¶òõoÿ$·((\0Q43ãdIªfº*%“IÝÀ!Ë¸‡Õv’¤_®#­ë:¢ Í‘¨O^9ƒÀ•Ë=·çÈ{QZZBåÒµ:îÛ$eÊ1]1
LCMM¥7û»+Û3ts3™ˆ“ˆEÉ-.¤‰3\0Ö}ûMw xÈð×ùòòpyý(ÉdZíêW½2Œ´³„Áûïk@ÖTÓÎ1	óÕ»3;ÛÅA=Z3òÄèÞí\0f¾·Â²¶‹Œ(.È¥j‘XŒP$Š/7‡ÛÝLoyÝú\0{„2²(‹Ý(´<xRUÐã45—àG…LRÉd¹ÄŸz¼¹ÒÄ-ÊíÇèúÎÇ’ÉèM	5æ.wç/\'12Î«éèÒîyï¿ä¼~›“‰H„”¢°u}ÕyÀs\0+gŽe`$MU\';»M$ÒºÂ™`üßßIƒO·ýJ¹åšCÐ»™4ùÎýjº¤GE£(Éß/ƒÙáÀã3]È’‰8@$-ú±-îY½Næ¦»çqçØVLŸüozôù—==ðõÌ?y Uq[JÐT—Ç‡–JrØñ#êDYž.;¨É$‰H˜X(ø³Á¸ÀžWßÉª±x‚h$Ì‡“ž¶Ý :þ†—ëH wû¶ù<úŸãè×{oòòòÒ`lõÊ§œxùu£œs†>¥j¨šš&×íîÊžšJâU’ñ)%¦iµ®¨´ª¶÷°©_ý?n;)ì°q²¯×ß“ÿ¶€lšš\"Û.8ãí,æÖëúsÔÀŽŽ0€+.;—½Ï\"yÌQ=?mæ„¯¯Ûìrát{v\0d›\"ì¹ßö§¤j	\\F‹eÆ`Pu+è‰¦¥Ðt¿§¹.u]C´Æf7-i±\\—LÔƒj’eè†nÝøÍ_£¾!Ú¶&åaÍbÛ‹úŽ±e[Œ½ÔúŒ×°lßôÝ÷Þô¼~Á·ØÐí^¡©¾XùÕçi0>æˆ¶Üxy7rAk`ÉÒìC+CÑáH”x<Ö\"÷ìZÆÍWÄÑÛ‚èeÒ«_sîåÓíãÏs÷‚‘(‘Xì\'JÖ¿([¾ÍÞœ<
Zµ¶õ®Ó¢««£|øÉVzëNøÇ©L|êZþ1òf€ûtøü§_›¶¸0/—`8‚$ËèšžnçèšŠ‹V™ÚcYþÑóVU•ÆPÈã¥öa¿eìÙ©ˆç=™{´ÃíÎ¡ri5ƒŽìwcû;gódÙËã±²pKnÕMwðQÿŸÈ8w:[,îð½5¬u)[²þûdÈ©‰h„ï?_ [%6J‹ýü°¦žW¦.åÓ/73î†39ë¬Sï•œsÑm\0ý²<Áírš¢ñ’dK6‰›\" Ö¦ÿ­$Í²¦¦ëÖ8†Ðäæk(ª½i)Tµ\\ØE©ùU»%©šô¿Éd“×hÉÄbÕz@Û”q^IR)³¿ÕÒklÞ‡Ôú&™x2en.„æÇë7†!Yõ›¾÷;/c××«/g©/Y¶pnŒPÁeçîK×}[ƒ¡rî¿žgÆ;KÁì‘.„Âlkl$7ã»qÛµ1¨oœN?“¦,âÜ+?Jƒñ¹ÿ¾mB$\'™J‘PvNêú-C”$n7¾¼|
Ë[“LÄ›¨‚­XæÁg×Ðc¿YÄpÆ\\2Œ‡ž|`¼(
ý\\\'.§“”ª\"Jf]U’(ñ8ÑPÊ]c¹…Œ©¥ruC0¦ü¦§ë>~:wðRVì¤¤È‹ å€è%ÍÜMßÄíÚ¯Ñdän;ACCESSÄ³NéIûv8d‰¯¾^Ë“žJ—©/0Þq3%‰\"’E2LëŸÿ›åßõ½‡EêjZ1•Óô¿&ý}Ù2·Œúyùy4f¿÷-¬àœKÆsÖ™\'Ó¡]±}d3;´Ø˜ÖÜâŽ\\Í¦8F²z{Y37½HuQnâ)Íà»•AÐ·—,ãŠ‚bY¥‰Í5¶lS0’ë3^#ABQPµíúÅÍ\0¹

Š·ŸW<‘°^Coñ5¶5($\"Õ`$›œWJUA\0In>Š³¾6†¡¬øMßûž×ÎŸHpö¬£ª¦ˆG\"D|·p^ŒÖš3ÿ¹Gö+ÑËyWLgÒkßÄ!Wýg|ÝæmõÔmÛF¤±¾0>„}Zátù˜ôêWœ{åÜ4ŸrÕ”T
]7	Dªªþa¥E[\'>§Ðì\'oZ»ÊVë‰ª½W¬òÄKÕÜvå»<xó!Lšü1`¢ïÿüGÁµ÷?Ò¸}?fö7Ñ±`àñÏéú¦T•x,jwEŸÌ^ýØ5Ÿ^áò•f˜K8hªem¾Òvs	K	+SAKÓˆSß¨§ˆDÖU7²¡¦‘Ó/~=Màú#Àxg™óÿúšÛÓ¼U©/UUéµ¬J×Ý*’fÏ‹’Ø”ð§ëzºº¦ÿÁ£Vó±§4¿Ñ,ƒ™‹u0¼}‘ïÐÎìffbJ2e’#tKiG}f`ãæµ·gÈÁH”xÂÉ*3íx³._m»Þr(%–H€aàpºw©kTØP³%ã5\"(É©”šÎzvŒÕ`wM“óŠÄãhšÞâk‚)–,6)\'‡#1âJÒÔßá5C3ß{í†ßô½ÿØy¥gP›•D¶iZ®·¾ˆj2I,ä»…ódàj€}öÈaàa%qX	¢œÏ¹cÞÉãƒÏ{Ç²ÍuõlÛº•À–MMz¤=ö/dÜU=Ô·§ËÇ¯}ÓŒO¾âÿ&ˆ¢€ªj¨š–ã?j1°Ë nŸ¼âRJ‚ºšõ\0#€/ë”ò™neŸNN^šþ_ÁÀÂ[Ÿx¶±®1Ð”Ðö3æŒƒ9Ž¤íPÞ¯ª‰Sµ1ÁÂÅ:Vl£´d=²½™³­32eÃ°‡lå,1Akº@$š$SÑtd™¼\\º÷>:ßž3žrü¿®eë®ÿ‘`ü¿Ÿÿ˜	¦©Ô×Ö€)
´Gû|ÑOÕ†ôZV­iæ÷\"sDKØa,JH¯â™=ç_wÛ«Úãráv;qÊæÄŒªj$’ISÞ8™üC¿‹k@SÊ±¨uEe}mMe$šì‰¦ðûœœ}ê´o[ÌY§Ÿ\0z„·f/´[‰Åˆ%hº–Î,Ü¦´^Zèþóÿ¸éÕö1ëATU%•Rq8¸M¡ÿ*€„¢Q½1ÁÄ77ÒL/2Ca¢qp.7Þœ<û5„R,^bÜø5M^C×u”T
I–ñøýD\\.°lûªkaæ\\XðH\0,h†0G\"Œ_cÅÚ<[ÍÚê@zÝ„ÃÄ	DQlöÞ·Ô¥øü›7=˜üMßû—i«×¼Ì½vƒföªí·µ±ÒÒ®^A;ãê’Ÿë ¬ÄÃ¾{ú).)âÜ+?jÆ§]7vYc(L ¡žÆÍµM2ã®]
¸ñò>¼Nw/¼º¤;2ºnüO€qf	Tv8ñää’_Ú
Õd|×Xýä7Xå²q«ˆ\'t°,2Öç¤$“¤”ÄïÆÛ7Žô}W¹<ü{_®)CÏ¿l”,ËY0þ©Rµ®¡&Ôdz]è¦(H÷ýK@ô4©l¥¬õbGQI‘EÉo3G÷»ÅaéØ=+ÝÐ›|.ö8>¿×‹ÇíÃ OŒD…ÍEI&ÿkõ÷d+#pz¼¶¾òB ûŠU[ÙŸbTUcÜU=ÀUÀ¤—ßã¡\'Þ²|+‰ÅPUÝ>?¹EÅl\\µ]è~ó¶$ß|—^$nm…0¬ØáráË+ S·×­]òõ»	ÅZU§ª&!~Ì„Âf–¦ídA!À<àû@HíR¹<LÆBtk dþ=•J!9xròÈ-*aóº5·b©(UmÄã8ðBc(D2iš«·ôÊÊµéyÙw/¸ùŽuÁH„„•!7{ïuºgs]’o–\'Ó÷þ£çe}¶ÍÊõÕàÎÙQâNš@¢ª¤“½ctÛ7Ÿ«oÿ–I¯}›ã‹o½{Y0!Ø²‰ÿ~øNš¡¿Gû.9so÷)Áí.bÒkß5éÿ¯‚qféÚÔ½ÎG×5N\'þ‚Â©Õß-=8;žÐ‡cY›žzõ5ÁÑxÂÁùÀL»JŸßÇþýŽ]¶`.À\0L¦õo•ÀÂÁg\\0Z”es\0NÕP3¤J¬œ,
‚(¤-Í)=åýÕÀ|;§Pâ1R‰›Ö®ªàÿÙ;ï0©ªûÿ¿nº»³ìÒQ°ƒŒŠ¢ ÅÞ;	k¢ù™hì¦‰ÆÓ¬ÑÄ$Ê×C”¨`/HìDEEØ…•ºËÎìÔÛœ{gf—¥Hs?ÏsŸ-s§{îyŸO{¿áw\05ÕQ†Ò‘»wÊ¢&ÓÄ²K-cÁª²\"®$BH×ŠB4„Kã\'<_ƒ|A†eòä]·_ãoºÁæ¸÷ïO>Ý	‡P×sE:sX~§Y(GiDâ´ÝåÍKÌdÍ!ï~¸”XL¦¿ý%ýô¯ÅõÎGž˜½²y5Ù\\^äD•P4FEM-ûµ`ÞÌ©í‰îgžú³k¦¤39?Ôæ h:±Ê*\0vÂgïÌ<Š’¨ùL`úÙWýÒnÍf±m$	-&^Ý…A£Žµë¦¾º¿¿\0ŸsòO¯žÒšÍ!K’V‰Äâ¸µ]Ùgèˆ)ŸÌš~tÙù‹€Ygüüú­>ƒP|#±}Âþ6ïqâO®˜’ÎæPÃ=º[ò»oèç’d=	<Þ6€¼ßžJ!îl–l¾€eÙ~»S[yÆÊ
…]w®¤nÞgÁ¿N¼íïÿ7/™N³²¹…l*ÈržDzt0ôà®Ô…ªêxäÉ9\\tÕkÛ—ƒ²‰PA4=„‘ËQÕµûÓÀÓs§¿^}Äès[ÂÑélÎã‚_™¾eÀÉN¢¢‚X¢šþ‡>.ŸI6,¿(Nj\',³i¡|U×‹ª[‘x%ŠŸ3v|°pÖÑg€‰ª(èšŠ®iè>Áã¸˜¶iZ~\'ÆŽãa‰—,#—%ŸN3oÖ´b?wm—07_7„ŠDo?-XòJ3¹<BCèØ;eµ!Ï?úÏ]€~ÁýíŸïµeYèÈíRaŠ$#KOÞuûÚôª‡?úß?ó”ñO?7[–$LË¦`˜[¥g[ÝQÁVDÈ¨ª‚\"ËEP×»Ûup4H¼‚hE%ÙdÀ1@Zì®‚PI±sÆ#“^ß’j¥`˜E
º@I\'Z™@E8ôä3\0´Pˆp¼‚h,^â°öTUˆD*+±Œµ½wš‚$MÑÃÂÑ1¿¥JVdŸuH%¯kèá±ª#Æœo»Ž;EQÕ)¡h”H$J4nóš*¯B±8–Q ËY½¦\0ST=D8#‹‹„ÑTUNÉ²X,Âb•	†ÿ<Ûuì)²¬LÑ£QÂÑñh„p(„$IhŠŠ¦©hšN(!žèÂgÿpëºTM‹W,¶ÆçÚ”ï­¬âˆÑçÚŽmM‘eyŠ
£‡#ÈŠRäv\\·˜õ)gC“ixïcøz•‚OêQ×’j%¨p}m{€Ã!¥m¥.P‘Ëç1âÎ$WanztQY¡2hŸ.<2ñ‹6`|Þ/ooÙö·\0Æ›_P/àsÑ#M(ªÙ6žç2bÌù-ª¦#É’ØÄØ6…LšLrË±;ªtIˆªéX†áó†;m‡6EZKÕuô° ÕÃB!MÕeY´yy’í8ÅÊyEó?R‹Òu\\×%W0Èä²¤³9òçÛ¬Ì^ÃS—‘eZ’¿fÊec&ªlÇÅq¿òyýó6V)™ýÊsEPìZáæëãôvTêêæðèSŠ)«ÖL–l./ÒJ¦‰‘ÏáXoOzê%àøò÷ºãº+ÖõQüô˜´ÿ.ÜôëóI$jñ”¹ÿI&M~­\'ðÁÎ<åà\'NšÍH¦Óä£ÓCÞÔY0é$YB×4b‘0‘p˜®¡È2ŽÏçšËHK2žë9MjzõÉ4/m,{=§]˜L„F‚üFð~Šªú7j¸¸£ŽF£TÆèéª&ZwüRþ oéø?=O´iªZÌ‹7EPþ¨÷7ˆÊÒ@Ý\'Ø!ŠM‡èá³ýÂ×qý–#	UUÄû(ªà<ö%]×õòÏE–ä\"¡¢¬ùŽã¿ëú¢ «A(I*åw6â»—>›[ÜL	Îh_ÎQV|E.á¥X¶`ÌªêÚË4YÕØ0:g>Ì™e[3W·¶Š\"8Ûö	Ú.2®ã ¹Ê™‚Í…Xh²XínÚ>=# õá¢+þPã_ÜyßøT&CK*½ñ`ìyk —¢H i¾~îæÏ\'+’&BØž‡çz%¶wI}Û†I!—!›JòÑ”—·ƒÐÖ®ŠÇ¨©©¡¢²
Õ§ÕTß3Þ›©íæ>È_Jr;Ï{-—ÑvD±PÁ0‘ðÄŸnýQytçþ?5>›Ë³:¥ây\"ÌêZÖ&oÔÊ«ŠeI|öà§\"ËÅJc¹H¥Zz<X=rÓ´Èµ«(µÖ¹iècmË¤à{Æ³_yn`\"0 G×(7^s0g¿+‘h‚º¿bÔéÿ
¾üË»îŸ’LgÈùzÞV¡@.•äÃ×^<
8¾¦KŒz\'¨¬ˆòæÛ_®o(úúƒöß…©/ÝFuu/ãxr”‘ÃGqÕu·sÏ½ÜFN®ˆEÑÕ­; {þâîº¶$ã¹‘P]Ó„2L4\"èðƒdkÍôP$*ÈÌÛM2Ñ3+·dE‘ù!*¯XÊïù±£éš¢ˆ¨à,{¨ªÒÁ{Im~7ºxŠ¨>gEÿ=@A×´~ŽçóÓ÷@ã=ç›~÷`Q” (ìâ…ˆB©ÖÒõ<\\Ç¥º¢‚¥Ñ¨è«íÑkÜ»Ï?MÙ\"XÌüÁ5¿~:Džëú×Iió…°@ª³Y°™ø„Û[ïî:’\\YüûÞÇÿ3>oäc£Á8˜gíA¦ª2rŒö-6S›Ç›*
W(,¶ÙÌS·ÙŒÈ®
‡t¢á0a]ßdÊÌÍi¶íÓUÚ6–l3ñî?üSvÊù—}ä#“^+Ib£/rÖ7¾N×+ËÂãU}rMUJ ëß?â(Ý§â9bã¡UÈ¾â®iX¶M2¡¥µ•dkšŒß¼_yjÀq,ËÃqlŒ|.\0ãâüØ­o%7]s0ÇŽÜ…®µ]¨ûx£Îxœd«äøé-›Îæ(ø÷Lð:Á°sŸj~úãaœrÜ¾tíÖ”jqx®hmÄë¶gÐ°¸™E¢p†]úõ ‘¨àÂÿ÷GyüìÏ´)OqÓW€<LQÄº©vò&æ*üðH¶š>áÑZûÖ°`‡ä‡/ïyø™çŸŽ„B¨ªŠëy¬
‡Q4=P­)K¦EÐËòVJ‘‹:X$]¿—ÙößwæÄ\'n-[ü;mó[½†Hú\00óOã³A\"‰ÐrÏîdóöÜgßqÃD–%Bº^ô¦‚¨@ÀV¥…Ú¶p¦ËÂÅÙ6€\\0ŒbˆÛ]ƒÄÃESÝr/œx4R\\¬6Œ”öÏëV9ÞÆE³l§CæÍµéÝ’­Më2Ã´¸é§o	ÊÌÍe20&Qç®;®IçêkÿH2Ù:æ‚ÓNj~è¿“.ÏRé™\\n½aë`N)>˜*þÚ¤(mCÐ’Ï—ä¹%`ümãªUÎJ»µj ¥b§r›ùàÄIã4UÔ?¦Õü|x¨ÀLËœìù–a´ãƒÕrÓÕ‡0ì^TTVQ7o	£Îü/ÉVÑBvÎõãÆæ
Ñ)bZ‚èÇ¶1òù\0hIæ˜÷éRF¾;]»;EÜ,8iÒ™H
Í«3´¤
tïª‹E€<–ÑÊ#¿\"væsæ3iòK\\pÞY8€º9ŸU>î¨Aw?úïº­µ¡Û1<dÏÃ6Œ\\Ë4xgòÄ}×€žíÎ
½ðŒ“\'<ñÂ+c%IÂ´,MoC1WšõZÆi+„k[&ùl#›åÃ×^x›5‹:móÚðµ=pýÎKù\0]çƒv0óÎ‡ÿe#•*[×Å²l
¦I.ŸG×4òéÖ ’»h¦åðé)¼²^çTFˆ¼¯ðRiœtYXYñÕÁ¼cÛ2±ü÷ôåöt€]úV!Éþ¾$\0d[l6³ÄÞ6Æe‹ä˜Ýb”™›Óžyê÷Œ1¤px,ÀÐ \'¨ÑXŸ\'„ KjJrýxò®Ûwñw¶}ýß¿ñ=wñÙ§ñàÄgÇeóyV­nÁò½xÝOg…Bz1j•Éåq]7X‡ß\"‡~¯+·\\wCêI,VÁ¤Wrá/òÁøôË¯ë8ŽŸÖ²±l¿…Ìq±Œ<…LÛ¶¶eË[q]‰{þú<ƒöëCª5Ã‚…-|±`9É¤ØÐ¤Ó²9“ªÊ=ºW‹†ØcÞôß³7ó¿øšDUœC÷Às3Ô7S•†ï\\uòFšëº˜…9Q8 \"
zrð^<ôÀì³÷Þ WrïýÿåæÛî\'™lsÎIÇ}øØäïÌäò¨ª¶Q+…çy‚P\"•¤nê«ƒ€!]ºtá”SN¡ÿþì²Ë.tëÖ­B7§{\\_OCƒp“É$uuÂAž>}:}ÕáíAûšXÌATqÏxpâ³\\O„¤-Û¦º²MQ°m‹/>xg&~kÕo­æ·V/ó0³¥µ•|ADR”ÄV\'à¬([ÚÅ<ûÆ‚±‘Ëaä²4|2§XÓ­6ÂØÓûƒÁsK½Õù‚¹Hnv4Ï¸<ÜDØ[£_Ÿ=jUºvÑô€K.ÛLt˜
åä\"nÛŽ6³†åéªv?‹ÿW:\0M¥|àü×ô¾=FqW_w\'ÉdŽÿû¿{4pêæ|2hÌ‰ÇúË¿ž¬¿ÖLHEÀ
T=O|Ð:5ù¯wäÏý¾ç[ÕÑÀ%$‰AþÜ¡ë‚7\\’
‘¨®†^½ GèÙjkù›ß\0ŒHTTÒ5r…/þã^•¶Ýumv†B!í> 2bH~÷«ƒùÞ~=}ì>ä¢«gçM8õg×Œ©,ñ}{/((+õW¨ª‚$A—ê(WÿúÉž0=ºWÑÏÞwÔþ:xÎýÁôí£2yòs$“i€Yxð‘–L.‡euòÆ²ã`æsHÄÀ€nÝœrÒ¡„t•é3çpÀ ¹òçÓ¯ßnœ~Ö\0N‹„ÃwÆ£mã–Ïó°ŒÙT :Ø,^¼˜ÝvÛîÝ»sÈ!‡î€1«Ó6¿\0]WWGCCuuuP^Âù\0Ÿ}zŸ¾˜L~pâ³væ®éÖÝ~æ/Ð—Z–ê¸ô¼_Þd‹ü–èuÖéJ[¾²@kK©×9“Ë–2ËþFóªŒ}Ç6ªwß2’½÷Þ<“dK“™\\ŽL>¿Ùz(·)0n»¡&ÀJ&…þ»E8dPƒVái;öé2Á“t$T<IñAXA’}:M)`óR‘PŠÀ-Î•Š¯ƒTN»©°O¶$\\Bª`8€D._Àq…lç=y€›n¼‚D¢XoPí¿È@,ù¿{ž‡e»xž¨{xñ÷!û3;à¾ÀÀ Ib ,ÓOU¤ë ( ªˆUUŠ\"Ž^½`¿ý`Ï=¡O¨*¾äÐ®#IÏÿí.ÕNXß%;ñÈ>Ü{ë¡ì²s¤0>ù!]ýfððµ§þìš;u]CBò>6-džç•w?i n]+¨©ióug¬ãcôú._‘\"Ö±m‡AûíÂ‚E+ùø“Iüöö§‚ó&­NµR0ÍoœÇïäv‹FÐÜ¨Ýº&øô³Å\\>k¯¾þ!‰D}ð\"§z4ýúö¡¾¡qèÙÇ¹Ë}ÿzr‘¬¨·`ø“¥=¡„ëº¼ÿþûÔÔÔ°Ûn»Ñ§OŸN´Ü–H$1b#FŒhóÿ\0¤gÌ˜ÁôéÓ©¯¯\0ú2 uñÙ§Ï&“ïylBÓŒŸ·juË°Õ­­eb’_Å-*×eEAGP®†g²Ÿ•áñg‹â³š“©bycÁ¸¼]¤[M„[u8gœ¸;HQêê>æ¢ŸÞ<}f2!“Ý<ªQÛ¨gÜÆ/µX¼,É»åé¿{š^ÝW¡ij[\0•ä\"—€Óÿtåžt±38G*{öž¶ÔÎc.=GB&Õš#5Ð5•|ÁB×uN?åPUq’©}wêB¹ä¨å·–•‡§ƒz\0Ï
Z/?tÿîÀ©Ài´#BÙ×_ü†£ük Š¼	è:hš\0_]oÄ8+ŠÐ¡îÝ[xÇm6AÍ¤ïèÛ;Ì÷ö­¤g·_¯€TÚòÇD>Ž>i\'.>g´Pðxè‰øÉõEÆÃŸú³kÆëºØì4¶íû¹…rØšÞêÞý{€\\J1ñóëF4-_ÆÊ†Ed’-~ô²ÄÖ¼´ñ(àõú†UÔ7¬bÁÂŒl*ùBÑûžpÑon¹3åk’›€¼	^QÇ¿(AUd¿nbÆÌ}ï)Í£=ÍMã® _ßÞAÎ Ÿãº‹6ý}ók<–N§™3gûí·_\' oe4hƒâ‚.(ôôéÓ™<y2Ó§O¯Nò[¯<oÌÀ¤Ç&¿ø´e‚€l>O*!Ë‘Íåñ<Åïa¯èRËòE_Í®XÐcACŽ—g¥\'§·¤ZEëÈÜàëã]£ÜtÍÁœqün„\"5Ô}¼Q§\'é+]wÇ_îlÍˆ¢ ÛÙ4@ÞÀx&0ü«Åª*¾ëœÏò¼üfUÚž¤öñäöæoø7kékîøyŽ³¦8Â²eÍ\\{Õ™ì±[/<w5õõÅhJ½i
…3×{×—°|õÿ¨N\0..áJàXà`¡kÍ?t¢,º^ãà(cY.’$@¸KˆøT–e²²eóxX°i¨ˆ©ì»gœ`¯]«ˆWT‚yÃÁv,Ë%[Èðûû>æŽ¿\\ãÓ.»v¼¦©%ÏØq:¬±ðÖÒ10ôÐÝ@-¥öß“†Š
@\"[)ÀÝŠcF.‹¢jSV.^t´A¶|E²ª,ú5éÔŸ]sgÞî¶/ôÒÉe½B×AÃöí¿+us’HTpþ¹§€gRßPº	
†ëØlÔÐû²}öZxO?ÿüsæÍ›Ç!CP:Bì´­ÐW^y%Éd’I“&1yòd&MšÔø!ðÃóN=1ißûŸ—^kÊW¤s9ZZ[iIµ\"I²Ø[&†{ú³wfžå/TƒÀ8ýòëÆµf³~¨Ñi†”ËHü6mlÛÆðçS!›iÆÝ¢Üzý!œ|ÌnÔÔÔR÷ñ×Œ:ýÑb»ÈOnº}l&›Ã°,²ùB±°gGõŒ/½åã¸ñ—GfrîvUDùüKpÎFkÜu÷£Ô7,˜õ»üß¢L.G2“Á(pl‹×ýçA>€‰_ ZW¾:òYU!jÄíX’ÀuÅ!\\ñ\0[ärÏCÙÚfÛNà!‹\\®\"Ñðuž†¥BÐc×bôê\'R$…pX§º*Ä}ÏçÅ7K`|ùµãuUC’Ä:½v0¸Úþ?ÑØ§o$9^üß.½{D0,‹á°ØÜ”¸¹,…lšÊÚ®SlÓœR?¯.Û­;ìôï·D+*±m›¼a K¢­uk©®í€,I‚_Q•`ç|j}Ã
jºTÐ¯o7~ëyzÈPªª»rÏ}ã‹7ÁŸÆ?¾(ÙÚŠcÙ°q¼Þ~Ï¯¾úŠE‹±ûî»w\"á6æ¾à‚¸à‚¨¯¯gÒ¤IÜ{ï½Ô××õ½‘ýà„cÞ\0n~òå×TÆcTWVR‹	²U°’tìÉO;Žý´¢t¬qLÓ$ãp¹‡¨Î„tA¡¨(¢7;›Ïcš&Žmñþ‹ÏÁ¸g÷·ýâN<²/ÝºÕP÷ñbFùTŒÇ\\{ÃØ‚/U´‹lì‚²=€1@M¢ŠÃN}ØÛ“žD1ÿºM›¼¾°~{ð%jŸ™Åç_Aêždkš•«[hjjæ•ñ=8ÛÚÄˆ‡\"¤·Be\0ö ·÷†\0²†Qáàa¥ß{ô€•+Ås5Mä‚ô€ë]&3+–¯*ÐÔ\"\0{Î§­Ä£
á°F(¤ÒeâQÖŒEÝ\'«AðÀŸròO¯žð?ØŽÛa+ h)uqmÇ´ðÚEúôJ€Ò¶^-¤ëÄ£Qª++I¥3Å¹ì8áx«P…QÈc]zõ¶eY™¦…Bh¡²¬øjT.ŽŸBð:yãMVdôH=£¦WŸ;›—6ž™Éä‡ÌùxûîÝ—Þ=»P•ˆsËmðÛ[(ÞÙ|žT&‹m[‹ÇëòB¡@¡,ìÓiÛ®õë×+¯¼’+¯¼’éÓ§sï½÷–{Íg~ÿø£Ÿn~ê•)*cQ•ÔV\'øzÅ*ZZZ0y<ÏCQÔâMnù¡/×±ÅÂ\"I¢§]Ìoš¢àzŠ,ãyo>õ¯\"÷îã¿:ˆ£ŽèC·nµÔ}¼”Qg>YìÝ<óŠ_Œ0-»m»ÈF,(ÛÔTUQÝ£ƒŽ<®®Iã–U±o+ºÀå-k–aà‡LoinnÒÜÜ
¢rÜE¿¹åé/ê3ù¯wžW–Ž#8\"à±îƒo¤Ý!…Bm½`Ï+°ã€m—@7\0ØµÍ|^<Ï²Š{åÑúh$ÂàOúýŸ}GD\'J‘˜d«tH7¹8æø‹/Ÿ§ú‘Â@©C0v…´¦e0
9<Ï¥yiã5øÝêR¯Œûº`øÒ‰e©Á6çS(ë‚FØsÿ>YVUYVü{¯#‚¨N@þ¦€,@ŽVTÐÚ´àà©d23 “ÉûsJ+ã³îylÂÓËW5“Îfql«:­ÅaõõõÜ|óÍ<òÈ#‘\0˜GwÔÓÀÍ_™² Ke%=jkXÑÔÌª–$élÃ÷VƒF€\\ÒšrAŽìh`H¿*øëïåðÁ=©¨¬¡nÞò6`|ÆÏ¯«©
àm²üßöÆ\0‰Š
véÓ#—ÅÌçýâŸ\\H}Ö*ŠŒS\"-˜„çèykÈ®àG7yÌ|ŽD·îS€)_Ì~7ðêgsá¥öÿýîÆ6@Ü‹(ÌêâƒpÔã(€XÓ„G,Z^LS\0®ã”<ÞÍ.²$‹„‰\'ªÙý{ƒ[ð¿÷ÛG\'±&±H0óèó/i
˜ðÞyo-aê ¨Í`ärÔÏ›Sd8;ãäý¸è‡‡ù!÷\\ñy™\\¾È}Ý6z*!)Š`áÓJ ¿¶MÛÖöØaBÖz(B8G’ejzõ™×¼´q%~Y¾iÚm–ŠG\'½ðt:—ÃrDÞÀs\\¼µzº¥ç©Š‚ªø\\ÐªŠcÛêîvÚŽå5?üðÃÜtÓMk\0óÙÇ5¸jâ«oØÕ•Ô¶$YÕ’du2U­p| 3óbQ~ç¹ÿ¼¾¾÷Ýs×
ž¸$ßÛ¿Èæ|²’QgNlÆAÏêwŒEˆR£º²‚ÊD‚B8Â7qÃ$pXÐ¦†4O©È²à7°mÓÄ0-_`ÃÛà÷ò\\A!iûZÑ–aàØ6Ÿpj¬(¼÷ü3G½öðW¡én~œúÄv ÷ào%ð„º}k\0Ü‘ã‡©HT“èÖƒ}‡ª³Œ¶iú
wš¬((ª†
ŠFEú&GÑ4$IZ«Ôd¦vl»Ø1“Ï¤™7sê¿1!]eôiƒ¸òÒ#¨­­7ÏE?½7xú¬T:Ck&»AíJÛJeÇdYFÑ4ôH=ÆÈçÚ<n´Û5â
®ëúZÀk+€‘[—o±†iÑµºÃ´H¥3´„Â üÝæË€#Ï>öÈñÏO›yg,¡\"&T±V­N
Å˜‚YÈc‚¸¸	àˆÁÕôê¢[m„ê*]YH
x¦)qéy»Ñ§W<I£nÎF}ÿ¥\"«ÑwŒƒE5ØÛš[$Í%Yˆ?°WuôÉ<×kC1ªÈ2ÑH˜x4J<!£*
¦e‘ÉåhÍdÉäòcƒ×<ÙC
˜´dÁ-m™oOz*Žèsÿ!>ÐþQ¤*áJDW<gIjÄo©H¤$Òuºv©&ÓÚX\"kiÄbÊÀ+ŠŠ¢khzU×Q5nYähÍ0µ…™Ï“Ï¤ÉgÒÌ™öÚ¿1áÊ?9œïŸq ƒöÛð¸èÒûyäßoƒÈM_šÊdHgsß¨ß¿¿ÍÉ¢(¨šÐ-mÈÑH¨¬—t]C5”âYû”vÚ</‹Fè^ÓE‘I¥3¬Z¹=¡Ó¾[À|ÅWpÕUW1}úôÀ\'v$pã¤7fÌŽGâŠ¦fš“)ò9!ç÷«<³.	ö©à€}ªÙs—8z(Dk²9Ç‘Y¶\"Ãg–sæÅoJw‚ñÚ\"X²,¡©*a]/*“©>eiGªO®çaY†iQ07¹í:<ö‡›ËS	‹€Yÿxò™©L–®ûêG.ÃÜ\0Ü+Ž¯c^²ÁÛ“ŸºøQ½;ÑÏTí{Å>WùG‘;.zuŽ³EA¸ý&H×T*bÂó-WÂ
6?E¡ðå¥µnŠ%;ÓŠk–aÏfÚ‚qXåWç¬S²Ï€¾$S£N¹ƒº0üÓ[þ8/•êP›‹§7Ãd‘e¥b°ÊŠH›¯ª*ªP_bÝ9ƒBn5x¥ÉàýöÙî”™güüz;‹u\"ÕwÌÄ´iÓ˜4iW]uõõõÇÇŸväðÛ^~óíq‘Pˆh8L4&›/jZ¹†Å\'_døôË,Óßi¡oï±˜Ž‡‚¦JTV„Éà†?~H:kL8íòk;Á¸ÌlÇÁ0MLÓÄs=Á©,IhŠ²NÕ\'×uý–EVxæ/·ïK[f¶Àò?ùþw>þÜKã4U,KÎ­šÔóÃÆ®ïñY†ˆ¼õÌúøïqþX^„èeŠù@\\åsÂ÷eô#[9·)BÖ%5)MÂ‘pˆ¦ù¡’øN„wý¿ëzk¤ƒ®€t6KÒºÇï>÷ßbAc$¬ñ›kFòý3²k¿^>ÿ%\0ãw€KÎýÅó2¹Žãb˜&ÎfæpïäMCå—­?¬ìp”öØç¦½µ„H¢&øs80µÝ)Ÿ=ó—?Þû°#æuBÔwÓN;í4FŒÁÍ7ßÌ=÷ÜpÃñGv pãsSßœ„±‡d²…tK3\"‚¡s>+‘å×}šö7ŠÂÛSU]WYÙ”\'—·&œð“ŸÕÔN0.÷rsùÙLš×ùÇ¦ª>]Dúí”àü±Ã@
Ó°$Å#O¼n8÷”ø×ó/s\\—L.G:—ÃÆY§Wl›&¦‘ÇÈçxïùg®®zF€s€ƒüq¬ðA88*ýÿk”‹ní(DÛï˜/äó9,[÷¥4(¦ŠrŒEm¯Mµ¶_4çy¨ŠAÁ0ð<—7\'–ºúôªäÊÿ7”³NÙ—vêN*ÕÊÈSdÎ¼\">ëÊ_6š¾.}@.²¥Š²Ê%\';y³®Œ¬¬9/NYÄØC÷-Ñìù$ñx.ÓgÍ\0<ŽÅ;å¿Ã–H$¸ûî»9õÔS¹ðÂ‹Þò)£Ž¸ö•YïÜ)K†ea	’…K§’­ö€|ù	G_ð“±A®Œ}ïØ¶YÝÚ€ñ&«>]ðƒŒÿË$­;(ÕHJÎ?o4#ý1À?<ùøÉN|vv<EUZÖhî$eí:ùo?ûdø\'~…ð>ˆêéjß+N ª¨kÊþ×Æ+Þ†€¸Æ†ÁŠæÕ¼òÐ_7Df¶H­ãñ$%ùT€ßCúî”àÞßËa‡ìNMM‚T²•§üƒ¹Ÿ,/‚ñ™Wü¢Qhb»Å{A’%TÚÖóxxkl
6´%_mKWµN@þV\0Y‘ÑtöÝÂŸ~±š¹ó¾ä\'‡!…\"©ÝñPÄeF®:`hG`Þiß=1b}ôQ¹·|ÇqC‡\\ò¯ç_ÎæKæ½þè?÷gÃ4³ëFŒ¹ Eñ½Ž€Ñè»Æ ÂÍM-IðUŸöÛ+Îîý¢tïªÓ­&Š¤T€edÀñ…ì}ßS’¹ââÁ ‡¸ú×©›×ÈÝºšGæÊËÏåžû85¤ë³C!YVÚ€ž‡ã88–‰™ÏSÈeyï…gþ	#Ô!
¸ªüñ¬õ Wì3m·‰ÜmKæºélŽ§ïýã­Àð”áßô=öØµ†Gî?…ƒõEÑãÌùx1§Ÿ÷Kš‹`|öU¿lTU\\?×EVUTUASÄOE…}âúø­‡n©çY\\³v <Ö`Ï·Áæy(o~öÅN$A´è‘(Ð¼Æc?ù9uŸ¬äÄ‘Ÿ1êÐ
Ðº‚\\	JQ¥Ëè$þè´¶ÞòðáÃ¹ðÂI&“c€~?<ùøKž~mê¼ªxœh¼Â^Ù¸xZ¦¥³PÀuQ¡((š¨LEc„£±5˜„¾©¦òŽÆ ˆP
¹,ÁÆFQ$âQ…»UpÈÕX‹§õ9â{5\"ìIª³w2äò‘ˆï“J÷þýîyà%\0Nÿþ/X42§ž84\0äa®ÏTèj—BÔ¢ ÉÈç(d³Ì~å¹k€;\0z ˆ=‚\\q5¢Ï¸›?®A®XÙF½â¶› ›–T+â0N;¦{îe]¢ìÖ7ZwPE¿îãzRiÿÃ»ŠÿR­êæ.è9Ä\"*÷ýáDvé[’ÎGsëuÚC¤WûËÀ%g]ùËÆ %Íq<@×Dj8¤ûTE)]§2P@W*óvÛ€qû^v?nùÔš‰eÛL¸ã¶Ý\'Üq[*I3=Ï›Ý	È›
ÈŠJ$^A(… Ç÷ÉÊ`{ÄœOšxròWTÄT¢‰hDAS‹nV{µ§Në´ÓN;Aƒqúé§SWW7xÿÌcFûÒ›o=][]Åü…,X¼„Lk
«P(I²‚¢ªþ¡¡¨%!w#Ãm;8îšò‹—X¼lï~”¤ÿîÍôêÞˆ¦‰°¢$û
M’B&k±¢ÉÀ0\\âñ±¨NUe˜eË’åðƒg7áy¥\\®`ñ‡`oGbQÈføhÊËE‹ƒ­L1ß®õº»ÌQD®XÙÆ¸èxØ-­ið‹ßZRó¿ÊjìÜÛåð‘
@ÒA’qÈ~€Œ\'qMlŒäà[{xn¼Ã¢P‘ÇTkŽ9Ÿ.áÔ>€ñ„S~vÍX]U‘$|9SKIJðôC­¦Ä!ßÞêÇýåï‹\\×÷QÙXyàµyÆrÙã²,ÔÞÇáñ?ÞÒ&Ñ.œýp©çy€¼±€¬iD+*©ìÚ¥_}!r|)£MŽ/Ù*øßÚÙgÀ¥ùLºs;më×¯}ô^xaÐ·üßŽ8üÚ)ï¼g<¥{m/[ÁªÕ-ä|O¹‹P»Â‘N0.w\\$Aá«>-hÈ£úÈ6çSxyzª*·ýÜEICÇñÚüo¿þµ|oÿŒ>u/V·üé¦cÀZÂcO
ž=³5›%oX~ß­„¨³Þ{á™>þ\"}|Ay¹·ºWÜËã¢ÅI-Ô·y0ãæœìuÀ LN¶M§™w>Lòüë+¨­Y„ªª¨ªè»–eM×Ð5Áß®i*ª¦ È
®¹¼KÁpÛ¢®QY\"ÕZàªq¯“Î®ö“zõØ®áyË0ó9ÌBO>Ö¦r}mvëÏÿßú¾Ú,ÀYÇãõ@CÙßÇ\'ªbœvÊpúöÛ‰T2Ç#O&™l=É¿uëä4YQ	ÇâTÖteïÃŽ˜÷éÛonhŽoæ¡\'Ÿi/úø£ÎAì´µÚÃ?ÌÀ¹êª«\0î8jÈà§¾7{¬˜Ð‰„tV®n)²{m®JÑŒATô†\"Qö<xÈ¸/>xçÈLÖÞ$Õ§Ï¾\\çÁ^{ÔrØÁ;‘jÍóàÃ“yäß³@ô»>šL¥‹Ô¨¶i‰Ìt+³_ynwà1`H¥;ûãZô.ã
Ú†¨¥íl.‡t=\0°A~ÜÚæ±Wß\\µÆùqMU|o”vLP™ªÊ0!]!ÕÐT‰>^I6\'úîOüÉcCºŽ„D.Ÿ+’†¼3yb±\"»²\"Äû\"µ®K°Vß°œúÅ+Ö÷µ†®çñ5ráýúvgêk¡_¿Ý|RŸ07Ýô+F9šº9ó†H’t«çyã:y£\0YFGˆIª¦qÀQÇÛf>7ÍöÃ\"žç¡¨*ªæSÂE¢„ã¨šFËŠek•_ì´NìÊ+¯¤_¿~Å¼ò¨CbÆŽUE½+šV“Îå6(ïÈ` ª*‰ªJ*ªkØuà÷[8çƒØxÕ§\'šVç{Îž³‚¯—g™ÿe3wÿc6K’Áã—ÿä·¿_Ì¤I¥Ó¾WœkMñák/Ç´Aô´/õðÁ¸ÌqÉÇö¢^#’¨(TÅctÜÉ—Ï~åù\0È­ë9éŒ¬›¬cÅªlGÿžpìE—ŽUý0u6Ÿ\'Ÿi%“L¶QBÛµ_-½˜îrÂGðüèG@\'*ù`’?³=Iäº§ÏüˆR•—R9G}Ã×44,mãD?b»ìÜƒ‡{ŽÇþõ2çŸ{&\\pwßu+#<ü<{\' oLøK’Q5Yª áX\\ÐÁ¹ž_ ùÚµ‚«UEÑt_9ÄíÀNÛ ;í´Óè×¯#GŽ$™LŽ~ðý€ÑÏM}³Q–dÁ*ÕÄ&ƒòŽÆ\0šªÌš$I\"Z™¨³McƒTŸ\\×Å6ÌB³§©qñ`àŸÃ>~Ñâ$‹ø`üè«~5>“ËaÛ­­­äÓ)2É$My©8¦{\0‡ûpÂ÷ˆw*ã _,o‡@\\dY¦2£²¦–Ý¿7øòB6ƒc•¨‡%Y)©%ùÜÔË}µ¾R¢¨\'™£Î¹h¶¬¨¸žG6—#ŸN“Mµðþ‹“Š`¼Sïjî¸íúîÔUÌX·\0^+Ù¼ASs†|¡”R=\"¤«DÂat]EÕtTUfÄá}ÊàÐnIÅóÿ>tOðÒé<áŽ®«˜¦Í¢†¥\\tñ-\0LŸñƒíÏˆáƒ7Ôëþî²¸1Kýi‘pˆ¸¡2§ª\"^BñU]|f™²%ŠÜ¸¥pK6ŸGÑôN¤é´¶€áëÂ/Š½ž:eÔ£ŸŸ6³± ›\0Êß0¼µŠX”heŠ¢wl\\ÛÙ Õ\'×sqL£ÇÈf©èRÛhò\'4~ñÙAˆTU˜9âçO	Ç+(˜¦˜0
dSI2É>šòrqLwõWß
D_qo\\{·ÓíŒÅ˜ËÄcQªk»‘íÂÌp,!,áºnÑËô\\_ÏØu©èR[·Æ-+ŠeùYU×ÑÃB (¯@Ñ4ð<ÌB#Ÿ%›JòÁK“÷Eäé‡ôî™à÷¿=öß™ªÊSgÌáß? %•#Î“Í˜–ƒëzhšFMME’QTEQPdÑÕ(LÖÖT‰„QUY´N©ªŸWp‡¦æVò9“ªªÕ‰8±X˜ªDe»ïUÀó6­ãf“YU”¢”Ö6>Š¿UÆcxžG—ªJºué²AÏ.’×û”›®ç‘JgH­Zªw‚r§}sP9rd”O9lôÓg6ŠíŸMÐšÍõ”;ÁxÍûQ×4¢á’Ï€¢Ääyàú*Lf!‘ËaòT÷è9[’•Ùš®ŠÆ<·()B¦-|4åå£€ç€È.ˆêˆÆ}€]}ï¸ºÝ˜JÛù¼•%™H(L·šj2éî„½€x#ðŠ½\"IŠØ¹m¤+ÛœçŸ+ùtœŠ*´TMG’elË,ÏÓçqïž	î¸íŽ8l7ºu­bú¬/9ýœ¿’ÉßÚwWU…x¼Ä=Ó§w-ûíÓÿwñ‰¼?ûs®»òLí×ƒéÓ‹dŽ³¶
 WÆcÛqø¦hßhçïµÝ]¹íÔBÖe-É;µ{-ÛméÚ†¢(„t¦¡ûGº2Ç’¥ËE;¹¬;í›Y\"‘X”O!@ÙóD¿±ë	ªFË^?%àw	ŒK‘/!	(Éò7þÜL ê÷|ŠEÅÇYUÅZa(d2d’«©›újQ>³p(\"]‹(äÚÍÿè«‹´ÌYYâñH„X¼]|Ö‚ðF)Ê+ŠCÌßòµ:ˆ@–ú½R4£¬·Û¶m£€™-Ï¤Û€ñÁßÛ™›u‡ÔDU3ßýŠ3~Xã	À—|ô*Ö“ëö¯ZÛƒ¶íL–Ú[3¾Þ©OWN>aZ(Ìûü‹~|kpÊôoƒPN=¢Í )x w÷n¢Ý¶Ú…y¿ÙÕÑz#èP¥bs¶‡`Ä1-Û?,Á³ýãOØoP¾ø÷¡÷¾™æèÌ‹o¼mÜÂxE\'ÂtÚfåç¦½Ùèº®O’Íå‹ÈN0Þ\\`.„ë%YÔ”<ì’¹®ƒm˜ä³i2-«™3íµ}}Ï˜Àþˆã®þXîî{Æ](1oíHc*ûR’¶#úq%]\'¤kDBaBº†ªª‚\\¸Óôüý¾µoÏ¥`š´¦³FÇ²øàåÉmÀøÖ_ÇÐ!»Fy}Ú|Î>ÿÁb{ÔAÇž<Ö(ä0óù¢ö´ç:kh/·uôr‡û›×qYQÿUy¯óÅ¶íŒ™ý¿/hüz‹—¬àå×ÞçÓÏ“Éä^Þ˜
ëäk¬oå-Ë€7œ¼™ªŠ8º¦a˜¦ŸGØ¼7M@^.(ÑDØ9Ð(MgsERÛßÝ”iå6uúÆþ ©ü_Ã7ÓGþà-7pÀ‘Ç£Ó:m3ò)#8fÒ32¶ãà¸\"?—Ë:Üxv‚ñ¦¯1HmE=Ï}Æk‚ñû@d\'DqÌÓ~À¾gÈ(*;è˜Z–MKk+“ÿzgGd3o¸÷;IËå›Ÿvãqó½kÇu‹¢³ž™p&ð89ì]¸õ×ÇqØÁýEâ<ò¯i\\tùSÁKN8òÜum›ˆ]‰mš%æ tî•Båm>‡6/©4¹pÇ!VUÕbäóÓ¬BÇ¶¦5/ml~´|EKdùŠ–ò1˜\0\\²±ã«®Œï\0ØßÞŒ:b?ê\'™ôÂ»=zÚ»¿ùåÏßÒs¢nüÓ“[²ù-­­4·¤hN¥Èå\"Ñ¯ôÂEËyÿý÷™úêýHRL¸Þn¼ž›óymÏò·j&¢ÄÝ×ò—@‰#ÉqB éŒ<áZ€‚v³Ó:m³ò?kUc]×ÁvŸC×%_0Ú°uu‚ñæ·\0Œ-C°oµã>ÀíÆ4\0ãò0õŽ8¦®¯võÈí7ÙÈÚÛmW\\º®—hð£¬ë\\ß)	RÜpäð=ùóÍ\'±ßÞ=QÔ0<1½Œo;éÒ«Æ‘n úäsN^.	KxmsÚÌ!é8X–‰éS£²¢•U—/™ÿÉ½”TÆ³<Ï[°)c¼6@>*\0ã«~v4Wÿì(z÷êJõK²œñƒßR7wÁÖ”#Ü\"ö£3OðÌëSÇVÅcÄ\"EfåêÒª†
uøœßßñ4?:ÿHN:v Èà9àfÁ+n[ÏÆó,$×ÏÄó$ÏÂse¿È:„¤Ô€Zƒ$Eð¤¢ÒÇP¶ù‚¶NÛ@ùÙgŸå€ ™LŽvà ÞœýÑXËv°,Û±q]‚i¶‘ùëãÍÈ®ëeÉ$W3gÚkA›M¤7%ˆ®¾g¼»?¦;j˜ºÜlÇáò~¿Éôí¡\"¦‹(Hr”éï|½¾—èëëŒ:–ÿqýGqÕ¥‡Ð½kW$þïñ7ùñƒ‡|êÏ®¯ëš¿aðpüÖÔoZd,Ë2Š¯ó¬i*Š,#K2Ž+R¤¹B¡Xñmä0\'ºõX0wÆ”›sŒÕuÊ»u\'¬k¼6õS¦Î˜È™§ç´SŽâ®?]Æ-¿{Dxb(Ä±Æ8ë›ýüÓi³CÓ;PlQ©û¸‘d*3æŒ£GñÊ¬wÆ†C!¿ò9™j%‹#«k~­T*Ç]yŽ_~ŸwªA×$
Û²\0[äp<<Ï³‘?ñºv‘Ùg÷0ûì¢k—*Ðz_Û\'¹ï´NÛ$ë×¯_ÑSN&“cŽ8è€§½7ûNË¶1mÛvpZ]
†Ñ	ÆßŠè`[F.G6•¤nê«qŒ$aê0¢€«¯ïWÀ„ ‡¿\'!Q8d`%‡PÍ¡ß«fÐ>Ýñô¾D IÒI‡/][¿¸™úÆ”ðVåÀ¡ñGMRÀs©›û¥à¯ö,úïÕ›ÓOÜMpÏÓ¹ú7ÏÁøÇãnÖu\\ÏÃ²-,ËOñø¡g‘ÃöÊÚYË<_Ox¿n‘gBBU\"á±H„h$Œ®iH@Á4Éäò´f²¤³!ôp”H¼Ç±7û¯‡Ä¢:s?iäž¿¿N>oñÄÄÙL}1Æˆ#3â¥Û|I3Yx˜n^¦@òœ¶€x^Y5¶ç áúÀì.žëøE\\`!¹Èaã Ô0çÓ#Oü5ÉTfÌqC‡ðÆ»ŒZ‘ÒÙ­ÍMTÖteÕâú™Àðº¹Û|±é3?ÙÜc8+×šê\\Í:m³Ø Aƒxøá‡9ýôÓîyÈAÉ)ï¼?Þ´,Ã¤`š
…N0þ<cÇ²1ó9r©$™–Õà÷¼Æ}}0®A„§÷h7¦Êw`L}ë¢7Úðu†¥Ë©û4Íû¦Ù·3µ]Âhšà®‡Bè!=¤¡*2}»kôë¡ø\0­€¬á¡,ÈD%	Fú=Ò“lÎ\"g¸,[‘&3¸ú†WxüÉŠ`|çÃÿ¯ùµK¹|¼aåI_.Utƒ¶¬òëíy˜–a˜–‰i‰Ô£¿ÿ­J‰6¹îþ?ÕbÛ©t†®¡©
­Š‚¥ëßJ«ïz«¬³9ƒ|¾t!>üh>C¾We[>©D&“cùŠ4ù‚UÈ®\0Û\0}p¬.nÛsŠÿŠV<lÛ\"—³ql‹šj}÷Š©Ú›ûîÃ´—îbä	×L¥ÇyèÁL}oöX\0Ã4iiMcòx®;náœAP˜ý–æè,¶Qq	/Ðh-;ŠíÛIˆ=Pc‘ý>ÅàP¥Xñœ·#Ùi§ÆÃ?Ì…^pßQC¿÷òÌ·çå
R™,«[’¹l\'oÖ{ÅÆ2òäÒ)Ò-Í|1ûÝ[1ªÆQßÞÉÓ]v 1õÊÜ&Å²À0ÄÑî¾rDál=@ÁphøZ`44xmf3±¨J÷ÚáŠ¢v,EîUÑ5…n]£(r‰¤CõÏq\\0MÏ“Ðu…X,L¯žU<ùì<^xõœâç>üÌóOÛŽ#Z-!‹)Õ™D¡žÊíZdƒ\"2Ïó0LK”y.îø] T1Œ²ö§ËÆŽ~¸êO=³@ó#¯–¯øå~,käz`x¡`Aôß£-©;õ®&U¸ÿ¡7ycÆ|,K,ð¦iQ(XØŽK;åçö¿´ù]ZËÿË˜–ƒaØx@$¤pÎé_ð«Ë2pÀQL{éFžp-ÉTzÌ¨Cbê{³Çº®‹aYX¶-TFB¡q¹Ö–iø¬0²ÏüMo!YQÐB!B‘(‘ŠJb‰jB‘(©U+©ŸW·ÍÝdŽãÏçI§Ó$“IÒé4¹\\Ó4ƒk›^ ¥²›KUU4MCÓ4B¡P‡‡¦i>³ŽÚ¬·W»à‚˜1cF õÏã‡vÌÄWßÈ,[Ù„ë:ä3™N0ÞLsMqäÓ¢¢úó÷ß>¸2Ï¸
Á¼µ‡?¶æö6¦\")è ¦MÀ(û¹ÇgŸAÏž`šP]‘†í8\\ø›[=ü»_.Þñõù5^ÿ“/6ý3VÄC„B
š¦\"á±ty:\0ãñÀžqòùæ
MÙÌ²×ø+¢›C÷Tê>n ™Êœù“Ñg~pâ¤y–c“ÍåÉ¾Öduôü‹V‡éÑ½’Ý+ITE™ÿùr^™ò	_|µr‹O¦?üíSÞý_wß´Š{Ÿâƒò5$SÊï~0Öóú\"!ñ±®¡G£d“IÌB×¶‹;šY«ZUÓÑ#UÅu],Ÿ?w[3EQ°,‹¦¦&-ZÄ×_ÍêÕ«immÅÜ†Å0Ê=øàwE	vÒ*º®‡‰F£Äb1***¨ªª\"‘HPUUEEEñxœpX„ÎÚ{ÓÛ“=üðÃÔÕÕ+¯+bÑ±ÑHÇ²Ú%t‚ñ¦…ªmËÄÈfÉ$[øôí7û\0\0ØÁ¡GpSïŽh-é†hyÒ¶ƒ1õü#\0ß2þ‘öœ,6MF¼ò
ÊþûÃî»p\0Ùvˆ†ÃxÌ‰\'|øÚ‹GÑ±\"Þ@ØÖfë%éHgÒm%æßñö²²ÿ}c…¦õÙˆÃvâ™G/ Q»È]Hf4®þå?xäñç\"À‰ÊŠayÃ ¹%åëBoþum€<8Ò¶Ý1u/¦G·*TU&neê›óiM@ô#?¸çÖÑ™¬=dú»+¹ðêøÝõ†Í´—î,ò¡3õÝÆJ’D8¤³0QÅ²•M…¼_
¿ñ[š _1`’eÇ÷Ä·Õp¯®ë†ÁŠ+Š ÜÔÔ„U–Ú^MQt]\'‰PQQA\"‘ ¶¶–nÝºÑ£GºuëFMM•••D£QB¡ .h§1¼­[yåõqC‡|xëãï|ýÑÁ¸0¸Œ7ŒÛÆÌçÉ¶
ŽjDÞ¸g-ÐQNÚÝâ=|`®ØÀ8\0aÃÚBµ!8R@«ÆßýÌKüçž;—Ú–Øwßâk–EX×©¨©eïÃŽ˜bäóS.k¯£¶¢¶;íb:²£SJ4›+ê¢$HÑÜ
Œ©Œ+LûÏÁÚOf¼ß*®‚ñ[š\\uÆðúÅ«ihlõG\"(
nñÖ”Ò§Ï<rUÕ]xdÂû$[®¼ü\"~ðv¦¿9›ú†¥CÏ>öÈ£œ8iJ(¤këþºrÈcÅ®ÈÓ¸´¥ýc³Ä óö|˜ß„moÖÜ¤çzØ–I!›Ás]š—6><•ÉÚCê>kå7úŒ
8æøÑL}éÏŒ:áº\"(Oyç}”CÔV\'hÍdE®a>_¹–gP( ¸¬#HÛ((Çb1$I\"—Ë±zõj–-[¶Ã,¦AH>ŸÏ³zõjŠ@Ý­[7z÷îMŸ>}Øi§èÝ»7]»v¥ªªŠh4Zôœ·`î×¯_›\"¯q—þhð&ÙÑéãŠÄýÆ¹Ö™–Õ,šû¿[ãÃ@ÿ¼Ú²qÝ	!«¨oÃcê–®¯.;0Nûžrp| ^åû}Yàà%Kèg—*‰s…‚àtNtÁ±mÓÂqlÁˆåk*L¯HÄQé*
¬Î¢ÏqŸ„£ºÎs]}üQQÙ)‘yàÖ=ÙwÏ( 1üÐ~ý‘ž‡\"ÀWÖ@R>¸7’Ôñ$¿LRü­”‚„Wïž)®¨äây
·üé%nþÓë\0,^ÒÂÝwüšÎ=…ßÞöw€a²,MQ}QŠ-È(ßEI%gO	N¨éÙ×m«ö±¹\0Ù±-
ÙéÕÍ\0ÍKG—ƒòmùÏ›À±ÇŸ©/ý‰Q\'\\O2•sÔÁLž:cle,ŠeÛ(²‚a˜¸ÞÆ{È²ß£¦ú!PY–H¥3¬Z¹=Ùf½ä\'žx¢w¼=Z\"QŠ€ÅãqTU]\'P/[¶ŒeË–1{ölºvíÊ®»îÊn»íF¿~ýèÝ»7µµµÄãqt]ß.€ù´ÓNãÊ+¯äž{î!\0ãCôyyÿÆìãUç3i2ÉÕ|ùá{GáçûûcETTãZ„ØÆT›|ÞaÏIç}Ï·ÁoÜìqK`xÅeüóšùÀD oi?«5Á´lb‘NUuÐzkp´ñ–Ë	8|o´ÜSlX.Žebäóù,Ïx£Æ½»kÜuÃ¼%Š,±jù—¼4#EuUˆM6-)‹‚¯+¡ªAA™„,«hšŒ¦)B@k¸¢Èä
.M«<Ï£¦K”pH#QáƒK]9usæƒ“ôA[˜iÙßJ1×†2ÀlÿèÐ*»võw<l^@öÀsÌBhe‚–å_wÊ¿»ï+\\gÇŸxÓ^¼‘\'þ†d*;æÔQÃÙ!õ™g]ñ;‹o³¿ˆïpä‰ãñ8‰D¢h—ÛªU«Xµjï¿ÿ>{î¹\'ýû÷gÏ=÷¤oß¾ÔÖÖRQQ±]\0óM7ÝÄ¤I“¨¯¯ŒÎ¾ò½¡î`¼¡j‹BNÈúeE¨údÁLêåë®\"mª½)˜«ž‡í{¸­>ø6ùžn\0ÄIÚæŠWû Ûê?VðõØÍÉtÆ/õ„<âfº>µáy@¾÷ê¦ñû_ìÎât­Ñù`NŠs¯™Ï‚úÌz_;V‰„•btSPtúwW´nÅ£BbQUöß»+{ìš ç¼š¦p×mÇâÙË¨¯/‚ô¢l>/dQÝo§Se“Õž4=Ôv7´™ÃJªBÕuUE\\Ök€òïÿ¶€\\þ?œyúqL{~#O¾•d*;†µÐ»mFûì¿÷þqô¾CGÎÛÖ¡[¶ÓõS¦mñÈ  *“ÉÉdÚxýA¹¶¶–p8¼Æ\\úüóÏùüóÏÙu×]Ùo¿ý0`\0}ûö¥k×®Äb1t]ßfsÌ‰D‚‡~˜GÏ>›û›š˜C©b¶g\'³°®ëŠªêÖV2-«YüÙ¼ûðûû‘?Jyãžˆ\"®mb\\Ëæ¦çy˜eží*ÿ¼â¥â­/€¥À×>(¯Åê(ÑV&9ãñƒk~=%—/€²¬‹„×èVñÖiðù ƒŸÅ¶[T}²ƒ<~¡@>›fö+Ïí<VãÝ8zH”îÝâÌ|¿™“~ü1é¬¢ÐkÈº†*_°ÉÖMÞ‘L•$UEfu²ÀÏÚ—ý÷îNXKS÷¿·yä‰éøÁ„YÉÖ4¹‚±IÑÖo¿ÍžVI\"Òz8B¼ºnq;PÎrïÃ‹Y¾j?»ð`¦NºŒ«ÇM¡Ïö¹¨¶þ»÷Í´3%”\"‡µ8T¦Ïút\0ð@8¶­/Býæ–›/^ÂŠÅÒƒmÔ}¡,åK¹ù¹%×ÏW4/mäGj¿‡ßkžL&I&“,X°€x<N=èÑ£Ç!î…²páBæÏŸÏÀÞ{ïÍN;íD—.]ˆD\"Åâ¯mÍFŒÁˆÛo‡Ë/ggÃ ŠÈVw‚ñ7òÈlËrŠ©Îùð üêÝþe;À¾¾wÜ‘7ÞêE\\Á|BÔžGÞGÏŽ€8èù™,D„³Ë¬Áß9ˆäWýö´HòÛBU=„ŠÆ‰UV©¨ `ˆWÐT•¦¡iatM÷¥å’ÃZðÀu½2é\\!ÏX0ÒÙ¦QÀ2
|ðRIÙ©ww?^ßcˆSÓ¥‚Ùs“œ|ñ¼\0Œ\'\0—ìyÐ¡³Ç¶¬¶ÜÕ~¾zù¢¯v)Ûc­ÍùA‘ç/h&ÙZÀ²]–­ÈòääOyáµ\"3æøŸÿîŽÉt†|¡€ãl£€üíÏÃeXÉW3¸îâLý÷! ÔˆÊ:·œŸ3ÎàeKôëÙWHJWíZoPº€F®>`¨¢jÛüB´ßž»S!É©mY.Òk[â:.®cãºŽ%ˆblÓ$–¨®³ŒBU(<ëyÍKUàTà4`X&“é»`Á,X@=è×¯ß^óçŸÎ_|ÁàÁƒ9ðÀÙsÏ=éÙ³\'•••Û®·üƒÀ_þBïyóˆûm¸Œ7ØypœRUuy¨º¢R=UïN‰ü#L±Nwë‚±,ƒçáxÙv^q¹Gü–j+Ú¾Ê,`0£ÿ!‡Ï–YVÑ1\"É2’$#+²Ð‰Ö„V´¢i8ŽC¡Ç0UÞ±õ;94tÃëµsÐäv$EYF×Å¶$ ›/à9.oOzªÆCé\\ó£îyxªª*©û4ÅÑçÍ¡5ã\0L>úÜ±¦QÀòëÚË,ÕÚ•5]yž·¨£M™ðÊó˜ùü4×uh^Ú¸¸oùÊldùÊ,o½×Xþ”ûÏ¹nÜåé\\Nˆ¼Æ&o×€ü@ùSÁ˜uþµzð
î¢W]µÄ…s<<Œ’‡ü\0¹GôíS	áþHZ?Ðz³-s›Ã>=ºÒ5²ù<‹e;X<)Šx®[ò–mÛeËð	ßsYbU	»Í<íØöÓ¾}&ppäòåË#Ë—/\'‘HÐ¿ÿ6Àìyï½÷vØaì¿ÿþôë×¯è-os¹åŠ
¸ã¤3Î *—ÃôÁ¢Œ7Ð;6Lò™V2É–Ìÿä<üªêÀ
ù@¼;\"7e+æËØ÷Œ×¥‘\'Š¶ ž¼îuYzpïþ#Ž^ ¨*Š¢\"«*Šª¢¨Šª\"½ú~¿~\0Î\0®cc›&f.ÇŒ§ß8Ÿ5ûgR6èÈ±~’ŽÈðƒun¿¶ìSE(cú;K9ýÒ/I¥ŸpÉåc‘$\"Ž¨(I,–…ÃÝ¶À\\¬ö.Svr³ÇÈe)d³„cññ_9F»ï7˜|Â%?Ÿ7!ðâyX–ý­]ru{¹™6”sîºOÓÔvQY°8ªHDÃ2ª*áyvÛü†÷Í@4†šª4]»|@÷šEŠŸaV>ÞæÇ/¬ëD#âÑ(Z(¼Ýz8”yÎŽcãXb³eæÅÍ•Ï¤ñ¹ÅŸžn^Ú¸;p0,™Lö}÷ÝwéÑ£»ï¾{›PöòåËyæ™gX¾|9‡r{íµÝ»w\'‹m{!ìc…!C¦MCÈn:ñvýÞ±mcäE!×W} ¿ÄO3¡\"o¼ÓÖUóMQJž±mCÔÍ>ðf€¹~wI[oøÁïsâc™Qàõ*ª\0dYVI–¤Ž‰s¹,oOzjwÿ­:j)Ù,úòÇâžvf÷~c<út#ý¢>xxÂ)?»flH×„
“#¤I×-­í×	JúÆÅM~/Ù*nèÙ•µÝ¸Ž=NQUôp„p¼‚hE…¨9ð‰¥*Nï»ì!¯”eEAV”ÆUKŠ œÉ}[kùEh~¹9Ÿní\\ñ¶Ðõbò2²*:^È%ìÅp*ËÂ4Ä–O·’Mµ ¨ÚÇ¶Îm^ÚGpÕž¹|ùòHSSýúõ£OŸ>mÞãí·ß¦©©‰t:Í~ûíGïÞ½‹-RÛ(»ìÒ	ÄßÀ;¶Lƒ\\º5Uß„¯âpQE…\\»–…ª·K’\0cEÏÃ5MR¾W¼‘#^ü…6-0ï\0?ä¤3S5EÓ@\\MK8f¶%ZOÌX‘=û©Œ:ÄfÀ®°G_Çz1c¶æ«5¼`’8$ñ³ák—ú%-ê/£ŽèöDþ·WWøÇ­=ˆWTððÄF~ü«\"ßvêÏ®§ë²$	0vwŒ¥ubÝ¦¨*ŠÏ¼‰W`[¦¨Q‘$EEÕuT=„,KbC×ø§¹#P¿‡‰TT6æZS‡55.^¥Û·a3;mô”Es?ê\\ñ¶Ö|e UTMC„‰ÄãÄªTt©¡²&Ezu3ŠªfÛ>·yiãÍÀÝ¶mŸ´`ÁšššÖcñÅ$“I2™x ;ï¼3UUUÛ(÷í+òÉ&tN‚òŽ-Œ\\–\\*Iý¼9qàLh[ñ³3\"TÝ‘OÞ*¡jIq\0Æ€W(	>Røå¾ÀÝˆ~bkâøÃNÿþ8ÕaUÓ…\'¬Èkõ€×ï~xÅ
hD$Ó²ù|Ä#Ð§¸÷R†Øä\"y¢p–4qG±$·Ôž\"¢”N
Ç‘È<\\R­Yžx>Çå7/>ÆO»ìÚñš& ÊvÈÚÀø›®Š$D04]¡nßé’Ú„ð¿m Þn¹=(K’„ªë„c2iÝzLq,kŠë:Ås%IÞä;K–Eõ¡
ŽÅ‰VV¡…B$W,Ã4
«Þ6Î’¬ hZ)ìT• Þ¥†Ö¦•\0€“ýó­ÉdrÀìÙ³éß¿?µµµÅ×Z¹r%Ï=÷†a`Û6»ì²‰DbÛåßÿ¾7Ô;6?j’Ä”HPê9Žû`Ü¡ê´UØ¸Ê½â ’ËÑJ)O¼ÚâWKÏz¸tÄ˜5]„¦E(ZnS”¸ñ`â	IÜ2s=øàq¼<vê±ŠXdš
ºV:Tÿk(~
\\þ¯ÊØN”¼¡c˜¶«#KÊ¼;·Àïþ¶¬ë~Ï³¨ÖmÆqyÔm ´FÝ^o²rPVTP8Š•Hà˜¶máùüªÒ&ß]¢%@…ºVì¿v¶9Ãï0K’¤ ë
²*v¿¡ˆV&H®XFM¯>O7/m|ø§mÛcæÍ›GŸ>}Ø}÷Ý‹¯“Ëå˜<y2–eáº.»í¶Û¶Ê}ûÂ7Â-·t^ôuzÇ¶/W™dñgóv¼ãþí¼ãÝ€ˆ$©¼å\'­\0bM+q¡@ÎóÈ h-—W\"zŠ}GyÜ1ü¿;žMUŠÅXåÔ”¥v£X´Ö»æ©¨b­›	Pÿµ8›áKWÄd4Õ-FÛËI8ð@Óª*d	$ÉÛIG–AWsDÂ©´ÃÜÏ‹<û?>éÒ«Æëš†$Iß
o‹¦nÏ^’$$7¨jºÆõ¹TƒTF®)=lôN
Úhn†¬¨«Þ6l²¬ i2aaÑ#Â±8©U+ðŽ±ÍK?îhll¤P(Ð¿ÿbÁ—ëº¼ðÂEº¼m”¯ºª×	È\"w\\Vìw>éÈãÿÜÕå*¶B!W9‡Bâï|Ã²È D\"\0ç Øµ¹âó®¸ýÎ‘pH\0–mcZ¶çzn‰®Š$AËQ±=©Rn	´]×Åq\\
²ŒíçW9bÊgï¼y4\"÷¾†Ò’ß¼sXº†@`‡µ>Ë€qÇýø²ñz1Lí`ÛöÆÛ= wvñ·\"Ë¨ŠBH×Ñu­-õFé/‚RèŽë’JgH®\\Ž¬v‚òö°qÓü¨Š¦ùÄ‘(M_/¡¦WŸ;›—6Î\0žkjjêYWWÇ AƒÚTa¿ôÒKÅØn»í¶íä”	3¦3t½sm3—#›J²dþ\'jà÷(;g\'D‚´[¡+\0c]`¬i`x…9²& ô }0ž\0\\ò·	ÿÍÈ²„aZäÃ01-«ZE\'¤ä¤–\0Ùç”–ÊöámË¶Éæó4©j1Ò¸÷aGLÉµ¦¦˜…BQP\"ˆ>¶Shêp¦²ÙED›ÖÌ£Î»¸IQ<lÇÆqÜïï0€\\Á”MÆâO<YF÷EîUUÙ(@VdMÓÐ5U”Ë2­•9–-[N(í\\ù¶`ö‹8dYFVT]G…húz	Àìæ¥ƒ§2™ÌŽ@ùÅ_,ê+ïºë®$‰m£%ª3—ÜñšàºØ¦Yî_A»Ü±äƒñÎˆ6§-ÚÏpiD\"”-
ò>ÿøUé€/ë~:æ¬àIÈÖ	t7üåÏ÷€WöÝ%ÿ~PMU‹Î‹$I¦I—ÊJ–Åc,…ÑÃ¢•	,£€m™¸¶ƒërTÖt­ëhM.õ»xž÷l1ré³‚ÉŠŠ
ŠD	Çâ„ã(ª’ÔÆ›÷¾#iÁ‹4‹Ž]Ô=–$‰ýç·]q=óÜ_Ü8eÑ¶Ì|Õikñ–CH’Œ¢ˆÖ‡fÊ¥žöµ€òK/½„®ëèºŽªªTTTl}ò¾};½äŽ¼c×Å(äÈ¥Sä3i,n”7ºõö¹ëÖòŽ5¢Q‡Áu…wlØÀãmÁøe6›ÿ¶Ÿ_º®‡S€úÌ	/¾:®KU‰Ê
*bQ–®ˆ’Éd°M×õûrÝrÀ¥CÏu÷³[¦öä§eY0ƒ)š¨Ë	Z´$I*æ¼½ïPÎvÈÁwlË(`Žãðö³Oþ›o_\\‚ÇÿxËÑû8zJçò·ýyËª¦!Éq$YöwëòzAÙ¶m^{í5¢Ñ(ápUU‹ºÓ[Õ~ò“N@n·.Ø–‰‘Í’kMÑÔ¸ø<`h¡q\\ÜË BÖU[Ã;<ãHD„­óy0MàQàºÒÙçÖV«ŒìP[5	Õ*’Ùs>Ëã¥‹¡èÒ7‘¨û4C²uÜU¬Iî1|Ì‰Ç	Œ~ê•)‘Pˆ®³¢©™t6‡í8H/Â$e•€µä£Ó¾§Îf©ïä­ÆF>O!“Æ4
üïµÿŒ‰Çd.SA49.Ä!PÀÍ°n¦·Žn 0(U Wˆž;)ÄÍ˜pS(íäí”I\"•µÇ­”[[[™6m•••E1Šp8¼uAyøpèÕ–.í¼°ˆb.Û4É¥[ñ™ôÎ\08°JD›SPY½EÁXUÇb\"wlšâpf\0?oÆK„Çoc;Ð£ï‡LRQÝ”žþzr(ýÀ
žäŠÇ%	ˆm>RpI¶ºÔ}–õ×¸
Pª¸ú7ÏP÷qÃà©ÑÇ5úÙ)ÓƒT çydrylÇ)~ŸN‚šï8 ·ã|º•|&ÍÜé¯ÿÈÜ7n\'F§©Ø	OŽ7îJð,_j±YíŽêZ!.!G@*ËJçLÚ^A9hŸ‹D‰·Ô6 <oÞ<T|pÉ’%¼õÖ[$‰¢§¼ÕóÉ¿ý-\\rIçEE´#Œm+/ªÅO]u-;§7\"wœ`VVE\\á°\0ãHD„ª-l›:Ïã¬ÒÙ·sþcÓ\'<:R\024§à÷àÝ¹0å]°ëBºT-,ö\0khjéPUÑ¬i
ºG×#„t	]‹à²âÐaB‘j¤P7íÌ´ÇÈ“n¤nîÂ!ÀS§5â˜IoLÏ8§¼ç‘ËŠžr§}‡¹#0Î¥S|<ãc\"a™/ëÁ¡èD\"8«I·|Á×+–¯ÌÓÔ’¥`ˆ]t›Ê:¬GÍçì³Ç›ôê‘€P$}×âcf!ß9“vP.çIs#\0å×’Éä€´éSþè£èÞ½;UUU„Ãáb>y«ÙÙgw²¿>8>å£Ÿ;>¨ªm·àíä{ÇÑ-íëº\0ãX¬ªv’žÇé®KRœ9á”Ÿ]3.Õ¼
üün&\'1g~i±zû#Q•z|e©¤EQnÕUÖT5¢ä‘eYNã8ÃC–5úöÖ9hÿ.8£;UUg2íÅ?2òÄßP7÷‹!À?«++Æº> {žÇÊÕ- ¼­²$IÈA«,Š[EýKÏÝ<¤ÜëãpHæWÿ¯;Ç‹Ð·—Æ’e6ç]·€•«¡`x˜¦…å”Dž6x T‡ I‹¼G8ü¿à¡Y\\Ö;(\'ªñ<7Ð^nl^ÚxðAcc#‰D¢£×ôéÓéÙ³\'‰D‚P(´uC×-Pþ^ÊÅ4
ä3iŒ\\àbüÔuñ½ãš-íE\\ÂKöÃÔxš&õb}|ù¼_Þ46W0e…ýGÝ2wúëlÇ“ìPÇ¦£ßµ™Ùîg»uî?M<þlwü:Ï‡œÍ³ÿþþ3’©Ì˜áÈô÷?ë¸A¿²Ç*¯…œ¯Ü	ÊÛ }¿š¦ÖuÑûë3¬8®ƒaZÃ4Ûlv0–øÅOºqú1ÕØUbÅ*‹c/j`þÂÍ-6áú3àÒ\\\' ïX ‰÷<\\ÛÁ2Mjzõ™Ý¼´ñZàŽùóçsÐA¹¯…ï¼ó=zô ¢¢Âo­ÛŠ§‘#7×ugn¹B×u0óyò™4¾Ú×P•’ˆÍã^@[1Q–WV
ïX,jày<hL²,Ä—èšFÁ0QT•p,Î€C‡ýìÝ™?£ã^ÞëïñèŸ)´wIª€A¶ã1óƒV~ò›Ü|å8þ¤1L}éOŒ:áz’©Ì˜ƒdê{³Ç–Ø¿\\¼È
›…_zCîÑÀù¿—†1¥Xñd×Oì»¾g¬È
ÑH˜Šh”p(TìgËärdóò…–mC¶I±#³mÓ4q,»(µWÆ×]ÜïŸØ…½v­$Ù’ä˜‹3¡‚Ùæ7ßÂøÍ<ää3ìúë:ÑlGå.5ÔšK|‡hÛö˜ùóç·É\'ÏŸ?Ÿºº:ºuëF4%o=/ycÃÖ¾Þ®8þjíøà,—[Mø˜WgËUŠÚTV€Ü¡¼Å¼c]‡x\\xÇº.¼cÏ£Îq¸¤$áúËÿwóï-K0S©šF´¢Y–4êØ³Ÿf[– æp]ð¶Ê{|ƒjgõn½àŽÖo³÷_š—6þÛv¼1uŸføýXö“œrúX¦½t\'#O¸–d*=fÔ!1õÝÆz¾—,I«S­“@C x»ö´›”åŽŸ®i„tÍ—táø¦…e[Ø¾Ç¾½ó&²exŽ¸˜/þýžƒåóÃ€z|çûŸxÊ®ˆÅÈòäòÓúFåzŽëÏ4§R8ŽeÅ®pHæúŸìÄNL°×n¤’FžWÏ\'_0=äÔ³-ÃÀ6ÛÆu¿®mùþZ\'ƒß&£…ÃS8^ªi´¬X†mštÚŽÊŠªŠD©¬íŠY(°²a!À%À d29 ±±±tã;ï¼Ã.»ìBmm-ápÍ\'Äßâ¶1aë€€°=‚;9ëƒ²îWØ?´møÚ	™E“B6%TŠÎÜ¿À*]Õl¡\"š +Þq4ZôŒ‘e.\\½:8óþËnýÓc¶ë`Ù‚SAQ5Â±Z(D¤¢×¶q]×qD°·fo›6£²”!ž[êöÁ1\0äL²…B&MM¯>c›—6VØŽwRÝgYîxpšö$ÇŸ|ŽÊ×P>ôà¯^{ëÝq®ë¢(2Ñp˜l>m;EÊNq=Äû»n0w@ÙYïv íº®ëø\0+*ÉY&
Q‹‡	é:ù‚Ak&[tþLËúîyÈ…lÇ²x{ÒSõý^|vÙ9£GßûøæØM)ŠRäÞ ›Ì§r€Üó\\f¿ò\\±€ë†ŸíÌYÇ%Øc×.$“)Fû9sç—ÀxÌµ74jªÒà-KPÃ™…–QÀ±-\\Ç];(ùqE)êhz®SÜYvÚŽÊª¦ŽÅItëx[™æ¥ã€ÿÖ××Á ™LRWWGß¾}©ªªÚº×ß$l€±¦mc8)„ªÐ
˜«ü#A)çºí†«]¬BžB6KóÒF•ª«»Q’XÜb\"¡\0ãÊJ1Ö¦	’Äƒ­­Ô\"ŠwÅíw^îy¦aøÞ¦+_e.ðå¢’EñÇuÅdàh”yÆåÎFGÈ×o«hM‘\\±Œ–Ë\0.j2Y{HÝgY~ÿ·D\"O2âèóxvÂ-Œ<á*€Ž9üÐúg§L_aÛ6šª[¡ÚÐvz¥ú¡ÀSXÂ¦°p\\‡‚iR(˜äÓ²øÏ·ïîG>v	\"•N|vŠaZ¬·Òœ,ñÐ[¶ýÝä\\*É‡Å¾_sÏÚ‡£GíM}£És/Ïcú¬Ï\0ï_qîþ¼?÷À˜XDæO¿ÜSîB¯î$3£~ø)uŸå‹`ü“›noèCšF$\"£ë¶m“ÉçÉæòdó
†Q¡îh–Úyí™l.PBé´”eM­¨¤ºGOr­©@%j‚mÛcêëëéß¿¤ôá‡²ß~ûÑ»wïbòV±cŽùæ`¬ëà8¤¥@BÐ ƒ¨Dî¨JŽùÇ6ÈŽ‘ÏcˆÔ *Ñn¡ëáôW+ŠÈ\'¥Ü±m“®_±\"8ëïª¢3
‚—Ú¶Š9ÙòPm$\"
©€5UA–d<OµaZä
òƒ‚in(ƒë8„\"´P(àå/µüù |ã_ò§Ð†1†‡ÿ~=þ¿?<túQ#\0®ãÛÏ¼áÞì€µK^ËzZî“D(Úu=lÕA¶dž½ïÏ÷?B´Žíâ³OŸ\\úàÄgç)Šì‡°Íí®|“WŒ_{ñL`LHW¹â’Áüð¬}Øs÷î ÔpåOOá¢Ëæ‘\'¦F€7ç¯ˆÉŒÿã^œ0¢+ÑhŒd«É¨1oµãs®×Ø”Lñô½¼Õ¿9•’YÀô<ùÌ¸HXä»†Ø9Ž³ö0¦¢+É=<’­’M«ÐBáNôÚ‘A9&žèB—ž½ƒÐõÀiË—/ôèÑƒD\"€a,X°€ýöÛÚÚÚ­È}û®Ÿ$¤=kn:M³ÆŸSü¢°§p¨èAÛjåmÍD}I#ŸŸ}*Ñîœ[:\\xÇUU%¾jYææåËIŠõæ…_Üyßc¦eaÅ¯¶SL­Ø˜–øÄï´¦*Ä\"Bº†îÚ¾(D²5CKk+é\\Ó´pY{þVV´PˆXeBxÕ®Û(·rýíŸòGoçŸyxWqá¥w<´¾!¸íŠuÒv6 Ò›ë²™ˆ²†=‚(ìç£oßAÒyô_¯Rß°t(ðþÅgŸ¾ÿ?ŸzvAÁ0iÍfÉŒï–‡„„vê\'™*ðG?äé>çÈ#vã®ßŸÏ]·ŸCßºP»#H9ÜòP‚Ûî\'à•£^\\<Ë*pìð†˜\0I#™Ê0bÌmÂÔ\']zUãªU«xí‘¿¿ßî3†þäûg	Œ¾ãá5*Š‚\"Ëk´rT8¤…iÕÔ½”p,F§í¸¡kEQ	GcTÖÖ’^ÝDM¯>š—6Þ	ÜP__ß¦Àëë¯¿&•J­uc·Åløðµ‡­;\0ãÀ;nö=ä÷€wýe¹ºN\0ûlÃ×JäŒ\\.ø×ˆö€œ\0ºoÉpµ¢ˆœqàË2¸.õ¶Í=Ë—gÝ,Š_-ò†)Š^]Ç²°LÇ¶xó©EIúp–XH;®G›üâ‚ÊxšpHGn^M*“YoÝŽ$+há0±Duy^·(/hÈðë?ÎÕ-9ïô£ñÜKxlÂÌÒÚíe€Á‹*LŸõÅz·´%Pëp6¯_U„©/\\Ï ûƒ’\0)Îoo¼ž/¾‘G›î®ŒÇN®ŒÇéZ1,þ]äA\0ñhˆOæ¯âÝÿ-¥P°xä?uì¿O®øéIÜtÝ(1ý%E°c9I<7 ÓpŠ\0,yàâQÖžž‹ä¶‚›!“Í‘Î˜˜¦Ã×+
äs­œùÓ¹Ìû¢ÆÇ^ticjÕJfþ÷‰û€ãk»D¸ãæ£8wô T3ãíe\\ý›\'j¸%×^øÃýî³€K:l^\'tíØ^²¢iDâ•TÖÔâ÷ßœ™L&d2âñ8\0™L†\\.·õymyäµ€1Ù,i |¼åw!-ˆ~œÂ¶Èž‹e0r¹ <´= ×øáê-B•PdVTï8c­(Ü¼xqpÖ¿nºï³s…¹BÃ4‹šÄ¶ePÈfxgòÄ£üKRîP¬¸®9ïÔ?óúÔy‘PI\"ž›Á°ÖÊmûð»ˆ\"1Q1ôáÏ]¾ÊŒ@†»ZÀg_å¸ì‚=¸àÌ³@®ôé:m<ÏöaEF’õ2\'KÂ“T¤ V_R¨oXAý’fÊ+
P°˜1sNqû4pŸÚ¯u/áê_ÞÆ ý¹ûÎßr÷7ðÈc†ýà„cÔûþõ¤­©ÚvGé¹Ù£6jÙ¶Ó2,ürù¼aXÈ²G&k±rU†lÎlë{>ß*^[ïØsp=|Þ$—wp\\E†xT&…[ÿ²/ë‹­M£O¸äòÆäÊ¼=é©Zü
ËcGîF—ê(o½×@<¶Š‡bê7²ëþ—“Lå6åëˆTV£ÓvpP.y©ºNM¯>vóÒÆ7€Å\\rP°¸Õwåå‘×ÆyÛ&h¬¬¶šµÑIl&*†…\\1r×>\\]‹ Ñ·Ô‡
‡…wp’žÇ¤U«ŠÞ1’DÞ0EKOƒmZA1á0€ö©àû\'õ@–¡oŸ*ºÖVùT¾• WòØÞç‘\'^\0ïŸqô¨Á/LŸ9OäcEßnIÂí°-)èñë‚êh`/MúþòUy?w»Œ·f7qðÀ/°{ÝºÅÐuªŠ¬¢i*ªª¡(\"Õ§ë*š¦£‡Dx]×TE¥oO~½b€‚\'k¾ã¦¤!I*¸ØûPdE#Ö0-Ü£Nø5ÉTŽé3?¢oßž\\ùóKqÄ`¦¿ù~•?^Óä2¡Šï Ï†/_•!Qfß]I¥Mzv‹aÛOü”Ç\'ÎL.€ëxØŽ»î*ë³ é/K *š&‘ÍY4\'\"Ÿú³ks™4­ÍMÁ$îYÛ%Â×Ë3<5iÿúï\'\0ÜtÝ(núõ¹¬®ÿERvÏ7í{î’çàÏFR*@©ER«ñä
täø€¡Z¨³°kG6Ïuñü
V$	-fEýÂ}Å%°|9ôëá0Ý»w\'‰lý… oßoÆ9àcà·~xº#Ë­¨·sü¿ÝIDî:\0äŠ-®ŽÇ G\"Å^ï‰+V-9/ÜþÏ‡dsyòÑ¦ã–R´wJ1‰–”ÍËÓ›Ø­o$…žÝBþ½„z!éý9|(Hüë¥ðþI#†íÿÜÔ7€‡¦ª$Ói
†é¯¥%U¦`è»®‹iUŽW‰WÐÔG’åyM‹‹ œÉY¨ŠÄu«‰ÇTB!U‘ŠB’iÁÃ£G×8Š\"£ÈBYõ{‡ƒ[¤2®“¨Š#«\"m¨é
Š¬ É2­­Z’yÂa.ÕQ¢Ñýv®¡\"*:SU•:ž›nÅ7mÇs¿{}È¥°k–¯ÌF•aºw‹Ñ-¤j|úÅj^Ÿ±•Mß*×óËÀ%\'þäŠF@¨>‰]¥¸!ã,g¼½¤ø„W§~ÆM×~	žâ/1’µ8«I¶x®ƒäÙxžUäêDIë…çt¹Z(>•íÌ;mÇc×qDn2ŸÃ*äiüüÓ}÷H ?@K=¿÷=vÙeªªª¶.§u`Go¾¹A`\\\\àƒ.0¤KM6ˆö}ë²e•óÊïm+Â%?dcUWëºUWVŠßýö£Û¿(æU\'Å‚R»ý¤„Ô¦§ •¶ùß¼_,ÌñÒÔUôíÓÈ÷öûŠœ²3]w:Š‡¸
xä_/F€ÇNuÄè	/¾Ú˜¨±#d–¼á`ŽûO\0ÌA’]Û…l÷n¬ìÖƒ®}úÒ¼ìëyófNü3“µ‡øqPXµ¾hÚä¡LTEŠ?÷éß‹SOÜŸæ6rèA»pÁö\'¹ºžéo~BÛyf&—Ã²ìín½Ùd@Þ©ÿ>–Ìÿärà¡ùši\\–FUe4UfUs1üm1eÕ1úÜEá˜Ð´u\\W4Î€¬Èdb‰_tº÷^]ymÚ|>¿Šå«28Ž‡i:¤Ò²9«Dt]Fx]Y!³s¯»ôQÙ¹w´^ÁC³
™L\'ríà`\\ÈdÈ¥’|üæÔ5Áè¹x1ƒ.ºˆÝvÛêêêmGŒ€™37ŒÏDä	>9Ä€¼-ƒ±Ð?¶°J€|¾7\\¼‡ýpõË‡Ãc±â¸×­^M}6Pw×#O<–ÍD«Sû¢+IBVU4ÑV9 ¾±#Ç¦™GÿÛÀß_Àm×·pú©Çp÷ï/¤nî—(ÄScN<v]koÝy Åsge›MU	‡B$*â˜½{’í¿»íÀ¼–•+{sâ¿!ŠÕûRêîÈä ä¾ëÇz
»’©|ñg8¤cÙ‡Þ}ôæƒÙŸò“+-Flu÷_íÖt¶˜ÿNrUm7¤½åñ‹?ýàG™¬9¤ìá2]ºßð#3ž#ûÇ†o:P~>@Q5´P=!‹¡‡Â(~nÆsÝb®ÏßeM«ó=3ƒÚ.Q=°ÕUa*bo½·”?ÿí
Æ&{·Ó;¹¬w|0Î¦ZøèWŠ`ÜAF	ížÏ³O<N¿~ý¨¬¬Ü6\0¹OŸã”Æû5vÙW_l—×Ë6ÌRˆWDÈÊ×*ÿØ\"ùãòÞãp¸˜?~´¾¾¸‘0-‹|ÞÀ¶í6€,ûëX(cŸÃ‡Oùä­GSbA¾_‘€ì³­üæÿãó…i~qÅÑL}áFFt3us¿L]×G½íçëlKJÎM™ÍüÍ=÷ÙÂE¬üº‘Öæ&
™4¶eùd$%B’uÑv„%>^Ì£›¬jl^všÿår—¶°beš©o~Æç_® “5ÇïÒT:ƒeÍïœ‡\\QS‹¬ªèáÈxË(Œoødn°s˜yØi£mEÓJ9ŸAfc¶Û’,!Ù²4ÿP‘ËvvŠ_xÓ{ÏM_ñÙÓÀeuŸ¬`÷~ÕÔt‰`Ú.ó>kböÜåÏØ„¯?sØYcÇ-œóa\'‚}‡Àxg`°úìæoï÷úÍŸOÍØ±D\"‘m÷ÜóñÑç_2vñgó¶Ûkf›&–iÐ¼´q0\0¹’-$&¡(%f®²“I¥êêG= `äcON’CW8×cß¡#§äÒ©)f¡€mXF)Óß¼´ñGÀCó¿JóÔó‹h\\þ<÷Ü¼Š©Ï]ËE?O²5çGû„ªRi½¬ûx	ÉTv>emG¾ÿÝ•?=pâ«oœðõŠ•|¶°žúÅKÈµ&±Ç±‹´žE@.…`°.
ZÏ\0˜=ÿ¿ÒÜ4‰TVÚf>7Í2ŒiÍK}ÇÏ2g^cùgz¸tìu74fr9,ÛÙîXº6 G+«üêÓ–aPÝ½g¬(¨zˆP$‚‰¢é:²¢øE›ü’Š?$¤¢×\\nš\"RYI…Q ç®{\\¾lá—5¶íŽ™¿ ¹£|¸ditlÇ²ŠäèkÄ]d5¤£‡£Dâqb‰jôp„ÔÊùN=äï
÷ñûî~¬n”«ÞxƒØwn]µ§6ËæðãÓ/¿nl&ÝŠ¹Îe××Ìç•ß?zÑYb[
ƒüq4*Æßu©Ïd¨\"›ðßÙ™\\Ž\\ÁÀ²;hG*ò©ÇP-!Z• àã7yr­©€=n|óÒÆ~Àó>O¡*
gÿä®º¸‰§…¤õ)’ëªJ¢ýHR|€mFž$Ú‘$I£$É$“ê>^\"*Ÿå(’æÂKn¥¾áëãÏ>öÈ¿þö{c{ÔÖ°¨WO}½”MÍ†!Ò†E^íŽi;ƒÇJÿ÷JSŸƒÛµmÌ|žBNˆ…Ä«kÆ;¶5¾ñóOò½æEÀ¬£Î»xA(£`˜È’$(A·CæM^9ôpUÓ	Çâ¢÷Ò\'\08ŸeEEV”bIý·9@¥~Ñ
\\ÇABBÑ´±Ÿúpš«üpÑ¤CN:ãÎÀkwÇv|ó^Û\'ˆP|	?·ƒc[|ÖßA0îÖŒk€ð§Ÿ¢f2HÕÕÛÎ—Ú@0Ö5×¶±­íS(Åu,ÃîÅµzÈ‘-ña$ITUšÇª
ŽÃë_]Œ¬I’„eÛB¶Ðq;\\odŸòWÕTôHÏ­*†mK´D¥V­`Õ’jzõ×¼´q7ÛvÇÔ}*Ä*nºc6vÿŠûvc×¾	*+Â É(ªŠ¦ª¨ªŠ\"ËH²‚ªªhºN(¤
i¾8Š‚ä¸~PZ¨”® tãÙ§îeä±’L¦Ç}Ø!L}oöXEQÐ5•pH§©%I.¿érŒår»–Q”¨¹,–aÐ¥G¯)²ªNÑÃaBÑ˜ÀŸ»Z\0òwT~1·U)›P÷º¥:@„xŠŒ$ÉbW©‡ÇbTT×Œw]g¼¬¨èá0áXœp<ŽŽ ¨ª§á“µ^H©ø$YEd–…$ËtZ\'G|ÏKš;Wx¦ÛŠ
¯¿ŽiÛÀœµ€±,K²~Û+ Ûf1ŒÛWu¹Uø^ó)è
”B!¾–$^jhÎxÝó¼¢\\ »²$	YRùt™º®¡ú¾¦m³º{O*kº²¼þ+€±ÍK	@9U™óI¯L_B8¤¢ë
²Hr›Èb,¢RQEQdTÕoO’%,[¢`X8ŽÇ¾zrèà]9ûô¡Üo\0Ó^{œ‘ÇœG2Ù*äß›=6Ð#”òc“@Y’$$ß™“U‰Uà8BñªøUC¤E…Ãç–ú¯\'‰ï&K2rÐ}à‡Ó]×ÝêšÊëäZß£ì‡(šÝÑIÝk»°MmF<Çß)“\\¡€ešÂc–$M%ŽF	…t±CôC%°Žï±`: ©t†d8Ò	ÊßA0ÞQÚ¥Œ¦NÝ¶\0YU‹;âyÀkcËvp{»ö¸Žƒ]’ÛÛƒ¼á8[¨ K–EAW,&B×ª
®K]‰d&x¦¹Vö¬À;€ÄTU€r$\"
¡ë}ºw#Ù»\'‹{õfÕ’b‰ê±‹?ýÛvÇ$[E´#ø¹)öúôÏ	?ü“^˜ËÝ¿?›ûõAùÜ(¿ûÁX(õ57{I
†¹Éž²$ËBåJQÀ—Z²žÁ¦¥|ƒÑÑ{I’„ª(¨ª‚®i„uÝçÿ€ï8.¦e‰kbš˜–]T®Ú’ÀÜ Ç²fâ;Àxÿ(…âñm.N_ÒzœžŸs¦(Q¼€A.c=/Ë²óøa$Y–H¥3¬Z¹=¡Ó¾{`\\ÓŒ¦Oß¶¾àðá0cŸ
œìºkcÛ±}bˆí3ÔçúÜÏk3‘?Þ¢Ö‘ˆHÈ2IÃ >•H=6ùÅE­™¬\0«µpai×Õ×o<þPQJ²Õýiüc-;÷ìAë^{òù¢º÷Ûuì/Mþ\"t¯°þ¶£¾¾ãµÖo-,žåc–|ÝÂ}Î0ð{Ç2íµ1ò˜
P>ôàßx÷ƒ;…§)¼äÕ©ù‚±Nq‹oâ1ÓN%jÝ¾Y™Æ½,ûdTJQ— 		‡	é²$c;69_S9íSX–…³9¼©¬ˆ0jÄ úõíÃô™s©›óù hi*ÊmýñšË¿ËëùÌ³®ø…ŽÅ;‘í;
Æjûè‚ÛÖ—ŒD¨‹Å¹z5IŒG_õ«±Aè.\0cÇÙþXÚ²#Ú)…
³ÀBe›§oÝt]\0r(TŒP”yÇu’$a;¦e­UîÕu,£€U(0ë™	ûO::÷úü:¸ô–¿=4¯Ïn{¶,_\\?-µj…lvŠëØífªWª„^Kë‘cÛ˜B5‹æ¥}€§2YcHÝÇ\\~ÝøÓ­‡~\"?ôGN?ëR€;Ž<ôàä”wÞï«¨=<¯•‚±y@ùÝÛþýíy¢«GVd&ÿõÎöZÊà†=8ñÙ¦e“ŠehNê¬Nµ’Îdq-k‹}îö€ü\00¤g.ÜùÇsæiCÑ´8Hù×ë\\tñ°r[ß!ûì¿÷þqô¾CGvŠKt‚±°uIn«ó<F.]JR,(.½ùcS0Cí(`p»ö‹›îƒòdMÕÕA…;ðe*<ú¥$IÅ´ÚÚÆÝu\\¿’º5X—ìÖ7JEL!QÐô0H!ê>YUÎÇ?xÿÆŸþxð¿žyÞW‹™ûÅšW®ÀÈeÅøø•Ïžë·¹e=Ã^ÛŠè\0Ó-«©éÕ§LùÉR÷ñb®7‘ûþ¬qê‰\'òðCâÂ_ðÐQCóÚ[ïŽw]W5y-)¢ß ìy^ñÞ¶MÇ¶˜ùßïÜœ´¶ç]|öé/\07?6ùÅÙ!]©[„®í-ÄÆØ‡¸+--~ìuÞ}ÿs~~Ù÷¹àÜI%“L~~Fq‡U:ÖXíÖ·Ÿ]×J¹Ûù†Ïu:ºƒ¿ÙkJ4ÿP˜>óãÀáx¼S\\¢ŒKÖÐ°&—ôV²äž{’@5ãö<<6o¬ji¡5›ÛqÀØóp]o‹¦æƒòäHD\0²ß¾´Äæ·ï¶m¯½-ÇsEÕx!Ó\0-ûìcðÀ*XÍûv¡¦Û. íjPºpÑÏÆóÈ¯F€÷xòñƒŸ›úæ¼šê*¾ZÜHãŠ•d³¹b<èõõÊ¸³)K¯ä¥Ç»ÔÐ²|´‘c4†Ìûìk®úÕxèþçŸ3
(ò1‡Êko½;ÞóÛ—<Ï£¥µu½ÚÌ›iB`[&…L†B.ËìWž+ÞÛU•QN?u(}ûö³ARhhXÎ¤ç¦’L¦ON:ïÔ~â…Wf[¶M&—#›/ˆN…-Èƒ€¾ñx„\\Îà•×>äù—Þ`Òso±zù«\\qù¸âòø§Ëàà	†[ÉÃb[ð¼5Ðk¯ì”ýí®q¾ès‹“F
þöÏõNÿ9®ÿ¾œ£ç”ÞÃsýÏêùRaPæKž!WˆJàŠÇ•jP{‚Zr’¤ U
0TQµN”ëã’Õ×o3€\\nµÕ	’éM-ÉŒƒØuœµròë×4Ñî¤i%…§‘GÀv,Ç^÷&Ã¶Ë™ÇH¥m^ŸÕÌÿ>I³G¿ýÞj†´„®ÝwE
ïÃÃ\\’ðXÿó”QGŒ~aúÌFEVi:Ë›šIçr˜‚õ<P4æsI„DQU	”_K¦ræ¹œ_öü{¼ÎùçÙ”^õÎ”òÊëd:ý­ƒ²ëº˜Flk’¦¼\\‹HÃF†¶¿ï
Ø$Ð$$»ï¼‰›oý÷üå!€çÎ9é¸ýÿñÔ3M«š#(J
¶éWù­QÉðå‚bÏ¶ãÐ¼ªžx,L¾`¢(²$±zu+«šZ±l§@nºåÞ«ç´är`ö:\0dÛ\\·¸EAlüÞa·íãE9G×¼Ýåµrð^> {6=j5vî­·™Pº”Æg;íÝìãoŒ·a«ˆE)˜&ÞŽÆ”„\\Ç]+K—º%¯]ÀŽ¦ªE@®[¶,x´NxÈEiÃ­¼½‘Úðµ\0ç†¯þ7/Í“/,E×çsÀÞsùõÏ¿d¿Žáá®¦nîêæ~>xê¤ÃF?7õÍFÏ{^“G:ëbÙë\'Íh«‘\\]^ù€òûËW¤\"\0côwžyBã‚KÃâeüö–»ž;vèÁ¯Ìzgž[Oe2krwoÖùàb
dSI€óžµ5•~è\0\\×dÆ›uüå¯“¨›ûƒîÉÏ/;‡‘#äî»n¥¾ák&M~¹\'pEX×Ç…B:²´åºhÊy&J&3UŽãÒ½{5¦eÓÚšcèáû0ù…÷øì‹¯™;÷+\\WìxÃ¤`XþÄò6\"í­ãowí­Áöå­åõÜ6á˜5Ïw×Øiwü›hX¦KB¥kÍ§ô¨ÕÐCE Yùtºí:Á¸d_|±mµ>ùò{XŒ‹€\\ò«éÀVÙB’‹ ÂÔwP¨–µåm–ë’ •d-\"‰Ü¼Þ±¸|±0ÍœÏ’üæçiÎc2í¥?3ò„ëŠ |Ê¨#FOzcF£[¦èTÒF^÷<%2’„Ò÷˜WÔHöAùû<À‹ÿrÓ¯/¢¾¾‘G›Þ?nèÁ/¿ùö¼ |ízž›YkË×¦ßëBhÄ\"Ã\0zôèÂGs¾bÏ=zsÍ/*Ò…Ö7,gÒso²ðË)ì²K®¸ü\"&M~`˜çy~WÎ–Û‚—Ï[Ûå“æ¾„}öîËN}º¢*2ñhˆ7g}Â“OÏÄ0,:­Ýœï—èãrklÜ&Ç!h×Ûñ.p‰7y­¹%Y–Ër¥\"ØvèT´{	EFGˆVVÒÿÃ§Ìï­£é¸}In˜ÿUš?þõcV4\\uùYL{ùFm”O;røèIoLoœ)×óÈæòëå wW×TT%†WYI$^A(Ã×€_”Ï:÷>&ýçZ~ð·\0EP>þˆÃ¿8ã­yA$Ãu\\Ülfƒ<õ˜xž`ø\"HX6¦i3ÿ‹¯× bI$*HTU€W ™,JE&s…¶í¬3’ñm2À¥ÀMÍ­=ßûàszt¯F’àë¥Í,jX€ñàËÎe^D;mô”Es?ê‰N0î´­uñÖïémÉk(ËÂ#.äv²WÎÛÜáK(há0·
IVØwØ¨)F.;Å6MlËÄÈçŠ}×ÍK“ÀóføÏäzlçi®»JfÚ+÷2ò¸+Pþg¢¢â„\0\\TU¡9)z„KÄ¨ËÓª','1','test','2015-11-13 23:32:41');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------
