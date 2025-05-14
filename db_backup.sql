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
('1001','','15','2015-09-12','','','La falla es aleatoria, es un error de pantalla azul.','Esto es una prueba de diagnostico','la solucon<br/><br/>se da si<br/>presupuesto 1200','','Presupuestado','Ingresado','(Ninguna)','0','4');
INSERT INTO `ordenes` (`id`,`id_empresa`,`id_equipo`,`fecha_ingreso`,`fecha_cierre`,`fecha_retiro`,`falla`,`diagnostico`,`solucion`,`nota`,`condicion`,`estado`,`transporte`,`finalizada`,`id_cliente`) VALUES
('1002','','16','2016-05-20','2016-05-20','2016-05-20','Tremenda Falla','La verdad ni idea<br/><br/>Esto es una prueba<br/><br/>Chau.','La solucion es esta<br/><br/>Presupuesto<br/><br/>$1500','','Presupuestado','Reparado con Cargo','Enviado','1','4');
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
('1','0','gbg933','af5a9f4653c88fd965e1182505695b362930b285','4681','Gaston','Baldenegro','Cont. Abayuba 2581 / 201 Block L','gbg933@gmail.com','099394334','����\0JFIF\0\0\0\0\0\0��\0`Exif\0\0II*\0\0\0\0\01\0\0\0\0&\0\0\0i�\0\0\0\0.\0\0\0\0\0\0\0Google\0\0\0\0�\0\0\0\00220�\0\0\0\0�\0\0�\0\0\0\0,\0\0\0\0\0\0��\0C\0	!\"$\"$��\0C��\0,�\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0	��\0T\0\0\0!1A\"Qa2q��#B����$Rb�3r���4C���%DSTs���56u�	&cdt����\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0<\0	\0\0\0\0!1AQ��\"2Baq������R#$3��4CSb����\0\0\0?\0��a4��ZH؛3_a{��1i�%,��UD̑��W%���`I��6�w��Lr�%�Ie:�ȱ�F/8&.ڢ��R�S$q�0���@�v�m�O���s���/��t�3Ek��T$�������.-}�^|��%���=�Qщc,%��J���uX��ͭ���\0��\\�:��;�p��1���~�X��.X�����2x�i�R���5��r.\"[�$j?T�@eFPlw��=�V�-��~SR�|��=J��Ri)���#��Y�[���zz=�3.��\'��-��-n_�zyXn5�GA��ҭk؃|�6qÒ�R�O(D`M�:��j
yr�L)ꤨ��9d�4�93zẍ́��-\\[Y�j6m��7����EX�;��~���dFdi���̉s9VmK$d-^[2��R��k��Ǟ=$p��u	�D�E*	��۽��2��<�lv���i2�^�)eNޜ�H&gIԁg��\\���q���#�$�U�f$S�+��07\0�m|e���ڵ�>>:����a�eҠ�y��2�ғ��!p�8ډ�|/}G���w��,��3�*��Zs(�p�Ǹn�����Uô��O�;J��;�.L�6fP:��ߖ�\0\\m����:3F�HU�X5Ř�N�pm�=���`�5)U94+�����X����z-96yQIP��M_�Q��
P̖\"�j�GK����\\���s苌k��gH��Mm�S\"���I�����v�{���ٔ�I6�~�3��\'0����p��D�J!%A���l;��i�@��U0�8t.;�bf����И|(���F*�^1����\\wF%̫������i8�N%�F�@èY}��9a��d%�X�ZAp1-Z�u������3��HŨd�\"�{�YY�{D,H����ȶ��N׫_��聘\\)�b]._�V�ly킜��3��S��+*#��s��&Sb:�r��v��m��h�#��+�JhW��������,��u0d�O���q��,����x����`�c�ܱmV�K��v{%��e|I��Ų�s~XT��\'y���e1��M���)�@�#�)2�ٮ-��Z�p�U[H�M�����j�$!��J��8�I�q������Q�pÑQ���Z�+�&�Tc+T\"=PJ���f�_��`��F�-�a/J�9a&��&a��GK���L�CHՑ��h�킓�k�������\\_�tu4�G5<R$�v��	<5�8��+5L��	G�����lHzu�b\0��jaln j���PSЬ��E�D�\"�bB�m���V�%;G,_OIՖD�-{���{om�z`��r
|�)XVS��D2��jSq���T�uY|�VƏLþ�Xoϧ,\0s%�6�AP���geAX�[TӴR����u,U��S������ʸ{��z�� ���x��%U+R5��X)�P���E�m���;#�Ltt�j�ҩ*�N�Ո�$��m�,
��9\"TIMB���%Ph�і �4���[�6�8!k_h�w�g�e�6X��G �ۑ}�mϯ������hީU{6P�=�e`z�T�k�l�\"�Ȳ*�U��ap�0�#p.���>QG5LLf��7mAd�@A�{�إ��K2��c:f��\\i�n�y��g�zvgv�\"�5��\0��se�W�e==U�f�0�i%���U��i���%�p7�cB̨��n��)�����X���q�U7��y1C�ޘK$q��Ԩǵ�s�6�L�t
M�@(��q(S�z�]3���2�G9L����ѣvrFB-��Q�m����`It����fEU��e=:��%�i���.l�\'K�hȷe��w��󘨚a�Llj������Aw@��@���\"��|·/�	s*h�%��(��5^�k_\\{]� y�zhɵ�����)��>|�6\\���\\�f]Y]u4�����/���gpZ����*�$���-CgTQ&�j٣#r�S#��Km�]O0N*���fH�\'�uF�:�5�#����)�0��� �1�R��+�<�dD���4U6�`�F�#�pk)cp
{����-����_��\0��v5�N^�<����p�f��,}�\0����_e���f<\'�sP8f�=���SJ�J�!�����$\0E�q�,ׇ{�GC��c
jԁ��l4�����x��[G�H��&�Z�W&�j {IW�m}ԅ7��l*���9�*��$�Q�t�ya�p�uMMA5<�u��CZ��J
�b�ꏸ!���$��L�F���G���ʍQ>�����c�.�x�*���Tc�Tʲ&�e���q�ǿ�x�7�f�cY]U�t���R�����m�[k���;���\\.��jm�Ϟ�!�Zh��L\\�n������+�z�8��{L���*�=�ǖ-W\'�\"�;�_���h�1��S��Q�H<��O,X��	���$��1v���bsy\\���G�:ؐb �1�X;�����1��>c㊼���;��ʋ}�(�nDc�o�4��X�܏�,k��+u�Nna�>uk۟�Ôz�r�����Ή�p&��^]RI`5X(ŏ��1ml��u
�|1&�{Cވ:�ҵz���ݎ�NIL�k�X���� �/���[i��8���H��<<�V\"=4���^�9���d�GI9c$�q����<�}���>��ޏ�0�#���G!#Q��ŕ-Y���2���q*	���C�1�i-2�Xr�W�5u�����q��[�Ҷ�J(��)�	o��M�]��#Xȡj0ܽ��M����=��������>�˺Hb-�۩��<��|ަ����>���2������*� &id����8��A��� �/h_��o��Q�Y�4�*&���XClJ����6�=1���ҟ�����^�yd�@��@׹����n}1(��2�j�ٳ(k��f��n�\0���t
=������*��3��%���w�	I^�I���������~r�5��#��gZ��s)&�	I�lM��M�6�݉y�R���T�YP���Q��~�o~Xo8HV�3Ju��Zt������� ��w��\'��FmPYEd�G��� >�����TIkmg*�\0�)�qLϜ��%,Ԕ�,����1�;!pB9I`��./c�P�����M,�Ӂ0Y�g���ˬ(7�N��܍�f\\G^ks*��>���z�	P�j\0�$�6��x�6��yj)�a�#��е�V��UV���d���.��Z�f|�6��>D�����j*�I(Tw�덀&�E�m7�u!��b̽K]\0F��j��e+���6>�1�p��(���%��էZPZ��I�:�M������YpS�=AMQ�|SJ���M.���Ho-�o��1Ǡ��`�A���^�>~���r.s�Ա��	�3\\�F�C�#K���v��/õ9�Q�M$����d�R���y�u:˟��h��>�dk45	;�k�u\0���4��*Nf�����	}b)G=6��)#�IR6�6�QQh�7��J����2��++�3��$Ro0���q{����}����<^�ǰ�-|T��vs��n#f2��6���\0ܵ���M9z���(���$�^������lܷ��	�I����u�������1����웕ʱ$�q���x�[n/��=��/E�=NW�,KD��k�Pw\"f7&	���MΒN���p�+�����ic\"�l�$}��p\\�M���y`��`��AG[v��N�3���%E�FR
2�e6_M��PT�F��h�E���
[�m�Sa��K��n����K��H�$FCue�_/.�.�#�I@�?d\\]%^I4˥.X���y�v67�k~�$Ir�g����S��@���lN���@����z<�ii)�L=f�UnK��K(eņ0Q�+a��<���C^��ҏ\'��Uꨳ
Ag�x��E�0H� b��2��L��v�,����97ǟ�{��3}^���O-Aq+S���x0$5���^{^����D�\0T��K@-�u3`���c�I���孹�W�1��3�2ƞFf���/�%#�\0�0HA��/�t c5d=&�5X[E�ӪiX�_��d��\0��\0�b&g��O�t�O(����l�o:*����rOQh7�lU���ӨD�yk�K�[�0�\0�Ӫ�cA�\\h^\"�\0��v�+�ci��?��p�Y�e��HG�ck���I\"5���x~��3�ioa�Įް�|�������h������C��6��}kp�}�i���ja�7��|���XK\'+a�	m����\')�-��Ğă�Ë\0���f��*)�,�d*@n�ec\\;���7�t2�)X�I\"������>�ŕ,j��c�L�f�b�]=3��`q\'�-+����a1*�;�#	,n�q�����\0�H͒\"���3�J����T����$�crm�R�����t�̌l�a�NiP��8�:�`0���@��i��ŜvQ}�f a�UXK٣�i8W�=�u�a��X0#u=F)���5�����N3*���9����H���Tx�P�b�ٔ��~�<�2������E�5���Xg���d#��vc�5��̩i2�Z�Mt����$�R<o�3��3�j����3�L�1�d����$��%��2itu:�R���kn�Q<���n��QWKS��	N�D��<����ِMɶ�Y>���_[K%�s�ϟ��w����h���1�Ѫ1y%.���/{P�o�/�G�\'fđ�W���~�A[Q>O���R�2��H�d�Q���l�����q.�J��zv��LU(�e���\"H���8Ԓ�-kF�۶�5b\0!f2㋸���2*�޲���Uha�A m͘��\0�>*�h��-�/�J\\������cpI�j7����<�ϳ~\"���h�0J�Q��{Eu�^㣦�\0!	KY�qD)38���E��.쟳��B�ܛ5�1@ɭ��Ҳ�1�?\\Z���*�*�!eas����v ����x�����E\\�@jɝddK)�f�_f�c}�!�Y�P�TO�f���k��j׳��%)a�m����Ts����iY��/�CMd��e`�h�,}���^�us�����|�0;,�����aw�h�.�.�ڞ�\"�Q�r�H�m\'�\\��[;���ʓFz�wX�\'ۉ|&��p�o@���kF�{� �a��z]��\0G�X��Y;\"P�C����{��wy�:���X\0U����]��\0��9O��ڎ3���Q�rDm���m��;ѣV3Vñ4�����*P�B��9n�;��?HZZ�Yu<3���Qnd�Ž��\0��uU4mN���jzy/kҐe��:I+����#t�6V#�ϝ&z�u�|��ʟKsR��h�\\�j�C��H����{�ƴم~G�qUI�f�UDz#T�E<�+}�6����lzn�g�#�������@��Ef�$�����%��r�k8F4�CQ�!c��b4�w�7����A+b�]����^�aO����Z:������%�W���h�ĥ�x�\07 ��Bf�*��c�c��i&�s�VӠ0?�̌|�ƉIB(ce�Bu0�����?H
j��=���N�H⌑�gv2���0�x��F�~�Ö`!����ZI��ӕfj+(���6�4V`��]�k�$�\\u!��Q�OFmO���4OՅ��\'�\0e+���x]�7��i*�gKX�<J9T�Q��g��b�i��%��(�>�0܊�o����m�>X�._Nۍ�1=���;,��	����Z���o+b��UiZ��L�H���{�ŝ*ȣ���D�:E�ؾʩ�{j���5��Gҧx�
�`�/�Gg����40�5��T�t�2�P�N�!X�ͷS��5i�����
S� y�Ƒ��\0)�^}e�u���S�,{j�i��E���Se����<��ZSS����a��V������i�IЇ߇*2���c� TSM��MlfZ��D�W\"�:cQ��l�e��[?�1�M����+q�aV>�d��&�IN��_�!��
w��0��uy�֢���b0�$�
�djd�b1e	���l1�&CK�{�\"�)�Eh���Տ�I�U��o,r8���u�c�Ib[��&0�}G�B�+�2�q���(�olO��%��XCJr�:b~���=����I[��`3�.���Q�X�m��9�TTt�(�Y��t��_�Þ�Lx@ �O�i�����tF�H�IFѥ��:C{�t�����{�&_]�VUSe�i�V�0iI�֑n���^�3�0��*��.�/h�U4P]�Dj^N�3f.�Zಛ�OI��<�S���d�����,}(]����sԊ���I�]�>EQ���57���f
KӘ�Tq���h�����b��x_$�4�kid�,ª9#:�uѤ����s�l6��.IÔ���sB��ـ�U����u�ܟ�w>8�7p���gϲ�}j�)�O&[�����\0F�3N#����&ȡ��s�+�a%AZ���J[D�ٗ=�f5��W!��bk��)��+�Vd���Y\"��=D)F�������U�/\'�2\'�2�� �syi�4U��!Og��}\"�{�笋6��U�9�O�U�Pz�S��A\0+�o�;U�\0K;H.��X�K*���τr�2n����d��2��XF���Ȫ�ŭ��\0��%�(7�r�Y�m��Z�FN)Q\'�ey�}`v�A1��(�_�K�uk�?��s��<̳JJz�C���6��;6#D�4A4��!	�g�VM���ExN+�i��eI��T^hԢ��Kn�6*H7ܝ�W������xW,��ik���|��ZQfU1�{ڵLnE�M�r�q�^	���3JJ��)Ψ�+	���E,�XKi{8��ek�e�/�_(��x�2~&���E����1�\'�#W��E��0��0�\\�U-e������X�6���X�@=!mi�e�t�g	��S4A�ƀ6����Z�-���3��L|i�7m3S�����Z��A�v1�gՆ.���U&�\"����Z�\0�of������g��r��Ѹub�opà����>�HАUC�\'�N^�o����)զ�b]CK8���-��,6;o�\\��s��R���}�FQ�cq{�y�q~~C����*����Z�(���ck���ߦ�6�
H�������G��ݘ�os��܂,�9@�\0���U3T�������6�E�ѫ�7)\"�{���\\���EK�e�*%�ip6\0}�o���I#r�IC�E2R4P��貼e�o�2꽶�0Q�V�\"��B+���u���7������#N�=���7OI6z6a����F�4��Z��2\\ˠC�\0�[F6{铗L5��~x�0��	Moi_F4��6�Ro��e��XZ�y���ka��zxݚUTPK16\0x�������n\"ᣑ����TS�\'gS��3/��¹C�6[R��h�1e�tS�R�\0{�>X�8��Gg�4q��4�6�.�I��c��\0dg��J[�Ԡ�=�=%�q>O�f.��h��vƝ�������w���&a�-L���Z���:|����S��\"��맫l�-�%�Y�̑����C�pM��q}O�|ȫ?SB��4��-��Qq�������E5��r\'Z��T����7j�I�p��觩�Q,t�����@��+����E.�|�(�l��Fsm��7$��2�|�%B�8���B�*�T#�*���M�򴵓��x�1��HJ�W���P�Jm��\"	����Z�Mχ�:4�~6O���v�Ӎdh�(�q��s�����~g��.b}k-��.�e
�b��־����
:Ib����&��*;ZM��\0���s��X�S�1�I��깤,I�w�է���|�b�����m��l��	�QzR��ZJɡ!�i�`y}�����(�xÆjd����C0R~v���1�e�IM)�^͊�P��ʺ�e�q��*䢅=v�����L��DY����h��W�T:\\?8�©n�~S۔u��F��H�;��>�bWk��gq]$�ͩ����B\0ط;nF���#��/q�i��0%v*z��o��00��H����^z�^ņ؃S���b�i����T���V\"$�v��z߯>W�AC鷉��V��,��duf����ϖ�^&���nW�5�ܒ[�O���/نr�\0NtQW��o�`�xV�>X���8Z��Yu+A& �x�ߧN����������
��e����\0î+#�.�Ujl�0XiQ��\"�n$��e[i��)*�9�����J�2�_a���Z�}�#�,a�D�v�ĸ�n5.\"��țbu,p�6�A�8\'#����\0�1٤���0٣n���p�C\'��aBw�������݅+*��
4rj~XRS�Y{�
׉��/�-@�0�E����o��YZ9R���¨�-��r����\\P������X��U[��K�\"؇]��K<�c���ᆦ�0�1A�\"�L�9��$��k!^�k�a�5$jP�v{�O�eq��Z>�i2�:A���Y��֥YkR����u�3�ř�tЬ�c�{zʍz��\0�6�`-��x�����*�sL�/͘*TVB@�A�*�C��ʡ���ߠ�������A2\\�<uC�4*F]*L�+�ʫ�����[��\0%n
�i���2��2�&�|�&�:Yk����^��,k{[�l�ТsWG<%�=@�$���u܃с>|��<�W�f˨rI�酅[]PʺI!u�\0���\\6�[^��-������6�y�9�Sy��M8>�,���*�[3,H6f-.��s�^ǉ�s*xkj*!6D�#1F���\"�}jN����Z�qM<�\0�F\0!ȑH��mb<��X��ւ���U#h��Ak!`=�#ng�����L�?�+*K�9~eK$�%@�-s@�
�\\˫a��x��f��}%UNs>G-2T�R�%Ljѣ*ڴ�,,A���gTg�MK-uT9mm\\�M�RPK_\"C��Z4`��_��d=2����-���`�ͳ�ʲ����D�@�S�%V;���K.ʆ�v�M�!����[d\\GW�^�+�r�~��Q�L����m���k����:�͓5��|�҂�X��h��ƈ����n�_m�L5�y^i]��Qem�eyȓ�0PʬѢ�>Ö��_�,.������2ܞ�(s)��Q[OH��Fɪ�`�V�ɰ\0��Q��J��`��C�Uv4�M(%�F�����|�۞ᾆXG�Y%\'v>����\0w�A-b���Ŵ�rVPL�HU����l#��*E�����o��{��W�r5K,�أ�����%�q��/9:X�j�-��^�*����I��v���e*6#pN�Qm�w��yAOIMQ� 4��S��d`���wI#E���$�|e^����xeg�`�s(�ĖC���;:����i+�(zz��v��U`��`:X	�s�C��a��EO)G[��k���G�,��U1��j��ےX�&�4�\0݀�Lǉ��%e�8\"�^�*����K(�N1is��IH�\\�f�y�]w��s�u�2�3JL��L2���\'Yʋ���/V��\0:����\'�@���l�ji���mrD���K\"-k�o��=��i�p���y�&_	�{g��+͏��ɹ���\'��jz:�ˣ�5�Ӗ�R���2{�{�xϫs����*�g��On�iL�7����lh8�yE��BPv�z?�?H�Ex�_+,�5�����C��8�8Ǐ��\'��^����q=�*���6?޹��Fa3Vvkfn^�YK��e�z�kV�E{\\�|S��v�V��BҦ��Y%t�(����Gҿ!�t9MUE�fȾ-����j2���cU4l�R��\"���r�?�3)}b���Ԡh�M�j��^xZPg&�P%�.-�r��s:ȡ_�-�Ù�b)�/�Xɕ��M���=��q��Z%�*��:z�kgގ�8�l��;S���1��Ryu�^�Ӣ\\􇄪�+efL�ї�G���i����C�C�`ik���5N�M�Tfm���T�d׎X�-��M���{�_�\\S�͚P��e*R-��01lv�\\5:u�`t�1U����gO6K��i �\0ņX��Q�h�f6�8�s���/�,ڬ��h�\0�>{X�v§������f̣��ߖ4�H�fA�*�=%}=�.̪b�0�G�F,鸃����q>ga�I��ɮ0���a�(Q���E���6\'Ǘ�١���*��2*��j%P��\'fߖ�>��z�\"z�g/q��c�$��4\"̕��x��x�V����Sj.Y��h��tq�����AS]S �3�R0�S������om�{���7s7���\0mM�	<,t��D�p�p��vaJ׾�\\�^v��ᇟ�~{��s�
bTqU/���SN����I��~B�����͗�FY/�����~�%��U���Aԥc�1�8����c�}WLC����dҩ}]�f;{�DL��L�)���&�o�{��csiyX_�K�y���?P�qK��~�W�3��E~�WGQ;���aٛ����|a+������4D���fV�)��,5=}<�/��s��.�����9�4lՙp���QJ�� ��;�a�^��0��\'��hw@7��p�WP!jz���E�YJ�|�:��YT�!Q�=VN�(�z��OdҔU7����V�#��\"�jƖ��2§o|dxbgR��qQ*�n��_��397���*�9���9��7^��)����I_�g��Z�҃���J����R-�d�+���^Q�C�gTJ��idco�����վ0�SK�\0X�*���ӛ�vO�<|Mԃ#�X�����`�����ϩ�+��q\\P���1��C���?���%����s�e��;���k�$o�1�CM�˫��3(�o=R[ry�����%e߬(^�_��/�CE2��������W����%�P��z�7����I�.�w��Ï)l4�s�SYw��6<�K�m�I\\T�0ນW�KG:J=�P�����мO۵�q����ؚb6	2�3ZJL�
쳈r�KiQS��f;�����c����f�d!e*J�q��㍴�Ө.�y��Ԧ}pD�%�o����bR���Q�[ؒ-����O�e���C5u4uN���+0��#��q����#�ٙ_I\0\"�Wߩ�s�\\A0{7�hG�*�#\0�F������F׶2?HiM]�l�c\\���B�`��l�(![Y*E�ݶ<ɇ�	,C-�+}k�j���2˱�\0���.,7���qW�W6e�����1T$ݨ��3v����a{\\��5X��_K��i9vo�VdYeDU�@{x�3
��x�I�H���_H����Q��|UmONeI�V�L���(�I��6�˗3�>}YOg��Z#�i�SD\"�*�\"�up4�,��bm��C<M��ME��;-E-3E
M܎�(`�Z��*�ԍ�Qi�a�t��_�u��qfi�
,�!�A��᤺G�(}���s.����3Y����-�3K��T��)&��1,�6���V���_M��R6A�S����,���U\\:��.�Q��H��X2`��(�U�}L�96nGP,I{۝�N�򭧏����6���#����GAN�i�b��RN���A�)$��}�C���Eh����9�H�l����1*�;�����1A��IJr|�%�5rΒS�c~�>�#b�6�����Ӡ�rj�3)��!d!�g�+���j��Ӷ�k���z�]%��f5���\\�Ƭ�5#�ڦV@M�V��P�i ��;i$ތ�3ʾ<���4��4�T��z�w@��/ ���ao��[�GQYTvҨ�	�ZQ��C�G\'6� 7-q�e��U�]D�݁$
Cr]\'U������`%�&
�Q�=�J	��G3�K�E�m�u<����y�I=����Ҭ��\'a��XcPi�3���t=)�!�Tpw���/{x�e��e�C�M��q�i0���t	-�[b�n����V�v�F!^�u�ϣ�k!���Ji�A.�	`��v$�܀�u�9�S嬳�J%��\0{�H���-;�Q��H�dh���J����˗B9lg�J���KJҐ�K}
�k[s��B�ʪ��� 7P!FWV�UO+��$���4�c���k��<�cA�Y��OAd¡�o���},n
�ڈ$��q�I�3����$�{��eUVAqqu����y_�T��u��i�Q�H�I��,6���Ќ:�\0l_�(��x{��d�@2�+�$�L�=PJK0��d����I���co��#ͩ\"��-����IN�xǗ�_I�?C��Fk��g�M,mF��CYAH�z\\8<�$|:�T~���Eg���CE
�Vu�3�X�v���`��7�{4�\"�qT��]��Ut\\qU������U�!�l��ob�hc~��mݓ1�;��z�ߞ8�i*xޖ�K�̌H�ɱ;t��\\H��.#c����Te��H#�)��I�Mt�i�Ѭ,`�����Z��K��\'�/�,.Dc� z3��/�?]K�qT��	��-=#����\0�7���_�8��m��u��6�Ϥ��|��\0���\0p��фm�<��T_���s���8��;���?��]<����D���5�\0gm�;ˌ���!2�b�mWSf\'�Ж��li�D���G*�\"����\\e�\0� �vy?�m^�Qk�\0f<s�]����ű^���XW,��X��������<��3	!&f��Jw�-����Õ,q͔mvmW7��x������\0Y9�t���\0���r�I�*d��De4�7���bGNgߎT��
���>��2�|<�H�Eh�`ې-��,K������P�-k�`�o���fB]g������,7+��mǎ	 �j��#��iR ������R�mq���������y���<�wC�v0�t��,�B���~|ɽ�[4�����%S@�;�^���\0��c֪1-�c���J�2G����e�<�orG�<]p��)�J�]^�� �rN*�]��S��;�j�߅��
g�R H��_��D��1<��M��3�x��9�����S�)�Ω�\"]K�6����6�a���1=��цt*�d�AR`��?��|^�\0g4�7�K.[+Ɣ����o{tƱ��UMA��7>�Yq�y���o��r�ʑ�Bv(@\0^�#\0ML8v���Uv�xٸ%-��M��-:+|��&W�SC,�=e4Q]�&a4j��p1qSA�S�2n�3Z9I�UW��H6��G�|q�	�����ɗIم�ԛ�@Ϟ�DXJ̃��s2�2��3��MU\"M�VE�F�,/�*�ƨ��\"~�F��i=?pȬ���mIQ��O��z?�.,r�@?�0�v�Ն�n쭤�ٟ�#˒_n��Ǫ&����\\���a��n�f�-�,��~]~8��P��ǹfy��
\\�?[WuF�Б��������ZUhJʪ�~�;�ø�y�E���z���8�$����A\0X`�^a�R�:M!�=�0�_rnZ�~�s�51Q���$M�����/6��&�:�Pӷ��}��X�D{�;=�<��(�n�*�r~��Ӽ�A�B��v�������U��9�p��)�EW��0�7U�� �����H�TVUS���$p�3G=b�*��U$YjD��j ��k��i�j�Qo���Y��3ӕ�EP�d�]M�f�p��+*`�[�\0VVG�r���V�7c.�҅nQ���D��Z����p�K<`}� lֽ������H���V��6��3�l��\'q��54ڬ��U²��\"�~�j��x��6���4��E�z�ģJ�N��<�:�a5M�gi�p�OÜG$\\KGM��=H,*#I&�����¬*���o`{ֹvT����,�a�va*�!G�x���}v����;
��yp���:�J�Ξ�<�˗U��3on�E:f�\\�a��\0J�?]�+[��	���1�A$��AA�I�νV�.�F��k	A���<�J��9*2���$�a��S�Wh�����b,��	�\'q�Lt�R�fcA]ԕ�̓S��.WIe.4��*7R���ņW��nS��͔�iSL�Q8�O +޽���D[lR�Z��O�œP��q,�ҿgQC;�������M�[rI��)���W[0Ϊ�8��4�?��vcQR���!ii�yfv�bem^�e6�3�44��<ymoOA&^Z����p�*���>�ڷ�����*�3Y��z��y�.l}�*ma����D��l�.���;e����(�
�6[)6 bI�Z��j�h!E�j��j���e��jy���:��i��R�RJ��jRM�H$��q~I����J��$�)йԤ1���5�l.��)��6c�y-e},�6AM#v3�����!�E��؍]���8��0ͪ��c�zZ�U�cf\\��j���K[k��U�^[͏��2�ƕdV�$s��,J,�`{�WW05]n\0؜����4��\\S*����J�Ycʐ#H��F�(\"��a|`U��L������,�ݿ�눭T���$Q�J6[���0���kOZQT�QY���7�K�uT�`I��&���<�a�+i�<�W���i��/�H�B�_n^�0}�9\00�X��I_r3��D̷I�\"�;j���q�(h�Fg��t����RP�!P�H��1s�����b*9-��^�m$;AN?��0��hYj�dT��,�j$��	�����c��(�u(f=�ssc�#�^V�n�[�<E%6w5{傮�׼����.��zt�*��{��oP��{��s�c��Ņı��SP҄�����\0_s�m���Ft�,����\0���L�GO�_�V,���c�92i�r�\"f�$��h�B6���ܬA�p�頄�kG5<߲�]*Q�{\0��q/gU���$����?��`�,�jc�HZF$�����܍�Xrŵ\'�
��P �����8^l��Z�?��\0�N\\/r��o�>#��S���h���4`Yk� n9�$�d4�I[���+�6c|8��
�F�\'i�������l�2��/�L޳5�\\ΚJ�^�&- ��\0y�ن8o/��)��H��9���}���n_�T��4����#cp\0��S��2̲|��P6��iEe���Z�7,,A����QAn��V�\"B���ȸ&�>�\\�\0���\'��8�E`Τ��W�����b�sz<��)xj���45[�i�^�X�(�Pz��+=!fy�ET�4��]Ja��D���r�\0\0����kOOYWMU����[Tr��6=��!E��o��˫���O�t��(�ǟ>v�y~o�х�.�k��U:�VXA�1!��<�b/��^i���jsH�F���� \0��]V[�s����iZ7�HxA���V�\"�}�țr��_����5e�Z�Rji���������Xy��|a��Mϟ?��l�%DC&WL� �b.�A\'�˝������WB�L�#0�!�lXٍ�N��^8�d:{AP������@n-k���duL��$F��7�\\���-�X��UB|O��KQ;�������Y�0(�\0^H����n|�����NL#W��0�J����Ͼ�a��bL|W��L������-�F��tț^�F�)x���H�+b�d��+�T�[���b{ֿK��T��	�D�~�\"%d�]�B�����w_���ӵj@�6��p������q���2:��d�#�$��&�1!6}�H7����s|�e:ki��=�|�����$k�q#݉ͫ{^W�з����p��8��3$E�ʶro���7������s!��.W:Ѹ\'������`O��|6���(�(u8J��T:����T��xta���U<�F�SX?gh�\0�[���w�ꃩ��O�����r��MR�����x��o����4�.qC1YbӉ�GQ���5�����Ɇ����n��;�d��%`��:--eu��#��t�ˋq�Pb[L�&Ң�:��kM�O9#��ŉ��[�V��#9�_��9k�����T��H#����������YM��?��`4.=�p-U��}i>�2m<���\0��5Ǒ8K��p�KO��е8c�$jb���A$۟��Q��\\N;�Re.��ap��\0���1��y��*ߤ��>ǝ��\0H�PY�\\�ﾙ|�M���s����!c+p��ԉʏ�m��Ōm(\'_��M�c��˘}\'T �mT�\\���<X���
�6Y]r 2������/L���}
���&���G_TSҰZ�F]2��ʏA|!&93H;��a����\"����&�O���6��\'��\0��l^�8Η����m/��n��q�0��Ʋ�����ї.�)ڞ6�h�`e�D�+�}׷���3�u���R�D�M�<��v�ߖ7��,p+��0���i?�|�%C�+�����H�Wx���Fۏ�F�U>�r��<uO@(�x�)�=�)� �7���lw?vk?E�K4�>S�d�$��;�t����\"���G���x�f�gĹf��T*����M�r{A�7��?��F��4�{��p���%E-]<Ց��l�\'M���nw��}� �2�� ��h��2ӳ��#G*lU�>�;�D�-L�_��G���xs��d2�$�,ҚJ9�Χ��:5H�\0n1�=ݍ���i(��P�@���G��jɥy�K%2#&�ob���\0yyn!�\'���i�M��w7�}�6��c��E|]_N��,�u�Ԥ0��1\0w�(��u)��l=�Rd9>h�����W�/T� ��R�N�6=pYE�H��\'���J=RӴ�ۅG��fK�\0X�^�|�+%��mP�c�fs-co+�Caaq�n�f�= ��\"�Q�C6�sb/�k���J\\�4��c�(����ĻH��V��cx��*��Y^WN旐�rH�Oo<���\0Y,�2�@ac���\0<J���O(�$���\0$x����lRȌIB�yr���y���6��l-�L�L��B�,�0ci!��<���M��h�z�0���L������ov�c5IU��r�Bmח���T�/�ACQHT���B@\0���X��?��|�Z����xS0��4�P2{#k\\�:�φ=\'����MU��L�������6��G<f�o�TE��3KN��Lu6#����.�M�e�Y��)}e��\"��\'�ɿ�����ᰃ/��`y��~o�Ə�?��1�˫���&�s2E��i�\0\'V����+�� �3�Y�\0P�fKK��K[��N؍ElUb#���=��0��L�k�!�>���Qw`�U��l;OH�8�čD���8��/�n�J��ܢ�/KFD]�����kx�>���@�KY7
�b�t�oX�c7`H��ߑ�R��R�IH�ēK�I\"�a{�ن�C,�j���7��l��e��%9�L�+Y��*�\'�p�o���O�.���3��-�P�����VP4��Ð��>���f�P�@�T�ғդ?�ş�d��*��1ľ�j�o����ѥ,A;IdU]F��Č�$�\\�*���֤�HG{�v�m�8�I�ZS�S���Vd��t��	���\0ӈ�Y��2Cn�قǦ\'�$��#�)*�:�����}����X�3�\\;�U�i���@����`Nؤ�&��ڡ�d�?��=j����N�p�X\\�)��̫dsEQ���b���rǣ=�G\'	�2?��\\�˗���=g�ķm_4�|U�6�53�u#i�����SA�s1U-�����ס�T��4���<���ᬮ?�F���a�7��U�\\?g)�u�*��I�^�	�\0Z����c��)�Չ���0��*���ď#��A(\0*t؍�RA-~G
���i��\\�ZcF�0��s�O?���9�>5Yk�#��v�c��Ͻ�#�𹪪��㙣��lB��M����v�H��������C��:LG��/|W!Y��
�oک?Ƹ�b��ݪ���\"�<�+SZ����čq˼�E����n|9�Ɠ��c2���T�0nD��4Gya۴c����M9�����.�^�2V6�����#sϙ����C�5�5Q��H擱3\0�(���܁�+)!��a�� �Y\\�-H��٭L�;3�+��Zm~Z��+�<y�q\'��\\H�ܹ\'Z�+o���	��49��R���!ue7FRO^���e�UI%1��UczI�u����U����Y������Rf�.���ݛG�걹��1�;C!�vb�������[�,Ue\"nلl���R���XA�Q4�H�
\0`-?<3�\"�Fyјg*���~ѯ���~}/̍��}�,m�Ib���������ж鏊� ;���Ǌ3�021m�\0@�^�/owĄ�. [ZÝ�
/u~�����5�U>o40�\"�{Ѐ6��a�r��*H�kG �Z��U���!m��+<s��&Jt,ov��|��_g-��z@�V�JUv܆#py�V����s�|��J�MS�<��mmD��D�V�p@�Ӌ8ei)�;_Hy��L�7u��@w�b��{�V�q�A�1-O �e��7�����X�?R��*�+V�ZȘ�����\'+_���i�˻8��k���t�վQ���V�;\\�4�}\"Ȭ�-};X�9���a�7�16I4�%<�.;ō�~{/�&���#,Z��n��\0���V\"34q�9�a��,cu��~��c,}Vp��͹��˦֖ޓ����J0��\\x�}�N�,�(���
�IL�M��*ms��ş�c<��lc�\05?��+�4Rc0����zN����.7�������y�?�$bX�T���\'{��\0P��y]<���֝;p�
�0�{ۦ.xc��ϲ�β	#C@��O~፯�{=pF����1����8jF
ҋ��э�s>��1WQ���},�`�����V�zDk�\0����叏�7?W���a�PlI��;��K�)�-B,9�\0*D��� ǅ�\0$bVOÕ2���FE��ܒnH\"���g�6���G���\0���yc��<;	��X?G�;Ě�s�\"��������fm6.ꑅ\0�rI�����oX���]a��ff5 �ϭ��ˆ䥥5&H�l��s���\'�.GC\\�p)�Vx��5�qyj+�`��X�ɐ�m���~�,K,���	$Z�b*���h���6��Q~crM��T$uI%nj�������}[|�p8o(��?S�:T�=��{�ab��5�-c��~��J�������s/����8e�c2݀V:���m��l7G駂�V+*sH�����������[�����HN�\\@ӧO�O�/�\0|���Ƨ�8[�p���_�<��Xq�M�Y~WG��$����U��0>��7>�%�{��OF\\+�TV/�CO,u(Q�R��@������f��9g�?�����̯�����~� G���5T�\0�>9�H�P�>*�m�dy`*gI�`�HW\0�V������D�H�?��oQ�U)*�)�m%�q^�����s�g�It���i�����k��˱��\0y1CI���MϘZ�r�ı� ���68���c����?�ԵUL�8��C�8���M����5Ћ�Wx��\0�Q�\0�3յ^B�9��)��9��@�ݠ��ۦ�\'�2�ʨ�֍���uiP���m7�_��.�^k��)�$��g7�Х������\0%��Gڸo�\"���h�Xb�UD9�s�������,���Z9���3^ċ��P؉��k�c\"�
��߶��N_<c��,�[^�\0mF���c^�a��M������c��������>̬̣{�	��P��Ru�ەN
e��X�a�4[I��\0�7�8�������N����s�ӎ�n\'>���ՕG,i=j}Im���Ǧ)���#�p3f5���3;_`H��u����5;�������!�s@�zWB�����5�	�SWVӦ�+*aV$�IYG�,L�:��\'NiZ�7�v�x�S���m���s%���RN+j�,�����É�g
��2�]�m1�h=��ؖ�}�qFi_O-[Z��ikԱ6����*g���U<��@�r�@�8M�9b�%���\0GsM.`D�H�<6ā���ƭ�SH���Q?�˾��A��Ѻ�1{~�_yƯ�PF����\\�r��1���i��N����������ߟ�������W���?�.t_�i������t�|9�|wN�q ���~�����	[�����\0LTo��[cB�3��3/z���i�\0����|K���+O���-�0Tk6��1�
�.��/����S�r��\0^W��a$��*a��b����cm���y�3Uz��G(O���^�he����l.S��rwv�{�����B��������?�\0�#�\0R����\\@�2,�\'�aC�*�IYR�dv;*��������X�d&�!Tnw����7��7ؘ�#M����br�_�mTڅ֩�����X2�Lʼ1�&����fLg49�<U5�����=�X��\'����ԋM�<_Tǻ*1�e��A���ҡ�O���/��ݧ���XM����~\'����\'��Q���7>x�y�aa�b;�K)��r���MG��/��	,w��>~$�UYUT�k��C���)�,^O�?��tԿ~
*��p:R��0Y��]F�H��\"���8��(x?��ÿJ��!�Q����ze3��Ѥ�T��,P�l5)f\0,�����8������������?�T}�̨ea} �8�g[o9�2��2����c�c{��5�+�<0��6���H���f�_�+�ߋ:��H�)�\'~bܽ�D\\G�@��P�h��`��7�y�F�Z1I_=V_%<�
��m����+s��T��~_;E�$n� X���8�saW�3&��!����w�÷�1>�
t���d��Rt�-����}�g\"��8�(�ˍo��4�R) a��6�x�+Һ�8������m��]��j�9���+zwX���|�e���m2?�deܷ�r�cܻ^L�L�\02�����*��R�s��-���li�*xg;lʦ�X�촱�8�~=�*E�:w����8��޽X�n���5��搬�3��:�HM�>xA�5���S]@��(������|����\'-�k.�M�N�s۞,��Zv?KC2e�}���%Bؘ��Ŵ���\0�\"�\0��\0{
{�\0y�wGY�$��F�ۇ]�>D���?�$Qj��� W��%�e�򨚿�)���~�˖1�J��)̬A��o��/�Ս�@�v�p7���ߥK,��]?N���lp��T��ggG.����ZZ�r����t>�?�����ZM�������({G1�ɽ�����]/9�M͠{\\���1�c��������l%�}(��+m���>V�걷!����y�DU*�>)�x���X@#�M�=YVhȷ=�
�9��EI#�p�.NY�I!M�;�8��U�9�S�0H�=ح�\"�1we2:�y��ʤ{�8Q�3F�R��[;�:U_܍���ͩ}n�\0م���Ac��)3��v@������V�\'!��.ȜF�c������~\0�~�g����Ҧ�FR��ƕ�IJ͔�S�ZyvA����c�\\�\0�M{�\'R��\0L�����J���닥_Pe��K#4�5&�ûo��\\0�C �Ө�嵦\'�2�O�%�K\0{�W��v��=��c��F>�	ܘ���ΒI3Z�#��6*	V
��i\'>�89��A,�1�\0Ɣ�<|*A�\0���� �BL	u���S�\0�剙Ubf0�%Dh���u#��nuT������%�\'#0�f��)���$�bs�ib�[����Vo��am����G$�����@�1I\0�Yc�I:��d]��\"���|roaF�}�%6�\0}ͦy,�F���>�?����B*L��_u+��II����Gq�M��T�O�fZ�#u��7�L�)�]\\�/��F�q��-D���K����Qё��m��������}I\'/�n�4?�+*�B��ܟ8�]Wj\0?��\0�f�%�;���^8ml
Ђ�rLW��Z��_m��������/����V�Y��������Tt�[k��)֥M�fDɝ�rH��x�;H���Ϯ�ݣ����W��_�J
�#����.�A�|�����$ ���0�y>��$��s�Ik-���d��Tu�6ih�� �����ʣ\0�\0�q�s��!P݌\\G1���-��.m���Q�L�$��أ`mf�������2|��(t��3�X�h�/�vjL�U�h��M��v,�	�#We��2Y�J�<�\0�0eA!�KZ�P���~�V	Dd�1���Mel/�e�T�6��s�*�eh-}�(_��0M�>���@D��I~`�O㈓Rv���k]���+Z̥�Y_���D��O+71�����d�1Te1e������ͼ���g�
���,P=�%6R�٩���MJ�*��V��=M�E����}DR�9ha#쇞&�T�
���XQ���0j���o�>Qg�塩�X�N�̩��lҟ�Rjؔ��R2��ǫ+2z�F�֙\0�Q�Q�%�犧����{|Ψi;�t�o�L$�����/�g�\"���Q�a��h���C��J�c,�# �7-��cq��uK+k�3��g,=�GM?���Q[��GE��3j��f7U@�-���|~p��Xl/
֙,�e@����*��Ʋ��uἹ��0õ�Q����X}����9��?[C_3wdd�Koc���<��y�
R�s�����y���`�;���[an�R���uG����G\0��s�?��J/.x!��c6\"�|��c�Vir�)�Av�o��$�eutR}]T�6��9���\\��	ĩ���ծF�����*S�&���!�ϗ�3�$�(k��3�5�ڢ�Imm�bz�<q���^(��2�,$�/�W�nN��bKzS�n�瞤�a�:
T�������*3�:�?����:*���3��S��O������-�eR��h&?t�3oH�y)=�֨ҡ@uBm�e���S�Ǥ!U��s9бmQ����*m��a����>1>���()�W��O
UKo��aO�;>6+�r.�}�j3�򣻘f̎��Na1��a���{��PfU@�3*�ָ&um�_�y[㷞 f=L�e%���\"[��|#��4�����b�Pp�on��|�\0�1K.O�v���K��I_W^_�~8�yT�V���H%	[���\\X��l\'��F�:�����Ѥt�Q��u(<�_L6���#��U�N>�H�$h�f�\0q�+���k,�	��$�k�m�<@�Æ�&�l�-����_����Ⴎv�|?������G�~�K^�B���|���)㩐��Xbn�X��8�0pׇ)�\"�;��?v��*�R���������\0	�����mo}�>�B��W��^�\'����b�ު����� �c�4�c�rI�r�>�\0��*�x\';H�L���mI�(\"��ӓ�s��(`t��i��\\wuxs�O�bA�|����� [����/p<��8p<kE#����?�:����?��u�|#��Y.r��3T�_����,���C-��L���\0�4��_%F$�}�+���߽�)�d�v9A�˱R	+��ce>���>�+��\'���@��c3P��<L:H�?l�������{<������66���~9�4*�m$�H����;�J4�K��Z�O-8Լ+z��<k�\0��?�1C�w�e�
@��%�D��������C�1?~6W͸t+�B���E�CO���pަ�9`c}-i�����±^��jG�F?o�dK�q1?���h��^�rH�r�Q��[��eR�/�o��Q����-�yr/��	RAV�l���X����<aF���?i���7���\"���<t�\'Lm���<�X���8��VT;�\0�쇗Q����d�д�v:e�����ޭ���vڕ�f��~2�Q�W-ڷ�8b��VH5�}�o~��_fUݦU�HK���OO���=M�k��|/���\0L�7s��\\ms�/������D��07��$jG����(t��f����F�\'k)%f��@�s:�?����]�������
����j�m�.�I-H*>�sc�\\F�:8����?厼4�Zx�&�f��\'e�tsP�i���%���Ar���s`�iZ�H�Щ�\'����G�?�����C��0�
	ҧ�Aa<7�Dl�,�Z$�*��G�$�ǻ�#o�7��7��0:E���@�6Q�,����&S�V�3	x/�-�a��r��޺�0����I\"��\'̜J���1�\"�Q~m~�l@\0B�	,b$��H��2�ֈ\0>�B����r��xC��ؒ%��{u���D�-܊�5?x���h|��\0�~�������g��b��V�wߩ#�lz�T!1q��\0��\0*(��{ݒ8�}�y���lgZ�\\�I���]<*[n�kz^�C4�k���Q��M{l�9���n�JY$������lm���iX�6`C*\'��9yya��62k4
>9�fxb���en`�V�c6\"ZYN�ʤr����F[4\0�-RF@iP���8�p�jJ�%Xفշ�����-�y�A3a�2:C���ָ�c��\'\0�攑��2���a��<�����#�dM����D�h[��FMZ^�����JԠݼ-�\0�J��y�B�fK�d2��iJbz�bq�\\�H�\'.}�J#�������I�e���F����ty
�F�<�bw:HaˡT��-D�>&U�����Y�`�N�Lgǘ6�1Rxo����V�^u��IIè��L��l�a��Ch�x��|�1�؎����4)6���\0�e\\����gY�q�բXٍ���f��L0���q$g}ɷw��ƒih�8z(�;�<{|���2�J�L�)\'ە���I����\0��fw
,�n��i����z�B��u��K4�|z���#���坤�0)}J����\0I��*�lڙАB���{x}�Kaj(�� Co�ի!ݵHJ�G-����HDw���|��\0��x䫢�D��[��������fSi*�5 
F�����ϔ˼����m��������?-�>�J�4�ֱ����U�7�\0	�*b�ctc)k�?�{Zß3��!1�J�Z.n��y|�m�Ō�r:���3ˠ��yc>��������|��r֠���Ƒkk�5����[�|���!j&�Fǘ�����a���M�J���p6߯_��c�t��P��0�*�\0�����Ly�j�ME\"���`�>\'��ct�+��rj$�������?���f�]D��f���S����
Lʖ)�^\"�����ݍ���˹��en�o�;|���S�V-��X�{����7�ǧ\\Vg�MQL�v%K�_�S����e�Ց5���6�<o���)8�0�1�`�ֿjEω#Ǘ�Ƥ�\0ֿ��ό�p������������4/r9�� �{��~a�Y��i*ͬ��m���8���ْR�����|7�����z���}��NǓ#��[o��+XZQ��=��K.g�c$�O#�6�����]��B�0]A�1m.W��?���D�^�(\"����YuC]����|hJ������/(%�V���Br�5�c�YN,V3y]z�Z��S�9�=В�o���G^�4ccɎ4%te��CQd���ڹP�ك�����Y.����1���Y���\\����;	��ts<�
	�5S����V�������,�ܐ0F8V�äJ��b\0�p������=w�V�3$k`@b����\'`��$��W�]S�;��u��xNJ}5N��I�m�ӟ+�|%+!���|�*��8눑C!��G��ۋ̉�38\"�J��I_e�)\'�-�b���Zv��!�¾�eU�\\�_}�lVg��Z�,s$`ݡ;���Gێ3b*2�Q�PG�z����?%�S��AQ�0��x#0Ḓ��.���:�=�C�>���-KQ
 .�Q77����C�1��p�a��>��r��3�J/%4ʤ���á\0x����v	9U>�(	??�a�,W���a��OA��������� �������p�-v�S�����d�&����$y�qp��{�\\�~���Ҝj�#C �e���$~%Վܷ،?�,5�)<�s��u\\=Q�	�\"���/�� �*�ep�H�lL��Ҥiۤv!N����N%�SCvMYL�a�\0,F��N������=�7�l�c������lp���=G+�0����m�\0���c���x�%py��J��\0�H�k^&������dj�m��,6�Va#^:YJ�������<w���L��M;�f�`<|o�,��(�)�%����[�n��˧�1e9��b��u�څ�����-�P��ST�F�{��ど�.��cK�=�I<������]V�Jz�I�è�ğ�����%?��1氟���R�����<\0�2�ȭ�������=v�8:��U|�iҙM�UX�_��3�[��6�GV�w���G���y�.Dr���U��%��I{E$�GV����bPI���F��K��O��JT��=!T���XX�l�.����,�v�X�znA$n/�����Z�k��7���N�0�2��ijd���M�������\0��W�Y���~}��:ޢe�;kf[[���o�,��b5�֎�I���̐>x�O�,�H����9�fd��̨bv̚���/-�ȴ��GH��q����ZuԃV�#����#�vp��Q,�6Qv!����~��cE���2�@|���iQ��6>�@�\0�p̙fW��f�:��
򷅼�+���dec�2z�[V��%�s�q}�=�Ѩ��(��W�A\"�X��_���TZ�/��ed\'b|`���4�gx�&��Wp\0��a�����r���61�j����G
S��sS����v����l����J�QPʂ�o���A��=��Y9M�����.?�(?[մ��U�ʹ~����~���=�b�;f��_�W��N��a~���\"�U�Ӿ�|�Fl;�L�}�����-v? %d�h)U�U��#������}�=�ۘ��$������dY|oo�qe|mPm$�m:�wmǾ������[�_Ӡ\'��Z��Jt���i_��L�%Ͳ�ށ�@�b��#p|��W%UO� B��_�����$l�*���mG�t�bX[���E��U1�$��O�@8Ca�������d�4��Yف��/L,UG<h;ß|��y�}���1��z?ባ�U4�X�uo�q�<�h)Zy)s�G����]�	ӳnN��@&�\"zAYc�R
�k��<���\0/>}0���E�m#k�|�.^�t��D�C�ر������m��J�Ƚ�eO�,>
o�x�2�����+���^����|w�&���}Ł;���߆bePY,6];���:����� \0o��|�- �5���_M��ձ��ak\\��H��������A\"�PlyI�:�����#�Gp�@-kZ����Y5�kY�49��硷���\'��`���2s�:����N�n���l�~xm�V+v����æ������;�&ۘ���1.<��w�S��������;���\0��������]�&�*@醭z���@oh4*n$��H�������a㙣;9[�7�����ap�nH�n>X�-�?q`N�uۙƄ�Ws�j-��%3a�ᕯr�+��u3�Yr֊hݵ+�M\\��bw�.7�z��q��V^�p�_����J\\�t�Hd[nH�O!��+�[��8Gm\"3����%��������pX�O�CESK�Fe�-�\"�o�7?,K�=Fr�P4b����aR�ds��P�/�el|���Ⓘ����f�8��MK��G�yrZL֟0�i=n\'Ԧ\0r9<}��k7Ӊ	���F�J�?�)��\"�hn7$��>d���)��bsҜ�XbW�J�yu�Jꂣ�ZY�U�&xia�q�PH��q��!�iX+��.�c�ߊ�s�k�R^f����lG�8p>�������l?32�M�,�W=�R�īZ����#��iQ\\�|�o�$�Lα���1��Ykd,�4���Pp�_�jҦ�!TT\\#T�Y,>�\0>�1�0ᜰ�-:܍C����$[���D�4�(o�c���\\������DR���by��Q��$�?d�j�\\�y9��@~�V���Kٲ�#�n��������1�\0e�U�J9��5Gp�ǽ�Ʒ��d���g��B��}��jԙUyr�f�H؃~�����|!M�*j�*$\'A`�\0t����0����M<q{�\0}��fy�_%$��P�^`M�R��c��l�,�z=��z���X�WH�k�~~Lm�b�%�薮��A$K]�_Qk��*�TQ�ċ����`\0��᜿�䊮��t��(�#�־�\0��ױ��`�-(�i�� �#R���7����qd٦]��NՕ���U�$ݶ\0o��2�ڦa$��.��\'I ر;�a��D�M$
�3�5���Bܮw����\0i_��Mj4����\0����s��3���5HÑ��\"�n{\\�يU�VEY�W��aq�����z��R�d%n�������\0~��<���m:��!��[����7Ӡ��	ũ]�1c�^řF�)���P�{��~|�����(�X�;���3�-�{�mkr��-%TA�8�w!������|F8�ϥfvVV\'H�W-���H����Y�G��3��,H�N��{�r�)�Z�d�E��P ~��w<@��]��T�p.�Ǧ�Ͽ��H~�J�2���A�d�[Rm2����\"I��A
2��]v,m�y�\0��bZ��
�%�^�׺�\0��#Þ��@���i�*��M�%\0{�E���;ve�]0V s:�M<����dz<�4�j�@c�\\XH��m��x9�=��aK�R��֑M�M�[��H�Mp,�Xo���,3;v�E.���ֱ\0�{���K��X6f��Y��
*�K���;a�x�-�X�Nܭp\07���[��=P�M~ЫnN��y��Jʳ��*�ݡI�$��	��q�a�^��^�I.�ݚt|j�1HrƖ@���o��x�3�MR�)r����iN�-}́����8ꎨ�5q<[���?���<��͞�0om�4��������5$�gXdV�)#nE]�X��C�q,�z��\0{),����o<&~)��=��^�<|1~5�[h�FU,����<����Z�{KhxQv���y�%��c�-����w\"�3UT܉k�y\0-��o�M�O�S�uMs�(�[�ˈ���t� ���_�]me�������&,}���A��\0?M�:�o���aR��ꌾ�DT�+k|�>S�u.��_�*��x;6�h���:����o4g�)[��d�Ї4��i����k�f�]6#���u��mK���>Y�v��C�%E��7�-����6bI�� \0����JN�zd����N�9�酶�Ot	9�6�e��Z�@�q{oc}�u��Iݧ�&��������Ջ=+HnI-+~�ur|�C[-��nt\\�����*u\"W<L�+DcW~��V���\0/�5}:7r%�\0w�o��6i�9l�ƚ�Jbm�c�v�����c��Eww�h�Z0��H8�S���ũx��U�����G�m��W3�B�cak�<m��\0��k&�<zi������H���گ���u�Ҋ�bm!c�Gp�/l���=y~F��$����PGx�x��<�ѽ=e:�FFؐ)՗�F#%�w��}v�ZH�{���j���-���6���<j-LH7PA؂68�8Req[��.�����\0T���X
�=�]M�-{�&�23��u \\��>�>��!�-C�q\'�}؟Cę�,��ٴ��XY���݂,��r��>���`ia���������2$Z���$���o�#<������!RǼsơG\"�Y��w���U-Bi�R@9j�����[z��7�L▟�&:^ۯjO�Ŕ\\9Q#�0�w}�6��g�Iv��jv6����?n(������L�Z��{���XP�r����|�I��aU���g<�P\0�����RH<$R�u�,�1�v��`��.,G�bt\\Q\"�e�\'�+�a����[J�Ple�P�SPAnWI$���a�\0.us�+�8W�j	�O59=b��\0�|}e�$�Ǹ~�vUP;����j���U�U>���/깬��	cW��������߫���g���#��`Jv����	�T~욾8��v�1�m�fw]�k�6��폣���ժYB\\�~v\0�����ؓ�3bM��q�~�2��`������ヒj�-\"�{2��e ����F�� U�	]���*nI�ߕ��V΍.������lH����	7��>W�NVih*#��!XT5��\0�����%�f�e�)��ץ\\��w��B��6�k��>�*	$�Y��&���!��=\0��@քU�$����{�e*7�v߯��F�(�j��;�A ���p~��ⱄ��fR��\'b@�84��$����H��IAPYt��僿i#�Wk���-������H$UR]���|p޶g��)���s��C+4S�e��,I��i(6�r�ѰV��i$�P�y�~�o���-�7,O������;�m4��f�y�\\\0I��=�}�xW��}���,T�j���p^ڍ~fK�K\'i����/uAE�8�,��j���,�@���s��\0<�e��J�U�-��#ko�-C���X��/��i�]��^�r1`���@��k�~7�M+�\'StCaq�l:m�qTI�n�$̑~v��p��@7߯�>��d�Y3	nt��]+1��T����xl<��Dj��5��6����3&�$Q}�6��\\a�P�q�nw;�XS*�>�Y�ED��H����Fy�\0���1�i�7�ttb�X�����#o��go�O�XZ����pye^p�e��E]��)U��¡�:���w��u����z���1�ȱ����H���~{c�����!������X�G�X��@�_z�T=�鶫�3jHΞ���\0���^�T�J����?~gi�Z1�=����-o�x�tr�j��*K0�܁���m	
Q��.�����g�GU:�c��6=Ґ��-�kX�2��I;�5�K�N�x��b[a������]�c�@�Bo�&��Tp��u
yy��T�C�H˪M�%�]��[��xp�d��=2�܍D���ۡ����:�S��1T�>�C1�s��&}_P�ZUBx؟����蜯\"�3\0�!V+���T|)J-��V
�o����d8�A��+��:�n���y{���YTv���ݼG�#���Z[W�=�j��>�N��%6��c��Xᕎ�x�8����f[���v��ĺX7�ف;����1���/��Ά��@\'��Ѭq��D���-����/��Y-F����n<m��4���-6\"�xb\\T�QvUQ$�z:�ح�+�)��|��x����}��F�J:^�8}�����޾���V�~�������g�IK��e#���kR��礶Ϩh3X�H��M�Y�o����Z����B�X�%��-n��|���2��.�\0�͞�΍��������:釩�k��.��g�g���`�f6���5iJ��\'���\0,f�ּt�{6P�޹S���ᇌ��Ix��1�k=3`c������ij?�t�z�����猷��+��?�x�˳��[��L��o#�却���MG�6��I���&R>�b�2��9�Ԓ�Lw�_����Yx��P_`����\'\0�X��?�	�a���EGem^E]�T����9��H� ������/T�������c�u5u��)(�d���,6�>�������(n��
��C�b�����x�u]�u�-q��i]T��Sk_n}zc��#*��T���l��ƌMĆ�������1T*���W�So�E��!6�S���o��\0�_G�+���TOSE4�L�Ve<gSēF���v�J\\߼��,0�a��4y}me%]U<RO=�fDԱ)!T��~�Q��^��2�l�<��E]�l)��&V@wk}�k���^�8w�r�M|M��,�j��L�)%���Y$�YK�f���#PA��	xS��2�\0E�C�e��s�����EV�J�lS�g��`0p�9�:��^��iᬚe�Wbf�O��$���,�� �8���*)M]U�F�KȎSv*l	������o�C0�� ��٥<���wUSLV�zd���-r4��GN�o�gԬ{L�9�\'��{KD�K+��1]�9%@s`KbZVAy��䠚�(%�������	齇��}6�WP�`}���kc�u����^��\\�-��!����T�� �s��/}�Ƃ�onc����߈83�d�j��:8T5M���^V%n�|	��D�b��b���9�_���E�_�S$�5\0HRH鹽��kS>����ul>�\\��IO~i�b�F��?��@�Y~��7r���Mߥ��\0������ٻη �����*ƨ�HTw���7\'Ǧ��%��U�1�nc����x/�����l\'�=cV�A��a��
L���f�w��~�=�4z
���rĝȷ=�醑�j�I��Ͻ���xd��K-��WI���\08�ؘ�e�P9�m�¦��}At���x�����r+#Q�_n�;o����i#���/y�I6�>!��d:�%�#WC~g�x���@	b����);6�K_�k\"�\0\\�~%��>�k !B��_k�c��@��EΠ�H���4U�;�ӝ��Ut�n3sa���\0}� �U�:t�	�v��_|5S�
	U�h<��n
�,����K߯,J��2�f��؁ޱ��f
���T45p����W_#}�$��\'� ��i(�9��:`G�L��ڡv��_��o�\0?,AI��x�H��`zo�־���LhRr�.��3N�M�s��������1\"�@�b\0����/�UJH�TJnA��Ꮏ�
}�~A��ʦ�l �S��� ��\0�x�TVc�7+��鎵�����{�>����9���W%:�3|ʑE��!�_6��f�����YW��iA��,o�#�|�ۿQN�o���;`N\'vO��N��	$�)A�����RqE=�G�/����S�g&�WF��T�8r>[�%v���y�q�[�-�%�DG[��l�0-�N�b,�I%�A~��ۉ��f�QPva�l>z.����̝<6��V-�?yb�1�PI�5&�g7RT���|C�{�[-�0RA�yy�xw\'�z����gc��J�yp�P����
�n�OHQ����52���6,;�m}�~Cw��;�~xҖ��6&:8W�cWe�⿦���i=#�3�zz�!:Z�l���|y�:	5�XB�G��cK�M���!fyup�h�%��;���Ϯ)�n��H���@he�}6�c�[o��>K޽��G/�Ůe����$������w_����mfWkp@���{�zf�#��|t�X�����D�M!��&�­m�[�#�[��y����V��%U������|0�\\�`mZY+e\"\"�U�Z�l9Z��|WT�Dы����<p��tTkX[����,ɪ�����~�4)�,ۤD�Q@�H�~c�ߏ�l\0e%HTَ��ߝ��k+\0��q�����RI�����×����ͺ�fi&����R�WX�7�p�=�7�F;#�����M�a��녴ZU7�c{���4�~2ov0cR4��t��?~=��<O�p��G��QR�燲��7��D�sU=�+�JH �G���Q�;�JFO;l	��o+������qļI��VO�zܓ��g�$pD�4��_Ձa��-��1zŌ�\0�d�(x֟�!��3��rt\'(�-K�x�k��Pl�X�¼�K���P�e���rhjsjU��Va4U%�	m����:��<PP�ne��e����M\'D��<3�jV��&�v+웋�l1KY5}B�\'[{M���P�j��0T�����jnI:�\"�
�X�q�f�G��|9�eS�f���I6�2թ��ɤ�c��,M�zQ���r\\抏\"�֫�LYm(�&���P�n�1�6�-�-�����������^X)�o1���d��Xa˖$��Wd��Ŭpq�ge��;�r솢J,ʟ2�b�	\")�F1NlW�$��#H��y�7��KY�R?-C��dR� ˩�%*���vT�����I���3�����W/̳�˧�_m#P��SOO4���n1\0�[��k����� ��ir��yl�#A)b@6���z*�ͩ=\'p�%FK[
ɤ�VM=�
*�!R5n��M��b^WY��O�5�������?\\U**���kr��`muhEs����� vX/��[�%�4����h]� N��Ǘ�`_��ucu��6�����݀�]�0aB�,���j\"ǯ��;<�4j4Ⱥ�W@�<F�\0�Ú��U�h�_Ik[�����he�!�AM\'��k�χ���E�$�#ߩ��j��*۲������\"-7����#U�[�s?��5�5R��z�6��l?#��D��w���sk����`)��\02�IEGI�H��#!K��7�m��a/N��j(\0z��by�ai5@��3n�M�S���M����P��JĠi ~<�<��Ҭey�3�@%�nI屽�C��XOg�V�t�as�^�>x��l��g�+�UǙ>����.�$,�3)Ҥ���翏+����f�W_cf~����v�a���HN׹6?�݉tѴ�	Vw�������>�����s&�bʍ���[݋KE4�7*�n��~za������;�7>\\�ه+�ٵ�-kۯ?-�޻�3FlK�������y-JhVE��;�`���;O�̀&�]V���8q\'{k���/ce��ya4��凌�Õ�\0��LU��w��V�Q�%\\۝�1����L�Q�i$�\'k�9�lT^�=Z��?go�ӫkmL۸�l9�Ԫ56� X�Z5Y#��H�8qi��M�`/�3���iH�\"��N�����^ �0�٨-�-���c����o��Zu�����/�s�	��P�xA<�$���$.���r�.N+�i����&0��8bK_M����H��e���ሒ���\0K+�H�b7���
rz1��;�
p�D�����3g�0-,lT�-��;�FiX��ƉbC��<�<����a�x~�S�ɨ��c�m�U
O�\'��t��v�bIAmƟ݇}ji�C��\'���x��%�:��:m���<2��)�C������Y׽,�b�1�c���˯]ƫ���>xY��CR��_����gqԽ�~|��tC�B���ܯs�?/�+�:�T*W~�ʝ�/��GT�ar�t�/�F��7��qI���Wi-w>�R����� 5!)ep76����a����(�{�a{�|C��a@�O��V�� ｻ��u��}Jy�VE�:N��{����@ӭKK����E�����6�T]rF�nͧk|1���-���!G&���qa���L�v+��������0��TTBT���U\0\'�Þm�H/fR�r?#[���c�i`�[�����\"m��$�*+�-˼y}�lk.����WNX]�F���~|��b�G�����}�\06�Z�{��k[���:e��I*wp�\0�c�E=��?���=���t��ʂm�������ǖ�CO_WC�\'�V�Kw��ֽ����i��f�*?��<7����<���]�f�lޙ��Q\"�kQL�!�������W��Szb��r�LƢ�B����;��X�m��猾ed�ܽɰ�Éu��$�:�;�x�~2����L�f�D��N���M����..�@��\0�N2�&���5L�!�RF��z$xَ���H��Yn�޵�����N�Z�QOu�}��+I��i�駋�xڶiV�c3-���������wm�3��N��;#�ـ,4���}�������v��.A=ml3$�\"](���^�ؑ�iY���g3f9�Ud�EED�+��Y��1�!��#-Gh@t\'�x����~�54����d���\0{�݅�완jp����\0v Y\"�j��WR����ͷ#�m���$+.���	mB�|:[��L5���I���Z� ;����`�ۡ���H^IME<2 h�ݘL/��?f>c1�#�E�5������|��k\\�J��\'�(ۑ�B�6�>X�_Ib�ƽ�>���wV��v�[~d�eW���4_Ov���[݄ �B�N����/����؛:�W7��X�䧖=\'�P�feK\0�E�B��^��{�I�~����;�8n�Z��0�ϼ>�0(��ff���|�\'I/h�e�@J�E��=���_�l���Y+u���{����K�9�>\0�0���\0C�hn��\0<\\�LIx���ڳ\"{7ac��#I3F��4�ߖ�\0-�!��ϧj�����0���qem����8�@ƙ���6�X�bl.E�Ȧ%��\"��9�o��F:��/tIr?�L���=���7犽�1Qű_h�nM��˯���M�Ki�7�{������ܓ�.X�>�\'���VR}�6��C:�Rɑ@���#q�|0���J�ݰ���y��L1,��y���?y���#F�����uM���m%�FeK(e؆����叅bH�٤�m�M�~��ɲ����&]C���^[�y}\"�hW�1�_���%{L�B!,��-�c���ؐ��UC�UV����r�q��x#GH-� ��m|ᇫ}���;L�5�r����\\�^��{��\0,v�/���_Tw�酆�!�o`uXQ&��c��V��F�g���ȇN_PMjTX�X_��NA�ve�Oh����nW>#�ƅ!;�*I؛჆��`�C@V��@- �N��X����e6g�T��s�~o����l��!é�s�	��J��p�ma�������i���%tE�=1��q��!�2���!��:J�?x=���0{��1�\0�>���cR�WP��\0/����{o�7���z���yK��ꖥ�o�-������2�}qH�}g?�-�|�lOF����y\\2l�M� >�o�*�^:���:�6<�����~�㨷\\Sᩰ��%��w��R�d{�DV�$X�A���XF�u1%����+��L�/���ӥ͍�lF\0��ᕡF:K0�l>�r���-k�Hل~��uUI-�6�����y�G��p/�������:r������o|g���','1','test','2014-07-17 14:38:13');
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('2','0','admin','d033e22ae348aeb5660fc2140aec35850c4da997','1234','Super','Administrador','Default','gbg933@gmail.com','099394334','����\0JFIF\0\0`\0`\0\0��\0:Exif\0\0MM\0*\0\0\0\0Q\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0\0\0\0\0��\0C\0		



	��\0C��\0,\"\0��\0\0\0\0\0\0\0\0\0\0\0	
��\0�\0\0\0}\0!1AQa\"q2���#B��R��$3br�	
%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������\0\0\0\0\0\0\0\0	
��\0�\0\0w\0!1AQaq\"2�B����	#3R�br�
$4�%�&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������\0\0\0?\0�$$��3�5�����m�C\'�tW��_rj��~&��!d��/!k��BHb��C�aؓ�&�����޺#�����<;����ߎ�w�h�Ty�J��Y�[�2���.x�x�7�hB�V�Z^��u��0�\07��ш��Ȭ?ُA����M[�6�q����YYE��M�0����ǵ}e��6Q��v���޹�Rx�Z�|���+�K�Ռ�e�E:��Ӗ��x�}�m�B#�V�(�*����{����Ho�k��{�>��Xڼq�Mq~7�Z�T�����zxiڧ/��c��>y�������v�J���q��}/�\0��\0mK�~9��Z�z��-E�4�*e���8I�l����\0h%�<og��=�ٛ^���ŤZ�d���$Ǣ�9������oK���
�[�:]�Ce��6(UG��X�Nk�_�$�������?n�o\"�p�3*��E���;���-L�H��
�y[�U$��s_�߶���j�\0j�S���u�CJ��Y���Z��k�\\#m�Q��ݻ�v�Ҿ��\0��������\0��]ƃ-�����E��=�lK\\���ּ_�	[����ɚ�x��-f5��yH˴�(b��\0�ߨ5���q��\0������\0��\0�ڧ�/�>	�o<�ff�S�F$�r�|��י���\0���S�3�;�k�\'����}{�Y�HR��L\'�m�����-�q_���;�Id��v8a��=���7�\0ɛ�_��|l�s�����ńa���P:���Jε>jR�ٗ�T����O�=�	hD�w,�0�Fiۼ���k��3�����\\�a��ZF�G��l\0W�9��������:����9F��IU��I��i���.6��%p�v�f��O��xNm�%��\0���G��:��+|(Ώ�f�Y����EVS؏ƈل~_�z��49��������M���\0:�W�u�-��K���\0:�����\'#�j���.���Z�\0��m�A֮b�/ͻ5j`Eeh�q¼�J}I\'�v����8
���������g-���X�[�cğ��]7�*�×��ď�~4�4������BU�8ds�QwIP�$�����k��j�R���q4\"9.�uh��C\0s���n��;Z����o. ў_9�c��^����Z���	:p��?$�L���ҕ�uo��q�y�\0��z_�5]CA�������F<A��$������c�^�(������[�>2����|)�ux���[NX�b@>\\��2I �k��\0��?�B?~������E����u{m4�ڨ���T>�����@��>��웪|#�C���y������$�3�z�u�k�7������㦉��������F�E�b\0��}�+�w��	�`���f�#�ϋ��xy��#?2/����W���Ρ��S��>+�o��߷�5h�`$����]#l�k��\0�����|H�Ic�����[����N� ;�-���x�����,6*5��<��-�;W���V����ψ�ho|B�u5�<���GT��W8�Âs��W��y�c�����0�G�H���|���)۷�����5��R�_4b|t ��E\'��↥�_��x[�I%������>���߁��W��)���ZƦ���?�#,F_N���CܔV�G��e�x�����<q������|� ���VQ����|/�\0_\0��9�SBԼ7�[��ݤ%���1��\0��_e$�6��K�~.���mM?�Z5������H�\0�~���e5!z�Ir���g.��M*�9��5�$y��n��\'��;?X���h�}2�wz�����^k��h�ե�n$f`{�^O�_����K���
�<Y�}eWN��̖��L8��G�ר�>\"x���Z��s�\\xn�;_8��)=�x�|UIc~�������\0��f��9UWh�8�����>��I�u-�X�����#��U�\0�����R[�çj6��N�������uKK]�$_:\0�����y�׌��2.�j�zs�}�uc8o��_�����cM�TM���$+�\0t���?�kY?�]r�}�lfo��k����5����_��s���w�������Ƭ��$VY�_����NT�i���?����c_�i�D��5��ڿ�y���H��g&��d�3��?A_��yg�=& �������r��z���\0���\0�;�>�~,𽣝F2\\Y�孏vQ���\\��+�}_��a��3�xfW�/bI���W�YFqW-�������z�~G�p�?�md�{E�G������?a&VO�r��=k����[XS��H����c�?��Cu��bHn!;�Ԋ��i�i�e��b���t�j??��#	A�o�������c(���S�z4���mʿ�G\0\\~�?�U�x�W�.4_�zI����;��B���T��hou��i�h����g	=��W����U��\0b�#��	��ǌ�!x�������m�,l̼�2�On��|N���I~�?�g��#�/�^ ��Ǻ�@�>� ����26��fU^2��/3����jcZn7wom6I�չl&���$��nUk�wu��1�tj�P/�w��<?u�ெR7�5�-Kmu{��nXp�r���T�.�K�[Țݤ]�W�|��|#�8x:�G�Ƌc��
�f� ��II�<��>>^-׋��m>Llz��ϥ,���x��Uճ*$�p^)\0��:��_��\0�Z�i���\0�t�hd��/cѢ��>U�˸�($�.�?c����͏��fV\'�5���\0-��7����,U�����U�y9��%����
5?��^�4��4�$��23����	�*�����p�u�\0�?��-���xV�\0��j2.�@�b���Lt���0��ʷ�s�,�O�[mմ-.��e�]ߟ_ּ�^I���Z͟Y�q�c�J~�+K>��|�sO�-Ѵ�KOԭYw��el~G5kQ�mJ��TX��Rz��ڿ������f��/<�&M7P�y�1#��G����!���V�>5Kh�s흠׃_�joNW^g�a|E�6�����ߏ�}qH��^s{���l���7��Wex$q�6+[���A�ȶ~��!�ZI]����p>�_ݳ^�����|����\0�cݼqq���
����Z�~h��\'¼7U�/�%�̭\'��1ю���ϽO�R���x~?ħ\'�&����)i$��e��._�	�#ɹv���՗���I��o%��cj��\0=&U�������F|M����K]Ѹd��3��
��խ�	Yu���x����7,!v~�O��|7-���x�A+P�����w8����\"�\0���e^Z��I�+���+�
��J�[G�Ɨi7NNg�zt�}3���%��D?�,�-m����s�\0~�שxk�c������=��<k�|����6�����+�q�?�b�o��~F��j����KC����<�0U�r�W������þ����|Y�j��ޕ���[+Pܫ1}ǡ�Uo|#Ѽy����O��ͽ���=�q]��������>5^~Ϟ9�η�v����e��0{����k��>NR���G�/���Wɇ팀U\0D?���jx���^,��;���>I|�kN)>�#�N����u޻M��?�Q���\0�O������|\'���<ko>\\�3���u���_^���x��1\\���n�nX�,n�~`׷�ӿ����S�׼�h�֭^ܾ��>��ο�\'��5O��\\�?g�W��\0	�ù�iNH��҉�̨�����@,x/�m�,��>��>�qv���T���i���&�V��>\\xg������c�u�>8�Uo�:�2>��ҿ�?�K���M�{������2��p�;�zF�m��p���խ�$�8dpy+���fS����S�4����%Z���=:��\0�G������\'��=���vmcZ�-�,�#24��_�w>Տ���6��ឥ�]b@���
E�杏
�{�����?k���^3��R��-�[�Xb^�Ϲ�K9�c��e��Ӫ<~�Z���J�����;�ۗ�����f�e�\\YxGO�B����j�	����?����>�;i�O����)P\\�}ٯ�0����}��\0���������躆����+�ѻ���b�;)��7�Wr����;?���,�xKF0�����8�֯��
�K���پǡ�wWq�>����n]�oB2:S�y���_�t���uA���h��vJ�&�e�=�MWk��b�9?Ҏ����rw>�
~�&~����Z����$@��|�K�!4�x��P𦬺D���90�C�G�~���t�^O�����z��n���6�%�/�W��<n	���*7���C�˳��-��ϕɤ��w�3�������*]k^���-�M�{g o�;� �y�+��;�~����?�|CԵ-z;�?a��������_x��TԼk�]kK2�S\\;�����NNk��\0�%7��[����;w�t;o2�^,��9�_�p�*�L�a�R��n��^�W��o`�a�9b�0�jh�4�ml�]���]���3���i%�t�;%;���)\'�~���F/�_�o�|J��Ϣ�3�MLvO�^K̬���G�_�{�?�zƵ!��v�QOw��$W��\0�7�m���`_
&�������A��dY�>`��\0�:}k�x�\0
0����o��k-�����_[���b�.Uʛ�����4>���8�:[���P�bI���<{�ՍC1������a]�ǟ�\0�ť��ZQ�q�����>�X�XϫM|���{�Z����\'��>!����|A�実bc�=3#a��~xk^o����$�sI�߲��nd��>�k�����F7����V�c���T��H�\0���|�\0�k�ᗄE���h�Ƿ�DF_~���=���Kwཷk�E����u��x9d/n�[7;?���M:=\'K�� �!@�j�������}w���)J�-�U��X�F7yL�ԃ^��#����?�c�iY3���B�0of�JA�~fݎ�5�&�0�o�}�/����<�w\\�5�ƽ/�:�濕\'�\\��?��P���cm��M5���{g�z!��I�\0S��M�f�m�>«�����z=֩>Č������i^��M�4�ϰ�H��<[c��c�|{����qR\'��{�(���h�(���q^�I�#�.�l�E�y���/�GG��de��c���1_Cl�����_��{H������>��\0�M�Ct�ۃ�E�ҷ��t�Y�[��Xܨ�F�~ld	���K��k����x�]��>4��{�p�3FW�]&G���9i�U�rk���8��<3�a|��a��וּ�B��e�P��X� �\0��8Rk�?�/g����l�\0���;qg�+�L��YjP�Ii���ɏ������7�=W�ָ�\0�፯���-��k%����h��?y\0~;�J��<%�\0#�\0�F�Fԣk;h�(�V�g|Iip�ı����8a�g���K��~:�@�G�����>�F�u/v�¶�c�+пf�}C������>	�m�|����ŭ̖�&���/X� �}��_�?�Y�z���m�\"x����O\\���d�O�������E���:z�)$~c||�\0�v��^3�!�_I���6j���+�ʼ�C���A��Vki�*��c�[�mK�u^��0@5���|=�^���w\'��/t����k��$�?�:��M.���އ��i�l�n79�Al%zu�.N�r���jx�N-���-�r�~z~�O���\'7�O�Gq�ȵ�؏�D	o9����>|$�~
xJA�k{+~s�ZF=K漻�wǯ��%���\0�� ��������3ܣ�9�o��\0���0��_���p�Ŧ^K�6?뜠6+|���q���I�\0���q0J�䗢k���G����ܹ�7<v�@,m�W�x�\0�_��#Z�$�+�ǉ4����K&��EQ��/+��9���&�-�u�T��T�K��9U,2@�{�q���4����;)�˝
^�I5{hﭾG�(;E)4��K_Sc�)j0��UwF�Y�h�B�}���5��G���T.���
Q�gǟ��\0����\0����D�*���O�\\�\0�E��ן�\0�;?g]k�h�o�4�[���Fl���xԶ�^W���V�m��|����+����x�A�����iE�������8j�Ō��f���j��M�S�%�be�JVJ��mRO��<��/�\'�H�+�Gj�2��W]GT��V�g����s=���,�n������*�\0���O�!\'�H�3~�?~3ܨ��á<\'�I�r���-��H�}��C���kC��aX	e#Ӱ�ɸ�2��:�����[��<���$�BjҒ旬��}yq?�<H��^\\c�?�W��v��\"��;H��?)\0rO�\"��.��e���v�[�=+G������\0f�ja�n. ��N7<��.��W�f~9�Q�4I�N~�V�P��i�]̚��9(�$ǻ�a��;�>�ڏ�$��s�T�ϩ��s��\0��x��̏P�6���Ȅ��[\'���Ko�Y�`�R�1��s\0�^��L����z�ܟ�����3O���Y�Gmo5�7M�O�]���g�_R�-�]>6��f��{h;;{���YՏ���t�;�Q��[�;v�l׷h�F�q�_��q������I�,�Ku������%�.]�����\0�C>��?cdF͉?*�u��A�mݝ�,?��־�b��FPH�$1�U���uH�����1�2�4�&����S�P�]���>�ƽ�_������n�#��G5����r�t��X��llqU#)y}�9R�Ɨ5gV�o�	v�[M/d;:�dQ�\0�u6a��J�ޒbT{�>񖊺m�F˘n#=�C�	c�J�؇���\0�o�\\y>��+���;[�̶�G��z����1dU�������/�W�(�O.��I$~\"��z��4\\I���ϡG�R@D�Z�w���Y\0(qV��\\0��k�O�\"���g�r~�N�4��\0	���Q���N��Q���}+�}��J�?�K�f�������C�n�׭�:�������U���J��~�\0����w�VX<a�\\h�,���D��:����=k�n���G�<[FQ����_y5�쐰�}*��޻y����Z��^�[h�����v{S���4o�1k	�T�T�C:��[�;xG�
f��ޓ,�A,!$OpÐ}���O�m�����Oz�g󭘯̄~��L=��Q�a�,e�Sv>��z���_z-ƽ��^�����L�fi�x��/��_��̾nn��B���)����o��5f�̞.����#�$gq��]O�)y���c�l�y�5�y\\�<t��j/6~��ڮS
��I_�F��ݩq����-J�;�y#�	�<n�*�FA�����W[�ԧ(I�j�h�Ѧ�1����$��vo`������n����(�u�9��\0T���\\!���4���k��ma�k�?|5����\0��|#�Y�>���u�YT���$��Q�\0�\'<�}W.�zz;Yz���¹\\s<Ζ���^�������EO٢oً�	��\'P�����\0nj$�3�>��ێ���B��Z�m��ە\\��E{��um�?M�#���*%@���+�g��ܙ?�V?�~վ��OT���X����E�K��5�������?�83��o��ö�9��3F��\\LDQqꡘ�藄-#� ����t�=>]�_�ߵn�}�w��J��G�iw�kWl�1�譓��?����<��^_x7K�UW�0�H�������$�ӟ�)��}�0M,�R���[\'ڶ|�1�oJ+��ڄ��\'��}+���j��Zt0���nȀaPp1B���uc��?�\\�����8I2���A��t]9������+���vz��m4(Zk��{xe�g
������^����Ě��y�L�\0�x�Z��t��O�iQS���;�I�|�=kNѬ��V+[h E�\\c���\0Y�Zͮu+�[T�q*��f�?�����<�iio�����7L���+��C�[���6��]_LOޚB�W�⸣({��׆~���)ƦiZ4c�k\'�}��<m�sxG�M2i�M�L�n��?�?*�_��\'�<a$��V�jA����?�^+.N0۽9#i�X�Y�BTX�\0����Qr��]���s�n��\0{V���u��K����Z�F���Kj�|A�7�s����z����)�<4�[C�ۯr��l}z��ڟ�_�߱���v��\0	%�W�`�4�ܲ~�޾�q]��#
�<�ާ�K�SR�%��N$�n��\\��s�uxǩrjCD��\0%���\'�n���(��Y�����Fw,�C޿/<�ڮ��^���G�>̇ú���6V)�[Щ���BH�UW^G��^��\',���W���s������ywvq�dm��7�W�ث��\'I$��]��w[���R��c�Y�\0T�_�M�>4��ԭ��&C��˚�G��������ko�.�1�mu�;@O�W��Ͱ��}���}�e-�jQ_j:���x���g��K�I�䀿,�}��#��!�x?Qk}J���a�&B��ƿH,���/2)X�d:0`=*���\'�vf-J���_�%�0\"��[3�F�7��,~mNVH]NH��9��f����e�6��t��\0֯П�����.��GV�n����cr;m�_#�C��<Uaw%�q�P���8t�S�5\\�h���:�)�ƿ����\0�P�8��$~)J � O�gvml�}��c�_�ǆ��|K�]AYZ;�ċ���W���k|���\0�F��qm���5\"�U�>x�#\"�T�������\0�/��$߬i�-II�+��W�)c�9��a�\"���.6�R�k�C�G�r�B�l�낧����;����A�Ԭ�Y��R�	�:0��ԟiv>?�<I�B8�R�x��ZG*�\'��ҿ?c=Z�����\0�_u��5/�:����y��.|�>�T����|dc]���ƙl��㊆����>�G>^F*K{�ʫ������;���j����9+�n�_sMk����א����@��)ǥ6Ѽ�.M�u}�T���X6~����>�*l��]�WG�rӌ^�??�\0గښ����ם�����\0�8�LB�\0:��\0��������9_��1��[�\"��t��2�h�}�mT����?h��4S�ۋ���5��I��G�
�䰊�v}� x�����X�!g��1�{#|�~׬g����$�&�^�wA����3^��x�bx{:�T���i����e~%�(�XJq���_�4�MdYw��Z:T:��X�4�g��]oT�R��9��>?��v�w5����fk����E&���Y�\"j�ſ�F�ko��X�<*�����q���)��_!�v�&��Dx��_���o���{2�Dv�����;k�K����/�7��
�v�k��6qYZ�ݎ5
����x���p�>��oo����*�\\���·y��{�<�,��p?^[��\'�sŶ6㼠��W�~�7~]�������\0��>�G�3j�/9�G�k��S����>~�\"�9<��E��;�����w�i�����H�:�鴂L`�m�B	�o��?�?��F�g����a&�8���q�=y�3�����|)�t��B�lpxc�����\\�5Øc��Wj���/�8�*Q�*��m^�z}�ܺ���jy���\\۝�mn�s�ߐ+������}�]]��t�{������3���m�@<ن�Z*3���|�?�]�>��?��/��˨F�2ڮ����K����O�5��յ�A��޹*�AڲQv���Qޥ	��F�;W�*����?l��(�b�����-�w��t����FM/x�����ٔ���k�o�&����\0����f���G�ˮ�xHኜƟR����wm�s�:��t�\0�^~͇�W��g�^�#ּQ�Q���ȍ��3��\0�����^���j~G�W,���*r�J��=�\0��K�6?l+4��,l�Uky-6N�I�1����\0�3�t�\0�.�Zc��q!���<m���}k�S���U����ξ�\0��|\"�\0���>$��7Z+l��9x�\0�\'��p�t}�Wk�?�<&⇗f�\0W��
�|��ό�O:m�\0���#ᧅ�zo.�6���o��q��$��|�>>��&���Co�\0V0H�k�EIB\\��ۘ
0�I�����TG1a7ͻ��+W�q�꠳G�ɜ����A��(�t�������.V���⧂�$�F�/\'��^-�db�F.��E{����+V��\\Cg��	�x7zy��Sgq�^*T~5WT��uX�\\B�/A�J���&��e�����nܱxx�>�Y���?
m_��UcҼIm�f��%Ђq�g���\0dkbh�[;��6��_����f���|�t�Q��P}�_����/���X����O�[��hI��������Z՗��;�>���ʫ?Iko�����>�|_C�i����+�N+���\'�O��)׊������^��L%�}\'����\0��/��Y�Inё��ޭ�J@�\\���\0��U�y�|T�&�k7���1��C�˚kl��\":���z��6a���9~��y�gyT�֨>U����a�������?�m��?�/��﹈���z���\0���꟱����[V���b.��mV�ps�#���8��,?m���]�I�ִX�l�3󤊂X���c�4�����\0�V�$����6��u��B\0�a�[���u�<z����t�����է��J�ѫ?3��V�#Ь�V�k}
O�\0e�a��Ҿt�\0�d�T����3�麓2k����Ց�uh؏�~~�[���/z�_�U(��,���|��ؙR}����>��V�K��b�4���*�=k�5Z�Δ]Kz��\0�U�_~Ǟ#��tMz$�*�\0����5޶?gMt��XK�B����1^���o�����I��5��=��L�����߲w�i�g�QЯ��C{,�{#?����ºX��[J?�?V�(�����/�\\���5�V��z�/���}\'�k�Q&F~诏>j�i:�Ԑ��-A��޴��j�*%��̹�c�~Y��7���\0�6_�+���ڶm8Q���Ak������ȸ��|i��So�H��5�qw5�0y�ob�*L��Td�V��P�����̧U:qZ3��\0�cxi~&�R-�fi���.�H�V[���_�����k�c��o�H|A���ۢ��\\M�|��9���_�Z֯��Mw/)n��>�!�3�z_�?��?�L�A�Z+�z�y����%񮟧��̣i�-��K�����=�2�1=��/��2x��W������ħ�?�֯~�?c�[�3�:�8Cgh����׊}+v?ಿ��o��Z-�Ҳ�Z��U��M�� ���A�>�}���;}+��Ψ<�F���$>�X����[���»��}�I��Hs�Z�~\"�9U�G�w�<;9c��Z�w�KDkg-�������8\\c���Ze֠��$�ҾM��Ҋ���b�Kַ�~�]��¾��֕���n��O]�ң���A3���SG�=zv�]����m�B��j�7~�N�}�\\}�diFq�e(���=��������h}Kug��d���4�� W�-��:}����k�1*F�t\0c�+��$���~|>&�!���?�QYp�[����*�͹p��W�;��9���ώ\\e���J�7���>�yz���X�<Y���ݿ�*�xn��z-�uI�-�`�^��Yx�M�\0�s��ˬ�j�o_�^�-՟]��hU�I���淪�g���n��G�gG���M&O.=É�R?�$W@8����c�R�����A����/�G��|��|�p��{W�Y��Ĵ�^����C;�)b��%�/\'?��SsN^My�ۅ#�Q��O8�WV�-5�v]F���9����E8�,���;} �na���׷��Wљ�&��+�c|?Ҿ��4���-��P�A+�k��}/e��̛Z6*3ڽ>!��G���iW�/h�}A�\0�~Ӓx&��uۆfЧ7G��Y�Č�Iǰ���bB?�����?�2*Cko��\0�W�Þ>�zY�\0z	��\0�B�4�\"|;Կd���Zȱ�򭾾�\'�|X]6Ce8��W��\0�7�[������Cis@��q�\0�\'O�e��]��H�b/\'�����[?�~&�ҡ�סK���ߡ�o�w����_�V�cJ�͟��\0��hi�\0G��,?�G�J��[W��,e���;[8#����U�&�����ni�ؓ��\'�>�G�	\"ya_�d����A_�?����\0j�G�ǂ�d_�Z2k��Ƀ,`Hϳ75�nx�9}I��CU�?3͸^y�iB8u�|����[��\0��o����v��T���At�!��+���I�\0�ӧ^�����C����/���<\'�B�{8�r�\',��Ha��ҟ�G�Xh߀��#�}�hD7���t�_#܌�w���6n2Vi��c����<9R/��I|�y������O����]n5	N���&��_��>���񾭧H�[�]�	Q�E~�.�/���fi��\0�_�4b�����W�������ڷ��{~_�9$_`�5ŞEd�ͯ���Jі*t�J*_��OП�����ʏ�&��{��p�1Y3\\O[=.��M����:�ais���\"�9C��_����=��NL��TWX�3)�ފt��N4������i~&�����D�k?�>6�>�u�O�E��Xpx�$1�ݾf��Z��	-�oFSɯ�+�*J��}�\\IF8���{۵��ܟ�l��&��\0�k���i<G~Y���Z�����B�!��]:�?_	��v�a�\0�t�n���ķ�N:���ߞ+��п�-q�9�������{>��O�){4��+zt(x^(�=n��,�Ө��m\'놯��\0ൿb�m���Ci��\"��t��!G����ٛ�$�2�_�!�}�����z6 hݜ��f�_��\0�\\��M�?�M��ks�[��ǣ@��������I�ǚ[�]�x���yI���>Q�C�������\0M�&{����3��W��[���8{Fq��go��À1�+�e��~[���Qɟ�g\0�0���d���\0u�?h��O�H�V�����c�v��J����y�Z�f�^\\�c���BmV�MbQw
v�c��䞂�Z�^�f�;���l�[�e�c��S����hߏ��-�g�i��nDp!���W���\0mj����<Y�޿J?��_�w� �\0�o���>]����Ӄ�;T=�M��J�r<����>O��*\\9�u1�\0�Sݏ��_r���D��݅��g�m����p�\0?J�����q)\'�\'�Uu�VhwW��G��M<�O�	9�~��������b�m�[y�?3�j�~��Ƕ�q���ֶۥ�6Y�	�לY>��[�J����{���^��o�M}\'�Iu��O�[+ ����_`�(��l��8 �Eq�q��_��>Ì�3ø�Tj���J����h}9�\0Y�V�%{��V�P�x�a�1���85�A�]x�z��}�}�\\�)������o�Io|4��q�>������q�-�oj����a�!p#�G�߈��^/`T�{x-�?K���1�S9{��]�����q�\0&�94��_��k���fF6�[�4�RPMEx�q�k6�-�k�~+i~F�ѮV�������9�Efj^�\0��ž�P��Z�Pn�\'�kl3|�wv83
��ue�O�>���쿦|e�����V���xv;?+�F�?#_���j���;�����I&<�k�V%�&Y,�Ͷ�=7${A����2�i�ơ@TU�W��!�g����>���#� G�k�~X��e)[ԟ��\05�c�����!��ʫ�M��g�O�W�����OP�#�MJM8�Z��<*a��������>���6xQu���oS[9�n0�gzE�j�K�*�����
���z��g�}���>�8��wMnL02s� �5�?��OԿdO�+5��}���h��lw)���ק5ɛҕl$��&{<+����iV��n�4v�Q��eq��l�z=Ex��{�(?e�\0�Sğ�\'�.���UН���x��ԁ�^��1��=��|��J�ڳ�o�-�	�>�h��ZL�m&�9�����,8�=��_8�]��ײ��w?M��a�er���S]<�c��
�|l�q�y1i/y{u#�C�iS$�na_���w��~ ~��2Դ���K�H�NV@�dWן?m�j��J�|eo��\'M�-8L������D��>���$��1Q��k���2�.�}�����^���k�u�����������{��s�u��)�u��)��!pH<~��Om
������RmZL��y	�]�s�9�^��?��,�[�:!�~+��>��V����B���5=�assj�\'x����z�ʘj8<%�dҧ��X�z��\'=̱Tq���S�ܺ�����oڳ�ԛ�:���;��䊗��w�m͍���^{q_Gh����Q#n��]��NH����r�jtY$�I��\"�͹�.:�덂���T}ؗ�«���1�\'^{m�3�얞WK���j�}[�}��\0�ً?�V�~U��W��hk�?�~<��S��^)��c���l�Eۀ�o�\0�����>>�~~��&�^�4������g��X�a铓���\0�j����쿯|%�cs}�|A�{;y,#\"XU�������k�<UJp�QI�w���<��J�i�&�Դ�dw��K���ß�J�c����~��k�c����B#�`zW�O�K�;������H�3m���sq1�߈�}u�����?��_��:��P��?[M�%�����B�=��ſ���4��ҷ�|M;�R+v~Q�
��z�8F���G�8�!��/����c���m�7�W���Nk�p���9���zW�����\0C�:|�8�}��it�p��W���	��r�\"���#!�7�]G����d���,c
A�yjtc0�z���8�5���Ƣd��ݘF�\0$��\0J��?�k41n�#�ܑX
�c*�B)j���W<�^�g_�>|\"��������F}J�#���\0W��o�A5���xZ�᷂�����l��*�\0_��g�4{=c�6�f�k�k-�yD7�����}���|���I�_���R������s����e�QZ�ng�����T�\0��|}�?�����R�[\\����h��5�b���T句~6�\0�H?h>?�Ӛ�[����c�X�?+9wǻd�k�<�{+�w������
k�*UW�N]�����^*s�-���85��|]O�?�d�\\��	�[��͹z�����\\C��T��>0�\0·�����N��b�`OʒJ����M6�g��3����
��/���[��]�����\0�J�%�1 I��<J�?i?�1�q�9�xvH�I�!g�s�\0,�^P�`W������Ya�	���\0!^��-xk6J�4��=k�ʓ����_�⧗�㉢��$כ���?5[)4mZ��uh�-\\�*0�RG��m=k��)/�&�s��v�*��#̧h��~=k��fny�{��8��֕��\0G8W<��etq�����i/Ē�FsHNsX�.V/j�I�Bx�H[ <WO�C_��^��5�N�\'!���W0�3����`{�/�a|��a,�<�c�ν�����>h�:��[\"����޶?C��C�Чm~\\�U��\0�A��k8��m$Zt������>����ֿ�������EU�Ϯ@�_��4Ն���Z��G�s,�����\0Z�l�\08笮x/ǟ��\0�?�s��\04Fh~-~Κ�R]���6L���T�����΍��//�cD�E��:����Ċ2�^���I�ϡ��?a�:o���\0�7�M~��_����Q���:��C �,+ú_���ۿX�u	����Jl���.-�-�9LY�d��H��jn������ny���\'ĺ\'�=O��Ĩ��ƾ��C&�xcg�pG=�}\'~U�(fUf�r+��\0��|]�C��Կ�1xG�:.���nt�g�Rf@��#�����ş^��4�YP��\'?Z� �����ѣ�N
͝|-f��֯V�&�^��q������A?خ$E�b\0�k�ͯ�+���w�m���CA�������\"t����Xry����GŖ�\"�t=B��M<���\'�=ƽ��3�xuJ��w>o�xoW��\'��k۽���f�kπ~�����z�Ҿ��~9x��^7�<�^4�6���`a�����@��eЬ��\0�I��˂3<&D^�,���K���L��<@�޼�����0�3�_�g\\S����u^�y?3����\04���2��O��|��n��^/��-���k)�/ߴ�����>��\0kˉ5+}H�C�9(���de��^���/���O�$��o]]0���#�7_���\0���Z����[K��4�hmmt���%
�����7�j�c:8\'�S�<������f�֗Vk[��0|?���S��[���;]v���Ũjr��o#�-�������^��������5K��ռAz�n5��T�_a]���vk�FU��T��uu�!��q��ǀ�5�u1��L�՟�a�_K܏,b�]/����I�Kh�\\Qéx�Q��F�|ғ��q�jo��z�]�8�kQ��\0+��7_�\0h��2[x7K{˅�qwrW`#�Q_���<_��\'vk��
r�
<�����\0[�:ܾ�(:qo��kK�fx8�\0ę�}ƴ��?
����yo��?D=~�)�MS�ӳ���{��@?�t	~�|\\����\0��Z�Y�� }�\'.��PO�\\���Fx>�����{[�[T����[�e�N���?�}�we�7_om�G�����%�����j+����\03�_��\0��Y��G����k��,
�m�����Ʒ���wb�;���yE5�<����8�)vG����<Eiׯ+�6�ݳ�oϏ��ο�v��$�5MJ/��&Hc,�@I�+�t�4Ӽ���i\\��O.I�~I�k��,��\0�>�����HǚT��\\���\\)Q��||��_��9��r�e����O	�� �.�W�����Qӕ}�?�O���?�b�<�ӬіY#uu*pA\"��g�\\�:�=+�q��(�l�­j�������_؏������C�Yծ-���S<�.��`�5�֙��a<s���م~A�\0�<>/��~%��������l�¤���#���{���A�u �����_}��x�=�����+(�\'E|�?=��w���io�C�ԭm��5�5ݚtm�3���W�#C3F��ђ�0�_�J|�L˅8+���?ۧ�����7Ѫ��V�M���v��w.}�k�x��ˈ��F~��~�z�GZ[{п{ZI~fȨzү�=���������f�t`�YO��5���1�5�>�G�Tfއ]�i���(j�⶞��}��5���S������6�z�JW\"Rѝ��q��ʷe���Nv{���	e>!��UX\"Kb���1���_�~!��3y�\'\'�����\0�k�J>jw̸mCQ*\0?�Z�l��ԏȼj�c��ʴ��K�?~�\0����?��x�J�����\'ڝ21���[� \"_��ۻ�+��\0�Ʊx_�ާ��d��\0Z���>/��Z歨ʱZ���N�q�>��,O�?#�_��Ɨ��x{��Ɩ:�j6���T���$7�������;�Z�ğn��}��V���\'wU$d�i�*�_~�>#������S�mMD�X�;Y)��̊��\0�~��:�_i�����gҾC>̪G�x���dte�x�ǚM�`��w���1�������\'���ɫ����uV��7�֍�>��\0R��>Θ�b��o�95���32��z��\0�T�Ww��m��W/*K���_�7�.���{�� ��/%�^��F�RX���z�Z���7�0Y�7�>�<נ���L���f��6_�0���^�ɓa�t^@��rs���?���-)�cT��Y��ݺV��h�_�J����~�vz�5��[y\'̇T�\\}���\\������SI��mtn�ޱ�u�ϖ�͌��h�n�\0�wW9ee�}9?�r�5�
//A��1ǝ�_(�F���\'�=\\ߋ>|T�F��m�����0o!���C����u�N�=fs��b ��M���[�d��h}፴�^�q�j{1��2�)=���5����o�����6�xG�:��=)�%�e�]����½��dּ+�6h�����0�j��\0�>%�R[���#n�<��
��\0��~�������4�Bmy����L�g�9N���u��ʰ8zP猔��~Gę�c���׃����_��?C��\0c}|i������x��\0ϋ��*~5�a�\0�M��ݔ�ל~��r�;R�ңcK/(Vs�kԾ-Ż�$�\0�9A����V�=����j?~�1���\0@o��k��������_�+����er�\0c��ȥ�)\'ݕ��Y���r5<��ψ^0�t==L�ڥ�� wc��?�~�����~|#��+c�ҭQ$���e��X�_���G��?�H�<u�G�Y��Y�4�H�\0tW�/���}���(J��)l�\"x�뙝<����>����|�*B�K�	��O.I��>�#��TƎ澣x���i�>G̞��˩�o��\0����j���+�/5����E;�ؓ�:
�� ��w\'��w���\0�}�\0���\0h��鮑˷U��x�2<�3�6~����F4�b�ĒI%�Z[c����\'��I�/�o& ۍ�3�¸��\0�[����\0����YI�\0������4(����ъG%O��u}��W��\0#�m+�	��hZ�7V�,H��dY�q���v����Ӵ�Q4��#�VIPm��rG�Ղi���V

�>_�8�0�U?�	s8^�-���w�=�I�+qq��׍�\0�G�}��Y5X�ׇ_�P��i##����U}KN�T�{{��-�V���`Fi���R�7��9�VʳX�v��}�����*sz��� ~]��F+w���`�\0~1j�6�-���f��1;@�r+�i���aa��e���a��ÿvIk���͉<Q����Tn�ۉ�\\�_j�%�q���k:���A�U|ϥ�\\u���h� +��sɯ�?c�\'�f�L���y�O��\0�W�mޫ5�3|�p�~�����Q����E�g��}&CJ������\0�n|������D_u����s�(.�sҿ$��d�=�n<���h�R4Gk�m��A�־��\0������\04��ȟ����H���F0}�叅�)�c�>�=�\\j7\'��͎k깔c�#�������}=�\0�>6ѼE�-C��M����P.V����
�?����־��u�r�/��ĚF�4�֠o.[=@ye[�t5�~�_t�\0��\0���cY#�I;�������8�_����<\'�Di~e����ʌũ[��T�ݏ�>�����cp،Suc��]=|�����a�-�^�&z��v�\"o��$m����ֶ|?�*��ݕүe�X���\"�<���>��F�����Y�k�M�����A�����\'x�;�����HПԊ�9zU��_�O9�!T�50�ӳm�G�=�a��^��d�-,�����-_��ߵ��.4X�Q
�������c��Z�߶��mo#R�S��`1
���b+�YeE-%y�k��>\"�8�*R���#��U�p>�*Dl��s�%��|e�����P)�!f�D������_l.!]{S�#�R�o��^.\0���-��{J�v��\\�ޏ�F��@��G�:}�T���JԆ���dC�@��.��>yWԵG�m{�>��}[��=˪�\'��W�_�\'������O�x�X��q<Qǵnc�IP0Xg�^k��������3�o�q^#K�*���,��F�ȍ�pFo��<=K�c�3�c���5��������x<]}�j�~�o#�s�׺�L��G��?�W˿�=�>񦭤[��G�^T�X��_Ux�y���Ȑ=+�\\D������O�e�l��TO����}kl}���tx������0+�����q�\0c�����FѮ�M�Z�q�5���Q��1�@�1���_�$���\0>5���7��\0ǽ~Yn[��s�V�<4��#B;H�ˈ)�=|¬��y���?Cd��v����?�j�g��Y/�;��I��>��%piHX�`v����l�k�jtc(-��`����L�8�eRW=J~\"�&��*K�[P��,a����b�;r�@�ڋ��?�?�n��\0�ž㾾R�\0��|p]���;Y6�k���}����ʿ5�������J�
���>Xz��au������x�O�^TT�ʒN�������/�E���1�\0�~d�G�Ϳ��i�U|4�\0��\0�����\0�W��,�Vϕܧ#��_ʼ��R���\0����V>_�u�Oկ�{�w�uO�77�)��дI��Q��������s�\03��\0���U�����5te�X~u�\"��g��|�+�5:�Y��݉��>)�e�˯h���_�U)���n�� �C�o�����)le~~�p���V�Ò]����L�����u���E+�\0��+���jv�[F�K����_�M:�a����;{׀��_\"����-.y���>C~i\"��+��
;m�_G��ЍS��\0>�k����(;_MWGc�?�)Æ�\'��|Sgg�P�\\��&X:��5�[���X���Яq_�� �m����6�w��B���`�������ǚǇ�6��vE�@t<�Q_;�ac��FCx?�V�a%��*z��k.�A���b��$
+:���=�|ڭ��?5��j^|��Ǚ&�4���3�Mx�\0�;����Ӭ4��\\�6�-ٝ�|�I�>������i(j�蕏�ϱ��[��&��*�W����J۾�m�|�_�om��X�h��H��0�=2+�����w�����\0����hU�P%A��2��U�OÏ����<Ao�x�z��}z�a�! 1��}i�{�����[ɮ.��+y9?k�Yd�����k�8*Xx�)s�<a����T��O٨�ҳ��χ�O�]C��ƥ�]M�_^9�i�r�+��ɮ��D�,t��;�7�E�7��ir?\\Wן����_��\0�m{\\�>�u�]KO_\"�L2�0��@9�%�\0�s��Z�=N��� �I4}-���S�M.3�;
���:��X��W��:���\0q�9����ɹJ��m��j�E]�w�}k�u���\"�NZ����i�\0zM�S�\0�\0�.{�1�h�5��m|cq%����H8���3�M��� ��TN<Ե?��f1RTkǒ}��ўݦxf�W�_2U�8�G�[8U�\\���5��x��M��hd�5���r&�q�r�̣5���x��<��Wk*�U�Y���V�,�����]W���y/�Ϡ�\\�ݴ����MU:wwc�Q�f��U�{���	�5o�t��o��\'x���-҃ʌ�N}1u�Amu��G�s����������.{��s���h�*x*�K[����f��2$���������)b$�R�9h�+a�9Jr����%�C#������::��&���%cX!.�2:W�Y�\0�Z�]I��e�B��\0]����z/�?���N-�<[�k�7�>c]J�\"#��p?�ַ��d��#*�WF�GD���BtS�]j������ysRq��Ks7�8Y�__B{�5;����a ?J��\0��.k��������l�!G��T���\0�𗎂�igu���8g��\0W\'�H?�*�ÿ�\'g�|t.oa���#!��Ra�\0��~��J�r�{�6�Fx���
��u�u���-��<{q��[]Ե+�Q����!X���r+�L�M��!�b�8~:�������MV����U�>T�@��!i�*�
��v��ϸ����Su���iӞ1��~�&����h�eѢ�ܚ��ԛ<��GE�^?*�������ai[�%��.�}�*�K3�Vbp~�~��\0#��?g�Kh�5+�����$~�~v�\0�-�\0gi>9���z��%�?	�\0�\\�Ye�}rw�+��T(������x_�&/��7�?���\"����sJ���@����Gw{�o$�2�p�v$��ɩ�w����Ҽ�
1��~����ȫ��1�6������&�_MZ��I�[Z��G�5s<ʎ�|Ӓ��۷�v~c�ۿe���G��Wi�K8&6Vk�b��c�A�&�>��CH�c33�s��>��M޿)�Uu*9�����et��,��TW�iLSv���3�Ebz�E�ǌ��c�\0tV^�z��{nգ_�Ef�5�S�O�s/��0��SFݻ���ޟޘǚӖ�#���X��~*®�ۧ��yZv���~�7p�	�Ѱ�\"�_�FA�~G[L��+����#����Y�)�O_���E�=�+�k�*�9\'�־�#�+:R?��p��I��!�rI����Do�nc�J��
[���i�2���kw�����#�W��r>\\��X|m�;�Z��t7E}F��������W�U�8���<�T�sXc#�F_�?+v�<�)�Qi�;LlmZV9g1��}I���j��\'��o��������U(��zW��r]u���a���Ҍ�W����\'ׇR����a@�}��*�u�j����s�Fs_�\0�.t���\0ĺ��\"��-���;��J�;S�Zi�27ݎ\"ߥ}�K�t��#�ň�^ �!�c�y���\0���&��[N𭼎!�Io�P~W$�r>��o�\0Ғ�L��4�c+ג�3�u;����\0��)�����Y�|v~]�~��\0�����?�?����մ�BO[�jq�LvN���\'׵�UpΝ�y�<��1��&�Z>����J���k����A��j$����(��ڟ.x[؎���G�<{�g�7�Z̡�D9VS�k����	c�#\'��櫇����HѯTW����*�B�����b��:�/���A���k��$��w��>~����c��T��������@Ol7Z��O��=�C�c��nS����\0�����s���i7�n������1���!�]��j���+����7�L3�K��G�}~g�,��\0u�{���&��x+�_������Z��V8d�9�vb����u�1�J7q��2����^Gtg7M9�W۱�Sx
d��KzUm�-}���C)�m»�iW^,HZ��fY�6��Jg����C[+�,���in!v� �r�y ��S��Nv�8�D�WQ���8��v�V�:�n��}<�fY$#����5�j�\0R�74ֶ��������*�ʔ���^z~&��4�{q�TFņWּ�Ƌ
��ɵd
w(��|H���1�\"mKX��p�`��s�(�I>��\'���\0O���=���osk�<���A�>�ׂ��+ɨ��ݞ~g�`�P�I�����\08��r����g�\0�P�����>����ׇr�0��B��?<]�ύ�<a�O�i��hxԪ��Hr��(���ur���;9-�|~qd*x*zs_q����:rwk�����W1�\")��j�{��o�[��޹=)��.��޽cĿ�߉��i��GT���9�1��v*;��2#�u$r,��v��~��a��B��F��\0F�/���WJxZ���V��[�/#��	��o��\0���Ho�w�]wY?l�Yu�u�7?uϟ���k�_ڟ��W�L�0�Ź��?_�	g_\"6b{�ɩŤp���{�����Q�p���? ���<�S_ܥ\'-��������\0�`�xd�:��8@�\0Ы�{�
��G��^��a����q�y-�C4�:��_#�ԙR�^ێ*#��3s���s\"����3��Op|9�G5��u9S�VZI�����֘��u|�N����--@�OJSҌ��PWFr�-�\0�����Z>.�co�k;5�S�Q��c�H^�ݴ�u���i=��/�G5������\"�o<9u6�=f-���/��1�W�9�:��K��$�T��S�+|-wF����qGK6���jo5��ϣ?\\�E\\�)�q8>��*�,x�̟/^�{bv�Z�v񕬋��Ҟ��⾅g�$�O������w�Z-�wl���(������|Ui�������ù����+���.���)ӵOjz����D��L���3�~Լc�ǧiV7W�Ҝ,P�Y�J�����n�?t�l�*�Q7I[����e�/4o��1��/�yz���P������=��<�K�X@T\\���)�>|��uhRBIZi�VSv1�;�]ǝC���p�Z�l����u?�x�0���1X�2�\\�V�o�?�?�(�@~�>:V���]�М����~��콠ib����R�W�J���͟^��~~�\0�F��ٞ6`��zWۊ���\'�\0������O�ݒ�;,.��$�B1�c\\��\\:t�jk�9��k�6��a��?~�:��ǃ��<3y�z9m�؎�r<s^���������y�j��!<�$,-��S�#޽���:����=��\'�S�|��J���=J�P�g��H	XfoVQ�޾b�\"�&+���\03�
�z�;�i������{LZ�۝�h��8����.��\'� #\"�a��|Y�!�>_4z׆�ʋR��|���^��{w�|w��C�#�4;�599�۟Qڦ�p�:����}a(k�c-�Q�j��׸b���ҡ��j���棻�.-%��b��Ҽw_�~*x3U��@{[I\'̷��{?�O|c�����M�dV+	9�����~�[|A��W���oڙ7;m�^���[	�M$ח7YH���t��Ga�k̮>=x�����Ǉ���[m����Ԁ8�xS�;,n����.o1�t����\'=OJƝ�����(��_�m����g�[�?�l�
���q�����-d�`�7MǞ1��u�\'׍�il���7��Q��$�/�s_Px/��^�R��-���$�t�7���&�~S7S^�<�T�%4�m���^Nx�)7���\0#�#�	owp�����\"(��?�D��_���~\\��ٶ�y+qw� ���+�Es�:2���y�5�,MEe?����pisB�o﷞�=�K���;�q�i7a����?���k��\0a/�2�_���]זV�����˅F�\"���߶V�������T��x��x�)lǀX��V����_�G��Z���\\N��ɯ{#�V�\\�{3��B�HӡiJ*ͮ����:?��?i7k4qƪП����W�`�X��<7����l��%ݸ
�������xcP[��-f^w� �{���[?BF�[�F�	�{���C����F{�euU|iBK������\'x��B<�j�j��h�h��Kڼ��>��{�-��k?h�������u�6}}>��c��I��X��>��\"HG��\0���_\'�ᛧS�����D�\\�n\"�+z)�i�����B�>�֗��i�S��>]����If�Z7�ߍqLv���_\'Z�J.�\\��S�`�:�V5#mӺ���NM;�26�~��2���!�R��J�)��~�é����F?�k,֧��\0�!���^�?��c�|D�E�-�E4������\0_����a���qF�.�ҏ!�8���Jv���\'�N1svB��y;[�OV\0e�~u6��ϫ�Gom�F��������`�|Q0_j�t�I�? �\0e���>~���1`��:j��V��d�~�c��z�<��o�D~_�^,eY\\}��j�Y=�g��\0?��Z���7�-��[!Ŵ\\�H��\0ݯ�~����/����R3#��k����N�K����#�m�W��������o�Ɨt30���\0�|.]N��G�g��o��8��+����\0y�����K{p��R��k�~4|W��tk����2y�c�~=+��/�o�Ou��]I0�?*�r�?�e���\0j���¥��m$���5�˪g��?������p������3�u����\0eȯ7�l��mR���)�/\'`�E�y�P9&�S�\'���ۛ㞠��nu�V�縹�M��w\'t��c?S_���O��#߂c�&�V�`��g�׳ �,��a^����*��2������|W����f����_��������#*��2@>����_i0_Y\\Cugr���3�0��o���?�����i��:>��,R��\0��{�5���Lxc^�\0�I��G©�M�/�}��&]��1�G\'�C�=����r�Ys�Ӻ}O��0���m��>�Қ燴��ɧ�6����I��O�\0^���Ý/��9�:]�٭c�X�!Ԑ?]���٢���9$�im�<�R���Aj�M&�Mҝ�&�nR�I8KO#��F�*p��wq�K�#��4j��@?Z�S��a����(����\\ߊ�0x_�Z�Y�ե�ڨf��\0�Ȯ_gRM{=N���=\'�VV�~�j�
5mAmBT�8�<ǟ�W6$�#n�9�J�;�(�\0��qh�}�k�u�%�S��S^�A�\0�F-u\"}\'��γ�|���ݣ���z�Y���T]����Yu*N�j)[�wo�}}�s��_j���;�i$H��nws�Q�k��N�Ǟ��u�umV�WQ���䃞L�g�Nư��7��i_���׵�ºK�m�+����t-[K+�mNZ-���\0�ҩB4��-�������mo��\0�Ѿ��v��;2$��#�_+�`���]���ͦ��e@�K���o��6��G���Y�n&|e��X]Ǆ>�k�� i:U��;�c��SEZ���^.�e��*TT��GWo6|����-�f]CQ�tub|�\04��:��_A~�>2�.<Aq��G=��u��`>YGc�Q�+��𿁯d��|�gR���͆����_��B�4�+Vֵksc�ϵ�-�F��^�_R�Gz�D�n!���h(P��]w>�2)_�O��j�k���OA\\������	��/-�,���:�A�\\ɧL�
�\0��Ez�����WԾ��X�,�~h��6�^�����/�Y�1�۟o��|�c�9��D&/W�K]r��Ǒw���Qm�U쬷�}u���ŋGqw�0|�H����i~&�k�7�^���fc�%>ޙ�����x&H�\0x/-A�o�=�j��Q�|s�G��s�?OZ��`h�MU�Ϫ�2�r:�_YúOGꏁ|u�\\�a�}�Z���؝�W�r���ʣ����ľӼW�Kc�Y����0c�w���?��a�:���VW����{#�|vaõ��t=�.���� 0�.t��ޜ��oϱ�.��sI����{���<!�Ic�Y�cw��2${{{����_7(N.�џ��|U�Uh�IZ�����s^/?�0�����������謼שO�?8�;W���\0⣒Ps�z�W{��l�g��U�t�#�W�%��R�?�]ϰ���~���Ui��m�uK|He�G��\0e��C��W[h�θ��L�%�\'.z��_���g���k���е�J�Xg�(@aꣽ}��G�:����\"���j��j7�\\���G@+�O��)X�\"�c\0aF+����e��\0#Ag#j7J8��O�����4�+=O�(�K5�%*q�������}OP��x�F1�/,HUA��=��c����z��@x��\0�S^�_�P��]�(��`�A\\�ǌu	2��ƾ�s^�z#�d՚=3�;�<Qp�_�4�����\\�׋��قʒpf������c�n��+����gE�%�۝k^���� 6��\0�f��MTcgvE��c�㖟��×���q���)2�1¯���W������-��V��[P���-2+P�䌩��yH���޽�	��\0����w���)Y�xSঙ(�JѥS���C���c��޿q>�7�~x3O�煴{=\'G��[���#�$H��a�\0��{���	���ztzz��\\��w�2��I_�1���9���z�}��n���W�7�5��~��mcG�lj|˘S��-K���<h��ï�~m�\0��?\0���3��xc�G��>�s7�}�n���7��J�O�`�{u�x�V�M���>�N�ƽY����~6|\'���\0��r[���-���V�SQ�dx�\'#��C��]���~F�O�ڧ��xo����>����nO��{�?�3� �5=3R16yo\'��^�����,��·y�xwS�ӚLc�1Hɟ��j�l%�9�S��f��\'�&���+���R_���Hl����]үя�W��~*�<G��y{u-��͹䑋3������O�c3\\^*μ۱��u�\0�🊡��v�m��<�t��g��/��\0�L_�GT���A��H�D�ne*GB�����D��&��׮,-��2�1����E�킺���<mg����H�+��S(�F�?etr�n~H���=�zD��M���@i�m<c�1��A��D��Z[�(�c���L�H��|a���x\"�\0P����-H��YČ�zg&�u�\"���>�~.k��m\'��+{��h��F���F�8��W9sM�>�37�<=
��-{���>˖E�H�ʻNX��Z��^|L��<S\'����i�|�O^��\"�Q&>�:֗��O�(��ox7Ǒ�X����I��\"����I��5�����}{�	ũ[�1��gk\'��E�Y[� `xXod$�0���[/�}�����#�qW����{��Z��nD~	�ׇ�\\�,X��Wn�r��\0Q���Ě��{�|5��������?i��K;�ڗ G�)���o¦�:�ċ��\"����q��}k��\0���/>�\0�C����O��i�������Oaӟ�_PM{OnU��~�ߛw�~&�$��w�V7�\0����\0�ƽ�X:���������>\"�\0�;~\"�	|P���H��h�[F~ǩ&~R���Lc ��~��_
�����.�՚4��g;��?�W1���\"�21ocޝ��?J��������>[ި4忐$�7�[z|�!��e��e��͂?� �bM��b�T�Z�T�p�;/�_�&�����l�v���%O�c^���x��屸�� }�>�v5��qV�]~��W^~�4��w)��Smn��k��/�~�▖�k�tW*AT|m�?p{W��\0�a�[¢{��j�9\'�n.#ݚ���_����X��m��P�����d�Ê������J���wi?
�%��Լ7w4��kr\\�idDv/?.W�k��et1+�Z�?E��3��xYޚ�X���3ʹ�\0��)�����:=Գ(�3I�8qԖ=}?�+�	ۣ�N+}CŒ��|�7ٔm����oǊ�L��ܑǺNY���k���m/��S��]��\0�0��{W>$�KW��g�<b��njts	om����-t3ɂ�#�#��\0|j�t+i��jsr�����0��=W�l���kf�yH����M!T��ֽ��+T~M:��nM�����.x�Z>&f�s�A*���U�͞>hc���cSڍ���2�k�1uZ��R%�ٳ\\���6�#[̭�3���\0J�yT��q�y��G�{�?�7�5ۯ&HT�h2��\"���#����A��ۭk\\������s\'dQܓ^��\0��\0�Ex����Շ���|�>�aq�	M��r�̧�q�1�Z�\0�F�\0�$��������š��,�>��v:�rM(n�01��_�6Q�D�[�E
\0|���@�U�:6��t��졆���DQA�H�\0q�*�#w�Ԁ�^\'�`~�:G�٤X�6v7(���L�h��5	O��\"^��q]_��@��I�mk�Z��]\'LS��$��vƽX�W-�8~�q�,���i���S�+[L�Z�Ǆ�S�٭��HW�\\�d�Ķ��L�||N�����}7��1���t�T�/�`��LjI㌱�:V���ix#�$�l���.���
X���_8�;����Y��(���\0bO�v�kW	y�i�/��18�#��FrOj�n�*�G���\07��u�?T�&��E���l�i�g�^���S�hr߶_ŵ���Hx��	�e/��[�k���A끜�5����B�<)��\'Z�Hum&Sew��\"�
�q�±kX�E��zҘ��T~&����\0k�`���nE�����%�b9י�~jm?3uϵS?v�i����:�8xA��X�T�Ϟ��>��\0�X~�����NxK��}?Q_3�B�nSs<h����+�_����|;�]~̺����xmb�9m2H�lgU>[(�B=+�?���\0\'���\0^�\08+�M?՟���׎�O�<�S���\"R|���Oc�����|e���ū}Z��ѝ4[��$W-�=��1�~������P��\0��-��-bŻ/Ȁ����5��C�O����\0wM�\0�f�����5�m���9��g燃�ߊ��G����վ%~ͷ:~�̺���?����v��_y|2����\0�^��7�u+=sF�\"��[�x�S�Gj�������:O�_�?��E�\0�����@}��A~ξ�����ևk��z��	��O�����b+����\0�{���	M�	/t�uo���/��S&�἞��ю��ƿr��������\0�f����?�@���\0�wǚ%����Q�o#�D����b��M6�a\\\'Q_,�\0�-������W�1�������1N�t�����I�����>��֏����@.�\0�V>< �����n�-K���(��gW?��~s~ß����\0j�����o?����Q����w���\0!O�\0�����>����|1�i���Z<�^�#�H��v���O��F��1-޾y�\0�gɣxo��}:� D
r)Kd���u��)�y���UH� �I�~�\0�h���~>�{�s�uq�^���K�;\"�Z��\0��\0�mk��S/�V�\0�������g�����6�����u�#_�\0�p��)����?�J������e��\0�m�\0��\0z��c�g�0�� H�Q�\"�\0�ac����\0��\0�1V(�p?±�e�?�>�յ+�&��K����^ح�շҼ?���\0�E���a�\0���;���mj�K5�_���X��C���<�~�FZ���(/��¿\0�_��֮���tȎe�n߈�U�y��+����Gֿ7����c��W?�!�����\0�V���g�4��u� �v�Z���\0��{O ��g��v���_�_�?�q����ᵗ��#��*u|�>�{&>fv���_S|{�\0�}��^ku��?�������\0�R�7�����V�VE��W�\0~�����{W�����S�Ra����?�
����Kcr-/���dH�]��\0~5��[�/�#�@�*�u�h���;;�9�|���A�Z�wO�2}���','1','test','2015-11-09 18:30:16');
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('3','','usuario','7c4a8d09ca3762af61e59520943dc26494f8941b','2233','Usuario','Default','Sin direccion','usuario@usuario.com','99228833','����\0JFIF\0\0H\0H\0\0��\0C\0


��\0C		��\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0	��\0J\0\0!1AQ\"aq2����#B����3Rb�$r%CS�����4c	�����\0\0\0\0\0\0\0\0\0\0\0\0��\09\0\0!1\"A2Qaq����#B�����3RbCr%��\0\0\0?\0��b9N��i&z��:jA֖��Z0��	�f����ҧ@%N���F�jN�fɐ5�ʠ�ѹ\0��Wn�#���iTǕw��ڳ�w�>�!F^��鮕��g)\\�����]�[ٲF�`*�si�J���Q�%:��Ll\"���}��L{��g_�7�?�{�o�w1��q6o�=*H����R��u�jQۮ��w���[��I(�w�#�(R&�F� �G=(��٤����&(�R��`r�������+yBr1��y��;ߏc�훷i!�T��eJ���y�ji���f*0}�����J��D�����:�����F�u��������H�VV)��Uy��J@g��-�uk��O�R�N[d���\\6��B2.���\0̥$�zj4��1�VS˞r����.�Qs@v%3�:Z�QWm�C��x|9�_�`�R�\0�c����
	�⇴��wJ��������3jWޔڢ�����|�\\-�D&��H&�U���\0�Lw�\0VX���J����k���*�!O�����>m#i�R��C�Og���H(�𙪍S����*�3S�ɵf��f���ܶ��YN�cJ�:-�FN��¥�z�w��*�)�����O�v�\0��hY�]3y��뒢W�53t��SZ&��5��]못#��#�W\"\"�arw�ֹ���Ѣ��1�%�+F���}�>�~�I��wH�f����E�u\'�h�םB���fl�o]�;�4I�5����tO*\"?,�3��}jR�T��&L�뚤{��`�?*�`}�RK%%[5<��U��n����W{�+K�fh:�O�X���j΂��zU%�w�4�Wv6����.ـ멏J�5[:�=�ν�N�:���A�4�or H��u�r^�l,��*D�-I*���j�Lk���I緕Jj�;�F��ug5�����k��u�\0f琨a]�����Jܖ�雑�i�J��蔔���t��;L7���Q�czB��$ƇZ(�R�ZG@�cNt/�OI#d��u��\0:
�>��H�~�h5&wL�^���I1��{a*�:�*iIRS����A��8�uakG[�aIJ�w5y�_�N��L�����D�v�h\0�-S�h\0���F.ei���df��ռ�	�e\"GÝZ�+EKr{t�/1���4�-� 6:ӱ�S���W��Wn�֧P3,3�	�jbg�ɾ�p����� �W:Ǚ��Z@�{�4���� *�>�) �>M��g17��e�>4���sI�e
̰�/���\0*\'�
0��f����N���L�����\0v��N�NR#Ρ��0~����A�!�[��$��%�zE��$�d�gU�xN�JB^h9ޥJ�JAH� ���?K@�|�6ؓO�%J��i���R�(��.Fq�[%Q��Қ��s9y��Q@�vfm��J�36�\0J�SIl�]��9.Ѣ�p<��؅;������j�&	�9T�!���T��v�v�y��h�t_cs�t!)����/�-t�ʣM��M۳�l���Q�mof���S��f)Y��~U:�=UF�8��S��so����֙/{$<�����;����V�XN��;T��/��*����<?������_Ժ�~�}��ۥ�p�K`u)]đ���ư����5�w���\0����=��v��Y��ȅ�~����^�ir�2&c��ܷ/3���@�w�~�K��+{���\0�u%�J�;.�*8�ub�c�Sr���+S���-�9�3|���^:��_u�Qז�kKM�O�s3�:W~�&�న�W�H�`��]VM�w\'�ө����lN�qPq�J�ה�5�U�:F��5��n@U.=�HI�ʸQuF��F�P�֍�PH�k�N��u�đ\\D��c����@^ݚ@�\0�\\�kG`�|��{Q-/cs��_�r�?���I1]�B�:�w�Qc7}L��\0J���n�t�c˥G�I�tt �z�\0?���	�ݳ�\"s;��
�@��P�r���$��4m+��M�V���o}ff����\\?ˑrM���N$�l9WأMZ���.�T�tLr\'���Ö|`Z�W)4F�0Wl�,��D�1��j�2���2��PD{�j�+m.H\0����ү㋙�����;߬T2�r�\'ʴTTL�7=�?���d¼	�\'bzѨ7!2�Ү���t�����+}S9�����*�a-���dU�}KB3��g(\'��P��`�_@�.IN\\��r֦1�M=���[�!\\��
dS�$���%i\'�:�F����Zdw`$�yz�x������xe��B\0�A�0�֢��;��d�ǆlAr��P�x֭t>|�t���b^G���S�j�پ�*BҀ	��h�.ކ~`K��ˮ3;���O؅�Ii���S�����Y\\�Hkqyo=���
�+�Hp��C�d���F�_�ޡ0�A�|���I��S};qK%7f��**���ٳZ�s�f�ƞ����=^�̓�>Z�u�I˪30���b�߹7�5���Զ�l�4�=f�9E_D�ڨ��h)�g%�Y�R�m����ҥ�v�]i D�&��h��=+��:���Z@֥�d(��%Ru��:�o�b��3}t�����\'���}�`�qݖ<�Z1x��7��OJ����K$<�k�׿�zυ�Ǘ�I5��G��8�ѵ�b�WIRA�Rg�T!�Ok&��Q����t_(�_���^)Ỗd�u��L��\0K�Nτ�h�;�K��l�9�����^w�����Ov�5���f�C��������y����PRʹh6����w�	`��n�#O�	����>b�
��zW�i�=����Q0jS��{��H;պ+�gS�G�>�7�ONu:��!PF��imXI�r�*%�Ѱf\'}���M����Ff�]Vs~�A@�&� �4`Q��2�g���*(�fm�I�W�a{Xy�qՄ��#F��\'o:>��ѣu���pUdsg&�@u��`|����
��vK��:�ۤ�(x.�yvt.]�u����	���\\;�9�i|P�R����	Q騞u.1z;����q.�FǦ�ʗ�KCp�l��c�\0h|3�p�j����#� f	NS�=��Ex�;ṲN�����p�,g;u᫛v�*���-Җ��\0�6��d(�����+R��Vb���|Rj�\0���}�X����\0��y���Ӱ�a�5�ۥ��I-cI�\0���I$�+�x>��1��2kE%�_��$���ʔt$��Rk�b�G��2�\0��}DN�Њ�������%���R�5<�\'���-~�YO��h7d�w�q��Sm�P�ē���B�ّ��.��-!N��JS�R�ߥ
N��#b�)Nh	ϒ@�SS��V�!Ѐ�NR�3�L	�S��o�����\'8:*\'T+�H����e��`�f�*�N2e����!�o���۱�`�N�=u�u$�5os�Q�ʱ�}ݛ���:��G�5*6���^�\'��K@6�e\\��Z5�!�6sz�R��M����� !jk$�u���ul]i]�����S��J�OҘ��Kr�)�1�	����)2���������hC7R��[�- �*�*��<R���X��}=�� ��+���z0��֥}�i�DǑ�Wd��1*�g]�P)ꓳ`��Q�(��f:r�ֽ�I����T���\\�0,�5:�활f���
MG�0�zȚ����Ѭ���i54���K�s�� �+���)ʙ�}MO�ɚ.��=\"��q]��wP�Z���2���)�P���J#�Lz��D��:��?CH���TS��~nlZ�F��K�\0�7!%	Ǳ\0��]/o�W_�^�T�,�������1�q�C�����}F~t��xb��$���.�?�r��9��l��3V���TQ�g7�N���������4n���C�Lg4�\"��ā:֫�c�4�B�HНO*�\'��=h]�I+Y�3Kx��{���\0 �O,)آ\\��:�P�Ѱd�y�}z�y�h�v������8I�k���Klҝ�t*6C|t�\0])���1N�y{�Y
q��eԅt������/%P&��]�{3:�*�m��\'�D�����\"��9��o�O�-�\'�D:�#J���ȵ�����@G*��w�A\"k���]3�<��\0Z��I��Y˖�!��T����2{�b�ip�}\"A�@�4gҋ��<��zn�mn\\J�;��I#P���r�i���˴3z�Q�jʓ����|#�\\�����6�2��kQ��ù4�x�<��� x���վ(�y$Ѓ�:��#�MQ������S�>����D���:l�O����ޜ�m¬����n�A����4��]�ۅ��m>4Z3�Q��s�N�\0b�L�a��!P*Q�${�O��/BB��)fHH:��П���[�	w%���
�+��IH?#Qt��{�V�p�.P%o�ғ�Ǧ�/c�cg1p�+�XP(Y�j�$��Q���@K��m!�0<J����F��*U�7+�3�c)޺�]ѻ�����gx�P�d�Zcd���JW�\"f���%[��P���߯�I��lb�tI8e���R�)�+�V[P%C�|��JUn�f�Vsi�\'��Hq�vp{K1��I�v�ҺQ���9I.��×V�jHs;[��R;L���c�>س������JDq��bY%^�%��4�T2���)��슟�KLlx�#Q�L�6����.�?�	�g�O�B�W���9˹�\\�PW�$���B��OΧ��y-���g�c΋��[�e�&�$p�I&�xȇ�I���\0��\"<[r�~4l��*���.k2<�L�y�rx�ܠ��^:��ˣ���D�=�R�x��d�k���#֧��%f�����\'NU?\"=��N�5�e������f+~H�EOɈ?6U�����]�c�J�����W�j~L}����C~��Q|���A�=�k11�=*������T7��q�\0�k��ٌ�Gu`v� �b�7����L� bk�t�[Y
}�-�	�r@~5VQ�Oc��Iq,FZ�к$ށ�ɷM���w�TP�~���|t�I{�@۫���#J�^�s�OLf1���\0�$���z��j~\\N�ߪͮ�Н�B�A�*����$s�x�J��1�A�d�:iR���m�{;M�&g��мq�c�]���w>����Oh�.�;�)c��4)Q+#��a�t�J�}�����Uz�ҕ�L�h\"��sm[��q2y��C,k�drK�&���*��y�(��NV鏰��A̢a& nf5�P8�v���������1z���I�lz�bc�j��H1�Q�!�-�Hf�̄��cΛV�N[�ݨ�S#C��-�z5�6YSjO��f0y�(��������[i�sWAw�hkV���m��lͫ��$��M$�u�/-�|�
�RF�i=*\"��������ݲ��eJR	�A�|����gS��/Z6�*C;%_�5)�H�6�ƹV�6H̔ �3>�Bml���x��*�ːBOX�~t�V\"�,�
���1;i��TGV���)J�OJ$)�s���)J%/f���J��/�s�%�|GM��z:K����J�\"f:�P��C�qN�̬�HX�\0�I���6�4����Qihx�Q*|8.�^I̕/q��D���s���\03���:�O��=�u�z8��t��b�ne ��04��\0o�ZT�l(>K�g��u��)BAR��j9)!�g	\\Z.岕����O:��A�<s���Y�j��?0_��֊���@\0=)���2Mq{4���T���gAPB��5�A?���Fj6�T�hҵ�r9o�q��������Ҥ�y��j��5��z�\\v�7 �N���U9@0EGl�=�J���Q:�3L��qf��;Im��)�b@k\"��m%Ld*�ߦ��暑����Aͤ�ޞ�%�9��Ԑު� ����c�A���*���َ�u�H4�Y����I6����Y�Jz��O�ډ(��QD��U�/�G�ռe<��UC$FbӯJ���g����W���-J(ܝu��%ɵL�g��\\�+���u:�(�/b���A����	����\0.�I;�-($f�7�r9�*Ғ�
�(:���Z��V����X���,$�\'04	�t���2�y��\0/V�L�j�`�{��{�3�Rs($��:/��B��VUkH<�-t>1�V�^����j�B�I����rmvp�̃���Gʊ��_��2��m����Z
���*�?y��d��\'��=�.j=����l�����
O�1R�:���6�[y�y\0�z����4���Â�.�E�-;~`w�5�G�-κ���P���\\B��N� ��U�~�bx:z����do�\'�l�ROPy�\07�r��:8��Fرi�H�\'b#�B��w�^�G����ǗD�
��.�П�V�B�F��;��o�q70��R��:m�rz��.UOG�RV�����SEi;9Ů��Xj�{�]<��f/��8y**)��1k�$�G#�B4IPI�\'�h��%���ݻ��\0�ZBN��5�[䝌Q�:v��5�I=�.C����9��{:Qq��)iqi\0��\'J��i�5|�%���:�f���,k�Z�y�Q�ߊP:x��Mʱ��HI�_J�9j7+���r��W,�\0I�\\�����jw�44�n���#M6�\\v�4�A����� s��2�*:;}��T�^�D�#m�z5�-:�pKL�aR�:㽶iFڤ���/uA�lH���9�������9�RM��`����d[d�k�WC26���e�KU@�A?���\'��Z��ܪ��p /R�I�XH�htwc֓�Lz�Uv����M�:G�)�J��\0J�~�D�5�TM]#��	҅N����=�sG%]1��	��S���BN	=	�Q&w��D�\'a�k\\��rАw�l��HӦLz���ڡp��i��Q\\�\"�\'Y֏��к�:�����j��cR��T�]��p�]h�(�*B����%���<���v3�v���g�����C�#�C,����xg\'ihy�5-뛿:�9��+l�	/v$0�U�@����M=���[�T���j:�zST�be��4��).��)}��ʏ������HaO��iRH�ЉI��h�w�}V�v�C�f)N^�D�	J��S����b�(a9���*c���=j���Q]����;�!����.|��������n����R���a���	P����I--��)�}EL��$�TG��r̉���vy� :�d\'��u��|�oɊt?�\0��^�K���ݤ�.6�
r�\\���\']�hG�q�C�tҴ��!�4�ql{��
ʝ��嶿J��F[@/\'L*;��	 S����c��ߔ����K��?s�刭N���R����|���EJ�/�d[���M�U�Ҥ��X1�m��Қ���l�/�J=��1�m��=q�8I9�dH��Ə��鋗�g\\�Vx��إ9�Vu�N@O­c�	i3+/�8�=ldmVy$�i��J�F�v���V�ßS�����Q;+`G)��981�+��-l��� ��\\�N_0c��^����:��\"�ۀWI�R�\\Z�?j廥.x�f��u�װ�U��q�L�)�L�SI�\\�F��h&w9��}�jb�dJ����Mjݕdh�>ֵ)���f)��~\"�3��h�~|�ںȫ1M�I����������gk��OO��L�6Q06�5ɂ��Y���I>�1I�S5��uWF�t�=��ͩL�7�+�d^��:��k��ޝq�Y�)��5�u�oDӲi��>��j˓���8>;�ɻP�S��6۠2�i�UǦT8�&\"c}h��Z*�s>���b\"�-��ᾃ�&I��j�9G\"~��^튦�hXŽ�^��z�E�(��Z����ŵcd	*:o֚Ħ�Б�fG���َh�4��u���1��Ktr�H޹8��:A�݌N-q1�LoD&��$B���0�}t;�r�\'hyoh���h9�`9��i���i��D��G|M�(}�?�X������?
�<�J�F�2u�_�Za@%K}��\0P�աQ�Q�N[��\0���{���Z�n;������Gr�̉F4��� ���J�!����}]#.K�o�����)Z�:d�ʚ��Y��K_ԑp�_���9�|9��<�:N\\�ƭ�p��2�kE��݉�4�U��r��{^��fKˋwf�?�5�&û&uK-���t�����@���j��Oc�G�*[�7$�ayΗ���[^���:̈́�������>�UigoK��0E-�Kp�˭.P��f^%G������%�㏺\'XwfXSQj�9KC)?���#���\"��#%�n��}jF�݇i�gMp5��;���fZ\"S�Im��YPMh-�\0ھ�C�X�Jc0��1��x�i�[����ݶ���\0M~&�Y@|�!�p�8�̤xV��~��;-(j���lqˌ A4B�֡d�7aN	��s�P�WQ��h�:��Q��(KǶU�Kٽ��I��&@��Wq�i�eL�#/D�K�{Z��D*˴#J���BZ�����$�A����
��JH�y��֔f��w.+��v�BR���;�>�ƭ#Q�A�Q�wd֪S����@Zg�^C�+�{�8�b;�\'H[ͅ�%BT:Ո�5Ei����@8�\"�%IX-G�DH4|x�&� ��`\0��PT ��).�
7�cu2
��$�DjZ�I��Gށk!*Ӡe;��f���DEQ�tk\\E��5��o�N���i���s�A:�Q���T�Vn ���%�j\0�R�ٮd<��I�#�]d>�3u��]�u1�iQ�߃A2�dT��Th	�s�:�R�2�`H��u�4�ud����*ɓI�pN�#�Fn��Y��eg��4I
�z�V�IԈ���P��i}�>����Hl8��H�i/c��C���*Pt�����j�$��FRzT �Mv���=j�>���ln��$F����S�Ad� ���@$c�r � ���F��=<�dm	�$��$�M7��0�����dƫc}0�0U�����\0I�{����FP�ВL	�n����h5�؛��-G�yzU<���C��O��]RYmA�Tr�	9���-�m�	zV�3v�a`��\\,D4��{��u)�Q�zC�F*�\0b���QHCIN�)��E��O\"�@60�o�+9P����<�֯�PFg	d��s�n�_�V��R,\0~#�z�	��k\'��c����=��y�tz���\"��pƃ@$d	:i]?s�W����$��e�H6�	�1�S()�T�q��A����0��[�������+�%�Et����	pgP�H̯u�VD`�A�0�4�BGI�T�i�5c�0�d���i;Ps����Q�%
�:&�?�C���Ft�s�������V�`煲R���Ѧ��q��-ҧ�e�\0G?SQ%n�
Ij�w���dn�7���-�dǋ`u�ZHR���&S��&���R�&�էZ�B�@$���?7�w�i�`W�Z��t�ROH��H���L��	@j�2�+d�.Ⱦ!c�JJ���QЊ�{���d�*��x��vB��;I�<�U�>K�̟\'Uh�ovUw�;���Z����[xs�}K��zD��xx[\'T�S���Pt�j�JJ̨^8�>k8s��ԅ�NWZq#*��G����7-�b�m�c-�V�V����)=g��ӹ��Tpݡ���]�\'�7HNU�`(�\0?J�Lj�%k@�����	�]+��.����VBJ�˥[�+EyƝ��I)�Mu�X�PTw�Ҹ�
>�WY=�� ���	�0#M	�F�T���2 ��\\��i��	�go*�6�@�cmwGw�2�	�TY
ѳ�Ҹ$h\0cJ��zTdF��Pq��m�M�{0�dhf)s�Y1��T��y�ꑳE/������JS��@a��\\�*EZ�������up������t��bV<h�>�U�Y�\'T�\"�jn��6�Au����]��u�[&Z@{�$�$N�ztݻhA0PaZ�oL��KCb���}��vGM\'ֹ_�5�1�$�rt&c6����*J� I�֔����:lҙ�t;a �*�6�I��F.�c�tBД��y�4�7}�QZ_�<,���6 �lTwΕJj٥�|���
W~��B�lK��	��f�(���7�E��[��i�.-_�؍\0�A�<��Z�)99��\0�?e�r�!ח�A u���tDڎ���/�N��k�t�M��R��#�h����y���٫�����t�b�<=m��3l�a,�j\0��4��,�>ϡ(F
��$�\\XG���6�q����E>�R	u=~i?����v�CL�9�g��W9j��(K���)Z��P6#z�����U+1	\0D@�\\��J49�J���2\0�@�{V�V�j�KhP?�L�S��g6�a�	J��H��Ը/���k�E�R�l����R*I&;�\')�r��b�+���QBgA���K�yi:�������p��/@)��q\'V��l� �`L�	~v95��c\"@JI3��:L�>*�\"?zJ�ҠP��Ң��1b�v|�LIФ����(��6aE����\\�U�=h��%Ę�&�R�
�EZǒPz(����<��7e)`=sf�����:���r<�������\0�N:�p��ӭ����\'J�K�<�`��1�p��;gb��څ]�	�\\�Ct\\B�2H3Z\'!dI�(��+�ȄeY�(l(T$�m�Y#����l�{�J������z+���:2��ҭ�TL&A�ϥq)�_k6�H�Q@���\0I���:�vh$�#ʥ�{�0k$�����)>�WRg~L�I\'L�Z����`N���A:�5����bjh���\'P}&���(�U?�lq`���r�j^F�Xȴ��le��;������.<���\\��ү*�P�|�������M���$�;|��	&(�\\t�J��Oa��45Q������M),z���屰4��ň�U�%#]~4��}3�Ǉx������װ�>\"w�W`�P�R�ha>z�X4��R瘦{���d�d�F�Κ���2#�2\\�҉tG�r`2$�򥧲zT!����5t9hhr�yқ���������
�Lt��C!�&<//�CcuU��~4�1�/s~�2a����r�d�<m۲T���J��֍��%$�Y��]\0CJ����;[�g?�x�]�R��3���{�y��Ño����P]�����gh!�ۋL@Ҿ}�f�y�>���X1qK�lA\0�w��i*1C۽��m��!	T���H\\x�a�F�@�2���v;�{���Z@$>��M=��l\'lͅ�)��\"��b���24hj]�ƈӕ�Am����Od�@�qkB��}�-�ջ�NU�Х@�\\yQ7)+l.�3�V�����M7���c�y(I(2��&Uzbέ�2ɉV�Q\'��j�l4���2+)�#҆)?QbM�Oc7�!�PK�먚��*��.�(�IJ��<��,v�l���ށ׬��!J;fO������	�a�K�;���#��J���ʥ�p5�k))s*�v;T5�d�=�+��+u
RD8���Xŕ�E<�����V$�C.L��V�\\g�cd��&�#8���wI1*����698=����ʴQ}��~��^��c+�S���y�V��y�\'�I}%*�s�q+)JL�iqy�Ƶ�r<�T�>�\\�E�̀&z�J���K��$�@9�`	56�2�؟�T�$@O ?Z.���A-!����F��
qO�u���=+�h+�Ά�g��G���Le�9���C��Kf\'�K���E����-����!�V�����Z��#��:#R`y�~�AG�^���4���lj��K�pV<U\'_���f��\0�Ua��L������xE���M�d����������9T5t��7�?����\0@ju��b��2#��V�m������K��h�\\5���`@ҪFI�H��TCHU��]b�\'�(�.m&\0
��u��(��f�eGCu̎�B����:{A;t�O c���vXƚ����K��hr��M9s��,E*N�_�-��I��a#J(���`[�*���CH��oCrs��}(�������G�;�R�#�	*3z$Gob��ރSA.��b@�OtmE`��t�R��4��k�����̍��+��m��$�zR���ǶiK��ND�\'Us>�����9\'&�;��U���ҩ� �~ꆽ�/Z����<����������!��ʹ���	n������HZ���2N��o�-�W^Ǣ{᯺�˯�>��	����z�9�,��G��6�K�_��E+B���J�8ڼ�T�o)��A�1�<���!�jI��S��[�ێ�+`�ew:t����ZѰ뜌r4��]�ϊ�a�X̉3�H�uq��Bw�	w)��$�	�)�R��X�&R^\'�;�Ң��7v��6ݢ
]�UTI�OZdc*bͮ\"�Y�,7��a#�3~�*�c�g{�6Tr�1A3�R�-���m���z;�:�VڄOM+��n�+�i$�K.���ґ�\0x`�\0~T��TC��1hSi�
y���}���B�d��H���)O����4CHqJ^D��yҡ���m�[VE�&�j�T�:��\0j�F��Cc�S���I��a{���ΐ�K�˕�T����+JXZ���N�DJ~�`[��⤘ʍ���h�Q������x|{L{Ubpb�bYSh���O2#o��qK�#7��:h��=m��8��
�)>\\�\0�uggM�3x��d�3�KW.)-�8����ȯI���xo�x\\v�M��Þ,���L)h�#[2Jk��Pt��6�6�RZY.N}�y*5����9����q�ƒ�Z*Y����N�	�}�K������%���X�>�T9Jh�/���\'N@Wq������LJz��J��\\��ξ���Y��O7u�\0�{R\"	ߝG:s�H�ߕ���G�\"S�L�7���}��\"M��O\\)��VW�IR5�>M�ǼS��0��i>.re�\'3mE�,1�%�A:��Z�j�BCR��\"���q�d4ޓ���Cr�G��9��\"7��=�-�{�/��\"}�1A�H~<���2���`�\'�m�ҳ��ue�N\\-y%�I�]�O��n��؏���y֍�3Zo����lA�&�Z�Y�s��j��U�~5N]�i��\'�$��O���\"��KC��Ic���bwB���ñ3��\0�g9�mQuؒ�d�<��	]�Ѵf&�t�#~�.�&�����
�l��i�}���\0��&��_c�Ù�M+�k����]I�vژ)&=l�uח*K�f���M�t��R�S��0��C.������C��)#O
���hU��q]Xk�eqHCh��Cj��t����qvF5n�H8\0N+���6�FA�s�:���Y�#C>rW���c�Kd)�H��J�d�m��%�	2���Ĝ��Md�b^���%�Z%`�r�b7�~�)6�c���i	KH%�9��`��(�˖�X�&B5�7�lR솚^�����RLe���cv�)�a�q��RR�d��^f�-5d�>( Z��B�T��p\"<#Q�9:S*NT�:.s�&��:n�Ғ֓��\051>IhL��q�k�R�R�TL\09
�}��ZL�v�er��h<���#j����SL �\\R�Ba
�ʚ��%�%^㰁�t�F�S��*��e%N/D�@J��(T���95H�mf@I��L��<Z��5z�b��+��0��Q�j����>JK~�K�n(\0�!D�]4�63���8��/�sK�G�Rʢ����N*޿wR�B�z��)EW|���J��6!a9DhF�b��@;���bb&��c8���X#�Z\\H)\\��|���H�>���]�q�N�r>\\��\'~�2<�N�Zv��&��%!M��O?��/\'f���B���\0�F�))ʙ%$�_*�X&��כ��4��zД�Z:5A2������S߹W���\0�_��jijSI\'@�7�O��W�N�>CN��T	�����#�z�a2�Z���b���3���q�/�f��&d�U5�9ٲ�]j8�s��\0��E^�r֎A����Ib��+C	��A\'�dc˦N�U}��V�Vu�2Q��K;\0^�*��T�I�V�#�)\"�I�6��#�P:΂�U��N�Ixm�]\"�k3����&���5R�.�/�j������� <��Cz��ά��J�u*d�HF�DV<�l><H Ne�f�j�ED��:�G�ˤ�8i:�5\"�L��f�S�B�i���	���I[�cP��<��\\���/Aʒ�z�% &N�T��!��.t�;`dm ��������>��h��.m%�lؙ���^��g.#]�Ja�.�Pu�T�\\�_`�� ��<P=9Q��sv�<|�NԘ��5���r�\0�h�}B�\0L
E��XIU���\0*9���k���}�����Z	Jd��̩����=�\"��D��������i����H���9E���g\\:�d%D,s���\0j����=?��Ҷ^\\3d�-\\JR\"@P�z�+�gi�{���w�4�[H�ps5Q?cB���c��\0��F~B�5�t�vaj/���$xSցJߤ�6��ͣ%ˁ>�a�S*OD6��Z>�r�1�;��!A=��ج�@��	���S��IR�� )-�*r���ʉ�?z��dAF.��\0�aK$\\9v�����\"��(rr�?�IAB����p�̑\0�Z�Q��M�G�9��s�j��oG���k�����+.b����SztU��tc����A�B��!K�	 �J�\0i�L=�#�D��Lǚ�[����cm��x�rt��(�m=��cOګMӶ�ZI���qr2��hy�uU�[ދK^�`��:4T%I>7��A��rܣ6`��IЦ$�%����`+�RVR�N�Toc��� �geh-��
�A��9Lz~b���
.���M�@(h\'Q�Ճ(���|4��=�\0r<�nx�Mm{ɏ��ݣ`ae�Ҥ�h#�7#��^�����x?����	uƜo�e@���A_��y֌Z}�y٧HN�]�Bҡ�������NJ�ժ��/��T�@	\'i�4��+=�J�<�\"���UX����F�|[Ѡ\0��T��J�^ zk�Wh���\'��T�#~�hB��Pz	�r�)>�!�0���*&O���ٖqA��<B�i�PBD
���lқq��6�fJ��v��^�0���\0:ہ�N��hŪ3�rٍ>�J�L�G*�%L�kd���Y��\0�5�l��)Z7|W���,,�3	�6�)��#ɍ���KNɖ8#N�\"�c��њN
�\"\0Q:kZm�\"�H�Cjוh��Q^͘����+�B^\'�&by��T\\��̈��uJL�����6���=��m�CH��X�j��֖1+�o|
[$Iӝ3`�֨\0�9���Ҵ�Fs���BNFCO}�\\��h�	Ԁܩ̯lIi\0��(�G5lt����n���62J<hA�.yrh�t��;|KcO]6��L)uT5	񎿥8V�H~�)N�uXuk�hq9֡%{\'x�KN��+Kd��J;��PTv����mw��ܙ��r^�n��rH���/ҩNR�t�,Q�����;7o���!�4t��?z�^fO��{�����gJde�o���I��uH�0�&W3�ڗ�m��aKF{��I�
d
�\\���=���|%)Y͛U�T��D�����d<�S!F3�L:j�vr�h2�Y�*%)H0F��}��\\B����IP��*bu���=m\"�(ȕF��4�Ձ�Hz��@�ܞI��ST�Z�7}��ȕ��\\�(�S�^��WC��-ם	�A٧���=��)��B�<	r<��)w�
q�Dn��j3�f �4�i��<R^���Q9�H�w�J��&��8���t�B�k�H3�9R��K��X��40���P������Α�%�R���㸰;�J[�1��
�j��I6�Lap�<����B�HjN�0�QS%hQ�}�AaJ):`��iJ֩�nt->�M] M�*.();/��r��0e�!���ۑ�O�Y��9TD�t�c[DS�J����Z�&�Tϊ-YJv���V�P�D�5��z_�m�~;���R�H�+Z�de���l���\0�+�cnG���ް�7����\'0�(�N������EKIm�J���H��??�]��;����)��DF_qE�x����5�i�>�܂Q���ݜ�+�P�T�J��;�8r��	�;���G��7p`�4��X�5�P������|߹�t�.�6�F�Nnp �Y��f�f�?+�K�o	q���hR��Y��r�Ze�`�T/s�xA�!Hk)�\0A�J���3�ª�w��<d2�|o�s���r�^�����~��{8�[���ADk�ե��9�3rxx���ճ�Ҝ��w���sT�R>*�n���{�P;�W#�Iĭ,jRq(Ç=9iL�r��ʪez��*�J�fO@(h��+AQ��7oS������zzf�P�h�I���F�?
�.�\\��4\'֑\"�n�t���&_��Twc��)a%��\"��L�ج�Z\0:Ir\"kJ=RM�b/�B ��ڎ=�4�ll�Iޝ+����hl9mR�{�P����R��]������@��n�d�\0M%m��Z���9��Tפ*/v=T%�|)��J��2�{�TvH�k�)5}[G˫i
I�af���|��N�w
�r�x~����B\0$6��u>��G7�U�5�i,���W�]㟊��D��\"����{�vZ�@�(Z�����*K�n�ޑ-���X��cY�Zn�Ƿ��g)�[	?*�l�i-$�	Q��S!v.o����˒��Zj��d)�Ai\'\"3AFY�j�Hm���ND%$s��\"��Zɷlv�e��PP�\0(�������mm�RU��0�4�h�S��߻u��&�O��J��N1pl�KPu ,%��	�}M
u#�S�l��]2�4H���I�����`���C���`����и��!����.wZ���;yP_W4�)�ZФHJU��Jv��J1�ӳ��\\J� H9H�WM�L����������Ҹ���= ;�<�$!@hA�U�rmDe�l�!���.�;~��Q�Fís\\X	4!p�z؄���J���N�qd
φ	�N�J�)��^�JM�c6�F��5I>��̣,.�����kdIrTSݯ3�w��,�T�RwҶ�)4�-�q<�t�����JIJwR�#��^�֙�Ѧ�^�(-��
eE��0|� �U��c3%��g�-
�9i�r�rJ�����p	*&#�9z���v�
;�:R_a���͡�D˕C@�E�������k���n[)2�%��s+(\"L��AY�L�G�rw�v����Z��݇m�}V�&Q� �\0Tr�*�!/#�l��yR���wXݩ�� �	�=��Y!�����!�L��k��q��Xy��{$�^G6Y�t�U�$�2om���@R
w1�g?6E���r�b/�z6M�Z[\'�ѻ�g�%439�&(�\\��~47\'����8i����Dk	��3d��(��1��<�\0��ilî6`�{OÜ�r<����:L�aø�%��3�A�
�q�Y���e6@L��
F%r���e� �����Z�˪莕H�G�*�3��2�b6��:)1F@Ϧ���]Td�JOe�ҊLx�b\'_-�c�ht׋�ӥ%�OWC��r���c\\G0G�7b��(�IJ�Fcw�]�D	��q��sz��4	���S%�Jݤ�T�W�����P�hH�iu�
I�$�X\0�\'��n��[t;|�۝*5c�
T6h�iM����t�w,��L6?\"QZ:�Z��d�M�\0�u,M��x[�\0e\0iU�i�ҥ�OxY
y��
�	S�d�i)�>C�~_-����!)I�j�)�^gZ�T�[=��2��m�+�\0��c�Wi�4�IYJBuT���KV�Iv���e����$��|b��w���l�)&gsV����ZA�{�=�%�H;��j�W
��a2\0A	���}(�h+�lrý�\0x�B���.6�ꤤح��-�>V�9�� ���hp�RSjPI
GΆ���Kk�s�%�k�Г9�I�VMk�|�e��hk3m)_�jb��MzP�Q�lX��$J@�c�{��ؓWHqA
RG,�-hm=�6�$�{��L�S��R���`s�{6�QJ
l�Ȑu�X�a����e	n\0k�j��<�}�\0q������hP���+��]�s��]�ie�j\"4#M)*!Iɂ.�AV_�D�UyF�c��Z�nP�D�D{]*��;�C$�I*L:���
IvD��X���A@&B�-V��B\\`����E�
70YK�� )=�c1�B������Qa�k�d}�RF��Z��.�;wG�ܷZ1\"�$$*F�g@O�+��+>w�m�Ց�p�Դ�QFc��]��U��-��δ��F�I���y��ʉ�V��8���u ɚ1o}��\0*eGp�p`ʗbIyyN�i��‿q͆1w�>���[�
�ʂx��T��i��bw�-��[�ʖ⤓�hc�1T�l��~���(��:����q�,I>��1^u-e)3�`yŝh��~-<4�]�9��z̈́��W��������~R$��\0�,��#��_�\0�/L��?�ղ/�l׮�RX
֯��\0O�l���C�}(�����c�ԩR��Y�|���|��dϨ�@.1��Vꔳ�5�!�0�G��Y϶H��W��4U/.���jvL��qj:����ܴlf~��.͍��Or�j�Q\'�yV�Lǵ�:`���?�)�
��\0���Pˮ�ӐY�\"�K��U*�z�\0\"H�-%Lr�sk3�֒��T�)N��-��3��M�*~.�e��+���1�h.�Ƿ��L��#ع8��7O�$kX��)=P���NƍC�e�@:��)>�Z��$ ��Q�\\���Q�9�\0��D9�b,�t�.���
?������ҕ�<�Te�s:\0��}(��`R}��-�63!*�H�}�VKܵ�,~Sn]\"ul(B
���Me�s�x	�M�ᔥ��R�h�F�����l�~*\\�F�[��:�Eg=�k/����
�xE��x�2�>T�BS��M%l�/��_�2����Ba=߯���x�OeW�c�$V��$��yRLFex�GXA�5ab�K�lkL��<\\����w���HH�&��8��qq��}m����
��\'BH��)�kr+)ޑ ��+ɕkU����r��y6�*���2�`,&rO9�\0��V��6��Ӈ���%I\0�4�ֻ�Ǡ�)m	?���d
���ԩ�#����,8Ͱ�l���WGQ:Yb�أv�
23H\'Q4k�B����R�IJB�YS�Ƨjc��w�\'�n6���j�qM��g��I��Ύ8��o*�u�F�ڭn��\'p�
�t�(Vz�)#W�}��Nn�)H������c�9�D7�Qn�\\il�胩�z���
�Q��JJ���㍥\'��R��̤y*���,��0y�mAYR���*���Jj+t3�}���YBW�ϧ�V���q��6�0���\0.�i[,ũ/�=7*qP&
�![�C����	QPT+x�1/�)�؅�aV�PH^�&t^��~�	n즸���Y� $�\'4��_|m[~2���yRr��%�-��!B�J�͜�c��^��>���m6F�˦�.�HiJR��v=v��j.���*�)Ji)a\':U�Q���Ӿ�Ы}�o3��\0e0�U1���w��\0��LD�2�\'W���b~4�~ƶ2t�����#�<�֙��ؚ�zF&DďC\\�WFA�H��@A$t��?�j`{Dԑ�*�L�\\M���C]�W�L�����β|ǣK���YƇ�Bw���6|���w-\09U��37\\H�˰�V�2[l���5�����믥���3�A�^�~���5�����t9f@�ҤXQ�ht�|�R^Ƥ����Ǘ�Y�R���kMƂy��b�E6��cì�֛���ކ��1��5�-kLE#2���z���J]����+d��ҊOB�I���zOJLht����_���R����N��î;�턑*y��*Z+�w&�/9�MR��e|��ZT�(�!*F�\0*���t{O����.kGM��o uj��΄t�^u�r\'&�=deIQ���q.Z��.�7���Ӝ�}j׏�,����+��?[�\0�ܧ�L�ﮓ{rm�qJ.�J����w��8�8cU����L��+o�W�m\\2멸T%N8�D�0\"y
{��B#��m�Ο�%��Mimwo�fL%iSI&9eQ9����GG�⭽���	��KG_M�>�\0	R��#S��Rߎ��e��FN��lp�n���0�E��@qo;��?���������%��-n�{	y�bm��L%W#y��Lc�[5>r��M��^\\�7|�jvJF��Li��]��{
I5��#�i����p d&\0�Ё�5M4fd䪇�EǴ��R4��G�Զw�p�c�V[}�
I\0��	���m�s�chyu�Kr�Z�+�n k���&�%RS�*���#Č\\�!v�/\"�Xܒ���WrS�E�x�rdBﵫl#	�n�qM�lJr���B60H�*���h��Ƿ��\0��W�j���Up� �ڒ�$��&3��t���w_��
x�Uv?k�ě����$B�gNYU�B63Nk$������h��r��;mgB~��oٔ����$��Dr4�crE�f4��F����Z���8���#�\'1XW9i�D|vދ>!����cr���n��0�I� �hm֗��]�>\'�7���{~�Jj�-��f�`��7);����Q�b�|���^�m�\0�\\w�.8Azu�90Mh����\'R,/�4����*��5�ZM�.���}�
ۑ��ƨ.(��\'�������:*9|�F�J����!.6K�-9�\'b��n����M�E�J_C�Y�?<O/�*��Gg��ې�ɹMׄ�2�!BL�	^�Q�ⶁ
yKD���t�^T�:��E��5�Ңr�Pd\0t����n����Ʒ�H���d>��De�9�u��vrʧ�Zk��\0F�
���9�Ҧ��-��@�1Q�&�h�\0G*�ي(�&�/sY	 �?:�&��v��Ѥ���dWvk؞�tԼ�������4�%�C�
��Mꇍ��J����:֊{3�u�E���-kT��в=��֖�LV���=hf�I���\'(&j�/Eˊ���I3�\"E���u�:M%�Wc�A���R��r��qI\"4ugSȵ�ʝ��5�U5Ժ؅��1�Q�^N툢d�k�RJ�$�;�{�{J�/@BF�����+a㜢g����\0F�iQ��]��\'#�yL��%~GW:����C���ƒ����t4MX���a��q�Q�IoH��]�0C�Oc��c�:�\"�@$l+��Rz>���p���}�Å��0�$�V\"rO^�r�a���z^�3�_!\\V�W�X�2��e)y�+Y2W�
���-{7<����/�v[��\\��x[Š��~cCbE;��w��6)�p\'����x�)U�) �cA\\�t�7����%��w�@����A��V#8��*O�νR������I���V�Bc�Zɴ[�\"I�����=(�ɹl[SZ��QR�iU�{vR[�uaN�%	
���J�cޘ�O\"ӱ�<k`�\\��W��c��߿*��A�(g�	z[t\\��v�������`�y����AI��*�\\������2qNG��4�R��V-��	T�a��iU#\'�Us�r���c�[�^�%
\\�U/����ҭ)�k������~������	+G�?��aM��*X���!�b�ٵ��d
Wt�B���rޖ��h�9R���-��±=N8E����vl�	?�dǕV���BW�\0���J���y��j}�IK�� �07����V��N1�Rty_��|B��B�\0q՗��U,�(H�\0�:��Z�઻<ב�ZrtE�;�]2�[�2�R�4�\03�ҭ\'�f4��k��\0�.P���������c�^}u��KB��St8�x�:��Y�	AJ�!Q�FnG_�^.9;B��dJ��Wd��a�;Ա
	Pi���D��k�.x-l������Tq���6���2��� ��\'�_>�T��_]�縺�c�n�|�]e�{�F@߁�wI���I����L{o���+���	�K�rw�\0�u��m|�Uϐ��o/�kh��~f�^�J�%P��k�y�\\^�J�6������IZ� \"��>��$����f�Vd�&���ϝox�vy_6�z���Z�)u����9��W��MQ�ʝ�?�8���J�\0�A#L��}ƭ�T̶���BRͪ�(s7�v9u��Lt�@˕��[��)�\0�Qӣ��lg� �&BT5��o��鐧��3𦃿���3��C�]�ۣAS���*r.�3_�N�뎻f�P�L��2�35�-��	�M@+of� hLjjW�-��ɒ+�����CDGK����!KI��#���Τ͏^�\\q��������F��iQ,�ܨH$��U�Q�(q��.Ț�I�tdk����릳BΊ~�qhs,i��%�����H�E��V;h����j�t����Β��Ӵ�)H<��Ҙ۰f)���X��Y�n���֯{ۯ�m{cD�\"��FG*�I�K&y��}��B��$�Ҙ���O��x��
TBnĬ���>Ph��n�V�$��z���
T�f�Y��\0�LOºoZ1�ޅ�T��t�5>��/q�$�I�\'Q��3����:���F����ʣ��|/9]Y�k����+���k1\"5�A�5�e�#�Ta�(��q�E��ԇ\\Z���ג}<���iE%�y��$�~�\0�[�ٝ��]<�2@��0��\0�t�QMɓ���x�[v�ۇ8k
�@R[R�@�7Rpy�O��S�z6!��%TO0#	�Gxm�����E����%=\"\'�\'U�ü!��ݲ�v�e��Q>Dr�R�kLD�%�\"/�g��w�)m�[[(	$s|G����i5U�8O��\02��>�X\"Yu��&�ZQ�G\"9
�L\\|<o�w���o�f{�-i]�i[EY��Y����Jt|�fs�d_��8�	t�����h�d��\0�GM9u�^h��[���:^��پoct��Ì,J\\l�>�D�=j��Z�h�W�Fy9���Vğ}$�铒
UKd�\0]�ZB�˾�/�Z��U��i�ho����ZṔ��5����V7�%�	��v���|�V��[*0I܃���\'���6�&P\\s�9�q��ol��LJB��Ry�&\0���2R�3��$Ր�{:{���-Ö͌�F�|�7$��}Z����R����J���ٯ�n���(���\0u�:t��Ɍ{+O��o��~����a�\\��R�p�U�G��ey)���Rm����Os��Vx���	��OJl<�(\\�	;��%�E�lmR�\\A���RVk	Q׈\\ξTk��eW�����\"��q�ݭ%�CIW��%@D�\0���gm�?P�ů��׹
�{���Aq���W&L�*&��źd�$Q��-����f�rۼ�6�(eKT3͉���z/�N�N3d���%�V�Q܈߭y+���Gh�����4Z�]�r ��yN��U�z\\��am_Y����eP���z֏�-���c�,�7ajñ4�(�A�c�ϒGͼ�*tE�쩿��ۥh&ڳ���.�p�8\0�+:u�7����m�����j{��G]�о�N�ֆ��BW�!��k��Jtl\\�_������F�i�
�º�3( ΃�o]��h����EI�F{;t�������?z29�?J�U�`#C:t�g*�A\'֧����c���4gvZ=�3�Ǻ���h��tv�/�ĞB\"�x��\\���G��J�mr���J99c6�s���G�J�ŀ99E�t/f�P�J\\ގ]�a�@M���5�/|Uv�p���H:jS���1pzE,����M�&��3����*��zU�ћ8�oxcy��S ��Vp\0KDǾ���B(�:3�M3�[m�,����|�q)R��\0٫0$g�
���H��\0�g94̵	Dk��jJ�t.�J���J��r%v+l��غBL�����L�Ⱦ��Ԭ1/���#�^w�YT_������m�`��0��!d%@��5�q6�U�)@	�|*�u��l6�L���3�Y���U#\"8yN�,�!�\\ٶ��!@f*H��iTrM��a�C]��YØ\'B����J�����I��<�J����X��k���>�Gv�3����dqB��Yx.����W�<�qRXM�!��0�f�����i���KEY�1�k��B��q�(z�K�
��L�7���\'ҎX8+L�O�Gj�67�(����+:=`�G��5$�X�]P~׊-�V��JѺT�5cj�qu��7+f9���w��\'0�\'p� �J��E�eƭ2��<A�h�*�\"F��R#7]����[X>(��]Bt����V��.4ʙ|ys�����\\D��\\��aC�T��X�zQTq��itZiH�%&�I�	M���,>)E�=�k{�>蒕,I�h\'ʗ��Ei�A�����*��P��i��Kh�9.�\"��U{jJr���#�ʧ�]pgv�A��H�BH�U A�F�%ةc��lx�\0x%m<˰ (�Y��
��>���.��o3jiHY��S�F����!x�i�1g-��D��Pi1<̞���vZ���l��݄��s*\0�~Q�L3����8���Oon�� �e�3��NY�Sbrx���5���X�Z�6��gx-@��I���2��oE��_9����\'�6�$������+	�z/<��M�;�0�\\B��(&D�ULr�蹓~�yߵ��\'�\0���f4?/�z�\'$���+���J��AJ�?�+y_G���c�BYD*מ�KDo�ի��Bƥ<���]V�]1�0�R[$�):��CEn�2��)���*�ƀ�b:��;�9�NR���![�2���WtK�3`	�Ķr\"��kS�W�¡��������)\"+����
y@ f���[#lF����t�G�ts�e��E��GH޼�����9[��N:{�\0��/�M\".ȳ�ȯ�Z��EN2���[0���li\0n&���wн��H���~�vds�Uh�i1�r\0�O*C,��#0���|bɀ��)l|iv���}j�;�j/@t����~�u�PǷ��:���)�\'����I\0�ڊ�)VЋ`4]<鏠a��A;7��4^���H&3i�D�A�j̸����]�\\��ݧ��F��Z�9YHI3$�Ը�hnE���
�{�H*>��wM��[[=O��0�&դ �R�I1�>��~l�et}#ᘾ^(�r-�mKH� �g^�T��;f�T���,��P�	�wҬ^�q�^�>*Ėœ�C\"��k��$��(�q�����mh�����$��hx�-I���<���~�n��4�9J��v�o17
&\0�:��Z����{s7���#�SbX������}>\"�и�\"�C&�%\\�FXEJ�%8�oٞ3�\"�M����&����ASeE�(%DRHRt
vo.��x<��V�w��[|��O�a����\0�a�(�ۖ�s�DQ�}c�by��6z����e.>v.s�]�n�{l)Y�T�\'ϟ0+}Դz�i�Զ�b��Ö�?z���)��9S���/$��-g��Z� Jƃ΂kv�UI{�����L�[�L�����w;�n٩bԨ�\"c΂�lMT�x�(�mրH\0č#�Q�h��S\\g�����<KV�yk�Z�܈��������an�e�JI3�@�Zq��<�\0��EΛ��npt)�����>��*R��a�/Seo�b8ڝ�T����|J �r<��Qq_�\"M�j��-��8�~�`�\\���`$~��x�-E��ǉ�-�p���:m���v����a�D�:yU���{l���t�p���F3���ǚ�|�R��Wl��\0T\0mT���n�Y%�üC��kZ�&��\'���J�U�}W�q]���H8s���S�]%�k��[+ߤ��Q�*X���(���b�_�����I����A��5��Y�G��_�%	(ܠ�
\0�ҮC3��/���!\\3����:�6�)��ZPt�I�ܨ<�)F���=e�
P\0IR���Y
F�{+~�pT�X?�BDʶ�,����aoG��D{Ŵ9U:��ޏ�悋�,G��VR�� Q�EZ4�S�RO�d���Z%7lo�.
��T��Ȗ�C(��,V�ѓ�<�����q�&��K��t��~b�����:k�;F�&tCJ�d�J�bjөH�:��d�N�9Th�-i�l_�ʆ�RrG��w�-�ݡ��#y����$߱k�F�[L�Ұ<�z�O��鴆�tB�\0{\\���c��o}�\'�.�ўݶ�ͨN�u�z�1�&*\'��Q�P{�[���ڐ\0�Y���2��T��;�6A;
C,�j�M��)�M��:��r��>�2���U�=^C��RNc�A�M\\kEX��ޫ)����{��rA��J/��Dm�9��Ί]\0��*A�PC�9�JѻEf$�\"�`Ete�O�5г����ql�X[ϸr��@�\'�iY�qr�-�~4���V���Hx/��{M����o������d�����GG���/�9��x?8�;b�`���pF��´rΓ<�\\�G��m��VU!��c�s��iɳ�><=���.��3�:;,�q�3��w��B��������H�8���Z�d�N�IP�kS���9�P���0��R��-��
�`�H�D�e��t`?$�9���|����j۵�\\�I
\0���h��;�\'7��HV���q��1|m��sjXuj��yjB��>F}j�?#��2�o�d�5��cg�8�+LQ����(6ҜJYY-�r�43��V3y�*Qe����/>���^�8V�\0��,Y�ӷm(��JA ��d������h��~\0��d��XG���s��a�G�6��CU&���`\0<�/$�g��ފ���c&�\0�b��0�p������/��U?�,r�1����Lq�78�L\'`�u���j�OE��J�E�����g�p��:�mT5�=RI%�;�m��ԥ�锥N��
Si�����K�\0<H�,��	3�\"$PS�iz��v��$*e\'��\0Z��t����Ys�>h͋�qA*șLj�嶵���<6T�5���/�����p�J��eK�#M��\0j��d�qQH�ł0�sl�,�x���a�<!��_���e-�N����;��\0`�3��66�F>�?g�>��wv���B��������Yҙ1� ����}#����K�\'���?m�&�8��!���H�M�)Z]x��ĭ9(*�\0� �F�(ǆ���6�@�2��n�CO->  ���L����ܱ�Sk�T\\���_�\"�[�]����\0��~QY��lm�����g��*Qd���.��t�gTJ�d����\\�%��G����_t�k�oe�>��	���纳\'��c/w�@a�)ĥ�CĤ��|����+uv9cB�uHA\\�7��T�V�b\\4�2��!CTϲ$�U��^pOh�qE������ZiWpM�Ke\'�Z<�Ƹy�Ůt9{��޽׎�6ϒ��ᕤ���mQ���>�MY�Y�����\"	{ԵAA9\'��o���L��i���ALAu�+!=RF���:���:�F��=H��.��w��i�MY���9�gtmS\'YB��p�:�X�Ar~�F�L:��`��VN{�Ւ�К��|ɢHoL�;)d�\0Ml��
�>s����:�����d������D�R��7�{ӷX���{dT��M+Y;��N��{�M�-c�Y:�A>���h4ȝv1TdiE4��<n&6�;,��C�ɉ��%��I��q0���K�ѝ�qC.lf�1tf�Qo�Zu&~�������J�E6��{F���\'�s�R�9�T���a�׭��Ǻ�Z�B��}�P�hfIRQ��=O:	���g/�єs�jc���ǽ��c�����+[�]w�!;��0:I�
��:�g��#�y���7�[aĸ@h�5t�.[�2�$L��O	��~+�B^;���C�}��Z|���QX��+����W��V6���Ps��G�8^ٴ��� �$�����{>��7�N,m�o<���Qͯ�%]�-�@~ �M�՜�=w�G�@��iێn��ϲU���0jҔ��G�{$8>j��u���Ba;�W̗��_%:H\'}�]�J�I*X IG�r�����C��-��␄�@\\\0�@j9e)[lS��H�x�plN�M� �Z�_�|�wv�}kW8����\\����]�ʓkj����@0I���\0?�йC�����	��1w��R���ML �{����?���-�%Ŗ�w�RW�D��!Y�2ܮ�i��(�ESr�����+R�\"tҡt˶����G���e\0��e#ڍ:�J�*n�X_�:�y�p�\0R|>��)N�G8�R!�B��^|ʑf���ՑŰ�\\D �zT�[Қi�z��)JGx�������\'���ԯ�!��X���|�s!Cz��O�Q�<��+>!��-_-�9�j�`@mE+Q;e˯�����Ik�4�M�\0�\'	c|u��\0C�˻�&��U�e�V�r\"��-j�/3.\'R���>�4\\���M�}��^�q+�N&i�.P�]K�)�PA�\0f^���\"\"���8���\0���de5M��D�Vτqk[��U�����n���S�.`���i�^�L���ZQ�_������u����ɻ��&2��su�}*��&��yx��%(�\0�!޲��)2[J��L����FT~����<W�����D���DW��n�{�.E��8Z��J�4�ȑ5F閩%l�/u�iHI�bvTP���:��#Wpn�ТVH
JF���Irl���~ۼ
d�StN�.��3F�G��P��X��P�Y:L�N߭{�m�6�|���q��_\\�Z���q�V�d�f���߹FF�q{�e9��K,c�2�0d��	�]�*I2��%i�V#$�r��BJ�u�D-��f���i]l�^�����h��؀T�3Mtv�	׭&4ز���}���u&u�j�b�f���WQ-WbKV�:Q��]�%2�6>t]�z���y���_�����j8��q������w�:���C��ȫ��:V�Z2�[\"��G�j��H�c���Ǩ��B�\0+�u����Lm���ȿj��r�ګ��izG(Li�����[�X���Act�\0bZ�`�Z�2�݃�j�:t�O��U/�ƗI��Z��t�M�����`�1�ױrJ*�8��O#Φ]
O����hal���Gv��;�43��sq
3��f�:\"N�G���|>�/�X��I	�H	� ��U���K�}[��|��Ɲ�p��~�Y�A	[�A �	��\'ʃ|���1�H+���|�Sj!��@�@2fw�6��Bn0��	����\0���	2KA!GC<�=k�drm�E���/��R�\\����W��.{m����>�I&O5�D�5�+���s��	p\\)��h�F���*C�[0Z��SD�c.�*s�j�?*zt$����_���\0\\���I-�z��6��\0��`�]4�iL���B�7���ߥ#=�t�G�L�IGk�\'��)�]\'Jw?.rgʕ�;]���G/hˠ�Ҥ�N��s䶎xxJ��Lm%kB΃���C~��RqH���,ܕ�0\"H�N�Ɗʹ��(k�\0���V�^��Q3Y2��g:sF���Izn�_R�2�����h�\0�2_�2�I#�<<+pI\'��2.�FO���]�J�<D�=7�M��mF3�5�]�&\\��H��rE<�9�]�l���Ҵ)�I�:u���5g���<rj��V6�`��@-�GX�Oޭ9c�mm��匪J��p�qen��e��%l�V�zƇ���t�h���ӻ��������B�p:����<����N�_������}n��υ0���P�\0�w��ͫ#��=����n\0R�ĨD\0��O��J=!���٭m����X���B�)m�J��0��)��[Sj	�����h׸r��+��P����;Ț�$���+h�cxc]��K�Fh�ΐ�캯��-bZJ�ZT��I�i��\'R�+$5vyg�;d\\yY�\'E��D�
��^��������;*��RFp�T\']�ֶ�i[<�\"��Y]��/�$�b�\"݆�Vڕ��\0��ʼ�\0��EQ����\\����d��~���S�WŸK)e���m!=�O�)�U~�eœ���Y��#�G�����1G�H+׺<Ĥ\0w�i���+���&�w���>-|�*E��� ��t�E��G7��GVγnzTW؅�j N���0�ٵ��\":�VЁQT��������O=GZ\"��R���/�W��of��G�\'q�⼺����|ʲ��q5��տhO�JDI�<��M#����N�z�3ht����ti+�Ĝ�P����փ �{t�V�|j��m��pQj��-%�;����-�M��b<&D��_�#ؔ�V$�+KF^wriW���Y�)��CK�J�gʛ�y&c�=֒H��]�j�8�W����Mh���B�\'�49.�m�f��ͫJ��H+�y�]j��쿱�m�:Įk.�z2r�\0��1�H���M7���C�Ҹ�~ݫ@��b���0)ȟ�>e�rm�͊0�c��K������4��:��?�����>*NM�өdeJU�̣��j��Iv{8��6CN�����F})\\7H�
}�%�7�)!ⓘ��F�q,9�A4�N4��JTu;ӾZ�=1eaiBs��J5�-!�m�8�í�j�J��Y���P�s�))-��Ke��s��x�\0�7i.��m�)dx����Ҡ!4�����h|:{Ȓ��JOA�Hpwd|�����x�����	���y�p}�!�ٕ�b�u���f��*�5�[�֮b�$\"`��=�d�H^�W6Y1����O{:�����g7IˢOy������<��1��D�}���RQ�V�L�8�)IG��-�?�i��Ǒ�.�	ZH!Z���1kܯۦN���i.���\0��X�\\tc�VI9��J�;�gok:�r۬7�J��7��PA拚�8~��^.4�BF��|(������Mo�sxґ�d��*��!����a/��ݨ�
�#���mT�^JԄ���mH��b�����=�*�����6�\0HRB�O$<V�Z�mL宔{G(5�խ��(H�����@��%�t8�t���]gʦ�K�N��(�\0|��J����=4?�h���>6�N�g(J� A���Z�����*v燩�Y�V�%i�h�J�?k����etʂ�]݆�d���Y���yʣ��x��L�+�������K�m�;�ڸu�Ftf���ޱ29Jg�|,P��R�\0�j���}�\\��ө
���mIj��	&�)��D:�Q�:�q$e9��n��Z��w���\0,8NP}� D��}u��By_g4�A�(���V�\0�i��bR	��d���\0�\'z[��h�Ӧ�*P:A�|��&ͧ@G*�_���K��PK����\0\0��#٘�^\'ʿ���|5pD��8��\00�W��G�%m:\"k�\'y�$d\\_�D�bt�+M�]u����OZB�~�Պa�F��P�]醭�S��Td߱�m��O�|�5Y��R�t�M-���B��	;z�.�ɧ�=�(��yV�>�l��P���i��~ڱ�³9�yS�М��Vc������3�m�|��O�#B�e3\0(`��zhZ�{�\\����9
|\0ƙKbd�U�_g�Q��/d��8�.��H��\04�O*W=�q�\0A��!�fy��/��^:xg%���$�:�9��pRZ<��s~��j=.�Ap�\'���{�%GS˭byR�L��8cT�[�Kn���H�ΉK��=5���q7�BBH;ΦI;,:�w�I����eh	3}(R���5J�>�9ITtO��i�Gi:���
J�V����PoC�H�K�Ͷ���RҢ�A�5�j~[�u�K�a<�h��\00J�婧G�vW��M��>��ל���9H� �5�oLǁ�2���AcM{���mQh���RQmGP�J9��\\�����i2��,�jm�@�������E8p�^�7eQ�X?�^�NE-A�Q�H�ii��[�K�xta6�JC�@�ژ�M:���q�Ǣq��%IBo���B�$o�Ӕ�U�g��AGm.��^\\��Ѕ	#�)��(�!������P�A
R?1ԟ��	¶lb��z 7n�RV)\\	�t�&��rj�L���B�mE!^-hyF��yZl�p���>����̭\0�j�3*�1s���>�؟%�RZ��Pps��U���
�?��ޟ��`��V���T9�Ia���sm�����b2��Gv���_}W�\'��U/p�NgI^~q�=gz���٣�Ce4!$Lm$A�x�{+[u�ֵ&BiOm�o��v�@�YO�����JN{H��Nn���hoJ��]��X.�[FS�Q����ɧ��-���I
l\0B6!\\�b���SiR�c��ehD�sǝ9*zةi��o�L7#u�ed2Z�>�<o�!q�U����Ÿыf���aK�!Q9��_q��*\\``|�]���g�p��4�-�������X1����!�Ǣj� �\\j��V����DRҒܙm�1���ۍpg8�1|9�
��q��Z*7�i��e�/t|+�>?�<�������ҮS0�)�LhJ%-$$�JO_Z$C^�( N�L�بp ���&4хR4ەA��$A*�4î�H�w�d1k@�p	�
},$ݣ�\\|6	\'Q�5���\0����/��+�+�rA����NV������E�TG����5��2���9t���ykJ]�v�\'��x�<�2�n�j�L|j��iB����u�m�������#�M-�����݃��ڢ=���l�b�>���х�r{lf܉$zoOt��-��U�ӬoN�B�}����]�*�2�>-�r�z�az:���ǝD:&m�$8�I��O3K�\\�F.+�p@�RL�#�0M|U�\0��v���v5b�g��D΂�����^sɟ,�3�_���f9%o�HavS�)�|��\0��I�?�X�4�gͼ�W���\0��+���P�h�I5��r�=/���e�-\"�`�]pBu�D{QB��5�4�Qe�
	Q��?sU跉[�L0�\'�e���7>����{z|��r��D�r��1Bݰ��aL�wt�`��I<��<o����P�������%M!\'t��5c�l���
�
9�Z�l���O��Ru\'�������q�2JN���bn`�=��E�V%D���\0ګ�����PY����C����K9�pzI�9�*��
R�+�kT��uRTs)J�k+�����+J��v �x�)�!\'D� �fo~�L�,���9]���ƕ�w�2�T�X�1�Z��v�-	ʑf4֞���_�8?Lo�X��(��/4���	�(A�?ZvH�*x��,�U_ԫ8��NXA3v���O��a��VZ��\\u�)0e[�VC�>&����I� �\'T���wl}��fz8kiҵu��<��N�?�2������pa�d�i��\0���~�t�B��V�䟌���a��T���e
j8\'��*é�SƽN���y��,���>�������{��Db��T���O�5S�Y��mcɤ}���%&svU!�h����cn�3a̹9��]^�3�:��3<�ү�	�j�5��5r�n�0e:yEE_��J �ǒ�a
�D�$�����7���Q�m<CI�4�\'d�%�B1G�*T\\*����E�*r����핥���ep��-(������[~��4y��O�����w�� w�$T�@�.�oyq��?�)3�|E­a�M_2�@����ʼ���G��>2[{,\\-�7h��()�� ��םZ�Wj��z���O�{��)*Q�t����u�U��\0V���9_�rڗ=\'���崎A�����0�F�6Fݚ؝t�D�&7�Gdm��AҦ��Ѓ��Rsf�\04Pw�����)˨U+/��=!�@3Ã���z׋ʿ�v{o<q�+>\'XU㺍i��䨲6I*\"z�W��Z�<�9��+I���=9$��J�cd�T���g�Z��w��=j|@o�MgLև}�4��M�UE��bͣŵa��.{�s5��+��K����k[H��dީQ;oVR�c7�K���O�T/$��������]:JUf�*� ��D�O�e�=�I}k�U�rnUcƌ1�)��U�;BT���@%@I�S��]��{��Yj��4TS�H�>^��yk�7G�����$TLܶ���H�8�0ʈ���*1���p����|�ʒ���+�c�X+��t��jr�ӟ8ޱ�W\'G���vKE���m�[�� 
��)_�Kq�JtݒnSז�w
N@���X��_�TI\"�7$�t:�NRF_d�R�Qȑڽ��
J|J�ʟ���)�J[g�m%dBN����V�W?3m�o�������fB�Џd����Q�)�Y�Fq�(X[��$i���
��#^�/qR쎰���^�	I2K�К����;$�+�ӱ��K$�¼J�	I�M�\'��v�Ŷ�N_)@��%JQ�\0�Xm���vV�ݽ��qc����J�5�y`���+B>/(���G�,R�\02E���Y�k���8SN�[}$h���G�t[ǩ\"�G$T�J��E�>�[��Ȁ\'M|��c����Ě�·�TlD�Q���2ˡX�z����j�	Q�Z��5f�.���O�5~�t�,��Q\0�|ꤠ�цN+O���n4®-Gqp�\'IJ���E�{��6ȟ�5�����;�>�NS���R�^ֆ<��Mh�Qyp͓9�@\0f��=9mW��FD#B�b�]�C��$�q;�BnN��~4����
��a-:�[���e�w�ǩ��k��y��\0�˜V���;�m�ܶ����I��&��iX3��_��\0o��r�\\ \'�ϡ��<T��k�R��l�Rd@\"#Z�(���}��.m�$~h;�j��֗`�����V�~U	$윛�>��:�[T��t5˰�E*_8���F��⁥Љ:W�7t�f�Y�*`��ܙPv�w8��A��3�<��j�Ѧ`y���Ǳ\\�v����Je���J��\"kg,�/�a|6�)�I�~���E>�T�3-*�#�c���\0˴����J9�8������Z��!MD�\"��r�3$sW��m۝�.;T�E7!�x�Y޽��c�ƍ��\0?�\0��K�W��ֹ�����\0mk�h�+�G�B��tuoJ��©���u��ўfjW��N�bO�q�fOX���+dF���p�$z?%6��&u�5s����i�U�D��w^u��R2��.D|νF�x͒����t2ZґJ+v�<�@��������L_��~�N��v�2�\'�Y�f�;�A��T[5i�އ	D�7��I����:��F�^KkdB�T��l���srv��@ט�6&�epeѭ:=
Ȓtm��u������ݐ�*4�҇ x�=�� �<�LZgdV����C#��U�e��(D+�V�`S�����z����1�Z{�CJ� �uH\0�~�<�8�gݾ�9��u��ï��/j�R$#2O�S������QM*�g�<�T�R����q�8�VP�\'��k&J�#�x-�\'��Svm�2� �\"U��̈́�A�p�����|��/H��J�\'xU��O��W�|�S��a�L����]2��a�G��Jl6���#Ra�?�\0��\0�9T|��gǱyp�Ŵo�6ֲ��RT��ϩ�Y&�\0a0q�M0t��� f�Sʨ5��Z�n+�>�m��ä�#���C����W�ۗ*!<a�b���!��{��1��iqW=�R>�v�E�c��*���4�.�n��S� �n	�*ք$�G��8m�^�.�o�LqFQo�$VR�c|���P�E;]�������#������H��]����$�D�?�U��\"�-�sYx�/�����V�xS7\\/L�/E%\\��������řr����m�x;�2n%�(J�hR��2r�5ɞu��c���/���������0R��gz�8�+3^\\�|���d����xzYF)�x����T-��P;�
��n�3J��>6=�6��8�`��S��Z�JW߫�Ӫ��ʫz��/[����,n�{8z���K�mwRͪCR��+����I!�#���]�6�{i)H*n3&O�ށ.^������M�)r
U=yK�r��\'=2W�X�\0z�ZsH�J�Mic���Ǩ�&M��\\���J�V�2ϩ���JJ�Ȍ��p*���T�I�:�Z���AC�[>Ӎ[B���G��5Y�q-)���7	u�3(h����}*����&RR�@w_/�BJ�:	�IrDKI�y*qA^�t;�7ж�`\\Agk���F�W8��v�d��yN%cDƺE��O4�襻J�ۋ�nZ.\'#iA j#7�4�|�v�;����?��\0��HM��S ���#�Q�ʴ&ۃ�;�JT����|��wc�cpK	iy�%&�˟��<����}Bx��[���Ş�J�љ� ��2k:��|��3��\0iwf󍱧���8��A�Q�W�<���������?�sI}Ȳ�:D�δ�:��&H\'A\\JF�����cPg�κ�FuH�W��䄍��+�&��d��r�荙�ACA$���\0\'`�R|���5�G���6�H�׌�|�{lI,Jʟ�W7Nj����gFG���S��j�B�	�����$R�����\02��.=�%[a�\0;������{Y�XV՟3SWl6�%1�֨3V+�V�BcA�JO����\0,���8��Yk�W�!�����ہ�3��$6m����i���=��Ԟ�@�Ξ�ؙ�v�wr@Bd�avt�Iof���1�*�Շ���j�9\\�����2d<H=Ё�v�I��V\"�X3L�e���,}��>%jӒ�hqB7?\"G�V?���D�\'���e��]k\0�t����TA�ԑ�>�V]%�<�X�;ze��v&�)d�B�-�LjH�#�Y>D8I�z���<�b�
CEMۭ()\'bG!�&��o�7S�>�J�;���r�]}�Ρ�����ÂR���ڂ���6�D����H��0ꦧ�,%���]	a
r˾��y֊s��AFI��y��%y�)� ��R\'4Ȕ�L�����O)�6���
RG8ڛ����M��F1�3e�{��.R�$\"�V�6$��H��ع�+eQż^���lI�;�=��$e
<Ӯ��w���Zl�d`���Ek��l�\\�����9P�P|C1M>uA�z0��0�Ӣ9�X;����4���� �#7�R=�3֭ˌcF*r�;�
9�,�l�&�J6�k;�&d�@x�I�$���W�NHG���{(�ű5+�1�{�K+$u\'Q�~T����Ԯ.��]�cXK�cIZ���6���\'����J����3I��Mxww�/�`XNE�n!#r�(멘�$�NV��^L��r�|��q���o8��,(<�[:�\0��I�F隹|�$�G�C�ѭ�kܴԔ8Lw�j\0��L� �w-��&�G;i��VwI�v�@Wt�C��%fy	�`�����W���N�^���X���qiX	&TdI�>�_���\'���X��qe6��Ca��S\'$f��	\\z\"k�`����d$�]u��\\ѭ,��,���dR��%AGO@iG%�9�wr�n[����S:zT�n�X�?K��w�tC�cʪI����S�O�Bs��\0��Ii5�P|]�B�[a��H��t��B����2���H��mB�L��$G/����@C�\'�Y�n)���[�>_Ȳ�d	�X�^t�-�����<�-ۄ���J�n\"4�u;�[�#�[̔mhö7_�,�pB�e�䥐\\��ŧ�:N����.9a$��=�\0���v}�m�5p���Kh�̑�|$�W�v���QÒ~\\�j����]�)t��`���H?M;>SQ^�\'2Îy���ϙw���^t�L�_G�j)����;,��ƊI$���M�w�P9I�56�ё�jI�A]�A���#~�����TY��ٚN�k�i�m\"$AҸ��΂v�H��~���������5[�u���
欿��ԧ���#O�#��N0�T���r�«kFN���>>`��o�1��#m���F~5zb����7Ӑ����\'��:�R;mΕ���=ڰ��a�b��=�b������:�k�@�&zPK�}���E���E���҅=˸9��ζ�y��ݥ�M�)\'�1֍��+c7��y�:5Bd�+F�S��O*��7�o��$�Xֻ#\'�v�^\0�\"#}��WG�I7��Z��*�,�/P��k#�*cb\"�o�[]�\\%�|[Z�M�4Q����β��F�e�L����.Y\\��dwK�N��?����8��L+M\"��V��m�*9����>�߭V�]�/�?�[/u��m��jQqm�VD��`>����ݶ孝^�;i�{�2� $y�[�{�>�B��Լ��hΔ��~Mh]h�Xۇ\\)�$��R*-\'�i��<h��kl�˻Ő�5Q����O!NR��U��h�m�f�ɼ-h*l+�Bf<P9�I��3>Y[���#���l���˪��h)\"ݙJ[ˢN�fbDj*���q�9�3�JM�z�ۯZ!��K��ְ�N�k���A�o��lͪ����1���p��wAQ�p╕$7���M\\�|l��#z�Я�=�b�6v�Y<]�q#*��$j4H i�䚳9��)G�q�$XF{�>��.���ˋF�)C�(�%{N���U&9�W.�?��|�����^%����ieN�ڇհ+V��H󢌓�9qN+Q�?��/1�ˆ�F/p�v��:4%%KA�$BR9#�^��I�f�{��ָ&���ںB�->�(�>!ݡ�
��jd���r���\0\"��v�\0���JpK�Q���a��m-�����Ɠ�Ij���&�;9�1l}�`n0��wn�w,��*%�T�5�!4$!����*�\'�vX�/�P:�@V�_7�X���T�RXu&Q����J/bTwt��\'�[c�Gs�V�:�&�;9;��)6�C��^uG2ofϏ��ŭ��~ӛ��{	�ei�B�{��Ho�
��z{꼱�z�-����N�W�J�w
j��S�.�V�ȑ����:z����56�u�
�b�R����]��<��\"����a�FD�m����ُxr�V�ww�͝J�ϑ_�+�|d�^�X古?}�8�A.ɘ������b�7iK@J�ʡ�Q�\'��,㸱����=�9�*$%��y5�;������1��m[RZBʕ)��SӤ5�J�\08�H�e^\"����\0z�,�iE�R\\C���?n�\0�ʢ��e
�:s�����F6yI��n��]c=�)W�����t��[Q�H��۔��
4��/�Y�ey.It�H��]=iy�aH���Yrc��;=��p�}p/�֫��5�	O ?jJ{>��O莏?��x���]�jr-��:�������+.^~���\0��5������x�P���M{.��X��;l(��!�f�4�u$V�a:�\0�Ҹ��ͬm]��frę�����ĝ>&�����Y�؟:M�n�a^`Q�]>5[ȗ����E�~��@�G�]u�0�r�z��$Tؓ�p���[Xפ��%��2#7Bi�Uj�րL��Q��	l���^*��҆)އXp�&f��Cq/�6H0�J���nC[
i �&�t�TM5oh]�1��ն6��Kk�3�\'�qqӲu�+s�*ځ�3/{l��Ȏ[QK�a!��\0��\'��֐�n[7vr�� }D6Ν#�(\'bL�FN��$�VJ�M�#��]��M�F��VY�K�B(�[s�mL}���\0B��]�\\bW��i-�#Us:�_��@��W�R����1v���r� �y�JI#�|[ǅ[D�����n�ݤ�\0����eJ˲A�2u��S����������HqiiP�1������+&K��#T�	q^�ix[D6ZG�;��+JN�y�C�����+N���Oܶ��f\0P����^�D�J٧��\\Z��oa#��Hm*e:�:Rz���{�d�<~����p��hm�gPcM�����F*M�P�9�q+[U����p������Ԡ�Y�A��\0�$���ro�u�gBVې3�xx��/��S6�d:��dxB`\0%zh4GZ��}�9�@Na��m���ݦXIm�<(�$��h�A�:uhI�v�}�g����ٻJ�D��\\x��<�Җ��]��\"3i�Xx^��춗=ոi-��}���	򣒔��X�d֐�A�-q�`J�3Ov�mP�vk����6��pE��.�����K{���(��?
opaxwK6�!�gr���)��{�rbȵ,j�*�j�m-ƃEeKB�\"`�
l����NR��7�$4��)� 4X�1>�ZJ�v�s�yR�G`\\{�l1\\�>��V����l\0�Jd�%Q�m�K��W���������i�j�̌)n ���f�,�i��O�(��R��a�p/�����}��+FP�
�w�R��Mgt�B\'	B�lG��sx�xnQn�n쀣$�ڔ7�ì��\0�W7ԴHp�2�E��][�!�HPi*(�#ìƭɣZ�mQe����3�\'Cv8�*�\'ƒL�7�)��TU�Y�J7�Nogwcev�Z�vݥ�9�H 6�ҩgI=vY�r��_��?hV��\\#�r\"�J�Zf�<�z����AQP#UL�n��v\0��#\"���$�^⥶pŻ�v���.�eZ�#�����cRj��N��N�y���Ҕ���r��a�!ҕ�T�\'��EW��1=��3�me�r��P*�N����MS2|�o�Z)�gZ��J�D� �� ����[Q���y|�\\\'�Y?g�	x�>�ۨk8J���m���\'�r�-b�=���YI?&J�߷��%�#
�Ҩ+VX%&����\\�zOy�r�c��ڣ��v��%*C-�)2diӕ{��ư�}ύ��<�g�H)E$��ס�����̀#�DG��)\'��ʥLܒ�V�u�������#J�ȺT�d
��f���\\O������vN��R����k�J�a�t��7:AkΩyQ�h��o�6\\x��p�$�2��^m%��Rk墪�PS�c�޶���3m�@�Q������(Άy���$gƑ���L�U��۱����1�}�\'>��Y�:5p6�m�_�TkF�j�����S҆�6���W�9mM¶+�k����~u��d�3��M��ʦZd�E�44Q�pw\'��S�B�ҕ#���̣��D�{�v�\'mg�D�ƒvkE]O�Q��c�4H�^%�Iq�����W�ރ�6��M_1�#\\�0A�j�\\��,9�5�ŵ��&��SW(u?{��L)a%*繓�?\"X_V�簗İ��k�?{�mn���d�)Bƨu��AH�5����I�/c�|�a�]u��:��BNX6-d��Tr&ꍼi�VXV��W�k�C��}t�{m�3��J\0�\0�����A���b?ٞ����|ˉv�҄����\"5��%T�XT�^��Ú&�
ek%0�o��Av�m��ʗ�8;�����M��}˅�}�BP�!;3�s�KMA8�%5$����х��V��4�r����ΏA2�F�S>��I�m����[qU�\".ۖ7WxcY3)��J��\'/!���Vq��g,n���;_��/���^�q)ʥ8�B@�\'���ո�򟽢c�c��\01q�v�q��]�$�	I�����}�L>V7��=�q�T��έTJ�27JL���ly���&c���m	M�`�ec);u��Z]tl��
���-$!Ը�N�P1��VY���Y�u�jp��(8��s���x�-����.Z��)Ru�;�I����c#Ƣ��׈B���J��*��ngJ��������`p�6���a*�6�J]�J�C�?�ۻgԳ%	�\"���
]<�8^4��U����ٙK�Vqҕ��-���1��{8�6�q�������+*�d�μ�>�Kqq�͜#�K�n��\\^�l�����m��\0!��̟uK�ٗ�*]./)�K�5OSM�W*mD)H�}�&9�YǓ�}%�S/�\0)�N�Mҏ�ܶmƁ�I��1�;ϐ�s��f�\'V�[]5���\\/0V{�Ta}���]��j^;Q�h7���:um�lT�����m{���\'-���iKB���ǋ]w�}�n�WBe���.�g,��C�P���&*6������[fۺB-�u�P:fL�0cM�zQ�����[���a�[:RR�0
IJ�����\00?���ŋ�*����{���\\eȐ�)��0c�y�*�_�g�nIh�q��i�/:T�%#U�@�5�����̼~�r��죂]���Z��eIZy�����O.O�.Ϭ��Ǉ���E��q}��8P���c�\'{E��4��ϛ=����x��l���H�@�}���_�~{�\0y���N/VAcH�<�kg}#bt�]`]�h�LN�#��gox��\0m:�/�f_��p6s3�_:���F�&��`������V(�ӯ=j���<w�b-�!1�%:�O�^v�z��E}���N{��z0��4&�N�jc�>�- 31�v*�K�v����j���Z,�2D	��&���pM�!6��y�Ud�#B0�7�a\\�eI�j���.�m����A�A����9����$E7)��)���Dz�,�%5�
22)����Rղ1ҍ�Cjq����y$�J�+�;�mIH��:ED��4�F�� �zj*e�8��Λ^g�>^����%���Q\"�X��bN`G�4�*)7���\0�˥*+�3,��Cf�-<>�J���Eʞ˧�na)|6�Hm �V���`yQNu�{_���.����/�G|�5h����O]+3*�$zlM:��m����oݝ-�k.>�\0p���IRI�\'M���j1wc2��D�p�8��qK[d\'�y��ĩE`�a#SΊ0NL|��A��ܦ��+�w�	�ԝ��<�qiK}�Y-Ɨ�ߊ�.1�?��0��\\[�N���Q�S$��*��)?����l��p�\0�ww����\'U+)�$��0!#��з{^�\'�m���n[~��fl~r3$u:o��%+~�)�D��ǳ��/�n�\0������2��s*��4�6n�\"���;�9j���A�Ap%6P��@
O/8�T�V�ͼKؕaH�`)ƒ��3\0I;�ӿ,�\\X����3$�W(���-�L��P����p�j
(C�|Y@?�C�X�K�^˃�V�(�8� +1TO҉I-���
�(8#�m!�E���V�PJIl*O��ϰ�%,��YI���%NIݏ������#�ɷR~2��+1A�Y�w\"���TGx��q|<e��*����0�J��E�\'��)�0fOp�a�U�	
e��k����ҎYq3^6v��H��wb��o��Xi�.�i�=��SɕU$U~/S��X�Z�W��J�}������T�Ԥ��cA�H�)���r�M\'e���a�Zb�,��6�!��:Iԓ�������\\V��F���[mZJT������^�X��y7���y-��PD�w�J��l�qe��֎.հ�rV���=��\0ϜE��W{k`l#�şi�j�����r�vO�@qT*��<��q�owb�k����-�Jy�|�\"�4���E?��1�)��(Jm�s�%>%r�ޜ��{���%�h�8����!j!RC�HCm�y��7�*N*/��l	�|W�p�����a9^d��0�\0z��ǔ��
~�qx�Z�j�\0�=q��8�Y�Y��&A�Te�䯤����á�j��R�����,��pˮxӕ˸)s	���|9)sȫ�yO��\0�T������<ܦV�-JԨ�N�z>It|�\\���l����LsL�An-���\0�Jjض�Ƴ��$���D��J���͔�k�[2 jL�U��N�\0 �����u\0�z���I��ϊuP�>�ߌ�e��K�a�i	�X�����7ǲ�u9�c*��ŕ]5bW �QGl	4��l���\0�좫�`f��R娆���cb�P��zV&F܏W�b�ac���N]ʓl��{�ie\'�ÝCl���t@����q���D�ޣ��P�S�a�]����_�)%l�ώ2�F�e*@1sҁ�L�x
�g��f�x�~[z���^�T=\'��G�q^_l�	#��~k`G�i���ȑ�T~�%��b,�*cΝ�����~�m>���J4Ӑ�E�V`M8J�����t鱍���gV�]�4
3�9SD%rVZ�=��m��R����7W���W�ɎJV{-c���zo�N#M��͸�9��R4�H\0���Y�b�G��.}Kx���w�w_�B�hV�����j��)�i��f��U�Wͩ�YiPT���\'R&N���O�1N+\'&�^\\-��R.�XIp(@R������(��KO<?�9�|V������ؾm��H2R#1+�Ṡ�)J��#�o�4���-;��ZRZ*BeJ\\��\0]I�)	��HV�Աn�t%2R��/^����=���U�\0 C�ȺQ9A�H�t�?b\\^=1�,�ܥ	%B�rW�ՖQ!j��(�YR�h4�k�����9c����Jn�jB��a��ޟ�v���e{���8e���KA2I;����&���aq�i����ݶl\'!Ke@�I�=Ew\"����0f���9j�g�PT��cM}�D��h\\g���9/��\0\0+�mn\\��u�&F�G�U�%H��9J*R�_�h8u۴2k8JLN�T����������p��^T\0&LM��~|�=�=�M��Z��o:[[����oc��X�p��@Nīs�*Nٟ��r%WV���ZZFu�R�5\"b��c:W7d[��S���F(�����,���+\"����q���y^��W�qxs�!��ꋎ>���+3J\0�5\0k��(�	I����C\"ƛ}�bj�cB{����M��2t�H��Oj��{���֓�\"���\0Nmo����w\'�Y�=�y���\0c�OD�߼�S�QBRC�c*R���k�z���P�|B���Ú��gLҕxp(��U��%��q�/-Eԥŀ��� O_ڹ(����x�I���iKNe(��eYFS=D��Ν<���n�K�V\\f��R�,�)�sd{�h�.���͑U�\"��Z�*���5���y>d�3C/��
�m����)���4a�R5iS�����s��^р�z��9i]It�NK���!�iR�\\�������*�T*�bf@�<�T�������5}���-��s3��gr$i܉�ݍ�Hl��#�)�`�;�L@:l>tDwٱ��z:�+�&���U��7�E�T�X\\`��p#@<Q5������0K�͙Zst�Z�Wf�N��o$������2���ki�GZ���I.#�4p��iS~��✺&����|+N�z�J��#����-��I ��B_�:\"N�Б�ݚQ�\0VSDs�Հ�Q�����Y/��n���ͼrפ/f�u��5VM����Ŏ�	A�ϭ?��)��\"����=h�R�F���S�qDI���8���Z����QSȒ㲲�p��c_uz�kҏ�I�4�rG��i~Jv��iЍtm]�G%����Y�i/8���1PG��\'J��%�^��V�z=)��?l��*R�d�)J���Ǭ	�9���(�^>u4�[��+�����Gyި���*�FRt�}|�뉱���Ŧ85V�8�iךh���Cl#R�I�S���ӓ�5\'/���?�����n�%+�iJ��#�L���rf�>+��8�\\���Z���\\d���%aCU\0A��HQ�*T�\'B�\\��w:�#�2��C��C��F�Zzf|���/㒋�$X�F��
%9@�=irv�񒋸���},r����-7�s��=�ePjL)}�:�����r�_���X>��m?pNe-j �\'���)�B�ڥ�+�L���v�;�]F��A����^�6XF�\"���\'�d]��\'��T�y\'Θ�{����%Nл\\d�V�	}��EI-�I�$�A����h/9Ǹص�;���<��Ã H-�LƤt֗�T����A�ci����Đ��#�`	#�@h~BJ��d��\\����ޱ}��W�9�
��?1���ƒ)<�%ث�p���Z%���Gv9f�-�w�)���*�rn���iU�\\#*��\0��YP�L5of��#��B����\'��`�9Ðp�8�Qݯ+.�wB\'Ry�y
l�����݅\\}v��cD[��/\\� e�ՠ|��N�Sr{k�`�{8~\"�T
*x%������I����4S�a������م�l��V��qD��9�SˤNI|�ř�7L_\\\\\\%^[mwn+ed ��\0�TJ.�2985]�`؂��g	C�>6�Q ��B��Y:��
<��@^!�n�,oѝ�2(���@V�	�\0��S#������6�>��|��^u&=�S��*��/��7�@�{��1n�����nU\0���5��k[%(����OZ������[)JYS�i��
��ǡ��E�)��{\'6?e�����Y��-㟳+�͌���O���8�3n��\0ԕo�r�!���-��{��\0�\\�=x�Q	LªǍ�R�H����̪1<��B2��^�P��@W�+��W�Ey��5#��J���m�(5��$�d�hﳴ�R�Ң���O���L�ƪО��-�ͣ_޹��ɟ�ou�$VG���gN��9 \'�
�­��� �p�$�t�X��\0b���N�R�A����}�D�r����\\�T����*.uTM-������=f7I\'�R�,߸��A�:�mhߞ��RG3R�t�#�+�\0�H\'�֔~����o�H�*	紉��hلm&�T�SI���b�Kggr�}g��ϡ䷪uڬd����<�S$�����
�+2*��{�kC-��0�v��x��[�X1&���rL���P�Eov�S�:I���1�,�{BI\0��M�EW�d@#��u=�$��6w=˛\'�C(ކFU��W�\\a��f�r��D��}|�\'���n��������Uup-�)Si*ʰvZ�����ǒMi�����MXQ�%]��s���X(
q`��QVP\0���E6��7�d�#˫�C�,���[M�M<�l�;�9��8=je%9&�x�ww�E�����b�*�%cb��O�1���;m=0��2G��Z��U��h�}ȅ��\0$ƅD��EW��F�a\'$�Nn]J�mg�3�=)/]��˖����[
v��#U&G:����#:u.�vv�}���I�ǭ:?a9��0ubX�jTK*m��!9��\"�ޝ���5J�?b|#}��i�a��ˮ�[P<���ɝ<鸦��:x�\\�-�o�ZbxB��0���d���i+\0kd��jUVc���\"��ME�k�i��7l�O�Y?l�q��RW
H$k:s�&�8�?�.P���� �2.���+�t��e�SE9���=���|�����4�v�:��-���W�k2��4��
V�G0*�͛������]�G�0�8f*�UpCe��YL�;H�O�ږ�IqWj�Vf�.��RNq��ʺ�VȂ��*�4`Si ��oUd�R.�T��S	B.�]leP����բ�K���֮3�~S�8܊y*	4C1�7�o�Y���í��BB��fߦ��ƙ��)N��Ӌ8�M���\\�m��%:eSa*�F\"B��R*�M�bq�\\U{��.C���ej{(��$!*H
W���Ij��f�*�@�E����w�Sv+���cU�@O��?��c�>�f\\��H�\0]��D<�wn��HH9FB�ysj�����VZ��	il��-[��T]p��&?�*�[�JuOاx�W��i���%�HP�	>���i�*e���b�_@B3�
)\0iĊфZ�[0�MAl��x��ta.f:���Q��Ҷ�G�I�x�*\\��h���ψ�,e��S��\'ZO�\'��ğ���3��$E%����mXcKAʙ�T��|J�O���\0g����[Q�A�j��c�����F�z�hr?Q��I���Jv����E�-ٴ�|�ɨ&�w�!&L���%:��t�v���$GZ1N��tu�Q�y4r7��\"�f�]�j�:vL�C�LF��+�[١�IY#⋏d�4��Tp�f�gj�ћ�.�$�?�i��Uэ+N�w�*�C����M��R U�	��r\0�cQ�\'7�X���MX�\0���.�_�>���\0�֔�W��{��T��l\0���--	\\8Bu�9Q�lM��q�Hk��֪�c<��^T�~��F�ֱr���b��%V�p��3��䭣AEK�!up�(QZ@Ә?�oL�ǺbIt$l:�J�cB���� u�U��*��O��(A&z
��1{���C+o�dUrU�ٍty�/��h6:k�hr�é\0�<�V��iTj	��`�]��͠�Т��-J�ْ	���<��#G��Kke��<l�XR�/-y�Rc\\������X���x��J��W��|�ŢV��}x��$e\'�\'�*���>d�M+�����[�.r8�nS�R��5��3�UI$�����S�u!ۀ����Nh	0<����b�)sH��M\'!^�+�:���J���-$���W�R	�$���ő��i݆\'ix�ͻ�zIY
-(�n���T��f��O���ia@�6R�촟-Q�wn)
�J�Y~U+�ھ��)�\0��B\\0��kʞ�S��@(��j�BCi1�<�?�Ǯ��Q:Ol�r��\0-�WX���0ݫm���2�e)�g:F��̚%�/Z:ppJ����\0��}����qn��{�0��\0�!3��y��t�N4�b�;��{KEX�%I���ԗ֔�p�KN��x��NM�}�W����p��+l�2ڙ�}��� ��(�%:��m����O���\0�)2Q���ڐCg�|HP�@��+��\\Y�u,��������/!�>�ӍQq�Wn��ӫΤf!����Z���_�T0�윂ڀ�lO���.NK[��ys��� N_#<�?�Sm���ʱ�&ˎ�,?��/���;�JB����3*\"dz�Z����3�si���-�ݥ?t��\0a�ud���9	����*�qb�C,s���o�P�`%M�m��Z�)�O#�rVvLj�;[^/��;��n\\_�;l�
cƨZDt%*��SZ�,��*E�YPa��J�\\��O �I�gJCV^�T�x�4�8K����KiIWEz���i~������Մ#S��n�1Y)�+ҭ������>6�W|!���h�`�&�n��(.�ԉl̪	��Zӌx~��%�\'�0���\0}��䴧s�-I}\'r5����VW?��O�Y����vit�,�d�S�\"+�r� �}(��d�tu!Fl�D��\'�l�{y�S�8�JA�n<��G�Z���>ϋ8�ݱ{֣�yi�^�N)��+���Z��֬�\'��؂��?�=�Ϙ��ZWBF�`I>T|�<}���t)3��*H���Rt<�ڋ^���Bzl&��0O�w�w]�$A�u��1�2C��ܚ��-\'��;�S穪����M�\0C�l���>���7\\��$��R�}��!4�W_b����\0I73	�Z���K>*j_bdƉ�C�a˳�A.#�cy��ڭ\'x P�Uf���jH�^��\'��~5l��N1z\"�,�����Z�V3�_,�&�z@>��y�N�_�-�H�a�}�H�*�\'�.(��a��DiʪU��\"�qۂB	��?�hE��:W{I�+���T����Q����.KH��|;r��ӆ�k�`�aUg���,�WO��j��JaL8�`x������i`ȷ�}�*l��@�ԩ�]12Ö�9F����M�Ƚh܈>��Z\\w.�;�΂[]��L���-:�,%��̭aS���1���=����$�wL����2-D��\'j̯SL�xrI��,�~\"A�[N)Kbؖ��v#1>���5Mù]�%Ul�q+ssd�\\!恶uN\\:�B�Z�\"F��&6���O�T�7\'�8ñ�Lm�M�s0mk��h~`�N�V�÷Q�Y�9��T%�%��m��ͣN�.�����B��y���S�h9�ʩ���������+9\0A���T��E�}&#��g8o�QԑB���%�[�Ͳ!�V��Ŭ��iHz\0#�:~����l�ŭ�)sx���љHl��)Txf}�P�>A�EG���W.�+q�T�B�+\\��H��zT��ꨜ�0^��l�ˋ��n�\0�aM�bR5�$��g����$�-�\0�۶[�v�q�d]<
Z���J���$r�U��]�FPUVN�q�K�p�l��l��
mӮA�	��ԧ�t/��E�:gK� }EhR���J�I�����b�	���y�J�	O_�@�	�2���8{��a�d	�k:�ZaFkck֐��}�
%$�G���!+#K�@�L��\0�{F\\�y%O��*ܨ$�r4OH�tf8[�Ww%�_��;��x{��
op���r�s��^��e)\0��	�̈́�bܭUZ�W૽��[q��a�I�BLt&4������byܴ�qKO�j����͠[o:��� )I)�w��w�q��V�o�m�8��q��#� ���\0ڣ��ExE&�<I�#�o��]R���
V��^uӍ+C ��m�Wۭ[��7:���#B¢n�+dʢ��w�YWIw+��Z����r\'x�4�LQkl��fd������l;�x:ً�E�F��um�P!hJT4��Twͦ��q���74����eV�IAҭ�ʵca�w������_cM<���1hv*��?�OJD����!��3���R\02ʾ����찛�8݂�c�\\�m�[�Z��v������`���O7[�/�G-�x�QU��Oh����>�jp�$DDSc�j����W$���JRS����ڻ3�\"�*բ4D�H�� ����4ŕ�2æ��,w+ �5v2��M��BGè�h�+dÂ�H&@��)��Ƌ폱�B��g�\"��F��:�S�*���.oR���މ\'H�j�*Gi�0o������gƮvL9R� O>����Y
qLXf	�\0������ʺ�r�4ڞP�\0/�Ci7��[$!ПH�o,����T%�ݷح���>d
T��Qߠ�))$I�0�+4�H��6yrM�4�%Hx�6[Y[d(��@��V��\\0��$i�S!օNU-���e�����[_JFI�?Iw!%��qrX�RR����jr�n�
Y�;�B��B4��i9C���y���3��cH�mHg,��Q�#$!�
�p�WV\'�W	`���[2;�����yY�Q�#�&)az<��}ӋJ�Lj+�1v�G�r%�6S��қT.����D:�N����ڑ�F���I}�b��,�
�$٪���)Y*�Ĥ�$�O�U<�Էc����[.^�q����K�u@\'
A:���2x��x����\"��-`�ku8�vم*D%*Y��-d|�e|�i�����X/����b3W\\�$���7��{)ʴң�}�qjn�Sl\\����[�ĥ0%k�ĝ�j�DڳCǝ�]�7�[7b���q�ӝE\0$6��v\0�&u5EC��ٍ$�X���<��JScn����@��2IyԿ[�|�쏱��ėt��=��!��E3�������\"w���+��Uƙ�^K��m�#�&� J���\'ֺ�$�P���xz����8T�e)C	|�:g9�)��Q㌥o�ҊI.�VX�!j��K=�Ұ�o���7t����V�q�_��T��&���\0��x���B�f�)	Cwh�$��*D���3����q�	n��!������~M�.#L�0#.YI��i*�,�;�]�\0���l�ӈq$��e���C�u.�m�:P�e����t���i(�̉�1+����({}|^i�YRa>$Ɂk�z�Mץ�G/x���-¥*U���&�c�qM��E-گ7��^\'gv�a�^!i:-j���IN�&���>�`�HC�Z`\\���\0a���=�_Z|�.����Q��1ב�>NO�
pP�*�����T�\"��6�Jp,\0��m�u\'�#��H��9e�i˰�9v�{*K�I�\0\0S�>POƔ��W�Ǔ�ZE~���.u��a��[�!ܪQ$�
����-ƒ�S�Yn�����k���q������@OMD�]��+)�+�7n߹�S������\0|��Ҏ5�F>lϋ�D�@��ۿ���� I֙%�(���L���C����׏pj���Rnm��Z�+dB@�	:\":W��)O,��w�<X��R��=�8���}j��5��6���X)��I�4�ji��r���ݥ/8\'c�mFN��kc���(�PKz�q�|1x��\0Y�UL�K����ڥ�ݻE����*?:���\0�AM��pe�щ�Y�ͿI ��+M4\"����\'C����f����9�Ť��%7.@�t�K�\'y<��n����Y$u=i�/a�����<���������̠�5�X^�����X�U��h��z���+3�������,�g�:D�9gO�����Д�g*?�@��bj��@+\'��n�BǸ:�|b�Hν%�U4��.��Q�5�$�_	$��T D�ʕC��d#�XH��Y�n����-�)��)�.($��ui�rZ\"n#�o�d��*[�a����?F0N�ZC��9fKI��YM���j>R~ĩ{��An��H�U[&7�&-�D���R���O���r�E��c�U�v[�l�(8ԛ�y\'�
�*�U%(Sdy��5�!y4�/�iAHJT?ӵ����֗D��4�\\:N�F�9U�#���?7��<[)N.�t���T�׵�ܢ�G���;�(ZO���J״�v�h� �S9�J���ݭڐ���&Q��Y\\�[nxđ�U��>2m7��%HZ���ә��}znMW�mtj�ɺ�c��7{���{��
$��\0~ �uG��ҎEX1�b��a��3����uXJH\0����L�:����E��Eo�\0-�T%Kq-��Q2L� s=#��V�:�2���I�/������&��\0,ʐ�D�U:5��
�9;kF�r��{�q�Ø:�N^����U�b:��λ�I�
�T`��S�~:����Ź���2���K𸴃:�ʞ�J���\\��..eV�We|���_����u��\0i�m��W�i��L3�Z���.�QnۡW6YC�Ɔ ���y��M�=G�w_�#	±^�ۼa�/-p�a�R�J��Փ�Q*V��*��u��$�-7�c���\'�IrӸ���FR@V]9�5�ʛ�+Ӟ�n�Z`x]��#�>��9.w�yF`�3��m�s��G�.�o+������L��o.���]�+�\0�H&N�F]y��D`���F����㕵ge~��e�&7IF�u%1� �>�ŏ��H=�l�w/��R^FfJ��uI=y��F���^rs!|C�Bl��Rˬ���Ҳ��6@ȓ	�	ȥ~�Εq��!N�v����-�fˊ-��)ZT�p�s�zՈGvR�8Wvo�5���Wv
��^���Jt�#ݶ�9R���O�*�1��j��s����d��y�-E@�G�N���%%	q`a���ؖ%�
��,�D�\\��p�B
IN�� *=F�Ɯ�Ϋ�#�q+�M�wo]���N��&GxT��7#_}9F�%{��\'���V��K�\0�����TU\0�2LO]��GM��礛���wt2�NT����G�VZ�~�PSy��
����6�;�o���R��������ߺE��x��=6}업.;3��ٶ;�ѳ��j���ß����Dy?W�����~��w��ӷ���TR���r5~>6IG�Z<����Z������\'����E�l��$p|��[o���U�C]�V�--ĉ����໔���ת�f�\0#�_pw��8<���N ӧ!R�MS��4���G�|��O�Ƹ���2��$�&�����%����
r��Us#[ş �.���6�e4��Ip�<�5�ђk�Dom��!:�Q�i�rf7�I�L\0㎼����_��x��9�I�4��6�[\\4��#֝8��G����e�\'0��K4�������2��!,*����v� v\"��t�}�7}��mҼ�գ[��OZK�q#N��W�b4����H�8m��
Iә/ʋ[9x���ct�
��$=��Ù:��v�N_*��_Jkm�a`�5 �J/H=et_kQ
���e�M�R1c2�B+�D�T��6�x�P��`I��~���Sl��l7������o�@I�in7��ʞ�c\0���AB��
�L�X�ä����\"��t;��\0�w����oq�a%.nGZO>K�L�%��0���! ΂���֑G&%)]P\"�-�%)
���/.qEg�b{@�8�������\"���M�4�И�J�6mYN_I���pv�Ү/6��I���[n�&}���]��	�PK�^�և\"�0ʭ�&����KC|�㇫���0qP��pRRgP\"A��oe�r��Z�����S��q��GY��iH��vZ�O�_�I٧.�C�I[���-�쓡�w&9�R���u?O�|;�KsE��:�å���YO���I\0��*�	A}�fr�����R�\'{�B����ZJ5��!�e���W4�F�w6۔�q�m-�W������ȗ\0�	��<����Ln,�߹lvw��j���<՛.���hTr�\0����zP8���h�%�r�׋ðM��u��>��D3�d\'�)��\\}˘d����$�|ش�U.�
B
��(0�Lﶂ�4�K�^G,�m���6�r����]���[!i
TT|����B���t��vV��Qh��ݺa9ظL\0��
}�3��R�r���˕CM����xv�wQ��XM�������\'Q�%E���U��eq�c�8����ֆ��H���$�v���Jh�,�$��-�ƛ�����l�J�0��4D)���幡�)-��ɧ�������.��x�/>� Np� #B6���s����JR�>tjW��l@���޳t��%��N\\�@Hԃ�AЀH;
��v/;��bm�����	f������
!�\'�3���4���IC���%o�m�k޵e�eBT�3=$�D{RA�N��\'*j�sj���g���u�P�i�S,��d	�t$t�Z|��4���N�~3x���$���R�G�<�Q�>t���ɸ�w�1�a��36i$��I�^��W#�\\i�������Ç�I�n�l�$�Z���Y�����Ŏ+m�wÓmۇel��X�kT�\0�2D�E����rQ�Ϥ��Sv��h	Km��`��Z,�Kvfb��M�1>��?��\0�\"�e_б��ĭ#�����\0hz�S<���.�B�#��\0�׹����Y�Z�k�`�_LؽuG�?MX_2����nPEˠt4Ywb��Z
~��I�ˆ(xS
S���l����j:���ΆRq���X�e�|��[&�j�j)$�^o(�RF�ol%f���m�ޓ&��/cV�ưg�R��
��<z(���Q#�p�[�6�Kգ�]6¯�b���Y9����#-����!����*Q rҫN^�և�P�=g�.Nƥ]�m�ɝƠ��^�{,�H�<���*7[��@&i�2��g(Q�ڧtL4�\\���x�C�f��@��Or��;M�g(>�-�=�]�
uLJ�L���n��IN�^tq�,������P�Wd�Dc�[�ǥ�����H�Wr;\0%P$*�U]	��&yE^��JřNq���Z	:&/�
���Y���V�bD���G*�@�Œ\0Tk�c��i�r��\' �����_�y%��2��`k�6��p��#֭CČRl���=!�Ww��~:Ѹ�;:.rav�u��ꚦ�e����(d-}��F�����b6�j�6��R��RЊmZlf\\Ѝ���@G�x�^�He���Ox��
\\��(�i{�W*z��A��+S�\\b�^l�]t/������޳��PJf ���5��.,�X��̊�^E��2��J�L��L�r�T���
|cO�V�ٶq�=):��\0���:q��L������a�.!K�qp��(m�]H�{ɝ(rI��8��?������U��ЄX��\0����9�멪�ĭ����J߹��s�).Y-Ie����3��@s�h��\'��]��+��7�U�ʞ�T�������7����/Eİ�K��gl��J�.�S�B����9c%_a���7&������9�_xh��U/�R������q�i�U��O�q��~�.$�x�:��!��\0Q��j:W+�{,O\"�`BQw�S�md�Z����l���py��M_�%��CK�0c�^%}m�+U��A�!JJ�\09H�4�t��GƝP3
�^-����|��;bm��� �G���8=����#����6��%8�-\\�g�e��=������G@d��@{�9�}��:�7�J%^�)
�<�Ǿ��Ǝ��7A�O^%�G�n�L�R����}I�ց����W8�i�1F�x�
�ٶ�Up��IJA�g2�t��JQr�9�0KdW��=���AN�
���Z�o�ק�Y�7�W.K�\"5g��j�
�OݘQp傥�h&u@��)�J]�V<���F�j����{��I���	��<�ԙJ)i�g9�]vJ�S���|2V�+2���ov�C.iH�����,�+CVj�C`\'�9�U�7f��j�p�K�+��A���g�	�X3��j�i<M���b�d?}�eC����C�*����UA��;Jh���\0��ػ4ŸkJe������>�~�D�bR�d�hؓM�O�|�����o�,Y�Z�X���A��y��[�pύd���|��8>��`sc�H�ҥ����	�)m�Q����#]c�ځI����B
��)n����(�9=z�ڱ�iw�F��P�Ҋ-�Ӣ]�o(%(�T�2��G���f�\0��,#���Ц�:j�5[\'v\\�%��İg-o�ZaGa^�u(tyl�+�AlG
-۶�>hh1fNN,foQƥ�-[\\eQИ���E��TK��\0v��p�]Z2�)L��������\\�{bl\\RR�@�Z��\"�ٛ�
��2;vOxzε~&|��Ln�\'`yiGؚ�ш7/ڹ��.�$)�:��������M
i� (^w�ТqD.5B�41y1�1x�H��m\\�0?Sq���$���r��,�d<�n\\�I�����$���n|�g5N�nN]�v��B9r�kܔ����`�dԧDJ>�U�\0\0<B�N�>�(��@T���H&�R8D�i\0�0c+m��P�);�����^Z�s��d���r�����5��kʊSgG����!�!<��y;E�$��:��T����U�]�.�`��U	�3�I�0��e\'�*�ͺ����<���Mk���-�����6-Cm��.�l�����
��%J73���}�pk,6�ͶK���\\px�Q\"}�#�ӱ�]ə>O��ڣ�jN���M~��R,�ЀNو�@�|E_�8:��<�Qd�����,���$i�L*i�[�%�! �a����3�V�D	\'1�z�6�Ñ�^�yU�@�K���x\0��?:B���mz�)�Ԑ��l�RHQk@�g®��wZ�r�V8�ͷv�;n�fϡV�=�%�+z�{�׈<��{Ai[�I:��yH�҃��	�r��N.���ܭ˥x�vs)9Jr�$��M�y\"���||�w�gkz�$Yڸ�voB�S�!#B�@�E
ǯPy$֣�I��So��۠8���ir���$f��L�W�2w}!�;�J>�;��W(KI��R�(I �#1�>@Q�k��2nL�q:0x��yJyVkiK�ε5<�?�8I�м�b�}�X�-�m��7Kb�1�!Gϖ�PJm�����n�i�1h�Ԯ��%�S�_)cʬ�?tSȚn����G>3{�
��[�m��	�v��)��)�I?���;�[��]�����Qt����c�����������w����	&�#�\0R7\'ɖ��� �G8�˻R�;�C|ʄt���un{5��n{� (�̨�a���sI�Nڱ�.��l�i�S��p(6T�Ӥ�?/�\'�O�-��y��i\"����\\u`\\6֫\0�Y\'S�J�˗z7ዌj\'�\\,�$��@�B�����A�1{��ٺ뉅-\'*N��d��W�-�*����xT�}�b�J�\0k
�p4�����G��<(rqH���S{��a82ٵJ��D� �����>�d��nH��\\�c�A�#H��+
wH�ɭ��o��rx���|ܜSH7�4�^��\07�D�=*�����\0������^^6�Ժ>�ۤ �֤��G��=�E�3�H#A֫<�:e��7�\0HrFS5:!�~ƕ�������#�ϥѱ��Ƶ6,Y*�n��(xO���|c+�J8^��7�-*I�V_��:fǌ�E��d[��b�0h�v:My�N8��M������eξ�p�J@2LS��O����JK��\0qf;\'��0U)���r���rT?��]��<��h��Ĭ/NVTڠ��ҽ�\'Hm�x�+��1�|V�j�oi� 廭�(I9��\'�yW����ȸ��x�_���ȶ���IX����0�(�Mz�cX�����sK>Gz�h��<��J�k��Pt\"��SJ��*&5/�crv�0���~S3V��+$����.�ujxD�)}�v/���}�S$R�n� �<�Vmj-�Lp��:�Cz�^�|1@��R��j`��?i�G���횰�\"�	lgZ��Sk�&��9yL�E
n�a;F�����8_h�����t���rp�΢]�Lw�a#��*�sk�3mǩ�&ξ*�9\\e�������;��n�(2��O�yv*s�@��yxH�<�ˌ P�#����Jedk�m)��-�l��2�k�m�U����������\0�]./��r��m���n�0����\\�6�q.(J�_5�y��
|`�:^�^\\�}L�x
k����,HW�Y��kc*J(�ϖݶyW��G��s�`w��s��s/���)9��U����iik���)q�w�(vy�X���!L8�\'m�Q��t���Z�Gx�����ɟ�o�Q�$�kdƚ��+��+v���R��м���9k��V��ed�����\\�{�}*y
2���|�m��e�e��[�W����G��̫,�����EMn@NJ�Ǳ�-{�AC�HY��:+�J5�Ŧ�Zb��n?\"|jJ��:җW��#�O���1?���K�@$�e\'Y��ϤP8ESC�������M�wHR��kQ`�{ ��sT�1�����[9�K	H��dG�Y�~�������Ý8��w1R�^DO�N����J����nr�a��0�N�-!M:��
H�\'Ȓ�QsWC\'%L����-r�RҲ�#�\'H��N��\0�)R��Q}���-M��IPT(i�9�K]�2� �SL��!a��Rd�\'R}Զ����{�⊸q��%���Ԯc��zjT��
nN�A�,<ݧ\"���A�@�j��5ѩ��ap�g�7IQ!��T53�r��Ҿ,���8�����.-�$����g�4�Ѩ�(�,���n�ǅ>c���*S���!&�>g*�_FR������9[�\0q��w�9�J��;\0<ɡܥE�8�?�kv?�Mp�b��]	h�\'U�@�d��
������,�����n?r�� �|2en��ν��TF�w7�*}��\'�\00��eA5ѳ7�h3�j.i/4�Y}��С!@�:|*�L\\��2�r8�3ɝ��\0�tp��q{�8��7�g+U���n��7H��ǕVŗ>8�|��z���3bÖ|�����j��\0���B�+�F�\\d������i��n�������թZ���Նې�I�T�gki�����5���R�Q��U^d���Oڎ��a)���������C�-�I9sk��r�ST%�R��u���\0t�e2 kbiY|�Uc#��;M��[Kdi��Y9!�]��f�*�qK�.첡�*�����s��#��p�[�ϡ��OZ쐆I�Z�4D���]u��3�D�@�֟̕(���+nRHf�aW��� ��\"\0��Ϛ.�<�=!�{*���Wt���4�\0�W.7�\'�\0�Ùu�>=��,ۙH<�m`����^O�]����G�1)�m��@o[���YV�y���0�j�!)2ANUt�m�=E�_�e���Wl�T��7Ts�f�!���D��I�KacmI0�W9���U5�Wƨ~ҁOSH��Lw��[���\0U�fǌ����PB5\"|�:��N��Fb���˲`��+:��uҡ!f�t�ʅ�Jo�WIP����E%�-��I��䁨�}�8�����W��.J��ϴ6��\\�DR���m��Y��\'�7J��,^�2q����`n�ۼ|._~	#�I��e\'�&��%�L�8#��Is�������}�2~������/;A�`}�vmn�k���#3j�Gz�?2����;+�?�;eh��sˌ�X����i6�M���m���iXq�zc�ys|���\'|3�4�޺Cc*\0e�ө���kj8�q��S�,�m�[��qpݢ���\\#orO����y���%R����=���I@�O��T&2|�4����ldc�o�g�xKûO�������d�T#*���G(�򬯈�X���n|��/b+�p.��BT�Q)���>m=��x�T�U�\0�+ǐ��\"�#]��Yœ��G&
_���ut��AH>#��֯&��<j�\0�xw$����	���$�P�(G����/7�@{���J��#LɄ��m��1��(KƔV�����{�$�M���O�SRU��Kz��:��Rr�>
�tf��\0�w��r��3o���jP&$�Y:h:W�8��1lDXٸ�e/��{\'��κ)9�x���/ZإAe*�B�	;�N�ͫ��U�w{��=t�1�i�:�?�+w6\'y�2��R!C�v�N��T��,�F��yՀ�)KZa;\0��ɤ7r�	wx�m���3�d�%�zv�0�e4��k�\'��i���W��`��{��L�\0����p�svy�\\B��i�����s�+;6w\'�o��m/�^/\"ٖ���Y�<�\0@�?	�?��4ɍ����зRQ����Û�H~��%w��U�k:k�:P�߹1��5�o�b��ҙqI�xWwĮqB�f�\0KY��O/@�>�5��x�$ы�o-`����np��c��J�C�
��;�?��5����S��rEǊ�^i��<�I�/!��{��Ow��?(Z>QU\\t��%X��kkgA�̑�J~9=��j��p׬���	J�W�/4�U[���R�
�^���7l<�o$�y��qg�8���-Kg��[�aX��_�(Nz�*-��[-^�g�^_?�<.�}�������f�k��/��d�e٪��\\�ۍݠ.�e#OxA�\'S\\_���_�;����AS�=ڊJ`t��#kL5�9t���\0Ti���\0I%l?�G�I�)�\0���b�x�;��Ҵ$�%�\05:���I�<�^�	�F�\0�(���vZ����\\b�*��T~��%�_BwMop� Q֊>,����$\"�3f\0\0�sҍ��݈YqݱݷZ�蒠���x���,�� �ÜzïAB�Q�w�&�gK��BX�,q�HSiA�x���>㲣�^r�N\\�5�Ԁ9W�� �P�<w�>���T|
�ڽ�l�)�MJ�S�d����R�&5�\\֎[c�x�� �*O�s�HY�e`�#](%��y�d�t�k�u�,ѩQ�<Y��+�)\\��h�,��6�r�2v���2��qB$\"\"��X���@;�m�J��u`*���(��,��T\'@G>���Y2�~�x��\'����j`��e=ef�SR���
�ɖ�)�����u����.���6XL{�#�*�/+ܪ?ՙ9�#�
�\0��zc����,�����7�[�S��9��U�������\0?��e�+&EM��>��̷��p�Y�ú����OǊݰ\'��H#s�XV	���[U;p���u�Rr����a�;{+��<��Aٳ�8��>��˕�R�1�� Õd���\\��Yd����6M`�B-�T;��o���\0Z�Ŏ)�22�o�+n�0k$ ���y�?�g�����Ir�
���Iu�wTVJ���qz������h�)(�E��lb��G��8���*B�@(<ƨ�[t��^:�l�Vć�`�Y��?ܠ����G�k��/#e#�|;pI׹c9�$�*���;�z�:{#��������J�&> Q������{,rŲ�f�mR��$��U�y��R���Z�8��C�d�4J�$��n3S����(�
@P*L��C�._δ��b�5K��ųy�������25�^x#ܖ�+Û7C*aC��Uqfim�Ο���iXl�
�qN��i�#;м�����F�r��B����a9vɶѾ�k֍fO|@~����[%Nd�\"�J	�J�D����7��L�0��Ե�����ȟ�Qo���M�\0Ad`���,��ca�&����lt|Qa�\0v���6�	$u�O3�\0S���Ҳ����ǝm˫w\"I:	����=ti��H�������MŨ/���B��ϔ��idrv�J*-6�p�!6v�e`)⬡���J��l�%a�3�J��8P�{�ξ�Ѭo��\0�-�i�Kt�ނJ�G/^�-�`S�~໤�RT s�iRM�Y���C�)�a=��%:�I��rt�;&Ur~Ř���7h,��7qBI*>j\"����a�_eg��!�<Ӕ��`6���oj����n�G�\0��O����j���d�Ւ��7|@�c\\�6�m }Myܯ����W�1k�a׊ʖg�ߵ�UCa�Nr��&H��P�J��CiV����D��q�>��he���R߶R�l����T$/�֙�V�Ȝy �׎!%76�)�@ |��չ��YJ3�]�
��mA���Jݗ6�/�X��g֍l^B�oe7��/�;DJ�E��|D��Ŕ4��\0R}�|=���D����#Iy2������\0�˝���xۆV����+d���¸��W��[�\\[�_u��������|�����;�ؗ޹k��\\aϠ�Y�iM�x�Fp���e	�o�xYYGM\"��Zu��ʔ`@��ޡ��,Aklt��$��yR�he=�����UB���%!�I3�ѧd�����S�Lr�%�r��Ch�9Ҡu�\"��vs���6q���*�
��!��>>DՎ/�{;V���\\@�ͧ��j���)�0#z�����iJ�S56KTv�E�
)����֎�a�	Jdk�b�I}Β�m	���-2�5�Q�&��{,\\X�A��~E���T�4�*pk\'Ρt����p�oT�vkC�m&`�K�Bܯ����c���ᶏ�^�BZ��l�k>I����Sh�g�a�:⤴�4�[�t��@�\0�:\'�\02�Y%��K�-�����S�o�\"�^m��B�X��<E�D� � BG�j�/��������鎋����t3kn�hxR���:p��X*).�l�oof��4ީH�(B����ZF�թcP��V3r�\0��A�V�@����2��F�\'��~{���SO�t�����]-�d��_VT���©d�{�o\\�(��nc7��m���Yy!˩���ϗ���!�$������v���� O���}=�u���%d�y ��c��q�oA؝c�?
}p�}���k�/|�S�h�J\0��7*:!>���pEJN_`3ʕ}��K6�m�ﲑ&7yg_��ҬE���ZZJ!��)�[홒�h�:� ~��$�l��>wc�o�=���~�R�����9���k�dU=_�Wȹ���3Ɛ՗Tnq�+��x`-�D8�H�E��U���Ʈ�P��$�)>#�������Ec��\'�\\R�B@4��S#\'�x��E_���]Y,���:J���.�.xRv�C�;;�e�T#90v&��Eg�S���e�����H�wҋ���$�j�#m(�l\\B��0<���^4V�9�;�-�倹�cJ��}��,Z���c*eK��F�;	����\'�%�;�{*Ůi�۩Frđ����1��%�Ip^�wJiE�ۚ��I�vև,閯�V����	l�U�Dsi<����[8/
?�2�u���>�~��=��s|�V^�d��ٗ�\\)�J�GI����qQݰ�Eʓ����\"̈́!����w��Y���Q�P^��{n�e��r�@	�O:S��{��;Q�S�X1��((�`M�YZ�������cu���\0M�*�\"�B��H��j|��ֿ���̗�G����K�ǿrd��q#)Zmm�ޓ��AFzl7�^��/��2��IxJ�MӀ�wN�LnTG�\0�iY�PV;ƅ̓�[7�����$}j�jݳyk��g�aJ$j���	�Z\0�s��;�����ZwtC�y�
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
