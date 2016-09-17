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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `departamento`
-- -------------------------------------------
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE IF NOT EXISTS `departamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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
  `tipo` enum('PC','Notebook','Otros') DEFAULT NULL,
  `id_marca` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_marca` (`id_marca`),
  CONSTRAINT `fk_equipo_marca` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- -------------------------------------------
-- TABLE `marcas`
-- -------------------------------------------
DROP TABLE IF EXISTS `marcas`;
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

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
  `condicion` enum('Presupuestado','Garantia Reparacion') DEFAULT NULL,
  `estado` enum('Ingresado','En Reparación','Reparado con Cargo','No Fallo','Reparado sin Cargo','Retiran sin Reparar','Plazo Vencido') DEFAULT NULL,
  `transporte` enum('(Ninguna)','Enviado','Entregado','Avisado') DEFAULT NULL,
  `finalizada` tinyint(4) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_EQUIPO` (`id_equipo`),
  KEY `FK_CLIENTE` (`id_cliente`),
  CONSTRAINT `fk_cliente_orden` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_orden` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE DATA accesorios
-- -------------------------------------------
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('1','Cable corriente');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('2','Fuente');
INSERT INTO `accesorios` (`id`,`nombre`) VALUES
('3','Cable corriente');



-- -------------------------------------------
-- TABLE DATA authassignment
-- -------------------------------------------
INSERT INTO `authassignment` (`itemname`,`userid`,`bizrule`,`data`) VALUES
('admin','2','','N;');
INSERT INTO `authassignment` (`itemname`,`userid`,`bizrule`,`data`) VALUES
('usuario','1','','N;');
INSERT INTO `authassignment` (`itemname`,`userid`,`bizrule`,`data`) VALUES
('usuario','3','','N;');



-- -------------------------------------------
-- TABLE DATA authitem
-- -------------------------------------------
INSERT INTO `authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('admin','2','','','N;');
INSERT INTO `authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('super','2','','','N;');
INSERT INTO `authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('usuario','2','Usuarios normales','','N;');



-- -------------------------------------------
-- TABLE DATA barrio
-- -------------------------------------------
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('1','Cordon','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('2','Reducto','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('3','Centro','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('4','Punta Carretas','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('5','Carrasco','1','1');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('7','Liceo 1','2','2');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('8','Centro','2','2');
INSERT INTO `barrio` (`id`,`nombre`,`id_ciudad`,`id_departamento`) VALUES
('9','Centro','5','6');



-- -------------------------------------------
-- TABLE DATA ciudad
-- -------------------------------------------
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('1','Montevideo','1');
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('2','Durazno','2');
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('3','Sarandi del Yi','2');
INSERT INTO `ciudad` (`id`,`nombre`,`id_departamento`) VALUES
('5','Trinidad','6');



-- -------------------------------------------
-- TABLE DATA clientes
-- -------------------------------------------
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('4','','Fernando Rodriguez','32233222','Chebay SRL','18 de Julio 1234','fer@gmail.com','www.fr.com.uy','099332222','Nossar','adasdasdasdas','0','0','1','2016-03-09 21:13:07');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('5','','Luciana Ruidiaz','47208665','LR Abogada','Cont. Abayuba 2581 / 201 Block L','luchynat@hotmail.com','www.lrabogada.com.uy','099062558','Agencia Central','No aplica','1','1','2','2016-05-22 16:24:03');
INSERT INTO `clientes` (`id`,`id_empresa`,`nombre`,`rut`,`razon_social`,`direccion`,`email`,`web`,`telefono`,`agencia`,`nota`,`id_departamento`,`id_ciudad`,`id_barrio`,`fecha_creacion`) VALUES
('6','','Daniel Alfaro','20911118882','Dar Soluciones Informaticas','No aplica','dalfaro@dar.com.uy','www.darsoluciones.com.uy','099111222','Nossar','','1','1','2','2016-05-22 17:37:26');



-- -------------------------------------------
-- TABLE DATA contactos
-- -------------------------------------------
INSERT INTO `contactos` (`id`,`id_empresa`,`nombre`,`apellido`,`telefono`,`email`,`id_cliente`) VALUES
('1','','Ramon','Gonzalez','099338833','gbg933@gmail.com','4');



-- -------------------------------------------
-- TABLE DATA departamento
-- -------------------------------------------
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('1','Montevideo');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('2','Durazno');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('4','Canelones');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('5','Florida');
INSERT INTO `departamento` (`id`,`nombre`) VALUES
('6','Flores');



-- -------------------------------------------
-- TABLE DATA equipos
-- -------------------------------------------
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('14','','ASDASDASD','ASSS2222','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('15','','VAIO SH22','NV3388899929','PC','2');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('16','','XM449','AM2123MMAS122','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('17','','RF711-S02US','SA112SSA333','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('18','','RF711-S02US','AS2221CVCVS','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('19','','RF511-S02US','AVVSS2222333','Notebook','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('20','','C45-C4320K','SF333FFGG44','Notebook','5');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('21','','VAIO SH22','NV3388899929','PC','1');
INSERT INTO `equipos` (`id`,`id_empresa`,`modelo`,`nro_serie`,`tipo`,`id_marca`) VALUES
('22','','sdasdasd','asdasdqwe1','PC','1');



-- -------------------------------------------
-- TABLE DATA historial
-- -------------------------------------------
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('1','','2','Create','Success','Creo el cliente:Fernando Rodriguez','0','2015-08-13 22:26:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('2','','2','Create','Success','Creo el usuario: nacheen','0','2015-08-14 19:13:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('3','','2','Create','Success','Creo el usuario: chachan','0','2015-08-14 19:35:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('4','','2','Create','Success','Creo el usuario: ramon','0','2015-08-15 12:31:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('5','','2','Create','Success','Creo el usuario: joaquin','0','2015-08-15 12:38:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('6','','2','Update','Warning','Modifico el usuario: joaquin','0','2015-08-15 12:41:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('7','','2','Update','Warning','Modifico el usuario: ramon','0','2015-08-15 12:43:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('8','','2','Delete','Error','Elimino el usuario: joaquin','0','2015-08-15 12:55:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('9','','2','Delete','Error','Elimino el usuario: ramon','0','2015-08-15 12:55:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('10','','2','Delete','Error','Elimino el usuario: chachan','0','2015-08-15 12:59:08');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('11','','2','Create','Success','Creo el accesorio: Cable corriente','0','2015-08-16 11:01:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('12','','2','Delete','Error','Elimino el cliente: Nacho Castro','0','2015-08-21 20:31:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('13','','2','Create','Success','Creo el usuario: gasgas','0','2015-09-06 11:55:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('14','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 12:14:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('15','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 20:46:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('16','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 20:53:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('17','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 20:55:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('18','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 20:58:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('19','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 20:58:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('20','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 21:00:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('21','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 21:01:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('22','','2','Update','Warning','Modifico el usuario: admin','0','2015-09-06 21:01:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('23','','2','Delete','Error','Elimino el cliente: Gaston Baldenegro','0','2015-09-08 23:47:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('24','','2','Create','Success','Creo la orden: ','0','2015-09-10 21:04:39');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('25','','2','Delete','Error','Elimino el equipo: A44','0','2015-09-10 21:16:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('26','','2','Delete','Error','Elimino el equipo: ','0','2015-09-10 21:16:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('27','','2','Delete','Error','Elimino el equipo: A504','0','2015-09-10 21:16:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('28','','2','Delete','Error','Elimino el equipo: PC','0','2015-09-10 21:16:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('29','','2','Delete','Error','Elimino la orden: 1','0','2015-09-10 21:31:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('30','','2','Delete','Error','Elimino el equipo: SAB1234','0','2015-09-10 21:37:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('31','','2','Create','Success','Creo la orden: ','0','2015-09-10 21:50:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('32','','2','Delete','Error','Elimino la orden: 2','0','2015-09-10 21:50:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('33','','2','Delete','Error','Elimino el equipo: S3','0','2015-09-10 21:51:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('34','','2','Create','Success','Creo la orden: ','0','2015-09-10 21:52:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('35','','2','Delete','Error','Elimino la orden: 3','0','2015-09-10 21:52:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('36','','2','Create','Success','Creo la orden: ','0','2015-09-10 22:01:15');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('37','','2','Delete','Error','Elimino el equipo: aaaaaaaaaaab','0','2015-09-10 22:02:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('38','','2','Create','Success','Creo la orden: ','0','2015-09-10 22:04:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('39','','2','Create','Success','Creo la orden: ','0','2015-09-10 22:05:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('40','','2','Delete','Error','Elimino la orden: 5','0','2015-09-10 22:07:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('41','','2','Delete','Error','Elimino la orden: 6','0','2015-09-10 22:07:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('42','','2','Create','Success','Creo la orden: ','0','2015-09-10 22:10:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('43','','2','Delete','Error','Elimino la orden: 7','0','2015-09-10 22:11:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('44','','2','Create','Success','Creo la orden: ','0','2015-09-10 22:12:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('45','','2','Create','Success','Creo la orden: ','0','2015-09-11 19:39:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('46','','2','Update','Warning','Modifico la orden: 1000','0','2015-09-11 20:40:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('47','','2','Update','Warning','Modifico la orden: 1000','0','2015-09-11 20:40:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('48','','2','Update','Warning','Modifico la orden: 1000','0','2015-09-11 20:40:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('49','','2','Update','Warning','Modifico la orden: 1000','0','2015-09-11 20:42:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('50','','2','Update','Warning','Modifico la orden: 1000','0','2015-09-25 23:50:22');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('51','','2','Update','Warning','Modifico la orden: 1000','0','2015-09-25 23:51:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('52','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-20 21:10:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('53','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-20 21:11:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('54','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-20 21:11:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('55','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 16:27:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('56','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-24 16:29:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('57','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 16:31:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('58','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 16:32:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('59','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-24 16:32:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('60','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 16:33:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('61','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-24 16:34:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('62','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-24 16:34:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('63','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 16:53:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('64','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-24 16:59:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('65','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 16:59:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('66','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-24 17:01:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('67','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:08:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('68','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:08:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('69','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:10:50');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('70','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:15:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('71','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:16:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('72','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 20:17:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('73','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:26:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('74','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 20:27:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('75','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 20:27:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('76','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 20:28:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('77','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 20:29:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('78','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 20:47:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('79','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 20:59:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('80','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:00:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('81','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:05:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('82','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:06:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('83','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:07:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('84','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:10:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('85','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 21:11:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('86','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:14:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('87','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-25 21:16:54');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('88','','2','Update','Warning','Modifico la orden: 1000','0','2015-10-25 22:34:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('89','','2','Create','Success','Creo el usuario: jaja','0','2015-10-26 21:17:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('90','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-29 21:21:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('91','','2','Update','Warning','Modifico la orden: 1001','0','2015-10-30 18:18:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('92','','2','Create','Success','Creo el barrio: ','0','2015-10-30 21:35:58');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('93','','2','Delete','Error','Elimino el barrio: ','0','2015-10-30 21:36:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('94','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-03 21:25:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('95','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:37:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('96','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:37:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('97','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:37:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('98','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:37:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('99','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:37:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('100','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:37:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('101','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:38:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('102','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:47:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('103','','2','Update','Warning','Modifico el usuario: admin','0','2015-11-08 20:49:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('104','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-10 20:59:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('105','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-21 10:10:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('106','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 20:39:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('107','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 20:49:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('108','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 20:55:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('109','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:03:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('110','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:03:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('111','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:07:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('112','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:09:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('113','','2','Update','Warning','Modifico la orden: 1001','0','2015-11-26 21:14:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('114','','2','Update','Warning','Modifico la orden: 1001','0','2015-11-26 21:14:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('115','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:33:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('116','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:34:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('117','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:35:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('118','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:35:59');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('119','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:36:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('120','','2','Update','Warning','Modifico la orden: 1001','0','2015-11-26 21:40:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('121','','2','Update','Warning','Modifico la orden: 1001','0','2015-11-26 21:44:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('122','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-26 21:46:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('123','','2','Update','Warning','Modifico la orden: 1001','0','2015-11-26 21:50:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('124','','2','Update','Warning','Modifico la orden: 1001','0','2015-11-26 21:51:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('125','','2','Update','Warning','Modifico la orden: 1000','0','2015-11-30 20:37:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('126','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 18:59:01');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('127','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:32:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('128','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:47:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('129','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:51:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('130','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:51:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('131','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:51:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('132','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:52:02');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('133','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:52:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('134','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:52:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('135','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:52:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('136','','2','Update','Warning','Modifico la orden: 1001','0','2015-12-02 19:54:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('137','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:54:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('138','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-02 19:56:17');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('139','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-03 22:12:28');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('140','','2','Update','Warning','Modifico la orden: 1000','0','2015-12-12 19:43:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('141','','2','Update','Warning','Modifico la orden: 1000','0','2016-01-06 20:24:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('142','','2','Update','Warning','Modifico la orden: 1001','0','2016-01-20 19:40:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('143','','2','Update','Warning','Modifico la orden: 1001','0','2016-01-20 19:41:37');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('144','','2','Update','Warning','Modifico la orden: 1001','0','2016-01-20 19:41:40');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('145','','2','Update','Warning','Modifico la orden: 1000','0','2016-03-09 20:05:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('146','','2','Update','Warning','Modifico la orden: 1000','0','2016-03-09 20:05:18');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('147','','2','Update','Warning','Modifico la orden: 1000','0','2016-03-09 20:05:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('148','','2','Update','Warning','Modifico la orden: 1000','0','2016-03-09 20:05:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('149','','2','Update','Warning','Modifico la orden: 1000','0','2016-03-09 20:05:55');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('150','','1','Update','Warning','Modifico el usuario: gbg933','0','2016-03-09 20:37:36');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('151','','1','Update','Warning','Modifico el usuario: gbg933','0','2016-03-09 20:41:56');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('152','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-03-09 20:45:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('153','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-03-09 20:46:09');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('154','','2','Update','Warning','Modifico el usuario: admin','0','2016-05-18 12:44:38');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('155','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-05-18 12:45:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('156','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-05-18 12:45:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('157','','2','Create','Success','Creo el usuario: usuario','0','2016-05-19 13:33:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('158','','2','Update','Warning','Modifico el usuario: usuario','0','2016-05-19 13:34:27');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('159','','2','Update','Warning','Modifico el usuario: usuario','0','2016-05-19 13:55:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('160','','2','Update','Warning','Modifico el usuario: usuario','0','2016-05-19 13:55:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('161','','2','Update','Warning','Modifico el usuario: usuario','0','2016-05-19 14:15:14');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('162','','2','Update','Warning','Modifico el usuario: usuario','0','2016-05-19 14:48:31');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('163','','2','Update','Warning','Modifico el usuario: usuario','0','2016-05-19 14:52:46');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('164','','2','Update','Warning','Modifico el usuario: admin','0','2016-05-19 14:52:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('165','','2','Create','Success','Creo el barrio: ','0','2016-05-20 11:26:24');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('166','','2','Delete','Error','Elimino el barrio: ','0','2016-05-20 11:26:33');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('167','','2','Create','Success','Creo el ciudad: ','0','2016-05-20 11:42:41');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('168','','2','Delete','Error','Elimino la ciudad: ','0','2016-05-20 11:46:47');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('169','','2','Create','Success','Creo el contacto: Ramon Gonzalez','0','2016-05-20 18:20:19');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('170','','2','Create','Success','Creo la orden: ','0','2016-05-20 18:58:34');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('171','','2','Update','Warning','Modifico el equipo: jag','0','2016-05-21 23:06:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('172','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-05-22 13:34:32');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('173','','2','Update','Warning','Modifico el usuario: admin','0','2016-05-22 13:34:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('174','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 14:38:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('175','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 14:40:21');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('176','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 15:01:00');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('177','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 15:01:48');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('178','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 15:05:43');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('179','','2','Update','Warning','Modifico la orden: 1001','0','2016-05-22 15:11:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('180','','2','Update','Warning','Modifico la orden: 1001','0','2016-05-22 15:12:25');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('181','','2','Update','Warning','Modifico la orden: 1001','0','2016-05-22 15:27:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('182','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-05-22 15:59:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('183','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-05-22 16:07:11');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('184','','2','Update','Warning','Modifico el usuario: gbg933','0','2016-05-22 16:07:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('185','','2','Update','Warning','Modifico el usuario: admin','0','2016-05-22 16:07:30');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('186','','2','Update','Warning','Modifico el usuario: admin','0','2016-05-22 16:07:53');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('187','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 16:09:10');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('188','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 16:13:29');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('189','','2','Update','Warning','Modifico la orden: 1002','0','2016-05-22 16:18:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('190','','2','Create','Success','Creo el cliente: Luciana Ruidiaz','0','2016-05-22 16:24:03');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('191','','2','Create','Success','Creo la marca: Toshiba','0','2016-05-22 16:35:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('192','','2','Create','Success','Creo la marca: Dell','0','2016-05-22 16:39:44');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('193','','2','Create','Success','Creo la marca: HP','0','2016-05-22 16:40:05');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('194','','2','Create','Success','Creo la marca: Olidata','0','2016-05-22 16:40:20');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('195','','2','Create','Success','Creo la marca: Acer','0','2016-05-22 16:46:35');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('196','','2','Create','Success','Creo la marca: Lenovo','0','2016-05-22 16:46:51');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('197','','2','Create','Success','Creo la marca: MSI','0','2016-05-22 16:47:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('198','','2','Create','Success','Creo la marca: Asus','0','2016-05-22 16:47:23');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('199','','2','Create','Success','Creo la marca: Getaway','0','2016-05-22 16:47:49');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('200','','2','Delete','Error','Elimino la marca: Getaway','0','2016-05-22 16:48:12');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('201','','2','Create','Success','Creo la marca: Gateway','0','2016-05-22 16:48:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('202','','2','Create','Success','Creo el ciudad: Trinidad','0','2016-05-22 16:49:13');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('203','','2','Create','Success','Creo el barrio: Liceo 1','0','2016-05-22 16:49:52');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('204','','2','Create','Success','Creo el barrio: Centro','0','2016-05-22 16:50:16');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('205','','2','Create','Success','Creo el barrio: Centro','0','2016-05-22 16:50:42');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('206','','2','Create','Success','Creo el cliente: Daniel Alfaro','0','2016-05-22 17:37:26');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('207','','2','Create','Success','Creo la orden: ','0','2016-05-22 17:40:04');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('208','','2','Create','Success','Creo la orden: ','0','2016-05-22 17:41:06');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('209','','2','Create','Success','Creo la orden: ','0','2016-05-22 17:42:07');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('210','','2','Create','Success','Creo la orden: ','0','2016-05-22 17:43:45');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('211','','2','Update','Warning','Modifico el equipo: VAIO SH22','0','2016-05-22 20:56:57');
INSERT INTO `historial` (`id`,`id_empresa`,`id_usuario`,`tipo`,`estilo`,`descripcion`,`visto`,`fecha_creacion`) VALUES
('212','','2','Create','Success','Creo la orden: ','0','2016-06-02 19:57:40');



-- -------------------------------------------
-- TABLE DATA marcas
-- -------------------------------------------
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('1','Samsung');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('2','Sony');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('4','Otros');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('5','Toshiba');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('6','Dell');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('7','HP');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('8','Olidata');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('9','Acer');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('10','Lenovo');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('11','MSI');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('12','Asus');
INSERT INTO `marcas` (`id`,`nombre`) VALUES
('14','Gateway');



-- -------------------------------------------
-- TABLE DATA ordenes
-- -------------------------------------------
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1000','','14','2015-09-11','','','La falla es nueva','Se diagnostica con mal de parkinson


y arroz','No hay','12333333','Garantia Reparacion','Ingresado','(Ninguna)','0','4');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1001','','15','2015-09-12','','','La falla es aleatoria, es un error de pantalla azul.','Esto es una prueba de diagnostico','la solucon
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1002','','16','2016-05-20','2016-05-20','2016-05-20','Tremenda Falla','La verdad ni idea
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1003','','17','2016-05-22','','','No inicia','','','','Presupuestado','Ingresado','(Ninguna)','0','6');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1004','','18','2016-05-22','','','Falla S.O.','','','','Presupuestado','Ingresado','(Ninguna)','0','4');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1005','','19','2016-05-22','','','Vuelve con la misma falla de pantalla azul','','','','Garantia Reparacion','Ingresado','(Ninguna)','0','6');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1006','','20','2016-05-22','','','No inicia','','','','Presupuestado','Ingresado','(Ninguna)','0','4');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1007','','22','2016-06-02','','','xczxczxcz','','','','Presupuestado','Ingresado','(Ninguna)','0','6');



-- -------------------------------------------
-- TABLE DATA usuarios
-- -------------------------------------------
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('1','0','gbg933','af5a9f4653c88fd965e1182505695b362930b285','4681','Gaston','Baldenegro','Cont. Abayuba 2581 / 201 Block L','gbg933@gmail.com','099394334','����\0JFIF\0\0\0\0\0\0��\0`Exif\0\0II*\0\0\0\0\01\0\0\0\0&\0\0\0i�\0\0\0\0.\0\0\0\0\0\0\0Google\0\0\0\0�\0\0\0\00220�\0\0\0\0�\0\0�\0\0\0\0,\0\0\0\0\0\0��\0C\0	!\"$\"$��\0C��\0,�\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0	��\0T\0\0\0!1A\"Qa2q��#B����$Rb�3r���4C���%DSTs���56u�	&cdt����\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0<\0	\0\0\0\0!1AQ��\"2Baq������R#$3��4CSb����\0\0\0?\0��a4��ZH؛3_a{��1i�%,��UD̑��W%���`I��6�w��Lr�%�Ie:
yr�L)ꤨ��9d�4�93zẍ́��-\\[Y�j6m��7����EX�;��~���dFdi���̉s9VmK$d-^[2��R��k��Ǟ=$p��u	�D�E*	��۽��2��<�lv���i2�^�)eNޜ�H&gIԁg��\\���q���#�$�U�f$S�+��07\0�m|e���ڵ�>>:����a�eҠ�y��2�ғ��!p�8ډ�|/}G���w��,��3�*��Zs(�p�Ǹn�����Uô��O�;J��;�.L�6fP:��ߖ�\0\\m����:3F�HU�X5Ř�N�pm�=���`�5)U94+�����X����z-96yQIP��M_�Q��
P̖\"�j�GK����\\���s苌k��gH��Mm�S\"���I�����v�{���ٔ�I6�~�3��\'0����p��D�J!%A���l;��i�@��U0�8t.;�bf����И|(���F*�^1����\\wF%̫������i8�N%�F�@èY}��9a��d
|�)XVS��D2��jSq���T�uY|�VƏLþ�Xoϧ,\0s%�6�AP���geAX�[TӴR����u,U��S������ʸ{��z�� ���x��%U+R5��X)�P���E�m���;#�Ltt�j�ҩ*�
��9\"TIMB���%Ph�і �4���[�6�8!k_h�w�g�e�6X��G �ۑ}�mϯ������hީU{6P�=�e`z�T�k�l�\"�Ȳ*�U��ap
M�@(��q(S�z�]3���2�G9L����ѣvrFB-��Q�m����`It����fEU��e=:��%�i���.l
{����-����_��\0��v5�N^�<����p�f��,}�\0����_e���f<\'�sP8f�=���SJ��J�!�����$\0E�q�,ׇ{�GC��c
jԁ��l4�����x��[G�H��&�Z�W&�j {IW�m}ԅ7��l*���9�*
�b�ꏸ!���$
�|1&�{Cވ:�ҵz���ݎ�NIL�k�X���� �/���[i��8���H��<<�V\"=4���^�9���d�GI9c$�q����<�}���>��ޏ�0�#���G!#Q��ŕ-Y���2���q*	���C�1�i-2�Xr�W�5u�����q��[�Ҷ�J(��)�	o��M�]��#Xȡj0ܽ��M����=��������>�˺Hb-�۩��<��|ަ����>���2������*� &id����8��A��� �/h_��o��Q�Y�4�*&���XClJ����6�=1���ҟ�����^�yd�@��@׹����n}1(��2�j�ٳ(k��f��n�\0���t
=������*��3��%���w�	I^�I���������~r�5��#��gZ��s)&�	I�lM��M�6�݉y�R���T�YP���Q��~�o~Xo8HV�3Ju��Z
2�e6_M��PT�F��h�E���
[�m�Sa��K��n����K��H�$FCue�_/.�.�#�I@�?d\\]%^I4˥.X���y�v67�k~�$Ir�g����S��@���lN���@����z<�ii)�L=f�UnK��K(eņ0Q�+a��<���C^��ҏ\'��Uꨳ
Ag�x��E�0H� b��2��L��v�,����97ǟ�{��3}^���O-Aq+S���x0$5���^{^����D�\0T��K@-�u3`���c�I���孹�W�1��3�2ƞFf���/�%#�\0�0HA��/�t c5d=&�5X[E�ӪiX�_��d��\0��\0�b&g��O�t�O(����l�o:*����rOQh7�lU���ӨD�yk�K�[�0�\0�Ӫ�cA�\\h^\"�\0��v�+�ci��?��p�Y�e��HG�ck���I\"5���x~��3�ioa�Įް�|�������h������C��6��}kp�}�i���ja�7��|���XK\'+a�	m����\')�-��Ğă�Ë\0���f��*)�,�d*@n�ec\\;���7�
j��=���N�H⌑�gv2���0�x��F�~�Ö`!����ZI��ӕfj+(���6�4V`��]�k�$�\\u!��Q�OFmO���4OՅ��\'�\0e+���x]�7��i*�gKX�<J9T�Q��g
�`�/�Gg����40�5��T�t�2�P�N�!X�ͷS��5i�����
S� y�Ƒ��\0)�^}e�u���S�,{j�i��E���Se����<��ZSS����a��V������i�IЇ߇*2��
w��0��uy�֢���b0�$�
�djd�
KӘ�Tq���h�����b��x_$�4�kid�,ª9#:�uѤ����s�l6��.IÔ���sB��ـ�U����u�ܟ�w>8�7p���gϲ�}j�)�O&[�����\0F�3N#����&ȡ��s�+�a%AZ���J[D�ٗ=�f5��W!��bk��)��+�Vd���Y\"��=D)F�������U�/\'�2\'�2�� �syi�4U��!Og��}\"�{�笋6��U�9�O�U�Pz�S��A\0+�o�;U�\0K;H.��X�K*���τr�2n
H���������G��ݘ�os��܂,�9@�\0���U3T�������6�E�ѫ�7)\"�{���\\���EK�e�*%�i
�b��־����
:Ib����&��*;ZM��\0���s��X�S�1�I�
��e����\0î+#�.�Ujl�0XiQ��\"�n$��e[i��)*�9�����J�2�_a���Z�}�#�,a�D�v�ĸ�n5.\"��țbu,p�6�A�8\'#����\0�1٤���0٣n���p�C\'��aBw�������݅+*��
4rj~XRS�Y{�
׉��/�-@�0�E����o��YZ9R���¨�-��r����\\P������X��U[��K�\"؇]��K<�c���ᆦ�0�1A�\"�L�9��$��k!^�k�a�5$jP�v{�O�eq��Z>�i2�:A���Y��֥YkR����u�3�ř�tЬ�c�{zʍz��\0�6�`-��x�����*�sL�/͘*TVB@�A�*�C��ʡ���ߠ�������A2\\�<uC�4*F]*L�
�ʫ�����[��\0%n
�i���2��2�&�|�&�:Yk����^��,k{
�\\˫a��x��f��}%UNs>G-2T�R�%Lj
bTqU/���SN����I��~B�����͗�FY/�����~�%��U���Aԥc�1�8����c�}WLC����dҩ}]�f;{�DL��L�)���&�o�{��csiyX_�K�y���?P�qK��~�W�3��E~�WGQ;���aٛ����|a+������4D���fV�)��,5=}<�/��s��.�����9�4lՙp���QJ�� ��;�a�^��0��\'��hw@7��p�WP!jz���E�YJ�|�:��YT�!Q�=VN�(�z��OdҔU7����V�#��\"�jƖ��2§o|dxbgR��qQ*�n��_��397���*�9���9��7^��)����I_�g��Z�҃���J����R-�d�+���^Q�C�gTJ��idco�����վ0�SK�\0X�*���ӛ��vO�<|Mԃ#�X�����`�����ϩ�+��q\\P���1��C���?���%����s�e��;���k�$o�1�CM�˫��3(�o=R[ry�����%e߬(^�_��/�CE2��������W�����%�P��z�7����I�.�w��Ï)l4�s�SYw��6<�K�m�I\\T�0ນW�KG:J=�P�����мO۵�q
쳈r�KiQS��f;�����c����f�d!e*J�q��㍴�Ө.�y��Ԧ}pD�%�o����bR���Q�[ؒ-����O�e���C5u4uN���+0��#��q����#�ٙ_I\0\"�Wߩ�s�\\A0{7�hG�*�#\0�F������F׶2?HiM]�l�c\\���B�`��l�(![Y*E�ݶ<ɇ�	,C-�+}k�j���2˱�\0���.,7���qW�W6e�����1T$ݨ��3v����a{\\��5X��_K��i9vo�VdYeDU�@{x�3
��x�I�H���_H����Q��|UmONeI�V�L���(�I��6�˗3�>}YOg��Z#�i�SD\"�*�\"�up4�,
M܎�(`�Z��*�ԍ�Qi�
,�!�A��᤺G�(}���s.����3Y����-�3K��T��)&��1,�6���V���_M��R6A�S����,���U\\:��.�Q��H��X2`��(�U�}L�96nGP,I{۝�N�򭧏����6���#����G
Cr]\'U������`%�&
�Q�=�J	��G3�K�E�m�u<�����y�I=����Ҭ��\'a��XcPi�3���t=)�!�Tpw���/{x�e��e�C�M��q�i0���t	-�[b�n����V�v�F!^�u�ϣ�k!���Ji�A.�	`��v$�܀�u�9�S嬳�J%��\0{�H���-;�Q��H�dh���J����˗B9lg�J���KJҐ�K}
�k[s��B�ʪ��� 7P!FWV�UO+��$���4�c���k��<�cA�Y��OAd¡�o���},n
�ڈ$��q�I�3����$�{��eUVAqqu����y_�T��u��i�Q�H�I��,6���Ќ:�\0l_�(��x{��d�@2�+�$�L�=PJK0��d����I���co��#ͩ\"��-����IN�xǗ�_I�?C��Fk��g�M,mF��CYAH�z\\8<�$|:�T~���Eg���CE
�Vu�3�X�v���`��7�{4�\"�qT��]��Ut\\qU������U�!�l��ob�hc~��mݓ1�;��z�ߞ8�i*xޖ�K�̌H�ɱ;t��\\H��.#c����Te��H#�)��I�Mt�i�Ѭ,`�����Z��K��\'�/�,.Dc� z3��/�?]K�qT��	��-=#����\0�7���_�8��m��u��6�Ϥ��|��\0���\0p��фm�<��T_���s���8��;���?��]<����D���5�\0gm�;ˌ���!2�
���>��2�|<�H�Eh�`ې-��,K������P�-k�`�o���fB]g������,7+��mǎ	 �j��#��iR ������R�mq���������y���<�wC�v0�t��,�B���~|ɽ�[4�����%S@�;�^���\0��c֪1-�c���J�2G����e�<�orG�<]p��)�J�]^�� �rN*�]��S��;�j�߅��
g�R H��_��D��1<��M��3�x��9�����S�)�Ω�\"]K�6����6�a���1=��цt*�d�AR`��?��|^�\0g4�7�K.[+Ɣ����o{tƱ��UMA��7>�Yq�y���o��r�ʑ�Bv(@\0^�#\0ML8v���Uv�xٸ%-��M��-:+|��&W�SC,�=e4Q]�&a4j��p1qSA�S�2n�3Z9I�UW��H6��G�|q�	�����ɗIم�ԛ�@Ϟ�DXJ̃��s2�2��3��MU\"M�VE�F�,/�*�ƨ��\"~�F��i=?pȬ���mIQ��O��z?
\\�?[WuF�Б��������ZUhJʪ�~�;�ø�y�E���z���8�$����A\0X`�^a
��yp���:�J�Ξ�<�˗U��3on�E:f�\\�a��\0J�?]�+[��	���1�A$��AA�I�νV�.�F��k	A���<�J��9*2���$�a��S�Wh���
�6[)6 bI�Z��j�h!E�j��j���e��jy���:��i��R�RJ��jRM�H$��q~I����J��$�)йԤ1���5�l.��)��6c�y-e},�6AM#v3�����!�E��؍]���8��0ͪ��c�zZ�U�cf\\��j���K[k��U�^[͏��2�ƕdV�$s��,J,�`{�WW05]n\0؜����4��\\S*����J�Ycʐ#H��F�(\"��a|`U��L������,�ݿ�눭T���$Q�J6[���0���kOZQT�QY���7�K�uT�`I��&���<�a�+i�<�W���i��/�H�B�_n^�0}�9\00�X��I_r3��D̷I�\"�;j���q�(h�Fg��t����RP�!P�H��1s�����b*9-��^�m$;AN?��0��hYj�dT��,�j$��	�����c��(�u(f=�ssc�#�^V�n�[�<E%6w5{傮�׼����.��zt�*��{��oP��{��s�c��Ņı��SP҄�����\0_s�m���Ft�,����\0���L�GO�_�V,���c�92i�r�\"f�$��h�B6���ܬA�p�頄�kG5<߲�]*Q�{\0��q/gU���$����?��`�,�jc�HZF$�����܍�Xrŵ\'�
��P �����8^l��Z�?��\0�N\\/r��o�>#��S���h���4`Yk� n9�$�d4�I[���+�6c|8��
�F�\'i�������l�2��/�L޳5�\\ΚJ�^�&- ��\0y�ن8o/��)��H��9���}���n_�T��4����#cp\0��S��2̲|��P6��iEe���Z�7,,A����QAn��V�\"B���ȸ&�>�\\�\0���\'��8�E`Τ��W�����b�sz<��)xj���45[�i�^�X�(�Pz��+=!fy�ET�4��]Ja��D���r�\0\0����kOOYWMU����[Tr��6=��!E��o����˫���O�t��(�ǟ>v�y~o�х�.�k��U:�VXA�1!��<�b/��^i���jsH�F���� \0��]V[�s����iZ7�HxA���V�\"�}�țr��_����5e�Z�Rji�����������Xy��|a��Mϟ?��l�%DC&WL� �b.�A\'�˝������WB�L�#0�!�lXٍ�N��^8�d:{AP������@n-k���duL��$F��7�\\���-�X��UB|O��KQ;�������Y�0(�\0^H����n|�����NL#W��0�J����Ͼ�a��bL|W��L������-�F��tț^�F�)x���H�+b�d��+�T�[���b{ֿK��T
�6Y]r 2������/L���}
���&���G_
�b�t�oX�c7`H��ߑ�R��R�IH�ēK�I\"�a{�ن�C,�j��
���i��\\�ZcF�0��s�O?���9�>5Yk�#��v�c��Ͻ�#�𹪪��㙣��lB��M����v�H��������C��:LG��/|W!Y��
�oک?Ƹ�b��ݪ���\"�<�+SZ����čq˼�E����n|9�Ɠ��c2���T�0nD��4Gya۴c����M9�����.�^�2V6�����#sϙ����C�5�5Q��H擱3\0�(���܁�+)!��a�� �Y\\�-H��٭L�;3�+��Zm~Z��+�<y�q\'��\\H�ܹ\'Z�+o�
\0`-?<3�\"�Fyјg*���~ѯ���~}/̍��}�,m�Ib���������ж鏊� ;���Ǌ3�021m�\0@�^�/owĄ�. [ZÝ�
/u~�����5�U>o40�\"�{Ѐ6��a�r��*H�kG �Z��U���!m��+<s��&Jt,ov��|��
�IL�M��*ms��ş�c<��lc�\05?��+�4Rc0����zN����.7�������y�?�$bX�T
�0�{ۦ.xc��ϲ�β	#C@��O~፯�{=p
ҋ��э�s>��1WQ���},�`�����V�zDk�\0����叏�7?W���a�PlI��;��K�)�-B,9�\0*D��� ǅ�\0$bVOÕ2���FE��ܒnH\"���g�6���G���\0���yc��<;	��X?G�;Ě�s�\"��������fm6.ꑅ\0�rI�����oX���]a��ff
��߶��N_<c��,�[^�\0mF���c^�a��M������c��������>̬̣{�	��P��Ru�ەN
e��X�a�4[I��\0�7�8�������N����s�ӎ�n\'>���ՕG,i=j}Im
��2�]�m1�h=��ؖ�}�qFi_O-[Z��ikԱ6����*g���U<��@�r�@�8M�9b�%���\0GsM.`D�H�<6ā���ƭ�SH���Q?�˾��A��Ѻ�1{~�_yƯ�PF����
�.��/����S�r��\0^W��a$��*a��b����cm���y�3Uz��G(O���^�he����l.S��rwv�{�����B��������?�\0�#�\0R����\\@�2,�\'�aC�*�IYR�dv;*��������X�d&�!Tnw����7��7ؘ�#M����br�_�mTڅ֩�����X2�Lʼ1�&����fLg49�<U5�����=�X��\'����ԋM�<_Tǻ*1�e��A���ҡ�O���/��ݧ���XM����~\'����\'��Q���7>x�y�aa�b;�K)��r���MG��/��	,w��>~$�UYUT�k��C���)�,^O�?��tԿ~
*�
��m����+s��T��~_;E�$n� X���8�saW�3&��!����w�÷�1>�
t���d��Rt�-����}�g\"��8�(�ˍo��4�R) a��6�x�+Һ�8������m��]��j�9���+zwX���|�e���m2?�deܷ�r�cܻ^L�L�\02�����*��R�s��-���li�*xg;lʦ�X�촱�8�~=�*E�:w����8��޽X�n���5��搬�3��:�HM�>xA�5���S]@��(������|����\'-�k.�M�N�s۞,��Zv?KC2e�}���%Bؘ��Ŵ���\0�\"�\0��\0{
{�\0y�wGY�$��F�ۇ]�>D���?�$Qj��� W��%�e�򨚿�)���~�˖1�J��)̬A��o��/�Ս�@�v�p7���ߥK,��]?N���lp��T��ggG.����ZZ�r����t>�?�����ZM�������({G1�ɽ�����]/9�M͠{\\���1�c��������l%�}(��+m���>V�걷!����y�DU*�>)�x���X@#�M�=YVhȷ=�
�9��EI#�p�.NY�I!M�;�8��U�9�S�0H�=ح�\"�1we2:�y��ʤ{�8Q�3F�R��[;�:U_܍���ͩ}n�\0م���Ac��)3��v@������V�\'!��.ȜF�c������~\0�~�g����Ҧ�FR��ƕ�IJ͔�S�ZyvA�
��i\'>�89��A,�1�\0Ɣ�<|*A�\0���� �BL	u���S�\0�剙Ubf0�%Dh���u#��nuT������%�\'#0�f��)���$�bs�ib�[����Vo��am����G$�����@�1I\0�Yc�I:��d]��\"���|roaF�}�%6�\0}ͦy,�F���>�?����B*L��_u+��II����Gq�M��T�O�fZ�#u��7�L�)�]\\�/��F�q��-D���K����Qё��m��������}I\'/�n�4?�+*�B��ܟ8�]Wj
Ђ�rLW��Z��_m��������/����V�Y��������Tt�[k��)֥M�fDɝ�rH��x�;H���Ϯ�ݣ����W��_�J
�#����.�A�|�����$ ���0�y>��$��s�Ik-���d��Tu�6ih�
���,P=�%6R�٩���MJ�*��V��=M�E����}DR�9ha#쇞&�T�
���XQ���0j���o�>Qg�塩�X�N�̩��lҟ�Rjؔ��R2��ǫ+2z�F�֙\0�Q�Q�%�犧����{|Ψi;�t�o�L$�����/�g�\"���Q�a��h���C��J�c,�# �7-��cq��uK+k�3��g,=�GM?���Q[��GE��3j��f7U@�-���|~p��Xl/
֙,�e@����*��Ʋ��uἹ��0õ�Q����X}����9��?[C_3wdd�Koc���<��y�
R�s�����y���`�;���[
T�������*3�:�?����:*���3��S��O������-�eR��h&?t�3oH�y)=�֨ҡ@uBm�e���S�Ǥ!U��s9бmQ����*m��a����>1>���()�
UKo��aO�;>6+�r.�}�j3�򣻘f̎��Na1��a���{��PfU@�3*�ָ&um�_�y[㷞 f=L�e%���\"[��|#��4�����b�Pp�on��|�\0�1K.O�v���K��I_W^_�~8�y
@��%�D��������C�1?~6W͸t+�B���E�CO���pަ�9`c}-i�����±^��jG�F?o�dK�q1?���h��^�rH�r�Q��[��eR�/�o��Q����-�yr/��	RAV�l���X����<aF���?i���7���\"���<t�\'Lm���<�X���8��VT;�\0�쇗Q����d�д�v:e�����ޭ���vڕ�f��~2�Q�W-ڷ�8b��VH5�}�o~��_fUݦU�HK���OO���=M�k��|/���\0L�7s��\\ms�/������D��07��$jG����(t��f����F�\'k)%f��@�s:�?����]�������
����j�m�.�I-H*>�sc�\\F�:8����?厼4�Zx�&�f��\'e�tsP�i���%���Ar���s`�iZ�H�Щ�\'����G�?�����C��0�
	ҧ�Aa<7�Dl�,�Z$�*��G�$�ǻ�#o�
>9�fxb���en`�
�F�<�bw:HaˡT��-D�>&U�����Y�`�N�Lgǘ6�1Rxo����V�^u��IIè��L��l�a��Ch�x��|�1�؎����4)6���\0�e\\����gY�q
,�n��i����z�B��u��K4�|z���#���坤�0)}J����\0I��*�lڙАB���{x}�Kaj(�� Co�ի!ݵHJ�G-����HDw���|��\0��x䫢�D��[��������fSi*�5 
F�����ϔ˼����m��������?-�>�J�4�ֱ����U�7�\0	�*b�ctc)k�?�{Zß3��
Lʖ)�^\"�����ݍ���˹��en�o�;|���S�V-��X�{����7�ǧ\\Vg�MQL�v%K�_�S����e�Ց5���6�<o���)8�0�1�`�ֿjEω#Ǘ�Ƥ�\0ֿ��ό�p������������4/r9�� �{��~a�Y��i*ͬ��m���8���ْR�����|7�����z���}
	�5S����V�������,�ܐ0F8V�äJ��b\0�p������=w�V�3$k`@b����\'`��$��W�]S�;��u��xNJ}5N��I�m�ӟ+�|%+!���|�*��8눑C!��G��ۋ̉�38\"�J��I_e�)\'�-�b���Zv��!�¾�eU�\\�_}�lVg��Z�,s$`ݡ;���Gێ3b*2�Q�PG�z����?%�S��AQ�0��x#0Ḓ��.���:�=�C�>���-KQ
 .�Q77����C�1�
򷅼�+���dec�2z�[V��%�s�q}�=�Ѩ��(��W�A\"�X��_�
S��sS����v����l����J�QPʂ�o
�k��<���\0/>}0���E�m#k�|�.^�t��D�C�ر������m��
o�x�2�����+���^����|w�&���}Ł;
�3�5���Bܮw����\0i_��Mj4����\0����s��3���5HÑ��\"�n{\\�يU�VEY�W��aq�����
2��]v,m�y�\0��bZ��
�%�^�׺�\0
*�K���;a�x�-�X�Nܭp\07���[��=P�M~ЫnN��y��Jʳ��*�ݡI�$��	��q�a�^��^�I.�ݚt|j�1HrƖ@���o��x�3�MR�)r����iN�-}́����8ꎨ�5q<[���?���<��͞�0om��4��������5$�gXdV�)#nE]�X��C�q,�z��\0{),����o<&~)��=��^�<|1~5�[h�FU,����<����Z�{KhxQv���y�%��c�-����w\"�3UT܉k�y\0-��o�M�O�S�uMs�(�[�ˈ���t� ���_�]me�����
�=�]M�-{�&�23��u \\��>�>��!�-C�q\'�}؟Cę�,��ٴ��XY���݂,��r��>���`ia���������2$Z���$���o�#<������!R
Q��.�����g�GU:�c��6=Ґ��-�kX�2��I;�5�K�N�x��b[a������]�c�@�Bo�&��Tp��u
yy��T�C�H˪M�%�]��[��xp�d��=2�܍D���ۡ����:�S��1T�>�C1�s��&}_P�ZUBx؟
�o����d8�A��+��:�n���y{���YTv���ݼG�#���Z[W�=�j��>�N��%6��c��Xᕎ�x�8����f[���v��ĺX7�ف;����1���/��Ά��@\'��Ѭq��D���-����/��Y-F����n<m��4���-6\"�xb
��C�b�����x�u]�u�-q��i]T��Sk_n}zc��#*��T���l��ƌMĆ�
L���f�w��~�=�4z
���rĝȷ=�醑�j�I��Ͻ���xd��K-��WI���\08�ؘ�e�P9�m�¦��}At�
	U�h<��n
�,����K߯,J��2�f��؁ޱ��f
���T45p����W_#}�$��\'� ��i(�9��:`G�L��ڡv��_��o�\0?,AI��x�H��`zo�־���LhRr�.��3N�M�s��������1\"�@�b\0����/�UJH�TJnA��Ꮏ�
}�~A�
�n�OHQ����52���6,;�m}�~C
�X�q�f�G��|9�eS�f���I6�2թ��ɤ�c��,M�zQ���r\\抏\"�֫�LYm(�&���P�n�1�6�-�-�����������^X)�o1���d��Xa˖$��Wd��Ŭpq�ge��;�r솢J,ʟ2�b�	\")�F1NlW�$��#H��y�7��KY�R?-C��dR� ˩�%*���vT�����I���3�����W/̳�˧�_m#P��SOO4���n1\0�[��k����� ��ir��yl�#A)b@6���
ɤ�VM=�
*�!R5n��M��b^WY��O�5�������?\\U**���kr��`muhEs����� vX/��[�%�4����h]� N��Ǘ�`_��ucu��6�����݀�]�0aB�,���j\"ǯ��;<�4j4Ⱥ�W@�<F�\0�Ú��U�h�_Ik[�����he�!�AM\'��k�χ���E�
rz1��;�
p�D�����3g�0-,lT�-��;�FiX��ƉbC��<�<����a�x~�S�ɨ��c�m�U
O�\'��t��v�bIAmƟ݇}ji�C��\'���x��%�:���:m���<2��)�C������Y׽,�b�1�c���˯]ƫ���>xY��CR��_����gqԽ�~|��tC�B���ܯs�?/�+�:�T*W~�ʝ�/��GT�ar�t�/�F��7��qI���Wi-w>�R����� 5!)ep76����a����(�{�a{�|C��a@�O��V�� ｻ��u��}Jy�VE�:N��{����@ӭKK����E�����6�T]rF�nͧk|1���-���!G&���qa���L�v+��������0��TTBT���U\0\'�Þm�H/fR�r?#[���c�i`�[�����\"m��$�*+�-˼y}�lk.����WNX]�F���~|��b�G���
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('2','0','admin','d033e22ae348aeb5660fc2140aec35850c4da997','1234','Super','Administrador','Default','gbg933@gmail.com','099394334','����\0JFIF\0\0`\0`\0\0��\0:Exif\0\0MM\0*\0\0\0\0Q\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0\0\0\0\0��\0C\0		



	
��\0�\0\0\0}\0!1AQa\"q2���#B��R��$3br�	
%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������\0\0\0\0\0\0\0\0	
��\0�\0\0w\0!1AQaq\"2�B����	#3R�br�
$4�%�&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������\0\0\0?\0�$$��3�5�����m�C\'�tW��_rj��~&��!d��/!k��BHb��C�aؓ�&�����޺#�����<;����ߎ�w�h�Ty�
�[�:]�Ce��6(UG��X�Nk�_�$�������?n�o\"�p�3*��E���;���-L�H��
�y[�U$��s_�߶���j�\0j�S���u�CJ��Y���Z��k�\\#m�Q��ݻ�v�Ҿ��\0��������\0��]ƃ-�����E��=�lK\\���ּ_�	[����ɚ�x��-f5��yH˴�(b��\0�ߨ5���q��\0������\0��\0�ڧ�/�>	�o<�ff�S�F$
���������g-���X�[�cğ��]7�*�×��ď�~4�4������BU�8ds�QwIP�$�����k��j�R���q4\"9.�uh��C\0s���n��;Z����o. ў_9�c��^����Z���	:p��?$�L���ҕ�uo��q�y�\0��z_�5]CA�������F<A��$������c�^�(������[�>2����|)�ux���[NX�b@>\\�
�<Y�}eWN��̖��L8��G�ר�>\"x���Z��s�\\xn�;_8��)=�x�|UIc~�������\0��f��9UWh�8�����>��I�u-�X�����#��U�\0�����R[�çj6��N�
�f� ��II�<��>>^-׋��m>Llz��ϥ,���x��Uճ*$�p^)\0��:��_��\0�Z�i���\0�t�hd��/cѢ��>U�˸�($�.�?c����͏��fV\'�5���\0-��7����,U�����U�y9��%����
5?��^�4��4�$��23����	�*�����p�u�\0�?��-���xV�\0��j2.�@�b���Lt���0��ʷ�s�,�O�[mմ-.��e�]ߟ_ּ�^I���Z͟Y�q�c�J~�+K>��|�sO�-Ѵ�KOԭYw��el~G5kQ�mJ��TX��Rz��ڿ������f��/<�&M7P�y�1#��G����!���V�>5Kh�s흠׃_�joNW^g�a|E�6�����ߏ�}qH��^s{���l���7��Wex$q�6+[���A�ȶ~��!�ZI]����p>�_ݳ^�����|����\0�cݼqq���
����Z�~h��\'¼7U�/�%�̭\'��1ю���ϽO�R�
��խ�	Yu���x����7,!v~�O��|7-���x�A+P�����w8����\"�\0���e^Z��I�+���+�
��J�[G�Ɨi7NNg�zt�}3���%��D?�,�-m����s�\0~�שxk�c������=��<k�|����6�����+�q�?�b�o��~F��j����KC����<�0U�r�W������þ����|Y�j��ޕ���[+Pܫ1}ǡ�Uo|#Ѽy����O��ͽ���=�q]��������>5^~Ϟ9�η�v����e��0{����k��>NR���G�/���Wɇ팀U\0D?���jx���^,��;���>I|�kN)>�#�N����u޻M��?�Q���\0�O������|\'���<ko>\\�3���u���_^���x��1\\���n�nX�,n�~`׷�ӿ����S�׼�h�֭^ܾ��>��ο�\'��5O��\\�?g�W��\0	�ù�iNH��҉�̨�����@,x/�m�,��>��>�qv���T���i���&�V��>\\xg������c�u�>8�Uo�:�2>��ҿ�?�K���M�{������2��p�;�zF�m��p���խ�$�8dpy+���fS����S�4����%Z���=:��\0�G������\'��=���vmcZ�-�,�#24��_�w>Տ���6��ឥ�]b@���
E�杏
�{�����?k���^3��R��-�[�Xb^�Ϲ�K9�c��e��Ӫ<~�Z���J�����;�ۗ�����f�e�\\YxGO�B����j�	����?����>�;i�O����)P\\�}ٯ�0����}��\0���������躆����+�ѻ���b�;)��7�Wr����;?���,�xKF0�����8�֯��
�K���پǡ�wWq�>����n]�oB2:S�y���_�t���uA���h��vJ�&�e�=�MWk��b�9?Ҏ����rw>�
~�&~����Z���
&�������A��dY�>`��\0�:}k�x�\0
0����o��k-���
xJA�k{+~s�ZF=K漻�wǯ��%���\0�� ������
^�I5{hﭾG�(;E)4��K_Sc�)j0��UwF�Y�h�B�}���5��G���T.���
Q�gǟ��\0����\0����D�*���O�\\�\0�E��ן�\0�;?g]k�h�o�4�[���Fl���xԶ�^W���V�m��|����+����x�A�����iE�������8j�Ō��f���j��M�S�%�be�JVJ��mRO��<��/�\'�H�+�Gj�2��W]GT��V�g
f��ޓ,�A,!$OpÐ}���O�m�����Oz�g󭘯̄~��L=��Q�a�,e�Sv>��z���_z-ƽ��^�����L�fi�x��/��_��̾nn��B���)����o��5f�̞.����#�$gq��]O�)y���c�l���y�5�y\\�<t��j/6~��ڮS
��I_�F��ݩq����-J�;�y#�	�<n�*�FA�����W[�ԧ(I�j�h�Ѧ�1����$��vo`������n����(�u�9��\0T���\\!���4���k��ma�k�?|5����\0��|#�Y�>���u�YT���$��Q�\0�\'<�}W.�zz;Yz���¹\\s<Ζ���^�������EO٢oً�	��\'P�����\0nj$�3�>��ێ���B��Z�m��ە\\��E{��um�?M�#���*%@���+�g��ܙ?�V?�~վ��OT���X����E�K���5�������?�83��o��ö�9��3F��\\LDQqꡘ�藄-#� ����t�=>]�_�ߵn�}�w��J��G�iw�kWl�1�譓��?����<��^_x7K�UW�0�H�������$�ӟ
������^���
�<�ާ�K�SR�%��N$�n��\\��s�uxǩrjCD��\0%���\'�n���(��Y�����Fw,�C޿/<�ڮ��^���G�>̇ú���6V)�[Щ���BH�UW^G��^��\',���W���s������ywvq�dm��7�W�ث��\'I$��]��w[���R��c�Y�\0T�_�M�>4��ԭ
�䰊�v}� x�����X�!g��1�{#|�~׬g����$�&�^�wA����3^��x�bx{
�v�k��6qYZ�ݎ5
����x���p�>��oo����*�\\���·y��{�<�,��p?^[��\'�sŶ6㼠��W�~�7~]�������\0��>�G�3j�/9�G�k��S����>~�\"�9<��E��;�����w�i�����H�:�鴂L`�m�B	�o��?�?��F�g����a&�8���q�=y�3�����|)�t��B�lpxc�����\\�5Øc��Wj���/�8�*Q�*��m^�z}�ܺ���jy���\\۝�mn�s�ߐ+������}�]]��t�{������3���m�@<ن�Z*3���|�?�]�>��?��/��˨F�2ڮ����K����O�5��յ�A��޹*�AڲQv���Qޥ	��F�;W�*����?l��(�b�����-�w��t����FM/x�����ٔ���k�o�&����\0����f���G�ˮ�xHኜƟR����wm�s�:��t�\0�^~͇�W��g�^�#ּQ�Q���ȍ��3��\0�����^���j~G�W,���*r�J��=�\0��K�6?l+4��,l�Uky-6N�I�1����\0�3�t�\0�.�Zc��q!���<m���}k�S���U����ξ�\0��|\"�\0���>$��7Z+l��9x�\0�\'��p�t}�Wk�?�<&⇗f�\0W��
�|��ό�O:m�\0���#ᧅ�zo.�6���o��q��$��|�>>���&���Co�\0V0H�k�EIB\\��ۘ
0�I�����TG1a7ͻ��+W�q�꠳G�ɜ����A��(�t�������.V���⧂�$�F�/\'��^-�db�F.��E{����+V��\\Cg��
m_��UcҼIm
O�\0e�a��Ҿt�\0�d�T����3�麓2k����Ց�uh؏�~~�[���/z�_�U(��,���|��ؙR}����>��V�K��b�4���*�=k�5Z�Δ]Kz��\0�U�_~Ǟ#��tMz$�*�\0����5޶?gMt��XK�B����1^���o�����I��5��=��L�����߲w�i�g�QЯ��C{,�{#?����ºX��[J?�?V�(�����/�\\���5�V��z�/���}\'�k�Q&F~诏>j�i:�Ԑ��-A��޴��j�*%��̹�c�~Y��7���\0�6_�+���ڶm8Q���Ak������ȸ��|i��So�H��5�qw5�0y�ob�*L��Td�V��P�����̧U:qZ3��\0�cxi~&�R-�fi���.�H�V[���_�����k�c��o�H|A���ۢ��\\M�|��9���_�Z֯��Mw/)n��>�!�3�z_�?��?�L�A�Z+�z�y����%񮟧��̣i�-��K�����=�2�1=��/��2x��W������ħ�?�֯~�?c�[�3�:�8Cgh����׊}+v?ಿ��o��Z-�Ҳ�Z��U��M�� ���A�>�}���;}+��Ψ<�F���$>�X����[���»��}�I��Hs�Z�~\"�9U�G�w�<;9c��Z�w�KDkg-�������8\\c���Ze֠��$�ҾM��Ҋ���b�Kַ�~�]
v�c��䞂�Z�^�f�;���l�[�e�c��S����hߏ��-�g�i��nDp!���W���\0mj����<Y�޿J?��_�w� �\0�o���>]����Ӄ�;T=�M��J�r<����>O��*\\9�u1�\0�Sݏ��_r���D��݅��g�m����p�\0?J�����q)\'�\'�Uu�VhwW��G��M<�O�	9�~��������b�m�[y�?3�j�~��Ƕ�q���ֶۥ�6Y�	�לY>��[�J����{���^��o�M}\'�Iu��O�[+ ���
��ue�O�>���쿦|e�����V���xv;?+�F�?#_���j���;�����I&<�k�V%�&Y,�Ͷ�=7${A����2�i�ơ@TU�W��!�g����>���#� G�k�~X��e)[ԟ��\05�c�����!��ʫ�M��g�O�W������OP�#�MJM8�Z����<*a��������>���6xQu���oS[
���z��g�}���>�8��wMnL02s� �5�?��OԿdO�+5��}���h��lw)���ק5ɛҕl$��&{<+����iV��n�4v�Q��eq��l�z=Ex��{�(?e�\0�Sğ
�|l�q�y1i/y{u#�C�iS$�na_���w��~ ~��2Դ���K�H�NV@�dWן?m�j��J�|eo��\'M�-8L������D��>���$��1Q��k���2�.�}�����^���k�u�����������{��s�u��)�u��)��!pH<~��Om
������RmZL��y	�]�s�9�^��?��,�[�:!�~+��>��V����B���5=�assj�\'x����z�ʘj8<%�dҧ��X�z��\'=̱Tq���S�ܺ�����oڳ�ԛ�:���;�
��z�8F���G�8�!��/����c���m�7�W���Nk�p�����9���zW�����\0C�:|�8�}��it�p��W���	��r�\"���#!�7�]G����d���,c
A�yjtc0�z���8�5���Ƣd��ݘF�\0$��\0J��?�k41n�#�ܑX
�c*�B)j���W<�^�g_�>|\"��������F}J�#���\0W��o�A5���xZ�᷂���
k�*UW�N]�����^*s�-���85��|]O�?�d�\\��	�[��͹z�����\\C��T��>0�\0·�����N��b�`OʒJ����M6�g��3����
��/���[��]�����\0�J�%�1 I��<J�?i?�1�q�9�xvH�I�!g�s�\0,�^P�`W������Ya�	���\0!^��-xk6J�4��=k�ʓ����_�⧗�㉢��$כ���?5[)4mZ��uh�-\\�*0�R
͝|-f��֯V�&�^��q������A?خ$E�b\0�k�ͯ�+���w�m���CA�������\"t����Xry����GŖ�\"�t=B��M<���\'�=ƽ��3�xuJ��w>o�xoW��\'��k۽���f�kπ~�����z�Ҿ��~9x��^7�<�^4�6���`a�����@��eЬ��\0
�����7�j�c:8\'�S�<������f�֗Vk[��0|?���S��[���;]v���Ũjr��o#�-�������^��������5K��ռAz�n5��T�_a]���vk�FU��T��uu�!��q��ǀ�5�u1��L�՟�a�_K܏,b�]/����I�Kh�\\Qéx�Q��F�|ғ��q�jo��z�]�8�kQ��\0+��7_�\0h��2[x7K{˅�qwrW`#�Q_���<_��\'vk��
r�
<�����\0[�:ܾ�(:qo��kK�fx8�\0ę�}ƴ��?
����yo��?D=~�)�MS�ӳ���{��@?�t	~�|\\����\0
�m�����Ʒ���wb�;���yE5�<����8�)vG����<Eiׯ+�6�ݳ�oϏ��ο�v��$�5MJ/��&Hc,�@I�+�t�4Ӽ���i\\��O.I�~I�k��,��\0�>�����HǚT��\\���\\)Q��||��_��9��r�e����O	�� �.�W�����Qӕ}�?�O���?�b�<�ӬіY#uu*pA\"��g�\\�:�=+�
//A��1ǝ�_(�F���\'�=\\ߋ>|T�F��m�����0o!���C����u�N�=fs��b ��M���[�d��h}፴�^�q�j{1��2�)=���5����o�����6�xG�:��=)�%�e�]����½��dּ+�6h�����0�j��\0�>%�R[���#n�<��
��\0��~�
�� ��w\'��w���\0�}�\0���\0h��鮑˷U��x�2<�3�6~����F4�b�ĒI%�Z[c����\'��I�/�o& ۍ�3�¸��\0�[��

�>_�8�0�U?�	s8^�-���w�=�I
�?����־��u�r�/��ĚF�4�֠o.[=@ye[�t5�~�_t�\0��\0���cY#�I;�������8�_����<\'�Di~e����ʌũ[��T�ݏ�>�����cp،Suc��]=|�����a�-�^�&z��v�\"o��$m����ֶ|?�*��ݕүe�X���\"�<���>��F�����Y�k�M�����A�����\'x�;�����HПԊ�9zU��_�O9�!T�50�ӳm�G�=�a��^��d�-,�����-_��ߵ��.4X�Q
�������c��Z�߶��mo#R�S��`1
���b+�YeE-%y�k��>\"�8�*R���#��U�p>�*Dl��s�%��|e�����P)�!f�D������_l.!]{S�#�R�o��^.\0���-��{J�v��\\�ޏ�F��@��G�:}�T���JԆ���dC�@��.��>yWԵG�m{�>��}[��=˪�\'��W�_�\'������O�x�X��q<Qǵnc�IP0Xg�^k��������3�o�q^#K�*���,��F�ȍ�pF
���>Xz��au������x�O�^TT�ʒN�������/�E���1�\0�~d�G�Ϳ��i�U|4�\0��\0�����\0�W��,�Vϕܧ#��_ʼ��R���\0����V>_�u�Oկ�{�w�uO�77�)��дI��Q��������s�\03��\0���U�����5te�X~u�\"��g��|�+�5:�Y��݉��>)�e�˯h���_�U)���n�� �C�o�����)le~~�p���V�Ò]����L�����u���E+�\0��+���jv�[F�K����_�M:�a����;{׀��_\"����-.y���>C~i\"��+��
;m�_G��ЍS��\0>�k����(;_MWGc�?�)Æ�\'��|Sgg�P�\\��&X:��5�[���X���Яq_�� �m����6�w��B���`�������ǚǇ�6��vE�@t<�Q_;�ac��FCx?�V�a%��*z��k.�A���b��$
+:���=�|ڭ��?5��j^|��Ǚ&�4���3�Mx�\0�;����Ӭ4��\\�6�-ٝ�|�I�>������i(j�蕏�ϱ��[��&��*�W����J۾�m�|�_�om��X�h��H��0�=2+�����w�����\0����hU�P%A��2��U�OÏ����<Ao�x�z��}z�a�! 1��}i�{�
���:��X��W��:���\0q�9
��u�u���-��<{q��[]Ե+�Q����!X���r+�
��v��ϸ����Su���iӞ1��~�&����h�eѢ�ܚ��ԛ<��GE�^?*�������ai[�%��.�}�*�K3�Vbp~�~��\0#��?g�Kh�5+�����$~�~v�\0�-�\0gi>9���z��%�?	�\0�\\�Ye�}rw�+��T(������x_�&/��7�?���\"����sJ���@����Gw{�o$�2�p�v$��ɩ�w���
1��~����ȫ��1�6������&�_MZ��I�[Z��G�5s<ʎ�|Ӓ��۷�v~c�ۿe���G��Wi�K8&6Vk�b��c�A�&�>��CH�c33�s��>��M޿)�Uu*9�����et��
[���i�2���kw�����#�W��r>\\��X|m�;�Z��t7E}F��������W�U�8���<�T�sXc#�F_�?+v�<�)�Q
d��KzUm�-}���C)�m»�iW^,HZ��fY�6��Jg����C[+�,���in!v� �r�y ��S��Nv�8�D�WQ���8��v�V�:�n��}<�fY$#����5�j�\0R�74ֶ��������*�ʔ���^z~&��4�{q�TFņWּ�Ƌ
��ɵd
w(��|H���1�
��G��^��a����q�y-�C4�:��_#�ԙR�^ێ*#��3s���s\"����3��Op|9�G5��u9S�VZI�����֘��u|�N����--@�OJSҌ��PWFr�-�\0�����Z>.�co�k;5�S�Q��c�H^�ݴ�u���i=��/�G5������\"�o<9u6�=f-���/��1�W�9�:��K��$�T��S�+|-wF����qGK6���jo5��ϣ?\\�E\\�)�q8>��*��,x�̟/^�{bv�Z�v񕬋��Ҟ��⾅g�$�O������w�Z-�wl���(������|Ui�������ù����+���.���)ӵOjz����D��L���3�~Լc�ǧiV7W�Ҝ,P�Y�J�����n�?t�l�*�Q7I[����e�/4o��1��/�yz���P������=��<�K�X@T\\���)�>|��uhR
�z�;�i������{LZ�۝�h��8����.��
���q�����-d�`�7MǞ1��u�\'׍�il���7��Q��$�/�s_Px/��^�R��-���$�t�7���&�~S7S^�<�T�%4�m���^Nx�)7���\0#�#�	owp�����\"(��?�D��_���~\\��ٶ�y+qw� ���+�Es�:2���y�5�,MEe?����pisB�o﷞�=�K���;�q�i7a����?���k��\0a/�2�_���]זV�����˅F�\"���߶V�������T��x��x�)lǀX��V����_�G��Z���\\N���ɯ{#�V�\\�{3��B�HӡiJ*ͮ����:?��?i7k4qƪП����W�`�X��<7����l�
�������xcP[��-f^w� �
5mAmBT�8�<ǟ�W6$�#n�9�J�;�(�\0��qh�}�k�u�%�S��S^�A�\0�F-u
�\0��Ez�����WԾ��X�,�~h��6�^�����/�Y�1�۟o��|�c�9��D&/W�K]r��Ǒw���Qm�U쬷�}u���ŋGqw�0|�H����i~&�k�7�^���fc�%>ޙ�����x&H�\0x/-A�o�=�j��Q�|s�G��s�?OZ��`h�MU�Ϫ�2�r:�_YúOGꏁ|u�\\�a�}�Z���؝�W�r���ʣ����ľӼW�Kc�Y����0c�w���?��a�:���VW����{#�|vaõ��t=�.���� 0�.t��ޜ��oϱ�.��sI����{���<!�Ic�Y�cw��2${{{����_7(N.�џ��|U�Uh�IZ�����s^/?�0�����������謼שO�?8�;W���\0⣒Ps�z�W{��l�g��U�t�#�W�%��R�?�]ϰ���~���Ui��m�uK|He�G��\0e��C��W[h�θ��L�%�\'.z��_���g���k���е�J�Xg�(@aꣽ}��G�:����\"���j��j7�\\���G@+�O��)X�\"�c\0aF+����e��\0
��-{���>˖E�H�ʻNX��Z��^|L��<S\'����i�|�O^��\"�Q&>�:֗��O�(��ox7Ǒ�X����I��\"����I��5�����}{�	ũ[�1��gk\'��E�Y[� `xXod$�0���[/�}�����#�qW����{��Z��nD~	�
�����.�՚4��g;��?�W1���\"�21ocޝ��?J��������>[ި4忐$�7�[z|�!��e��e��͂?� �bM��b�T�Z�T�p�;/�_�&���
�%��Լ7w4��kr\\�idDv/?.W�k��et1+�Z�?E��3��xYޚ�X���3ʹ�\0��)�����:=Գ(�3I�8qԖ=}?�+�	ۣ�N+}CŒ��|�7ٔm����oǊ�L�
\0|���@�U�:6��t��졆���DQA�H�\0q�*�#w�Ԁ�^\'�`~�:G�٤X�6v7(���L�h��5	O��\"^��q]_��@��I�mk�Z��]\'LS��$��vƽX�W-�8~�q�,���i���S�+[L�Z�Ǆ�S�٭��HW�\\�d�Ķ��L�||N�����}7��1���t�T�/�`��LjI㌱�:V���ix#�$�l���.���
X���_8�;����Y��(���\0bO�v�kW	y�i�/��18�#��FrOj�n�*�G���\07��u�?T�&��E���l�i�g�^���S�hr߶_ŵ���Hx��	�e/��[�k���A끜�5����B�<)��\'Z�Hum&Sew��\"�
�q�±kX�E��zҘ��T~&����\0k�`���nE�����%�b9י�~jm?3uϵS?v�i����:�8xA��X�T�Ϟ��>��\0�X~�����NxK��}?Q_3�B�nSs<h����+�_����|;�]~̺����xmb�9m2H�lgU>[(�B=+�?���\0\'���\0^�\08+�M?՟���׎�O�<�S���\"R|���Oc��
r)Kd���u��)�y���UH� �I�~�\0�h���~>�{�s�uq�^���K�;\"�Z��\0��\0�mk��S/�V�\0�������g�����6�����u�#_�\0�p��)����?�J������e�
����Kcr-/���dH�]��\0~5�
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('3','','usuario','7c4a8d09ca3762af61e59520943dc26494f8941b','2233','Usuario','Default','Sin direccion','usuario@usuario.com','99228833','����\0JFIF\0\0H\0H\0\0��\0C\0



	�⇴��wJ��������3jWޔڢ�����|�\\-�D&��H&�U���\0�Lw�\0VX���J����k���*�!O�����>m#i�R��C�Og���H(�𙪍S����*�3S�ɵf��f���ܶ��YN�cJ�:-�FN��¥�z�w��*�)�����O�v�\0��hY�]3y��뒢W�53t��SZ&��5��]못#��#�W\"\"�arw�ֹ���Ѣ��1�%�+F���}�>�~�I��wH�f����E�u\'�h�םB���fl�o]�
�>��H�~�h5&wL�^���I1��{a*�:�*iIRS����A��8�uakG[�aIJ�w5y�_�N��L�����D�v�h\0�-S�h\0���F.ei���df��ռ�	�e\"GÝZ�+EKr{t�/1���4�-� 6:ӱ�S���W��Wn�֧P3,3�	�jbg�ɾ�
̰�/���\0*\'�
0��f�
�@��P�r���$��4m+��M�V���o}ff����\\?ˑrM���N$�l9WأMZ���.�T�tLr\'���Ö|`Z�W)4F�0Wl�,��D�1��j�2���2��PD{�j�+m.H\0����ү㋙�����;߬T2�r�\'ʴTTL�7=�?���d¼	�\'bzѨ7!2�Ү���t�����+}S9�����*�a-���dU�}KB3��g(\'��P��`�_@�.IN\\��r֦1�M=���[�!\\��
dS�$���%i\'�:�F�����Zdw`$�yz�x������xe��B\0�A�0�֢��;��d�ǆlAr��P�x֭t>|�t���b^G���S�j�پ�*BҀ	��h�.ކ~`K��ˮ3;���O؅�Ii���S�����Y\\�Hkqyo=���
�+�Hp��C�d���F�_�ޡ0�A�|���I��S};qK%7f��**���ٳZ�s�f�ƞ����=^�̓�>Z�u�I˪30���b�߹7�5���Զ�l�4�=f�9E_D�ڨ��h)�g%�Y�R�m����ҥ�v�]i D�&��h��=+��:���Z@֥�d(��%Ru��:�o�b��3}t�����\'���}�`�qݖ<�Z1x��7��OJ����K$<�k�׿�zυ�Ǘ�I5��G����8�ѵ�b�WIRA�Rg�T!�Ok&��Q����t_(�_���^)Ỗd�u��L��\0K�Nτ�h�;�K��l�9�����^w�����Ov�5���f�C��������y����PRʹh6����w�	`��n�#O�	����>b�
��zW�i�=����Q0jS��{��H;պ+�gS�G�>�7�ONu:��!PF��imXI�r�*%�Ѱf\'}���M����Ff�]Vs~�A@�&� �4`Q��2�g���*(�fm�I�W�a{Xy�qՄ��#F��\'o:>��ѣu���pUdsg&�@u��`|����
��vK��:�ۤ�(x.�yvt.]�u����	���\\;�9�i|P�R����	Q騞u.1z;����q.�FǦ�ʗ�KCp�l��c�\0h|3�p�j����#� f	NS�=��Ex�;ṲN�����p�,g;u᫛v�*���-Җ��\0�6��d(�����+R��Vb���|Rj�\0���}�X����\0��y���Ӱ�a�5�ۥ��I-cI�\0���I$�+�x>��1��2kE%�_��$���ʔt$��Rk�b�G��2�\0��}DN�Њ�������%���R�5<�\'���-~�YO��h7d�w�q��Sm�P�ē���B�ّ��.��-!N��JS�R�ߥ
N��#b�)Nh	ϒ@�SS��V�!Ѐ�NR�3�L	�S��o�����\'8:*\'T+�H����e��`�f�*�N2e����!�o���۱�`�N�=u�u$�5os�Q�ʱ�}ݛ���:��G�5*6���^�\'��K@6�e\\��Z5�!�6sz�R��M
MG�0�zȚ����Ѭ���i54���K�s�� �+���)ʙ�}MO�ɚ.��=\"��q]��wP�Z���2���)�P���J#�Lz��D��:��?CH���TS��~nlZ�F��K�\0�7!%	Ǳ\0��]/o�W_�^�T�,�������1�q�C�����}F~t��xb��$���.�?�r��9��l��3V���TQ�g7�N���������4n���C�Lg4�\"��ā:֫�c�4�B�HНO*�\'��=h]�I+Y�3Kx��{���\0 �O,)آ\\��:�P�Ѱd
q��eԅt������/%P&��]�{3:�*�m��\'�D�����\"��9��o�O�-�\'�D:�#J���ȵ�����@G*��w
�+��IH?#Qt��{�V�p�.P%o�ғ�Ǧ�/c�cg1p�+�XP(Y
}�-�	�r@~5VQ�Oc��Iq,FZ�к$ށ�ɷM���w�TP�~���|t�I{�@۫���#J�^�s�OLf1���\0�$���z��j~\\N�ߪͮ�Н�B�A�*����$s�x�J��1�A�d�:iR���m�{;M�&g��мq�c�]���w>����Oh�.�;�)c��4)Q+#��a�t�J�}�����Uz�ҕ�L�h\"��sm[��q2y��C,k�drK�&���*��y�(��NV鏰��A̢a& nf5�P8�v���������1z���I�lz�bc�j��H1�Q�!�-�Hf�̄��cΛV�N[�ݨ�S#C��-�z5�6YSjO��f0y�(��������[i�sWAw�hkV���m��lͫ��$��M$�u�/-�|�
�RF�i=*\"��������ݲ��eJR	�A�|����gS�
���1;i��TGV���)J�OJ$)�s���)J%/f���
�(:���Z��V����X���,$�\'04	�t���2�y��\0/V�L�j�`�{��{�3�Rs($��:/��B��VUkH<�-t>1�V�^����j�B�I����rmvp�̃���Gʊ��_��2��m����Z
���*�?y��d��\'��=�.j=���
O�1R�:���6�[y�y\0�z����4���Â�.�E
��.�П�V�B�F��;��o�q70��R��:m�rz��.UOG�RV�����SEi;9Ů��Xj�{�]<��f/��8y**)��1k�$�G#�B4IPI�\'�h��%���ݻ��\0�ZBN��5�[䝌Q�:v��5�I=�.C����9��{:Qq��)iqi\0��\'J��i�5|�%���:�f���,k�Z�y�Q�ߊP:x��Mʱ��HI�_J�9j7+���r��W,�\0I�\\�����jw�44�n���#M6�\\v�4�A����� s��2�*:;}��T�^�D�#m�z5�-:�pKL�aR�:㽶iFڤ���/uA�lH���9�������9�RM��`����d[d�k�WC26���e�KU@�A?���\'��Z��ܪ��p /R�I�XH�htwc֓�Lz�Uv����M�:G�)�J��\0J�~�D�5�TM]#��	҅N����=�sG%]1��	��S���BN	=	�Q&w��D�\'a�k\\��rАw�l��HӦLz���ڡp��i��Q\\�\"�\'Y֏��к�:�����j��cR��T�]��p�]h�(�*B����%���<���v3�v���g�����C�#�C,����xg\'ihy�5-뛿:�9��+l�	/v$0�U�@����M=���[�T���j:�zST�be��4��).��)}��ʏ������HaO��iRH�ЉI��h�w�}V�v�C�f)N^�D�	J��S����b�(a9���*c���=j���Q]����;�!����.|��������n���
r�\\���\']�h
ʝ��嶿J��F[@/\'L*;��	 S����c��ߔ����K��?s�刭N���R����|���EJ�/�d[���M�U�Ҥ��X1�m��Қ���l�/�J=��1�m��=q�8I9�dH��Ə��鋗�g\\�Vx��إ9�Vu�N@O­c�	i3+/�8�=l
�<�J�F�2u�_�Za@%K}��\0P�աQ�Q�N[��\0���{���Z�n;������Gr�̉F4��� ���J�!����}]#.K�o�����)Z�:d�ʚ��Y��K_ԑp�_�
��JH�y��֔f��w.+��v�BR���;�>�ƭ#Q�A�Q�wd֪S����@Zg�^C�+�{�8�b;�\'H[ͅ�%BT:Ո�5Ei����@8�\"�%IX-G�DH4|x�&� ��`\0��PT ��).�
7�cu2
��$�DjZ�I��Gށk!*Ӡe;��f���DEQ�tk\\E��5��o�N���i���s�A:
�z�V�IԈ��
�:&�?�C���Ft�s�������V�`煲R���Ѧ��q��-ҧ�e�\0G?SQ%n�
Ij�w���dn�7���-�dǋ`u�ZHR���&S��&���R�&�էZ�B�@$���?7�w�i�`W�Z��t�ROH��H���L��	@j�2�+d�.Ⱦ!c�JJ���QЊ�{���d�*��x��vB��;I�<�U�>K�̟\'Uh�ovUw�;���Z����[xs�}K��zD��xx[\'T�S���Pt�j�JJ̨^8�>k8s��ԅ�NWZq#*��G����7-�b�m�c-�V�V����)=g��ӹ��Tpݡ���]�\'�7HNU�`(�\0?J�Lj�%k@�����	�]+��.����VBJ�˥[�+EyƝ��I)�Mu�X�PTw�Ҹ�
>�WY=�� ���	�0#M	�F�T���2 
ѳ�Ҹ$h\0cJ��zTdF��Pq��m�M�{0
W~��B�lK��	��f�(���7�E��[��i�.-_�؍\0�A�<��Z�)99��\0�?e�r�!ח�A u���tDڎ���/�N��k�t�M��R��#�h����y���٫�����t�b�<=m��3l�a,�j\0��4��,�>ϡ(F
��$
�EZǒPz(����<��7e)`=sf�����:���r<�������\0�N:�p��ӭ����\'J�K�<�`��1�p���;gb��څ]�	�\\�Ct\\B�2H3Z\'!dI�(��+�ȄeY�(l(T$�m�Y#����l�{�J����
�Lt��C!�&<//�CcuU��~4�1�/s~�2a����r�d�<m۲T���J��֍��%$�Y��]\0CJ����;[�g?�x�]�R��3���{�y��Ño����P]������gh!�ۋL@Ҿ}�f�y�>���X1qK�lA\0�w��i*1C۽��m��!	T���H\\x�a�F�@�2���v;�{���Z@$>��M=��l\'lͅ�)��\"��b���24hj]�ƈӕ�Am����Od�@�qkB��}�-�ջ�NU�Х@�\\yQ7)+l.�3�V�����M7���c�y(I(2��&Uzbέ
RD8���Xŕ�E<�����V$�C.L��V�\\g�cd��&�#8���wI1*����698=����ʴQ}��~��^��c+�S���y�V��y�\'�I}%*�s�q+)JL�iqy�Ƶ�r<�T�>�\\�E�̀&z�J���K��$�@9�`	56�2�؟�T�$@O ?Z.���A-!����F��
qO�u���=+�h+�Ά�g��G���Le�9���C��Kf\'�K���E����-����!�V�����Z��#��:#R`y�~�AG�^���4���lj��K�pV<U\'_���f���\0�Ua��L������xE���M�d����������9T5t��7�?����\0@ju��b��2#��V�m������K��h�\\5���`@ҪFI�H��TCHU��]b�\'�(�.m&\0
��u��(��f�eGCu̎�B����:{A;t�O c���vXƚ�����K��hr��M9s��,E*N�_�-��I��a#J(���`[�*���CH��oCrs��}(�������G�;�R�#�	*3z$Gob��ރSA.��b@�OtmE`��t�R��4��k�����̍��+��m��$�zR���ǶiK��ND�\'Us>�����9\'&�;��U���ҩ� �~ꆽ�/Z����<����������!��ʹ���	n������HZ���2N��o�-�W^Ǣ{᯺�˯�>��	����z�9�,��G��6�K�_��E+B���J�8ڼ�T�o)��A�1�<���!�jI��S��[�ێ�+`�ew:t����ZѰ뜌r4��]�ϊ�a�X̉3�H�uq��Bw�	w)��$�	�)�R��X�&R^\'�;�Ң��7v��6ݢ
]�UTI�OZdc*bͮ\"�Y�,7��a#�3~�*�c�g{�6Tr�1A3�R�-���m���z;�:�VڄOM+��n�+�i$�K.���ґ�\0x`�\0~T��TC��1hSi�
y���}���B�d��H���)O����4CHqJ^D��yҡ���m�[VE�&�j�T�:��\0j�F��Cc�S���I��a{���ΐ�K�˕�T����+JXZ���N�DJ~�`[��⤘ʍ���h�Q������x|{L{Ubpb�bYSh���O2#o��qK�#7��:h��=m��8��
�)>\\�\0�uggM�3x��d�3�KW.)-�8����ȯI��
�l��i�}���\0��&��_c�Ù�M+�k����]I�vژ)&=l�uח*K�f���M�t��R�S��0��C.��������C�
���hU��q]Xk�eqHCh��Cj��t����qvF5n�H8\0N+���6�FA�s�:���Y�#C>rW���c�Kd)�H��J�d�m��%�	2���Ĝ��Md�b^���%�Z%`�r�b7�~�)6�c���i	KH%�9��`��(�˖�X�&B5�7�lR솚^�����RLe���cv�)�a���q��RR�d��^f�-5d�>( Z��B�T��p\"<#Q�9:S*NT�:.s�&��:n�Ғ֓��\051>IhL��q�k�R�R�TL\09
�}��ZL�v�er��h<���#j����SL �\\R�Ba
�ʚ��%�%^㰁�t�F�S��*��e%N/D�@J��(T���95H�mf@I��L��<Z��5z�b��+��0��Q�j����>JK~�K�n(\0�!D�]4�63���8��/�s
E��XIU���\0*9���k��
�A��9Lz~b���
.���M�@(h\'Q�Ճ(���|4��=�\0r<�nx�Mm{ɏ��ݣ`ae�Ҥ�h#�7#��^�����x?����	uƜo�e@���A_��y֌Z}�y٧HN�]�Bҡ�������NJ�ժ��/��T�@	\'i�4��+=
���lқq��6�fJ��v��^�0���\0:ہ�N��hŪ3�rٍ>�J�L�G*�%L�kd���Y��\0�5�l��)Z7|W���,,�3	�6�)��#ɍ���KNɖ8#N�\"�c��њN
�\"\0Q:kZm�\"�H�Cjוh��Q^͘����+�B^\'�&by��T\\��̈��uJL�����6���=��m�CH��X�j��֖1+�o|
[$Iӝ3`�֨\0�9���Ҵ�Fs���BNFCO}�\\��h�	Ԁܩ̯lIi\0��(�G5lt����n���62J<hA�.yrh�t��;|KcO]6��L)uT5	񎿥8V�H~�)N�uXuk�hq9֡%{\'x�KN��+Kd��J;��PTv����mw��ܙ��r^�n��rH
d
�\\���=���|%)Y͛U�T��D�����d<�S!F3�L:j�vr�h2�Y�*%)H0F��}��\\B����IP��*bu���=m\"�(ȕF��4�Ձ�Hz��@�ܞI��ST�Z�7}��ȕ��\\�(�S�^���WC��-ם	�A٧���=��)��B�<	r<��)w�
q�Dn��j3�f �4�i��<R^���Q9�H�w�J��&��8���t�B�k�H3�9R��K��X��40���P������Α�%�R���㸰;�J[�1��
�j��I6�Lap�<����B�HjN�0�QS%hQ�}�AaJ):`��iJ֩�nt->�M] M�*.();/��r��0e�!���ۑ�O�Y��9TD�t�c[DS�J����Z�&�Tϊ-YJv�����V�P�D�5��z_�m�~;���R�H�+Z�de���l���\0�+�cnG���ް�7����\'0�(�N������EKIm�J���H��??�]��;����)��DF_qE�x����5�i�>�܂Q���ݜ�+�P�T�J��;�8r��	�;���G��7p`�4��X�5�P������|߹�
�.�\\��4\'֑\"�n�t���&_��Twc�
I�af���|��N�w
�r�x~����B\0$6��u>��G7�U�5�i,���W�]㟊��D��\"����{�vZ�@�(Z�����*K�n�ޑ-���X��cY�Zn�Ƿ��g)�[	?*�l�i-$�	Q��S!v.o����˒��Zj��d)�Ai\'\"3AFY�j�Hm�����ND%$s��\"��Zɷlv�e��PP�\0(�������mm�RU��0�4�h�S��߻u��&�O��J��N1pl�KPu ,%��	�}M
u#�S�l��]2�4H���I�����`���C���`����и��!����.wZ���
φ	�N�J�)��^�JM�c6�F��5I>��̣,.�����kdIrTSݯ3�w��,�T�RwҶ�)4�-�q<�t�����JIJwR�#��^�֙�Ѧ�^�(-��
eE��0|� �U��c3%��g�-
�9i�r�rJ�����p	*&#�9z���v�
;
w1�g?6E���r�b/�z6M�Z[\'�ѻ�g�%439�&(�\\��~47\'����8i����Dk	��3d��(��1��<�\0��ilî6`�
�
F%r���e� �����Z�˪莕H�G�*�3��2�b6��:)1F@Ϧ���]Td�JOe�ҊLx�b\'_-�c�ht׋�ӥ%�OWC��r���c\\G0G�7b��(�IJ�Fcw�]�D	��q��sz��4	���S%�Jݤ�T�W�����P�hH�iu�
I�$�X\0�\'��n��[t;|�۝*5c�
T6h�iM����t�w,��L6?\"QZ:�Z��d�M�\0�u,M��x[�\0e\0iU�i�ҥ�OxY
y��
�	S�d�i)�>C�~_-����!)I�j�)�^gZ�T�[=��2��m�+�\0��c�Wi�4�IYJBuT���KV�
��a2\0A	���}(�h+�lrý�\0x�B���.6�ꤤح��-�>V�9�� ���hp�RSjPI
GΆ���Kk�s�%�k�Г9�I�VMk�|�e��hk3m)_�jb��MzP�Q�lX��$J@�c�{��ؓWHqA
RG,�-hm=
l�Ȑu�X�a����e	n\0
IvD��X���A@&B�-V��B\\`����E�
70YK�� )=�c1�B������Qa�k�d}�RF��Z��.�;wG�ܷZ1\"�$$*F�g@O�+��+>w�m�Ց�p�Դ�QFc��]��U��-��δ��F�I���y��ʉ�V��8���u ɚ1o}
�ʂx��T��i��bw�-��[�ʖ⤓�hc�1T�l��~���(��:����q�,I>��1^u-e)3�`yŝh��~-<4�]�9��z̈́��W��������~R$��\0�,��#��_�\0�/L��?�ղ/�l׮�RX
֯��\0O�l���C�}(�����c�ԩR��Y�|���|��dϨ�@.1��Vꔳ�5�!�0�G��Y϶H��W��4U/.���jvL��qj:����ܴlf~��.͍��Or�j�Q\'�yV�Lǵ�:`���?�)�
��\0���Pˮ�ӐY�\"�K��U*�z�\0\"H�-%Lr�sk3�֒��T�)N��-��3��M�*~.�e��+���1�h.�Ƿ��L��#ع8��7O�$kX��)=P���NƍC�e�@:
?������ҕ�<�Te�s:\0��}(��`R}��-�63!*�H�}�VKܵ�,~Sn]\"ul(B
���Me�s�x	�M�ᔥ��R�h�F�����l�~*\\�F�[��:�Eg=�k/����
�xE��x�2�>T�BS��M%l�/��_�2����Ba=߯���x�OeW�c�$V��$��yRLFex�GXA�5ab�K�lkL��<\\����w���HH�&��8��qq��}m����
��\'BH��)�kr+)ޑ ��+ɕkU����r��y6�*���2�`,&rO9�\0��V��6��Ӈ���%I\0�4�ֻ�Ǡ�)m	?���d
���ԩ�#����,8Ͱ�l���WGQ:Yb�أv�
23H\'Q4k�B����R�IJB�YS�Ƨjc��w�\'�n6���j�qM��g��I��Ύ8��o*�u�F�ڭn��\'p�
�t�(Vz
�Q��JJ���㍥\'��R��̤y*���,��0y�mAYR���*���Jj+t3�}���YBW�ϧ�V���q��6�0���\0.�i[,ũ/�=7*qP&
�![�C����	QPT+x�1/�)�؅�aV�PH^�&t^��~�	n즸���Y� $�\'4��_|m[~2���yRr��%�-��!B�J�͜�c��^��>���m6F�˦�.�HiJR��v=v��j.���*�)Ji)a\':U�Q���Ӿ�Ы}�o3��\0e0�U1���w��\0��LD�2�\'W���b~4�~ƶ2t�����#�<�֙��ؚ�zF&DďC\\�WF
{��B#��m�Ο�%��Mimwo�fL%iSI&9eQ9���
I5��#�i����p d&\0�Ё�5M4fd䪇�EǴ��R4��G�Զw�p�c�V[}�
I\0��	���m�s�chyu�Kr�Z�+�n k���&�%RS�*���#Č\\�!v�/\"�Xܒ���WrS�E�x�rdBﵫl#	�n�qM�lJr���B60H�*���h��Ƿ��\0��W�j���Up� �ڒ�$��&3��t���w_��
x�Uv?k�ě����$B�gNYU�B63Nk$������h��r��;mgB~��oٔ����$��Dr4�crE�f4��F����Z���8���#�\'1XW9i�D|vދ>!����cr���n��0�I� �hm֗��]�>\'�7���{~�Jj�-��f�`���7);����Q�b�|���^�m�\0�\\w�.8Azu�90Mh����\'R,/�4����*��5�ZM�.���}�
ۑ��ƨ.(��\'�������:*9|�F�J����!.6K�-9�\'b��n����M�E�J_C�Y�?<O/�*��Gg��ې�ɹMׄ�2�!BL�	^�Q�ⶁ
yK
���9�Ҧ��-��@�1Q�&�h�\0G*�ي(�&�/sY	 �?:�&��v��Ѥ���dWvk؞�tԼ�������4�%�C�
��Mꇍ��J����:֊{3�u�E���-kT��в=��֖�LV���=hf�I���\'(&j�/Eˊ���I3�\"E���u�:M%�Wc�A���R��r��qI\"4ugSȵ�ʝ��5�U5Ժ؅��1�Q�^N툢d�k�RJ�$�;�{�{J�/@BF�����+a㜢g����\0F�iQ��]��\'#�yL��%~GW:����C���ƒ����t4MX���a��q�Q�IoH��]�0C�Oc��c�:�\"�@$l+��Rz>���p���}�Å��0�$�V\"rO^�r�a���z^�3�_!\\V�W�X�2��e)y�+Y2W�
���-{7<����/�v[��\\��x[Š��~cCbE;��w��6)�p\'����x�)U�) �cA\\�t�7����%��w�@����A��V#8��*O�νR������I���V�Bc�Zɴ[�\"I�����=(�ɹl[SZ��QR�iU�{vR[�uaN�%	
���J�cޘ�O\"ӱ�<k`�\\��W��c���߿*��A�(g�	z[t\\��v�������`�y����AI��*�\\������2qNG��4�R��V-��	T�a��iU#\'�Us�r���c�[�^�%
\\�U/����ҭ)�k������~������	+G�?��aM��*X���!�b�ٵ��d
Wt�B���rޖ��h�9R���-��±=N8E����vl�	?�dǕV���BW�\0���J���y��j}�IK�� �07�
	Pi���D��k�.x-l������Tq��
TBnĬ���>Ph��n�V�$��z���
T�f�Y��\0�LOºoZ1�ޅ�T��t�5>��/q�$�I�\'Q��3�
�@R[R�@�7Rpy�O��S�z6!��%TO0#	�Gxm�����E����%=\"\'�\'U�ü!��ݲ�v�e��Q>Dr�R�kLD�%�\"/�g��w�)m�[[(	$s|G����i5U�8O��\02��>�X\"Yu��&�ZQ�G\"9
�L\\|<o�w���o�f{�-i]�i[EY��Y����Jt|�fs�d_��8�	t�����h�d��\0�GM9u�^h��[���:^��پoct��Ì,J\\l�>�D�=j��Z�h�W�Fy9���Vğ}$�铒
UKd�\0]�ZB�˾�/�Z��U��i�ho����ZṔ��5����V7�%�	��v���|�V��[*0I܃���\'���6�&P\\s�9�q��ol��LJB��Ry�&\0���2R�3��$Ր�{:{���-Ö͌�F�|�7$��}Z����R����J���ٯ�n���(���\0u�:t��Ɍ{+O��o��~����a�\\��R�p�U�G��ey)���Rm�����Os��Vx���	��OJl<�(\\�	;��%�E�lmR�\\A���RVk	Q׈\\ξTk��eW�����\"��q�ݭ%�CIW��%@D�\0���gm�?P�ů��׹
�{���Aq���W&L�*&��źd�$Q��-����f�rۼ�6�(eKT3͉���z/�N�N3d���%�V�Q܈߭y+���Gh�����4Z�]�r ��yN��U�z\\��am_Y����eP���z֏�-���c�,�7ajñ4�(�A�c�ϒGͼ�*tE�쩿��ۥh&ڳ
�º�3( ΃�o]��h����EI�F{;t�������
���H��\0�g94̵	Dk��jJ�t.�J���J��r%v+l��غBL�����L
��L�7���\'ҎX8+L�O�Gj�67�(����+:=`�G��5$�X�]P~׊-�V��JѺT�5cj�qu��7+f9���w��\'0�\'p� �J
��>���.��o3jiHY��S�F����!x�i�1g-��D�
y@ f���[#lF����t�G�ts�e��E��GH޼�����9[��N:{�\0��/�M\".ȳ�ȯ�Z��EN2���[0���li\0n&���wн��H���~�vds�Uh�i1�r\0�O*C,��#0���|bɀ��)l|iv���}j�;�j/@t����~�u�PǷ��:���)�\'����I\0�ڊ�)VЋ`4]<鏠a��A;7��4^���H&3i�D�A�j̸����]�\\��ݧ��F��Z�9YHI3$�Ը�hnE���
�{�H*>��wM��[[=O��0�&դ �R�I1�>��~l�et}#ᘾ^(�r-�mKH� �g^�T��;f�T���,��P�	�wҬ^�q�^�>*Ėœ�C\"��k��$��(�q�����mh�����$��hx�-I���<���~�n��4�9J��v�
&\0�:��Z����{s7���#�SbX������}>\"�и�\"�C&�%\\�FXEJ�%8�oٞ3�\"�M����&����ASeE�(%D
vo.��x<��V�w��[|��O�a����\0�a�(�ۖ�s�DQ�}c�by��6z����e.>v.s�]�n�{l)Y�T�\'ϟ0+}Դz�i�Զ�b��Ö�?z���)��9S���/$��-g��Z� Jƃ΂kv�UI{�����L�[�L�����w;�n٩bԨ�\"c΂�lMT�x�(�mրH\0č#�Q�h��S\\g�����<KV�yk�Z�܈��������an�e�JI3�@�Zq��<�\0��EΛ��npt)�����>��*R��a�/Seo�b8ڝ�T����|J �r<��Qq_�\"M�j��-��8�~�`�\\���`$~��x�-E��ǉ�-�p���:m���v����a�D�:yU���{l���t�p���F3���ǚ�|�R��Wl��\0T\0mT���n�Y%�üC��kZ�&��\'���J�U�}W�q]���H8s���S�]%�k��[+ߤ��Q�*X���(���
\0�ҮC3��/���!\\3����:�6�)��ZPt�I�ܨ<�)F���=e�
P\0IR���Y
F�{+~�pT�X?�BDʶ�,����aoG��D{Ŵ9U:��ޏ�悋�,G��VR�� Q�EZ4�S�RO�d���Z%7lo�.
��T��Ȗ�C(��,V�ѓ�<�����q�&��K��t��~b�����:k�;F�&tCJ�d�J�bjөH�:��d�N�9Th�-i�l_�ʆ�RrG��w�-�ݡ��#y����$߱k�F�[L�Ұ<�z�O��鴆�tB�\0{\\���c��o}�\'�.���ўݶ�ͨN�u�z�1�&*\'��Q�P{�[���ڐ\0�Y���2��T��;�6A;
C,�j�M��)�M��:��r��>�2���U�=^C��RNc�A�M\\kEX��ޫ)����{��rA��J/��Dm�9��Ί]\0��*A�PC�9�JѻEf$�\"�`Ete�O�5г����ql�X[ϸr��@�\'�iY�qr�-�~4���V���Hx/��{M����o������d�����GG���/�9��x?8�;b�`���pF��´rΓ<�\\�G��m��VU!��c�s��iɳ�><=���.��3�:;,�q�3��w��B��������H�8���Z�d�N�IP�kS���9�P���0��R��-��
�`�H�D�e��t`?$�9���|����j۵�\\�I
\0���h��;�\'7��HV���q��1|m��sjXuj��yjB��>F}j�?#���2�o�d�5��cg�8�+LQ����(6ҜJYY-�r�43��V3y�*Qe����/>���^�8V�\0���,Y�ӷm(��JA ��d������h��~\0��d��XG���s��a�G�6��CU&���`\0<�/$�g��ފ���c&�\0�b��0�p������/��U?�,r�1����Lq�78�L\'`�u���j�OE��J�E�����g�p��:�mT5�=RI%�;�m��ԥ�锥N��
Si�����K�\0<H�,��	3�\"$PS�iz��v��$*e\'��\0
�>s����:�
��:�g��#�y���7�[aĸ@h�5t�.[�2�$L��O	��~+�B^;���C�}��Z|���QX��+����W��V6���Ps��G�8^ٴ��� �$�����{>��7�N,m�o<���Qͯ�%]�-�@~ �M�՜�
JF���Irl���~ۼ
d�StN�.��3F�G��P��X��P�Y:L�N߭{�m�6�|���q��_\\�Z���q�V�d�f���߹FF�q{�e9��K,c�2�0d��	�]�*I2��%i�V#$�r��BJ�u�D-��f���i]l�^�����h��؀T�3Mtv�	׭&4ز���}���u&u�j�b�f���WQ-WbKV�:Q��]�%2�6>t]�z���y���_�����j8��q������w�:���C��ȫ��:V�Z2�[\"��G�j��H�c���Ǩ��B�\0+�u����Lm���ȿj��r�ګ��izG(Li�����[�X���Act�\0bZ�`�Z�2�݃�j�:t�O��U/�ƗI��Z��t�M�����`�1�ױrJ*�8��O#Φ]
O����hal���Gv��;�43��sq
3��f�:\"N�G���|>�/�X��I	�H	� ��U���K�}[��|��Ɲ�p��~�Y�A	[�A �	��\'ʃ|���1�H+���|�Sj!��@�@2fw�6��Bn0��	����\0���	2KA!GC<�=k�drm�E���/��R�\\��
��^��������;*��RFp�T\']�ֶ�i[<�\"��Y]��/�$�b�\"݆�Vڕ��\0��ʼ�\0��EQ����\\����d��~���S�WŸK)e���m!=�O�)�U~�eœ���Y��#�G�����1G�H+׺<Ĥ\0w�i���+���&�w���>-|�*E��� ��t�E��G7��GVγnzTW؅�j N���0�ٵ��\":�VЁQT��������O=GZ\"��R���/�W��of��G�\'q�⼺����|ʲ��q5���տhO�JDI�<��M#����N�z�3ht����ti+�Ĝ�P����փ �{t�V�|j��m��pQj��-%�;����-�M��b<&D��_�#ؔ�V$�+KF^wriW���
}�%�7�)!ⓘ��F�q,9�A4�N4��JTu;ӾZ�=1eaiBs��J5�-!�m�8�í�j�J��Y���P�s�))-�
�#���mT�^JԄ���mH��b�����=�*�����6�\0HRB�O$<V�Z�mL宔{G(5�խ��(H�����@��%�t8�t���]gʦ�K�N��(�\0|��J����=4?�h���>6�N�g(J� A���Z�����*v燩�Y�V�%i�h�J�?k����etʂ�]݆�d���Y���yʣ��x��L�+�������K�m�;�ڸu�Ftf���ޱ29Jg�|,P��R�\0�j���}�\\��ө
���mIj��	&�)��D:�Q�:�q$e9��n��Z��w���\0,8NP}� D��}u��By_g4�A�(���
|\0ƙKbd�U�_g�Q��/d��8�.��H��\04�O*W=�q�\0A��!�fy��/��^:xg%���$�:�9��pRZ<��s~��j=.�Ap�\'
J�V����PoC�H�K�Ͷ���RҢ�A�5�j~[���u�K�a<�h��\00J�婧G�vW��M��>��ל���9H� �5�oLǁ�2���AcM{���mQh���RQmGP�J9��\\�����i2��,�jm��@�������E8p�^�7eQ�X?�^�NE-A�Q�H�ii��[�K�xta6�JC�@�ژ�M:���q�Ǣq��%IBo���B�$o�Ӕ�U�g���AGm.��^\\��Ѕ	#�)��(�!������P�A
R?1ԟ��	¶lb��z 7n�RV)\\	�t�&��rj�L���B�mE!^-hyF��yZl�p���>�
�?��ޟ��`��V���T9�Ia���sm�����b2��Gv���_}W�\'��U/p�NgI^~q�=gz���٣�Ce4!$Lm$A�x�{+[u�ֵ&BiO
l\0B6!\\�b���SiR�c��ehD�sǝ9*zةi��o�L7#u�ed2Z�>�<o�!q�U����Ÿыf���aK�!Q9��_q��*\\``|�]���g�p��4�-�������X1�����!�Ǣj�
��q��Z*7�i��e�/t|+�>?�<�������ҮS0�)�LhJ%-$$�JO_Z$C^�( N�L�بp ���&4хR4ەA��$A*�4î�H�w�d1k@
},$ݣ�\\|6	\'Q�5���\0����/��+�+�rA����NV������E�TG����5��2���9t���ykJ]�v�\'��x�<�2�n�j�L|j��iB����u�m�������#�M-�����݃��ڢ=���l�b�>���х�r{lf܉$zoOt��-��U�ӬoN�B�}����]�*�2�>-�r�z�az:���ǝD:&m�$8�I��O3K�\\�F.+�p@�RL�#�0M|U�\0��v���v5b�g��D΂�����^sɟ,�3�_
	Q��?sU跉[�L0�\'�e���7>����{z|��r��D�
�
9�Z�l���O��Ru\'�������q�2JN���bn`�=��E�V%D���\0ګ�����PY����C����K9�pzI�9�*��
R�+�kT��uRTs)J�k+�����+J��v �x�)�!\'D� �fo~�L�,���9]���ƕ�w�2�T�X�1�Z��v�-	ʑf4֞���_�8?Lo�X��(��/4���	�(A�?ZvH�*x��,�U_ԫ8�
j8\'��*é�SƽN���y��,���>�������{��Db��T���O�5S�Y��mcɤ
�D�$�����7���Q�m<CI�4�\'d�%�B1G�*T\\*����E�*r����핥���ep��-(������[~��4y��O�����w�� w�$T�@�.�oyq��?�)3�|E­a�M_2�@����ʼ���G��>2[{,\\-�7h��()�� ��םZ�Wj��z���O�{��)*Q�t����u�U��\0V���9_�rڗ=\'���崎A�����0�F�6Fݚ؝t�D�&7�Gdm��AҦ��Ѓ��Rsf�\04Pw�����)˨U+/��=!�@3Ã���z׋ʿ�v{o<q�+>\'XU㺍
��)_�Kq�JtݒnSז�w
N@���X��_�TI\"�7$�t:�NRF_d�R�Qȑڽ��
J|J�ʟ���)�J[g�m%dBN����V�W?3m�o�������fB�Џd����Q�)�Y�Fq�(X[��$i���
��#^�/qR쎰���^�	I2K�К����;$�+�ӱ��K$�¼J�	I�M�\'��v�Ŷ�N_)@��%JQ�\0�Xm���vV�ݽ��qc����J�5�y`���+B>/(���G�,R�\02
��a-:�[���e�w�ǩ��k��y��\0�˜V���;�m�ܶ����I��&��iX3��_��\0o��r�\\ \'�ϡ��<T��k�R��l�Rd@\"#Z�(���}��.m�$~h;�j��֗`��
Ȓtm��u������ݐ�*4�҇ x�=�� �<�LZgdV����C#��U�e��(D+�V�`S�����z����1�Z{�CJ� �uH\0�~�<�8�gݾ�9��u��ï��/j�R$#2O�S������QM*�g�<�T�R����q�8�VP�\'��k&J�#�x-�\'��Svm�2� �\"U��̈́�A�p�����|��/H��J�\'xU��O��W�|�S��a�L����]2��a�G��Jl6���#Ra�?�\0��\0�9T|��gǱyp�Ŵo�6ֲ��RT��ϩ�Y&�\0a0q�M0t��� f�Sʨ5��Z�n+�>�m
��n�3J��>6=�6��8�`��S��Z�JW߫�Ӫ��ʫz��/[����,n�{8z���K�mwRͪCR��+����I!�#���]�6�{i)H*n3&O�ށ.^������M�)r
U=yK�r��\'=2W�X�\0z�ZsH�J�Mic���Ǩ�&M��\\���J�V�2ϩ���JJ�Ȍ��p*���T�I�:���Z���AC�[>Ӎ[B���G��5Y�q-)���7	u�3(h����}*����&RR�@w_/�BJ�:	�IrDKI�y*qA^�t;�7ж�`\\A
CEMۭ()\'bG!�&��o�7S�>�J�;���r�]}�Ρ�����ÂR���ڂ���6�D����H��0ꦧ�,%���]	a
r˾��y֊s��AF
RG8ڛ����M��F1�3e�{��.R�$\"�V�6$��H��ع�+eQż^���lI�;�=��$e
<Ӯ��w���Zl�d`���Ek��l�\\�����9P�P|C1M>uA�z0��0�
9�,�l�&�J6�k;�&d�@x�I�$����W�NHG���{(�ű5+�1�{�K+$u\'Q�~T����Ԯ.��]�cXK�cIZ���6���\'����J����3I��Mxww�/�`XNE�n!#r�(멘�$�NV��^L��r�|��q���o8��,(<�[:�\0��I�F隹|�$�G�C�ѭ�kܴԔ8Lw�j\0��L� �w-��&�G;i��VwI�v�@Wt�C��%fy	�`�����W���N�^���X���qiX	&TdI�>�_���\'���X��qe6��Ca��S\'$f��	\\z\"k�`����d$�]u��\\ѭ,��,���dR��%AGO@
欿��ԧ���#O�#��N0�T���r�«kFN���>>`��o�1��#m���F~5zb����7Ӑ����\'��:�R;mΕ���=ڰ��a�b��=�b������:�k�@�&zPK�}���E���E���҅=˸9��ζ�y��ݥ�M�)\'�1֍��+c7��y�:5Bd�+F�S��O*��7�o��$�Xֻ#\'�v�^\0�\"#}��WG�I7��Z��*�,�/P��k#�*cb\"�o�[]�\\%�|[Z�M�4Q����β��F�e�L����.Y\\��dwK�N��?����8��L+M\"��V��m�*9����>�߭V�]�/�?�[/u��m��jQqm�VD��`>����ݶ孝^�;i�{�2� $y�[�{�>�B��Լ��hΔ��~Mh]h�Xۇ\\)�$��R*-\'�i��<h��kl�˻Ő�5Q����O!NR��U��h�m�f�ɼ-h*l+�Bf<P9�I��3>Y[���#���l���˪��h)\"ݙJ[ˢN�fbDj*���q�9�3�JM�z�ۯZ!��K��ְ�N�k���A�o��lͪ����1���p��wAQ�p╕$
��jd���r���\0\"��v�\0���JpK�Q���a��m-�����Ɠ�Ij���&�;9�1l}�`n0��wn�w,��*%�T�5�!4$!����*�\'�vX�/�P:�@V�_7�X���T�RXu&Q����J/bTwt��\'�[c�Gs�V�:�&�;9;��)6�C��^uG2ofϏ��ŭ��~ӛ��{	�ei�B�{��Ho�
��z{꼱�z�-����N�W�J�w
j��S�.�V�ȑ����:z����56�u�
�b�R����]��<��\"����a�FD�m����ُxr�V�ww�͝J�ϑ_�+�|d�^�X古?}�8�A.ɘ������b�7iK@J�ʡ�Q�\'��,㸱����=�9�*$
�:s�����F6yI��n��]c=�)W�����t��[Q�H��۔��
4��/�Y�ey.It�H��]=iy�aH���Yrc��;=��p�}p/�֫��5�	O ?jJ{>��O莏?��x���]�jr-��:�������+.^~���\0��5������x�P���M{.��X��;l(��!�f�4�u$V�a:�\0�Ҹ��ͬm]��frę�����ĝ>&�����Y�؟:M�n�a^`Q�]>5[ȗ����E�~��@�G�]u�0�r�z��$Tؓ�p���[Xפ��%��2#7Bi�Uj�րL��Q��	l���^*��҆)އXp�&f��Cq/�6H0�J���nC[
i �&�t�TM5oh]�1��ն6��Kk�3�\'�qqӲu�+s�*ځ�3/{l��Ȏ[QK�a!��\0��\'��֐�n[7vr�� }D6Ν#�(\'bL�FN��$�VJ�M�#��]��M�F��VY�K�B(�[s�mL}���\0B��]�\\bW��i-�#Us:�_��@��W�R����1v���r� �y�JI#�|[ǅ[D�����n�ݤ�\0����eJ˲A�2u��S����������HqiiP�1������+&K��#T�	q^�ix[D6ZG�;��+JN�y�C�����+N���Oܶ��f\0P����^�D�J٧��\\Z��oa#��Hm*e:�:Rz���{�d�<~����p��hm�gPcM�����F*M�P�9�q+[U����p������Ԡ�Y�A��\0�$���ro�u�gBVې3�xx��/��S6�d:��dxB`\0%zh4GZ��}�9�@Na��m���ݦXIm�<(�$��h�A�:uhI�v�}�g����ٻJ�D��\\x��<�Җ��]��\"3i�Xx^��춗=ոi-��}���	򣒔��X�d֐���A�-q�`J�3Ov�mP�vk����6��pE��.�����K{���(��?
op
l����NR��7�$4��)� 4X�1>�ZJ�v�s�yR�G`\\{�l1\\
�w�R��Mgt�B\'	B�lG��sx�xnQn�n쀣$�ڔ7�ì��\0�W7ԴHp�2�E��][�!�HPi*(�#ìƭɣZ�mQe����3�\'Cv8�*�\'ƒL�7�)��TU�Y�J7�Nogwcev�Z�vݥ�9�H 6�ҩgI=vY�r��_��?hV��\\#�r\"�J�Zf�<�z����AQP#U
�Ҩ+VX%&����\\�zOy�r�c��ڣ��v��%*C-�)2diӕ{��ư�}ύ��<�g�H)E$��ס�����̀#�DG��)\'��ʥLܒ�V�u�������#J�ȺT�d
��f���\\O������vN��R����k�J�a�t��7:AkΩyQ�h��o�6\\x��p�$�2��^m%��Rk墪�PS�c�޶���3m�@�Q������(Άy���$gƑ���L�U��۱����1�}�\'>��Y�:5p6�m�_�TkF�j�����S҆�6���W�9mM¶+�k����~u��d�3��M��ʦZd�E�44Q�pw\'��S�B�ҕ#���̣��D�{�v�\'mg�D�ƒvkE]O�Q��c�4H�^%�Iq�����W�ރ�6��M_1�#\\�0A�j�\\��,9�5�ŵ��&��SW(u?{��L)a%*繓�?\"X_V�簗İ��k�?{�mn���d�)Bƨu��AH�5����I�/c�|�a�]u��:��BNX6-d��Tr&ꍼi�VXV��W�k�C��}t�{m�3��J\0�\0�����A���b?ٞ����|ˉv�҄����\"5��%T�XT�^��Ú&�
ek%0�o��Av�m��ʗ�8;�����M��}˅�}�BP�!;3�s�KMA8�%5$����х��V��4�r����ΏA2�F�S>��I�m����[qU�\".ۖ7WxcY3)��J��\'/!���Vq��g,n���;_��/���^�q)ʥ8�B@�\'���ո�򟽢c�c��\01q�v�q��]�$�	I�����}�L>V7��=�q�T��έTJ�27JL���ly���&c���m	M�`�ec);u��Z]tl��
���-$!Ը�N�P1��VY���Y�u�jp��(8��s���x�-����.Z��)Ru�;�I����c#Ƣ��׈B���J��*��ngJ��������`p�6���a*�6�J]�J�C�?�ۻgԳ%	�\"���
]<�8^4��U����ٙK�Vqҕ��-���1��{8�6�q�������+*�d�μ�>�Kqq�͜#�K�n��\\^�l����
IJ�����\00?���ŋ�*����{���\\eȐ�)��0c�y�*�_�g�nIh�q��i�/:T�%#U�@�5�����̼~�r��죂]���Z��eIZy�����O.O�.Ϭ��Ǉ���E��q}��8P���c�\'{E��4��ϛ=����x��l���H�@�}���_�~{�\0y���N/VAcH�<�kg}#bt�]`]�h�LN�#��gox��\0m:�/�f_��p6s3�_:���F�&��`������V(�ӯ=j���<w�b-�!1�%:�O�^v�z��E}���N{��z0��4&�N�jc�>�- 31�v*�K�v����j���Z,�2D	��&���pM�!6��y�Ud�#B0�7�a\\�eI�j���.�m����A�A����9
22)����Rղ1ҍ�Cjq����y$�J�+�;�mIH��:ED��4�F�� �zj*e�8��Λ^g�>^����%���Q\"�X��b
O/8�T�V�ͼKؕaH�`)ƒ��3\0I;�ӿ,�\\X����3$�W(���-�L��P����p�j
(C�|Y@?�C�X�K�^˃�V�(�8� +1TO҉I-���
�(8#
e��k����ҎYq3^6v��H��wb��o��Xi�.�i�=��SɕU$U~/S��X�Z�W��J�}������T�Ԥ��cA�H�)���r�M\'e���a�Zb�,��6�!��:Iԓ�������\\V��F���[mZJT������^�X��y7���y-��PD�w�J��l�qe��֎.հ�rV���=��\0ϜE��W{k`l#�şi�j�����r�vO�@qT*��<��q�owb�k����-�Jy�|�\"�4���E?��1�)��(Jm�s�%>%r�ޜ��{���%�h�8����!j!RC�HCm�y��7�*N*/��l	�|W�p�����a9^d��0�\0z��ǔ��
~�qx�Z�j�\0�=q��8�Y�Y
�g��f�x�~[z���^�T=\'��G�q^_l�	#��~k`G�i��
3�9SD%rVZ�=��m��R����7W���W�ɎJV{-c���zo�N#M��͸�9��R4�H\0���Y�b�G��.}Kx���w�w_�B�hV�����j��)�i��f��U�Wͩ�YiPT���\'R&N���O�1N+\'&�^\\-��R.�XIp(@R������(��KO<?�9�|V������ؾm��H2R#1+
�m����)���4a�R5iS�����s��^р�z��9i]It�NK���!�iR�\\�������*�T*�bf@�<�T�������5
%9@�=i
��?1���ƒ)<�%ث�p���Z%���Gv9f�-�w�)���*�rn���iU�\\#*��\0��YP�L5of��#��B����\'��`�9Ðp�8�Qݯ+.�wB\'Ry�y
l�����݅\\}v��cD[��/\\� e�ՠ|��N�Sr{k�`�{8~\"�T
*x%������I����4S�a������م�l��V��qD��9�SˤNI|�ř�7L_\\\\\\%^[mwn+ed ��\0�TJ.�2985]�`؂��g	C�>6�Q ��B��Y:��
<��@^!�n�,oѝ�2(���@V�	�\0��S#������6�>��|��^u&=�S��*��/��7�@�{��1n�����nU\0���5��k[%(����OZ������[)JYS�i��
��ǡ��E�)��{\'6?e�����Y��-㟳+�͌���O���8�3n��\0ԕo�r�!���-��{��\0�\\�=x�Q	LªǍ�R�H����̪1<��B2��^�P��@W�+��W�Ey��5#��J���m�(5��$�d�hﳴ�R�Ң���O���L�ƪО��-�ͣ_޹��ɟ�ou�$VG���gN��9 \'�
�­��� �p�$�t�X��\0b���N�R�A����}�D�r����\\�T����*.uTM-�
�+2*��{�kC-��0�v��x��[�X1&���rL���P�Eov�S�:I���1�,�{BI\0��M�EW�d@#��u=�$��6w=˛\'�C(ކFU��W�\\a��f�r��D��}|�\'���n��������Uup-�)Si*ʰvZ�����ǒMi�����MXQ�%]��s���X(
q`��QVP\0���E6��7�d�#˫�C�,���[M�M<�l�;�9��8=je%9&�x�ww�E�����b�*�%cb��O�1���;m=0��2G��Z��U��h�}ȅ��\0$ƅD��EW��F�a\'$�Nn]J�mg�3�=)/]��˖����[
v��#U&G:����#:u.�vv�}���I�ǭ:?a9��0ubX�jTK*m��!9��\"�ޝ���5J�?b|#}��i�a��ˮ�[P<���ɝ<鸦��:x�\\�-�o�ZbxB��0���d���i+\0kd��jUVc���\"��ME�k�i��7l�O�Y?l�q��RW
H$k:s�&�8�?�.P���� �2.���+�t��e�SE9���=���|�����4�v�:��-���W�k2��4��
V�G0*�͛������]�G�0�8f*�UpCe��YL�;H�O�ږ�IqWj�V
W���Ij��f�*�@�E�����w�Sv+���cU�@O��?��c�>�f\\��H�\0]��D<�wn��HH9FB�ysj�����VZ��	il��-[��T]p��&?�*�[�JuOاx�W��i���%�HP�	>���i�*e���b�_@B3�
)\0iĊфZ�[0�MAl��x��ta.f:���Q��Ҷ�G�I�x�*\\��h���ψ�,e��S��\'ZO�\'��ğ���3��$E%����mXcKAʙ�T��|J�O���\0g����[Q�A�j��c�����F�z�hr?Q��I���Jv����E�-ٴ�|�ɨ&�w�!&L���%:��t�v���$GZ1N��tu�Q�y4r7��\"�f�]�j�:vL�
��1{���C+o�dUrU�ٍty�/��h6:k�hr�é\0�<�V��iTj	��`�]��͠�Т��-J�ْ	���<��#G��Kke��<l�XR�/-y�Rc\\������X���x��J��W��|�ŢV��}x��$e\'�\'�*���>d�M+�����[�.r8�nS�R��5
-(�n���T��f��O���ia@�6R�촟-Q�wn)
�J�Y~U+�ھ��)�\0��B\\0��kʞ�S��@(��j�BCi1�<�?�Ǯ��Q:Ol�r��\0-�WX���0ݫm���2�e)�g:F��̚%�/Z:ppJ����\0��}����qn��{�0��\0�!3��y��t��N4�b�;��{KEX�%I����ԗ֔�p�KN��x��NM�}�W����p��+l�2ڙ�}��� ��(�%:��m����O���\0�)2Q���ڐCg�|HP�@��+��\\Y�u,��������/!�>�ӍQq�Wn��ӫΤf!����Z���_�T0�윂ڀ�lO���.NK[��ys��� N_#<�?�Sm���ʱ�&ˎ�,?��/���;�JB����3*\"dz�Z����3�si���-�ݥ?t��\0a�ud���9	����*�qb�C,s���o
cƨZDt%*��SZ�,��*E�YPa��J�\\��O �I�gJCV^�T�x�4�8K����KiIWEz���i~������Մ#S��n�1Y)�+ҭ������>6�W|!���h�`�&�n��(.�ԉl̪	��Zӌx~��%�\'�0���\0}��䴧s�-I}\'r5����VW?��O�Y����vit�,�d�S�\"
�r� �}(��d�tu!Fl�D��\'�l�{y�S�8�JA�n<��G�Z���>ϋ8��ݱ{֣�yi�^�N)��+���Z��֬�\'��؂��?�=�Ϙ��ZWBF�`I>T|�<}���t)3��*H���Rt<�ڋ^���Bzl&��0O�w�w]�$A�u��1�2C��ܚ��-\'��;�S穪����M�\0C�l���>���7\\��$��R�}��!4�W_b����\0I73	�Z���K>*j_bdƉ�C�a˳�A.#�cy��ڭ\'x P�Uf���jH�^��\'��~5l��N1z\"�,�����Z�V3�_,�&�z@>��y�N�_�-�H�a�}�H�*�\'�.(��a��DiʪU��\"�qۂB	��?�hE��:W{I�+���T����Q����.KH��|;r��ӆ�k�`�aUg���,�WO��j��JaL8�`x������i`ȷ�}�*l��@�ԩ�]12Ö�9F����M�Ƚh܈>��Z\\w.�;�΂[]��L���-:�,%��̭aS���1���=����$�wL����2-D��\'j̯SL�xrI��,�~\"A�[N)Kbؖ��v#1>���5Mù]�%Ul�q+ssd�\\!恶uN\\:�B�Z�\"F��&6���O�T�7\'�8ñ�Lm�M�s0mk��h~`�N�V�÷Q�Y�9��T%�%��m��ͣN�.�����B��y���S�h9�ʩ���������+9\0A���T��E�}&#��g8o�QԑB���%�[�Ͳ!�V��Ŭ��iHz\0#�:~����l�ŭ�)sx���љHl��)Txf}�P�>A�
Z���J���$r�U��]�FPUVN�q�K�p�l��l��
mӮA�	��ԧ�t/��E�:gK� }E
%$�G���!+#K�@�L��\0�{F\\�y%O��*ܨ$�r4OH�tf8[�Ww%�_��;��x{��
op���r�s��^��e)\0��	�̈́�bܭUZ�W૽��[q��a�I�BLt&4������byܴ�qKO�j����͠[o:��� )I)�w��w�q��V�o�m�8��q��#� ���\0ڣ��ExE&�<I�#�o��]R���
V��^uӍ+C ��m�Wۭ[��7
qLXf	�\0������ʺ�r�4ڞP�\0/�Ci7��[$!ПH�o,����T%�ݷح���>d
T��Qߠ�))$I�0�+4�H��6yrM�4�%Hx�6[Y[d(��@��V��\\0��$i�S!օNU-���e�����[_JFI�?Iw!%��qrX�RR����jr�n�
Y�;�B��B4��i9C���y���3��cH�mHg,��Q�#$!�
�p�WV\'�W	`���[2;�����yY�Q�#�&)az<��}ӋJ�Lj+�1v�G�r%�6S��қT.����D:�N����ڑ�F���I}�b��,�
�$٪���)Y*�Ĥ�$�O�U<�Էc����[.^�q����K�u@\'
A:���2x��x����\"��-`�ku8�vم*D%*Y��-d|�e|�i�����X/����b3W\\�$���7��{)ʴң�}�qjn�Sl\\����[�ĥ0%k�ĝ�j�DڳCǝ�]�7�[7b���q�ӝE\0$6��v\0�&u5EC��ٍ$�X���<��JScn����@��2IyԿ[�|�쏱��ėt��=��!��E3�������\"w���+��Uƙ�^K��m�#�&� J���\'ֺ�$�P���xz����8T�e)C	|�:g9�)��Q㌥o�ҊI.�VX�!j��K=�Ұ�o���7t����V�q�_��T��&���\0��x���B�f�)	Cwh�$��*D���3����q�	n��!������~M�.#L�0#.YI��i*�,�;�]�\0���l�ӈq$��e���C�u.�m�:P�e����t���i(�̉�1+�����({}|^i�YRa>$Ɂk�z�Mץ�G/x���-¥*U���&�c�qM��E-گ7��^\'gv�a�^!i:-j���IN�&���>�`�HC�Z`\\���\0a���=�_Z|�.����Q��1ב�>NO�
pP�*�����T�\"��6�Jp,\0��m�u\'�#��H��9e�i˰�9v�{*K�I�\0\0S�>POƔ��W�Ǔ�ZE~���.u��a��[�!ܪQ$�
����-ƒ�S�Yn�����k���q������@OMD�]��+)�+�7n߹�S������\0|��Ҏ5�F>lϋ�D�@��ۿ���� I֙%�(���L���C����׏pj���Rnm��Z�+dB@�	:\":W��)O,��w�<X��R��=�8���}j��5��6���X)��I�4�ji��r���ݥ/8\'c�mFN��kc���(�PKz�q�|1x��\0Y�UL�K����ڥ�ݻE����*?:���\0�AM��pe�щ�Y�ͿI ���+M4\"����\'C����f����9�Ť��%7.@�t�K�\'y<��n����Y$u=i�/a�����<���������̠�5�X^�����X�U��h��z���+3�������,�g�:D�9gO�����Д�g*?�@��bj��@+\'��n�BǸ:�|b�Hν%�U4��.��Q�5�$�_	$��T D�ʕC��d#�XH��Y�n����-�)��)�.($��ui�rZ\"n#�o�d��*[�a����?F0N�ZC��9fKI��YM���j>R~ĩ{��An��H�U[&7�&-�D��
�*�U%(Sdy��5�!y4�/�iAHJT?ӵ����֗D��4�\\:N�F�9U�#���?7��<[)N.�t���T�׵�ܢ�G���;�(ZO���J״�v�h� �S9�J���ݭڐ���&Q��
$��\0~ �uG��ҎEX1�b��a��3����uXJH\0����L�:����E��Eo�\0-�T%Kq-��Q2L� s=#��V�:�2���I�/������&��\0,ʐ�D�U:5��
�9;kF�r��{�q�Ø:�N^����U�b:��λ�I�
�T`��S�~:����Ź���2���K𸴃:�ʞ�J���\\��..eV�We|���_����u��\0i�m��W�i��L3�Z���.�QnۡW
�\0�H&N�F]y��D`���F����㕵ge~��e�&7IF�u%1� �>�ŏ��H=�l�w/��R^FfJ��uI=y��F���^rs!|C�Bl��Rˬ���Ҳ��6@ȓ	�	ȥ~�Εq��!N�v����-�fˊ-��)ZT�p�s�zՈGvR�8Wvo�5���Wv
��^���Jt�#ݶ�9R���O�*�1��j��s����d��y�-E@�G�N���%%	q`a���ؖ%�
��,�D�\\��p�B
IN�� *=F�Ɯ�Ϋ�#�q+�M�wo]���N��&GxT��7#_}9F�%{��\'���V��K�\0�����TU\0�2LO]��GM��礛���wt2�NT����G�VZ�~�PSy��
����6�;�o���R��������ߺE��x��=6}업.;3��ٶ;�ѳ��j���ß����Dy?W�����~��w��ӷ���TR���r5~>6IG�Z<����Z������\'����E�l��$p|��[o���U�C]�V�--ĉ����໔���ת�f�\0#�_pw��8<���N ӧ!R�MS��4���G�|��O�Ƹ���2��$�&�����%����
r��Us#[ş �.���6�e4��Ip�<�5�ђk�Dom��!:�Q�i�rf7�I�L\0㎼����_��x��9�I�4��6�[\\4��#֝8��G����e�\'0��K4�������2��!,
Iә/ʋ[9x���ct�
��$=��Ù:��v�N_*��_Jkm�a`�5 �J/H=et_kQ
���e�M�R1c2�B+�D�T��6�x�P��`I��~���Sl���l7������o�@I�in7��ʞ�
�L�X�ä����\"��t;��\0�w����oq�a%.nGZO>K�L�%��0���! ΂���֑G&%)]P\"�-�%)
���/.qEg�b{@�8�������\"���M�4�И�J�6mYN_
B
��(0�Lﶂ�4�K�^G,�m���6�r����]���[!i
TT|����B���t��vV��Qh��ݺa9ظL\0��
}�3��R�r���˕CM����xv�wQ��XM�������\'Q�%E���U��eq�c�8����ֆ��H���$�v���Jh�,�$��-�ƛ�����l�J�0��4D)���幡�)-��ɧ�������.��x�/>� Np� #B6���s����JR�>tjW��l@���޳t��%��N\\�@Hԃ�AЀH;
��v/;��bm�����	f������
!�\'�3���4���IC���%o�m�k޵e�eBT�3=$�D{RA�N��\'*j�sj���g���u�P�i�S,��d	�t$t�Z|��4���N�~3x����$���R�G�<�Q�>t���ɸ�w�1�a��36i$��I�^��W#�\\i�������Ç�I�n�l�$�Z���Y�����Ŏ+m�wÓmۇel��X�kT�\0�2D�E����rQ�Ϥ��Sv���h	Km��`��Z,�Kvfb��M�1>��?��\0�\"�e_б��ĭ#�����\0hz�S<���.�B�#��\0�׹����Y�Z�k�`�_LؽuG�?MX_2����nPEˠt4Ywb��Z
~��I�ˆ(xS
S���l����j:���ΆRq���X�e�|��[&�j�j)$�^o(�RF�ol%f���m�ޓ&��/cV�ưg�R��
��<z(���Q#�p�[�6�Kգ�]6¯�b���Y9����#-����!����*Q rҫN^�և�P�=g�.Nƥ]�m�ɝƠ��^�{,�H
uLJ�L���n��IN�^tq�,������P�Wd�Dc�[�ǥ�����H�Wr;\0%P$*�U]	��&yE^��JřNq���Z	:&/�
���Y���V�bD���G*�@�Œ\0Tk�c��i�r��\' �����_�y%��2��`k�6��p��#֭CČRl���=!�Ww��~:Ѹ�;:.rav�u��ꚦ�e����(d-}��F�����b6�j�6��R��RЊmZlf\\Ѝ���@G�x�^�He���Ox��
\\��(�i{�W*z��A��+S�\\b�^l�]t/������޳��PJf ���5��.,�X��̊�^E��2��J�L��L�r�T���
|cO�V�ٶq�=):��\0���:q��L������a�.!K�qp��(m�]H�{ɝ(rI��8��?������U��ЄX��\0����9�멪�ĭ����J߹��s�).Y-Ie����3��@s�h��\'��]��+��7�U�ʞ�T�������7����/Eİ�K��gl��J�.�S�B����9c%_a���7&������9�_xh��U/�R������q�i�U��O�q��~�.$�x�:��!��\0Q��j:W+�{,O\"�`BQw�S�md�
�^-����|��;bm��� �G���8=������#����6��%8�-\\�g�e��=������G@d��@{�9�}��:�7�J%^�)
�<�Ǿ��Ǝ��7A�O^%�G�n�L�R����}I�ց����W8�i�1F�x�
�ٶ�Up��IJA�g2�t��JQr�9�0KdW��=���AN�
���Z�o�ק�Y�7�W.K�\"5g��j�
�OݘQp傥�h&u@��)�J]�V<���F�j����{��I���	��<�ԙJ)i�g9�]vJ�S���|2V�+2���ov�C.iH�����,�+CVj�C`\'�9�U�7f��j�p�K�+��A���g�	�X3��j�i<M���b�d?}�eC����C�*����UA��;Jh���\0��ػ4ŸkJe������>�~�D�bR�d�hؓM�O�|�����o�,Y�Z�X���A��y��[�pύd���|��8>��`sc�H�ҥ����	�)m�Q����#]c�ځI����B
��)n����(�9=z�ڱ�iw�F��P�Ҋ-�Ӣ]�o(%(�T�2��G���f�\0��,#���Ц�:j�5[\'v\\�%��İg-o�ZaGa^�u(tyl�+�AlG
-۶�>hh1fNN,foQƥ�-[\\eQИ���E��TK��\0v��p�]Z2�)L��������\\�{bl\\RR�@�Z��\"�ٛ�
��2;vOxzε~&|��Ln�\'`yiGؚ�ш7/ڹ��.�$)�:��������M
i� (^w�ТqD.5B�41y1�1x�H��m\\�0?Sq���$���r��,�d<�n\\�I�����$���n|�g5N�nN]�v��B9r�kܔ����`�dԧDJ>�U�\0\0<B�N�>�(��@T���H&�R8D�i\0�0c+m��P�);�����^Z�s��d���r�����5��kʊSgG����!�!<��y;E�$��:��T����U�]�.�`��U	�3�I�0��e\'�*�ͺ����<���Mk���-�����6-Cm��.�l�����
��%J73���}�pk,6�ͶK���\\px�Q\"}�#�ӱ�]ə>O��ڣ�jN���M~��R,�ЀNو�@�|E_�8:��<�Qd�����,���$
ǯPy$֣�I��So��۠8���ir���$f��L�W�2w}!�;�J>�;��W(KI��R�(I �#1�>@Q�k��2nL�q:0x��yJyVkiK�ε5<�?�8I�м�b�}�X�-�m��7Kb�1�!Gϖ�PJ
��[�m��	�v��)��)�I?���;�[��]�����Qt����c�����������w����	&�#�\0R7\'ɖ��� �G8�˻R�;�C|ʄt���un{5��n{� (�̨�a���sI�Nڱ�.��l�i�S��p(6T�Ӥ�?/�\'�O�-��y��i\"����\\u`\\6֫\0�Y\'S�J�˗z7ዌj\'�\\,�$��@�B�����A�1{��ٺ뉅-\'*N��d��W�-�*����xT�}�b�J�\0k
�p4�����G��<(rqH���S{��a82ٵJ��D� �����>�d��nH��\\�c�A�#H��+
wH�ɭ��o��rx���|ܜS
n�a;F�����8_h�����t���rp�΢]�Lw�a#��*�sk�3mǩ�&ξ*�9\\e�������;��n�(2��O�yv*s�@��yxH�<�ˌ P�#����Jedk�m)��-�l��2�k�m�U����������\0�]./��r��m���n�0����\\�6�q.(J�_5�y��
|`�:^�^\\�}L�x
k����,HW�Y��kc*J(�ϖݶyW��G��s�`w��s��s/���)9��U����iik���)q�w�(vy�X���!L8�\'m�Q��t���Z�Gx�����ɟ�o�Q�$�kdƚ��+��+v���R��м���
2���|�m��e�e��[�W����G��̫,�����EMn@NJ�Ǳ�-{�AC�HY��:+�J5�Ŧ�Zb��n?\"|jJ��:җW��#�O���1?���K�@$�e\'Y��ϤP8ESC�������M�wHR��kQ`�{ ��sT�1��
H�\'Ȓ�QsWC\'%L����-r�RҲ�#�\'H��N��\0�)R��Q}���-M��IPT(i�9�K]�2� �SL��!a��Rd�\'R}Զ����{�⊸q��%���Ԯc��zjT��
nN�A�,<ݧ\"���A�@�j��5ѩ��ap�g�7IQ!��T53�r��Ҿ,���8�����.-�$����g�4�Ѩ�(�,���n�ǅ>c���*S���!&�>g*�_FR������9[�\0q��w�9�J��;\0<ɡܥE�8�?�kv?�Mp�b��]	h�\'U�@�d��
������,�����n?r�� �|2en��ν��TF�w7�*}��\'�\00��eA5ѳ7�h3�j.i/4�Y}��С!@�:|*�L\\��2�r8�3ɝ��\0�tp��q{�8��7�g+U���n��7H��ǕVŗ>8�|��z���3bÖ|�����j��\0���B�+�F�\\d������i��n�������
_���ut��AH>#��֯&��<j�\0�xw$����	���$�P�(G����/7�@{���J��#LɄ��m��1��(KƔV����
�tf��\0�w��r��3o���jP&$�Y:h:W�8��1lDXٸ�e/��{\'��κ)9�x���/ZإAe*�B�	;�N�ͫ��U�w{��=t�1�i�:�?�+w6\'y�2��R!C�v�N��T�
��;�?��5����S��rEǊ�^i��<�I�/!��{��Ow��?(Z>QU\\t��%X��kkgA�̑�J~9=��j��p׬���	J�W�/4�U[���R�
�^���7l<�o$�y��qg�8���-Kg��[�aX��_�(Nz�*-��[-^�g�^_?�<.�}�������f�k��/��d�e٪��\\�ۍݠ.�e#OxA�\'S\\_���_�;����AS�=ڊJ`t��#kL5�9t���\0Ti���\0I%l?�G�I�)�\0���b�x�;��Ҵ$�%�\05:���I�<�^�	�F�\0�(���vZ����\\b�*��T~��%�_BwMop� Q֊>,����$\"�3f\0\0�sҍ��݈YqݱݷZ�蒠���x���,�� �ÜzïAB�Q�w�&�gK��BX�,q�HSiA�x���>㲣�^r�N\\�5�Ԁ9W�� �P�<w�>���T|
�ڽ�l�)�MJ�S�d����R�&5�\\֎[c�x�� �*O�s�HY�e`�#](%�
�ɖ�)�����u����.���6XL{�#�*�/+ܪ?ՙ9�#�
�\0��zc����,��
���Iu�wTVJ���qz������h�)(�E��lb��G��8���*B�@(<ƨ�[t��^:�l�Vć�`�Y��?ܠ����G�k��/#e#�|;pI׹c9�$�*���;�z�:{#��������J�&> Q������{,rŲ�f�mR��$��U�y��R���Z�8��C�d�4J�$��n3S����(�
@P*L��C�._δ��b�5K��ųy�������25�^x#ܖ�+Û7C*aC��Uqfim�Ο���iXl�
�qN��i�#;м�����F�r��B����a9vɶѾ�k֍fO|@~����[%Nd�\"�J	�J�D����7��L�0��Ե�����ȟ�Qo���M�\0Ad`���,��ca�&����lt|Qa�\0v���6�	$u�O3�\0S���Ҳ����ǝm˫w\"I:	����=ti��H�������MŨ/���B��ϔ��idrv�J*-6�p�!6v�e`)⬡���J��l�%a�3�J��8P�{�ξ�Ѭo��\0�-�i�Kt�ނJ�G/^�-�`S�~໤�RT s�iRM�Y���C�)�a=��%:�I��rt�;&Ur~Ř���7
��mA���Jݗ6�/�X��g֍l^B�oe7��/�;DJ�E��|D��Ŕ4��\0R}�|=���D����#Iy2������\0�˝���xۆV����+d����¸��W��[�\\[�_u��������|�����;�ؗ޹k��\\aϠ�Y�iM�x�Fp���e	�o�xYYGM\"��Zu��ʔ`@��ޡ��,Aklt��$��yR�he=�����UB���%!�I3�ѧd�����S�Lr�%�r��Ch�9Ҡu�\"��vs���6q���*�
��!��>>DՎ/�{;V���\\@�ͧ��j���)�0#z�����iJ�S56KTv�E�
)����֎�a�	Jdk�b�I}Β�m	���-2�5�Q�&��{,\\X�A��~E���T�4�*pk\'Ρt����p�oT�vkC�m&`�K�Bܯ����c���ᶏ�^�BZ��l�k>I����Sh�g�a�:⤴�4�
}p�}���k�/|�S�h�J
?�2�u���>�~��=��s|�V^�d��ٗ�\\)�J�GI����qQݰ�Eʓ����\"̈́!����w��Y���Q�P^��{n�e��r�@	�O:S��{
U ���:�����i�`Z�(p[^����jx���5l�e���(�T&A�{��-�_e\\��KB�í�Z+HB�w��>c��X�6���ʬ{�-��ZΣB�Z��d��h���{I��܎���]H���JP�{���^�pn:�Ui�a�Xͫ��\0�T�4�q�4��<�q��i���ɋI�������0�����^�,��l(��>����>|?C�:���L^N<�R����.�e<Q��ѷ��k�b		| ����cCU>t[����Ҋ�q���n�EZȍ �Qt��6�v\"��m)\0A�q�����Z�TFX�4�j�BZrLA\0�@�[�zQ֬SU�c�!Gmt�K��2rJ�3�C�
����g��~Sķ�#�\\L��V}�j��:�2��7���k�JT�	�7�u���~����-�K#�c_�6�A)�jaq�!6�Ru��;b�K�\0gIZ�\0��D8Ŵ�m�vZLr����L��:㎎[HSӬ5ۣ�R�ݖgg}��j!����A%W9{�t��\"��[���;g�;4�\0��E�ٸ�x������O�t��\0ҟ}3�����\0��\0q_60�#Ҽ3ُ	','1','test','2016-05-19 13:33:11');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------