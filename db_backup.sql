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
  `estado` enum('Ingresado','En ReparaciÃ³n','Reparado con Cargo','No Fallo','Reparado sin Cargo','Retiran sin Reparar','Plazo Vencido') DEFAULT NULL,
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
('1','0','gbg933','af5a9f4653c88fd965e1182505695b362930b285','4681','Gaston','Baldenegro','Cont. Abayuba 2581 / 201 Block L','gbg933@gmail.com','099394334','ÿØÿà\0JFIF\0\0\0\0\0\0ÿá\0`Exif\0\0II*\0\0\0\0\01\0\0\0\0&\0\0\0i‡\0\0\0\0.\0\0\0\0\0\0\0Google\0\0\0\0\0\0\0\00220 \0\0\0\0\0\0 \0\0\0\0,\0\0\0\0\0\0ÿÛ\0C\0	!\"$\"$ÿÛ\0CÿÀ\0,\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0	ÿÄ\0T\0\0\0!1A\"Qa2q‘#B¡±Áğ$RbÑ3r‚’á4C²Âñ%DSTsƒ¢³56uÒ	&cdt“ÃÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0<\0	\0\0\0\0!1AQ‘ğ\"2Baq¡±ÁÑáR#$3‚ñ4CSbÂÒÿÚ\0\0\0?\0òøa4±ÄZHØ›3_a{ş¼1iš%,ÑÓUDÌ‘ÉŞW%´µ­`Ißû6¿w˜ÅLrÌ%ÔIe:È±üF/8&.Ú¢ª†R£S$q³0ÖÃÚ@½v§mìOòá†sÃÄ/«˜t•3Ek«ÑT$±‹ë×˜íä.-}É^|ñ¢ú%¨¥¡=ƒQÑ‰c,%©ÀJƒ°•uX“µÍ­õÃ\0¹Î\\°:´Ï;Ãpªæ1²ø~èX½Ï.X¼àì‘–—2xıi…R•†‹5†×r.\"[ò$j?T‰@eFPlwû=¦V³-ÎŞ~SRã|­ë…=JúİRi)ˆ•£#ĞY˜[÷¡àzz=Ï3.â”Î\'Í‡-ÌÁ-n_¢zyXn5ÆGA¨•Ò­kØƒ|É6qÃ’£RÍO(D`Mú:êèj
yréL)ê¤¨¦â9dˆ4¢93zxÍ„ŠÛ-\\[Yj6mì7ÆêÔÓEX‹;õì~ÚøÚdFdiêÚâÌ‰s9VmK$d-^[2½‡Rá”÷kØóÇ=$pòåu	˜DËE*	ˆ§Û½°”2Üô<¹lvíş…i2ê^‹)eNŞœH&gIÔg‰‹\\ÜíËq×Ó×#ı$‡UÁf$Sí+½‡07\0‚m|e¤•›Úµ®>>:éĞßòaÕeÒ ÚyÍß2âÒ“Öê!p×8Ú‰ä|/}G®×Åw£¾,Ÿ‡3é*–¾Zs(¼pÕÇ¸n­ğ±óÁşUÃ´ôÒOš;Jù;è–.LÁ6fP:±ùß–ã\0\\m‘¬šæ:3FàHU¬X5Å˜‚Nípm¿=¯½³`±5)U94+§ÇÀÈê¤Xõ›¯£z-96yQIP•M_ÛQ®’
PÌ–\"àjÔGKŞ×ÔÀ\\èòÆsè‹Œk¤’gH±ÔMm†S\"®á»ÇIØì¡å×vŒ{ª´Ù”èI6í~3›ˆ\'0¼¦Øp´DÌJ!%Aú·çl;£ËiÇ@ÄÆU0½8t.;¤bfŒŒˆñĞ˜|(ğÇÚF*ò^1£ìğù\\wF%Ì«éìü±ŞÏi8ûN%åFÑ@Ã¨Y}–¶9aàd%ÁXÀZAp1-Z–uîìŞª—Â”3¥ğ£HÅ¨dÙ\"Ò{§YY”{D,H‰åğÂÈ¶ñ¡§ÂN×«_Âøè˜\\)ùb]._ŞVÔlyí‚œ¢†3´†SãŒõ+*#’‘s¬–&Sb:”r¶úvÁ¶m•ÑhÔ#+ãJhW½¥ïÓ¸›‹,ĞÊu0dÄOµ‰”q©Î,ª¡¥“x£ÓîÂ`cŞÜ±mVâK´ˆv{%öÅe|Iû–Å²És~XT±Ã\'y”…«e1§ÖM†–Û)ª@±#ã‹)2èÙ®-îÂZ÷pãU[H‘Mœ©¹j¾$!øáJÀû8Iªq‚ôš˜ÛQïpÃ‘Qµ½œZÃ+®&ÁTc+T\"=PJ–Üî¿fı_§õ`àŒF¬-¤a/J¬9a&©Œ&ašÖGKÆô¹LÑCHÕ‘§«h‰í‚“ªk€¯õ·½ÁØ\\_ätu4óG5<R$àvÊñ«	<5ş8¿Ÿ+5L«±	Gûƒ±çlHzuˆb\0·Ëjaln jÑĞåPSĞ¬„EÄD¤\"ƒbB‹m°øVæ¹%;G,_OIÕ–D”-{ëÜ{omüz`ƒr
|û)XVS±ÏD2¡±jSqñçT”uY|ĞVÆLÃ¾ØXoÏ§,\0s%¦6üAPõ™geAX™[TÓ´RÄÁ‚êu,U”S¨éç¶ø§¯Ê¸{ŒçzõÍ «Ëæxˆ†%U+R5‚ÒX)ßPÚÂúEïmôƒÃÜ;#½LttµjîÒ©*’Nå™Õˆ¸$ìm·,
ÍÃ9\"TIMB±%PhÄÑ– 4‹€[‚6ü8!k_h¢wÊg˜e†6X¦’G ûÛ‘}ìmÏ¯óÅÍœhŞ©U{6PÌ=›e`zìTƒkâlğš\"±È²*°UîéapÁ0¸#p.¼œ«>QG5LLfÆ7mAd@Aë{±Ø¥ºã‹K2›ßc:fÍò‡\\iÃnÙy¬¥gõzvgv’\"¾5ë–\0ªseûWğe==U‘fæ0Çi%¨¡»UäÔi¾çÚ%­p7ØcBÌ¨èón‚®)™©ÃÆñ‹X€šÇqßU7º÷y1CèŞ˜K$q›´Ô¨Çµ„s£6LÃt
M®@(¶çq(S¹zÎ]3¡¿…2¯G9LªğÇŒÑ£vrFB-µQ°mÖüÀ°`It¨›‰éfEU¯Õe=:ö‰%¬i¦„.l¡\'KhÈ·e‹ºw¡Êó˜¨šaªLlj”É³¡™ûAw@¡Š@¾±Ş\"Øã|Â·/ã	s*hé%²Ì(¦¤5^×k_\\{]ä y‡zhÉµŸúéã)ˆ°>|ï6\\ƒ…ä\\„f]Y]u4µ¡™›/«ı§gpZû†ˆ¨*À$­ÉÅ-CgTQ&¸jÙ£#r©S#‘ßKmÔ]O0N*½çĞfH’\'ŸuF’:‰5Ï#»©ÆÓ)»0İÔ– œ1RĞÆ+²<ÁdDËëä4U6™`†Fí#Òpk)cp
{±£Š§-½½“¿_¡ÿ\0±Üv5ÊN^ó<ô¿’ÖpŞf™õ,}É\0õˆ™¬_eÉ‡f<\'ÃsP8f—=ÈïíSJí©J°!ûÜ÷½É$\0E¬qê,×‡{–GC›Éc
jÔ¥Ìl4º°¼·şxòÖ[GúH©à¾&ŠZÊW&j {IW»m}Ô…7ÙÒl*ªªõ9½*úÒ$¦Q”t•ya™pŞuMMA5<”uÉ©CZŸ³J
ƒbÆê¸!ıÁ$±èL²F¨¡ŠG¦’™ÊQ>å…úÔcã.Îx„*òêêTc“TÊ²&Òe€ÉÜq¶Ç¿Ìx7ãfôcY]UÂt´ëRÉ…” ëmµ[kù;Şøô\\.«©jmÓÏ“!ÖZhòáL\\¥nš˜¢ƒ—+•zî8ìŠË{L¼¦é*–=ğ¥Ç–-W\'ª\"â;ù_µÊÖhØ1‰ÍS±„QûH<±ğO,X­Ì	“ğÇ$¡š1v‡¼bsy\\¶•áG†:Øb î1ÍX;ˆŒÛÓå‰1ö>cãŠ¼–‘»;òÇÊ‹}ñ(ÇnDc…oÏ4–‰XÖÜ¿,kĞá+uÂ•¼Nnaƒ>ukÛŸ˜Ã”zƒrùá·ÃÑÎ‰õp&öŒ^]RI`5X(ÅëÎ1mlúĞu
»|1&ä”{CŞˆ:´Òµzªšéİ¢NIL­kâX£“ á/ĞâÆ[i†ë8«¤ÜH¾ì<<ÛV\"=4¼Ôß^Ù9ß–ıdÌGI9c$÷qÓ‡ÇÁ<Š}›ûñ>¦ÓŞâ0¦#ÃG!#Q°óÅ•-Y¯ˆ«2“×âq*	ŞÖøCæ1©i-2ØXr“Wœ5uÇà˜›qŒ®[¼Ò¶J(Àö)Ã	oÈáM¤]¾Ü#XÈ¡j0Ü½š‚M­ŠÌÏ=¥¡©‚¡ÊÉ>®ËºHb-İÛ©¾Ş<¹‘|Ş¦¯‰³¾>‚’Ÿ2ŒğÀÊàš* &id‡¶Æ8¦·A®öå Á/h_ÅÅo¢ÕQåY½4•*&œŞXClJ­»Âö6ó=1³¬ÒŸ‡–§‡è^ºydƒ@¡¤@×¹¸º“Ón}1(Ëó¬—2âjêŠÙ³(kª½f‚›nå¡\0®Âãt
=ÀÚäáŞÍ*³ì3‰©%¤õ¦w‚	I^ÀI±®ÛÚöÁ~r³5¯›#ÎòšgZêØs)&í	IİlMô’M÷6Ûİ‰yÕRåô²TËYP¨¹íQÊÄ~€o~Xo8HV­3Ju’²Zt½”»¥Êº¨ ‘¥w°°\'ùÅFmPYEd—Gˆ†« >¥ÒÌÀ¨TIkmg*ë\0›)šqLÏœåÏ%,Ô”Ñ,óÑÉ£1²;!pB9I`Ğì./c›PÓÕæ°úÕM,ÓÓ0Y¢g¾ÎË¬(7äNæÆÜ¤f\\G^ks*ü>ÂÍÙzˆ	P j\0‰$î6­‡x±6ä³yj)èa#âŞĞµ­V²™UV¨‹§dÌ×Ì.»ÀZØf|·6Š±>DÆçÈÀÉj*à¨I(TwŠë€&İEöm7Üu!¡ÊbÌ½K]\0F©Ëj¤†e+ºƒŞ6>¡1êp„É(åÈó%¢Õ§ZPZ”ºIÔ:’M‡³½ÈïÜYpSú=AMQÀ|SJ®úçM.·¸ªHo-›o­à1Ç ¤Ó`½AñÌé¹^Ö>~’ËÑr.sÀÔ±Â†	Ë3\\‚F×C¹#K…ÛévÛ¼/Ãµ9ÔQºM$èàûd…RöïÚy‘u:ËŸ£h£‹>Èdk45	;ík…u\0×şï4¬…*Nfô•œĞ	}b)G=6±ù)#øIR6Ø6­QQh’7˜ê Jøš‰2ºÈ++»3£½$Ro0­íq{›µÁÕ}®Œ³Ò<^£Ç°Ô-|T°Ôvsö‘n#f2µÀ6¹öÉ\0ÜµÅõ¯M9z×ÓÃ(™¡•$ú^¢¢ÈÖälÜ·‰ä	¤Iª£¦°u’œ°…šå1Ææà…ì›•Ê±$Ùq’²šx¦[n/çá=‰é/E¹=NW—,KD”ék˜Pw\"f7&	““«MÎ’N’ÈÊp+¢‡Œ¤ic\"l­$}Úæp\\»M¸ê¬y`ƒĞ`õÜAG[v¨¤NÈ3­‹ %EÇFR
2ôe6î”¼_M²ÔPTÓF†¢hæE¯¬í
[¨m·Sa×ŒKæ Ën’›ŞKáªê¡H$FCueñ_/..Æ#úI@ù?d\\]%^I4Ë¥.X¥¶ùyƒv67Ük~„$Irãg¶¡’òSÜß@¾âılNşƒÊ@ïÒƒÇz<Ìii)ÚLÂ=fUnK¡¨K(eÅ†0Q°+aªê<øÈÊC^ñÜÒ\'â¾ƒUê¨³
Ag·x¤ˆE÷0Hğ b³‚2©²L‚¶v×,Œ½½°97ÇŸÇ{¶¦3}^«ÑöO-Aq+S€áÏx0$5üõ¿^{^Âú²˜Dÿ\0TƒáK@-óu3`Úö‘c—Iîí‡Äå­¹ÃWû1¤3‡2ÆFf˜âó/%#´\0ß0HAâç/®t c5d=&º5X[E—ÓªiX_ËÕdôõ\0öŠ\0÷b&g°äO¿tõO(µ±Ëlêo:*ÊÂĞˆrOQh7ålUş¥ªÓ¨DÄyk‹K€[Ş0ÿ\0«ÓªÙcAî\\h^\"ê\0µævÁ+Şci’Ö?±ŸpÄY¨eˆHG¼ckŠI\"5õ®Íx~’ª3¤ioa©Ä®Ş°Š|©˜ù…¼ËhÈé«‡ ¦C©¾6Àõ}kpŠ}çiâ•ö™ja™7ƒ¥|±öœXK\'+a“	möÃóŞ\')‘-…ÄÄƒ¸Ã‹\0¶Ûâf’Ò*)¾,¨d*@n˜ec\\;±ñÀ7­t2ú)XÃI\"ÆÄï„ˆá‘úïˆê>ÈÅ•,jÂÇcãŒL¹fÅbÒ]=3ù`q\'õ-+œßÌa1*€;Ö#	,n¯qŒ¥›¡š\0ÔHÍ’\"¶öÃ3åJ›‹‰“Tªä¸…$ïcrm‚Rıàœ¥tôÌŒlÛaµNiPÀ8â:ß`0àÆÑ@é‚i…ÉÅœvQ}ñf aÅUXKÙ£ãi8WÆ=«uëa—¸X0#u=F)«Š5µÆ×ÀîN3*ş§¨9²šºŠH›¶¥TxÒP·b—Ù”¬~è<¥2ùŒ¹âÚáEê³5š•æXg‘ğÙd#–€vcĞ5ùŠÌ©i2°Z‚Mt„´¢¹$–R<o¿3½Ç3¨j¢¯‰ë3ªL1Ëd¦¤©Ö$«%ŒÇ2itu:äR¬î¦çknñ©Q<’ón–ºQWKSåõ	N¦Dœ«<ˆªÍô‰ÙMÉ¶¦Y>¨½¾_[K%¯sçÏŸ‰íwĞåõÉhÑÁë1ÓÑª1y%.€ïµ/{Päo¶/ GÚ\'fÄ‘­W©ñû~üA[Q>O•§å«R©2•©HÇdìQ†¤İl¤›¶ÖÔq.¥JšŠzvÏÍLU(òeğŠ„\"Hûºƒ8Ô’€-kF¦Û¶²5b\0!f2ã‹¸’—†2*¬Ş²–ÒUha­A mÍ˜èÿ\0¼>*áhè©ø-—/¤J\\½éĞÀ»İcpIÔj7¯½ÍÉ<ğÏ³~\"Ìòêh›0JQ–Å{EuÕ^ã£¦°\0!	KYÄqD)38£¯•E¤.ìŸ³åí‰B°Ü›5ö1@É­õ’Ò²¯1á?\\Z¼Ç*´*ë!eas°‹v ôÀ¯Ëx²œèÒÔE\\í@jÉddK)·f¹_fíc}†!æY£På•TOœf”Õk’j×³İæ%)aßm¬æÊñTsÎş…®iY¥“/ªCMd¢®e`öhã,}£½ô^Êusµ„ÔêÂ|ù0;,§…¨ëİawhÚ.Ì.‘Úó\"øQÈrÔHæm\'ô\\®[;ÊÙ¬Ê“FzØwXñ\'Û‰|&‘Ôpä«o@’±½kFÚ{¾ “aÒÅz]…ÿ\0GçX¸ÆY;\"P C¦ÀÆÌ{»›wy‚:’»ŒX\0U¨æêÓ]®µ\0éá•9O¦ŒÚ3ô¦”Q§rDmİİïmÔ;Ñ£V3VÃ±4Õ¢Œ»*PôB¤•9nã;â¤ì?HZZªYu<3ı QndÙÅ½ãÿ\0ä’åuU4mNÁ©§jzy/kÒeŞ:I+ä¹#t¤6V#ÃÏ&zïuİ|ùùÊŸKsRş¯hÙ\\ƒj¥C¨õH§Ä÷Ã{Æ´Ù…~G‘qUIÚf™UDz#TÕE<¤+}ô‡6ŒŞÌí²ƒlznËg“#’®™ˆšá©@ ¦Ef¨$İÕÎÖ%¾rˆk8F4ìCQÕ!c½âb4ºw°7¨ÅğóA+bÛ]‡ë¤Æ‚^İaO¢é²ÅáZ:œ ²åóÆ%¦Wøh›Ä¥´xÙ\07 ’úBf¢*Œ…c™cªi&§s±VÓ 0?ÂÌŒ|Æ‰IB(ceBu0À¦ØÅ?H
j¼Ë=¤§‹N…HâŒ‘°gv2ô°à0üxğìFû~’Ã–`!¿ ¯ÙZI©âÓ•fj+(Óşí6ë4V`Öò]ùk‹$\\u!·Q€OFmOÃÔó4OÕ…ª’\'ÿ\0e+¢ö€x]Ã7½i*ÌgKX<J9T€QäÆg¡ƒb…i³‚%Ø(°>à0ÜŠıo‚ù–mÊ>X‡._NÛñ¹1=ÄÎÔ;,Ñß	ì÷ÁùZª–×o+bµáUiZªÛLíHƒ¬{òÅ*È£º½ØDò:E½Ø¾Ê©á{jîùá5ªØGÒ§xÕ
Ë`†/¨Gg½ğô40¨5ğñTŒtÇ2¥PÛN‚!XâÍ·S‡¥5iŞø¬ª¨
S† y™Æ‘ÏÏ\0)Ü^}eñuµö‡S˜,{jÄi–®E²ïSeÕÌÄé<úœZSS¹”ÎÃa®¯Vöô‘Šš©iÙIĞ‡ß‡*2Úàãcñ¾ TSM·ÙMlfZŒıDW\"ê:cQğÄlÇe¯Š[?¸1¹M„ÆÚÈ+qÈaV>›dÆÅ&ÃINüÉ_†!ªò
wØÊ0¦øuyâÖ¢…ØÜb0§$â
ŠdjdÜb1e	‘–ël1–&CK£{œ\"£)Eh“ÚõÕ‹Iã‰U´ïo,r8ßç…Üu‡c³Ib[êÛ&0õ}GÇBË+Ò2Çq‰Áå‹(¹olO‚’%íğXCJr¦:b~®™å­=‘Š‰©I[‰¢`3â.ÛÀ‚Q‚X×m€Ã9TTtÍ(†Y´‘tˆÄ_˜ÃÕLx@ ½O˜i©õ¬ÃÖtFH×IFÑ¥Šó:C{³tÀ£Ş©ô{’&_]™VUSeñi•V˜0iI¬Ö‘n‰°¹^¸3â0£‡*Š§.í/héU4P]¨Dj^NÒ3f.›Zà²›±OIÇù<”SÖúídôÌâ¸åÓ,}(] ºésÔŠµ »IÏ]›>EQÖÁ57­¹­f
KÓ˜åTq¥­íh·‰±ÚÄb£ˆx_$Ê4Ïkid«,Âª9#:µuÑ¤Ñ•ä«sĞl6Äş.IÃ”‘ğğsBÅÙ€U°ïÜ÷u°ÜŸ¬w>87p´ÔægÏ²½}jÕ)©O&[Üı¶òÁ\0Fòƒ3N#¡áìÇ&È¡­Ís«+ıa%AZµš–J[DëÙ—=èf5›W!†ôbk¤È)¿£+˜Vdš¥•Y\"Ú=D)F®ûµˆµ›¼U/\'Î2\'—2‹ Ìsyiô4U—¤!Og¨’}\"Ã{êç¬‹6ÀUÆ9æOšUåPz›S¤±A\0+ÚoÑ;U\0K;H.ÇëXàK*‘ñ’ÒÏ„rÙ2n®†¯‰d”Õ2®™XF°–˜ÈªÀÅ­˜ê\0¡¸%˜(7írçYÇm–¦ZÙFN)Q\'…eyã}`vƒA1‚(¦_¤KÛuk¸?ˆësœ»<Ì³JJz¨Cö¦¦6”Ä;6#D‘4A4›û!	êg°VM“ñÅExN+ËiªªeIµ¶T^hÔ¢„ªKnŠ6*H7ÜñWµ…¡¬«ÌxW,ËòikäÌó|®–ZQfU1¬{ÚµLnEîM—r¯q€^	àÌ3JJ¬Ï)Î¨©+	’ŒÔE,¯XKi{8ãåekíe¶/¸_(¯Ëx­2~&¨¬âEõ¶¼“1’\'‘#W»‚EØë0ú€0È\\êU-eˆ´¹ØÙXš6¸ŞÚXË@=!mi”e´t¹g	ÉÚS4AÂÆ€6³½—˜Zì-½´í¶3ÑéL|i™7m3S˜•½­Z†İAÒv1­gÕ†.’U&ä‰\"ô‹ ŞûZö\0ïof¿£íƒ‹óg§õr´îÑ¸ubáopÃ “ò¹ÏÌ>“HĞUCŞ\'ÒN^¹o¥®£…)Õ¦b]CK8”·¼-Üä,6;o™\\´õsúãRË£´}£FQ‚cq{ìy“q~~CôçúÂ*ŞÎƒŠZ©(Á¬Êck¯Òûß¦ç6ì¦
Háí¤¢îÌÒG¼Öİ˜øos¶ÄÜ‚,ì9@õ\0Ú÷ñU3TÉøÊÌöªâª6§EšÑ«ª7)\"í{·ü\\± ğ®EK–eâ*%³ip6\0}€oÖ×æI#rÑICœE2R4P­»è²¼e®oÈ2ê½¶İ0Q—Vª\"§‘B+²¡“u»½®7åĞõòÀ¥#N³=÷´¤7OI6z6aÒØÎøF4ª†Zˆ«2\\Ë Cÿ\0¤[F6{é“—L5ØÍ~xØ0±Ú	Moi_F4…¹6·Ro‰‘eîèXZØy ›™ka‡«zxİšUTPK16\0x“ÓœŒ¬ n\"á£‘’À„TS´\'gS¿3/ôåÂ¹C½6[Rùıh¸1eötSüRû\0{‰>XÆ8ÓÓGg’4qæä4·6ƒ.úIÈècÈÿ\0dg©‹J[˜Ô Õ=‘=%q>O—f.®Îh¡¬vÆ¦¨÷ÊÂìwµ¶Å&aÇ-LíÚæZ­íÀ:|Èö‡ËSáÎ\"¥Éë§«l—-Í%œYåÌ‘§îC“pMÍüq}OÅ|È«?SB•‹4œ-ÎöQqø‹öÇ¿®¬E5ÓÏr\'Z¢T„“çç7jïIÔp¥¨è§©ÛQ,t½€±Ï@ıİ+¥ô³E.š|²(™lêFsm‰ì7$õæ2š|ë‚%B¨8²‚áBˆ*á¨T#ë*îÖæMïò´µ“„çxÃ1£ŒHJÇW•öšPûJm±ş\"	çÏúœZ½MÏ‡í:4ø~6OÉüÍvÓdhâ¯(¥q¥İs•º®Àï~g‹é‹.b}k-¯ˆ.½e
ÉbªÚÖ¾Äü±†
:Ibì¨ø¿†&Œ *;ZMÔİ\0ÔÃÇs¾şX™S1¡Išïê¹¤,IwÈÕ§Ùåâ|¹b“‰¸ÙümúËl½ß	»QzRá€ZJÉ¡!­i `y}¯µıØ(ÊxÃ†jdÁååC0R~vü‘ã1ÖeüIM)–^ÍŠ„P¤ÆÊºõe¯q¸ü*ä¢…=vŠ¶™ûŠL´ÒDYˆ¶›ìŸh±ßW‹T:\\?8ƒÂ©n·~SÛ”uô“FñH®;¬>ëbWkçÓgq]$§Í©ú¶¸ªB\0Ø·;nFÆşĞ#©Á/qšió¬Æ0%v*z‚ìoüÇ00ÁÄHö–á—ö^zú^Å†ØƒS—öÃb¿i§ô«ÆT óˆçV\"$švç²îzß¯>WÒACé·‰¡‘Vª,™ïdufåçÏËÏ–ã^&ƒ¡ˆnWá5êÜ’[¡O»•”/Ù†rÿ\0NtQW±o®`ŸxV¾>X“ş–8Z¨Yu+A& àx©ß§N¸èÑâô½æû‚¯
­Ñe±„ƒ…\0Ã®+#ã.ªUjlæ0XiQ—í\"ßn$Ñçe[i¤Ì)*Â9•Ê÷ÇJ–2_aœê¸Z´}µ#é,a’DävğÄ¸™n5.\"¤‹È›bu,pÈ6™Ağ8\'#¬’à’\0 1Ù¤„©Ò0Ù£n§Üp“C\'™÷aBw»ö–ÚÃİ…+*óß
4rj~XRS±Y{Á
×‰¨æ/…-@è0³EÖöç©ªoºYZ9RÈÃÂ¨·-°˜rö¶äâ\\P˜¶“ğÂX¥ãU[¬ŠK·\"Ø‡]¥úK<ƒc‹›±á†¦„0è1AÄ\"šLÃ9°ñŠ­$•îk!^Ük‰aŠ5$jPËv{Oµeqİ¾Z>Îi2š:A–ÖÊY²ÓÖ¥YkR¨„’·u·3ÊÅ™ítĞ¬…cú{zÊzÖ\0Ø6“`-º›x‹àŠøÓ*ÈsL—/Í˜*TVB@²AÇ*C¼ªÊ¡½µß ¦ª©´ÎÊA2\\Ù<uCÃ4*F]*Lµ+ˆÊ«¨¤¬º¶[¶İ\0%n
²i¸–»2®“2‡&á|®&’:Ykšª¡›^£Ú,k{[‹lØĞ¢sWG<%Ş=@Æ$¬ëuÜƒÑ>|¯Š<ÖW™fË¨rIªé……[]PÊºI!uû\0¹Óí\\6Ø[^ûÆ-­ø‡óüï6ÖyÔ9¯Sy²ùM8>¼,ÄÜë³*°[3,H6f-.›„sÚ^Ç‰è©s*xkj*!6D€#1Fª¦ä\"‘}jNµèÁ¶ZÕqM<‰\0€F\0!È‘H°ömb<ÁØXóÄÖ‚ŒÔU#hí¹Ak!`=¯#ng­†ìé»L×?Ì+*Kåµ9~eK$‰%@©-s@®
è\\Ë«a¤·xİéf¹¥}%UNs>G-2ÂŠTÇR«%LjÑ£*Ú´—,,AÜòägTgõMK-uT9mm\\íMÚRPK_\"C°ŒZ4`¤‚_¼d=2Üş¢-Š›„`¦Í³ŒÊ²ùŒÓDÒ@ÈS³%V;°ÒåK.Ê†Êv²M¯!ôóçÂ[d\\GWÄ^+³r–~³šQÙLµ´ı mí‚ƒkè‘¶á®:£Í“5¨¨|ÍÒ‚¾X¢•h‡ÑÆˆ³¶ƒ n×_m‡L5Áy^i]ÃñQem—eyrÌ‘¬0PÊ¬Ñ¢°>Ã–¼’_™,.ç¹”•°˜2Ü‚(s)¢ÕQ[OH¢›FÉªÏ`ßVÜÉ°\0¾šQ±øJ©ı`ôÃC”Uv4óM(%ŞFˆ‚Äé°Ù|÷Ûá¾†XGÅY%\'v>ÛéûÚ\0wöA-bÛ·ğÅ´ÕrVPL²HUí’Á„€l#µÀ*EïàÖçÔoÑå{ÑñW‰r5K,ëØ£»ºı%®qËæ/9:XÒj¦-á§^“*’ŒÈÉI™¢v²›‘e*6#pN÷Qm¬wÁµyAOIMQ… 4ÊòSÈËd`ªÀØwI#EŞÖ$ß|e^’ª¦Ìxegš`s(ÎÄ–CÊãÙ;:‰¹ğßi+Í(zz¹ÓvÚãU`íµ†Í`:X	ÛsáC–¡aÖÑEO)G[ŸÒk”ÙêGÛ,“ U1¼³j–ÌÛ’X&Á4ê\0İ€ç‹LÇ‰„‘%eÆ8\"ï^û*¡º°K(ıN1isŒŞIHó­\\Íf©yÈ]w¿¸sØuå†2Ù3JLµ—L2åí\'YÊ‹ƒ«È/V±Ü\0:Ÿ§–Ú\'–@˜álñji¡‘šmrD¤öƒK\"-kîoËù=Äüi‘pİ­çy½&_	ö{gŸû+ÍãÉ¹¤Ş\'¡¥jz:åË£–5ïÓ––R¾äî§2{«{xÏ«sŠªª¹*Úg–¦On¦iLÓ7½Úçålh8ÊyE†³BPvŞz??H…Ex¸_+,¤5¹âŒù¬C¾ß8Ã8Ç³î\'‘¿^æõ™¢q=*–‰6?Ş¹ÀåFa3Vvkfn^üYK“ĞeğzÆkV°E{\\›|SğÆv­V¦ÓBÒ¦š™Y%tó(Œ¶˜úGÒ¿!‰t9MUEfÈ¾-·ÙÏªj2ùÖåcU4l Rºˆ\"ü÷Çrç?Ï3)}b’ŒÔ h¢MÜj›^xZPg&ñ­P%­.-Ëräís:È¡_ã-ıÃ™øb)“/ÌXÉ•ÙàMô•‡=ıq÷¤Z%ã*¦Œ:zkgŞ²8³lÖ²;S¬šÈ1ÄÖRyuå‰^‚Ó¢\\ô‡„ªÕ+efLÅÑ—”GïµÍi©²óÏC™Cì`ik’õ†5NôM›Tfmú¶ T¿d×Xû-‚Mùà{Ó_ç\\S“ÍšP˜ıe*R-¯Ú01lvÆ\\5:uÆ`t›1U‰ËÖgO6KşÒi ÿ\0Å†X¿ŞQ„hÉf6‡8¤sû¢©/ò¾,Ú¬ú×h²\0>{XşvÂ§¬¡©€ëìfÌ£Âöß–4HìfAÄ*’=%}=Ÿ.Ìªbğ0ÊGÜF,é¸ƒ¨Ğq>gaÒIÙÇÉ®0˜¹aË(Q”£…E”Íô‚6\'Ç—ÉÙ¡¤¥ì*Š´2*±ìj%P¢×\'fß–İ>â–áˆzÇ\"zˆg/q¤ªcÌ$Ëó4\"Ì•”ÈxíÎx¾VÕëÜÃSj.Y ¦h–ãtq¹°¹ç¶òAS]S ‡3ÌR0åSéÎÄßúÀom±{úª¸7s7‘öÿ\0mMº	<,tı£DpépÒğvaJ×¾º\\â^v·²á‡Ÿ¿~{áØs®
bTqU/³´±SN‚ÀƒÑI½î~BÂàÖş®Í—•FY/¾™ÓíÖ~ì%¨óUö²ì¾AÔ¥cò1ş8éÕÇïcé™}WLCÆé¬ÕdÒ©}]äf;{¾DL‚˜LŠ)ø“†&öoû{ÂÇcsiyX_¯KŠy‡õÜ?PŞqK¼ê~ÌWç3ÑÒE~©WGQ;ˆáíaÙ›Âà•å|a+¨ßÏÒâé“4DÉø‚fV‹)Š­,5=}<½/°×s½Ç.£¦øäÔ9½4lÕ™p¶¹»QJûû ¾;‘a^¡—0¨™\'ïöhw@7¿»pÓWP!jzÙéÕEÉYJØ|Â:ßãYTë!Qñ=VNâ(³zÊ‡OdÒ”U7·°ÛØV¹#Ëı\"ñjÆ–½¸2Â§o|dxbgR‘ıqQ*ßnĞñ_¦Ì397«Êò*ß9òè‰ê9…ë7^§Ç)×ÅÒöI_âg¨˜ZÒƒôš¥J¸ŠúöR-ıdù+âğÁ^QéC†gTJ©«idco¥‰÷·Õ¾0áSKÿ\0Xá*¹ô•Ó›í¿vOá<|MÔƒ#XåÙÍÖ†`²±¥¯Ï©è+ƒ¨q\\P°¿Ğ1áØCìéõ?­ç¥ò%Èë›öîsÕeÕò;õÅçk$oä1åCM’Ë«³Í3(’o=R[ry£¥ù%eß¬(^ù_ÓÄ/İCE2‚ëÛíä‰ÃWŒƒí¯æ%¸P÷Æzš7‰º‡IŒ.ÇwËøÃ)l4ÈsòSYwââ6<şKâm‚I\\T¥0àº™WëKG:J=áP¹ğëãñĞ¼OÛµ¾qÃë®À”Øšb6	2í¾3ZJLµ
ì³ˆrÙKiQS•Ëf;òÒ†²ùc¬£†ªfŠd!e*J‘q±±ã´êÓ¨.y‘éÔ¦}pD–%Øoˆù”ÁbRú´ëQİ[Ø’-ÓÇó×O™eÔõéC5u4uNº’+0ò#æõqöş¤‹#ËÙ™_I\0\"Wß©÷sÁ\\A0{7ÌhGò*Í#\0ÚFº¶½¯±æF×¶2?HiM]ÃlÂc\\È’°BÅ`‘´l²(![Y*EÁİ¶<É‡´	,C-Î+}kµjˆé¨Á2Ë±È\0’à.,7ŞÖÆqW™W6eêóÑşÍ1T$İ¨’ä3v¤‹®ëa{\\¯´5X¢«_KÁÖi9voŸVdYeDU°@{xª3
í§x“I›H²½œ_H¯»ÚÃQÌÙ|UmONeIåVL¥‰î(ÙI²ò6±Ë—3€>}YOg•ÇZ#‰iœSD\"Ó*±\"åup4î,bm‹ÏC<M™ÅME’×;-E-3E
MÜ¤(`¯Zòû*µÔÇQiˆaÅt„œ_ÄuÔ›qfi‘
,ï!©AÈîá¤ºGÚ(}«¤s.¸™é3Y²üº-Ê3KÖæT´í)&‚1,ì6°ªßV›ûÚ_M”×R6AšS¤¨ôí,”Ï‚U\\:ôØ.¦QªÛHå‹ºX2`Š(êUÊ}L…96nGP,I{ÛîN¾ò­§ñ³œã6¡¦Ì# ¨ŞGAN²išb¨¶RNâììAî)$ƒ¾}ñC˜ÖæEh™ôõ²9ŠH„l”¨…ãŒ1*¥;±·´Øì1AœÔIJr|£%®5rÎ’SÀc~Ò>Í#bª6»Ö¾ä‰Ó ırj¨3)¾ª!d!g„+¦»¼jºŠÓ¶¶k°³ó‹zÂ]%ßåf5Ÿ«û\\’Æ¬Ô5#ÈÚ¦V@MãVì×P»i éÔ;i$ŞŒè3Ê¾<âìÛ4ª¨4«T´¹z³w@ìã/ ëïâaoÂï[•GQYTvÒ¨–	®ZQµîCİG\'6ş 7-qçe¼ˆU…]D¨İ$
Cr]\'UÙÔö×èÁ`%…&
ĞQ´=…J	‘õG3¡KE”míu<í°á¹êÆyI=»†Š×Ò¬ûˆ\'aİøXcPiê3Œ­t=)Š!¢TpwÈö¬/{xŒe‹˜eüC›M—q¼i0¬ìöt	-¤[bÖné·ÆøåVÙvF!^şuœÏ£Ìk!–‚ªJiŞA. 	`¬öv$¾Ü€şuµ9£Så¬³ÅJ%È\0{ìHóÃš-;ÉQšÔH²dh•Á—JîàïË—B9lg¼J­¡ìKJÒóK}
£k[sÔÜBØÊªÙÉë 7P!FWVµUO+Õì¯$²¼š4ÛcŞÀÛk•ò<±cAÄY¤õOAÂ™dÂ¡Ïo™íÅ},n
‚Úˆ$‚İq•IÅ3ÒÆÔÓ$’{æáeUVAqquü‡˜Ãy_æT™¬u¿¬iëQè’H™I¾,6÷­­ĞŒ:\0l_ç(ë¤ßx{ÒÇdœ@2Ş+È$”Lâ=PJK0½‡d³ğ¸IµÆûco‡#Í©\"ª“-Ëêâ™«INxÇ—ò_Iü?C”½Fk–®gM,mFµCYAH´z\\8<¶$|:ÙT~‘™ÕEgªÒĞCE
ÙVu„3»X²v¶›ß`Àî7è{4ë\"‹qT¦]ÅõUt\\qU–ÑÎô´³UÈ!îl€obã‰hc~áèmİ“1;İîzùß8¦i*xŞ–ªKë™ÌŒHµÉ±;tçË\\H¶á.#cúÒ½ğTe¨H#ç)³ºI•Mt‹iñÑ¬,` —»§×ZûûK‹\'ß/¨,.Dc z3ú¿/¿?]KqTı³	ı-=#­¸æ‡ÿ\0§7şáÁ_¡8Êñ¥m»“u¶Æ6ÀÏ¤¯ş| ÿ\0éÇÿ\0pàÃÑ„mı<¢T_²’Ös¡€Â8—ş;Ÿâ?…ë]<õ¦ôD³ÙÜ5ÿ\0gm¼;ËŒÛôô!2şbÁmWSf\'‘Ğ–åçliˆD©ŸÔG*°\"µÖÃÚ\\eÿ\0ş ²vy?‘m^»Qkÿ\0f<sø]½Œ×ÅÅ±^ÉÕ™XW,¥Xªµ¯µ¯†ı<ğˆ3	!&f‘ˆJw¹-­ñßñÃ•,qÍ”mvmW7óÂx„öô‘•…\0Y9ªt±Úÿ\0ñ¾órI«*d™›De4¸7½í×bGNgßTË¢
Á¶¹>Ñ‹2İ|<±HµEh×`Û-Ş,K¥«‘¯¥èPÌ-k`Ão»òáfB]gõ¦Á¨®,7+°ÛmÇ	 ®jªÂ#êËiR œü±Ræmq™›´‘‰½ÀØÌyóçâ<ñwCšv0ötŒ±,çBêç¯~|É½ú[4–‡ÔÇ%S@¬;»^üÎÿ\0Ë‰cÖª1-§cÈùàJ›2G§‰éÉeĞ<µorG‡<]pËË)’J†]^À¹ ïrN*æ]¥ØS;§j¼ß…èÁ
gÍR H½‹_íÁD²¬1<¬ªM…Î3˜x«9ô•ÂôòSˆ)£Î©Ş\"]Kø6éÏÄå6ìa§¶¿1=èçÑ†t*ªdˆAR`„¡?ÄÙ|^ñŸ\0g4¼7™K.[+Æ”²³ØĞo{tÆ±èÑUMA€Ğ7>üYqŞy’Óğ®oùµr½Ê‘½Bv(@\0^äŸ#\0ML8vÔÍó—UvÒxÙ¸%-«õM¿ï-:+|À¾&W—SC,Í=e4Q]‹&a4j ôp1qSAÆSê2nÏ3Z9IÓUW¬H6ÒGÃ|qí	¨€óå¹òÉ—IÙ…òÔ›Ÿ@ÏëDXJÌƒˆ©s2Ê2œ³3®”MU\"Mç´VEŠF¸,/í*õÆ¨Ùû\"~ÌFü†i=?pÈ¬ÉåŠŞmIQ‡õOÌçz?ä.,rš@?†0¿v”Õ†±nì­¤ò¬™ÙŸ–#Ë’_nÏìÇª&àŞ“\\«ı—aøáºná¸fš-¹,­©~]~8‡†P®ÓÇ¹fy¿¤
\\®?[WuF˜Ğ‘¨ï°ÚøÚèığZUhJÊªâ—~Ğ;§Ã¸·yœE«²zŒş²8$Õ¢ÓÉA\0X`ñ^aÓRÔ:M!˜=Ü0¸_rnZı~ìs¨51Q•’ö$Mø¼Âš²µ®/6œ›&á:„PÓ·•ê¤}öèXD{ñ;=—<¨†(¸n»*¥r~ÕÓ¼ºAÅBº‚våïß×çÎÕU²æ9”p¤ê)ÖEW–0–7U¾› Ú÷ÚØç¤HÓTVUSÒğí$pÁ3G=bÌ*ª¥U$YjD‡“j òÛk›õišj·Qo–“YÛÚ3Ó•œEPÔdÜ]M—f‚pš«+*`[ÿ\0VVG´r®ÄçVö7c.“Ò…nQ—×ä¹D’çZõñäùpĞK<`}° lÖ½û›óÀúH§›‚V’£6®ª3‚l¦ª\'q—î54Ú¬Œ¡UÂ²é½À\"Ã~Šj¸•xú§6ÊûÏ4§‚E§z Ä£JèN®ê‡<ö:å€a5MÀgi¹pŞOÃœG$\\KGM˜ñ=H,*#I&­êï±íÂ¬*¥®Œo`{Ö¹vTÉóèó,Éa®va*é!Gßxİƒ¯}v»µ‚•;
Ñäyp¤—:ãJ¬Î¼<µË—U˜å3onÖE:fï\\a­ \0Jœ?]Ã+[—µ	¢’1ÒA$µAAìI¡Î½V®.¥FØ¨k	A¾‘Š<Jü’9*2¥©Ì$a‰®S±Wh„’°¸¯b,À‚	¾\'qæLt¦RÙfcA]Ô•Ì“Söª.WIe.4½ˆ*7R¢Ê×Å†WÄÙnS¹Í”šiSL¯Q8ÑO +Ş½ÅÁíD[lRúZôÂO—Å“P×Ñq,±Ò¿gQC;°ºú†­îMˆ[rI±´)–÷„W[0Îªë8’ƒ4â?ÕÙvcQRË½!iiçyfv¯bem^¡e6ß3Î44™Í<ymoOA&^Z¦²¦šp×*ô«>îÚ·¡Øã†Ÿ*Í3Y©½z±ïªyñ€.l}É*ma©¾ÃDÌól‹.§£Ï;e²²Îö(õ
ª6[)6 bI»ZÍÏjÛh!EçjçÊj²§‘e‚¢jy¤»Á:«Ói²•R–RJ»jRMîH$ÚÑq~I•ÉúêJ˜ëª$)Ğ¹Ô¤1îÁÖ5îl.‘¨)êÅ6cÃy-e},Ù6AM#v3“¥³ß!ÌE‚¥Ø]ë÷È8³Š0ÍªáÉcõzZ²U‘cf\\»‹jÁˆ·K[kâÁUÖ^[Íˆ½2ĞÆ•dVÍ$sÚÓ,J,¶`{¥WW05]n\0ØœÏÇÏÆ4\\S*ìšœÆJÄYcÊ#HÜ÷F›(\"ÆÇa|`UùƒL¬‘‹ª’,§İ¿óëˆ­Tòã¨Õ$QßJ6[ó·†ûü0ÜÄÉkOZQT®QY‹¦¡7‰K·uT¨`I½ö&ÛßÚ<¹a¸+iò<®W¥£†iÈú/ªHŞB _n^Ï0}9\00ƒX¤ÉI_r3ÇÙDÌ·I¶\"÷;jçİçq¶(h¦Fg¤ªtı†¥¤RP›!PÈHµ¹1s·•ñçéb*9-¯Ã^ßm$;AN?ıŸ0¨ËhYj–dT—°,Àj$Úİ	ëÖÖÛöc˜êª(äu(f=’ssc¹#—^Vßn„[æ<E%6w5{å‚®×¼’½–ì.»ztí*¹Å{‰oP×Ö{¨£søcª”Å…Ä±´‹SPÒ„×¤€›°\0_sĞm×¦ŠFtÀ,¦Á™€\0ùóÛL€GO»_ÙV,×ñÛc‚92iªr¨\"f‘$í•h•B6ëª÷¾Ü¬Aæpëé „”kG5<ß²Î]*Qâ{\0Üåˆq/gU¦¦×$ŞãÙñ?å÷`Ó,Èjc§HZF$ÜÚüş±ÜùXrÅµ\'Ä
´ÔP êÒûüö8^l¤çZÛ?ÿ\0óN\\/rßÈoƒ>#š¸S‡ ‚håšøå’4`Yk¹ n9Œ$Ñd4äI[œÓØ+‡6c|8ùï
å±Fé\'i¸Ö¯Ò÷µílã2Œª/ØLŞ³5¤\\ÎšJè^š&- ¨¡\0yï¿Ù†8o/¨É)ééšH¦’9„½Ğ}«‚¾n_ÇT“4´îñî#cp\0¿—SÏá®2Ì²|ÚÄP6ÂiEeöÔûZÁ7,,A½°¦­QAn½£V\"B»ÃÈ¸&³>ª\\ÿ\0ˆ¦‡\'†»8ŞE`Î¤“¥W®÷Üıûbész<¶™)xj…òæ‘45[±iä^®X›(ğPzù€+=!fyET•4¢¶]JaÔúD‹ìï·rÀ\0\0²‹»¼kOOYWMU—²±…[Tr›¹6=€!E‰»oÈí½±Ë«ÎÄóOÒtèò(òÇŸ>v‡y~ošÑ…—.Ìk©ˆU:—VXA»1!¹’<úb/æ•Ü^i“ˆªjsH’FšªŸ¶ \0º÷]V[Ûs€˜øæiZ7†HxA‘âºöVì€\"Ç}¯È›rŞÒ_²ŞÂ5e•Z¦Rji½”•ñ¶Ö¥í½ ¢ÀXyóú|ašÈMÏŸ?¬±l—%DC&WL¬ ’b.ÊA\'»Ë‡…±·†òWB­LÚ#0°!ÙlXÙîNø­^8Ëd:{AP½Š¬àö@n-kùÛ·duLÌ§$FŠ7»\\Øµ-úXØÂUB|OğKQ;áçá›‚òY£0(’\0^HÇÒ€ºn|¹øóÃğNL#W§0J«¬èÎÏ¾a·÷bL|WÖL¶¯ÑÛÌÀ-™Fú¿tÈ›^şFÓ)x“‡šH•+b•d‘Ú+ÄTº[¾ü­b{Ö¿KâïTÌ´	öD¡~¡\"%dê]·B÷Á¹–Åw_–§áÓµj@º6¹¿pŞüÈ÷íq‹äÍ2:ˆ¢dÌ#‘$‰İ&–1!6}÷H7¿è’s|ºe:ki¤=¿|‚ª¦Âä·$kq#İ‰Í«{^W£Ğ·³ù”òpäÂ8”Õ3$EÚÊ¶roµúö7½‰éÏëès!—­.W:Ñ¸\'´•äÒöÛ`O³à|6½¯‹(«(u8JøÄT:™²–ÙTßëxta¶ø“U<¿F“SX?ghæ\0Ü[îßÍwé‚êƒ©•è´O¼®£âèrç§’MR‰™—¯xûúoĞôÀœ4µ.qC1YbÓ‰ÆGQ½Á¾5øÙ×ú®É†›‚ ën¾å;dôÇ%`İİ:--euµ÷#îätáË‹q¡Pb[Lû&Ò¢“:ª«kM™O9#ı¤Å‰ùœ[ÑVĞ#9÷_’’9k§§•¾³TµüH#ÇË§¦¤¤Ç…‘YMíğ?›‘`4.=ëp-U§³}i>‹2m<´Ëÿ\0¼ø5Ç‘8KÒÇpÖKO”å²Ğµ8cÉ$jbŞÕîA$ÛŸ–¬Qş\\N;³Re.ûîapÉÿ\0åïÛ1´Ïyœà*ß¤ôŞ>Çéÿ\0HÓPY²\\¸ï¾™|üM¶ßÈsğÄÕı!c+pö³Ô‰Ê£m·òÅŒm(\'_·ÜMïc‡ô‚Ë˜}\'T æmTÛ\\ìÂß<XÃéç‡
ı6Y]r 2›åÔı˜/L£ıĞ}
¿öş&˜ğG_TSÒ°Z­F]2Ë€ÊA|!&93H;¤ëa½ú©Â\"ôçÁÒ&±O™Ú×6‰¶\'÷ÿ\0„âl^š8Î—¬ª‰¯m/½ïn‡óq0÷½Æ²‹ƒ¤âÏÑ—.Ï)Ú6Îhà`eØDë·+Ø}×·–Ûô3õu‡Ò¦RÅDùM÷<·ív±ß–7èı,p+ş0Ëıªi?÷|Æ%Cé+¦ˆ©HóWxüí‚ÏFÛ³F¯U>ÏrşŒ<uO@(¨xÓ)š=™)Ú İ7²±Ülw?vk?EßK4É>Sd¯$ÈË;¥t¡ä˜»\"óÜG•ñë˜xïƒf·gÄ¹füµT*ıø˜œMÃr{A•7º²?çˆ—FûÀ4˜{³ÈpúôÏ%E-]<Õ‘·³lÖ\'Mùànwçå}‡ ƒ2£Í Ìãh§¤2Ó³ö‹#G*lUˆ>Á;ÈD‚-î˜³L²_êóGşÌÊxsÒöd2®$â,ÒšJ9â©Î§š—:5HÖ\0n1¸=İ¯Œõi(÷‘P@“óGœšjÉ¥yÌK%2#&‚obÒ±¹\0yyn!¦\'¦õ˜iÛMôÈw7å}®6¶ãcäÍE|]_NÙÅ,Õu‘Ô¤0ˆ§1\0w´(¾›u)±íl=ÄRd9>hÔÔô²”W±/T• ‚çR’Nä‚6=pYE‚Hş¹\'¤®’J=RÓ´ÍÛ…G¹ÓfK¨\0XØ^ş|ñ+%®«mPÃc‹fs-co+CaaqænæfĞ= ”«\"ÇQ§C6³sb/Ûk±¢J\\¾4§§cÛ(¦”½šÄ»H¶äVö°cx‰Î*‚©Y^WNæ—írHç·Oo<Š¯¢\0Y,à2î@acËÊÿ\0<J­‘–O(Ğ$³¡‘\0$x‹¶élRÈŒIB’yr·Ï‹y‰ÒÍ6¸èl-‹LªLº‹B×,‰0ci!º‚<Ú×äMÍíhÑz¼0…‘ƒLêÂıÓçãovõc5IUÖÍrÚBm×—‡á†ŞTô/æ¯ACQHT–™ÒB@\0‹ûXòß?Îó|æZº©¡«xS0ŠÍ4åP2{#k\\€:Ï†=\'œşüMU¹ÆLÅÇÒöÌıâ6ˆîG<f¢oÖTEÙç3KN«Lu6#èæÀã.ËM¬e×YçË)}eä®Î\"Ö×\'³É¿Ã©¢Èá°ƒ/«¬`y~o˜Æé?Ñú1 Ë«¸š£&ªs2Eú¾iå\0\'V¸ÖÜÇ+à› ô3ÇYÿ\0PñfKK“ÏK[’ªNØElUb#˜ñÃ=ìÖ0¹ºL…kê!§>«’˜Qw`ÖU·»l;OHÅ8¶ÄDıøÒ8×Ñ/¤náJ¬ó‰²Ü¢“/KFD]¬¥›–Ãkxß>Œıú@ô‹KY7
½b toX‘c7`HµÔß‘ÀRöŒR™IHÅÄ“KI\"Åa{®Ù†ÎC,—jŠê©·7şül§ôeôÁ%9’LË+Yş*€\'Ãp oŠ÷ĞO¥.£“ˆ3Øá“-¤PÕ¹‚¾VP4Şç¼ÃÂò>ğ¹ËŞf¹PÔ@³TÄÒ“Õ¤?ÅŸ¨dôĞ*Íê1Ä¾ÏjËo·¹­µÑ¥,A;IdU]FÂ÷ÄŒë$©\\‹*ÊşÖ¤ªHG{»vÕmş8‹IªZS¾S —ÑVd°Çt®¥	ã¸ÿ\0Óˆ•Y·Ö2Cn¹Ù‚Ç¦\'±$Ú×#–)*ò:¼–…èë„}°»¨Xœ3Â\\;˜U¥i‹ÕÅ@½ÚÍÜ`NØ¤Ã&¦òÚ¡ÒdÜ?š™=j¦²ªŸNpÆX\\ğ)™ÉÌ«dsEQï¨éb¬ˆørÇ£=ÒG\'	ê2?õÒ\\ƒË—ğãô—=gªÄ·m_4È|U¤6Æ53Ôu#i¾­ªŒâSAês1U-«Šãê×¡£Tõ‰4¾á<¹ò÷á¬®?ÚFÖÛùa7Œé£Uì\\?g)Óu™*œ£Iß^Ê	ÿ\0ZñìÛùc¢³)¶Õ‰áì°ü0Œïƒ*²ê˜éÄ#¼šA(\0*tØÏRA-~G
Ÿ‚ªièÍ\\ÕZcF³0Šàsó¿O?â9>5Yk×#øßv™cÖéÏ½†#Òğ¹ªª–ë…ã™£ÕÙlB±®M­¶ÛîvèH¶‡ÑÜÒÃ‹›C©:LG˜æ/|W!Y±
åoÚ©?Æ¸ùbËïİª¤¿ş\"â<œ+SZÓ˜µ˜ÄqË¼ÊEº›©Øn|9ÚÆ“Ñöc2–õÚT±0nDáç‹4GyaÛ´c°¥µ…M9½¯ô£§.¸^’2V6 ÅÁ›†#sÏ™°ßËüCÃ5™5Q§–Hæ“±3\0‹(½ÎâÜÅ+)!”«a…  Y\\â-H§ÑÙ­LÚ;3‘+ Zm~Z··+ï…<y€q\'­Ì\\H’Ü¹\'Z‹+oÔ°ç	äõ49²ÃR‘²Ì!ue7FRO^¾é’eùUI%1’ªUczI²uÛÇ™ÂUûõšÑY©—Û÷™ÜRf‘.”¨’İ›GÏê±¹‡›1Ï;C!©vbÚÍÉÜÚÛù[§,Ue\"nÙ„l‹İßR“øŒXA«Q4ÒH´
\0`-?<3–\"ÍFyÑ˜g*§–à~Ñ¯±½ï~}/Ìı}Ÿ,m¬Ib©Úä‹–ÛÀ±Ğ¶éŠß ;ÊıçÇŠ3ë021mº\0@Ø^û/owÄ„ã. [ZÃÀ
/u~ïˆÕïòÛ5ÒU>o40Ï\"{Ğ€6÷Øaérüö*HêškG ºZ­ã§UÀ÷Œ!mÒ¼+<sœ±&Jt,ov°å|‡ï_g-°âz@ÍVæJUvÜ†#pyVúÛı›sÆ|ÕõJÅMS’<ãç‰mmDÕÑDÓVÕp@ıÓ‹8ei)ï¼;_Hy¢¹Lº7u½‡@wßb×å{VİqúAœ1-O ïe±æ7ö¹ØşX“?R¯¢*®+V©ZÈ˜…“³ş¸\'+_‘ñÆiëµË»8·œkü°štéÕ¾Q¶‘ïV­;\\ï4ˆ}\"È¬´-};X9·¹çaä7æ16I4÷%<Ú.;Åí~{/&×òğ#,ZÚÇnî†ÿ\0³ëÕV\"34qì9•aÂÒ,cuš„~’éc,}VpÄ•Í¹ôñ¿Ë¦Ö–Ş“òÎÎëJ0½‚\\xÛ}¼N¿,ë(¥¬Í
ÅIL“MÙë*ms¹óÅŸôc<¾ùlcÿ\05?û°+„4Rc0©õˆÔzNÊÙÉë.7½ÖíÖÛüÌyÙ?é$bXÉTí¹¾Âş\'{Ûÿ\0PóÆy]<¹™ËÖ;pÅ
ê0é{Û¦.xcƒæÏ²ÜÎ²	#C@ªÚO~á¯È{=pFšïò†µê1°…‡Œ8jF
Ò‹òÖÑús>ñö1WQÀµ±},Ô`óîêÃüVûzDkÿ\0ìáùŸå×7?Wù‡ùa£PlIÆÓ;ØøKé)ø-B,9“\0*D¥ˆ± Ç…ÿ\0$bVOÃ•2¬°ñFE˜…Ü’nH\"ÆöÅgô6¯÷éG÷›ÿ\0·äáyc£<;	µşX?G¬;ÄšØsî‰\"«…œ°’Ÿˆ¨fm6.ê‘…\0ßrIµ¯·¼îoXü™Ó]a­Ëff5 ãÏ­°¬Ë†ä¥¥5&Hô‹l¤ßsîÅí\'Õ.GC\\õp)¬Vx…‹5¼qyj+ê`å ÈXÆÉæmª«¨~…,K,ñ°çà	$Zøb*Èä•åh£·6ˆQ~crM¿ÏT$uI%njÕŞïŒ®¡á}[|±p8o(ìÖ?S¦:T„=ˆÕ{ŞabÜï¾5ú-c¸ü~ó«Jş©Ÿ¢áäÆs/¥ş¦’8eÎc2İ€V:ö¾İmòçl7Gé§‚V+*sH•˜€ˆ®æíÊü¶[ïÊö½ğ¯HNò\\@Ó§OôO‡/ÿ\0|›ıÕÆ§ú8[ıp­¿î_ñ¶<ñúXqşMÆY~WG“Õ$ğÑÎÒU†µ0>ï¶İ7>ô%é{…òOF\\+’TV/¬CO,u(QÉR¬ä@·îƒïç¶š fé¬9gæ?Ãô¹·úÌ¯·ÓÃ÷œ~ Gø¨õ5Tÿ\0î>9úHúPá>*ômšdy`*gIâ`áHW\0V¸éöô¾¿DÏHü?ÀÙoQçU)*Ş)¡m%‡q^àïñùsÅg×ItˆßÏií€Òßèkˆ¯Ë±ÿ\0y1CIéûMÏ˜Z¦r Ä±¸ µˆ¸68ô£éc‡¸£Ñ?åÔµULË8ìÙC8ıïáMÈÚ÷Ä5Ğ‹±Wxê›ÿ\0ˆQÿ\0ã¦3Õµ^BŞ9´)²ª9ªó@èİ ×ÈÛ¦Ø\'Í2ÚÊ¨²Ö©ÄôuiPÁ˜…m7Ø_¯†.’^kªÀ)ı$Ûg7·Ğ¥¯ïÂıŸÿ\0%Ò‰GÚ¸oŒ\"ª®©h§Xb–UD9×s±¹îÄÎÉóœ£,§ËåZ9‹´‰3^Ä‹ØPØ‰†“kôc\"¯
¨ºß¶“ŸN_<c—,Ü[^ì\0mFöşÛc^ôa‡†M¯ÚÉÊ÷øcô ÓÉÄù˜–>Ì¬Ì£{Ü	øäP¹¯RuëÛ•N
eËûX÷a4[I–ÿ\0â7ü8“•©õ¿±N—°†sòÓn\'>´ÄÕ•G,i=j}ImÚ­ÈÇ¦)åÌó#Ãp3f5„úÏ3;_`HëãˆuùÔõ5;Ã«ÊŞûøâ!ªs@”zWBÉÚÖö¶5™	ŸSWVÓ¦˜+*aV$°IYGÈ,L:Íã\'NiZ·7Úvşx©S°ÂËm‚°•s%ş³¯RN+j®,ÏÚ·¼õÃ‰g
ú—2«]¬m1Åh=ãŞØ–}›qFi_O-[Z½šikÔ±6éï£Ì*gª˜ÍU<³Ê@ärÌ@ó8Mğ™9b¬%ÜÂÿ\0GsM.`D³Hà<6Ä½¿òÆ­úSHƒ‡ÛQ?µË¾«ıAŒ—Ñºß1{~ü_yÆ¯úPFë—ğö¦\\ÀrØè1ÌÄéiõüNş•¾Ÿ™äãéßŸ³øâŞÖ¬ÉWéßû?.t_—i™÷ òÇtï|9£|wNıq ƒ³Ë~¶©Ûëâ	[ôÛóÑÿ\0LToğÄ[cBí3¾ò3/zÃéÍiÿ\0½şáÄ|KÉÇı+Oıï÷-¶0Tk6ÌÂ1è
·.îë/¨ø§SŒr²Á\0^WÁ¶a$ƒƒ*a¹Ñbõ¼Œëcm°š¹y¾3Uz¹ÂÚG(Oµî›^Èhe¶›èÅl.S•·rwv§{¨ØÒµ¦B¦÷†ŒÀ?ÿ\0µ#ÿ\0Ràõ¦¿\\@É2,·\'ôaCÄ*’IYRŠdv;*÷»£§Õ¨âÊX‘d&á!Tnwååøá¼7†‰7Ø˜¾#M–¨ø€brÅ_émTÚ…Ö©…º›êşX2ôLÊ¼1Å&çú˜ùfLg49<U5™œ‘³–=¢XÚ×\'ùàóÑÔ‹MÁ<_TÇ»*1çe“ìAåú‰Ò¡­Oøş†/´Çİ§åâªXM™µŠŠ~\'›Š¨á\'´“Q°²¨7>xïš‰Şyıaab;ÛK)ŞàrÀôÜMG¼/¤ª	,wåå¶>~$£UYUT‘k’ŞCñÀ³)ë,^Oâ?ªœtÔ¿~
*œáp:R¿Ş0YœÁ]F©HÂŞ\"Ûïç¶8±(x?…îÃ¿Jû·!ŞQòßú„ze3óüÑ¤ÒTóï,P“l5)f\0,­ÔÔ‘á¸8 ‡ˆ¨æÇšíÌò¸òÇ?¤T}ØÌ¨ea} ì¾8êg[o9–2‚³2­¨ÌÅcëc{Èì5·+ü<0¼Ï6¬®¢H™ËöfÈ_‡+ò¿ß‹:¼â±Hí)Ä\'~bÜ½øD\\G˜@…‰P¿hãá`Ã†7ÜyúFÜZ1I_=V_%<Î
ÄÉm€ŞÍá¿+sğÃT¹µ~_;E²$nû XĞó¾Ş8˜saW­3&œ©!Äåìw½Ã·â1>È
t§¥Ïd‰áRt‘-ÖİÂÀ}˜g\"ë–â8°(¨Ëo­Õ4ŠR) a°¸6øxá+ÒºŠ8¥“²İô m½Ä]¨Íjã9„‘º+zwXßìÅ|ëeªÑÇm2?·deÜ·ÅrÙcÜ»^L£Lÿ\02®¥ª‘ä*©–R×sŞì-ÖÛËliÍ*xg;lÊ¦ŠX©ì´±Í8í‡~=ã*E¶:wØôÇÛ8ÍÆŞ½X‡nßÏå5ÕÒæ¬Õ3º±:ƒHMö>xAÂ5Á¾ÒS]@–ü(Îã¸ú­×Ë|±ŸÒæ\'-k.×M×N«sÛ,áãZv?KC2eÃ}öÆÚ%BØ˜ÚÊÅ´ñÿ\0¦\"ÿ\0Ëÿ\0{
{ƒ\0ywGY˜$éÚFÛ‡]ö>DàŸ?Ê$QjèÁş WïÅ%®e½ò¨š¿£)ğšĞ§~§Ë–1ïJî)Ì¬A¼¬oãô‡/¢Õ¸@Évòp7åå·Ïß¥K,ÌÉ]?NûËélpğ·çT¿ggG.—Ëô‚ÙZZ¤r¸â¤ôt>ù?áÄü£½ZM¾©åï‰Çê…({G1‹É½¯û¸êÓ]/9µMÍ {\\µşÀ1ğcË–¤¤ÖñÇál%Ş}(»ø+m‡‚³>VŒê±·!™”ùy‡DU*°>)şxù¤ïX@# M±=YVhÈ·=ş
‚9§EI#‘pª.NYI!MÏ; 8ŸU¬9ÌSÕ0HÔ=Ø­·\"İ1we2:åy§ıÊ¤{ã8QÊ3FêRßÜ[;Ë:U_Üü±ÕÍ©}nÿ\0Ù…¿–˜Acè«)3õªv@ï›‘½˜ãVı\'!¨›.ÈœFÚc«•˜—À¨~\0¸~­g¯ˆ§Ò¦òFRıî—Æ•úIJÍ”å‹SÎZyvA¨”Üøc—\\ÿ\0ªM{ş\'R€ÿ\0Lãåù˜ÆJ£Öİë‹¥_PeÓÍK#4”5&âÃ»o¿¿\\0çC şÓ¨Æåµ¦\'¹2ËO–%‘K\0{œWş¶v¸Š=óÀc¢¾F>Ä	ï‘Ü˜³–ŒÎ’I3Z‰#œ6*	V
Æöi\'>ä89õ°A,ñ1ÿ\0Æ”²<|*AÔ\0ü‰Ïü âBL	uçş¡Sÿ\0õå‰™Ubf0É%Dh¥®Íu#ÁânuTÉïíÛğÇ%Â\'#0¥f¶È)å€$Øbsib—[ÅÖş„Vo¾“amı¡ŒüG$ƒ»Ÿîã@£1I\0†YcI:‹Æd]ÑÏ\"Ëò äµ|roaFÀ}Ø%6†\0}Í¦y,¤F½º®>«?³¾ÇåB*L¡ê¦_u+ÃII’ºÙòGqçMüÆTªOûfZŞ#u¹ê7£L§)¦]\\Á/½®Fıq˜×-D¨‘•KÚÃùãQÑ‘¢¬m•²ÈªÀã…ø}I\'/‡n­4?+*ÒB¢™ÜŸ8]Wj\0?ÿ\0©f»%é;ƒ”£^8ml
Ğ‚rLWŠ®Z†_mæ‡ğáÌÒ²³/–ºŒÓVéYı³İèş÷†éTt¶[k½ã)Ö¥MÃfDÉ¤rHîøxã²;H÷µ­Ï®øİ£ËıÉµWåˆä_³J
¶#Êş®“.ôA¸|ö¥üâË$ ûµü0Şy>é˜Í$ø˜s³Ik-ôóÇd‘™Tuë¶6ihıê ×ñ†ÜãÊ£\0ÿ\0ŠqˆsÓú!PİŒ\\G1¶ÅâŠ-şø.mıÓáQ¸LÏ$—öØ£`mf¿Èà“ó¸ë2|Š‚(tú•3ÆXŸh’/÷vjLˆU™hÕãMôêv,™	¾#WeñÖ2Y×Jµ<ÿ\0º0eA!»KZ¡P ëü~ĞV	Ddî1ÈåúMel/¶eÉT‹6›sõ*‘eh-}¯(_¾Ø0MÄ>’¢º@D•“I~`ÌOãˆ“Rv§½Ûk]¸à·+ZÌ¥½Y_«şÕD¬åO+71ñ¾²œ÷…d¨1Te1eª‹«µ’–Í¼î‘ñgõ
îßÂ,P=æ%6RÇÙ©œâ™MJû*’ıVåó¶=M•E•×Áë}DRÄ9ha#ì‡&¦TÁ
êÈùXQá¶ÀÏ0j´ÎËo¬>Qgå¡©‰XÉNãÌ©¶£lÒŸıRjØ”ŸöR2ïğÇ«+2zÖFâÖ™\0İQâQî%¯çŠ§àŒ™Ù{|Î¨i;têoáL$¿öŸÏí/–gŸ\"¨âÉQ½aıÙh„Ÿé¿C‡ãJ”c,ü# ‘7-É¨cq¯ôuK+kË3šÚg,=¦GM?ÁûñQ[ÁœGE¥©3jŠäf7U@¬-ÊáĞ|~p–­Xl/
Ö™,¹e@Ğô¹Í*ÚûÆ²ò±Äuá¼¹Ü×0ÃµíQÄÖéíX}¸Ñó£9 ‘?[C_3wddKoc ‹<¯Èyâ
Rås‚²ÔÕÄyŒ‹í`–;ßå…ú[anğRŸáuG™³§ïG\0és‡? ´J/.x!şÒc6\"á|²ªcÙVirÄ)ûAvßo—$ÒeutR}]TŠ6Òó9À‹Ü\\şÌ	Ä©÷ˆúÕ®Fëù‡ş‹*Sú&«¨Í!çÏ—3î$à(k¸3®5’Ú¢ªImm·bzä<qğş^(áË2Ò,$“/ŠW»nN¦ØbKzSâ†nÄç¤«a®:
TåÌì€ü¶Æ…*3©:ü?™¹¸‚:*•Ûã3¨½S¶ë®Oî¿àø›¢¡-´eRÍáh&?t˜3oHœy)=ŸÖ¨Ò¡@uBm×eùõÃSñÇ¤!U›‰s9Ğ±mQ×È’±*mãöa¼Çşï>1>–ŸÙ()ıWÉıO
UKî ¨oøñaOè;>6+Ár.”}í†j3üò£»˜fÌà‚Na1ùêa¶öù{ğÜPfU@˜3*ÒÖ¸&umú_¾y[ã· f=Lƒe%§úÏ\"[ÉÃ|#•å‚4·ø›ÑbûPp¼on¦|ÿ\0í1K.O™vÁ˜ÓKõµI_W^_~8ìyT–V¢£öH%	[“Îö\\X¦Ìl\'ÏÂFÅ:‹•°—ÇÑ¤tè­QŸğu(<¯_L6ñî±Ã#‚òUÚN>áHö$h¨fÿ\0q+àáê†k,Õ	¶›$­kßm¬<@ÃÃ†ó&…l²-ï»‹_ÇÃóàá‚®v¦|?‰¸šİGÔ~¦K^áB¤·¤|¡Àæ)ã©ü„XbnàXÉí8Û0p×‡)¨\"Ş;ªí·?v‹„*»R…ôŞäÓèúÿ\0	ÃÍÁ”Ëmo}™>ÍB®ãW÷îŸ³^‹\'ı£áÜbŞªøƒø‘› ôc«4œcÄrIÔr•>ù\0éå‹*Îx\';HášLö»°mI¦(\"ÎÓ“ĞsÇ…(`t­ i±\\wuxsöOÌbAá|µ•„“Ã [›òÔ/p<¾Ü8p<kE#§Çù‰?â:‚¦°ğ? u”|#¤öY.rÂÛ3T _˜Šªš,Ÿı–C-¯ÎLÂßÿ\0–4¸¸_%F$ª}Â+ø†ß½‰)”d©v9AÑË±R	+Şøce>şĞ>³+ñÌ\'şåş@şÂc3PÄÀ<L:HÔ?l¹±ò°Ã«ªî{<í®í÷66ÅÊø~9”4*×m$•Hûºˆç¾;™J4ÆK¹µZªO-8Ô¼+z¨ˆ<kÿ\0Ìı?‘1C˜w´e´
@¿³%şDï‡âÈøÛè²êC¿1?~6WÍ¸t+ê¬B’“’E”COş’pŞ¦´9`c}-i­şı°ÁÂ±^óñjGÙF?oŞdKq1?êÉıh”÷^â©rH”rÙQáØ[Š²eR£/Œo±‡Qåààá-Åyr/úÍ	RAVĞlİãå†XëÎøŠ<aFœ“â?i‘ã7õ‰ô\"¢Âß<tğ\'LmúÀ­<‡XÕåã8ÖÙVT;…\0åì‡—QŠìÇÒd¢Ğ´Îv:eÌãáƒş•Ş­ş’‡vÚ•¾f§¢~2©QŞW-Ú·ü8b¯ÑVH5Õ}ä´o~öÁ_fUİ¦UHKÁÖOO××æ=M“kÖÀ|/ğÅÿ\0L¢7söŒ\\msî/ßø•õêçD¹•07¶“$jGÍñÅá(tö“fªŞß×Fİ\'k)%f×Û@„s:ì?†ûÕÉ]¿îï÷Øà†
€ÚğÍj½m—.¡I-H*>±scò\\F’:8öÕùê?å¼4ìZxÈ&çfŸ\'e¹tsPÔiîÀ%ù¡†Ar°ĞÕs`ßiZÏH½Ğ©ò\'ñÂ¢ÉGø?’´Cü0Ñ
	Ò§ŸAa<7•Dl‚,Z$Õ*òˆüGá…$ìÇ»¨#o»7­î7¶Í0:E†Öœ@¨6Qá,†şãã&SŠVª3	x/ó-øaÉérÀŠŞºà0¾ë¨ûñI\"µ–\'ÌœJ¨•Ì1‰\"Q~m~øl@\0Bî	,b$¥ÊHºæ2·Öˆ\0>ÜB––r¸‹xC·ÚØ’%¾Ë{uµ¶ÂDš-ÜŠş5?xÅÜÁh|ù¼\0Ä~ñÓÏóËñÂgª¥b©’V×wß©#ólzT!1qµÿ\0•ÿ\0*(¦{İ’8ß}¼yãÄòlgZæ\\µIş«]<*[nÎkz^ÛC4ÜkšÓöQÉØM{lÛ9ŞÜín¾JY$¹í©Æ×ŞÛlm…­òiXæ¦6`C*\'Âİ9yyaŠÙ62k4
>9Êfxbõª¸en`„Vßc6\"ZYNåŒÊ¤r·³ÏõF[4\0Ë-RF@iP¼÷å¶8´pÕjJç%XÙÕ·‰·‡Ï“-ëyûA3aŸ2:C£Šç›Ö¸øcŸ­\'\0²æ”‘·2™·ñaŒÊ<ş®˜#ÚdMÈòÏD”h[ˆ’FMZ^œ‘×÷ãJÔ İ¼-ÿ\0ØJõúyûB¯fK½d2©ïiJbzßbqº\\ÁH™\'.}—J#¯¹ˆÂâ¢ËùIÅeş£F·ûğäty
¹Fâ<Æbw:HaË¡Tøí‚-Dé>&U›´¥«ášYè`®NìLgÇ˜6û1Rxoˆµ“ÁVû^u¹ëœIIÃ¨º–Lê¨Ül†aÖŞCh²xÁõ|«1œØôöãÃ4)6ÃÂÿ\0şe\\¿ŞgY’qÈÕ¢XÙÃ•¯fìL0µ’²q$g}É·wÃîÆ’ihˆ8z(Ç;Ë<{|¯†ë2ÚJ•L»)\'Û•‰¢ØIÀöÀÿ\0óüfw
,Ênñ€Öi½÷åá…z­BÊÍu’ÚK4»|zòğ¾ø#Ÿ‚¨å¤Œ0)}Jˆ…Âø\0Iõü*ô„šlÚ™ĞB¹ì˜ï{x}¸Kaj(¿í CoîÕ«!İµHJ€G-½ø±HDwØì|¼ÿ\0˜Äxä«¢D®—[«×ıûıØøfSi*ê5 
F…òñóØÏ”Ë¼³Š¾©mæÄÀ”µ˜·?-ü>ÌJƒ4­Ö±ŒÕšÚU€7ÿ\0	¾*bÍctc)kî?½{ZÃŸ3ÏÇ!1éJZ.n¢úy|¹mğÅŒâr:ÂôÎ3Ë †ªyc>Á¤€¸|½ØrÖ €ÒúÆ‘kkŒ5…¼ù[ó|…¦!j&İFÇ˜åãïùøa´©MûJé±îp6ß¯_·©c±t‡©PÌõ0ô*ÿ\0¸€üÀšLyÔjÚME\"³ßÚ`¾>\'ø±ctÒ+²örj$šêŞ÷¿Ö?‘Œ f²]D”æfÁ™îS™°Úş
LÊ–)è^\"ä–šäÇÏİ‰ÆñË¹¿Òenoı;|¦«S™V-ÛÔX“{ì«ò7úÇ§\\Vg¼MQL v%K™_S¶©³×eÆÕ‘5‡ÖÔ6Ä<oãËå)8‹01¡`’Ö¿jEÏ‰#Ç—óÆ¤ÿ\0Ö¿®£ÏŒÁp–²“õ×ö“¿¥•£4/r9”À {óÅ~aÅYŒÏi*Í¬´ëm­ÓŸ8¥˜şÙ’RËûÆà|7ùõéñÄz†áÆ}”ËNÇ“#¸ø[o³+XZQàè=–‰K.g®c$’O#ã6ÛùŸ¿É]¯ÒB²0]Aü1m.W’Õ?ìù›DÄ^Ï(\"ßŸ…êYuC]¾ú‡İ|hJ‹ûÒı¢ì/(%®V…‰Br·5ùc«YN,V3y]zùZø™SÃ9À=Ğ’”o¾ìG^Í4ccÉ4%te‡ŒCQdö‘Ú¹P‘Ùƒ«ø°‘Y.¡í±Úä1ÄÃÃY‘ìÙ\\®¾Ü;	æ„¯ts<í†
	ê5S–µÆçVöøâ†­É,»Ü0F8V¨Ã¤J¬Èb\0æpÂª’Õ·=wşVÂ”Ç3$k`@bú»ñÂ\'`ÎÖ$ìW„]S»;–Ûu×ğ¶xNJ}5NÚãIœmÈÓŸ+â|%+!°¾ğ|š*…ó8ëˆ‘C!ŠÒG“Û‹Ì‰¸38\"JºšI_eí)\'â-ğb§‡³Zv§“!ÌÂ¾‡eU”\\÷_}ïlVgÙÂZ§,s$`İ¡;ºû¼GÛ3b*2óQÛPGŞzÔÃáé?%ÎSĞèAQö0›x#0á¸’²â«.‘´Ç:©=‡Cñ>ó½¨òç-KQ
 .ÃQ77°ğµ‡ÌãCô1ÇšpÖaèÏ>ìêrüÖ3ê“J/%4Ê¤ ‰Ã¡\0x¬¤áõv	9U>Ñ(	??¼aØ,W¤©ÚaâøOAª¹­ë›ˆíñí¥  ïª¨·ğóûp™-v¸SÔÛ¶üğd¼&ˆì¡Áˆ$yáqp¬{¡\\~­À±Òœjí#C œešü€$~%ÕÜ·ØŒ?¬,5Ò)<·sòÃu\\=QØ	–\"‹®¢/òç‰ ¨*Ìep½HßlL”Ò¤iÛ¤v!N›ÜøşN%ÔSCvMYLíaÿ\0,F¬N‘¥İÔØÚ=ş7álæ„c”È“ö¹Ålp‘°Ö=G+ü0—‘™¹mÿ\0‡×å‡c¥¯“xé%py„»JÌ\0áHËk^&‘©ª¬ ôdjåm­·,6ÙVa#^:YJØ©¹¾ûì<wÅ™…LˆÒM;×fˆ`<|o,²Ç(”)ç³%­Ğïï[Ÿn“¹Ë§ñ—1e9ÅÙbËçu¦Ú…‡¼‡-ÏPêıSTÅFå{óÛã©ó.ÉıcK¤=ÀI<…ˆøõ½]V¥Jz‰I›Ã¨ÄŸáƒ¯¸%?Œ¿1æ°Ÿ¤ÊëRßşƒüî<\0Ã2ÕÈ­§³’âìÊÖ=vñ¾8:·ŠU|ÆiÒ™M˜UX—_¼Ï3ø[Š£6ĞGV w®ªÁG¼°y¬.DràƒU¾Ó%š¢I{E$GVæÀıøbPIÒ® FÃÜK–¦OÄ”JTˆÖ=!Tº•XXîlÇ.ƒ‘ÓÃ,ªvŒXznA$n/ÒÛùòÄZËk¦7¦ÈÅNò‡0Ì2÷íijdŒ¾úMÈÛËóü®ÿ\0§ëW…Y‚÷˜~}Øú:Ş¢eï;kf[[—…­oÆ,ğ¬Ìb5±ÖîI¶×çÌ>xÑOê,§H¢—Şå9åfdƒ³Ì¨bvÌš”ƒñ¶/-ÎÈ´¹²GHÇâq›­¾¦ZuÔƒV¤#ÄıÓù#½vpâëQ,ˆ6Qv!ôÚşî~ıñ¤cEµú™2ó@|–¨·iQ›Î6>É@ÿ\0ºpÌ™fW´“fÒ:ó«
ò·…¼°+‘çÙdecÏ2z©[V†™%“sËq}î=ØÑ¨ à¹(¡¨W A\"êXæÒ_âğÑTZç/Üşed\'b|`ÔÍÃ4¯gxä&÷úWp\0øØa¿ÖÙ—Õr•ªÔ61Ój¸øŒ­G
S²ösS‹‹Êvê˜ÃÒl‡´ìãJ©QPÊ‚ÍoışüAŠ¢=áôY9MÛï Íê.?×(?[Õ´UúÊ¹~“†£˜~ôî‚ß=ùbê«;f‰_WÊÅN’éa~œ¯¶\"ËUÄÓ¾Š|„Fl;òL }î¶ğ¶®-v? %d·h)UÂUµ‰#§¦¢àö}³=ˆÛ˜õë†$àºÔ¡¬§ÖdY|oo³qe|mPm$ùm:wmÇ¾Á†‹„ø†[­_Ó \'ıŒZ¾ğ¸Jt¦Çëi_òûLò«%Í²ÑŞŒ@–b¡·#p|ùœW%UOµ BÀ°î¡¹_Ïüµ¿è$l¬*¸‚²mG¼tåbX[Ñ÷E¼U1¸$™¬Oø@8Ca÷µ‡ÄÂÍÚdç4ÅYÙ°°/L,UG<h;ÃŸ|®yß}ÇÚ1¨Öz?á‰£ÓU4»X´uoïq<çh)Zy)sêG‘ıƒÙ]¬	Ó³nNŞÉ@&·\"zAYcŠR
´k½À<ïÊÿ\0/>}0…¥Eûm#kù|.^ütåóD¤C³Ø±¾÷¸ùüúmˆïJÈÈ½”eO´,>
oşxğ2£²öñØ+²‚·^»õùï|w×&ŠÉ}Å;…¶é¿ß†bePY,6];‘ê¦:´´šŠû \0oÎş|±- Š5êÇı_M‹Õ±ñ÷ak\\¨¡HÆÅ­·€÷ãŸA\"¨PlyIĞ:¸ûğÌğ#ÙGpî@-kZüşâÆY5“kY¨49Œ¶ç¡·ó¶Üñ\'õæ` ö2s°:ˆé¸ÛNÈnèõlŞ~xmà¨V+vûçå·ËÃ¦Œ¼ÆÃÄ;Ï&Û˜¤üî1.<ş•wí¤S·¶¾İğÙÊ;„–¹\0ü¹ŞöñÇÎî¶]ï¸&×*@é†­z‹±”@oh4*n$¥•Hªµó¾Äøaã™£;9[ê7ö¿Ë½ãap…nHÒn>Xè-Â?q`NûuÛ™Æ„âWsØj-îÍ%3aèá•¯r¦+ıî¸u3ªYrÖŠhİµ+©M\\ébwê.7ÆzµõqêÓV^Ëp˜_¨üøJ\\â¡t†Hd[nHÒO!ãã+Å[¨‰8Gm\"3¾¢Ìë%¬§’º™ÚÆïpXÏO¿CESK­FeÈ-Ş\"Ío7?,K=Fr³P4büÃ¸÷aRÖds¦‰P’/ôel|È÷øâ’¾ù²Ûäf§8‚¡MKÜGøyrZLÖŸ0’i=n\'Ô¦\0r9<}Üñk7Ó‰	¥‘FîJô?–)é£Ê\"áhn7$¶¢>dÛ³)§‰bsÒœ¾XbW£JùyuÅJê‚£”ZY¿UÌ&xia“qÙPH÷q³Ş!œiX+ÊË.…c¯ßŠ©sŠkÙR^fÆÃçÏlG›8p>†œ“æøl?32áMï,ªW=¬RµÄ«ZëëÃå†#Œ¿iQ\\î|oñ$â®LÎ±¯¥–1â ±Ykd,Í4Íû£PpÂ_ç¬jÒ¦½!TT\\#T¦Y,>»\0>À1·0áœ°ƒ-:ÜCèÙïî$[íÀ…Dè¤4“(oãcç‚îâ\\¢¢š•«ãDR½Ö×by°Qª$?dñjõ\\ºy9ïİ@~üVÔñÕKÙ²ø#ßnÑËıÖÁ–¬‹1ÿ\0e—U×J9ùâ5GpüÇ½–Æ·ıÇdû±gİáŒBÖ}•ğjÔ™Uyrf½HØƒ~ ­‰Õ|!Mê*jª*$\'A`·\0t°òå‹·0¥§š¬M<q{Ó\0}Ëfy¾_%$ÑÇP^`MÉRşûcÍçlÚ,îz=Ÿ¼z—ƒ²XáWHÜk‰~~LmöbË%Ëè–®¢”A$K]ª_Qkì–*¥TQÓÄ‹îÁ±Ó`\0ëøáœ¿ˆäŠ®ª®tÒæ(í#ÚÖ¾ÿ\0ú¾×±Œæ`é-(éiàÎ ‰#R­„†7Ü±ßŞqdÙ¦]–ÔNÕ•‘À¥U÷$İ¶\0oŒ»2âŒÚ¦a$±.‘¼\'I Ø±;ÜaüñDŸM$
ñ3Ô5ÉÖÂBÜ®wŞ÷®ÿ\0i_¡½Mj4âÔéÿ\0´²ûŒsäÍ3úªú5HÃ‘Üû\"¨n{\\¯ÙŠU¯VEY§W®aqáÊöòÛz´ŠRÆd%n¤€·ùÚŞÿ\0~ûâ<¡©Àm:õ !›¼[­‡Ÿ–7Ó ª 	Å©]ª1cÖ^Å™FÈ)ËÈãµPë{óƒ~|û¼°¨³(ûXû;†êÒ3¬-ƒ{›mkrÛÃ-%TAÚ8Ñw!¬„µ÷ÚÛ|F8’Ï¥fvVV\'Hä·W-ò¾ø¾H‹Í£ªY‚G¢Ò3 Ú,HŸN›{ôrº)»ZšdŠEÒÃP ~í­°°w<@Ğö]ë¾ÅTØp.¢Ç¦üÏ¿—¦H~JŞ2 Ü÷Ad˜[Rm2Ÿ´»‰\"I¤A
2¶à]v,mĞyÿ\0‹ãˆbZÀ©
Í%”^Ê×ºÿ\0¶¹#Ãûâ@ªŒ¯iÙ*«¡M%\0{¼EÇÒ;ve]0V s:®M<¯·‡»dz<ã4Ëjû@cœ\\XHˆÇmï½şx9á=¢aK˜Rú¡Ö‘M•M¹[üşHõMp,¥Xoõú,3;v—E.Æá”ŞÖ±\0ö{­ó×KôôX6fºüY’†
*ŞK›±±;a™xÓ-‰X¢NÜ­p\07µ¹[õÆ=PµM~Ğ«nN«Üyı¿JÊ³ìÇ*İ¡I€$ÜÄ	óéqöa‹^³^ßI.£İšt|jó1HrÆ–@º‰oğØxá3ç¼MRŠ)rÎÁ‹iNÊ-}Í¾ø¦Ê8ê¨¬5q<[éğ?Ìâê«<ËéÍ®0omí¶4ò®õŒ¬Íî¯â5$¼gXdVì)#nE]àXıÇC‘q,€zç \0{),Öç÷o<&~)Ëá=ÙÃ^à<|1~5[hŠFU,£üü°<¬îÄÈZ·{KhxQvõœòyÀ%¬±câ-îÄÈøw\"Œ3UTÜ‰kîy\0-ÌàoúM™O¤SåuMs¹(Ä[ÊËˆÒÕñtË †„‚_º]meø°ñğé‚îÒ&,}§†‹AÃĞ\0?Må:¹o¨óØaRÔäêŒ¾§DTó´+k|°>SÅu.¯Û_‘*…á¾x;6•h¯‚ş:İÈåão4g÷)[ÏÒdêĞ‡4¦áiƒ³¨¦k†f†]6#ÈíöuÀ†mK•ÀÑ>Y˜vûC¨%Eº7¾-—‚Øï6bIŞú \0ı¤øœJNËzd©¬N°9óé…¶µOt	9È6eŠZä@Ãq{oc}úuñ¾Iİ§¡&áÏÏ± ÉÕ‹=+HnI-+~Øur|•C[-¦Ünt\\üÎø‹Ã*u\"W<Lù+DcW~Ä÷V×ñÿ\0/·5}:7r%÷\0w¼oğÁ6iÃ9lŠÆš¦Jbmİc­vå±ßíÀÖc“ËEwwhZ0½üH8ÍSÔı¨Å©x¶ÌU£Øï¶G´m„ÉW3—BÖcak‚<mÊÿ\0€Åk&<zi÷•‘çªëH™à’Ú¯½ºuÂÒŠ“bm!còGpÍ/l½Øû=y~Fø$‘÷´°PGxÜxóû<ñ¥Ñ½=e:ËFFØ)Õ—ØF#%áwÙâ}v™ZHÊ{²±Øjé…ö³-¬ ³6À›Ï<j-LH7PAØ‚68Ï8Req[•.¦ı‡ÿ\0TŸ»şX
¼=]Má-{˜&•23ºØu \\ö>ü>¾µ!-C§q\'æ}ØŸCÄ™,¦¨Ù´¥XY‡¿Ãİ‚,¯ˆrÚà>˜Äç£`ia¨¿¿ö„Îã¤Š‡2$Z†µ÷$†‰­o–#<‹œ±€é»!RÇ¼sÆ¡G\"êYƒÕwû°ÕU-BiR@9j·¸ôÃÏ[z­Ï7ÔLâ–ŸÖ&:^Û¯jOòÅ”\\9Q#…0¤w}¾6ÅÅgĞIv¦–jv6Ø÷Ôş?n(êòú„ÅL‘Zúá{ŸğşXPÃr½´¿Ö|ÛI‹ÃaU•ª¦g<ˆP\0Ä®Œ“RH<$R¿uñ,ë1§vå`Àû.,G¼bt\\Q\"÷e§\'—+öa°¡[JËPleêPäSPAnWI$ë¬a‹\0.usï¾+ª8W…j	ÓO59=bœÿ\0Å|}eÒ$Ç¸~™vUP;“ØùŒjƒè€U”U>òÙ/ê¹¬ñø	cWû­ˆ§ƒ¸‚–ß«ó¸ÊôgŒü€#íÁ`JvŞïîß	úT~ìš¾8…¦v†1ğmêfw]äk¨6”•í£©”ÕªYB\\¨~v\0ûíËÏÅØ“Ú3bMËïqö~ã2¶¥`ÍÈ¿ù‘öãƒ’jÍ-\"™{2Îëe ÆÀüFüñ UÇ	]¦•±*nI´ß•¾óŠVÎ.Âàí¹ÛÇßlHõ…’ê	7çà>W£NVih*#‘Õ!XT5‹ê\0ïÌŞŞñ¶%Òf„e–)¢×¥\\“şwÀğ•»B©³6Ököû>Ü*	$Y»¸&âıï!ğÅ=\0ÂÆ@Ö„UÕ$†ª İ{­e*7Òvß¯óÄF‘(æj£ª;÷A ©Şçp~ñ÷â±„º‰fR¡¶\'b@®84èÓ$¨¤ÇH±IAPYtµåƒ¿i#…Wkí½ïğ·-­ñÃ“H$UR]‰çâ|pŞ¶gÑÚ)±ÍÃs·¿C+4Söe”È,Iàòi(6²rÂÑ°V‚¨i$÷P÷yî~ËoÏšè-¡7,O¡¹ñéó;âm4Á½f¢y‹\\\0I°İ=ı}ØxWÕö}š²Æ,TŒjÛÌüp^Ú~fKÉK\'iŠö÷ƒ/uAEş8™,Šğj”€¨,­@›ÜÜs½ÿ\0<¨e¨˜J™UØ-ôõ#koÏ-C¤±ÅX¬/·ÇiË]ºéŠ^ôr1`£ŠÚ@ñßk€~7ò²¯M+ë\'StCaq°l:màqTI¢nÎ$Ì‘~v·Şp…–@7ß¯‰>íÅd¿Y3	nt®·]+1º…T¶–ğ¹øxl<ñ¢Dj¦5îÊ6§ğÄ3&’$Q}Ã6òù\\a¨Pëqà»nw;ïXS*â>ÁYõEDÀìH­ï÷œFyä\0¨±1íiñ7ÇttbîX…İúÀí·‡#oÍÕgo¬OÄXZÀ·Øüpye^pÏe°¢E]–Ó)U°”Â¡ì:ŞÛşwÁÕuĞö”ìzé²ÛŞ1‘È±ÔÀ›€H¾Æİ~{c°æ©ØÃ!¹ÀáÏÇşXßGXˆ¶@Ó_zúT=é£é¶«á©3jHÎÒäô\0ïŒ’¢¦µ^ÒTÌJ×Ôí?~gißZ1®=»µ·û-oxƒtr’jÓñ*K0ÜÜøâñm	
Q®Ì.«½íğìgĞGU:Æc¤¨6=Òµ‡-íkX’2ÜÒI;´5äK÷Näxø¥b[aö•–…Õ]‚cĞ@¸BoÏ&âê‚Tp¤íu
yyŞßT®C›HËªMÉ%¥]»¤[ÎØxpŞdâï=2‹ÜDş»âÛ¡•í:üS˜Ô1Tî>ÚC1ßsî&}_PáZUBxØŸÅü¯‹èœ¯\"™3\0±!V+´âT|)J-®ªV
¡oó½ñÛşd8„AÅÍ+®Õ:‘nîÂıy{²YTvŒòµİ¼Gó#ÉÂùZ[W¬=¹j“ù>™NŸõ%6ıçc÷œXá•äxÁ8¥…•f[’£şvûğÄºX7ÑÙ;£§â1 Œ·/ˆÎ†œ‡@\'îÃÑ¬q­£DŒ¶¼-º´ˆ /æÕY-F¦‘Şá®n<m4†®–-6\"äxb\\TõQvUQ$èz:ŞØ­‡+õ)„™|Íßxšì§ãÌ}¸ÕFJ:^â8}÷„â¸í€ÇŞ¾¸­ÍVˆ~ÑªŸ¬ÅıøgúIK±Óe#÷€¾kRÄÊç¤¶Ï¨h3X‹H½•MˆYĞoññÏóZ¬¶ ¥BX÷%Œ-n·è|¹à°ñ2¶¿.ÿ\0ÇÍĞÎ´êèÛÍÏìÆ:é‡©¨kÄæ.âÒg”g´§©`»f6ë‚»5iJ¨À\'©Øÿ\0,f‰Ö¼tª{6PËŞ¹SŞî“öá‡Œ’IxŞİ1…k=3`cŠƒ¼ÒáÎij?«tÔz¾õ±û§çŒ·¿ƒ+¤‹?x¶Ë³ÚØ[³™L‹ão#óå´ñÃßMG´6ªÕI¢¢™&R>°b‡2áÚ9»Ô’ËLwÚ_‘ßíÄYx‘÷P_`ùãçâ\'\0ÜXš?	ëaßÚÖEGem^E]ëTí€ì÷û9â±ÖHä ‚¯ÔƒüÆ/Tºº‹ôÂãùc•u5uğê)(äd¶¡æ,6Ç>± ‚êÖùÇ(n²
Š¥C¦b¦ÖÛßşx™u]Íuî-q÷Ëi]Tò¨¬Sk_n}zcŠÍ#*¶ Tì¶µlÒå’ÆŒMÄ†ÊÖÖóøá‘Ò1T*¢æÎWŸSo»E˜Å!6ç¸S¤ŸoÏÿ\0£_G¼+ÆÖTOSE4¼LÙVe<gSÄ“F¦œ€v©J\\ß¼äî,0€a…™4y}me%]U<RO=fDÔ±)!T±é¹~¬Q‹š^âÙ2ŠlÆ<†¬E]Õl)¨Š&V@wk}ºkØãÖ^Œ8w„r¿M|MèÒ,©jòúL¦)%†ªY$ÕYK–fí’#PAîµî	xS‡¨2ÿ\0EÙCÂe›‡sŠˆ•¥ØEVÉJØlS²gØß`0pÅ9ã:àÚ^¨Ëiá¬še«Wbf°O€ğ$òñÄ,àş È8¦¯‡*)M]U²FïKÈSv*l	°ŞÂÜñêoÒC0áÎ ãÕÙ¥<¹ğ¾wUSLV‡zd­ùÖ-r4òğGN™oğgÔ¬{LÏ9—\'¡{KD“K+º«1]Ë9%@s`KbZVAyá¨éªä š¦(%’¬»Œ·²	é½‡ËÇ}6ªWPÓ`}£ÓİkcÖuş‰äâ^¥á®\\·-š³!¢’ª¢TÓÚ ¨s­ô/}ÊÆ‚äonc¿¥Ñßˆ83‡dâjÈó:8T5M£ìä^V%nÀ|	ğëˆD†bïÃbÍÎì9›_ğååEÕ_³S$ª5\0HRHé¹½½ØkS>”÷ul>Ë\\°„IO~ibºF›ò¿?¸«@ÒY~­«7r±¨öMß¥Æÿ\0¶ÄµÕÙ»Î· –òßã¾*Æ¨óHTw´ê¶÷7\'Ç¦‡»%õÌUƒ1ßncûışx/˜ßÏÌÈl\'Â=cV’AÓía®ğ
LŠƒ»fèw¹ü~Ü=Ú4z
ÊÌËrÄÈ·=öé†‘Õj—IîïÏ½«Ãşxd¨ÛK-µ‰WIóç¾ÿ\08½Ø˜±e¸P9‚m‘Â¦™¤}At«¯ĞxËÇìÃr+#Qİ_nö;o°üøâi#‹ÙÜ/y®I6¿>!ğÇd:ã%´#WC~gşxŒ¬‚@	bäçÎß);6“K_²k\"÷\0\\í~%¥Ú>’k !B‹±_kºc¥@ÌÚEÎ İHß°ú4U×;‘Ó¶ÂUt›n3sa±¾ÿ\0}ñ ÇU•:tî	Òvï÷_|5S¹
	U‹h<ñÒn
,ÂÁ­·Kß¯,J£§2ÙfµØŞ±ÛãŠf
¥ˆÂT45pÌÁœ¡W_#}¾$àç\'Î «ˆi(9¨û:`GõLìÎÚ¡vÕí_ûoÿ\0?,AI¤¤xÚHäé`zo¾Ö¾ûáøLhRrˆ.´3NÔM¯s«…æ£ç€ôÏä1\"Ş@ãb\0åøõÃ/›UJH„TJnAµÈá¿õ
}¦~AïÄÊ¦íl ÕS©¹’ ñÛ\0ó¶xÌTVcÙ7+ôñéµ”îÓÜß{€>óåöâ½9²†W%:´3|Ê‘E„«!†_6¦Úf÷ç“çúYW»¹iAŞı,oã‡#á|ÍÛ¿QNªo¨ãü;`N\'vO´±Në	$Ï)A¶†şóˆRqE=˜Gì/Î÷üÛS…g&òWF§ÅTş8r>[ı%v¾‡èyïq×[Û-¼%ƒDG[ˆµl†0-ÑNÛb,ÜI%ÕA~ğ¾ÊÛ‰Ñğ­fíQPva¤l>z.ËìÌ…Ì<6¶ØV-·?yb¥1ÒPIÄ5&…g7RTêØÛ|Cµ{ß[-º0RAûyyà½xw\'ÚzŠ³Ş÷gcøâJåypêP­º÷â½
»nÂOHQ°™ìõ52®™ä6,;„m}î~Cw¤ï;É~xÒ–6&:8WÍcWeîâ¿¦›êßi=#á3Êzz™!:Z©l¾ÊÆ|yâ:	5‘XBİGùcKÔM†­†!fyupúhí%¶‘;­óëÏ®)øn«HµµÔ@heÕ}6Ûcş[o¯>KŞ½ÔìG/óÅ®eÃõ´í$”ö«„óœw_‡ËúmfWkp@üíç{ÒzfÌ#ÃÚ|t‹X›Şû¸“D´M!õ‰&ıÂ­mù[®#È[¡öyÂÖßğ¾VœÊ%UÂÛíÌíö|0§\\Ë`mZY+e\"\"ÑU Zİl9Zãó|WTÇDÑ‹¸µÀ€<p…’tTkX[Ÿú,ÉªÛÚÀŞİ~ü4)»,Û¤DêQ@ÛH¹~cŸß‡l\0e%HTÙö¶ß°ë…k+\0î‹íqÌöü±òRIöÖ½ Ã—•äàÍºÈfi&•—´›RìWX¹7ûpÑ=Ö7şF;#›º‘¨†M­açùë…´ZU7³c{òüß4–~2ov0cR4éät‚¾?~=…Ç<OŸpœœGÃòQRåç‡²úêº7 †D«sU=æ+¨JH ìGøòQ;›JFO;l	¸ßo+ıøõ¯ğöqÄ¼IÀ™VO—zÜ“ğ–g˜$pD•4ò»›û_Õa¹¿-¦1zÅŒÿ\0dà(xÖŸŒ!¦Ì3œırt\'(¦-Kªx‹kÒ÷PlŞXÂ¼éK‰‡­PÔe¿«¨rhjsjU¥…Va4U%ê	mõ•¸:Ç<PPğneÀÑe©—´œM\'D™Ê<3©jV­&ç¸v+ì›‹ïl1KY5}B¼\'[{M–­³P’j« 0T‰ì…Œ¬jnI:†\"é
æXğ—q¯fùG˜ç™|9eS¬f‘ÒI6‰2Õ©ĞÊÉ¤éc¤‰,M™zQ‘øÙr\\æŠ\"áÖ«LYm(ì&¦‚ÒP¤nÓ16Ä-î-µ³ü§‡¡¢£áëÒ^X)¸o1ªˆ´d´ÆXaË–$‘ÄWdÀ¼Å¬pq“ge©é;„rì†¢J,ÊŸ2Ìb¨	\")½F1NlW¼$³¸#H¸ßy7ñöKY’R?-CÔÓdRË Ë©ã%*¤˜¼vTä•ıÛìI»¼é3¸‡ŒøW/Ì³è¤Ë§ı_m#PÃûSOO4¬ìÚn1\0Ø[Àßk¦Š«‡ó ©ìir’ylÅ#A)b@6À¿»z*¤Í©=\'p%FK[
É¤šVM=‹
*‹!R5nïÓMäb^WYŒúO5ô¥Äô±Á¡?\\U**Ø³òkrÛù`muhEsÔï¦÷µÇ vX/ô [ı%ñ4­¹Õh]¶ NÜÍÇ—ù`_°…ucu­˜6£°ø·İ€¼]¢0aB–,ÖîØj\"Ç¯–;<Ó4j4Èº™W@æ<Fÿ\0óÃšåìU£hØ_Ik[­öüõÇhe‘!ÑAM\'¸÷kÏ‡üü±E˜$Ê#ß©³ˆj´*Û²ÔØõ¿‡–\"-7ª‘Š÷#Uã[Øs?·å‰5•5RÊ¦z‘6ã¨î¤l?#†DŒïwˆ÷¯sk›¼şë`)¶ÿ\02ßIEGI–HĞÆ#!KéÒ7äm¿¼a/NÆÉj(\0z“Óbyâai5@£3nÓMSÊ×äM€ñÂÈP¡JÄ i ~<¼<ğìÒ¬ey€3‰@%®nIå±½CçşXOgÉVèt›as¿^½>x™ôlÒ£g–+UÇ™>¯á×˜.±$,Ö3)Ò¤›¶ç¿+âô¼©f‘W_cf~îÂíşvùa äûHN×¹6?ò·İ‰tÑ´Ñ	Vw‘ƒ™ö±>ëû¯†ì°s&¡bÊá½ÎÛ[İ‹KE4–7*ÖnêÀ~za±±ÕÚé;7>\\ÇÙ‡+«Ùµ‡-kÛ¯?-°Ş»³3FlK¶Üöéñåã‰y-JhVE•ã;•` ù;OíÌ€&ê]Vê¯€8q\'{kŞÆ÷/ce²şya4ÅÚï¥•ÔÃ•É\0¿—LUåêwˆ“VQ©%\\ÛÏ1Îø¹áLÜQÈi$Ş\'k‚9ÏlT^Ş=Z¬½?goåˆÓ«kmLÛ¸°l9áÔª56Ì XÍZ5Y#©H¸8qiÁæMº`/…3öˆŠiH’\"½ÂNçóöà‚^ Š0«Ù¨-È-ùåÚc–äÌço¤´Zu¹ö°âÄ/ÈsëŠ	¸•PxA<$ïÏ$.™¢ïrÒ.N+Ói÷“ÑÌ&0¯†8bK_MöÀ¤œHı™e­Üáˆ’ñ‚ÿ\0K+€H¹b7üŒõ
rz1ïÚ;û
p†D´Š¾öÀ3g³0-,lT›-ı;âFiXÈïÆ‰bC¨<¿<°ˆ¨éaÇx~óS­É¨‡üc½mûU
O\'îÆt¹vbIAmÆŸİ‡}ji¥C¤Å\'­íï¾x‘è%Œ:°í³:m¸<2ù­)öCßÄÛùàÖY×½,¶b¤1äc¥ØÆË¯]Æ«†éà>xYâĞCRœîœ_Şü°ÓgqÔ½~|¶ÀtCèBÜî’Ü¯s¹?/·+Ú:êT*W~õÊÇ/ğáGTìarĞt…/ŸFÔÊ7¶ÊqIÖÓWi-w>‘RÖ˜…Ş 5!)ep76¾öüøa˜ãÓï(Õ{•a{ß|C¸³a@ØO–’VÖ ï½»››uğå‡}Jy©VE§:NæÍ{á¾ö°Ä@Ó­KKÔêæ¤İEùı¸°“6®T]rFänÍ§k|1¡ª-­á!G&úÚÌqa½¯ùL×v+¾®¥¯Ìûü0ëÕTTBTúºÍU\0\'§ÃmŠH/fR­r?#[‘¬c±i`¿[³½Íş¯\"móÂ$Ğ*+€-Ë¼y}Ølk.º¯¦öWNX]¶F¹½­~|ÍúbåGÊ¬÷æ}ÿ\06ãZ¸{±Äk[ŸçË:e‰›I*wpÿ\0³cªE=İÔ?Ç¬¹=™ŠÈt¦Ê‚mĞõòë—ÒçÇ–ÃCO_WCŠ\'†VÀKwµ®Ö½†ÂøÏi‰€f±*?Äâ<7ì™™¼<¶¾Ø]¡fšlŞ™¸²Q\"¶kQL²!£™™£¶¢ÃWåÓSzbâêr¢LÆ¢«B¨Îà°¹;ÚäX‘mÖçŒ¾ed±Ü½É°óÃ‰uÕŞ$û:;şx™~2³™£LœfÑD©›N²ï³ÈM†’º¼..¼@ç„ÿ\0¦N2‘&ıº¹5LÒ!òRF˜ìz$xÙ÷±ÓHÈñ¢Yn‰ŞµÈßÏáòN¦ZˆQOu›}‡‰+I˜Şi«é§‹â¨xÚ¶iVå£c3-ÅŞÀ‘±ö“§Õwm½3ñ¢öNÕÕ;#ÚÙ€,4÷¹“}ˆ°·µŒéÔv‹ö.A=ml3$š\"]( ö€^ÛØ‘‰iYŒœg3f9¥UdêEED+€äY™µ1å¿!Ï–#-Gh@t\'¼x·¿Ş~Ì54Œ²€ d“µÿ\0{Çİ…êì™„jpôşıÿ\0v Y\"õjìÕWR®úŠÍ·#ámü¼ñ$+.Å	mBÅ|:[ï‡L5‚¬ÇI®“Zß ;¸£`àÛ¡ÚûàH^IME<2 hÉİ˜L/±ó?f>c1ˆ#ŒE©5¨’ÍËùŒ|ñªëk\\€J›òµ±\'‘(Û‘î»Bö6æ>X’_IbÒÆ½>¤¶›wV÷Óv»[~dá¹eW˜€4_Ov÷Êä[İ„ ±B§N£½€è/†õ²²Ø›:W7ñşX–ä§–=\'±PÍfeK\0İEÏB’^ÁÎ{šIÒ~¨ŞÃì;ş8n„Z‚›0éÏ¼>š0(ƒ–ff¶äò½¹|Î\'I/h¨e˜@J¨Eº•=É÷_ã„lÌÇY+uÒÆÁ{»û®ä›K»9¸>\0û0ÑÖ\0Cûhn—ÿ\0<\\²LIx¤œËÚ³\"{7acïå¾#I3FŠæ4±ß–ÿ\0-±!ıÏ§jÛÛÎøä0¬ÆíqemşÏó8¹@Æ™ƒÄ”6°X±bl.EÆÈ¦%›\"ŞÌ9›oğûF:¦í/tIr?˜L¥œ©=ÆÒˆ7çŠ½ä1QÅ±_h›nMËçË¯ÃºÆMKiä7Ó{öŸÍğÔÍÜ“º.X¨>ß\'º±ıVR}Ö6Ûá‚C:¬RÉ‘@°…#qÌ|0û¼šJÇİ°îêìyŸL1,æyÚÀí?yùáÈ#F’„²êíuMï»m%ãFeK(eØ†şïÃİå…bH²Ù¤°mîM”~ï·É² ‡ö·&]CŸ™^[õy}\"ïhW³1Ã_¸™Î%{LâB!,¬¤-Ècá¶ŞÆØŒUCUVû¨¶Ûrèq¡Šx#GH-È Âîøm|á‡«} š÷;Læ5šr–¥™Ñ\\–^Ìø{ºÿ\0,v£/®í_Twîé…†ß!ão`uXQ&Üñc†¯V“FÂg©’×È‡N_PMjTX‹X_ ÂNAœve’Oh÷µ¨ÛnW>#îÆ…!;á*IØ›áƒ†Óî`úC@Vá¼Ö@- ÖNĞX‹†³e6g¥T¾×s°~oƒ—ÃlÆØ!Ã©òsŞ	¬‘Jšªp…ma«áÓÄ–§ái£É%tE=1Ÿç‚q¹·!2ıØ!€¢:Jç?x=¢Ç0{‹û1ÿ\0>‹…écRWPÀô\0/áîÁ‘{o„7¼òÁzîÊæ¿yKı¡ê–¥¯o®-µü¼ññÈ2Ã}qHû}g?†-™|ÎlOF¥ı²ó·y\\2l¥MÅ >÷o*³^:„ÔÖ:»6<ğŸÃ®‹~¸ã¨·\\Sá©°µ¼%«w™åR˜d{£DV×$X¯AùóÇXF®u1%ˆ°½Ï+ÃåƒLÃ/¦­ŠÓ¥Í˜lF\0¦‘á•¡F:K0ùl>ìr«áù-kÍHÙ„~¡‡uUI-¹6Øï¸òñÄyãGàíp/å¹Ã÷³°Üî:rË©ÙÜµüo|g†ÿÙ','1','test','2014-07-17 14:38:13');
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('2','0','admin','d033e22ae348aeb5660fc2140aec35850c4da997','1234','Super','Administrador','Default','gbg933@gmail.com','099394334','ÿØÿà\0JFIF\0\0`\0`\0\0ÿá\0:Exif\0\0MM\0*\0\0\0\0Q\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0\0\0\0\0ÿÛ\0C\0		



	ÿÛ\0CÿÀ\0,\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	
ÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑğ$3br‚	
%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	
ÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RğbrÑ
$4á%ñ&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0õ$$äğ3Ç5Îø¿ÇèmåC\'™tW¢ô_rjŸˆ~&¬í!d™†/!kÏõBHbšòC¹aØ“Ï&¿£èàäŞº#øŸ´•<;ùœ×ÅßºwÃhãTyµJùŠYÙ[2æíı.xËxá7‹hBÓVñ¥¼Z^‡u¾†0ÿ\07ğ´ÍÑˆşèÈ¬?ÙAµø•âM[â6¥qõÕíãYYE÷—M0¾ŒÙÉÇµ}e¦Á6Qıv¦ßÏŞ¹¥Rx®Z³|°ÕÆ+¯K³ÕŒ¨eÕE:ªÜÓ–®ïxÁ}›m»B#ÃVº(*ü Ğ{õ«ŒñHoík­¿{’>µèXÚ¼qÎMq~7ÓZÓTüüÙ§µzxiÚ§/‘ácâİ>yı“’Ãáâêv¤JÓÌçŒq“Í}/ÿ\0òü\0mKÂ~9øë­Zùz§Ä-Eí4ƒ*e¡Óâ8Işlô¯ÿ\0h%Ô<og¢ü=ĞÙ›^ø…¨Å¤Z…dÏï$Ç¢¨9ú×îìñğoKış
ø[Á:]ºCeáÍ6(UGª€XıNkó_³$êÓÀÃÕúô?nğo\"”põ3*ûÏEş¯ï;›˜­-L“HÇ
îy[…U$Ÿ§s_ß¶í¯Ájÿ\0j­SàŸ€u­CJøàY˜ø£Z´Ìk­\\#mòQº•İ»ÂvçÒ¾Ëÿ\0‚ğşÓ§ìÅÿ\0ìñ]Æƒ-ÂøƒÄÓEáı=¡lK\\¥‡ĞÖ¼_ş	[ûÃûşÉš‹xƒş-f5ÔõyHË´ò(b„ÿ\0°ß¨5ù¡ûqòÿ\0ü»ş—ğÿ\0Ãÿ\0²Ú§ÂŸ/Å>	…o<ØffŸS‰F$’rà|ÜÊ×™şÌÿ\0´î‹ûSÁ3¼;¦kŞ\'µ›ãÁ}{í±YßHRòïL\'Êm…¿ÖŒò£-Æq_¯†Â;«IdÛÈv8aòœö=«ñ“ş7ÿ\0É›ö_ñÊ|løs“áùïšÅ„a‘›—P:ÆİíŸJÎµ>jR‰Ù—ÖTñªşËOî=î	hDŠw,€0üFiÛ¼²­èk˜ø3ñÏâ‡Âİ\\±aäßZFåGü³l\0Wğ9ÒÉş¯ñ¯Éñİ:œ™ı9F²«IUÒIıç iïöÍ.6ëæ%p·vßf¾‘Oğ±ÙxNmú%¿û\0ŠåüGí©°:œš+|(ÎÆfŞY¥ı¹ŠEVSØÆˆÙ„~_ğ¯¯z›µ49¬åğ‘øŒßø‘Mşòÿ\0:äW¥u-ø‘Kşúÿ\0:äÁâºèü\'#âj¿§.µ¤ÜZÿ\0ÏÄmüAÖ®b/Í»5j`Eeh¶qÂ¼¬J}I\'Îv¯ŞëÅ8
ö©ÜÒö÷ö§g-œ¬X·[éšcÂ’ÄŸóí]7ü*ûÃ—·ÏÄ~4Õ4½ÁşÓŞõBU8dsµQwIPø$×Ì¶—ík§øjïRğîŠÍq4\"9.àuháÎC\0sÕòn£ñ;ZÔü†ío. Ñ_9ì c¶â^›Ü¾ßZúü	:pæ«ò?$ãLÊšÂÒ•Ôuo¹ûqûyÿ\0ÁØz_†5]CAøáøõ¯³³F<Aª£$ÆèâáŠ÷Ëcé^û(ÁÁŸµ‘ñ[Ã>2øˆ­«|)×uxô»Ù[NX­b@>\\€¬2I €kÌÿ\0à–?ğB?~ÓóØø¿âE­æƒàÖu{m4·Ú¨ëÂõT>§Ïúéû@şÂ>ñÏì›ª|#C·Ñôy¬¼›ãƒËû$ª3Šzîuë‚kè7ĞüşöÔúã¦‰£ø¢ÂÖê†ûFñE™b\0İñº}Á+ñwÂß	®`ÛÃÆfó#ğÏ‹³­xyŸ•#?2/ºƒƒøWèüãÎ¡ñöSÀ>+›o¾ß·‡5hä`$–³Ì÷]#lök‚ÿ\0‚·şÍó|HøIcñÃöÅü[ğÚãûNÔ ;î-ÇúØxë•ç¢½·,6*5—Ù<¬ë-;W÷’üVÇçí‡àÏˆßho|BÔu5Ö<¤êŠñGTşÎW8ÚÃ‚së“øWÚÉy¥c”’Öâ0ÊGÌHşµá|íáû)Û·†õ³’ê5¼·Rø_4b|t ñìE\'üëâ†¥â_…Óx[ÄI%¿‰¼âÂê>ó¢ğ‡ßŒûWéØ)ÆÉÆZÆ¦©ôæ?Ì#,F_N¢²©CÜ”VG¿Şeüxı…Ûş©<qğÎóş¿Æ|É Œíµ½õVQÀÏåšâ|/ÿ\0_\0ßÂ9ñSBÔ¼7¬[²İ¤%à—Ä1Øÿ\0³‘_e$Ÿ6õùKã~.üğ§ÇmM?ÄZ5­şáòÌÊHÿ\0İ~¢´Äe5!z˜Ir¾«£g.ˆ¨M*”9ÒÑ5ñ$y§†n„ş\'¿;?X´âhå„}2êwz×ìıá^k«¯húÕ¥Øn$f`{‡^Oç_şÙßğKËƒş
Ô<Yá}eWNÓ×Ì–ÎöL8èüGØ×¨Á>\"xª×ÂZºêsİ\\xn’;_8’ó¸)=…xø|UIc~¥‹¦”š½ÿ\0ÌúfğÚ9UWh»8½¿¿à>ÖŞI´u-á¹XİƒéÏ#ó¯›üUÿ\0§ø™¢ëR[ØÃ§j6ËÊN“õƒšıŸÖuKK]¯$_:\0€ŒŒï¥yí×Œì®æ2.jªzs‚}Íuc8oıõ_±Á”ñæcM¸TM¥ÜÃ$+ÿ\0túú×?ñkY?Ã]rè}èlfo¯Èk©ÓôÙ5«øíã_™s‚ºwáõ†½¤µ«Æ¬¬»$VYã‘_¢âåÍNTã£iÛÉ÷?Àáåíc_¢i¿DÑù5ûşÚ¿ğ¡¼y¥ëÓHşÖg&ï›ì²d3éÏ?A_«üygâ=& ¸ŠâÎà¶rºŸzüĞÿ\0‚ˆÿ\0Á;ï>ê·~,ğ½£F2\\Y¢å­vQıÏå\\Ïì+û}_üÔağî¿3ÜxfW‰/bIê¿ìûWæYFqW-©ı˜éèızú~GôpÖ?Ãmd{EñG½’ßûËñ?a&VO˜r¸Î=kœñíØ[XS™îHªø§câ?ÚİCuå½ÌbHn!;•ÔŠ«ãŸi±ieãÃbüŞtò¬j??ñ¯Ñ#	Aûo²–íéëĞüc(ÕıÌSæz4ÕöémÊ¿ğG\0\\~Ò?ğU¿x£W….4_„zI·ÓÓ–;©ÙBÉşñT’¿houìãi¦híÒ––g	=ÉàWóïûÁUíÿ\0bİ#âÄ	ğÇŒ¾!xëÄ¢¸Óímá,lÌ¼¿2•OnµÏ|Nø•ûI~Ş?´g€¼#ã/ˆ^ µ“ÇºÂ@š> ²µ³µ26ÈÀfU^2äšü/3£‹ÅâjcZn7wom6IŸÕ¹l&‡Ëã$§ËnUkíwu¹ú1ûtjğP/Ûwáï<?u·à¯†R7ˆ5é-Kmu{ÂÁnXpÄrÇŠúTÑ.´Kµ[Èšİ¤]êW«|ıš|#û8x:ßGğÆ‹c§Ã
…f ®çIIõ<šç>>^-×‹¡Œm>LlzšğÏ¥,øÁ‘xÓáUÕ³*$Íp^)\0û¬:‡ã_Ÿÿ\0ğZßi²¥ÿ\0‚tÛhdñ/cÑ¢é>UÉË¸ú($ı.ø?cı—ğúÍÈÒfV\'§5øéÿ\0-øı7ÆßÛı,U„š‚ÃÏUÄy9Èç•%ºĞÀŸ
5?±^˜4™¼4¾$ğä23”¶ıç”	É*ËÈõÁ¯pøuÿ\0ğ?Œ-µ·xVÿ\0€Ñj2.ï@Äb½ÒïLtÌº0ÊéÊ·½s¾,øOá[mÕ´-.ü‚e·]ßŸ_Ö¼¬^I†¯ïZÍŸY•q–cJ~Ò+K>ˆê|ñsOÔ-Ñ´İKOÔ­Yw…†el~G5kQ½mJùçTX÷ôRz×ÏÚ¿ìà–™¤ÑfÖü/<‡&M7P‘yú1#ğÅGìáñÂ!ÃßµV†>5Kh®sí ×ƒ_…joNW^gÚa|EÃ6½µäî¾ãßï}qHí…ë^s{ñïÃl‘¢ø7Ä¯Wex$qø6+[ø³ûA³È¶~ğê!áZI]±ï÷Åp>Æ_İ³^§¹ş¾å|·“•ÿ\0Ãcİ¼qqåÙÇ
°ıáËZæ~h¤Û\'Â¼7Uñ/í%¬Ì­\'†ü1Ñ¿øºÏ½OÚRê«£x~?Ä§\'õ&º©ğş)i$¾ó†§eÓÖ._ø	ô#É¹vËÁäÕ—¬øÛIğÜo%ş©cj«ÿ\0=&Uşµó×ìõûF|M˜¦©âK]Ñ¸d‰Ò3ø
ƒúÕ­ş	Yu¯Íæx£Çã7,!v~¬Oò®ê|7-ê³ÉÄxA+P¤Ûîßèw8ı¹¾ø\"ÿ\0‰ĞÔe^Z¯˜Iü+æïÚ+ş
©üJÒ[Gğ½½Æ—i7NNg”zt­}3àŸø%ßÃD?´,õ-móÏÚî™sÿ\0~ö×©xköcğƒ¶®á=œ«<kõ|šõ°ù6“æİùŸ+˜q†?ùbûo÷î~FËá­jöŞâúKCìñàË<‘0UÏrÄWì¯üïş…á½Ã¾ø¡ã‰ì|Y«j‘¥Ş•¦ÂÂ[+PÜ«1}Ç¡àUo|#Ñ¼yà›íóO·şÍ½ŒÆê‘=Çq]÷üöŸ½ı›>5^~Ï9›Î·³v½ğµä§ıe»š0{•àìkÔò>NR¾§ìGÃ/†ô˜WÉ‡íŒ€U\0D?º£µjxÇÁÖ^,ÓÚ;¨Æà>I|ÈkN)>Ô#‘NõÇß¥uŞ»MŸ’?ğQêÿ\0ğOŸÛÃôµ•|\'®•Ğ<ko>\\±3ÙŒ¡uù€ï_^ÙŞØxÏÃ1\\ÂĞên«nXé,n¼~`×·şÓ¿³–ƒûSü×¼âhæ³Ö­^Ü¾èÉ>‡ğ¯Î¿ø\'Ÿ5OÙû\\×?gˆW¯ÿ\0	—Ã¹ØiNHşÚÒ‰ıÌ¨Çïíœó@,x/Ámû,şØ>·ú>qvÚ÷‡Tü«öióû&ìV…>\\xgö¢ñ‹¡cÒu­>8äUo¿:ğ2>ëÒ¿àµ?üKğçãMŒ{áÔ—«²¯2ÚÌpö;ÔzF·m®épßÙÍÕ­À$‘8dpy+ôÎ¯fS–®«Sñ¾4ÂÖÁã%Z‘¯=:íÿ\0µGÈù†Şù«\'ÆŞ=ÑşøvmcZÔ-ì,í#24’¸_Èw>Õñãã6—ğá¥â]b@¶öŠ
E»æ
 {šüı©?k¿şÓ^3šóRº–-Û[ÉXb^ÙÏ¹¯K9Ïc€§e¬åÓª<~áZ™¬•J—ŒÕ÷ò;ŸÛ—öæ½ı¦¼fºeƒ\\YxGO“Bèç™ëÎjı	ı–íü?§üğÌ>û;içO‰”İ)P\\Ÿ}Ù¯Æ0Èş¸}‹ÿ\0Éø—ñÂ÷òÛÙèº†»àé¥ò§+ÒÑ»²äşb¾;)ÍÆ7‰WrëÛÈı;?ÈéÃ,öxKF0éßÏÔı8ğÖ¯ö­
ãKº“åÙ¾Ç¡â¹wWqÇ>”ØÏn]øoB2:SÜy‡“í_¡t²ØüuA«ØôhŸÙvJİ&e‰=«MWk³Œb—9?Ò†½º’rw>•
~Î&~¿áÛéZŞÅÄŒ$@Ã¶|ûKÁ!4¯xªûPğ¦¬ºD—Ëö90«CÕGµ~„½øtí^OñÁµ­ÃzÕæn·š”6ï%¬/ÒW…®<n	‹¢Ö*7²ù¯CÖË³ÜÃ-¯—Ï•É¤ï³éwÏ3ò†Óöø“û*]k^ÓõÙ-×Mº{g oû;© ùyè+êØ;à~¥ñÃÃ?ğœ|CÔµ-z;Ç?a´»™¼–Çñ²Œí_xæïTÔ¼k©]kK2êS\\;Üù£çÜNNkîÿ\0ø%7íâ[Íà›«;wÒt;o2…^,ö9ç“_œp¾*LÁa±R“„n£»^ıW¡ûo`ëaò9bğ0„jhç4’mlù]¯«Û]¬¼3ğ·Ãşi%Òt›;%;£Œ)\'ú~ëßğF/„_ğ¾¿oÏ|J¸„Ï¢ü3´MLvO^KÌ¬‡ıĞGã_ü{Ã?…zÆµ!ÚÖvîQOwè£ñ$Wèÿ\0ü7ömºı›`_
&£øƒÅÛüAª‰dY®>`¤ÿ\0²:}kèxÿ\0
0§„§¢ošËk-ºŸàş_[Š­›b¯.UÊ›Õİêİı4>²Ôõ8ô:[©¶¬P©bI¯®<{ãÕC1¼˜’º¿ıa]¿ÇŸÿ\0 Å¥ÀûZQ¾q‚›û>øXÛXÏ«M|ÏİÂ{Züœş„\'ı¦>!Ûüıœ|A¬å®Ÿbc·=3#a‰Í~xk^oø«ÄŞ$›sIªß²£³ndª°>ıkô“şïûF7€¾ÙøVÒcÅÇúTŠïHÿ\0º‰ï–|ÿ\0Àkó§á—„E‘¤hğÇ·ËDF_~­úæ€=Ëà’Kwà½·kæEæñÕıu£«x9d/nŞ[7;?†¶ôM:=\'K‚Ö ¡!@ j°à‘Á »}wáûË)J´-ŸUªÒXÜF7yL§Ôƒ^‘³#•Óãü?•cæiY3ÍÚŞB„0ofÇJA~fİ‡5é&Ğ0çoÓ}†/ùæŸ÷Í<á›w\\ß5ûÆ½/û:ùæ¿•\'ö\\óÎ?ûäP¶Îcm«ÎM5‡ù·{g½z!ĞíIÿ\0SıóM³fÜm×>Â«™ï©Äéz=Ö©>ÄŒíşùûµÕi^·³MÒ4¹Ï°­Hàû<[cÂûcŠ|{ù‚úqR\'®å{‹(¤‹Éhã(À‚¡q^ûIü#Õ.îl¼Eáy¾Áã/ÜGGºèdeçÊcıÖÆ1_Clıæîø¬_è¿Ú{H«™£û¾â€>çÿ\0‚MÁCt¿ÛƒàEŒÒ·ö‰t¼Yêº[³XÜ¨ÃFÊ~ld	ŠúÔK¼ãkú×óó¥x›]ıŒ>4Çñ{ÀpÏ3FWş]&Gö¥°9iÏUäŒrkö»ö8ı­<3ûa|Òüaá›Èï¬µ–BãåeÏPËÕX‚ Š\0õ¦8Rkà?ø/gìşÇölÿ\0…İá;qgñ+áL©¨YjP²Ii»÷°É¼˜ç¾úó7¡=W×Ö¸ÿ\0Úá¯Æ€ş-ğäk%®¹¥ÏhÊÃ?y\0~;üJı¹<%ÿ\0#ÿ\0‚FüFÔ£k;hú(“VÒg|Iip¸Ä±©äÆÇ8aœgšøöKı~:ü@øG§ø‹Áş>‡FÒu/víÂ¶Ücì+Ğ¿f»}Cöñ†¥ğ‡Ä>	Òmí|¯£êúÅ­Ì–—&ŸËò˜/X¯ ç¥}åà_‡?ÃYèzºéúm„\"x£şÜıO\\ú×Ôd™O´›«Îíå¡ñœEÄáÔ:zİ)$~c||ÿ\0‚vşÒ^3’!«_Iã£å6jª¿ğ+ŸÊ¼“Cı…¼AáÍVki¾*ğÔcæ[»mKÛu^û0@5úù¢|=ñ^âñw\'‹®/tÄık÷è$Õ?‹:¯ÄM.ı§ğŞ‡áßiªl®n79îAl%zu².N«rùëùjx¸N-«Ëì-ºr«~z~çOÁïø\'7ÃOİGqÄÈµˆØôD	o9ú«Ãò¯¶>|$Ñ~
xJA·k{+~sZF=Kæ¼»âwÇ¯¾¯%·Äÿ\0‚ ğôÑñı¥‰‘3Ü£Ä9õoáÿ\0…¼ñ0ÃÃ_‹šæ…pÜÅ¦^Kæ6?ëœ 6+|º¦ƒq¥şIÿ\0™·Öq0J´ä—¢kæãşG¶ˆü„Ü¹7<v©@,má¹W‘xÿ\0À_¾ø#Zñ$Ş+ğÇ‰4ÕîšÚK&ŠâEQ“ó/+µø9ãéş&ü-ĞuçT·“T³K†9U,2@Í{´qŞÑû4š–ú«;)ˆË
^ÕI5{hï­¾G½(;E)4§‘K_Scó)j0«àUwFY³hİB³}ÖÏİ5¡ŠGéÈÍT.„Ê
QågÇŸµÿ\0ü³Ãÿ\0ÚâöDñ*©òî¢Oİ\\ÿ\0×Eïõ×Ÿÿ\0Á;?g]köhñoŠ4¿[ÇõòFl§ŒîxÔ¶ì^WŠûßVÒmõ˜|»ŒÜ+¼µÄx‡AşÁ½òÛiEù‘Êô¹®å8j¸ÅŒ¤¹f·ìújêœM˜SË%”beÏJVJúµmROµÏ<×ü/í\'ûHü+øGj­2ø“W]GT–Vøgè•û±s=·¼,©n‹›ÇŒ*€\0€¯ËOø!\'ÂH¾3~Ô?~3Ü¨šÇÃ¡<\'¡I»rœ’÷-ïHÆ}ëôCöñkC¾•aX	e#Ó°¯É¸£2úî:¤©í’ô[ŸÑ<“¼³$£BjÒ’æ—¬¿É}yq?<HÌ×^\\c™?ĞW¾évşĞ\"€Š;H²Ç?)\0rOó¯\"ø¢.¯ãe™×÷vˆ[ñ=+Göàø²¿ÿ\0fja•n. û¶N7<œø.ãøWÎf~9ÁQ¾4IûN~ÚVöPÍæiÚ]ÌšŒŠ9(Š$Ç»¸aşí;à>ÚŠ$¹‘söTÈÏ©¯øsªÿ\0ÂãŸx©ÛÌP»6–ßÈ„•ı[\'ğ¯¤şéKoáY®`×Rœ1îÇs\0±^†ŸL‰²ŸzÜŸ—¯“…°3O²°›YGmo5Ã7MˆOë]Ÿ†¿gı_RÛ-À]>6ùşfü¨{h;;{©³‡YÕŞõ©tû;QöÛ[Í;v©l×·h³î‹¦Fqç_ÉßqÛå×õ®ÓIÑ,ôKuÎÒŞø¥%Ç.]ìıàöÿ\0¼C>š·?cdFÍ‰?*çuûA“mİÄ,?¼ŸÖ¾¦bÁ‚FPHÃ$1íUïô¨uH¼«ˆ£š1Ô2î¤¤÷4•&ªË×SåPù]Øüé«>îÆ½ó_ø¡ëåš’ÎnÆ#òşG5Ãø«örÕtíÒXÍê¯llqU#)y}Î9R¾Æ—5gVĞo´	vß[M/d;:¦dQÿ\0Öu6a”éJãŞ’bT{­>ñ–ŠºmóFË˜n#=«Cş	cûJØ‡öËÿ\0…o¨\\y>ø‘+Şè®í¶;[ÑÌ¶ã¶G¦ßzÙñ¦™ö­1dUŞĞÇëæïÛ/ÀWş(øO.©¡I$~\"ğ­Äz¾—4\\I‘œ•Ï¡GµR@D–Z„w¶‘ÉY\0(qVŠ‡\\0àğkãOø\"×íõgûr~ËN¡4Ëÿ\0	‚ÓQ„ğÑN£ÇQ»¨ü}+ì§}ƒŸJ?¼Kğf×àü÷ãæ“ºCˆná×­ğ¼:Üşñ±ìˆ®íU“åãJîà«~ÿ\0„öòøwâ¥VX<a£\\h·,ËæÀD‰:àãğ®’=kôn©à£«Gä<[FQÌù¶‹_y5µì°Î}*ôÛŞ»yŠªİÇZÌ×^Œ[hõ¯¢ö¶v{S›ª4o¼1k	TTí¹C:âü[û;xGÄ
f¼ğŞ“,ŠA,!$OpÃ}Á®ãOŸm¦éåÏÊOzšgó­˜¯Ì„~µµL=‘øQça³,e¶Sv>ñÌzïÂø_z-Æ½¨ê^´ğñ–Â¹L¿fi°xŠô/Øö_´şÌ¾nn™şB¸ø)õ½ÇÃo¿5fıÌ.º°±‡#ï$gqÇÔ]Oì)yö¿ÙcÂlí¶»yö5óy\\<t¢õj/6~…Ú®S
«íI_ÕFÇÕİ©qšŠÊö-JÎ;‹y#š	<n‡*êFA¦¯½Œ“W[ŒÔ§(IÂjÍhÓÑ¦º1¸¡¨Å$Švo`Š»°…Ô˜níŠğïø(Åuø9ğÿ\0TÊß\\!³²Œ4’¿ıkÛ÷maıkæ?|5›öåÿ\0‚Ÿ|#øY™>¦ÎuİYTü¢ˆ$ŸøQÿ\0¯\'<Æ}W.zz;Yz¿êç½Â¹\\s<Î–¦ÉŞ^‘ı²ùŸªğEOÙ¢oÙ‹ş	åà½\'Pİµ¬Ûÿ\0nj$Œ3Ë>æ÷ÛµÕüBÖÛZñmôÌÛ•\\¢öE{–±umá?Mµ#‚ŞÎ*%@ÀÇè+çgİÜ™?ŠV?­~Õ¾çõOTü­øXõ¯ÙçEò´KËí¿5Ãü§Øõëá?ø83öŠoøÓÃ¶·9£€3F¯Ë\\LDQqê¡˜×è—„-#ğ—€ şëì¶ŞtÇ=>]Í_ˆßµn™}ûwşÙJ°êG¢iwÒkWlä±1®è­“íÇ?ìÒ‹â<‹À^_x7KÓUW÷0ªHÃøœòÄû–$×ÓŸô)“Ã}œ0M,R‘®[\'Ú¶|û1øoJ+æÄÚ„ŒÀ\'İÎ}+éßøjÇÃZt0ÛÛÃnÈ€aPp1BÕ–ïucÄü?ğ\\Õö¼‘‹8I2›ò®ûAıŸt]9‘®Œ—’®+©Ÿ¥vz·ˆm4(ZkËË{xeg
«øšòşÛ^ğ‹ÉÄšÕÄyµLÿ\0¾x®ZøÊtê»öOÂ™¾iQSÀáç;õIÙ|ö=kNÑ¬ô¨V+[h Eş\\cñ¨õÿ\0YøZÍ®u+«[TËq*¢şf¾?ñßíÕâŸ<‘iio¤ÛçåØ7LÔôü+ÇüCã[Å×í6©¨]_LOŞšBÄWÏâ¸£({Ìı×†~ù¶)Æ¦iZ4cÙk\'å}±<mûsxGÃM2iòM­Lœn¸?ï?*ñ_ˆ·\'‹<a$‘é¾V‡jAËåúî?á^+.N0Û½9#iäXÑYBTX\0óøŒ÷QrÅò§²]ÏŞøsÁnÉÿ\0{VŸ¶”u÷õKäôóüZñF‘âµKj©|Aİ7œsøŸ¥z—ÂÏø)Š<4Â[C­Û¯rşîl}zõ¿ÚŸö_‡ß±§†Ìvëÿ\0	%œW»`¿4ŠÜ²~ÓŞ¾èq]‘#
×<Ş§ÈKÃSR¯%¸ÂN$­nªÛ\\ıøsûuxÇ©rjCD¼“\0%÷îÁ\'°n•ï¼(¿¡Y­î“ìŸ´Fw,ŸCŞ¿/<íÚ®Äñ^©ğ§ãG‹>Ì‡Ãºö¥§6V)É[Ğ©ëô¯BHé»UW^GÀæ^ÓÅ\',ª£‚WÑê—ÏsõêÏá†ywvqßdmış7ĞWã¿Ø«Áş\'I$³†]éÆw[ŸŸR¦¾cøYÿ\0Tñ_ƒM¼>4ğøÔ­ÓÛ&CïÏËšúGáíñğÓâÌËko®.—1ùmuä;@OøW¹…Í°ÕôŒ’}™øŞ}áe-ûjQ_j:¯øxßöñg‡·K¥I¯ä€¿,¤}ô¯#Öü!©x?Qk}JÆæÊaÕ&B­ŸÆ¿H,îÖê/2)XÜd:0`=*®µá­\'Ävf-JÚŞñ_‚%Œ0\"½Ú[3à§F¥7ûÍ,~mNVH]NHÁ¯9Õôf³º¹¶e®6üßtƒÿ\0Ö¯ĞŸŠ±…õİ.òóGVÓn•ˆ‘¾cr;mí_#üCı–<Uaw%å´qêP†Àò8t¾SÉ5\\ÉhÈóü:Ÿ)şÆ¿¯à˜ÿ\0ğPİ8ÚÍ$~)J š O—gvmlô}‡¸cé_ĞÇ†õ¸|Ká»]AYZ;ˆÄ‹ƒœäWóçûk|¼ñÿ\0ÂFÄÁqm­èì5\"ÈUâš>x÷#\"¿T¿à‰¶şÕÿ\0±/†ï®$ß¬iñ-IIæ+ˆ€W)cş9ğ¹üaû\"Éâí.6›Røk¨C¯G±rÒB‡l«ë‚§ô¯“¼;¯Úø§A²Ô¬¥Y¬õRâ	ä:0ü¯ÔŸiv>?Ò<IáB8æƒR²x™şZG*•\'€ŸÒ¿?c=Z÷àïÄÿ\0ˆ_uö‘5/‡:”Ğéşyùæ°.|¢>ŠTı¯«á|dc]áåÕÆ™lªáãŠ†ñßÑõ>‡G>^F*K{´Ê«—¹ô¨ã;“¦ßj–ÒğÚ9+óní_sMkï•Õæ×·«ºÛ@‘£)Ç¥6Ñ¼İ.Mßu}ñ“TîåóX6~ñÉö«>İ*l÷é]ÖWG¨rÓŒ^÷??ÿ\0à°—ÚšşÍÍı×ø¨­ºÿ\0Ï8„LBÿ\0:ìÿ\0àº’İşÉş9_‘Ô1ªğ[\"ı—t‰£2ëhÎ}ÌmT¿àš·?hı“4SıÛ‹…ü¤5ò‘©ì³I¾ñGè
ëä°Šşv}û x©õ¿†òXÉ!gÒç1®{#|À~×¬gŠùóö$¹&ã^‡wAãşúô3^Ÿ‡xÉbx{:Tœğâ¿iô™Èée~%æ´(®XJq©ó©Î_ù4›MdYwôÏZ:T:êXÛ4²gšû]oîŸ‚T”R÷¶9‹>?³ğvw5İÂÁ¬fk™ü³E&½‡şYû\"jñÅ¿´F½koãËXí<*’“¹ÙqòùŸ)œ_!üvğ&©ûDxÂ_ô¶íoˆÚÜ{2‚Dvû•û;k÷Ká×ÃÍ/á7ô
èvëk¥è6qYZÄİ5
¿ ¯Ïxï½¤pÚ>óóoo¸ı›Âœš*\\ŞšŒÂ·yÏü{Ô<¯,óÚp?^[àİ\'ûsÅ¶6ã¼ ·ĞW ~Ñ7~]Ÿ÷™›òÿ\0õÓ>øG÷3j“/9ÙGækóƒöSöõø¦>~Í\"š9<»ÍE•¾;ŸŒ ùwûiöú–ŸâŸHğ¬:¥é´‚L`ˆmÉB	ôo¯¤?à¼?´ğFƒg¦ïÛa&¡8³—qµ=y¿3¾øßÄĞ|)ÑtûíBãlpxcıÚï™²\\±5Ã˜c£…Wjçİğ/â8‹*Q—*Š»m^×z}çÜºßíá¿jy·‰©\\ÛËmnãsãß+‹ñçíáâ}¤]]Üğ§tÀ{±ãô¯Ÿ¼3¦¶Ÿmº@<Ù†ãZ*3œŠø|Ã?¯]Ú>êò?°ø/À®Ë¨F®2Ú®÷–ÉöK·©©âOê¾5•¦ÕµÍA›ŸŞ¹*¿AÚ²Qv û¿QŞ¥	åFÀ;W‡*““¼›?lÂá(áb¡‡§¥Ñ-½w ŠtƒŠÕFM/xéÒöµØÙ”˜øÎkèoø&·ìñÿ\0ûöŠÓfº…›GğË®¡xHáŠœÆŸRÀ ¯Ÿwm°sè:šıtÿ\0‚^~Í‡àWìãg¨^Æ#Ö¼Q·Q¹ÊüÈş­3ì¼ÿ\0À«ÔÈğ^ß«Åj~GãW,‹‡ê*rµJ¯’=ÿ\0¼şKó6?l+4½Õ,låUky-6NÅIÆ1ô¯Æÿ\0Ú3átÿ\0ş.êZc®Ûq!šİû<mÈüº}köSö±ñUé¿õîßÎ¾ÿ\0‚|\"ÿ\0„³À>$³‹7Z+lºÚ9xÿ\0ì§\'ñ¯³Îpªt}¢Wkò?’<&â‡—fÿ\0Wªí
Ú|İìÏŒôO:mÿ\0óÌæ½#á§…©zo.÷6ÇåŞoşµqŞÒ$»ò£Œ|Ó>>•íº&•¦Coÿ\0V0HîkóœEIB\\©ŸÛ˜
0öI¦ÓòüÉTG1a7Í»±è+Wøq¥ê ³GåÉœ‡ˆà×Aå©ì(´tâ¸ô½ú„£.V“ş¾â§‚¾$üFø/\'™á^-¼dbÖF.˜ì¶E{¯Âßø+V­¢\\CgãÏ	•x7zyòØSgqú^*T~5WTÑíuX¶\\B²/AÇJôğ¹Æ&…¹e¡ñ÷‡™nÜ±xx¹>©YşŸ¡?
m_†¿UcÒ¼Imô€fÖô%Ğ‚qùgÄÏÿ\0dkbhş[;Á½6ò¹ï_˜ºçÂf³ÌÚ|¿tåQ¾òŸP}«_Â´—Ä/…ÍöXõÛù O˜[ŞæhIúŸÈ×Óàø¥ZÕ—Ìü;‰>ŠÕÊ«?IkošØû·Ä>Ò|_Cªiö·‘°+ó¦N+åßø\'î¼¿ğOŸø)×Š¾çì¾øƒ^Ğğ±L%„}\'ÜÔßÿ\0à¦ë/ÙüY¢InÑ‘›«Ş­êJ@ú\\·íÿ\0ãüUøy |Tğ&±k7‹şê1êğC¿Ëšklşú\":‘ƒœzŠú6a‡¯­9~‡áy×gyTŸÖ¨>Uö–¨ıaø­®·üá?«mÓî®?²/›·ï¹ˆ“ØŸzüƒÿ\0ƒşêŸ±üÀŸ´[VşÁñb.•®mV‘psî˜#ıÊı8ğ,?m¯Øµ]êI¤Ö´Xïl3ó¤Š‚XÏûÜcñ¯4ı³¾éÿ\0ğVø$®¤¦Ö6×î´uÔíB\0ía«[ŞÄ¨u–<zšôéÔtç°ŞçÆÕ§”åJ¢Ñ«?3æëVş#Ğ¬õVİk}
Oÿ\0e€aú¹Ò¾tÿ\0‚düT¸ø‡û3Úéº“2k™ô›Õ‘¾uhØ˜~~ô[¸‘·/zı_ˆU(ª½,¾óğ|ËğØ™R}û¯ Ù>çãVãK“Üb 4èÜì*¾=kª5Z³Î”]KzŸÿ\0ÁU¦_~Ç#”òtMz$‹*ÿ\0ìÕâ±5Ş¶?gMtù¤XK€B±ùÏı1^ÕñÊoŠŸ±¿ÇI™5¹=ÂÕLü”×Çß²wí‰iğgáQĞ¯‚³C{,‘{#?úêøœÂºX¨Ö[J?“?VÉ(µ‚•®ã/Í\\ûëö5ÕVÃÅz¤/ò­Ä€}\'kéQ&F~è¯>j“i:İÔıï-AüëŞ´Üjñ*%ÓÇÌ¹¯cÂ~Yğå7­çÿ\0¥6_Ó+šŠÚ¶m8QÛş½Ak÷Œ÷±ÂÜÈ¸ïšå|iâ¾So‚HÉ5‹qw5Ã0y¤obİ*L¯İTdâ¿V§‡P÷™ü“ˆÌ§U:qZ3¼ÿ\0‚cxi~&ÁR-æfi¡øá‰.™HùV[†ØÔ_¯ü§ÊğkócşáoøH|Añ«ÇÒÛ¢ı³\\MÎ|®‚9Áôİ_£ZÖ¯‡§Mw/)n¥Í>ñ!â3µz_ğ?°ø?õL§A«Z+ïzêy‡ÆĞş%ñ®Ÿ§ÛüÌ£iİ-ğ¯Kğş…ü=¢2ªÂŸ1=øæ¸/„–2x·ÅWºõÂü›ŠÄ§§?áÖ¯~Ô?cø[ğ3Ä:Ó8Cghë¼ÂÌ×Š}+v?à²¿ÇÆo·Z-´Ò²ëZßÙU”åM¥± ş¼¯AÓ>Û}»‹’;}+ŸñÎ¨<ûFë—îÍ$>„XÀÙÏï[æ—ñÂ»¯Ú}ŸIóïHsŸZø~\"Å9UäGöw€<;9cÅÔZÔwôKDkg-»òö§î¨Õ÷8\\cÔÔöZeÖ ø†$çÒ¾MŸÔÒŠ†—ØbóKÖ·¬~ß]ÎñÂ¾„äÖ•¿ÂÕn¸’O]«Ò£òÅA3“œSGİ=zví]Œ¼ıƒmçBÎê¤jç7~åNí­}Å\\}õdiFqœe(¾–ô=—öı¤ı¢¿h}KugÒìd·äâ4äõ Wí-•œ:}½½¼k¼1*F t\0c†+åø$—ìÜ~|>&Ô!òõ?ÚQYpñ[•ã‚ßğ*úÍ¹pØäWé;„ö9íñçÏ\\eı·J…7ûª–>«yz·øûX’<Y¦òãİ¿ô*ñ¿xnßÆz-æ‘uIä-†`ñ^ÉûYx·Mÿ\0¯süëË¬ãj©o_ç^Ç-ÕŸ]ÏÇhU©Iª±øï§–ÖgÀğnëáGÅgG¿–M&O.=Ã‰¹R?à$W@8•õïücàR§ƒ´ŸÙAûÈÏÙ/ÙGğŸ|î•|‚pË÷{WåYÆÑÄ´ş^‡úáçC;É)b¡ñ%Ë/\'?ÅÏSsN^My‡Û…#â”QŒĞO8õWVÑ-5¨v]F®½9®£§ĞE8ü,ñßü;} ±naşé×·±®WÑ™­&µ“+Èc|?Ò¾×4˜õ­-íäPÊA+ìkÆõ}/eÄĞÌ›Z6*3Ú½>!ÉÚG“ËiW¥/h®}Aÿ\0ç~Ó’x&ïÅuÛ†fĞ§7G˜ÖYÈÄŒöIÇ°¯³¿bB?‚¿´¯Æ?ƒ2*Cko¨ÿ\0ÂW¢Ã>ËzYæ\0z	Ëÿ\0ßB¿4¾\"|;Ô¿dàí¦ZÈ±èò­¾¾ñ\'ü|X]6Ce8ëĞWÚÿ\0¶7Ä[…´×ìñûCis@Ú­qÿ\0ˆ\'O™e¶½]öîHãb/\'ûÕú–îŒ[?Î~&ÃÒ¡š×¡KàŒæ—ß¡ñoíwğıà›_ğVÍcJòÍŸÃÿ\0Ñhiø\0Gîå,?ï¢GÖJö[W¶Ğ,eº¼;[8#ŞòÊáU¹&½ÛşıniØ“şí\'‹>ŞGâ	\"ya_–dû¡¿¹A_™?´‰îÿ\0j­GáÇ‚ì¯d_êZ2kºäÉƒ,`HÏ³75önx°9}IÕÕCUó?3Í¸^y¶iB8uÔ|¯åÔú[áÿ\0íào‰º¼švƒâT¼ŒåAt¯!úò+´Œ³IÏ\0Ó§^µñÇïÙCğ÷Âí/éº‰<\'BÂ{8Är»\',¤Haœ×ÒŸ²GÇXhß€º‰#}²hD7±÷Štù_#ÜŒıwğÇÇ6n2ViíåcÍãïñ<9R/ŸI|®y§À¿¦¹âOŞ¼]n5	NÆû»&„ó_Ş>ğôñ¾­§H¾[Ù]É	QÛE~Õ.“/ÃßÛfi£ÿ\0_4b£¹ƒŸÕWäßíÃáãáÚ·Æö{~_í9$_`Ç5ÅEÂŒdÖÍ¯ÔîáJÑ–*tºJ*_£üOĞŸ„‹›ãşÊÇ&»Û{–³pÑ1Y3\\OÂ”[=.úêM¨›€Ë:×aisøİ‹\"ã9Cº½_¢èğş=¼şNLîúTWX¿3)ÃŞŠtàì´N4 š¿­ÑØi~&‚æÏ÷¬Dêk?Ä>6û>—uöOšE°Xpx¬$1¾İ¾fìã§ZŠì	-ÛoFSÉ¯Ñ+ã*J‹Œ}æ\\IF8¨Íí{Ûµ§ÜŸğl¥&µÿ\0ãk‹ƒºi<G~Yû±óZû³âÚøBî!ï]:Â?_	Á²vŸaÿ\0‚tÉnÍş§Ä·ÊN:şğ×ß+´şĞ¿Ó-qò›9¾ŠøŠü´¿{>÷ıOëš){4–Í+zt(x^(´=n¡í,ÄÓ¨şäm\'ë†¯ÿ\0àµ¿bømğ‚ËCi¼±\"¾£tàÅ!GâÄ÷Ù›â$ş2ü_Õ!›}¦“¬Ûøz6 hİœƒîf³_”ÿ\0ğ\\ŸMñ?ãMşƒksç[ßŞÇ£@³û˜ù¨I¨Çš[]†xŠ°¡yI¤—›>QøC§ÜÂº…Øÿ\0M×&{ûœõß3ÇáœW¯Ù[ı’Ê8{FqŞ²go±Ã€1è+¸eù~[¯ÏQÉŸég\0å0Àåğ§d¢£ÿ\0u„?h¼OñHğ¯V±°ÂÙcvªJóªÛúyŠZõfé^\\¯cé³’ºBmVíMbQw
vêc¶ì¸ä‚³Z^×fÄ;¿±ølÆ[æ¸eŸcŸéSşÈßî¿hßú†-¡g†iÄ÷nDp!ÜíùWãÏÿ\0mjŠ±±û<YñŞ¿J?à‰_³wü ÿ\0õoˆš¤>]÷ˆˆ·Óƒ®;T=àM“ŸJör<¯‰äé»>OÄÎ*\\9Ãu1ÿ\0‹Sİ¬´_rÔûÃD·ğİ…¾›gÇm§À–è p\0?J˜ô »Ëq)\'©\'ëUu½VhwW÷’G½œM<ÌOŠ	9ü~ıØèœ³æÄb’mÎ[y½?3ÀjÍ~ÊçÇ¶¶qÜÂ÷Ö¶Û¥„6Y	ú×œY>Ûè[³J¹üëã{¿Ûë^ı»oüM}\'üIuéÛOÚ[+ •ˆşƒ_`Á(“Ël¼8 ğEqàq±Å_“£>ÃŒ¸3Ã¸ŠTj»¹ÁJı¯ºùh}9â\0YüVø%{áë•V‹P·xşaœ1û§ğ85ùAã¯]xÅz¦‹}Ç}¥\\´)ô¯åƒø×ëoÂIo|4‰»qÚ>€şñ‡üàqğ¯-¼oj…­õÀa½!p#•GÊßˆïí^/`T©{x-·?KğŠ1–S9{•µ]¹–ëî¹òqÿ\0&•94À_œkóçäfF6º[¥4”RPMEx qÜk6Ä-ÙkÎ~+i~F¿Ñ®VèÃÔçèÍ÷9üEfj^ÿ\0„Å¾´P¬×Z”Pn‡\'¦kl3|éwv83
Š–ue²Oò>ùñçì¿¦|eı†íşêV«åİxv;?+¨Fò†?#_şÆòjŸµü;âÇìõâI&<øk¶V%&Y,ßÍ¶‘=7${Aô¯Óí2±iÑÆ¡@TUÀWå·í!ãgı‚¿à²>ñ•®Øü#ñ G¢ká~X¢¸e)[ÔŸ»ÿ\05ûcË¤™¹–!×ÅÊ«ûM¿›gèOüWãå¿í­ûøOPÕ#MJM8èZí¬ŒÃ<*a•ÜíÉú×ãçƒ>Âƒıµ¾6xQu·ÛøoS[9‹n0ÙgzEíjûKö*øü×ş
Ÿãƒzœßgø}ñÉÅ>›8âwMnL02sÔ Ç5ò?ü‡OÔ¿dOø+5ş±}”ğŸÅhàçlw)ÃíÃ×§5É›Ò•l$£ı&{<+Š¥†ÍiV«²nß4v·Q‰âeqş¸lÚz=Ex¯ì{â(?eÿ\0ÚSÄŸõ\'û.—â©ÛUĞ¹x³ëÔí^Ğ÷1Èñ†’=ÍÌ|òßJóÚ³àoü-	Ç>›hÇÅZLÂm&î9ü–´”î,8ã¦=«å¸_8]ö×²Ùúw?Mñ…aer Ÿ¿S]<cø­
İ|løqæy1i/y{u#ğ‘CöiS$úna_Ÿ·w¬~ ~ÕŞ2Ô´ÙâÎKæH¥NV@¼dW×Ÿ?mıjÛöJñ‡…|eo—ñ\'MŠ-8L­·ÚÈêDãºç>õùÍ$ìÒ1Q÷kõŒë2†.”}“¾·üæ^ÈëàkÔuâÔãîÙö½ÛûÏÕ{Åñsöu’Æ)Íuë’)Ã!pH<~äŸğOm
çáş»ãë—RmZL¸Šy	Ì]™sÛ9é^ßû?¢‚,Ì[û:!Ç~+Àà¥>»ğVŸ¤øÓB¸¸Ó5=Íassjæ\'xØ ‘zúÊ˜j8<%ødÒ§­İXøz™Ö\'=Ì±TqÓ÷ñS”Üºó¶İıûoÚ³öÔ›Á:Óüá;ˆõäŠ—·¨w›mÍ©ş×^{q_GhŠíáûQ#n“È]ÏüNHäšü’ørójtY$’Iä–ú\"ìÍ¹›.:×ë‚–²‰T}Ø—Â«‡ñõ1•\'^{mò3âì–WK†¤“j÷}[î}ñÿ\0æÙ‹?ØV…~UÅWëûhkí?~<´øSğ¿Ä^)¾‘c‡Ãúl÷EÛ€¡oæ\0¯‡¿à…>>Ğ~~Åş&›^Ö4İŞ×Åúgº¹X€aé““ôÇÿ\0Ájà©şñ×ì¿¯|%øcs}âŸ|A¶{;y,#\"XU”ÈìÇ˜éÎkó<UJp­QIëwù³ö<¶JÔi¸&ıÔ´ïdwßğKŠ§ÃŸğJcâ„Óîºñ~£©kşcŸ™¤šB#Ü`zWåOÆKñ;ö¢¹¸‘šHü3mµ™sq1Üßˆ}uğÃöœğŸ„?à_şè:„ÇPğé–?[M—%”‚ÍBÎ=ö×Å¿´û©4—ñÒ·Û|M;êR+v~Qø
ñózÎ8FáÔıGÂŒ¦8!¦ë/áİÛÓc½ğŒmë7÷Wõ®NkÁpí´™›«9¶ázWæøˆÿ\0C²:|˜8Ü}¬­it’pÀŒW¬Ûİ	ìã‘rË\"ƒÀ¯#!˜7é]G…¼ı•d¶÷»,c
A®yjtc0îz£¸ı8Ï5ÅøßÆ¢d’Îİ˜Fÿ\0$’ÿ\0J¥â?Ük41n†#èÜ‘X
şc*´B)jÉÁà¹W<ş^¾g_û>|\"¼øçñ§Ãş±F}Jñ#‘€ÿ\0Wù¤oÁA5û± xZÏá·‚´é‘Ç—l–ñ*Œ\0_Á¿g¹4{=câ6§f¢käk-İyD7¸úãôÍ}ö¿ê¾|³îÎIé_¡ğşR£í¤¬äøıÆsÌó˜åÔeîQZÛng»õéèæ¾Tÿ\0‚³|}…?³äº…Á‡Rñ[\\†ù’ùhòş5õb¸™¸Tå¥~6ÿ\0ÁH?h>?şÓšÓ[ÌÒèŞc¦X ?+9wÇ»dÀk¯<Æ{+Œw–‡‡à
kñ*UW…N]ŸòıçÌ^*sÔ-¹·ì85úû|]OŒ?ìd\\ßé	ö[¤ÏÍ¹zõ¯ÏßŒ\\Cşé¯Tıƒ>0ÿ\0Â·øÇÔŞN—¯bŞ`OÊ’JùœéM6ôgïŞ3ğÏö–
¬é/ŞÒÕ[²İ]×ïÙÿ\0ÄJú%“1 I˜ö<Jè?i?„1üqø9¬xvHÖI®!g´sÿ\0,å^Pş`W•üÕöÛİYaó	“úÿ\0!^ıá-xk6Jå’4ÚØ=kî§Ê“Œö©ü_—â§—âã‰¢ìá$×›¿è÷?5[)4mZâÎuhî-\\Ç*0ÁRG´£m=kè¿ø)/Á&øsñŒëv±*éş#Ì§hÂ‰¿ˆ~=kçøfnyî{×ä8ÌÂÖ•Ğÿ\0G8W<£œetqô÷’×Õi/Ä’FsHNsXú.V/jIšBxïH[ <WOğC_şĞ^±’5‘N¢\'!‡İØW0¿3íüëÓ`{ñ/ía|¯a,ç<íc…Î½ª´ÄÆ>hù:Æı[\"ÅÎúÆŞ¶?C‘¾CÆĞ§m~\\ÁU¾ÿ\0ÃAÃãk8¿´m$Zt‹÷¢¸·å>¼ø×éÖ¿­ÅáíâîâEUÏ®@í_œ¾4Õ†µ®êZ„ìGs,Äú‚Äÿ\0Zılÿ\08ç¬®x/ÇŸêÿ\0·?üsÀÿ\04Fh~-~ÎšœR]›„6L™ëŞT‡Ù¾‚ñÎáŸø//ücDñE¥Ä:Œ¬¶­ÄŠ2ú^­á½öIƒÏ¡¯?a‰:oìëÿ\0ñ7ÃM~ø·_¬æò­äQä¢¤:àñ†C ÷,+Ãº_‹àßÛ¿XÒu	¿µşüJlù‘Ü.-ã-º9LYùd€H¨Æjn­ÊöÉÅÙny·ì½ñ\'Äº\'Ç=Oá×Ä¨§‡Æ¾ŒØC&Õxcg¹pG=Æ}\'~UË(fUfÜr+…ÿ\0‚Š|]øC¯şÔ¿ş1xGÅ:.©ı«nt½gìRf@…•#¨†“Ó±ÅŸ^ñˆ4¶YP™À\'?Zø Á¸×ıÒÑ£÷N
Í|-f”ÕÖ¯Vº&Á^şÇqáİÅöÌÓA?Ø®$Eê„b\0ükàÍ¯ì+öƒâwÃmã·ÂıCA½’ŞêÆı‰\"tÆÀåXry¾ñÇüGÅ–¾\"™t=BÊ÷M<Æò±Ç\'‚=Æ½¬—3öxuJ»Õw>oŒxoWõ¬\'¼¥kÛ½©¿f·kÏ€~“î²éñäzñÒ¾ı¶~9x¿Ä^7Ö<¬^4­6ù„`a‡â½ö×@ı¦eĞ¬ôÿ\0øI·‹Ë‚3<&D^Ù,àçğ®KÅßğLß<@ÚŞ¼Ú÷ªåî0Ã3°_£g\\S­„…u^šy?3ğğÿ\04£2¶êOİï|‘ànãÃ^/±Ô-íÚæk)’/ß´çò÷¯³>ê¿ÿ\0kË‰5+}HøCÃ9(—ıç²de±ë^—ûÁ/›ÀúO‰$ø‹o]]0´¶#Ü7_ŸÎ\0ú×ÕZ‘¥ø[K²Ò4«hmmtôòâ%
ª½‡ùş7Šjác:8\'ÛSö<—ÃÚÚÑÅf”Ö—Vk[ùŸ0|?ı“üSğ÷[¼…µ;]v‹µÅ¨jr¼ëo#³-©ıŞíÜîë^»ğÏáŸ¯ï5K‰åÕ¼Az¡n5Ÿ¼Tà_a]…ÅävkºFUæ¹üTµğ¶ƒuu½!·q½øÇ€¹5òu1øœL¯ÕŸ©aòœ_KÜ,b¶]/ö¢‚×IğKhú\\QÃ©xãQŠÎFŒ|Ò“’ìqèŠjoˆúzÚ]¤8kQÀé´\0+šğ¤7_ÿ\0h¦2[x7K{Ë…ÎqwrW`#ÕQ_ó®çã<_ñå\'vkëó
r†
<İÑòæÿ\0[ã:Ü¾î…(:qoáŞkKµfx8ÿ\0Ä™Ç}Æ´Áù?
üî·Ä yoû¥?D=~í)ëMSòÓ³šƒĞ{‘Ì@?…t	~ß|\\ø›áÿ\0éÊZëY¼ }Ô\'.ŞØPOá\\ü£ÌFx>õ÷Çüö{[½[Tø‰©Û[ƒe§N§î?–}Íwe¸7_omşGÄøƒÅø%­“÷Òj+»’²ÿ\03ï_…\0°øYğïGğşÃk¥Û,
 mÉ“øœŸÆ·ÇÌÆwb‡;¤ÜÁyE5Á<şµú¥8Æ)vGù“ŠÅ<Ei×¯+ó6ïİ³ÅoÏÑşÎ¿³vµ¨$Û5MJ/°Ù&Hc,ƒ@Iü+ñtÍ4Ó¼’±’i\\ÈîO.IäŸ~Iükìø,íÿ\0ãŒ>³”¾›áHÇšTü²\\¸Üß\\)QõÍ||­“_ñ9×ÄrÃe¡ıùàO	¼« .´W´¯ïÉõQÓ•}Ç?ãOõĞı?­bÅ<–Ó¬Ñ–Y#uu*pA\"¶¼gó\\Ä:°=+¶qÑÒ(úlİÂ­j‰««¿ÏÔ_Øãèøğ÷CÖYÕ®-¿ĞïS<«.ÏÔ`ş5õÖ™©Éa<sÛÉòÙ…~Aÿ\0Á<>/¯‚~%Éáû©ˆÓõìlÉÂ¤ëĞş#ƒôú{ğŸÆë©AŸu ó¡‰ûË_}•Öx¬=ºìøÃ+(Î\'E|Ö?=şãwö¹øioûCüÔ­m¼¹55İštmê3´½ŒWæ#C3FèèÑ’¤0ï_«J|™LË…8+õ¯Ì?Û§Âú§À7ÑªùšV¸Mõ§Êv®âw.}kçx«§Ëˆ§ÓF~Íô~â¯z¦GZ[{Ğ¿{ZI~fÈ¨zÒ¯Î=«‰´ø¼ˆ¿¾µfÏt`YO‹Ö5­Âı1ş5ñ>ÎGõTfŞ‡]Ñi¤¬Ÿ(jåâ¶ËÎ}ñş5­üSº¿‰’ÕÚ6Üzâ…JW\"RÑŒ¼q†“Ê·e–åøNv{šúş	e>!ñ·ˆï¤UX\"Kbí÷‹1ßÇå_ê~!3y¯\'\'¦¾Êÿ\0‚kÛJ>jwÌ¸mCQ*\0?ÜZúl‡şÔÈ¼jÍc‡áÊ´ãñK–?~ÿ\0ôÇÆ?ˆ’xƒJ¼”ÖŞ\'Ú21šø[Ç \"_²ÆÛ»¾+éÿ\0ÚÆ±x_áŞ§åûd‘”\0Zø·Å>/ƒÃZæ­¨Ê±ZØÀóNìq>Õú,Oá?#æ_Û×Æ—ßşx{Âé»Æ–:ªj6÷÷­TŒÃ$7ü¾”³ı‰ü;ñZ‹ÄŸn¯¼}â»ÄV¹¿Õ\'wU$d¤iœ*€_~Ã>#“öı±¼SãmMD‘XÚ;Y)çÉÌŠˆü\0µ~è:²_i°¯˜Šñ¤gÒ¾C>ÌªGõxé¡ú·dte„x¹ÇšMèŸ`ğ¿ìwğãÃ1©±ğ¶……àı‚\'Èú•É«÷¿³ƒuV‰¼7áÖ»>—ÿ\0R·ˆ>Î˜ûbÆŒoÅ95‰†á32õÈzùÿ\0¬TšWwùŸm¾œW/*KµÄ_°7„.â‘ôÛ{ã ‡Ó/%´^¿ÜFúRXşÍözªZ®¯¯7–0Y¯7—>¹<× ‹û…LüñËf«Ë6_æ0İòÕ^ÕÉ“a¤t^@ÃrsŒä×?®øò-)ÙcTÊğY›ŠİºV¸µhş_JƒıÚñŸ~Ívzä²5ÑÖ[y\'Ì‡T¸\\}¸Çá\\üÊö›±éSI¦ômtnÆŞ±ñuîÏ–¬ÍŒğƒh®nÿ\0ÅwW9eeŒ}9?r·5í
//AñÜ1Ç°_(¸Fú»ƒ\'ş=\\ß‹>|TñF”úm¦³áß¾0o!¤’Cì şuÑN…=fsÕÅb ›§Mßû©[ïdŸ¿h}á´’^Ïq¨j{1°2Í)=Õéõ5Äøà·ÄoÚïş¯ˆ6óxGÀ:‹»=)†%¾eÉ]ãĞœŸÂ½«ödÖ¼+û6hĞÚøËÁ0ÚjÊÿ\0é>%‰R[–îï#n•<íä
Ğÿ\0‚‰~ÓïìâÖş×4ıBmy…• ‚L¹gÀ9N£ u¯´Ê°8zPçŒ”ßä~GÄ™Öc‰¨é×ƒ¦—ÙÕ_Îû?CÉÿ\0c}|i¯øÃÄ­æx†ÿ\0Ï‹ÚË*~5éaÿ\0‰Mœ¿İ”Œ×œ~ÊÚrø;R±Ò£cK/(VsıkÔ¾-Å»Â$ÿ\0Ï9A®ÌÎØVâ=—áçŞj?~‡1àæÿ\0@o÷Ík•à¯øó¸úŠØ_º+òºßş•erÿ\0c€áÈ¥¦)\'İ•àûY”¶r5<àëÏˆ^0Ót==L—Ú¥ÂÛÂ wc×ğ?…~âşÏß¬~|#Ğü+cÕÒ­Q$ùêäeØıX“_Ÿ¿ğGÙÎ?üHÔ<u¨GæYèäY—4ìHÿ\0tWé³/”û„}çà”(J´ş)lı\"xËë™<–Œ½Ê>ô¼äú|*BŞKÛ	¢ŠO.Iª¾>é#ƒøTÆæ¾£xòÌşi§>GÌ·ÓË©ğo‹ÿ\0àŠëãjµçÄ+Ù/5—¹”›E;Ø“Î:
‚ø °‘w\'®w­šÿ\0…}ÿ\0¥Ùÿ\0hËşé®‘Ë·Uşíxõ2<—3Š6~³†ñ«‹éF4ébıÄ’I%¢Z[cñãã‡ü\'şÏI§/Œo& Û¶3ŸÂ¸§ÿ\0‚[·ı‹ÿ\0€õúûYIÿ\0‚ëş¸§ò¯4(şÇÁÚÑŠG%O¸¢u}¤±Wï¢ÿ\0#äm+ş	•¨hZŒ7V¾,H®­dY¡qûÀäv¯¬´ºÓ´ÛQ4áî#VIPmÜÀrGÔÕ‚iÃî×V

Ğ>_ˆ8«0ÎU?í	s8^Ú-™Øøwã=å„IÔ+qq»£×ÿ\0ÁGô}ãÀY5Xå×‡_íP™i##™ü®ÏU}KN‹Tµ{{„ó-çVĞô`Fiˆ¢«R•7Õü9œVÊ³Xúvïİ}Çå—öı¬*szğµø– ~]ÏìF+wö“ø`ÿ\0~1jÚ6Â-ÕüûfìÑ1;@úr+…i¯ÎêaaèìeùêÇa¡‹Ã¿vIkëÓäÍ‰<QÇËÍïTnõÛ‰\\í_j§%ÌqŒÉò¯®k:ûÄĞA¹U|Ï¥§\\u³ÔähÍ +¹ñ¸sÉ¯º?cÏ\'†fL›«ÆyŞOîÿ\0õWçmŞ«5ì€3|Œp¥~‡üÑáøQ ÙãıEšgòÍ}&CJÕÜüçÿ\0³n|¾ı©ßîD_u‰ƒ™ä“sË(.ÎsÒ¿$à£¶dŞ=Ön<áëÌhÖR4GkmÏ÷AÏÖ¾¨ÿ\0‚ÂşÜöÿ\04üá»ÈŸÄÊÆîH˜§ÆF0}×å…´)¼câ>Æ=ò\\j7\'’ÌÍkê¹”cÍ#ùšŒå¯‰è}=ÿ\0À>6Ñ¼Eâ-CÃúM¦¡¥‹P.Vä”ŞÁ
Œ?ŒàõãÖ¾¸øuûrø/ÅÚÄšF¥4Ö o.[=@ye[¦t5×~Ï_tÿ\0€ÿ\0ôİÁcY#ˆI;ù¤”˜“õ8®_öı<\'ûDi~eõªéúÊŒÅ©[®ÉTöİ¼>¹ö¯€ÆcpØŒSuc¦×]=|Üòœ«—àaï-Ü^ß&z€ñv›\"o®$m‚Ú‘ëÖ¶|?ñ*ÕÃİ•Ò¯e™Xş†¿\"ş<şÊş>øâF±ºµÔõY‹k›Mò¤ËØñ’µAğçà—Æ\'xî¼;£øª¤‘HĞŸÔŠÚ9zU–¾_ğO9ñ–!Tö50’Ó³mşGì=ï®¦aÙ·^äÖd·-,…™˜÷-_øÄßµÂí.4X¼Q
€µÀçıæcø“Z—ß¶ÇÆmo#RøSåİ`1
’ƒôb+‚YeE-%yók÷å>\"¡8¥*R‹ìã#ôåUçp>Œ*DlöÅsŞ%»Ò|e¥½œ—×P)ó!fD÷™ğÓÃö_l.!]{SÖ#Rêoçó^.\0ÚÈù-©é{Jvå±Ø\\éŞŞFî@¬GÀ:}ïTù¿¼JÔ†ò‘¹dCÇ@Ôé. …>yWÔµG¸m{œ>¯ğ}[Ìû=Ëª°\'ñúWÉ_·\'ìááÏøO´x×Xğì«q<QÇµncèIP0Xg¯^kìïø²½½³3ão¥q^#Kİ*âÆü,İFÑÈÈpFoÅ<=KÇc—3ËcÁÊ5·³·©ó‡ìÅãx<]}¡j±~ño#ås÷×ºüL¶ûGƒ®?ùWË¿³=Œ>ñ¦­¤[ÈßG×^TõXØä_UxĞyŞ¾ôÈ=+ô\\D¹°¯ûÈüO‡eõlò…úTOî‘ç¾û“}kl}ÚÈğtx±‘»±­€0+òšßşœåqÿ\0c¦ÀŒšŸFÑ®¼M¬Zé¶qÉ5ÕôéQ¢ä³1Å@Ì1üëë_ø$ìèÿ\0>5Éâ«Ø7èş\0Ç½~Yn[îÀsøVø<4«â#B;Hó¸Ëˆ)ä™=|Â¬¾»y¾‹ï?Cdv¿³¿À?øjÕg·¶Y/Ë;üÎIïó>•é%piHXğ`v¦‘ƒŸlêkõjtc(-‘ş`æ˜ú˜ìLñ8eRW=J~\"ñ&›á*Kí[PµÓ,a¼¸¹•b‰;rÌ@ÈÚ‹á°Ú?á?ğnåÿ\0Å¾ã¾¾Rÿ\0‚×|p]áæà;Y6ÜkËĞç‚}Ñø¾ßÊ¿5ÚÎ©û¨Ø€JŒ
ùÜÃ>Xz®”auÜş€ğßÀxñOÛ^TT¯Ê’Nêö¾ºŸ½Ú/íEğÂÆ1ÿ\0Á~dGöÍ¿øıiÃU|4ÿ\0¡ÿ\0Á§é«Áÿ\0ÅWóş,¡VÏ•Ü§#ÇÜ_Ê¼çÅR·ğÿ\0¹ÑV>_øuüOÕ¯Ú{ãwƒuO‹77)ğìĞ´Iµ×Q‰”ñê¸ø¯ásÿ\03‡ÿ\0ññUùƒã–ş5te‰X~uÓ\"”£gø¶|Ş+À5:Y–Ÿİ‰ú¦>)øeË¯h¿…ô_üU)øá‘nÌŞ ÑCoãçõ¯Ê)le~~Óp¹çÍV—Ã’]šêç–ÎL‡Š¯íùuàE+ÿ\0¼¿+Å¯jvÓ[FñK‘²†Œ_ÜM:œaÇÌÍì;{×€şÀ_\"øƒğŠ-.yŒ—Ş>C~i\"şı+ß“
;mß_G‡«ĞSùÿ\0>Êkå˜éà«ë(;_MWGcæ?ø)Ã†ñ\'ÃÈ|Sgg»PÑ\\¤å&X:ıó5ğ[øîXŠŸ—Ğ¯q_°Ş ğm‰ôÍ6ñwÚßBğÈ`×å§ÅïƒëğïÇšÇ‡õ6ıŠvEÆ@t<©Q_;acŠ·FCx?ŸVÅa%•ó¥*z¤ûk.µA–êébÏï$
+:ïÅú=£|Ú­€Ç?5Êj^|ğ½íÇ™&Ÿ43ıMxÿ\0í;¢øÂ¼Ó¬4µŸ\\6Æ-Ù¢|òIè>‡šóğô•i(jµè•´Ï±™¦[‡&ª‡*»W”µ¶¶JÛ¾‡m©|ğ_…omÚóX·hÕÃH°Ÿ0=2+¦ı¦¿à·w¿…ßÃÿ\0ô¹´õhU¼P%AŒˆ2ÔşUñOÃÙ×Æß<Ao¥xÃz¦£}zÛa! 1ú}iğ{ş÷øİñ[É®.‹á+y9?kºYdÇû±–ıkê°8*XxÉ)sÍ<aÄØÌâTş³OÙ¨¦Ò³ûîÏ‡üOâ]CÆõÆ¥ª]M¨_^9–içrï+¤“É®ëöDÔ,t¿Ú;Â7ƒE¬7ÃÌir?\\W×Ÿ´ŸüÀ_°ÿ\0Ãm{\\ñ>¹uâ]KO_\"ÒL2Ü0Àê@9¯%ÿ\0‚sşÈZÇ=NïÄŞ I4}-ü¸àS´M.3Î;
Óˆ…:œûXùìWŒ…:™Şÿ\0qú9äŠ²ÛÉ¹JıämÀj–E]ªw³}kÆu¯„\"øNZ÷Á¨iÿ\0zMîS¹\0ÿ\0.{û1Åhü5ı¢m|cq%¬›¬õH8šÂö3ÄMìŞã ×çTN<Ôµ? ¨f1RTkÇ’}ÏÑİ¦xfÏWµ_2UÀ8â¯Gà[8U·\\²àÏ5ÂØxÂÖM§Ìhd÷5 úôr&ãqŸrõÌ£5¡Ù¯x»Ì<‰Wk*·UïY·úüV·,»›ÔàÕ]WÄñÃy/¹Ï é\\Ãİ´®ÌÙÜMU:wwc­Q¥fÏøUñ{â÷í	ñ5o¬tõğo„ì\'xîáİ-ÒƒÊŒó¸N}1uªAmu¼“Gós¹Ûæøõ©’„ .{À®sâßÃhş*x*ãK[–±»fÚé2$¶“³©çô®ªÕ)b$¹R‚9há+a©9JrœŞüÍ%è—C#ãßí şÎ::‡ˆ&¼òç%cX!.½2:WYÿ\0ÁZ¾]IåÍe®B™ÿ\0]åîğÅz/„?àŸÖN-î<[¨kŞ7’>c]Jè˜\"#¸p?ï¬Ö·ˆ¿dïÅ#*øWFòGDû¿BtS–]j—“î§öÅysRq¦—Ks7ó8Yà¥__B{È5;­Øâ·a ?Jùÿ\0â·ü.kû¹¡ğ¾ó…¹¼lş!Gõ¯Tø¹ÿ\0íğ—‚Íiguáùã8g³ÿ\0W\'ÕH?¦*Ã¿ø\'g|t.oa¾Öî#!—íRaÿ\0º ~¹¯J„r¸{í6ßFx¹‚â
¶¥uİuôìÏ-ıŠ<{qâí[]Ôµ+ˆQ»Ôé×!XõÉØr+ïLïMıÙ!şb¿8~:øş÷ö½µŸMV³ÓõU>TÇ@ôú!i¬*ø
Îév²ÜÂ˜Ï¸¯®Œ£SuµÌiÓ1´~ô&¯ç­ÙÊh¿eÑ¢ÄÜš¿Ô›<˜ÕGE¥^?*ü¢·Æ©ØÅai[±%†.«}¼*ÒK3Vbp~Ñ~Áß\0#ı?gKhÕ5+¸Ååóò¿$~Å~vÿ\0Á-ÿ\0gi>9şÑÖz…Ô%´?	ÿ\0§\\îYeé}rwÀ+õÙT(ÂíÛÛ«ìx_¾&/øò7Ò?Œ½¦\"Ÿá¥îÅsJßÌö@«·§­Gw{o$ò2¬p©v$ıĞÉ©‘w²¯İßÒ¼ş
1ñá~şÌôĞÈ«©ë16ÏûÁ¤áˆú&ã_MZ²¥IÎ[ZçóGå5s<Ê’|Ó’Û·åv~cşÛ¿eøıûGøWišK8&6VkÙbŒàcêA¯&ò†>”ÈCHŞc33¶s»©>¿MŞ¿)ÄUu*9¾§ú‰‘et²ì,†œTWÈiLSvñõ©3øEbzÛEœÇŒ¸Ôcÿ\0tV^ÏzÓñ{nÕ£_öEfõ5êSøOÍs/÷†0ÇÏSFİ»†æçŞŸŞ˜ÇšÓ–í#†ıÏXı‹~*Â®øÛ§ùÒyZv¨ÂÊ~Ê7pı	¯Ñ°Ë\"†_ºFA­~G[LĞÜ+«òÎå#ªÕúYû)üO_‹´­Eœ=Ü+ök *ê9\'ëÖ¾›#Å+:R?›üpáŞIĞÍ!ÕrI­û¦ÏDoncÇJùş
[ğ¶iŞ2µ‹kwÉşë§#ñ¯®W÷ªr>\\ñïX|mñ;ÀZ–‹t7E}F§¯–Øà¡¯W‡U©8ıÇä<TÊsXc#İF_á?+vç<œ)ÅQiÍ;LlmZV9g1‚Ì}I­ÏøjëÂ\'¿Óo¢¸° ‘ªœU(ùÆzWÂòr]u¹ıÉaŠ£ªÒŒµWÔö¿ø\'×‡Rı¤¬Ùa@º}¤·*ãuöjı‘¶¦s÷Fs_ÿ\0Á.t´øÿ\0Äº«©\"ÖÕ-³Ûç;¿öJû;SœZi÷27İ\"ß¥}Kötú¶#øÅˆ^ ”!öcşyø¥ÿ\0êøÓ&­ñ[Nğ­¼!ŠIo§P~W$ár>œ×oÿ\0Ò’×Lı˜4¸c+×’Ë3œu;ˆ¯’ÿ\0àªş)“Å¶ŸŠY›|v~]º~îÔ\0şµÔşÁ?õ?‡ş¸µÕ´İBO[ÎjqÆLvNÇî·û\'×µæUpÎöyó<†1Œª&“Z>Çè«ÆŞJ§Ëîk‹ø±ğAø±j$º¬õ(ÔßÚŸ.x[Ø£ØñG…<{¥gÔ7ŞZÌ¡ÖD9VSèk®²›í°	cå¿#\'¯„æ«‡‘û•HÑ¯TW‹ş®»*üBø™ãÏÙbçì:æ‹/Œ´‚A·Õí—kˆı$ÀwïŠë>~Óşø’c×TÖõúÚÜşæ@Ol7ZúãOö=²C±c˜ÜnSù×Ïÿ\0´Çì£üsñ•©i7ønşÕÀ¸–Ù1æ ç ş!ë]ô±jªÕ×+îµ¿©óøŒ7L3çKìËGò}~g¢,Šÿ\0u·{ö¡—&¹x+Å_íãÒîï´İZÚÍV8dò9vbÄôÑÅuº1½J7qœÖ2²•¢Ó^Gtg7M9®WÛ±ìSx
d‹å‘KzUm¼-}ÒşåC)ÈmÂ»¯iW^,HZÒŞfY”6×ùJgûÙû¿C[+ğ,Ş³†in!v“  r¹y å©ÕS¶½NvĞ8D˜WQƒƒÅ8¢Êv•Vü:Ön©â»}<ífY$#¢œõ5Îjÿ\0RÙ74Ö¶Š§¬’şµ¬–*äÊ”­Ìô^z~&Œ4«{q½TFÅ†WÖ¼ßÆ‹
ŞÆÉµd
w(ô¦|Hı ¼1á\"mKXñ—p©`ÊîsØ(ÎI>‚¾\'ø‹ÿ\0O¼½ñ=×ö‡osk¿<ìÛäAÓ>•×‚Àâ+É¨Á¥İ~gŸ`°PµI«ö‹»ÿ\08ğürë¾¿„í¹g’\0å²PËú×Õ>¸’ëà×‡rÙ0ÂˆùîB×Å?<]âÏï‡<aãOŞiÑßhxÔª‚ûHr¿(æ¾Íøurº×Â;9-Û|~qd*x*zs_q—ÓäÃ:rwk±øÆ‰¥W1–\")Æöjı{šşo˜[åÆŞ¹=)›ñ.ßÃŞ½cÄ¿±ß‰´¿iÚí”GT†òÎ9çŠ1ûÛv*;şå2#Áu$r,Ívœú~ù¶a‡©BµªFÈÿ\0Fø/‰ğÖWJxZ±””V‰êŸ[¯/#õş	Éâo…ÿ\0³¿ÀHo¼wà»]wY?l¿Yu‹u’7?uÏŸ”‡¦kè«_ÚŸáàWÄLİ0šÅ¹Ïş?_…	g_\"6b{¨É©Å¤p¾á£{•íáøQ§p‚²ó? â£½<ÛS_Ü¥\'-»ş‹¡û½Çÿ\0Ü`xdÆ:Ÿí8@ÿ\0Ğ«ó{ş
÷ûGÙü^øÃaá½şíÃqîy-¥C4ì:†ç_#µÔ™Rş^Û*#¸»3s¸ô¬s\"©‰¥ì£3ØàOp|9›G5©ˆu9SåVZIõƒŸÃóÖ˜ƒšu|ëNúŸ¼Æ--@ÓOJSÒŒñøPWFr¾-ÿ\0ÌîŠÎïZ>.Õcoök;5ëSøQù®c¬H^Ôİ´´uªØài=ÆÛ/ÊG5ô‡ü‡âÇü\"¿o<9u6Û=f-ğ‚ß/œ½1ùWÎ9Å:ŞîKµš$†Tå©Sê+|-wF§´‰âqGK6Ëêàjo5£ŞÏ£?\\ìE\\î)¬q8>¢¿*í¾,x¢ÌŸ/^Õ{bvâ¯Züvñ•¬‹·ÅÒÃÏâ¾…gÉ$¹OçùøŒ„¿wˆZ-šwlö¯ø(×ÁæğïŒí|Uiú«û«‹ò¬Ã¹úŠù¤+¡×ş.ø«Æ)ÓµOjz…ıŞDÒïL«3Ã~Ô¼c¬Ç§iV7W×Òœ,PÆY¿JùúòöÓn’?táœl«*Q7I[›¥¿àeÁ/4o±ü1ñë/Íyz‘†ÇP¿øªúâ=ßÙ<¨K÷X@T\\×ûü)Ô>|³ÓuhRBIZi£VSv1’;ñ]ÇCì¾™á¤pŸZûl¶Ÿ³¡u?xó0¥Ï1XŠ2æ\\öVíoó??ø(œ@~Ù>:VÎæÔ]‡ĞœŠıı’~èÚì½ ibÖÖâÓR°WJ³³ÍŸ^¿¥~~ÿ\0ÁFîşÙ6`¸ÛzWÛŠõïø\'ÿ\0íÛƒ¡³ğOŠİ’Ç;,.›$B1ìc\\î­\\:tºjkÁ9†‹k¯6Šıañ§Â?~Ë:¼ÚÇƒâ¸×<3y—z9mòØír<s^…ğïãşãïÃy¥j–ë!<©$,-ıÖSÈ#Ş½ÛÅö:…ª•š=²Ã\'†SÅ|ãûJşÇÆ=JãPÑgê’æH	XfoVQßŞ¾b–\"—&+İóÿ\03õ
Øzø;ÏiÅëÊÛüè{LZİÛßh”8şé«öŞ.ºƒ\'— #\"¾ağ‰|Yû!ø>_4z×†ãŸÊ‹R¶“|–»º^¥•{w‚|w£üCÑ#Ô4;ø599†ÛŸQÚ¦¶pÖ:®èßš}a(kc-ıQĞjÚÔ×¸bª¸ãÒ¡ò×jŸ•·æ£».-%…ÛbíãÒ¼w_Ñ~*x3U–Ï@{[I\'Ì·–é{?ÀO|c¯¡¬éÑMédV+	9Æéößæ~’[|A°ğW„ãÛoÚ™7;mÂƒï^ñö‡[	ƒM$×—7YH ‡ıtçÑGaîkÌ®>=x·ÄÚõåµÇ‡–ÒÅ[m¬ÂäÃÔ€8¬xSñ;,n£Óæºù.o1¾t¸°\'=OJÆËßØÛÚ(Á¸_›mı§ügñ[â?‹lô
êØÉq—¸µÓÉ-d¼`Í7MÇ1Šãuø\'×üil—çÄ7¸¾Q€$/¶s_Px/Àö^ÓRÖÂ-‹Ï$‡t“7÷˜õ&¶~S7S^¥<ÂT—%4½m©à®§^NxÇ)7·¼ÿ\0#ã­#ş	owp±âõ’Ù\"(˜¶?àDŠö_„±‚~\\­ÒÙ¶¯y+qw† ú…è+ØEsÅ:2¤å¾îyÏ5³,MEe?»©®‡pisBšoï·§=ñKÀöş;øqªi7a·¾?Õñ‘ìkÇÿ\0a/Š2è_£Ğõ]×–Vº“Úù«Ë…FÀ\"¬şÑß¶VƒğòÚóÃúT‹ªx†ôxÕ)lÇ€XúûVìÙğò_øGÓîZòâä\\Nßí¹É¯{#§Vœ\\ç{3à¸ëBµHÓ¡iJ*Í®‡ì·Ãˆ:?¼?i7k4qÆªĞŸ•¢ÀèW­`üXı›<7ñ‚’âÑlõ¿%İ¸
àû‡ñ¯“ôßxcP[›‰-f^w¡ ı{·ÂŸÚğ[?BFÀ[¸Fü	­{°´êC’¢¹ò¹F{˜euU|iBK³üÏøÉû\'x£áB<Ëjújßh·hÇûKÚ¼Äå>ò²ç®{ı-Ğõk?hæâÚâŞòÖuä¦6}}>•åc¿üIŒŞX§ö>¨¹\"HGîœÿ\0´ŸÔ_\'á›§S­äÏêúDÆ\\¸n\"‡+z)ÅiêÕşóâBß>ßÖ—ù×iñSà‰>]·ö…“IfêZ7¾ßqLvõÏå_\'Z•J.Ó\\§õSœ`ó:ßV5#mÓºùùNM;µ26Ë~úÊ2¾§¦!àRÇáJİ)¿Â~”Ã©Ìø¿F?÷k,Ö§‹ÿ\0ä!ûµ—^­?…™c¥|DıE¤-ƒE4ƒš³’úÿ\0_€¥ù¤a‘»¶qFÜ.ãÒ!î8ãÜÒJvªªî\'éN1svBœãy;[¿OV\0e»~u6›§Ï«ŞGom—Fˆ¥™°íß¿`ß|Q0_jÁt°I™? ÿ\0e©¯±>~Ìşø1`±é:j½×Vº¸d¬~¼cğÅz˜<¦µo‹D~_Å^,eY\\}ûj»Y=ógÊÿ\0?àZ÷Œ„7ş-‘´[!Å´\\ÜH¾ÿ\0İ¯¯~üğßÂ/ìº›¡ÆR3#û³k¥»»‡N†K‹‰£…#–m Wšøßö·³ßo£Æ—t30ıØÿ\0ú|.]N‚²GógñîoŞ8ª+éè’ó¶ÿ\0yéº…¶‘K{p°§RìİkÅ~4|W³ñtk§ØùÍ2y†cÀ~=+ñ/‹o¼Ouçß]I0ê?*ır¾?ñe¿ÃÏ\0jš½õÂ¥¾Ÿm$ìÇ5ßËªgÄó?³§¡ø¿ûpë§Äµ§®3÷u‹ˆ¹ÿ\0eÈ¯7ÒlîõmRŞÚÒ)®/\'`‘E–y°P9&½Sá\'ìïã¿Û›ã ÑnuVùç¸¹ØM½¨w\'tĞc?S_³ŸğOßø#ß‚cí&ßV×`·ñg×³ ò,Ï÷a^Øé¸äı*ù­2–èøáÛ|WıŒşøf÷âç†õ_ø‰¼»ùéôö#*³á2@>•ôâ_i0_Y\\Cugr»¢’3¸0¯ÑoŒ¿¼?ñïáæ¥ái°ê:>©•,R˜ÿ\0ºÊ{×5ø§ûLxc^ÿ\0‚IşÔGÂ©¨Mâ/ë}ºÅ&]Œ±1åG\'æCÁ= ¯Ìr•YsĞÓº}O¼á¾0—‹mÂú>ÇÒšç‡´ïÙÉ§ê6¶÷–³I«¹Oÿ\0^¼ÓàÃ/À¾9ñ”:]ŸÙ­c¾Xâ!Ô?]ÂøÙ¢‹ö9$ÈimÎ<èRşµØAj°M&ÕMÒí€&¾nR©I8KO#ôÅF†*pÄÑwqûK±#Çæ4j­Ï@?Z‘SÎ¾aõ¨÷ì”(Æì÷í\\ßŠ¾0x_ÂZ³YêšÕ¥¥Ú¨fŒÊ\0ôÈ®_gRM{=Nº˜Œ=\'ÍVV¿~ç¤jŸ
5mAmBTŠ8ã<ÇŸ˜W6$ß#nÚ9èJó;ø(ÿ\0‚üqhë}âk‹u%à»Sã°ÏS^ûAÿ\0ÁF-u\"}\'ÀñÎ³Ü|¦ıÆİ£ı…ëŸzîY‰œ¹T]»½ÄYu*N¤j)[¢woä}}¼sşÏ_j†òú;ši$H£Œnws…Qêkå¿ÙNßÇğçŠuÉumVûWQ™¦ÎäƒLÒgî¯NÆ°äğ7Œ¿i_ˆš‰×µé›ÂºKùmö+ò±Çıìt-[K+ŠmNZ-ßùÿ\0ÛÒ©B4¥Ï-¢ô²îÙíŸ¿mo‡ÿ\0ŒÑ¾±£v â;2$çÓ#_+ü`ı¼¼]ñ‚å´ÛÍ¦ØÜe@¦K™õoğí6¿±G€¬İY¬n&|eƒÌX]Ç„>økáü i:U—;Àcïšë¥SEZ™ù^.e÷*TTáÕGWo6|‘ğ÷ö-ñ—f]CQ™tub|ÿ\04½:çë_A~É>2Ô.<Aq¥ë²G=÷‡u³’`>YGcúQñ+ö»ğ¿¯dÓí|ÍgRÎÁ¯Í†ôİÓğ¬_ÙçBÕ4ı+VÖµkscâÏµù-ÃF£îƒ^î_R½GzšDøn!Âåøh(P»—]w>å2)_­O¥é’jËkûÆîOA\\ßÃÏÇâÏ	Ûİ/-´,£û¬:×A§\\É§L—
ÿ\0¼½EzÇË‘ğÛWÔ¾ÊÓXê,Œ~h˜æ6ë^ñàºŠ/”Yİ1ıÛŸoş½|Ícñ9ˆûD&/W­K]rÎõÇ‘wîÀÎQmêUì¬·î}uªé–ÚÅ‹GqwÌ0|ÀH¯øÉûi~&–kß7ö^¡‚ßfc˜%>Ş™ª¾ø½ªx&Hÿ\0x/-Aæoº=jöüQÒ|sÛGòî±¹ás†?OZâÅ`h×MUÏªá2Ír:ê¶_YÃºOGê|uğ»\\øa©}—Z±šÍØ¬W÷rºİëÊ£ø«ô›Ä¾Ó¼W£Kc©YÛİÛÎ0c™wõëç?Œ°aƒ:‡ƒäVWµ¥Áà{#|vaÃµ©Şt=ï.§õÏı 0÷.t½”ŞœËáoÏ±ó.ğésIŸ•¾•{ÄŞÔ<!«Ic©YÏcwÃÇ2${{{÷¬üñ_7(N.ÒÑŸĞø|UğUhÍIZêÎ÷ùìs^/?ñ0ıÚÌÈµ¥ãùÇşè¬¼×©Oà»?8Ç;W“óÜ\0â£’Ps÷zûW{ğölñgÆ÷UÒtÙ#³WÛ%ôêRİ?à]Ï°¯°ş~ÁŞøUi£¬mÖuK|He™G‘ÿ\0e©¯C«W[hÏÎ¸£ÄL«%¼\'.zŸË_ßĞùgàìkãŒÍĞµ“JÒXgí—(@aê£½}ğGö:ğÁ¨\"¸Ìjš¤j7ß\\íŸöG@+¼Oèğ)Xî•\"Œc\0aF+‰ñßíeáÿ\0#Ag#j7J8‘O¹¯ªÂå4©+=Oæ(ñK5Î%*qŸ³§ü±Óï}OP–îxÚF1Ç/,HUAõ¯=ñ·íc¢ù–Úzı²@xÿ\0«S^ã_ÚPñ”Û]¤(ÙÄ`íA\\ÇŒu	2ªÑÆ¾€s^¤z#ódÕš=3Å;Õ<QpÓ_Ş4‹¨£é\\Å×‹¬ìÙ‚Ê’pf¸›«ë‹ÒŞc»nûİ+•ø«ñgEø%àÛk^»ŠÖÚ 6®ÿ\0fì«êMTcgvE–çcñã–ŸğûÃ—š¶¡qŸ§Ù)2Í1Â¯·ÔúWşÎ³Åø-—ÄV·Ñ[PğÁ-2+PÕäŒ©ÔğyHúã°éŞ½ş	õÿ\0¸ñÏüwÇö¾)YßxSà¦™(›JÑ¥SÚùÎCƒïcœñŞ¿q>ü7Ğ~x3Oğç…´{=\'GÒâ[ÚÚÆ#$HÏøaÿ\0ğø{ûşÍ	àï†Úztzz¬Ó\\·Ïw¨2šI_«1ë ®9Ôãøzãµ}›±nüÅùW7¨5âß~âŞmcGlj|Ë˜S§»-KÊæ<h¶ßÃ¯µ~mÿ\0ÁÇ?\0×Æü3ãëxcûG…¯>És7ñ}nïá÷7íûJøOö`ø{u¯x³V‡M´¶Ë>îNÑÆ½Y ¯~6|\'ı¢ÿ\0à­¬r[Ëğ³á-­­şVëSQ÷dxø\'#‘ÆC¥]½öì~FøOÆÚ§µxo´›û>êÎøßnO¿­{ç†?à§3Ò ‰5=3R16yo\'Ôó^ñ—áÔß¾,ø“Â·yÓxwS¸ÓšLcÌ1HÉŸÇ®j•l%É9ÇSĞÁf˜¬\'ğ&×Ìú+ÇßğR_ø®ÚHlƒá]Ò¯ÑøW‚ë~*Ô<G©Íy{u-ÕÌÍ¹ä‘‹3ÏÅª£…£Oáˆc3\\^*Î¼Û±ú•uÿ\0»ğŸŠ¡‚øvëm×ï<ÁtÌÒg¹æº/†ÿ\0ğL_øGTò×A·‚HÎD—ne*GBñøÖ§ûDÜü&¹×®,-äâ2Ù1¡úòéE×í‚ºõó<mgåÉÛíHŒ+áåS(®FÚ?etr®n~H¦¼’=ÆzD¼›MºšÚ@iÜm<cå1ø‡AÓüDº›Z[Ü(óc´£LòHµÇ|aı¢ôx\"ÿ\0PµÕìõ-HÆÂYÄŒÎzg&¾uÑ\"øŸğ>Ù~.k¾¾m\'Ä›+{Ûôh¢–F†ÜòFÆ8®ÌW9sMİ>İ37â<=
§-{½£ò>Ë–EŒHÌÊ»NX“ÀZàá^|Lı·<S\'‚şè÷i¬|½O^˜­\"ÁQ&>½:Ö—üOø(×Æox7Ç‘ëX®–ÓÛI£È\"†É˜IöÁ5÷÷ìİã}{ş	Å©[ü1ø‘gk\'€ä˜Eá¯Y[ˆ `xXod$0ùÁ¯[/Ê}œ¹ª«Ÿ#qW·³Á{««ZßğnD~	ø×‡ü\\÷,XÜ™WnŸrØÿ\0Q·¨ûÄšù{ï|5ñÄŞø‘£Ïá?i­²K;…Ú— G£)¯è‹áoÂ¦ñ­´:¥Ä‹ı™\"¬ˆÉÖqÔì}k™ÿ\0‚‚Á/>ÿ\0ÁCş¦Ÿâ‹Oìßi±‘¤ëöŠóOaÓŸâ_PM{OnU±ñ~Ñß›wæ~&ü$ñ™ğwˆV7ÿ\0¦Úÿ\0ìÆ½ÙX:ãœŠùÇö–ı>\"ÿ\0Á;~\"Ÿ	|P´šëH¸¸hô[F~Ç©&~RßóÎLc “Î~µí_
õåñ¬.•Õš4òËg;ñÀ?W1™Òã\"™21ocŞİß?JÔğæ€ÚÍöæ‚>[Ş¨4å¿$Ü7ã[z|ş!ÒİeåeÆÒÍ‚?è bMŠ£bğ¼TZúTËpõ;/†_´&½¤Í¾½l·v°¶%O¯c^İá¯ØxšÉå±¸â }å>„v5òøqVô]~óÃW^~Ÿ4–òw)ßëSmn´–k¡ô/~øâ––°kštW*AT|m’?p{WËÿ\0¿a[Â¢{Ï³jÖ9\'Èn.#İš½³Â_´¥™ÓXø‹m—ÙP³Şû¢ d–ÃŠùŸá×ü¿Jø×ûwi?
¼%áõÔ¼7w4¶’kr\\íidDv/?.WkËÇet1+ßZ÷?EàÏ3®šxYŞšûXÛÊû3Í´ÿ\0)ø‘ã¤é:=Ô³(Û3I8qÔ–=}?ğ+ş	Û£øN+}CÅ’¦µ|¤7Ù”m·ˆû÷oÇŠúLÁ¹Ü‘ÇºNY—Œık–ñ—Æm/ÁêSÎû]Ğÿ\0–0Ÿæ{W>$¥KW­g‹<bÍónjts	omşó¥Òì-t3É‚í­#¨#¸ÿ\0|jÑt+i­ãjsr¦ÏÈ¹¯0ñ¯Æ=WÆlÑùkfÜyHßÌ÷®M!Té×Ö½¨Â+T~M:²›nMİõ¾¾·.x—Z>&fósˆA*¸ô¬UğÍ>hc€• cSÚ¹«õ2»kŞ1uZŞÀR%ÉÙ³\\†¡§6Ÿ#[Ì­º3‘ÿ\0JôyT«İqÅy—íGñ{Ã?¼7ˆ5Û¯&HT‹h2íû\"¯©¤#’øÍñ³AøàÛ­k\\¸òãÀœÍs\'dQÜ“^¡ÿ\0©ÿ\0‚Ex“öäñÕ‡Çš|¶>·aqá	M‘ç®r²Ì§øq1ÍZÿ\0‚Fÿ\0Á$õïÛÇÚíñêÅ¡ğü,·>ğ”Èv:çrM(nİ01Ïé_´6QÙD±[¢E
\0|¨£ø@íUÌ:6“‡tèìì¡†ÖÎÙDQAíHÔ\0q€*è¤#wó œÔ€^\'û`~Ù:GìÙ¤Xé6v7(øâLÛh²î5	Oñ·÷\"^¬çŒq]_ÇïŒ¯ğ»@†ßI³mkÅZ»›]\'LSµ®$şûvÆ½XúW-û8~Éqü,×îüiâ‹ÈüSñ+[LêZ»Ç„µSÏÙ­ÉHW§\\œdĞÄ¶¿ğL­||N·ø¥ñâ}7ÄŞ1Ô§Ót˜T/Ã`ŞLjIãŒ±î:V‡íûix#ö$ølÚ÷Š.¼¹™
XéÑç_8è¨;ÜôëğYø(÷€ÿ\0bOƒvòkW	yâi¦/¦é18ó®#áFrOjşnş*üGø»ÿ\07øëuª?Tñ&¤ìE½œlğiñg„^Ê©ëSÊhrß¶_ÅµøñûHx›Æ	§e/ˆ§[ák¿—½Aëœç5åõµñBÕ<)ãı\'ZHum&SewŸš\"ù
÷qÂ±kXìEÜÀzÒ˜ŠT~&‹ê¿ÿ\0kü`ÑäÓnE­ä%Éb9×™¤~jm?3uÏµS?v¯iŸñóÔ:Š8xA¥ÕXŒTëÏ³»>êÿ\0‚X~ËŞø“ûNxKÔô}?Q_3ûBõnSs<h¥°ûÅ+ö_öÍı|;û]~Ìº¿Ãû«xmbû9m2HãlgU>[(ìB=+ó?şÏÿ\0\'»áŸû\0^ÿ\08+öM?ÕŸ©ş•×§Oİ<¢S«„\"R|ÍËîOcò·şÉı|eğ¿ãßÅ«}Zµ½Ñ4[«Ì$W-¿=—û1®~ÇŞø›ğïPğÿ\0­-õË-bÅ»/È€÷í ö5ó¯üCşOóöŠÿ\0wMÿ\0Ñf¾äñğİ5Ëm«Üô9¤÷gç‡ƒµßŠßğG¶‡âÕ¾%~Í·:~³ÌºŸƒÀ?êæïƒïvÛï_y|2ø§áÿ\0^°ñ7…u+=sFÕ\"Úİ[¸xäSèGjƒâ÷ü’ÏØ:Oå_Á?äŠüEÿ\0±Âëùš@}ûA~Î¾ı¨şêñÖ‡k¯èz¢–	×æOö‘¿…‡b+ñ§ö¦ÿ\0‚{øÓş	Mâ	/tØuoü»¸/öÔS&¡á¼¸ûÑ›¿Æ¿r®ãÚ©®öœÿ\0“fñ—ı‚î?ô@şÿ\0„wÇš%¯£êQÓo#’Dà†üºbºëM6•a\\\'Q_,ÿ\0Á-¿ä™ø«şÃWú1«ëû©şè©æ1N t ôª¤ÒI¸”íõ>”óÖà“ıÃ@.ÿ\0ÁV><Â ıš§Óìnš-KÄÍö(Š¾gW?—~s~ÃŸ¡ı›ÿ\0jøÆãæµÒo?‘¨êQàšúwşƒÿ\0!Oÿ\0×™¯‚­>ıÄş…|1ûiÙşÒZ<—^Õ#“HŒ…v·“èOùÅFçÎ1-Ş¾yÿ\0‚gÉ£xoè}:Š D
r)KdÒ÷ u ‘)„y’íŞUHÏ éIü~ÿ\0Àh‚ı ~>ø{ösøuqâ^áŒ‚æK™;\"Z«ÿ\0Œÿ\0‚mkßğS/ŠVÿ\0´ÆËâø¦ÜgÂú€ˆ¯6œ¬Œ§ªuş#_ÿ\0Áp¿ä)àŸúã?óJşŒàŸŸòe¿ÿ\0ìmÿ\0¢Å\0z¾c“g¬0­¼ H£Q´\"\0°acÙüêÿ\0±ÿ\0×1V(¬p?Â±üeã?À>¼Õµ+Ÿ&ÖÅK¼„õô^Ø­‰Õ·Ò¼?ö÷ÿ\0’E£ØËaÿ\0£–€;¯†¾mjøK5‹_³ë„X·C—°·<¬~ÌFZóßø(/í¹¡şÂ¿\0õ_±»Ö®€´ÑtÈeÔnßˆãUêyçè+ÚÇüƒGÖ¿7¿à­ò’ÙcşÃW?ú!¨ó§ö€ÿ\0‚VşĞ·g4ˆŸuÅ ñv¢ZşÉÿ\0Õø{O ²àgïµvÔó_£_²?ìqàßØÇáµ—‡¼#§Ç*u|è>Ñ{&>fvëŒöí_S|{ÿ\0}¯á^kuş®?¡¨¹¡üÛÿ\0ÁRş7ÂßÛçâVšVEóõWÔ\0~¸¸Ë÷œ{WÏõõçüSşRaãŸúõÓ?ô‚
ùµÀKcr-/¡‘‘dHİ]”ÿ\0~5ûğ[â/ì#û@ü*Ğuïhğï‰Î;;û9Ä|ÈÔØAÏZüwOõ2}óÿÙ','1','test','2015-11-09 18:30:16');
INSERT INTO `usuarios` (`id`,`id_empresa`,`nick`,`pass`,`pin`,`nombre`,`apellido`,`direccion`,`email`,`celular`,`foto`,`estado`,`sesion`,`fecha_creacion`) VALUES
('3','','usuario','7c4a8d09ca3762af61e59520943dc26494f8941b','2233','Usuario','Default','Sin direccion','usuario@usuario.com','99228833','ÿØÿà\0JFIF\0\0H\0H\0\0ÿÛ\0C\0


ÿÛ\0C		ÿÀ\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0	ÿÄ\0J\0\0!1AQ\"aq2‘¡±#BÁÑğá3Rbñ$r%CS‚’¢²Â4c	Ò£òÿÄ\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\09\0\0!1\"A2Qaq‘¡ğ#B±ÁÑáñ3RbCr%ÿÚ\0\0\0?\0ùŞb9Nõçi&z˜ :jAÖ–ôÃZ0˜ëµ	ÏfÁ¶éÒ§@%N“³°FjNµfÉ5×Ê †Ñ¹\0™ùWn»#ŸÜŞiTÇ•w±ÍÚ³ wƒ>”!F^æÁé®•Íßg)\\ƒ¡Ûİ]¢[Ù²F£`*ìsi›J¶çéQº%:ÑÒLl\"¢»}›ÒL{«ºg_º7ë?{ÚoÔw1ıë™q6o¯=*HÁ¯˜åRõ´u£jQÛ®ºŠwÔèÁ[ƒ­I(w#Ü(R&ÓFÁ ìG=(‰¶Ù¤™ƒ¾µ&(™R€’`rš€“äû–‘+yBr1™şyšê;ßcÆí›·i!¶TûÅeJ‘óĞyîjiµéÑf*0}‚ŞÌãÒJù‚DÇéşõú:¶ÙİŞ›Fšu÷ÛÙğµø®ˆêHóVV)ÕöUy¢İJ@gïÙ-ÚukŞOéR°N[d¼¸ã\\6½ÅB2.ÙÆÿ\0Ì¥$…zj4õ«1ÃVSËr†–¹.Qs@v%3ä:ZúQWm¾C‚ßx|9Æ_Ì`ùRÿ\0c•û˜ê‹
	‚â‡´‡ŒwJ”£İæ÷»³‰3jWŞ”Ú¢”’°¿æ|è\\-ôD&š»H&ŒU‹„¤\0ÙLw\0VXÓåëJùü––kÙÓÎ*Ä!O ©•È>m#i©RÄ×C–OgıĞúH(õğ™ªSÚ´Ì*·3SÙÉµfæÖfº¨äÜ¶¥YN†cJŠ:-«FN¼ÇÂ¥zw’§*î)¤¥³™ó™¢Oğvÿ\0ÁÖhYÛ]3y¤¹ë’¢W¦53tíSZ&«ø5˜§]ëª»#•Ì#ûW\"\"ôarwÓÖ¹­’úÑ¢¡ç1î®%¾+F”¸Ò}õ>ä~æIÜ½wH×fŠ¤ïëEìu\'îh™×Bèµ´flÚo]Ó;Ò4IÉ5ÚÚÕtO*\"?,Ñ3¦}jR²T•³&Lûëš¤{£‚`Ï?*`}ÍRK%%[5<üêU€ån‘£ ùW{ì+K fh:O•X¢²•jÎ‚´ÓzU%¤wš4ÜWv6¤Šƒ¹.Ù€ë©J‚5[:Ì=õÎ½‚Nº:˜§AÎ4¶or Hô©uìr^Öl,åı*Dé-I*™Ó×j†LkÛÜêIç·•Jjº;ßF¦»ug5­èÌÚèk›öuÿ\0fç¨a]»£¬ÀJÜ–Òé›‘ÌiÏJ”›è””©³ tûª;L7¯ÁĞQczBâä$Æ‡Z(ĞR’ZG@ÈcNt/ğOI#dêu„ÿ\0:
>ø¨Hµ~Æh5&wL^¤•I1Ğ©{a*â:¶*iIRSøŠåçA®¨8¥uakG[µaIJÆw5yõ_åNµ×L°¢º÷ãœDÓv«h\0•-Sh\0óõ¦F.ei¸ÅïdfŞıÕ¼¡	ñe\"GÃZ®+EKr{t…/1«Ç§4û-´ 6:Ó±ÆSìéW‡ÜWn§Ö§P3,3â	òjÂŒbg©É¾ôp¸••¸§ ìW:Ç™®¥Z@§{º4İÇâæ *†>•) á>M«¡g17Ôée¼>4®âªÎsI¦e
Ì°¥/˜ÿ\0*\'Ò
0òf—¨–âN°ÕöL¡¸½²ÿ\0vâÔN¹NR#Î¡¯¹0~ŞÁ†±A™!Å[Ü”$úÅ%¥zEˆ¹$’dƒgU“xN²JB^h9Ş¥JøJAHæ ªŠã?K@ò’|6Ø“O¤%Jîæ…iüôªRÅ(ºö.Fq•[%QÖĞÒšØê´s9yêëQ@şvfm÷ÄJÓ36ÿ\0J’SIlß]Şá9.Ñ¢¯p<¦‹Ø…;í´šˆ¿j³&	9Tª!­ìÉTƒ•v‰vyï¤üh“t_csît!)î‘„éÈú×/Á-tÙÊ£M‡•MÛ³›lÁ¡ƒQ±mof³©“S°“f)Y‡~U:¢=UF‡8ßáSÅösoÜÉÎÕÖ™/{$<Ù÷ö‡‹;‡°«ŒVèXNˆê;Tü/‹Ë*¾¾ïø<?”ÚÅÒ÷º_Ôº¬~Á}«İÛ¥Çp»K`u)]Ä‘ë²ŸÆ°¯§Ÿğ5ÂwêÍÿ\0üÄşÃ=¢ávıëY¬È…ª~”µñÌ^ğirú2&cîÑÜ·/3…¶ò@Ôw°~”KãŞ+{¿äÿ\0u%üJëŒ;.â*8Öub€c½SrÜôÌ+SÇóü-Ö9«3|†ù^:õÇ_uÑQ×–¦kKM™Oìs3Î:W~ç&şà°¨ò«WåHÀ`ïë]VM¤w\'™Ó©¡¤·îlN‡qPqíJˆ×”í5ÔU»:Fóå5öön@U.=HIÛÊ¸QuFÁæF“PıÖ¥PHkN¤âuœÄ‘\\D¯³c‘™Ÿ•@^İš@Ò\0ë\\ékG`ó|ùÔ{Q-/cs¡×_…r²?‰°¨I1]îB»:’wİQc7}Lÿ\0Jêûnôt’cË¥G°Iïtt úzÿ\0?‚‡÷	´İ³£\"s;—Å
”@šPôrŒ¦ı$ó„»â4m+ÂìMÁV°©o}ffø†¤Í\\?Ë‘rMø‹°N$ál9WØ£MZ°“ã.«T’tLr\'¦ôœÃ–|`ZœW)4Fî0Wlœ,¤¼Dì1ı½jÔ2§·Ğ2ÅÇPD{¾jÑ+m.H\0€˜ççÒ¯ã‹™™™Âı•;ß¬T2îr\'Ê´TTLÉ7=³?©‹dÂ¼	Ú\'bzÑ¨7!2ÊÒ®‚¶å¹t²’×ÜØ+}S9ˆ¯¼ı*Üa-ıŒédUÑ}KB3ø–g(\'çûP¸¢`Õ_@ç.IN\\Ä¬rÖ¦1÷M=œ¼ú[Ö!\\ŒÄ
dS’$ô¨Ó%i\'¯:‰FÑÒí±âZdw`$ìyzÒx¦¬±Éô‡ÖxeÅÎB\0ÈA—0Ö¢½ú;ŸÛd–Ç†lAríÂP•xÖ­t>|ştôø«b^GĞ¼±SŠjÖÙ¾ì*BÒ€	÷îh¥.Ş†~`K·Ë®3;€ªêOØ…’Iiœ–ê€S¹º½•Y\\•Hkqyo=ÍÁ’
¤+İHpŒ»Cşd¢©²FÚ_îŞ¡0‹A|¦³šIè½ÔS};qK%7fƒ**³›İÙ³ZïsŸfŒÆ¤ò®ü²=^ÎÌ“§>Z×uĞIËª30„bºß¹7÷5ìëĞÔ¶Ólç4¨=f9E_DÅÚ¨›Ëh)Ëg%ÅY£Rˆmµ³µÒ¥·vĞ]i DÔ&Á”h’=+¬™:™®Z@Ö¥»d(êÍ%Ru“å:šo b«ê3}tŠëöı\'¨şÄ}¹`–qİ–<´Z1x´©7ŠÊOJñßğóK$<œk—×¿îzÏ…åÇ—¼I5ö¯GÔí·ƒ8‚ÑµÚb–WIRA·RgçT!ñOk&ŸåQ››àt_(«_±^)á»–d›uûÅLüÿ\0K´NÏ„«hŒ;áK ·lĞ9‚¡úšÏ^w‹‘®şçOvÏ5ı¯»fàCÀ¸…‘¾²»»y¢†¬ÙPRÊ¹h6õ¨Áw•	`—n©#Oı	ş¥÷ù>b®
°zWÔiŸ=šäÛöQ0jS­Š{üóH;Õº+ßgS¥G¹>Ú7¼ONu:¶İ!PF³êimXIrı*%ºÑ°f\'}µ¨¢M“¶®ìŠFfë]Vs~çA@ì&¹ ¿4`QšÔ2­g”ı*(ë´fmŒIúW´a{Xy×qÕ„›é#Fäæ\'o:>Ø½Ñ£u¦úÔpUdsg&õ@u¢ù`|Éûûë„
—vKœ»:ûÛ¤ı(x.Âyvt.]u´©ãÑ	ËÜì\\;¿9i|PŞR­˜—Ü	Qé¨u.1z;”âÇq.‚FÇ¦‡Ê—“KCpæ©lôÏcÿ\0h|3„pjî–î×#¿ f	NS¸=à’Exß;á¹²NàíÃÄópË,g;uá«›v±*Ñûæ-Ò–ÿ\0Œ6ëƒÙd(€˜’³+RàVbğóã|Rjÿ\0ß÷Ù}ùXİÓşÿ\0¿äyûµÓ°Ìağ¬5…Û¥¤‚I-cIÿ\0§˜êI$ê+Óx>à¿Ì1¼¿2kE%Œ_´ó”$¡¤éÊ”t$“ÏRkÔbƒG“ò2ÿ\0ø‚}DNŠĞŠ³ì¦òÒÛØã%ÛÔë¢R§5<€\'ô§Æ-~åYO“©h7dçw‡qŒªSmˆPñÄ“ô¢·BëÙ‘°§.”Û-!Nº·JS©Rß¥
Níœé#bß)Nh	Ï’@ŸSS¦ÉV•!Ğ€ÊNR¥3¬L	øSoÓö–’‚\'8:*\'T+òH°¶›½eâ`¤fŸ*©N2e¿˜¥Ù!°oïî‡´Û±Û`ÚNª=uĞu$š5osëQâ¸Ê±­}İ›ÒçÚ:üùG‘5*6­€š^À\'î‰K@6e\\¼ÏZ5ù!É6szRæÚM£©¯¤è !jk$Íu¾èul]i]áÊâƒ—SëåJšOÒ˜èÎKrÙ)Â1¡	Œ¡µœ)2…úÊ‚ªË–¤hC7R‹Ş[÷- ¥*Ù*Ü«<R†ı‹XòÆ}= ë¡ç¥+Øéz0ôåÖ¥}‰ií£DÇ‘ÉWd·÷1*g]è”P)ê“³`ñQÄ(ıf:r‡Ö½Iõƒ¬Tíèå\\›0,É5:ªí™œf‡‹ö
MGê0ªzÈš‚¤ıÑ¬úši54’³“K¿sœæ ı+¸§ì)Ê™}MO™Éš.¤˜=\"¦q]œ—wPZš¯È2‘¾ı)˜PšìJ#»LzæÁDÛŞ:Â‡ş…?CH—ŸTSşœ~nlZ†F¿ˆKÿ\0î7!%	Ç±\0 ]/oW_ñ^şT’,¯Œù‹Òò¿æ1‹q’C¸­Òúæ}F~tØøxbõ$ø—‘.ò?ærû¼9”îlßæ3V£ŠµTQg7ÊNÄşğ…‹÷¥ö4n‘ª…C‹Lg4»\"­âÄ:Ö«ÂcÇ4«B£HĞO*“\'ÑË=h]¼I+Yå3KxÚÉ{Øõ‡\0 šO,)Ø¢\\‰€:ĞPÄÑ°d¢yï}z£yhÖv®¯±Ûèë8Ik¶ÕÓKlÒt*6C|tÍ\0])”Û1N¤y{êY
qº³eÔ…t¨¦Õ¥¾Ì/%P&»‹]å{3:æ*êmíÉ\'³D£‘¨§ö\"ãÚ9ï¶o…O¶-Í\'¡D:€#J†Ÿ¸Èµü¾òÜû@G*æ¬íw…A\"k¸³›]3¤<…ä\0ZØIÇÜYË–›!² Tˆï”ĞÆ2{Übé™ipĞ}\"A•@Ì4gÒ‹Œ˜<Òèzn“mn\\JÂ;ÄäI#Pˆ×ãµri­†²Ë´3zùQøjÊ“âğé¦À|#ç\\ãÉí²¾62öıkQ“›Ã¹4ìxè«<¬ãë x³×ÈÕ¾(Íy$Ğƒª:«˜#ßMQ®ÅÉêÇøS >¸‰û±D”š:låO°­çŞœ¿mÂ¬÷¶¹³n Aƒóø×4ıÈ]ğÛ…á×m>4Z3ÉQ¸şs®Nÿ\0b“L³a†÷!P*Qæ­${OìØ/BB›Ë)fHH:™ĞŸ‰¢ì[ü	w%–­Ò
‡+ËäIH?#QtÉü{»V¬pÖ.P%o¸Ò“ Ç¦”/c×cg1pÛ+–XP(YÌj¤$ñƒî¡Qäì†ë@K…÷m!‘0<JùíFâĞ*Uª7+3€c)Şºˆ]Ñ»—»‘”ûgxåP£d»Zcd¸•ÉJWš\"fšì‡%[Ø™P—¨†ß¯§I¤µlb¹tI8eğÕúR¤)Ô+üV[P%Cª|ÇóJUn™fçVsië\'­ŸHq¶vp{K1¹×IŞvòÒºQûõö9I.ˆ•Ã—V·jHs;[¤­R;L¡‡cÉ>Ø³¸£½Ğñ¸JDq«ÙbY%^‘%ãÎ4€T2¤™’)±ÃìŠŸ©KLlx #QéLı6Åş¥½.?â’	g¥OéBıWØäñ9Ë¹ë\\¼PW“$¬àñB‰ÒOÎ§ôˆéy-ÑÉâgòcÎ‹ô¨[òeì&®$p§I&xÈ‡äI­šÿ\0ˆÜ\"<[r®~4lŸŸ*£“Ä.k2<ªLy¤rxÜ ëñ©^:½³Ë£…ãÏD=óR¼xód´kúëÑ#Ö§ôñ%f“ìäã¯ê\'NU?\"=’óNû5ıeóæ»äÄ•÷f+~HEOÉˆ?6UÙÉÆí]òcîJœ½™ÏõWùj~L}Îù²³C~ˆùQ|¨ÊAœ=çk11§=*¼±®‚„åT7º¼q—\0êk£‹ÙŒ–Gu`v‘ êb­7²¯±¢LÇ bktÅ[Y
}Ô-Ó	±r@~5VQ§Oc¦îIq,FZ»Ğº$Ş¡É·M³´ºwúTPË~ìéÅ|t¨I{Û@Û«²…Î#J³^ÊsšOLf1ëğÿ\0•$‘ÂñzïÊj~\\NæßªÍ®ùĞãB„Aç*£–ïß$s©xâJ”›1ÌAĞdé:iR±®ˆmµ{;Mó¹&gËûĞ¼q²c–]ÙÀ¿w>ª‘¾”Ohï™.Û;Î)cÅë4)Q+#îöa½t•J„}Îù’¾ÅUzòÒ•…Lèh\"´Îsm[¶½q2yå™ëC,kØdrK¶&íÃè*œÚyÑ(Åì‰NVé°÷ÔAÌ¢a& nf5úP8Åv‚„¥÷±ÕÍñÏ1z¦ÑIálzœbc÷jï¥H1ò¡Q­!-®HfñÌ„™ÓcÎ›V–N[ˆİ¨ïS#C¡§-÷z5‰6YSjO²´f0yó(¦­ö›¤‘Ú–[iÄsWAwêhkV‡¬«mÜÙlÍ«ò‰İ$ô®M$u³/-À|„
ÉRFÄi=*\"ı™ÔşâêÎîİ²—ãeJR	ÖAÜ|¦¥ÒgS­®/Z6±*C;%_È5)ßH6¶Æ¹V…6HÌ” ¥3>­Bml†š¹xãç*‰ËBOX€~töV\"¤,Ù
Ì÷…1;iıë¯TGVØÅÕ)Jñ‚OJ$)¯s¸û»)J%/f’¡ÈJ—±/ sé%í|GMŒÍz:KîÇÖí¡JÁ\"f:ùPÚÛCÖqNåÌ¬­HXÿ\0¼IŒ£Ê6õ4¶œ–ĞQihxŒQ*|8.Š^IÌ•/qÁŠD¢ØüsŠíÿ\03¥âÕ:âOâ¨’= u‡z8¤×tşğbòne †É04ğÿ\0oçZT•l(>K‹g°»uÀ”)BAR¡äj9)!¼g	\\Z.å²•ºŒ¤óO:˜ÍAé<sÛÜY¹j¢‚?0_ŒÔÖŠŒ éˆ@\0=)€™ğ2Mq{4„ò÷T‘¥³gAPBü˜5ÓA?®—Fj6ÔTïhÒµå¥r9o³q¤ŠêèäïÒ¤ê£y²ìjÉÓ5¡Üzë\\v»7 ‚N¾µÇU9@0EGlí=£J“¼ªQ:ö3L¼…qfö®;Im’Œ)¹b@k\"©äm%Ld*ºß¦ğïï©ƒµ°ä¿üAÍ¤åŞÅ%÷9’ÈÔŞª… íœª×cÖA„Œ¿*¼‚ÙuÔH4–Y¸§¡ÂI6òó¥ªìY²Jz†‰OÜÚ‰(ØëQD¶œU‚/ºG¸Õ¼e<²·UC$FbÓ¯J²Êëg§ÅûªWÜêû-J(ÜušŠ%ÉµLå²g¤í\\Ğ+­œºu:ü(‘/b©„A°¶•û	ˆÍûÑ\0.ÒI;Ç-($ÂŠf¿7r9ö*Ò’Ÿ
“(:úû¿Z†›Vƒ‹ÕX£÷,$Ÿ\'04	òtñü‹2Ğy¢“\0/VÔLÁjæš`ª{‘¶{Æ3¶Rs($“÷:/ˆ±BïVUkH<è-t>1¿Vì^áÌì¶äj¥B¹IŠ„¶ÎrmvpĞÌƒŸ‘şGÊŠ“ _¡2ÄÉm“×û×Z
’¦*Ó?y¶îdœÈ\'‘æ=õ.j=ŠäíÑl²¬‘”¡
O¥1RÛ:¤ŞÂ6é[yÚy\0¥z…§Ùş4¥¶–Ã‚ß.ãE¤-;~`w5èGí½-ÎºñûÕPÇüº\\B‚‚N’ ù¥UÊ~ïbx:z³”¶do»\'ÚlªROPyÿ\07¢r÷÷:8ÛïFØ±iÉH\'b#B—ÜwË^ÃGí‚¤£Ç—Dú
©Ñ.ĞŸİV”BùF€Š;ùo¯q70õ˜R“â™:m­rzÓÑ.UOG´RV¢Á”SEi;9Å®ĞÑXj”{Ø]<©Šf/‹÷8y**)æå1k°$¯G#»B4IPIˆ\'æh÷Û%¥ş‘İ»ÖÎ\0—ZBNùÒ5ú[äŒQö:vÉË5¥I=ë.C‰ˆ†9Ôê{:QqØÄ)iqi\0ÉÙ\'Jš±iÓ5|ê%µø“:¥fş†—,k´Zy­QßßŠP:xÁøMÊ±’ÉHIÀ_J¡9j7+ÒÅòrúW,Ô\0I€\\ƒ²œşèjwÖ44ĞnıÌç#M6ë\\vú4­Aûë‘ÆõÁ s¸í™2ê*:;}£äT‘^æD#mëƒz5¿-:ÍpKLÀaRŸ:ã½¶iFÚ¤äÄÇ/uAÖlHßãÚ9í¼Šã•‘®‚9ïRMÑÓ`…¹¨d[dÃkşWC26¬ÙËeÜKU@ŒA?ó \'·°Z¤ÆÜªË¶p /R¥IÈXH€htwcÖ“¢LzùUvÆÅı‡Mï:G¥)J˜á\0Jõ~ªD5÷TM]#¥	Ò…N´½‰ä=ÕsG%]1¨Ê	ÔĞSöÊúBN	=	ùQ&wàÇD€\'aÈk\\ârĞw©lŠµHÓ¦Lzû«‘Ú¡pÜi¥¸Q\\´\"Ï\'YÖØĞºë:õ‰¥°ÓjıcRºéT‹]Š§pŞ]hä(ß*Båäìè%³¡ê<Å‹ív3”v¤Ãğg‡ÏªõCË#ÔC,‘˜Üxg\'ihyı5-ë›¿:ë—ÂŸ9ª+l¿	/v$0×U@Ìø€¹M=ñµØÜ[€TÒÓøj:ÑzSTŸbeÕÛ4°”).ƒá)}ÛÏÊ’í€àı‡HaO”¥iRHÙĞ‰Iõèh´wË}V‡vØCäf)N^¦DŠ	Jû°S¤ÉÁîbƒ(a9€ø*cÔşô=jËÑñŸQ]…À·­;Ü!¤¬ƒÔ.|ô¿œ¥ØßÒÍn¿ áºRû‚Â„¦aÄ‰è	P©ĞåãI--ì»)º}ELœÒ$åTG»rÌ‰ı›Øvy‰ :–d\'Ÿúu×Ì|©oÉŠt?ÿ\0‹“^‘KÀ±İ¤¡.6á€
r¡\\‚‚\']ºhGêqöCøtÒ´†ö!Œ4·ql{¦È
Êôå¶¿J•äF[@/\'L*;ïõ	Â SÔ„õÛcÌÂß”“¡«áK¯æ?sìåˆ­N¶†§RœĞ˜ä|ÁèEJó—µ/…d[‹ÄMÒUºÒ¤‘®X1®mùÇÒš¼˜Ël©/†J=¡1Ømşƒ=q“8I9‘dH§ÆçÆé‹—Ãg\\¢VxÇİØ¥9ÚVuÇN@OÂ­cÍ	i3+/‰8œ=ldmVy$ÊiõJµFÆv®ìåVôÃŸSÖê·¨°¢Q;+`G)õ¥981ñŒ§+¡–-lí¥êó ÷©\\ÉN_0c§^öÄñö:ÌÎ\"‚Û€Â„WIÉR¢\\ZÓ?jå»¥.xĞf™úu©×°¿UşÛqÆLƒ)ÄLŠSI\\—F®Âh&w9}ıjbÚdJš©¢ŸMjİ•dh·>Öµ)’’öf)¸~\"¡3ª¶h§~|öÚºÈ«1MI˜®³ª‘°Ÿ®gkÜÑOO®Lš6Q06é5É‚‘ÎY‘¯­I>û1IÓS5ËğuWFÂtŞ=Õ¶Í©Lê7+“d^§:‘kÜÖŞqÍYÛ)Ìê5u¨oDÓ²i†¶>åÏjË“·²ö8>;ŞÉ»P‘S¡ôƒ6Û 2£iúUÇ¦T8Í&\"c}h¨îZ*ös>ÄËòb\"‘-Œ€á¾ƒ•&I®Ëjô9G\"~¡^íŠ¦æhXÅ½›^‚¡z°Eä•(ÈÓZ¹¨¥•Åµcd	*:oÖšÄ¦ÛĞ‘ÕfG¾ØÙh4š”u³–¶1¯¥KtræªHŞ¹8„÷:A İŒN-q1šLoD&…Ú$B…„»0Î}t;Årè\'hyoh»• h9ê`9éæišˆÜiÉ×D“²G|M»(}à?ÅXğª òó?
©<’JßF2u_ä’Za@%K}Âê\0PïÕ¡Qò…Q–N[şÿ\0‰¥{Œ±‚ZËn;Å¢“°÷ÔGrØÌ‰F4˜áõ ’íÈJ!¬ûêì}]#.Koø¥¼¤¥)Z•:d«Êš’‰YÉËK_Ô‘pÏ_ñÂÛ9Ğ|9ˆÒ<Ï:N\\±Æ­—pø™2ÉkE¹Ãİ‰İ4ÒU²r’¥{^ƒ¥fKË‹wfî?‡5Ñ&Ã»&uK-Û½®t³°ä«é@ü‹‰jƒ¢OcØGŞ*[Ã7$÷ayÎ—ú•î[^íü²:Í„Œ÷»¶„˜>¤UigoK¢Ü0E-¤KpË­.P‡·f^%G€ô¤¼Ïı%¸ãº\'XwfXSQjÚ9KC)?¨ù’#‚ûî¸\"ŞÙ#%›n¤ó}jFÖİ‡i»gMp5˜‡;´„¬fZ\"SëIm­¶YPMh-ÿ\0Ú¾‚CåXñJc0Ûù1®xùi [½—áå±İ¶”¾ÿ\0M~&ºY@|©!ºp¹8¶Ì¤xV¤Ò~´‡;-(jÚç‡lqËŒ A4B§Ö¡d”7aN	ûœs…P›WQ“½h˜:˜«QÏù(KÇ¶U¼KÙ½…ëI† &@¨çWqæiÚeL˜#/DŠK‹{Z­ì°D*Ë´#JÕÃåBZ‘æü¯†$ùAğ…Ş
òâJHäy‰úÖ”f¥ûw.+„€vŠBR»…;À>´Æ­#Q×AìQƒwdÖªSŒ£ğÌ@ZgòŸ^Cåµ+•{–8¿b;÷\'H[Í…¬%BT:ÕˆÉ5EiÁ§¦Ç@8ê\"å%IX-GÅDH4|xì&× õ©`\0…£PT Áê).»
7Ócu2
•$êDjZIìéGŞk!*Ó e;ìªÎfš¡çDEQÂtk\\E»£5“Ìo½N‰èÙiµÖs³A:ÈQ‰¨²T¯Vn À™®%¦j\0‘RˆÙ®d<«Iˆ#ë]d>û3uçë]ìu1¬iQÙßƒA2­dTïTh	Ìs®:¨Rİ2ú`Huè4“udîÅ‡Ï*É“IšpN»#—Fn•¥Yãegõì4I
×z¸VöIÔˆÎ±P”i}©>ÇííåHl8şˆHèi/cáºC„ôĞ*PtŸ°¨˜Ûj‡$‘FRzT šMv¼ŒÊ=jî>ŒüœlnƒÌ$FÔ×ö°SÀAdç ¨×@$cÚr × ¤•ëFš=<ªdm	­$¸Ì$ôM7±Ğ0Äå÷ÒûdÆ«c}00UÓ¤‚ÿ\0I¥{Œ«¡FPàĞ’L	¨n•‚¢õh5…Ø›¥¶-GóyzU<²à¹ğC›áO…°]RYmA–Tr—	9äòŸ-ömÂ	zV¨3v«a`–\\,D4¤ø{â’u) Q“zC¹F*»\0b£»QHCIN)ÓáEú„O\"®@60·oœ+9PÆùœÚ<´Ö¯òPFg	d•ô‹s³nÅ_âVÅë©R,\0~#Æzé	òük\'Êóc‹Óïö=ğ¹y©tz›‡û\"´ÂpÆƒ@$d	:i]?s¼W”Ÿ•“$¶ÏeñH6Ï	Ú1ãS()ßTÈq›AüµìÃ0ÖÒ[®˜”å+Û%ÁEt¶ÀĞá	pgPÔHÌ¯uÌVD`ßA¶0ä4 BGIT¾iô5cû0Ëd¡”i;Ps°¸¥ØQ‘%
:&¢ï¡Š?şC§÷™Ft‰s¨“½à’¶V‘`ç…²R­†šÑ¦úØq†Û-Ò§¥eĞ\0G?SQ%nÙ
Ij‡w¸–dn­7÷ûê-×dÇ‹`u°ZHR¤“º&Sîµ&¶ÇñRĞ&îÕ§ZÛB@$Îş´?7ğwËiÒ`W˜ZÁ¸t©ROH—H‰âØLœá¿	@jÌ2Ò+dÃ.È¾!c™JJ›ĞëQĞŠ·{¢‹Œdº*îĞxÏ¶vBœ¡;Ië<¹UÜ>KÆÌŸ\'Â†UhóovUw‚;´—Z‰Ì‘ë[xsÆ}KÈğšzDÖùxx[\'TªS¡‘×PtıjãJJÌ¨^8¶>k8s¢òÔ…çNWZq#*äGĞÒÕÄ7-öbïmŞc-’V‡V¯ğì¤ó)=g–ÚÓ¹¾¤Tpİ¡½ÛÌ]Û\'ğ7HNUÂ`(ÿ\0?JëLj‡%k@¤¨´¤•	×]+»è.·ìßVBJÓË¥[Ç+EyÆ¡¸I)‡Mu¦X“PTw“Ò¸ã
>ºWY=›Õ “¹ª	«0#M	ÊF»TßÜîŒ2 ‰å\\‰ßišÒ	go*‚6@ÌcmwGw³2’	ùTY
Ñ³¸Ò¸$h\0cJ—¢zTdF¤ïPq¨Öm¥Mè{0Ëdhf)súY1ÕûTäÃyò¬‡ê‘³E/üÒõ«°úJSôË@a¢¥\\÷*EZìäšøÑ‘Úup…±Á „útªìbV<hè>±UäY‚\'Tƒ\"€jn…‚6“AuĞÕöÎ]”¶u®[&Z@{Â$$Nõztİ»hA0PaZíoL„õKCb™ç¼Ó}„›vGM\'Ö¹_¹5ö1¡$ært&c6üè‘Õü*J‹ IƒÖ”ªÂöº:lÒ™±t;a ‰*Ö6¥Iı‡F.›c‹tBĞ”¤ªy4¥7}QZ_Ô<,§¹Ü6 ¨lTwÎ•JjÙ¥…|·Ğó
W~ôºB™lK‰Í	ùf—(ÖĞõ7îE÷Ş[ıiÑ.-_†Ø\0ÏAÊ<ªÅZì)99Òÿ\0Ğ?e«r“!×—ªA u®…½tDÚ»ıË/²NËãkötÙM¢™R™ï#ÏhşõŸæy‘ğá®Ù«ğßõ“¹tbà<=m†Û3lËa,„j\0¼4²Ë,ù>Ï¡(F
£ª$¼\\XG°˜ğ§6Ôq‹÷ÑûE>âR	u=~i?¹…¾ƒv˜CL¡9Òg‘ÔW9j¾ç(K¤·µ)Z²ÆP6#zíàù»U+1	\0D@å\\“íJ49·J’í2\0@£{VÆVìjÀKhP?ŒL“S¤×g6í¯aû	JÔñHÀ”Ô¸/©òkˆE¦Râlº©ÉR*I&;Ø\')¢rõ®bç±+¶ƒ¢QBgA›˜åKœyi:µõŸÊ¤¡p£¤/@)¿±q\'VÁ—l `LŠ	~v95ì½c\"@JI3¢Ç:L¶>*ß\"?zJÂÒ P­ôÒ¢şå1b¸v|ËLIĞ¤ó«˜òî™››î(„â6aEÌÉñ\\ŒUø=hÉÉ%Ä˜¾&ÉR›
Â‘ÔEZÇ’Pz(åÁ©Ú<ûÚ7e)`=sf…²¤„Ÿ:İÃär<——àÓßòÿ\0ÉN:·p‡”Ó­œš‚…\'JÒKš<ì¹`ú1ÖpÛí«;gb“üÚ…]Ó	Ó\\—Ct\\B2H3Z\'!dIö(íÛ+µÈ„eYĞ(l(T$¥mY#ÅÒßàlò{äJ„¸‘¤é‰ñz+šÚä:2µÒ­•TL&AÔÏ¥q)ñ_k6¥HQ@´ª\0IÔù©:¹vh$ƒ#Ê¥…{ö0k$ÎÕÀşæ³)>›WRg~LI\'LÇZ“—äÚ`NºƒµA:ö5ú×ƒ§bjh€\'P}&„îÍ(òU?¹lq`’«Är×j^F”XÈ´å²ÂleÂõ;òş½›‰.<‘¸ñ\\¹åÒ¯*âPš|­‚¡ÕÊÙM¦½$é;|¨™	&(\\tÛJŠÑOa„€45QºØè¤Øí­·ÛM),z’’Ğå±°4¶şÅˆ­U‹%#]~4’’}3—Ç‡xô©äéÆ×°é>\"wƒW`ôP”R ha>zÓX4ÆåRç˜¦{´íºddôŠ”F¶Îš¶ØÔ2#ö2\\Ò‰tGàr`2$÷ò¥§²zT!ù†´Â5t9hhræyÒ›ûŒŠ§¡å‘ÊòÍ
˜Lt©õC!—&<//»CcuUÌü~41Û/s~Á2a–”…«r¯d´<mÛ²T¢µØJöíÖ¶Ş%$ÆYâå]\0CJ«ÒĞÅ;[ğg?Äx“]èRÂÔ3¬ƒĞ{©y¦°Ã‘oÆÀóäP]×ìã…í¸gh!°Û‹L@Ò¾}åf–y»>¡âàX1qK¢lA\0w¢i*1CÛ½ìm‹ê!	TíıôH\\xÓaëFÂ@Ê2˜Ÿ­v;Š{­ÚZ@$>±ñ¢M=ÙÕl\'lÍ…í)”Ú\"¸ºbê¦Â24hj]¥ÆˆÓ•§Am€„§Odì@¦qkBœÒ}-ĞÕ»©NUÈĞ¥@¢\\yQ7)+l.Ê3¶V„„ˆœ¦M7±ôºc»y(I(2µÔ&UzbÎ­ª2É‰VÓQ\'ø“jÆl4‚¢ 2+)°#Ò†)?QbM¥Oc7Û!·PK‹ë¨š®í*´Á.Ø(¡IJ‹„<€ò¤,v©l²¦®Ş×¬ª…!J;fOå¥Öè±•´è	ˆaÅKÌ;½Äë#˜¢J¾¡±Ê¥¯p5Ûk))s*’v;T5÷d¾=¢+á+u
RD8‘§XÅ•ÃE<ø”şÈV$ÉC.L‘âVœ\\g´cd„¡&Ú#8«ÛwI1*¿Ÿ•698=ù°üÅÊ´Q}¤ö~‡­^¹·c+S¦€úyúVæöyŸ\'ÂI}%*Ás½q+)JL¥iqyœÆµ·r<Tá>\\¶EØÌ€&zëJäâöKŠÈ$–@9†`	56˜2‹ØŸŞT$@O ?Z.ó’ëÀA-!å®úF‰·
qOÔu÷Á’=+¾h+ŞÎ†’gŸ•GÍ±§Le9ŠšCÅöKf\'ãKùÍ±Eõ£¿é-ƒú!¯VÑÌÇZ#—:#R`y×~¢AGÇ^âöœ4İÓÉlj¥¥KÊpV<U\'_ì½àfí­ó\0ïUaçÊLµ“À­±ªxE§ÒéMıdŸÑÅûŒÜáÖÛ9T5tõå7±?¦¦í‰ÿ\0@ju×Êb§õ2#ôÈVÏm»„åÌÚØKÇõh•\\5ÜáĞ`@ÒªFI¾H½ÇTCHUÂç]b¯\'é(É.m&\0
ğ€uõ­(´×feGCuÌ·B­ŸÏ:{A;tåO cª“vXÆšØí©õŠK¾§hrƒM9s¥º,E*Nƒ_¥-¿IÅÂa#J(ŠÉí`[£*Ø¦¯CH£“oCrsâÛ}(ÅíôÆÀøÌG¥;ØR·#‡	*3z$Gob¬ŞƒSA.Âãb@ÃOtmE`ôètáR™€4éék±ê˜Øè¡Ì¦˜+¾Çm¬À$ÖzRš¤ÖÇ¶iKùÊND¡\'Us>´™ë²Æ9\'&Ò;¶üU†’¬Ò©Ö ~ê†½Ù/Z½ğ§­Ğë<¥©”¤ğˆ„Ï!§ÏÊ¹Òïù	nªûíâŒHZ»´Ç2N¿ò¤o«-òW^Ç¢{á¯º¾Ë¯©>Œ©	” ô÷zó¯9ñ,¯éGµø6õK¶_–·E+B»´€JÏ8Ú¼²TÏo)¨ªAÌ1¥<à’¥!¥jIòåSûŠ[ì“Ûç+`”ew:tšİŞØZÑ°ëœŒr4øã]…ÏŠ¦a˜XÌ‰3¢HŸuqÖäBw»	w)ÈØ$‰	)Õî–ˆRû±XĞ&R^\'Ù;“Ò¢—Ü7vî‡í6İ¢
]ÌUTIOZdc*bÍ®\"¨Y•,7¸Óa#­3~Ã*õcËg{´6Træ1A3çR-û‹œm´¿äz;å:²VÚ„OM+¤§nú+úi$ŒK.†’ŒÒ‘ÿ\0x`ÿ\0~Tº’TC’»1hSiÒ
yÌÑš}İïBd”åHˆçê)O“íª´4CHqJ^D£æyÒ¡ÊÒémÅ[VE±&İj‚T:ôÿ\0jåFÚşCcšSúÑºI•ºa{£¿¯ÎéKÔË•éT¿ˆâß+JXZ—ÎØNÕDJ~ª`[´©â¤˜ÊºúĞhçQÙÆğŞıµx|{L{Ubpb²bYSh²¤O2#oæõqKæ#7åÊ:hÄÜ=mˆÚ8”
“)>\\ÿ\0uggMí3xéédí3KW.)-”8„æÛÚÈ¯Iâùöxo‰x\\vÕM£ëÃ,¼’¤L)hê#[2Jk‘å®Pt‚÷6Ï6ÚRZY.N}‚y*5ş”º´9¶÷º½q»Æ’òZ*YÑÅ—ÓNµ	û}Kí×Ø„÷ù%”ÙíX—>ÈT9Jh…/Á²ü\'N@Wq°¹µÙ×ŞLJzóÓJØ\\õ®Î¾ô©ÓY¨àO7uÿ\0ƒ{R\"	ßG:sÚHßß•·ÄÍGË\"SöLí7ÊÕÏ}œ§\"MÁåO\\)ÕÔVW™IR5¼>M¶Ç¼SŒ´0“ i>.reŸ\'3mE€,1Å%ò’¢A:‰åZÁjÑBCR¡æ\"…¼Ğq²d4Ş“¤êCròš´G•ˆ9˜ƒ\"7­=£-å’{Ã/åÂ\"}ó1A“H~<’“Ñ2¿Ÿé`‘\'ÌmüÒ³¢½ueùN\\-y%çIÓ]«O¤ŠnÛ×Ø€ÙæyÖ»3Zo½³†ÌlAš&ˆZèY sƒÏjµØU‰~5N]Çi›\'­$´’O¡ÂÀ\"KC„ïIc¤’bwB¹÷ÑÃ±3¤©\0®g9­mQuØ’†d“<¨	]ØÑ´f&Ştæ#~ç.‘&š•ÑÒü
´l“Ói¡}†·«\0•ï&Ø_c¥Ã™”M+Ük›¤¾Ã]I€vÚ˜)&=lîu×—*KìfÚĞå¥M¯t…äRˆS‹Í0ÃëC.í¡‘‹¤®…ìšC÷£)#O
»íêhU®Ãq]Xk»eqHChÍàCjœ¢tçõ “qvF5n¢H8\0N+‰¶ë„6ÛFAØs€:ûª®Yñ#C>rW³ÓÜc÷Kd)¯H×Jñ¾d›m³é%	2ÆÁ”ÄœÉßMdÖb^æÃÛ%¸Z%`¢rb7ş~”)6ìc¨¯Èi	KH%Í9¨€`Ñı(˜Ë–’X­&B5€7šlRì†š^ ı©ÎÙRLeÒûšcv´)¿aíºœq¼ëRR d^fŠ-5dé>( Z¶µBîTÚİp\"<#Q¯9:S*NTÛ:.sô&‡:nÒÒ’Ö“©ÿ\051>IhL’ƒq³k·RRÛTL\09
Š}´šZLËv‹er¤h<ü€ª#jõû”¹SL –\\RÒBa
ßÊš¢ä%É%^ã°ÂtFóSÆú*¶Äe%N/D¥@J¤ı(TåìÆ95Hámf@I€ÜLòò<Zï ã5zìbİË+Ø¹0•˜Qêjºâõî>JK~ÃKä—n(\0¡!Dİ]4í63’´€8­‹/¨sK›GRÊ¢ö‹˜òN*Ş¿wRØB–z‘¡)EW|ªì³ÆJºŞ6!a9DhFõbš§@;¦½°bb&ªc8¤ìİX#¼Z\\H)\\Áè|¨”œH>¹»µ]¦qNàr>\\ªü\'~û2<ŒN‰Zvƒ&éä%!MÈ‘O?ö­/\'f“æB¨òÿ\0áFÃ))Ê™%$_*õX&ä¬ù×›…â•4³¸zĞ”ŞZ:5A2“ÏıôéSß¹W«öÿ\0‘_»¡jijSI\'@½7ÚOëï¨WîNêš>CN­ŠT	¡†Çì#“z—a2­ZíËòb”ë3Ëû×qû/Ïf»É&dòU5ö9Ù²ïˆ§]j8“s ä\0úÍE^ÎrÖA”ëÈëµIbÖé+C	óçA\'ÄdcË¦N°U}ÃV»Vuó2Q¿‚K;\0^Ü*ñ÷TIøV„#Â)\"I¹6Ø¯#ÊP:Î‚¯UÄÌNäIxmä†]\"k3ÈÄâî&·•5Rñ.Ü/ïjƒô¦ø¹ïÑ <œêCz€ëÎ¬æúJ˜u*dóHFDV<äl><H Ne¸f­jõED®À:«GÜË¤Ò8i:ê5\"¦L·±fä¯SåBôˆi§°›	€úÕI[ÑcPõ¹<æ’Ë\\½å/AÊ’èz“% &NŞT«•!±.tÈ;`dm À•š¿ŠŞÆë>¾ƒh¦¤.m%ÈlØ™ºÓ^Šëg.#]JaÉ.…Pu°T\\¨_`õ¤ Ÿñ<P=9Q¾´svö<|êNÔ˜½‡5îÆÉrÈ\0Šh}BĞ\0L
E¶öXIU£¥¶\0*9†Éæk»öÜ}Öı‡ö¹Z	Jd¸©Ì©ëüùÔ=¢\"¢µD‰‹Â”•ë¬Ìi©òÓëH”ŸÒ9E¯¥×g\\:‹d%D,sƒíÿ\0jÈòòëŠ=?âÒ¶^\\3d¦-\\JR\"@PĞzü+Êgiö{Ÿ¯¢w‡4†[HËps5Q?cBŞÃØc„”\0™‚F~B5îtûvaj/å¼É$xSÖJß¤6¯ Í£%Ë>§a¬S*OD6£÷Z>Òr¦1µ;’ö!A=¿ûØ¬©@”¦	ÔóçSşÄIRºã )-¤*rÄæé›Ê‰¹?z¯ïdAF.Şÿ\0¿aK$\\9v•º´´\"š(rr¹?èIAB ¯÷åp„Ì‘\0êZ°ï–ŠQ‹’M›Gâ9”¼s¤j˜÷oG½½ŒkŠºÓ±”+.b’¤ŸäSztU•µtc”ø¨AÍB×ğ!Kù	 áJ›\0i¢L=¨#·D·«LÇšî[”’±šcmèÜx“rtô¸(ém=èêcOÚ«MÓ¶¶ZI»…èqr2»ãhyuUÍ[Ş‹K^ì`ıÛ:4T%I>7 äŸA¨ÏrÜ£6`–ÀIĞ¦$Å%ú†¥÷`+›RVRáNŠTocı¨ˆ ’geh-ıË
”A•¸9Lz~b¡»÷
.ÈıûM­@(h\'Q×Õƒ(§»â|4­·=…\0r<ÅnxóMm{É£Îİ£`aeÇÒ¤¥h#À7#á¯í^—ÇÉş–x?—¨¯ì›	uÆœo¼e@’”ûA_éèyÖŒZ}öyÙ§HNå‡]¶BÒ¡•ˆ¡úéNJÕªŒ/¸ÊT­@	\'ié4Åö+=ŠJõ<´\"¦øèUX“œõôFˆ|[Ñ \0Ÿ„TİôJ£^ zkÌWhŠû™\'– T«#~ÇhBõÑPz	¡r‰)>è!‡0 ±˜*&O†ªå—Ù–qA½’<Bñi²PBD
ÍÇÏlÒ›q†6ìƒfJ‚âv§Ê^¡0‹ãù\0:ÛÅN§•hÅª3§rÙ>¶JÒLG*ç%L‹kd·Ä‰Y–Ş\0ª5¬l¸Ş)Z7|W°õŒ,,¦3	ñ6£)«#É§ƒ†KNÉ–8#N±\"³cõèÑšN
ˆ\"\0Q:kZmû\"«HCj×•hû™Q^Í˜ÈÔÁ+¤B^ÂŒ\'ñ&byµ¢T\\´‚Ìˆ™uJL³ŠüÚ6†”Ë=¾‡mßCHè­Xàj‘©Ö–1+ìo|
[$IÓ3`åÖ¨\0ñ9ˆ™ôÒ´—FsŒ¯“BNFCO}ì\\ßàh	Ô€Ü©Ì¯lIi\0Àæ(—G5ltÜõÓn”·¶62J<hA˜.yrhåtâô;|KcO]6¤ÇL)uT5	ñ¿¥8V«H~‘)NşuXuk£hq9Ö¡%{\'x­KN«Ø+Kdƒ²J;Á›PTv“Óİğ¡mw­¿Ü™áør^¸náÙrH—Ÿ/Ò©NRŠtÍ,QŒš²èà;7o÷…¤!×4t‰ä?zó^fOô¦{­–ßÚgJdeĞoÏö¬Iİ›uH˜0Ò&W3 Ú—¿mŠ«aKF{â‘IŸ
d
\\•’Õ= ­¢|%)YÍ›UTø¥D¸û°¥¾d<€S!F3€L:jvrŠh2ÛY–*%)H0F‚}‘Ë\\B–ªğ‚IP˜*buÓ§î=m\"å…(È•F¤ˆ4ŞÕôHzİÂ’Ğ@ÌÜIßûSTšZÅ7}ÛÈ•„¶\\ß(ÜSİ^Åí«WC–Â-×	üAÙ§¦¢î=‹—)ª—BÍ<	r<àÑ)wÉ
q½Dnİûj3Şf ì“4iöÇ<R^Æ†®Q9’HÒwŸJ”á&Èá8®Ä×tµB…kâH3Ö9RÜßKşÃX’õ40º¹´Pò‘²‹ãÎ‘“%¯R±ğÆã¸°;¤J[·1¤ó
©j´‹I6ıLap´<­„‚ŸBç»HjN–0ºQS%hQ}‘AaJ):`•¥iJÖ©ßnt->ÉM] MÓ*.();/÷®rÇå0eÛ!ÌÀ…Û‘ï OìY¾·9TDØt¨c[DS±JÄ˜ZÇ&¶TÏŠ-YJvµÃí¶—VÚPÂD5z_Èmâ~;§¯äRÉHº+Z€deœº¤l‘Ğÿ\0Ô+ÑcnG„ÎéŠŞ°È7 „ÚÜ\'0ì(òN™¼¦­¦—EKIm‘JÏîÙH‘™??ï]…ş;Ûâçè)“ëDF_qE x·”÷5İi§>•Ü‚Q×àîİœî¤+¬PÎT´JÛÙ;À8rÒı	;ÊóşG““7p`Ç4¬–Xğ5°P–‡÷¬œ|ß¹¯t‰.Á6ˆF¨Nnp ‘Yóófßf†?+¤Kì¸o	q’—ØhR±Y²òr©ZeØ`ƒT/sÃxA²!Hk)ÿ\0A§Jäåå¦3äÂª€w¼†<d2É|oás«ór­^ŠÒññÉ~Å{8°[ÊîÙADk¦Õ¥â9Û3rxxäôˆãœÕ³™Òœ³Êw«ËÏsTÙR>*‹n¨ı›{ñ°P;“W#äIÄ­,jRq(Ã‡=9iLÅr–ÉÊªezŞÊ*ŸJÖfO@(h‘ä+AQ™º7oSÌÁ¨•†šzzfÛP»h—Ié˜öFÑ?
©.Ë\\©4\'Ö‘\"Ün¬tÔÌ…&_’ÌTwc„)a%¡¶\"¯ëLÅØ¬¯Z\0:Ir\"kJ=RMÛb/ÎB ™óÚ=‘4ÕllÌIŞ+«ØáÏhl9mR{úP¼µ·ÀRıÂ]ÛÕØÛĞÓ@öÇnˆdÿ\0M%mØÉZÚ9œäT×¤*/v=T% |)²ÅJ­º2Ú{ñšTvH¢kì)5}[GË«i
Iî’afòõê|ê´ÓNÑw
·rè°x~åçÊÖB\0$6×åu>®µG7¥UÛ5¼i,“¨—W´]ãŸŠ”€DşÚ\"¼¯–ö{ŸvZø@”(Zö¦œ«*KînÆŞ‘-ÃÏâXƒšcYŠZn¶Ç· £g)ˆ[	?*İlíi-$ç	Q¶ºS!v.oìµ±ñË’“·ZjŠ÷d)×Ai\'\"3AFYŠj‚HmÉí°£©ND%$s¡\"‚ZÉ·lvãeÖÖPPÿ\0(£à€ŠâÎÙmmäRU’‹0Í4ä«h™SĞşß»uÀò&“OêJŠòN1pléKPu ,%³²	’}M
u#©Sµléç]24Hƒ”ÑIÊëı€Œ`¶ÄµC…‚Ó`îäùùĞ¸¥½!²ÈäšÛ.wZŠ“˜;yP_W4’)çZĞ¤HJU¨ñJvŞËJ1ŠÓ³•¶\\JÀ H9HŠWMŸLı²¬Äø’©ØúÒ¸ğ÷É= ;à<ã©$!@hAéU¹rmDeÕlù!”Èæ.Û;~Ã€Q¦FÃ­s\\X	4!p×zØ„’©ŸJÉçN¬qd
Ï†	ÓNµJ†)ûì^ÙJM…c6‘F¶´5I>ÈóÌ£,.¤¾¼ë“kdIrTSİ¯3İw¨Ô,²TæRwÒ¶ü)4Ï-ñq<çt’‹‡–JIJwR´#“^³Ö™óŒÑ¦Õ^¾(-¼“
eEî“0|÷ ùU¸¯c3%Åìgˆ-
í9iûr¦rJª·Øíp	*&#9z–ÄívÇ
;Ï:R_a­ÒŞÍ¡ÀDË•C@«E«ØÖÃøƒ—kÄì™Än[)2ø%°s+(\"LÀ×AY¾LòGèrwöv–ÖÁ¼Z–ğ¤¦İ‡mÛ}Vè&Q É\0TrÌ*´!/#Íl·ãyR‹»ğwXİ©¶® ì	¯=åøY!¸»Äó!“L»¸k†ìqÖĞXy³˜{$^G6YãtÏU‹$­2omØÚÜ@R
w1­g?6E¸á…örçb/©z6MóZ[\'ôÑ»³g±%439ó&(¿\\ı~47\'ÙâŞÃ8i•÷¯¥Dk	«˜3dÌı(§“1ÆÛ<ÿ\0ÆÜilÃ®6Â‚`ì{OÃœÒr<¯™äÆ:LaÃ¸%ª¼3ğ¯A“
ÅqòYé‡ø¥e6@LŒ¿
F%r´‹Ùeª ‰†¨ƒéZŒËªè•HÜGŸ*Ò3û2b6ò¨“÷:)1F@Ï¦¾¢¢]TdµJOeøÒŠLxÒb\'_-écÔht×‹‘Ó¥%OWC”¤r¥°õc\\G0G¥7bòı(½IJĞFcwû]ˆD	øÓq÷±sz¯ö4	Íá÷S%¡Jİ¤„T’W¶³½è©PÌhHiu»
IÅ$„X\0¸\'÷£nˆŒ[t;|€Û*5c¥
T6hôiM–”“t‡w,ÌÄL6?\"QZ:¶Z½ d«Mÿ\0u,Mıƒx[Å\0e\0iU¥iì·Ò¥´OxY
yşí
Ê	S¦di)ª>Cû~_-‰à«¢Ø!)IÑj¥)Ó^gZò¾T®[=ç‰Å2×Àmó©+À\0³­cÊWiÊ4‰IYJBuTÁòéKVÕIvÂöeñøŠÀ$‰š|b›šw­¬™l§)&gsV£ÜÛZA›{„=%¢H;‰êjÇW
µ¦a2\0A	Ôçê}(”h+§lrÃ½ÿ\0xĞB½š.6ê˜ê¤¤Ø­ªÖ-ò¬‘>Vğ9ÔÕ ¦¢åhp‡RSjPI
GÎ†ı›ÆKkÜs‘%™kğĞ“9¦IëVMk¡|œeêÛhk3m)_õjb“ÆMzPÎQºlX¨¥$J@Šc{Š´Ø“WHqA
RG,½-hm=–6—$…{ŒÂL¥SíëR±§µ`s­{6ÉQJ
lÈu XÛa¹®ÑĞe	n\0kºjåÀ<÷}ÿ\0qƒ¶ì­õŒğ¥hP¡¢…+åÂ]sŸ ]Ûie´j\"4#M)*!IÉ‚.ÚAV_óDùUyFµc”Z¹nPîD™D{]*¬å;ßC$¥I*L:¤¥
IvDŸ¼X‹¨ÌA@&Bª-V‰ˆB\\`Ä™ĞëEª
70YKöÎ )=ãc1BçÅì§ûQa¶k•d}©RF„ï¨Z¾ã.Œ;wG›Ü·Z1\"ò$$*F™g@O¾+Öâ+>wäm´Õ‘ÇpçÔ´ÙQFc”ê]À÷Uøµ-ò´êÎ´•…F¥I”ÁÒyŸÊ‰èVıĞ8Œ®‚u Éš1o}®‰\0*eGpÔp`Ê—bIyyN»i¡¢â€¿qÍ†1w†>—­Ÿ[™
ƒÊ‚x£‘T•iûİbw¯-çİ[î¬Ê–â¤“êhc1T•lâß~ÙÀ¤(¤:éâŒÖĞqË,I>áÚ1^u-e)3½`yÅhÛñ~-<4¤]œ9öËzÍ„¡åW’Íşúèğü~R$¿ÿ\0›,à#™óª_ÿ\0ò/L¸¾?ãÕ²/Äl×®ÙRX
Ö¯áÿ\0Oıl«“üC‰}(¤ø¿¶Üc‰Ô©R’ó¯Yâ|Ùç|¯ŒdÏ¨¶@.1®ÔVê”³ç5è!0ÒGŸYÏ¶Hø©W©™4U/.¨¿âjvLøÅqj:Æõ‘Ü´lf~ˆ.ÍÀ­Orƒj‘Q\'ÃyVšLÇµö:`ºÄÔ?Á)Å
Ûÿ\0‰·ÀPË®ÎÓY‘\"©K²äU*ìzÚ\0\"H“-%LrÚsk3åÖ’ËÚTÇ)N¼ã­-¤3ÅƒMÇ*~.Äe«î€+œúÇ1µh.ŒÇ·¡‚LîÓ#Ø¹8ïî7O…$kXšö)=P‚ŒªNÆCµeî@:À)>ãZ´$ ĞüQÌ\\©¡Q—9¸\0‘î¥D9Ób,‰tÏ.”ÇÑ
?‘Åà”ˆ×Ò•Œ<›Te¢s:\0Ò¢}(æë`R}íŞ-¤63!*‚HŞ}õVKÜµ’,~Sn]\"ul(B
†ºîMeùsĞx	·M–á”¥–ÙRÈh‘Fƒäü‰l÷~*\\–F[Âç:ùEg=ôk/ÃÅøë
áxEÕÛx¦2‚>TÈBSÔ¹M%l/µ›_½2¾üµBa=ß¯ğÕØxóOeWäc÷$V¤$œßyRLFex¥GXAü5abŸK²lkL“à<\\İû­­wù¹şHHò&š±8±®qqô¢}mŠ´—
òç\'BHëä)œkr+)Ş‘ Ãß+É•kUæéò¦ÅrºÛy6¬*Ö«”2·`,&rO9ÿ\0”ÚV³¨6 ÅÓ‡¶”¥%I\0è4˜Ö»äÇ ‘)m	?†©´d
ÌåşÔ©á­#äÛÙÓ,8Í°ğ¬„l£üÔWGQ:Ybå·Ø£v—
23H\'Q4kŸB¥–ÉÁRæIJB¼YSúÆ§jcñùwì\'õn6¾â¢İjµqM£¼gÁ§I˜ÛÎ8õ¡o*ä“uüF¬Ú­n”…\'p°
’tò(Vzù)#W¬}ÑÀNnï)H•ÒÃÅşäcò9ªD7ÅQn \\il„èƒ©zŠÍË
İQ­JJ”€Ïã¥\'¼ÈR…¥Ì¤y*£ÒÚ,®é0yÇmAYR’¡ *˜ôëJj+t3‹}£µ¼YBWüÏ§V’ˆªqİ¯6Ş0ê”Øÿ\0.ô‡i[,Å©/È=7*qP&
ˆ![ƒC¬‡µû	QPT+x•1/°)¿Ø…ãaVïPH^ &t^Ÿµ~Ì	nì¦¸êèİYİ $ \'4ƒ¦_|m[~2§³ÎyRr¸”%Ñ-ßÜ!B‚J¡ÍœÊc®Ñ^§Ò>äÉÆm6F°Ë¦™.¥HiJR¹öv=v“j.ÌÉ*Ø)Ji)a\':U›Qáø¬Ó¾­Ğ«}‚o3¨Ä\0e0®U1üö†w­•\0¤ÁLDÍ2é\'WØØêb~4À~Æ¶2t¤„¨ÌÅ#Ú<ë‘Ö™­÷ØšâzF&DÄC\\ÈWFÂŒAÏHÌÅ@A$t®Ñ?ìj`{DÔ‘û*•L“\\MÑĞÕC]¹W¶Lø¯ù”ëÎ²|Ç£KÄÜë²YÆ‡ğBw¬ßÓ6|Š­w-\09U¤»37\\Hê‰Ë°úV’2[lí¡Ëù5äşâöŞë¯¥®ƒº3¢AÕ^‹~ßßó5†’Øøët9f@ĞÒ¤XQµht‘|¹R^Æ¤–Áø¤Ç—YÄRÎè¯kMÆ‚yÕïb•E6†÷cÃ¬éÖ›À¬”Ş†É»1·•5ö-kLE#2„ÎÂŒz¬Ğ§J]«¸õ±+d’çÒŠOB£IĞíğzOJLht’·÷_•ªRãª»€NÀó¡†Ã®;ìí„‘*yÈî®–Å*Z+¿w&’/9¤MRíße|–œZTã(•!*Fÿ\0*Ãòä’t{O‡ãôª.kGM²Úo ujÜÎ„t^uær\'&Û=deIQãŞŞq.Zğì.å7‚ŸğÓœ}j×á,û–Œï+Ïı?[ÿ\0Ü§î»LÄï®“{rmİqJ.¤J§¯ˆîwšô8ü8cUËäøLä+oÇWåm\\2ë©¸T%N8áDë0\"y
{ñ õB#çåm¨ÎŸ¹%¶íMimwoİfL%iSI&9eQ9€Ôó¡–úGGÊâ­½şäÇ	í¡ëKG_MÂ>â\0	R“#S¤ùRß–ëeˆüFNéÑlp¯n–ìÚ0—Eºİ@qo;¡Ê?¯ºªåñå¤Óñ¾%º“-ní{	y…bm­âL%W#yñŠLcÅ[5>rÈÒMÆí^\\ 7|ùjvJF èLiïç]ÓÛ{
I5¤‹#¾iö”•™p d&\0ˆĞ¨5M4fdäª‡é´EÇ´µ¶R4€¿GòÔ¶wÎpëc«V[}ò—
I\0 È	õ¢„mÓs”chyu÷KrğZš+¨n k¨°&™%RSË*®ˆ¦#ÄŒ\\„!vÀ/\"ÛXÜ’Ÿ¨é­WrSëEüxçrdBïµ«l#	ÅnŸqMµlJr ŒÎB60Hä*ºÊâ›h³“Ç·šÿ\0¢­WÚjŞÕ×Upè¶ –Ú’„$ƒ”&3‘Èt¨äÉw_ßõ
x±Uv?k¾Ä›‘‰¸Ü$BĞgNYU§B63Nk$ı«ûşşÅhçÁrØˆ;mgB~èëoÙ”•”÷¾$“¬Dr4‰crE¬f4ôöF¸‡µ”ZØ÷Í8·Ô#¼\'1XW9iúD|vŞ‹>!ñÒ×cr‚‹¶nÊ›0ÊIÒ ŸhmÖ—“Ä]¦>\'ó7ışá{~ÖJjå-ºÖfü`œí¦7);û üÅQ–bü|ØÉ°^Øm±\0Ã\\wä.8Azuª90Mh½‹ÈÇ\'R,/½4âà…‰*üê¥5¦ZM½.†™Ê}©
Û‘÷ÑÆ¨.(Œñ\'…„¹»€’™:*9|â¬F™J’‰íõ!.6K-9Ê\'bê•nø§—ó›MÙEñJ_CèYÈ?<O/Ÿ*õéGg…ÎÛîÉ¹M×„æ2³!BLò˜«	^¤QÈâ¶
yKDª‘ÏtŸ^TØ:ÜEÓØ5öÒ¢r£Pd\0tƒ¼ô©nÎú½Æ·ğHØòó©d>®ÆDeü9šu‚ÕvrÊ§°ZkÜè\0Fº
‚û³9·Ò¦şç-™º@‘1QÓ&©hÈ\0G*ëÙŠ(‚&¤/sY	 “?:ë&ŒÖvÓÑ¤è‰dWvkØötÔ¼“¸•æµÓ4ü%ê²CÇ
¯Mê‡İŞJû÷à:ÖŠ{3šu¦E³§-kTÈÓĞ²=“éÖ–ÉLVÌ¨Ê=hfÂIû Ã\'(&j“/EËŠ¥±ëI3­\"EˆØéµu:M%şWc€AØïÌRßär§ûqI\"4ugSÈµØÊôå5¡U5ÔºØ…äÁ1”QÀ^Níˆ¢dškìRJ¶$’;Î{Ñ{JÇ/@BFôµØÆë¡+aãœ¢g•Àˆ½ÂŒ\0FıiQü’]½Û\'#‚yL“´%~GW: œ·¥C±ó¶·şÆ’²€æt4MX˜ë ßaªÄqãQ˜IoHÈÒ]—0COcÔÜcı:Ü\"’@$l+ÉùRz>‹âãp€Ü}ÇÃ…Øö0æ$âV\"rO^ºr¤aÀ²ºz^ã3ù_!\\VÊWîX¾2âÜe)yé+Y2Wë
ô˜á-{7<òæ•Éì/…v[â\\¥x[Å “›~cCbE;æÅw°‰6)‰p\'¥ä¶Öïx±)U´) –cA\\§tñ³7éˆŒàæ%Şw¡@ñ¼ÉëA™éV#8¥«*OÅÎ½RˆæöâõŒI»«‹VÛBcşZÉ´[”\"I„…¦¼ó=(µÉ¹l[SZâĞQR‹iU¾{vR[¶uaNä¥%	
æéJ”cŞ˜ÈO\"Ó±Ã<k`ú\\¶¹WˆøcØí¶ß¿*ªñAê(gÉ	z[t\\švÎö¦—Š‚û`Éy…¤AIéæ*\\‹ôÇó2qNG­û4íRßÃV-î’óˆ	T¨a¹ùiU#\'UsŒr´ı‹câ[¬^É%
\\£U/®œùíÒ­)ÊkìÊğÍŞĞ~ß€²¥¬	+Gæ?¦•aM­ö*XÔş!ÜbÖÙµ¸´d
WtB‰‘ÌrŞ–ç«hï‘9R‹ü-ÆÛÂ±=N8E»¯çÌvl¢	?údÇ•VÈéª©BWÿ\0²‚ãŒJÓÁíyĞÛj}ÖIK» ò07”¦†ıV˜ÙN1‹Rty_‹ğ|Béë¼Bÿ\0qÕ—¿¯U,Á(Hç\0‰:´éZ‘àª»<×‘ÍZrtEŠ;„]2ò›[‚2¼R 4€\03üÒ­\'ªf4šºköÿ\0ˆ.Pòûö‘¬¡À¦c¦^}u©¨KBœåSt8Äxƒ:€§YÃ	AJå!QíFnG_ó¢^.9;BãçdJ®ÆWdõíaö;Ô±
	PiÅÉÑD“´k¥.x-l³Ëãû±Tq­û©6¯­ö2—²© ˆ…\'Ï_>‘T§ã_]¡ç¸º—c«nÔ|‡]e«{¦F@ßàwI”ùÕIø”ªÍL{o²èì+¶ç	ÄK¿rwÿ\0Çuñám|ĞUÏõó¬o/ÂkhôÄ~f¤^ËJ•%P…¤kÊyÖ\\^ÏJ²6€¸ƒ†şÙIZ¦ \"¬­>ÀÉ$ÖÊ´¶fãŠVdä&˜ñ‡ÏÏoxvy_6ÛzÑçüZã)u ¿Ã9üúW¤ÅMQà³ÊŒ?¨8ÍÅÑJÿ\0ÀA#LÀ}Æ­ÒTÌ¶íûšBRÍªË(s7†v9uÓÔLt÷@Ë•ìæ[‡“)\0ëQÓ£šµlg‰ ´&BT5ƒÌoûûé§Ğ3ğ¦ƒ¿¹€å3â×Cë]ÙÛ£AS±™Ö*r.º3_óN¼ë»föP‚LÔª2ƒ35Ç-›€	ØM@+ofˆ hLjjWä-œÉ’+ıÎ‰ßCDGK¢ÅìÍ!KI#ëıëÎ¤Í^ƒ\\q¢ˆˆ›£ã÷FŸ‘iQ,©Ü¨H$ÆÛUÛQÛ(q”.ÈšÀI­tdk¨ƒáë¦³BÎŠ~ìqhs,iı¨%¡‹éº²˜HçE–âšV;h¦”™£j¨tÈËå×Î’ÇÇÓ´Ç)H<ŒùÒ˜Û°f)ùô«X´ŠY£n¬ùôÖ¯{Û¯¤m{cDô\"›ŒFG*èIµK&yô£}ŠŠB‹¨$óÒ˜úı‡Oxß
TBnÄ¬Óø“>Ph¦ônìVä$ÀØzĞÂû
TßfíY•¢\0äLOÂºoZ1åŞ…îT”’tŞ5>´¨/q™$ºIÌ\'Q·•3±¢Íì“:—×ØFñ®õåÊ£³Ğ|/9]YèkçÚÀğ+‹“¢k1\"5ÓAñ5äeë•#ŞTaº(Æí®q¼EË×Ô‡\\Zó¨™×’}<ô­ÌiE%ìyœÏ$ç~ÿ\0ğ[œÙ½Ô]<”2@€é0˜ÿ\0«tŸQMÉ“‚¦Ëx¼[vËÛ‡8k
²@R[Rİ@ü7RpyÈO¸ï½S–z6!âÅ%TO0#	¶Gxm­°• §E‰×àó¥¯%=\"\'\'U Ã¼!ÃØİ²ÏvŞeø¨Q>Dr‘R²kLDá%©\"/Äg¾âw¬)m¦[[(	$s|G®Ôèæi5U8O¸ÿ\02¥Æ>ËX\"Yu€•&àZQªG\"9
åL\\|<oµwışåoÄf{ü-i]£i[EY‚ÛYùƒ·ÇJt|Ïfsød_ÒÃ8ç	t²õ»¶ªhì¢d“â\0ìGM9uÜ^hµ¶[ÅâÎ:^ÅÕÙ¾octİå½ÃŒ,J\\l˜>›Dê=j´ç£ZãhôWİFy9’³ VÄŸ}$âé“’
UKdÿ\0]ªZBÁË¾š/ZŒíU•¥iòhoŒ°îÙZá¹”ÁÚ5õ ›åV7§%Ù	âÛv¯Ï|ÊV†æ[*0IÜƒ·ûÒ\'’Á†6­&P\\s9q«Ëol¯ÀLJBÎëRy&\0“¯¥2RÙ3ÅÍ$Õ×{:{¹îî-Ã–ÍŒĞF|æ7$ÆÛ}Z²¥´öR—„ÜîJˆÅÇÙ¯Ånå°Ê‰(ŒûÈ\0uõ:t§ÇÉŒ{+Oáğo‘Ä~Îö˜‰aÏ\\İÁRŞp¯U’Gõey)­ÒğRm¡í·ÙŠOs™ûVx§Àë	³¼OJl<(\\ş	;°ş%öEÅlmR›\\A›°°RVk	Q×ˆ\\Î¾TkÈ÷eWğø¦øº\"ıq´İ­%—CIW³%@D‘\0œ±Ògmê?P¤Å¯†ä×¹
Ç{â÷ïAqÎğøW&L•*&‡æÅºd¿$Qû¾-Ü¥ÔfrÛ¼6(eKT3Í‰Úßìz/²NÚN3dŞ‹«%ÊVŞQÜˆß­y+ÅàùGhöŸËÑ4Z¥]ãr „yN•“Uîz\\–ˆam_Y¨­œîePçÁäzÖ-èËòcÊ,ò7ajÃ±4„(˜A¯cãÏ’GÍ¼ü*tEÔì©¿óä™Û¥h&Ú³¥ ‚.’pû8\0­+:u’7Š˜şÄm»–ÒÚÁj{¼ÚG]ùĞ¾ÃN’Ö†¸ªBW—!Á˜k¶ßJtl\\’_Äù€¥«öF iú
ÂºÓ3( Îƒ¤o]³´hÁ±æEIÚF{;t¨‘³©ƒô®?z29É?Jã©U¤`#C:t®g*×A\'Ö§®ÉıÄcÚÓå4gvZ=–3˜Çº¼÷Ähßøtvã¨/ÆÄB\"«xÉö\\òÚäGí–ºJŒmr«’‚J99c6 sŠİßGœJŞÅ€99Eì•t/f˜P×J\\Ş]Ğa@Mš—²5§/|Uv‹p·Øå¨H:jSØõÅ1pzE,°´í±Mâ&­â3¼„í¥î*ÎİzUçÑ›8èoxcyßÈS ˆ—Vp\0KDÇ¾‹ÜŸB(…:3ĞM3Ø[mö,øğÎà|©q)R¨ÿ\0Ù«0$g”
™»Hêé\0òµg94Ìµ	Dkó©ĞjJét.úJøëJƒ¢r%v+lÉÌØºBLŸ‡ûÑîLÕÈ¾»ÀÔ¬1/©½â#œ^wâYT_Ûàø¤ám`èÄ0¿º!d%@‰õ5çq6æU’)@	Ã|*àuÖËl6ÊL””™3ÏY¶¥‘U#\"8yNÚ,¼!Û\\Ù¶û„!@f*H„ùiTrM½ÕaûC]ÊYÃ˜\'B””§ÍJåÏö¥¨Iêé<Jµ‡ãX½ákïö¬>…GvÊ3­¦äòŠdqBôÛYx.è•ğã÷WÏ<•qRXM±!ÁŞ0•f‰Øë¬€i°ÁıKEYù1Œk·üBîÜq“(z×KÉ
„©L‚7ö­\'ÒX8+LçOô‚Gj÷67Ş(…‘«­+:=`€G¾«5$ôXŒ]P~×Š-ñV¦İJÑºTˆ5cj¸quÛÜ7+f9¦õw¢Ï\'0ˆ\'p´ ¡J€å¥EûeÆ­2åà<A±h•*š\"F“ÔR#7]’±¹ô[X>(Êí]Bt™ı£İVáä.4Ê™|ys´íï¯éï\\D¸™\\ÈÓaCóT¶ÂX¸zQTqÏ¿itZiH’%&ÚIš	Mô–Í,>)E¹=‘k{ô>è’•,IĞh\'Ê—ëöEiÁA†°ğ…¡*îÂP’­i±‹Kh¥9.¬\"‹ûU{jJr¤‚“#çÊ§’]pgvÜAÃöH—BHU AëF²%Ø©cÈİlxÿ\0x%m<Ë° (ñ¢Yíé
Ÿ‹>˜ış.°¹o3jiHY€ÖSĞFœªÃÎ!xi€1g-¯™D¥¡Pi1<Ì†‘ó¯vZÅÉâlÙô„¦İ„¬øs*\0ò~Q­L3ù÷è¤8»†Oon¯¼ Ÿe–Â€3×ßNYSbrx«Ù†5‚ÜàX€ZÙ6îœgx-@óöIó«’2·ŠoEÏÙ_9ÄøİŞ\'ï6„$£‘¨¬+	ë¦z/<§²M‰;ß0â\\B¥(&DùULrâè¹“~–yßµ¾ü\'ß\0‡­¢f4?/¥zß\'$‘áş+†¶‘J«ÙAJ¤?+y_Gˆ•µc‹BYD*×´KDoÜÕ«©îBÆ¥<ˆşÓ]Vö]1¦0àR[$™):ùìCEnÑ2×Ô)¦‚œ*¾Æ€Òb:éï®;÷9ÜNRĞõ©![÷2¾šWtKû3`	ˆÄ¶r\"¤ùkS²WäÂ¡´“§º ıƒ)\"+¨šû¡
y@ fš†Ò[#lFâÕÆÄtƒG©ts×eµÙE¹îGHŞ¼×Äå³Ğü9[ô±N:{ÿ\0›•/ÇM\"ï’Ÿ.È³«È¯ÛZ½ÇEN2Ñ€Ó[0ı…öli\0n&—îÜwĞ½‘×H¡™Ë~ávds÷UhÅi1ër\0×O*C,¡Û#0ëî¤È|bÉ€™)l|iv¶ä}jî;Èj/@tø•˜’~•uôPÇ·ê¼:‘©‚)\'öÄóåI\0õÚŠ¶)VĞ‹`4]<é aÅÉA;7¥Á4Â’^ÆìâH&3i½DÆAÅjÌ¸ÒïÔé]Ø\\×Üİ§·ÒF•ÓZä9YHI3$®Ô¸ÛhnEĞı¦
î{°H*>ÓùwMƒ[[=OÙş0¬&Õ¤ ÂR’I1ó>úñ~lùet}#á˜¾^(¢r-½mKHï g^±T±®;fÎT†–,–İPÊ	ÖwÒ¬^Šq‹^ã>*Ä–Å“¤C\"Šœk“Ø$¢½(§qÒØÀí—mh»“¬êó$õ­hxÏ-IèÀò<õŠÔ~¡nàŞ4í9JÅ¿vÓo17
&\0•:íËZÖÇâÁ{s7—‘ï#ÙSbXÅû‹ª·¿}>\"¼Ğ¸ó\"¬C&ê%\\FXEJû%8ã¼oÙ3†\"ëM½Åíƒƒ&Úõ·å§ASeEµ(%DRHRt
vo.ŠĞx<ÜÊV¥wıô[|ÇüOˆa¦ûÃÿ\0ªaÍ(¡Û–s²DQé}cby§6zŸâ²äñe.>v.s†]µnµ{l)Y‡Tò\'ÏŸ0+}Ô´züiÃÔ¶™bİğÃ–¸?zâèÊ)æ9S•Çò/$”-gáê±Z¿ JÆƒÎ‚kvƒUI{²ØìşáLÛ[¤L™¬œò³w;nÙ©bÔ¨è\"cÎ‚©lMT€x¶(¶mÖ€H\0Ä#İQóh³ò”¤S\\gŠ¸åÚÂ<KV¦yk½ZÄÜˆ¯–İôà¸½an÷eÇJI3ù@ëZqÄÚ<ÿ\0‘äEÎ›Æïnpt)´¤˜¨í>ú¯*RĞøaÇ/Seob8ÚîTâí€­|J ùr<õøQq_ê\"Mıjˆ-‹á8Í~ë`«\\÷Î“`$~Ôüx¥-E²åÇ‰›-pŞÕû:mÀÛ÷v¡°¢¤aÒDï¼:yUÅãä{lÌ…Ôt¿p½ŸğF3‡¦ãÇšµ|¸R†–Wláÿ\0T\0mTç…îÑn†Y%ÑÃ¼CákZâ&êŞ\'¹ºÕJ¦UŸ}Wùq]è¶÷´H8s´ÆñSİ]%ËkÄÁ[+ß¤ùÏQ¥*XÚÚè(ä‹ÓÓbÙ_°®õ®öIÔòôéAµ¦5»ÑYñG³Š_”%	(Ü ¡
\0¤Ò®C3ŠÒ/¢ÛÓ!\\3İğÇ:ó6®)œåZPtÓIşÜ¨<‰)FÁññ¨=eÓ
P\0IRµĞçY
F§{+~ÑpTİX?˜BDÊ¶ü,¤Œ‰aoG•ñD{Å´9U:õØŞ™æ‚‹£,GüÁVR–É Qä¬EZ4éS«RO†dÀ¢ªZ%7lo”.
ƒ´TÁŞÈ–úC(èÓ,VÑÑ“¬<«ìÑÓqë&¸›KØçtÉÛ~b¦Îı•:kêŠ;F³&tCJšdªJïbjÓ©H:ÙÛdN¢9Thî-il_ïÊ†úRrG’¤wÒ-‹İ¡ô¡#y™¡Ã‘$ß±köFÌ[LÒ°<ùzOğÕé´†œtB±\0{\\…Šõcü—o}‘\'‰.í¡­Ñİ¶ÙÍ¨NÚu­z÷1Õ&*\'ºÕQÔP{Œ[ˆâÏÚ\0©Y¶è2ÈƒT¤Í;Û6A;
C,Új‡M§•)M‹å:ø„r¥ö>˜2³¬ùUü=^C¤ÕRNc¬AşM\\kEX÷éŞ«)ùÎÔÌ{—ìrAñÓJ/õä”Dmä9ÓËÎŠ]\0…î§*AøPC¶9»JÑ»Ef$ü\"¢`EteÌO™5Ğ³¤¶áœóˆql¬X[Ï¸r„¤@õ\'iYçqr“-ø~4üœªVÉïöHx/‡¾{MÍâ–íÚoÀüÄÉéµdøŞÏÉÁGG¦òş/Ë9Ûûx?8†;bÊ`¸¥§pFúÏÂ´rÎ“<Ş\\×G­°mĞVU!¬ÃcĞs¯–iÉ³ê><=‰á.İ·3¯:;,Íq¦3âœÙwŠÈB§òò¨ùî“ÂıH¢8Öç½Z˜däNğIPêkS¨Çó9ËPÑÃû0½¾R¯¯-Öâ
´`èHÜD­eäÁt`?$Ÿ9§ñû|ÃÍá˜jÛµ‚\\‰I
\0ÄíÖh¡äµ;»\'7ÃÖHVÓıŠqŞÁ1|mĞşsjXujû¹yjB”™>F}jÆ?#„í­2–o†d–5½¢cgö8ã+LQœîÛÜ(6ÒœJYY-©r43×İV3y‰*Qeá»”’/>Èìñ^Ë8Vÿ\0‡í­,ï¼YûÓ·m(”ˆJA úÍdåø•ÇåÅhôØ~\0œşd§ıXGÙúçsï‚èaÙG…6÷CU&ˆëÎ`\0<«/$òg×èŞŠÇâúc&ÿ\0¿bİÃ0…pÖ»§Íñî²/òùU?•,r¦1åù´ÑLq78“L\'`îu”ÆÃjéOE¼ùJúE‹Á¶¬±g¡p¹É:ÁmT5Û=RI%Ñ;Âm‚êÔ¥œé”¥N’À
Si¾†äÉéKş\0<Hé,½â	3•\"$PS¡izŠávËñ$*e\'Èÿ\0ZÁétÄù¸Ysğ>hÍ‹ëqA*È™Lj¡å¶µµÕ÷<6Tå5¢·í/ƒÛp¬J‹ÈeKé#MÀÿ\0j¦òdÉqQHÕÅ‚0©sl¨,¬x§µ¬a«<!Òíœ_Šñäe-ëN†®øŞ;—ÿ\0`¿3Éı66àF>Ö?gë>ÉøwvÕûœBêıÀÕÅåÊåYÒ™1É šô°Ç}#ç¼Œ¾Kå\'£Ëü?mƒ&Û8­ö!‡âÍH°M“)Z]x¨ÛÄ­9(*•\0£ ÖF–(Ç†Ì“Ÿ6—@œ2ÕÇnÛCO->  äÕL‘Š’Ü±†Sk—T\\¸«Ü_Ù\"Ú[«]Şáéï\0ÛË~QY¹ülm¸³ÑøŞg“*Qdãû.®İt½gTJ†dƒ¨ò¬\\¸%‡òGãù‘ò_tËkÄoe¤>¬ 	”‰Ÿçº³\'§£c/w²@aõ)Ä¥­CÄ¤é|ªØ×+uv9cBšuHA\\Ô7ÓûTÎV‡b\\4Æ2®õ!CTÏ²$‘U§¤^pOh…qE‚¯­¤ÉZiWpMÆKe\'œZ<‘Æ¸y·Å®t9{ÃâŞ½×î6Ï’ùĞá•¤µıômQß°>¢MY”YœéÚ—\"	{ÔµAA9\'¾†o ø”L i®…µî„ŠALAuš+!=RFŒñ:Ôşç:öFŠ¤=H©¢.ıw™•iåµMY½˜’9ò¨gtmS\'YB¸„p¤:X©Ar~ïFĞL:ô¨`ìĞVN{ÔÕ’÷ĞšÕÒ|É¢HoL½;)dÿ\0Mlú
ò>sõ³Õü:ãèÆÚâdµ£ñÕD“R•‘7–{Ó·X­­²{dTˆØM+Y;áúNûĞ{M´-câY:“A>ˆ‹·h4Èv1TdiE4®ö<n&6¤;,§«C¦É‰ÜÍ%¡ğI«èq0¤é¼éK¡Ñ€qC.lf´1tfçQo Zu&~­²Š“é­®ÔJŒE6Èå{FœÜ\'¤sëR»9ÒT•ºaÃ×­¶…ÇºìZàBµ’}ÚPÇhfIRQ³Õ=O:	“¯g/œÑ”s‚jc®Á•Ç½–Ïc¶ë°Á¯±+[¼]w™!;”0:Iú
Ìó—:‹gĞÃ#Æyêßà7Æ[aÄ¸@h…5tƒ.[¼2­$LƒóO	Ùè~+äB^;ƒÓöC†}÷‰Z|£ğÚQXˆ•+××åW¼™V6›øPsò¯G®8^Ù´°µ¡  $úô¯‘ß{>Ÿ‚7¦N,mµo<¤•òQÍ¯­%]”-Ó@~ ¶MñÕœã”=w¦G»@¸ÅiÛnÍÜÏ²UœÁÊ0jÒ”ö‘Gä®{$8>j¼‹u„„¤Ba;šWÌ—¾‹_%:H\'}À]ÒJœI*X IG¥rÎÓñòÓCûÀ-¾ê·â„”@\\\0„@j9e)[lSÁöH³x†plNÙM¥ æZ‰_²|Äwvä}kW8äÈÊò\\â½ÇàØ]…Ê“kj…¼¶À@0IĞÆÿ\0?”Ğ¹Cã±‹æÎ	ä—ğ1wÂõR·£ML ı{éò¥ì?’óé-Ş%Å–Ûw¡RWÓDû‡!Y™2Ü®öiáñ­(×ESr…¦ù¢±+R‰\"tÒ¡tË¶”¸®‹G‡ÖÙe\0‚¥e#Ú:J¯*nX_±:µy–pÿ\0R|>Şğ)N×G8ÊR!ÜB´˜^|Ê‘f§£Õ‘Å°ú\\D ÂzT»[Òši–z®å)JGx‘¼üªæ–¿\'ÏáÔ¯Ø!‰÷X¥¨ï­|€s!Cz¶øO´Qã<ôº+>!ìù-_-ü9jæ`@mE+Q;eË¯º‡„±¿Iká4ÖMÿ\0Ú\'	c|u€ÿ\0CâË»›&ÕáUÂeÖVér\"»Ÿ-jö/3.\'RÌÇò>ƒ4\\¡şÅM‹}‰­^Ãq+‹N&ië¦.PÊ]Kí)¨PAÕ\0f^ªŒÉ\"\"İÇå8ÃÙÿ\0Éçøde5M§ùDìVÏ„qk[‹üU«ğÊûä³nÉÊöS¬.`‰‰Õiù^®L½‹áZQ»_·ı’îĞñuöƒ†¢É»¼À&2¬²suÛ}*²ò&äÍyxÊã%(ç\0â˜!Ş²ÚÛ)2[J¤‘L—“ŠŸFT~šçøà<W¸°·¹”Dº DWònâ{Œ.EÅÃ8Z¯›JÂ4È‘5Fé–©%l•/u«iHIÊbvTPÉÚÒ:ÊÒ#WpnéĞ¢VH
JFãËáIrlÒé¬~Û¼
d¢StNÅ.•3FãG•ûPÂÃXíÒP Y:LêNß­{mÁ6ö|§âĞqÎÙ_\\¤Z¡Ğ©qçVœdëfÓ³Ãß¹FF˜q{˜e9‰¥K,cõ2ä0dÈı	°]Ã*I2’Ÿ%iëV#$ÊrÓBJÒuƒD-¦ºf ¨øi]lê^â¬¦óÊhâ¬çØ€T“3Mtv‰	×­&4Ø²µ}¤€u&ußj‚bÍf®ºWQ-WbKV°:Q£¯]‰%2 6>t]¶z³åÂyƒ–¼_›õ¿Àj8×äŒq“¿öªµæw«:ôÑŞC¦ıÈ«Šá:VŠZ2İ[\"ò„G­j˜íHücûÒıÇ¨¤½B¶\0+Èuš–†î–ƒLm¿º¨È¿j‡­r¡Ú«²ÜizG(Li©õ¥±±[ìX×ßActû\0bZ¸`éZº2ò´İƒ“j:t«O¢¼U/îÆ—IñûZõšt…M¾—û¤Ã`ë1 ×±rJ*“8¶¡O#Î¦]
O«»ıhalœ”ŸGv¾À;ë43î‰‚¿äsq
3Ììf¦:\"N¯G¤¾Ì|>æ/ÂX²I	¹H	‰ €U™åîKğ}[üü|ıÆ¹p­¶~ôYî¯A	[‚A è	óÒ\'Êƒ|‹Ÿâ1H+Øãß|¹Sj!°”@˜@2fwê6¤üBn0ìñ	ÀÜíÿ\0àô·	2KA!GC<Ô=kÇdrmŸEÅ‘/¶³R†\\¤ì•‡•WÚö.{m›ÁÚ>åI&O5çD²5Ğ+–ßıs‡›	p\\)ı½hÖFş –*C¸[0Z›¹SD¦c.Ÿ*sšjÙ?*zt$¹„•_¸äì\0\\¥¶›I-øzô¤6—á\0øĞ`Ÿ]4şiLŒ×ìBÅ7¶‰ƒß¥#=×tùGíLIGk¢\'ã§ì)Š]\'Jw?.rgÊ•“;]ÁáG/hË ·Ò¤âNšÔsä¶xxJãûLm%kBÎƒ–ëC~¡©RqH‡İÚ,Ü•ƒ0\"HåN·ÆŠÊ¹î¶(k½\0™ğåVÕ^ÍíQ3Y2 Òg:sF€ôéIzn_Rõ2Š´µ¸µhä\0æ2_’2ºI#‹<<+pI\'¯ó¥2.ÄFO ¥¢]²J<Dè=7¡M§ÙmF3ì5‡]­&\\ºH¦ÆrE<ş9ª]’l­¯­Ò´)²IÕ:u«ñò5gœŸ‰<rj†÷V6‰`®ê@-ìGXßOŞ­9cœmm”¸åŒªJˆp¾qenõˆe×É%løV¢zÆ‡–âªät©h±äÓ»ıÈìşÁÖí²úB›p:„­­<¼ªŒòNö_àŸ¶†ö}níãÏ…0¤»®PØ\0w¥¼Í«#åÅ=Œ±Ïìn\0R­Ä¨D\0©ıOÃùJ=!¶ÁÌÙ­m¥„¡°XÀòëBò)mƒJË„0şğ)µ°[Sj	‚“¦½h×¸r‡¹+¸ÃP†”‚;Èšç$´ÀŒ+h„cxc]òÊK„FhÛÎ¶ìº¯øö-bZJŞZT¤‚Ii¡§\'R¤+$5vyg¶;d\\yY‰\'E¤DÉ
óï^¿áíğÙóŒâå;*ëæRFpŸT\']Ö¶Ûi[<´\"¯òY]ˆœ/â$İbî\"İ†ĞVÚ•®±\0õÛÊ¼ÿ\0ÄòEQô¯ğæ\\šÛşëd«·~ÌğŒS„WÅ¸K)eä¹ø©m!=âOæ)åU~äeÅ“åÍúYµş#øGäøòò1GH+×º<Ä¤\0wÔi¿óø+ÙÙñ&­w³ƒ¡>-|ı*E­Ÿ ™Üt¦EİèG7º™GVÎ³nzTWØ…÷j Nş»Ğ0õÙµ“\":„VĞQT‘¡õ£ »ìÂO=GZ\"¶ÀRÑê´/¢WäôofÍàG”\'qéâ¼ºù‡´ø|Ê²Åæq5í¾úÕ¿hO‘JDIã<¼ëM#½½´‚NçzÓ3htà†ÀØti+²Äœ”P®¾§áÖƒ ¼{tÃVæ|j”m¡ëpQj®û-%Ê;·ìôë­-M¥¡b<&DÒÇ_»#Ø”—V$è+KF^wriWˆø¢Y’)ãïCK•JægÊ›¡y&c©=Ö’Héò©]‹jû8µWâ®äÑMhˆ¶»B—\'Å49.…mÁf¤ĞÍ«JÄİH+Şy£]jİÙì¿±í’mû:Ä®k.¿z2rÍ\0¬Ÿ1¾Hú÷øM7â¹¥¶CşÒ¸Ç~İ«@¸îb˜Ôë0)ÈŸñ>eÇrmØÍŠ0c»¹K¥À ö´Ö4‘©:ë?âçÄÀø>*NMÓ©deJUŞÌ£ı¿jóÒIv{8Òì”6CN§»•º´F})\\7H±
}è%‡7İ)!Â’â“˜šïF±q,9ßA4¡N4…€JTu;Ó¾Zö=1eaiBs§æJ5‰-!êmô8±Ã­Õj¸JÇæY€®P¿s§))-Ã´Keä©ĞsôÜx½\0¹7i.ì”ëm÷)dx’“¨ò£’Ò !4›åĞİÜh|:{È’µ¦JOAçHpwd|äãÇı†x†´¶•á	“˜ÄyÑp} !—Ù•¿bé³u øÔfÉø*¦5½[àÖ®b$\"`Ä=êd÷H^ÆW6Y1„†¥´O{:Ìóç¥–g7IË¢Oy‚¢âÕçÃ<åÊ1§­D±}ŠñÏRQâVüL†8”)IG—­-®?¹iÇæÇ‘¬.ù	ZH!Zˆ“½1kÜ¯Û¦Ní´¹i.“ª€\0£X¿\\tcØVI9¨èJ;Ùgok:ÃrÛ¬7ªJŒ7ô©PAæ‹šä8~Éç^.4áBFèØ|(¸µô•ÆÕMoğsxÒ‘âd*äô!àèŒİa/´â‘İ¨·
µ#ö¥òmT‚^JÔ„ÚÁÜmHğ¬æb´½¨ï“=ô*‹‚€â—6ê\0HRB¿O$<VÒZmLå®”{G(5±Õ­£Í(H„À¤ç@‡%©t8Ît”ÀÓ]gÊ¦ìK‚Nˆ(ÿ\0|ÚÒJ¤¤ÀÑ=4?Íh£ùÂÈ>6ÓN°g(Jå AĞûZ‹ÕÉıÏ*vç‡©ŒYçVÜ%i§håJõ?küetÊ‚Ù]İ†Ãd­åYƒõ­yÊ£³Íx¸ŞLª+ÜõÙ÷±ÛK¦mñ;æÚ¸uÍFtfÉòòŞ±29JgÖ|,PÁ…Rÿ\0Ùjö±Ù}£\\¶Ó©
û³‹mIjº	&Í)çıD:íQó:éq$e9‰ÛnŸÏZö°wÑùÿ\0,8NP}¦ D™}u¢ëBy_g4Aä(”¨V‚\0Úi‰‚bR	çğ©d¯Èá¿\0‚\'z[ŞÉhÒÓ¦Ğ*P:AÚ|èÓ&Í§@G*_ÜîÜKíƒÔPK¦ìôŸ\0\0ß“#Ù˜ç^\'Ê¿™Ñí|5pD‹—8’ÿ\00ëW¼¤G•%m:\"k‰\'y­$d\\_¹Dbt’+M™]u±ã€€OZBì~¸ÕŠaÄF•P¸]é†­ÆS¬íTdß±§mÛO†|·5Y½—R—tùM-Œ»BŠö	;zĞ.ÆÉ§²=ˆ(÷„yV>ŒlÍİPÁ´Âií•ã~Ú±¥Â³9ÌySãĞœ©§VcÄ·Šèöû3‹m£|ŒÑO¢#B—e3\0(`´¥zhZÚ{š\\ş â—‰9
|\0Æ™Kbd®Uİ_gÆQö/dëˆñ8â.¤ëHĞÿ\04¬O*W=Ÿqÿ\0Aãğ!¿fy÷/Şâ^:xg%ô¡$°:Ÿ9ı¨pRZ<ŸÇs~£Êj=.Apı\'ÃíÚ{”%GSË­byR–Lš8cTË[ºKn”€¨H„Î‰K‡º=5°îê®q7•BBH;Î¦I;,:”wîI’’ëÁeh	3}(Räí²Æ5J¨>À9ITtO‡ÜiõGi:ıÁ×
JÔV¾€À©PoCÖH«K¡Í¶«¶œRÒ¢ÚAÌ5èj~[í£uKa<Üh–ÿ\00Jƒå©§G­vWÉåMíô>Âğ×œÄ•£9HÕ ‚5 oLÇ¹2§‘äAcM{„ßÃmQhÛÎøRQmGPŸJ9à‚\\™—ú™ói2¯â¾,µjmíµ@ğÉô¬¼™•E8pÎ^©7eQ‰X?Š^NE-A–Q¹Hæii·ì[”K„xta6¨JC@ŒÚ˜æM:®ÅÊq¥Ç¢q‡Ú%IBo¼“âB”$o¤Ó”ÔU”g™í·AGm.š·^\\­æĞ…	#Ò)²Ã( !›šå²Åø®P©A
R?1ÔŸäÕ	Â¶lbÉöz 7nğ¹RV)\\	şt¥&’ØrjôL½ûB›mE!^-hyF£”yZlpİõ®>Ë‚êôÌ­\0ÅjâŒ3*÷1süÏ¹>ƒØŸ%˜RZæÀPpsç§ğU©ø¼
Ş?ÄôŞŸ·ä`æ‚VÉøT9ÕIaû¢ìsm´ÆÏáËb2 ÌGv£¶Ÿ_}W–\'ŒU/pÛNgI^~q =gz®¢šÙ£¥Ce4!$Lm$A¨x¹{+[u†Öµ&BiOm¥o£›vÒ@ŸYO¾—ÅÖÅJN{HÓÈNnîƒíhoJàî¨]¶¹X.ê[FSáQ¡ÅÑÉ§îÄ-ÔâÖI
l\0B6!\\êb¯®SiRì„cçehD•sÇ9*zØ©iìó—o¡L7#u¨ed2Zô>Û<oÆ!q´U½›àèÅ¸Ñ‹fòçÊaKÑ!Q9½Ã_q­*\\``|õ]ÓìËg†p…Û4ƒ-°”¶“¡ÏëX1Èí³êß!ä¨Ç¢jç Ã\\jõ÷V‹¦ˆìDRÒ’Ü™mÊ1µÑòÛpg8‹1|9Ñ
µºq¢Z*7¯iâÍeÃ/t|+ã>?é<ì¸ûßû€´ƒÒ®S0í‰)èLhJ%-$$¥JO_Z$C^ç( N´L†Ø¨p õ «&4Ñ…R4Û•Aİô$A*ç4Ã®ŒHÒw¨d1k@Ûp	ñ
},$İ£Ò\\|6	\'QÊ5¯Ÿÿ\0°öş¨/·õ+®+×rAò­¢§“NV¶ˆº½½«E’TGöÀøë5¦ú2êöô9tœ€’ykJ]v•\'ü‡x“<è2ônĞjÜL|jŒ´iBå´Â§À‘uªmšŒ¤ª…“#êM-ªÑÓÑİƒÌòÚ¢=œÛãlŒbñ>êÖÇÑ…är{lfÜ‰$zoOtÊñ¾-Œ®UãÓ¬oN‡Bš}³ĞÓá]²*ú2Í>-Œr×zé²az:º¸ÔÇD:&m½$8¶IúO3K›\\‡F.+Ôp@ïRL™#Ù0M|Uÿ\0ìöv‰»€v5bËgÃ÷DÎ‚¡¹ëëå^sÉŸ,3ï_‡Éøf9%o‰HavSÄ)×|¦’\0’âI“?½Xê4—gÍ¼ŸWíÿ\0Òø+é¢•P‡h×I5ƒ‘r›=/¨¢e„-\"á`ø]pBu•D{QB’Š5á4µQeˆ
	QŒİ?sUè·‰[¦L0…\'ºe˜Î’7>´ÈÅÕ{z|É¢r¾‰D¤r­1Bİ°¸ÚaL·wt§`…I<ªÖ<o••²ÎP·…ıáŞñ%M!\'tê¥5c·l¨ü
»
9†Z±lÕÀ½O´™Ru\'ıêãÇ¤ıÊqò2JN¯ùßbn`é=ÍÎEªV%Dùÿ\0Ú«äÉòôPY¾¨ßìC¸ëµ²K9ĞpzIª9ò¹*÷ƒ
Räº+«kT¡§uRTs)J’k+õÑèã+J˜v ‡x)Î!\'D“ ™fo~ÅLÙ,¹°À9]„¨„Æ•§w»2ŞT¢XÜ1„Z¿âvá-	Ê‘f4Öìóş_—8?LoşX¥£(ÂÁ/4â×ã	ˆ(Aæ?ZvH®*xù§,·U_Ô«8™–NXA3vôó¬ĞO£×aÈÑVZ¥»\\uÔ)0e[…VC>&Ô’¿æI°ïµ É\'T¡ùwl}¥ fz8kiÒµuªà<´çNÁ?—2·“›¯±paüdĞiµÁ\0ù³~›t¯B¼•VÑäŸŒäêÃaö¯T”´•e
j8\'œı*Ã©ôSÆ½NĞÆçyÖó,¨é>¼´ª“ÂÚÙ{‘ºDböÊT¬ ÂO¶5SåYó‡îmcÉ¤}„—ó%&svU!­h´¤øÓcnã3aÌ¹9ˆŠ]^Ø3•:¢å3<œÒ¯Ê	¥jí5ºƒ5rÓn­0e:yEE_©¹J ûÇ’Ãa
ÑDÀ$Í£ÑÔç²7ˆº­Qşm<CIé4\'d©%¶B1Gš*T\\*‚£ßEô*rµµ¢í•¥¿„µep°©-(Æú¦±åç[~’4y‹ÅOŠÃìüÈw¶· w$T¥@.¥oyqåŒó?Ÿ)3Ú|EÂ­a×M_2˜@„˜˜ËÊ¼´åÂGØü>2[{,\\-Å7h‡³()¶³ ƒé×Z–WjÄÊzíìùOÛ{‘Ú)*Q¾t•¹Ìu¯Uğÿ\0V³ãŸâ9_ÄrÚ—=\'ã¬‘å´A¢¦«0F•6FİšØtó®Dû&7Gdm™›AÒ¦¶ìĞƒËáRsfÿ\04Pwµ±Î­ã)Ë¨U+/ĞÂò=!Ã@3Ãƒş™÷z×‹Ê¿Ìv{o<qò+>\'XUãºiàè¡ä¨²6I*\"zïWÌÎZ¢<É9Äì+I™‘Ó=9$‘åJcdÚT…°ÑgŸZ¯ØwÊì=j|@oÈMgLÖ‡}4çõM³UEñ×bÍ£Åµa¨ë³.{•s5Ñì+½KóøŠık[HÂœ½¨dŞ©Q;oVR»c7ÔKºø“OŠT/$®šèİÌå¨ë]:JUfì€* ùòDãOìeÑ=âI}k¡U rnUcÆŒ1Ê)²ÔUÁ;BT«„@%@IØS£Ñ]§î{å”öYj¥ë4TS°H>^êóykæ7GŞğ¹ñğü$TLÜ¶ß²ëH”8ä0Êˆœ³â*1¾ºŸp§«’â|ÏÊ’‡‘É+¿cĞX+Ït¤Àjr‰ÓŸ8Ş±²W\'G¥ñ”vKEÓÖÊmõ[ÃË 
ˆĞ)_ïKq£Jtİ’nS×–áw
N@¢ÚƒX“Ï_¤TI\"æ7$Ët:˜NRF_díR®QÈ‘Ú½âî‰
J|JÉÊŸè÷Ñ)ÂJ[g¼m%dBN¾£ùçV×W?3mño ºï§°¤”fBˆĞdúé÷QÚ)ñY¦Fq(X[­„$i¡üş
©“#^æ–/qRì°¥º·^ï	I2KªĞš¡¿ªô;$î —ò+Ó±¹ØK$´Â¼J™	IÒMï•ŒŒ\'²‹v®Å¶ÃN_)@æİ%JQä\0©Xmì•ÃvV¶İ½ØÛqc·ºÁ®J£5Óy`ÎÊæ+B>/(ú˜¾GŸ,Rÿ\02EûöYökÆÌã8SN‡[}$h°  G­t[Ç©\"ÅG$T±JÓûE¦> [œÌÈ€\'M|½ÕcæîÊòÄš®Â·¼TlD©Qáµ2Ë¡XğzŠïŠø•j—	Q¤ZÊË5f´.©¢¶OÙ5~“tû,øöQ\0è|ê¤ ä¬Ñ†N+Où“‹n4Â®-GqpÙ\'IJÁš™EÕ{„ç6ÈŸñ5«—¶öì;Ş>ãˆNS®³ÌR¾^Ö†<‹Mh°QypÍ“9³@\0fü±=9mW¤ÚFD#Bíbê]ÊCÄ$«q;×BnNÛÙ~4¡Á­–
ù¼a-:à[‰Œ®e‚wĞÇ©­Ük’¦yŒÿ\0åËœV¿¿¸;±môÜ¶…”¤©I³Í&ªä‡iX3¸ñ“_Ïş\0oàå«r‡\\ \'”Ï¡š¡<T©škÊR•ÅlñRd@\"#Z­(ªÒ¥}ûƒ.m‚Â–$~h;ÕjÈÖ—`ÖßæÌV~U	$ìœ›ß>«…:ª[TÁØt5Ë°íE*_8µ¹¸F Îâ¥Ğ‰:W7t•fØYÍ*`íéÜ™PvÁw8“‘AÙÌ3¡<Áë½jøÑ¦`yíËŠÇ±\\ív·‚ªİJeÀøËJÇå\"kg,Ÿ/ìa|6ù)ÕI±~¶¾áE>‡TêŠ3-*ä#­cæñÿ\0Ë´ìú‹åJ9¸8è‹ğõïÂÊZ”ã!MDí\"²¡r3$sWÜùmÛâ.;TâE7!³x½YŞ½ïÃcÇÆŸÿ\0?ÿ\0éåKğWÛùÖ¹äìÀ¨ÿ\0mkˆhÅ+¤G¥Bü’tuoJ‚ØÂ©‡u¸èÑfjWØå£N¢bOìq‚fOX±æ•+dF“•Ôp·$z?%6Ÿõ&u¯5s³Ûøõi¶UœD©ºw^u©R2¼‡.D|Î½FõxÍ’Ÿú€t2ZÒ‘J+v»<™@î˜½Œ’¿«L_¦ç~´NÅ˜vÑ2¡\'áYófœ;¡A¤ïT[5iÒŞ‡	D7¥I¥ª¹º:ÌÑF¬^KkdBşT£µlãÑçsrv†¨@×˜§6&ÈepeÑ­:=
È’tmôèuô©‹¶—¤İ…*4ƒÒ‡ x=˜ø <ôƒ½LZgdVö·ø¦C#ÃëUëeÆ(D+ñV‰`S•êû¯æzû†¯†1ÙZ{ĞCJ³ ªuH\0ê~ç<ˆ8ägİ¾’9¾u¢•Ã¯Òæ/jòR$#2O‰S¼ë´ô÷õ«QM*÷gÌ<‰TÛR´™è®ºqå•8¢VPŠ\'áêk&J#Ñx-ğ\'øÑSvm»2° \"UÚŞÍ„ÒA¹p¶¬°¤|†•/H·J’\'xUòÚOá‚áWæ|¨S¢ìaıL“à÷®]2²ëa²GµÏJl6¶œ#RaŒ?®\0°¡\0ï9T|êÄgÇ±yp¹Å´oâ6Ö²†œRT¡–Ï©ˆY&ÿ\0a0qõM0t«ÇÒ fÑSÊ¨5ÉöZn+Ò>¸m°–Ã¤å#À±¥C‹¥¿àWÂÛ—*!<a÷bÛÍİ!Íà{À…1áæiqW=£R>¬v»EÎcÙş*Åş‹4ã.ÁnÂåS§ …n	ä*Ö„$ºGÏ8m±^Ô.¸oµLqFQoŠ$VR°c|ÜÀøPãE;]‚Ş—ÇÙıÊ#‚¸ûŠ»ÅH·¸]ş¥êÑ$¶Dò?•U£–\"õ-sYx“/éûµá´VÅxS7\\/LÍ/E%\\ô¬Œ˜çÑè°æÅ™r‰ßöımÃx;—2n%„(J”hRœ´2r5Éu½íc´ŞÖ/·Âû•¾¤¢Õ0R‘Õgzµ8á¹+3^\\Ù|¸¯Çd¯„¾ÏxzYF)ÆxİÍÃÊT-–İP;ê
¿n´3Jöü>6=Æ6şì8ç`†¸SÄİZ‰JWß«ºÓª•ÓÊ«z§º/[Æê÷ø,nÍ{8zÒı¼K¸mwRÍªCR•í+åõ ’I!«#•¯ê]¶6Ÿ{i)H*n3&O÷Ş.^â²Ü€µ«¸MĞ)r
U=yK¼r«ƒ\'=2WÃXÿ\0zêZsH™J¢MicÉÒŸÇ¨¹&M”„\\µ–§J‚V’2Ï©õ«’JJ¨ÈŒå¯p*ıÂîTÊIä:í¯¯Z¡–î™­AC“[>Ó[B– Gˆ™5Y©q-)ÅÊÁ7	u¢3(h£¤òş}*«Œ£Û&RRÚ@w_/èBJ·:	ò¤IrDKIy*qA^Òt;óš˜7Ğ¶ë`\\Agk”œÄFÚW8òĞv÷d‰îyN%cDÆºE»ÙO4¸è¥»JÅÛ‹–nZ.\'#iA j#7™4ó­|Ûv;åäâší?ğÿ\0á¾HM»á°S ˜ë# Q×Ê´&Ûƒ£;ÁJTûı¡|‰¿wc÷cpK	iyµ%&ÛËŸûÖ<¦Óãì}Bx”É[ÑÀïÅˆJ‚Ñ™Â ù™2k:¶|‘ç‘3åÿ\0iwfó±§´ñİ8¢ A™QùWÑ<ññàŸØüññì¯?ÄsI}È²¼:DÎ´Ï:º³&H\'A\\JFÀĞé¬×¿cPg×ÎºÂFuHÔWşæä„·Ú+»&¨Àd™ùr©è™›ACA$½‡ø\0\'`»R|ş¶5êG¢ìü6H”×Œ“|ö{lI,JÊŸˆW7NjıëgFG’şàS©ÒjÑBĞ	®ğ†´$RŠŞÅŞÿ\02¢•.=‡%[aÂ\0;‚—•‡‰ò{Y‰XVÕŸ3SWl6Ù%1åÖ¨3V+ŠVÅBcA·JO³›áÿ\0,¡şõ8ş¡Yk…Wõ!·‡ñ¡šÛç3¶İ$6m¤é¨óıi‰„=ØÍÔö@çÎºØ™ıv¶wr@Bd¨avt’IofìÁË1§*éÕ‡µ¤já9\\«ô®Ğ2d<H=Ğğ¤vËIğV\"£X3L¿e²úà,}ñÙ>%jÓ’ëhqB7?\"G¼V?“šûDø\'’ãàeÃÛ]k\0å€t¤¤†ÒTA˜Ô‘é>ñV]%ê<®X¸;zeıÙv&î)dĞBó-ÅLjHõ#áY>D8I´z†ä¸–<ÃbÑ
CEMÛ­()\'bG!ó&©¹o’7Sß>ÁJì;´ €rÎ]}ãÎ¡»µ–•öÃ‚R¨”‰Ú‚·¢Ş6î—D–ŞíæH‚˜0ê¦§º,%Øéü]	a
rË¾ê†yÖŠs›AFIúèyŠ…%yå)× €¼R\'4È”ãL„âèûƒO)Ä6ëçğ’¨
RG8Ú›¦Ìù¾M¤´F1Ş3e»{—ï.R€$\"ÕV¢6$ó“îH•ÏØ¹±+eQÅ¼^ûØêlI‹;¡=ÚŞ$e
<Ó®Óæw§âÅZlì¾d`ŸÆüEk‰álŞ\\¾Ãá”èØ9PìP|C1M>uAÆz0óù0ÉÓ¢9†X;‹ØŞâ®4ûÊ–¶ ‰#7ùR=¯3Ö­ËŒcF*rÉ;÷
9Ã,³l¼&ùJ6©k;ç&d­@x‚Iæ$í®ÕÊW¤NHGİÙÂ{(¿Å±5+†1Ê{¹K+$u\'Q¸~TÙéø¤Ô®.ƒ×]“cXKïcIZòÚÛ6¼áÕ\'ò¨¡ëJŠäÇË3I¤öMxww‡/×`XNE£n!#r•(ë©˜Ü$×NV˜Ü^L¢Ôr±|§Ãq½Ùo8¼Í,(<Ê[:ÿ\0Ô‹I¤Féš¹|‰$œGœCÇÑ­ÑkÜ´Ô”8Lwj\0ë¤‰LÇ ùw-ú—&øG;iÅÖVwIÉvÒ@Wt¹Cˆ%fy	˜`˜˜Š£™W±¿‚Nê^åçÃX’›qiX	&TdIÖ>µ_¿ï\'“Š³Xâíqe6·Ca¾úS\'$fãå	\\z\"kÎ`—ùŸÀd$]u¥Â\\Ñ­,ÑÍ,¬‰¾dR¤%AGO@iG%­9¼wrÄn[‡Ğ”øS:zTÒn˜X­?K»ˆw©tCìcÊªI¶¨²ñ¸SâOçBs‚“\0ÛãIi5ĞP|]¦BÜ[aŒ°H“ÒtªÜB”ÕÚÙ2¢¢µH¡ØmB£LÊÕ$G/¸ø€‚@CÉ\'ìY”n)¢¶â[…>_È²Îd	ÓXÛ^tÈ-í¤ú£Ï<‹-Û„¹§…Jğn\"4äu;ï[˜#Å[Ì”mhÃ¶7_×,ˆpBŸeÖä¥\\›×Å§­:NâÛöã.9a$õÚ=ÿ\0‰İØv}ÂmÚ5p‡ñØKhËÌ‘´|$ùW—v½ŸQÃ’~\\“j¢™ãü]Ù)të°ù`ÂÈÖH?M;>SQ^å¿\'2Ãy¥ş”Ï™w¯—î^tîµLï_G„j)šüŒ¿;,¦ıÆŠI$™‘éMè©w£P9Ië56ÃÑ‘¤jI×A]îAñî®#~ÆàƒúÌTYÎŞÙšN¢kiöm\"$AÒ¸˜¦Î‚vHØÔ~ÄÖöáÄâÌÀç5[Èu¢Î
æ¬¿ÉáÔ§Úğò¯#O#ÖâN0¤T¸¹Írî¤Â«kFNªª>>`ªÒo 1‚#m¦¯ËF~5zb‚¡â7Ó¡àé\'ş¤:ÃR;mÎ••‡Š=Ú°õŠaÀb³ò=˜bşÁ´¤“¯: kª@ê&zPK•}„ïÔE¹™ëE¹ÌÒ…=Ë¸9´ÛÎ¶ày¬±İ¥ÄM¹)\'§1ÖéƒÉ+c7»àyë½:5BdŸ+F®S™›O*èé7Éo³«$ÇXÖ»#\'’v^\0¾\"#}ö÷WGéI7¡â’ZÁ©*Û,½/PŠ¬k#¯*cb\"¹oì[]\\%Û|[ZƒMÜ4QŸØé¯ËÎ²üFÏeğL’„å¸.Y\\¾ÃdwK×N€è?›ĞàŸ8ÛñL+M\"ëìVå Ãm©*9„¨ >£ß­Vò]»/ü?Ñ[/uäîmí’Â’ÓjQqm¤VD‰×`>µ×Üİ¶å­^Ø;i÷{¡2“ $yÔ[ê‚{•>½B’†Ô¼‹hÎ”ÈÕ~Mh]h›XÛ‡\\)Õ$”êR*-\'ÙiÉÆ<hçˆñklÁË»ÅÂ5QÜÔô¥O!NR¾´U˜×hˆmËfÃÉ¼-h*l+ÙBf<P9ÄI£3>Y[“ßõ#Ïö£l‹¶ĞËª»ºh)\"İ™J[Ë¢NÂfbDj*Ä× qÍ9Î3ÄJMÇzåÛ¯Z!ÀĞKª†Ö°ÉNàk ÓİAo¢ÆlÍª½±¦¯1âùÅp¦šwAQËpâ••$7“È¬M\\‡|lÈò#z“Ğ¯ğ=Ïb¶6ví…Y<]»q#*²æ$j4H i¦äš³9ñ¶û)GqÒ$XF{ß>ÅÀ.¦ÂÍË‹F‰)C®(¨%{N³áóU&9ÓW.Ë?¦’|ÂÏáıÏ^%›±‡ÛieNİÚ‡Õ°+VšòHó¢Œ“Ø9qN+Q¶?ìó‡/1Ë†İF/p÷vıÑ:4%%KAˆ$BR9#•^”£I£f›{³¾Ö¸&ûà÷ÚºBŸ->ã(¹>!İ¡¿
ôÔjd‘§Â—Ér·¡ÿ\0\"¢Ôvÿ\0Ø‡©JpKÜQŒ‹·a–Üm-¢œĞâÆ“—Ijò¡Èã&ö;9Æ1l}‰`n0ËÎwnÛw,îÛ*%¦T¥5İ!4$!Æô ê*¿\'ÙvXã/©P:ë@V‡_7•XšíTÙRXu&Q¾ ¦£J/bTwtÂÜ\'Š[cüGsıVá´:´&à;9;¼¥)6ÑC§‹^uG2ofÏ•¥Å­’‹~Ó›°¿{	½ei·BŠ{À°Hoò­
œºz{ê¼±¹zº-¼ôëìNøWJ°w
jûºS‹.ºVÈ‘©€Ç:z´¶‰56Úuø
ÜbÖR‡û•”]°”<œã\"Š‘Èë¾aµFD§mäÀ¯ÙxréV¯wwÛÍJ¤Ï‘_…+’|d¶^–Xå¤?}Œ8ëA.É˜ƒ¯®Ôì™‹bô7iK@JÛÊ¡—Qµ\'“ö,ã¸±µû©=Ù9´*$%­”y5°;î¨™Ê¯Á1ıÎm[RZBÊ•)ºšSÓ¤5ÓJÕ\08¹H´e^\"´Ìôÿ\0zš,ÆiE¦R\\CŠµÜ?n‡\0¸Ê¢‚µe
ı:s«˜¡êßF6yIì¢ïn¿Ä]c=À)Wâ“›¦İtôË[Q¥HòùÛ””—
4õÖ/„Y¶ey.It¨Hõ]=iyÜaH¹áÂYrc‚é;=³ƒpß}p/®Ö«‡×5™	O ?jÂƒJ{>¡Oè?ıµxøáø]®jr-á™Á:ƒ§¼ş•±ğ¼+.^~Èñÿ\0âÏ5øŞÁ¹¿èxµP©×ÜM{.ŠXŠ¡;l(öû!«f½4u$Vöa:ÿ\0›Ò¸ä¨ÏÍ¬m]ûùfrÄ™–¢Á“¦Ä>&¹°’¾ÇYÈØŸ:MĞn×a^`Q¯]>5[È— ±†»EÛ~¾ë@ÌGƒ]u¯0›r¦z‹¨$TØ““p³§µ[X×¤ÉÉ%Êâ2#7BiÖUjİÖ€L“¶Q÷­	l¡½Å^*áÒ†)Ş‡XpÌ&f•—Cq/õ6H0ğJ„÷ÖnC[
i È&ÚtåTM5oh]Ğ1‘âÕ¶6ÄÈKkµ3Ô\'ÈqqÓ²uí+s¯*Úç3/{lïÈ[QK°a!¢ÿ\0ü\'ÔÓÖªn[7vr·  }D6Î#«(\'bLÅFNÂÇ$VJŸMÒ#Ï]œM€F´…VY—K—B(Ñ[sÜmL}—ôÿ\0BÓì]´\\bW¬©i-™#Us:Ö_”¹@õ”W“RûøêÀ1v¢¦¡r• ÷yÕJI#Ô|[Ç…[D«²«ç­ÙnŞİ¤ÿ\0Š…¸°eJË²Aé2uçĞSó¨ìóş¨á«êø‚HqiiP˜1®™ŒÄÌı+&K‰é#T›	q^Éix[D6ZGŞ;²¨+JN¦yC¼ÎÔïØ+NÁ¼óOÜ¶¢îf\0P‘ìÀß^³DãJÙ§ãæ\\ZŠÙoa#¼¶Hm*e::Rz¤‡¹{Ëd´<~ÖÁ»¦pºÓhm¡gPcM‰Ÿ‰¥F*M¶PÏ9§q+[U¢æÁËpê–öÆâáÔ ÃY–A€ñ\0‘$ø†ÕroŒuìgBVÛ3Šxx¡—/®ŞS6ëd:•dxB`\0%zh4GZˆ»}‘9Ü@Na‰â·m¢ÂÚİ¦XIm¦<($¦ÃhÛA­:uhIävÉ}§gö¸½¢Ù»J®D¶Ø\\x”’<÷Ò–¤û]šß\"3i´Xx^„áì¶—=Õ¸i-€}¨óĞ	ò£’”¶ËXüdÖí«œAò-qÇ`JÓ3Ov›mPÕvkãğåõ6±ÄpE¶ò.­²¡ÔÜK{ (û?
opaxwK6·!‹gr„¾í)‘{”rbÈµ,jÇ*ájÕm-ÆƒEeKBÈ\"`Ì
l­ª“°NRÔ˜7ß$4¤Û)„ 4X€1> ZJãv™sôyR¹G`\\{€l1\\ì>ÒñVÅ÷’ëŠl\0§Jd¥%Q m°KÜ¦WŸˆ¤÷¿à•ÛãiÄj›ÌŒ)n ˆôâf•,i•¿OÅ(ÅôR­ğaÃp/¼¥ØÄÛ}õ©+FP¤
’wİR‘ÒMgtßB\'	BélGáÑsxçxnQn³nì€£$’Ú”7üÃ¬Åÿ\0äW7Ô´Hpü2ñ¬E¦­][”!æHPi*(ˆ#Ã¬Æ­É£ZämQeğßáÏ3‰\'Cv8®*«\'Æ’L¢7…)ñ‚’åTUYãJ7¦Nogwcev€Z»vİ¥­9ˆH 6òÒ©gI=vYñr¾Ÿ_íø?hV–Ò\\#Úr\"ëJÛZf¶<µz×ØíßAQP#UL×n»»v\0ÄÛ#\"³‘í$Å^â¥¶pÅ»Öv®÷È.eZ’#éô ã°cRj™ŞNîİN÷yÄĞÉÒ”¢îÃrÙãaª!Ò•«T\'¨ïEW¡Ÿ1=Ñæ®3½meçr¬ÈP*ŞN¾ú¿‹MS2|‡o‹Z)ìgZïÀJİDå âÊ åÏÏß[QŠ’¦y|ù\\\'´Y?gÌ	x¶>İÛ¨k8Jà„£m‡œÖ\'ÄrÂ-b÷=‡À¼YI?&Jşß·àö%Ó#
ÂÒ¨+VX%&»¡ŠÅ\\¹zOyr¿cçßÚ£ˆŒv„ò%*C-¥)2diÓ•{ƒÆ°¹}Ï‹³<g±H)E$‰ø×¡£À»èãÌ€#áDG¶)\'¡×Ê¥LÜ’˜VuŠˆı‘³ì‘#JîÈºTÎd
Éf‰ëé\\OåÍÌÌúÔvNÖÅRâ€Ôïò¡kìJïa¾t¹Š7:AkÎ©yQ¨hµ‚o6\\xÓÙp„$2óå^m%ÈõRkå¢ª½PSçc©Ş¶¡ô˜3mÈ@øQîÔÑû€ê(Î†y‚´$gÆ‘·²Lò¨UÑÒÛ±í†ÜıôŒƒ1µ}¬\'>“éYù:5p6úmÀ_ëTkF²j´…’¬£SÒ†¬6ÒĞÓWà9mMÂ¶+Èk‹Ñ¸~u±Íd©3†¼M“åÊ¦ZdÅEí44QËpw\'¨ÔS×BäÒ•#«¡ Ì£¾ñµD{£vš\'mg¥DÎÆ’vkE]OĞQ¤ªcÇ4HÖ^%¹Iq¡õËğ´ÖWŠŞƒ˜6ïâM_1ş#\\‰0Aäj³\\´Í,95’ÅµŒñ&ÆØSW(u?{îüL)a%*ç¹“îª?\"X_V¾ç°—Ä°ùØk•?{ömnö¡¥dîœ)BÆ¨uçAHÍ5²·……IÉ/cÑ|Äa–]uõ§:İïBNX6-d“çTr&ê¼i¥VXVö×WØkÈCŒ½}t¥{m—3ƒáJ\0ò\0‘ï¤Óà’AÉÆ¿b?Ù–®¯Ñ|Ë‰vÙÒ„²­„\"5ıê%T˜XT»^åáÃš&å
ek%0o”ĞAv‹m¤âÊ—8;×ï®ÛîÉM²}Ë…‰}ÃBP‘!;3¤s“KMA8²%5$•ö¼ÀÑ…ğÃV¶4œrù¤°ãÎA2¥FùS>¤ÑI©mì¦ıŠÑ[qUŞ\".Û–7WxcY3)ÌÊJòû\'/!±ÏßVq´ûg,n¯Æ;_³À/’¦­^¶q)Ê¥8ÑB@è\'”ÏÔÕ¸øòŸ½¢cäcƒÿ\01qØv¬q€Ü]„$‰	Iëıé’ñÜ}L>V7´ì=„q²TâÃÎ­TJ27JL±ÊÍlyàö‘&cŠ­Üm	Mâ`ªec);u ”Z]tlâÍ
Øôñ-$!Ô¸¤N©P1ëñ®·VYÇÂÛYñuÈjp´´(8’•sûÑó®ƒxã-´§Œ.Z‹Ï)Ruë;ıI¨—©Úc#Æ¢î×ˆB¼ÎæJÌå*ö¤ngJ†«³¤“ìÓü`pÅ6ú a*6çJ]áJåC¼?´Û»gÔ³%	•\"şµÎ
]<Œ8^4ºâœUã¸ÛÙ™KÈVqÒ•¬Í-àãÓ1Ò{8â6¬qÀÅëµ­¼©+*…dÎ¼µ>óKqqìÍœ#ìK…n¿£\\^»l†îÒÓ´mÂÿ\0!Ì¼ÌŸuKµÙ—’*]./)ãKë5OSM÷W*mD)Hˆ}é&9é½YÇ“„}%åS/Ş\0)âN²MÒİÜ¶mÆÑIÔÉ1±;ÏªsõÚfŒ\'ÂœVÉ[]5‡º—\\/0V{‡Ta}ßú‡]ÏÃj^;Q¦h7×ßì:um³lT¨äûªm{³¤Ÿ\'-ıšÜiKB»·¡Ç‹]wò }ˆnWBeû€ï.¤g,‘C¬P¶Ûâ&*6äöˆÏñ§ô[fÛºB-ÔuˆP:fL™0cMâzQÂî‡ñå»Ñ[ñ¿³‹a[:RRã0
IJ£´ôÿ\00?±£áÅ‹É*…¢’â{•’À\\eÈé)”É0cÔyü*Ô_¦gænIh¬qËüiŒ/:T¢%#UÔ@˜5¢³¨ÂıÌ¼~òrğ½¼ì£‚]àµZ’¢eIZyµäü˜O.O™.Ï¬øÇ‡ñáÒEŒq}‡¬8P‚”Â€öc­\'{EøÖ4÷üÏ›=­âéÆx÷ºl‚ú‚HÔ@é­}áØş_~{ÿ\0yÉóòN/VAcHå<…kg}#bt³]`]éhä™LNÕ#äÍgoxÀ›\0m:â/ìf_§p6s3Ë_:àºèÍF±&¸ë³`˜ù×‚ÁV(“Ó¯=j—¨<wşb-Î!1†%:ˆOé^väzœŸE}Ô÷‡N{ÖÌz0›í4&àNjcØ>- 31–v*ôŠKğv±˜äj÷ÙZ,£2D	ª¹&®‹¸pMî!6ÌÀyíUdã#B0–7µa\\®eIÖj»Šö.ÆmöşüAÕAò×Üç9ïîÔã$E7)ˆË)ñÚşDzè,™%5¥
22)ûœ¶ RÕ²1ÒCjqï™ĞÓy$…J¥+Š;½mIH„:EDƒ‘4“F­„ èzj*eØ8ÕôÎ›^g‰>^êµ £%ÊÅŞQ\"—X›·bN`Gı4Ö*)7¡Ãî\0Ë¥*+î3,©×CfŸ-<>ÏJ³ÆÑEÊË§³na)|6¥Hm óV¿­`yQNuì{_…ÍÆ.Ùé®Îğ¦/íšG|µ5h„¸”óO]+3*×$zlM:²×mÅÚâøoİ-·k.>ÿ\0p•¸©IRIË\'MÁŠŒj1wc2§–Dƒpï8¾ĞqK[d\'»yå¤÷Ä©E`ña#SÎŠ0NL|£‘A—çÜ¦Æï+Îw¡	ÏÔµı<©qiK}šY-Æ—¸ßŠì.1å?ŠÜ0··\\[¶N™“¨Q×S$ü¢*œã)?šô…ò„Çl®­pÿ\0ëww¬¸´„\'U+)ğ$À€0!#–¤Ğ·{^Á\'ÇmŒğºîn[~âÌfl~r3$u:oñ®ç%+~æ†)ÅD¬øÇ³ê/—nÿ\0î– «˜²¸­2ÌÔs*’²4®6nå¸\"Ûùµ;ç9jÆãñ±AªAp%6P„ @
O/8øTÆVêÍ¼KØ•aH¹`)Æ’êÊ3\0I;úÓ¿,³\\XãáæÊ3$¢W(‚¯…-ÊLµP–´ÁÎp»j
(C­|Y@?½C›XñKØ^ËƒíVµ(Ú8  +1TOÒ‰I-‚¡Š
¨(8#ºm!ËE¶œ°V§PJIl*OîâÏ°”%,•¥YI•«ã½%NIİÅâãÉõ #ÀÉ·R~2ø›+1A©YÜw\"¤şÂTGx›q|<e·º*Íì÷ƒ0ÛJ°³Eí£\'‹–)¸0fÂœOpËa¼Uï	
e¨¨k¡‰ƒ×ÒYq3^6vš“HŸğwbø²oº¿XiØ.¨i—=ùÅSÉ•U$U~/S–ÂX×ZàW÷‹Jß}õ²¦íûÂT¦Ô¤™ÌcAÎH)ßÜÎr—M\'eÖøa…Zb×,‡„6„!²˜:IÔ“ô¡œœ§¡Ñ\\V¶ËFá«æ[mZJT“ åüó©Ô^‹XâÜy7±­å©y-†ÒPD…w¨Júä§lqeûöÖ.Õ°·rVƒº=¨ó\0ÏœE¾ÖW{k`l#‰ÅŸi‘j¶”‚µ¹r¤vO…@qT*±Š<ßğq®owb»k±ì¤-ÍJyè|´\"¢4ØøÓE?ŒŒ1ü)îé(JmÇsŞ%>%räŸŞœ¯—{ıÊù%é©h¨8Šé¢ÓÍ!j!RC«HCmùyÕÈ7ƒ*N*/ƒşl	À|W„pç—±”–a9^d‰Ÿ0ÿ\0z½“Ç” ”
~ÅqxÙZÏjÿ\0Š=qÛç8ÀYÇY †&AóTeáä¯¤öğø÷Ã¡şj¿âRı³ı¤Æ,—†pË®xÓ•Ë¸)s	š·ã|9)sÈ«ğyO‹ÿ\0‰T ğø›¿ú<Ü¦Vµ-JÔ¨êNç­z>It|Ö\\¤íìlõŠÜLsLAn-”\0ÏJjØ¶ÙÆ³¹•$«–ÍDÈ×JŸÉÖÍ”ók€[2 jLUÓîNÿ\0 ‘€ÉĞÔu\0×zƒ“²IÀÉÏŠuPó>‚ßŒ½e£ÅKËa”i	ƒX—ªÙéò7Ç²·u9Öc*×èÅ•]5bW ¡QGl	4–Àl‚æ\0«ì¢«÷`f¸ûRå¨†“”é²cbÒPÀĞzV&FÜWãbŒac¼©ÊN]Ê“lµ×{³ie\'—ÃClŸ—ít@¨äÉùqûû«D˜Ş£œ‚PSØa§]îÀĞéµ_Å)%lÉÏ2—F¸e*@1sÒùLèx
“g……fx ~[z‡¤Å^áT=\'¼ĞGËq^_lá¾	#Ãğ¢~k`Gái˜•È‘ÔT~¸%ğ´ûb,¦*cÎËäÊÙ~”m>ˆÚå—J4Ó­EêV`M8Jİ×‡œté±äíñgVÁ]â4
3ìš9SD%rVZü=‹³mƒ°R´ŸÄ7W§ĞùWŸÉJV{-cŠ•özo³N#M½‹Í¸”9˜ÂR4ÌH\0å·ÃİY¹bºG¥Ã.}Kxƒîàw—w_†BšhV§³–æÂj¿ì·)Æi¾fË¹UËWÍ©×YiPTµ•ê³\'R&NÜêÓO1N+\'&´^\\-‰ç¸R.ÅXIp(@R²ü¶¤(íşKO<?Ò9â|V÷Ã…²¥ıØ¾mĞÓH2R#1+çá¹ É)J¡ì#¾o¶4Çğ†-ï‹;¢†ZRZ*BeJ\\Äé¸\0]IÒ)	èŸæ®HVîÔ±nÁt%2Rú³/^§™ •=šÇÉUÿ\0 C¶ÈºQ9AÈHÌt¥?b\\^=1á,­Ü¥	%BŠrWĞÕ–Q!jÓê(×YR£h4Ëk¢ÒòÔô9c‡ìÒÈJnƒjBŠÆa±™ŞŸÜvËĞóe{¡Ó8eÚïËKA2I;ƒı¹Ñ&şåŸÕaqªi‡‚²·İ¶l\'!Ke@×Iá­=Ew\"¤¼´ª0f®“†9jæg±PT¤cM}ò£D¸Éh\\gŸ—¥9/ïÿ\0\0+ámn\\··u¢&F²GéUò%HÚÅ9J*R‹_Ğh8uÛ´2k8JLNºT©¾‚—š±¶¢ÆîpÀ^T\0&LM¾È~|©=‰=ÁM½¸ZÜÓo:[[²„üÊocì…X²p†›@NÄ«s­*NÙŸ“Èr%WV¨µ±ZZFu§R’5\"b¡¿c:W7d[ğS‡âøF(âÊÔÁë,á¹+\"‘§Ôqå””y^ÃøWİqxs!ÀÅê‹>Ñî”Ô+3J\0ê5\0k¬ü(¡	I¥÷ş„C\"Æ›}¯bjí¹cB{Âû¶åM©é™2tØHòëOj—å{œ¦­Ö“ö\"¸§ÿ\0Nmo¬„¶Êw\'ÛY=Ày¤îÿ\0c§ODÆß¼¼SëQBRC™c*R´¶Äk­z°áÉPı|B‚ëî­ÃšÑÄgLÒ•xp(®ŠUÕŒ%Ğˆq—/-EÔ¥Å€©€¤ O_Ú¹(ÙËè¥xI³·¿iKNe(ø¥eYFS=DõåÎ<ŒŒ¯nŠKˆV\\fáÂR¤,È)sd{çhÆ.×ÜÇÍ‘U–\"§ÜZ’*ƒ€ƒ5µÜòy>dí¤3C/ş
£m©¼£÷)ü¼½4aïR5iSéüò¨ô¿sšœ^Ñ€©z”9i]ItÉNK³—£!ØiR¬\\›º¢¥´æ*êT*÷bf@ñ<¹TşÄ¤ˆÔÈå5}ıö-às3¥’gr$iÜ‰ªİÜHl”È#Ò)‹`É;èL@:l>tDwÙ±øò®z:™+à&Á¿ıU›æ7ÇEÏTöX\\`¿ùp#@<Q5‹‰îèô½0K²Í™Zst×ZÒWf¥NÇo$š£ÅÓØ2“ª‰kiĞGZºÅÂI.#‹4p™ÚiS~‘¸âœº&–é„Ì|+NäzÌJ º#Åô¥½-·¡I éB_š:\"NšĞ‘ÆİšQÿ\0VSDsÕ€œQˆıêúúY/óÉn˜ÖÍ¼r×¤/fÀuÉ5VM§¢ÂêÅµ	AÍÏ­?¸Ş)®ô\"¶–Æâ=h“R›FÒêçSó¨qDIÉöÆ8ÂæÕZºÓğ¯QSÈ’ã²²¾pıéc_uz¬kÒäI©4ÆrG¦Õi~Jv¾ÇiĞtm]íG%÷ğÍúY¿i/8¤·Ÿ1PGó\'J«—%¤^ÁšV“z=)Ùæ?lò»*Rd¥)J„¨ÆÇ¬	¯9—¢ı(÷^>u4¶[¶÷+¾°½¼½GyŞ¨¢ÚĞ*FRtŸ}|êë‰±›äÆÅ¦85V·8i×šh„¥¨Cl#RàIæ¨S¼¨Ó“Ò5\'/ïùø?½¸»¼Çn¦%+·iJ„ê#©L”ôßrf‰>+¹8âœ\\‹“ÅZ¸À®\\d¡’ã%aCU\0AñÌHQŸ*T­\'Bù\\•°w:ö#‡2ıÉC…æC¬FÁZzf|ê´âÓ/ã’‹Ó$X“Fá
%9@=irvËñ’‹¸‚Áµ},r€˜¢…-7Ís¦Ü=İePjL)}§:´­½™òr_È¥ßX>ãËm?pNe-j ’\'çıı)¯BùÚ¥Ø+âLªµ÷vÙ;×]F©A´õ«„^Ø6XFÓ\"˜§Ù\'şd]¸Ò\'ğÒTy\'Î˜±{¡üŒá%NĞ»\\dòVÓ	}ŞõEI-¨I$ïAšî´ôh/9Ç¸Øµ¾;†İÙ<ıÅÃƒ H-âLÆ¤tÖ—òT˜ÌËéAşci¼¦éÄ¢…#`	#Ï@h~BJäÇdøæ\\º¢ÀÂŞ±}†ŠW9¢
´å?1õ¡¨Æ’)<Ù%Ø«˜pÌæëZ%¾´™Gv9fû-›w§)¡Š­*írn˜ÚÕiUÂ\\#*‡„\0®öYP¥L5ofóï#Æ´B·¨­\'Åë`Ş9Ãp¥8¦Qİ¯+.¼wB\'Ry¨y
l—¹›ú¸İ…\\}vŠ²cD[­Å/\\Ù e™Õ |ªÜN¤Sr{kû`Ü{8~\"êT
*x%ã”È÷™øĞI´ú4SÜa÷¸” Ù…•l©ÊV¤ÀqDù9ƒSË¤NI|·Å™Ã7L_\\\\\\%^[mwn+ed ÿ\0ÑTJ.ö2985]œ`Ø‚şïŒ€Ög	C¹>6ÈQ ÔÀBœéY:¤‹
<åÊ@^!Ånï,oÑ¦2(”º@V„	ÿ\0«áS#‹ƒ¢–Çñ6î>ôá|£¼^u&=‚S©°*ÒÇ/±‰7´@ø{µã1nÂúèÚÚnU\0‚¯Ê5ëæk[%(ë³Ìù¾OZèô—ı˜ø[)JYS¯i«
º˜Ç¡¥ËE«)Çâœ{\'6?eÁ®ìÚÓY•-ãŸ³+ÏÍŒÑâO±Ö‰8¥3n¦ÿ\0Ô•oî¨rÉ!ØüØ-´Š{µÿ\0³\\€=xÑQ	LÂªÇ–R•H¯åùÌª1<¨îB2ü«^¶P¶×@Wâ+³W—Eyº±5#Ÿ•J³–¶mŸ(5ëü$dühï³´«R™Ò¢€»¹Oœè¢L¦ÆªĞ”Ğ-¾Í£_Ş¹°ªÉŸouŞ$VG˜©¼gN‰—9 \'¬
ÍÂ­›çÆ »p¨$t­X­Û\0bŸˆôN“RÒAÕû‘¦}D«rÚĞëñ\\Tœšˆì*.uTM-À â°åÛ=f7I\'ÈRÛ,ß¸ ÛA·:Ómhßê€RG3Rƒtº#÷+ÿ\0ŸH\'ûÖ”~ƒÏäæo¢HÀ*	ç´‰¬ÉhÙ„m&ÄTíµ˜SI×õ¥b©Kggr„}g†âÏ¡ä·ªuÚ¬dÃ¬£‡<ùS$Ï÷­¤‘
è+2*¥£{škC-›0‹v½xõÊ[¶X1&­à‹rL£ääP‹EovàSê:Iµê1­,Û{BI\0ùéMèEWìd@#®¾u=ƒ$ı‡6w=Ë›\'ßC(Ş†FU´‹W³\\a¶®fò”r¤Dˆù}|«\'ÈÆÔnô¿ÍÅğ‘èÎÆUup-İ)Si*Ê°vZ´’êÇ’Miìõ±š’MXQû%]á†sû‡X(
q`‚éQVP\0Ğô¥E6¯ì7”d®#Ë«œCÀ,°¤…[MÃM<ò’l¥;€9ŒÀ8=je%9&ÀxîwwÀE­¬ª÷îbß*Ì%cb¯ˆO 1 ¥©;m=0£©2G„ÜZà·øU‚’hË}È…åÍ\0$Æ…DéäEWœ®F„a\'$öNn]JÚmgñ3ó=)/]³±Ë–€Øå©[
vÜä#U&G:Šãô–#:u.‡vv‰}•œİIØÇ­:?a9ğÆ0ubXójTK*m¦’!9Æ\"šŞ•¸Å5JÏ?b|#}ãi¶a‹’Ë®–[P<ĞûäÉ<é¸¦¸ö:x­\\‡-öo‹ZbxBï†0û‡ÂdâÛi+\0kdåØjUVc“›õ\"“ñ£MEík»iÇö7láOİY?lïq˜äRW
H$k:së&…8í?à.P”ª½» Ø2.°ûÛ+‹täëeıSE9’áŞ=’®´|š…±˜ğ·4‰v€:Ö†-‹’«Wk2Ñí4¢é
VİG0*·Í›ú–‹’Áå]–Gá0Ã8f*úUpCeæüYLé;Hó¤OÖÚ–˜IqWjèVfÑ.©ĞRNq¯¿ÊºœVÈ‚æİ*İ4`Si ŒoUdÕR.ãTíìS	B.‚]leP™úÒÒÕ¢ÎK†®ÃÖ®3 ~SŠ8ÜŠy*	4C1Ş7´oˆY±ÅíÃ­–BB‰Ôfß¦‘¿Æ™æëª)NåØÓ‹8µMñÖ…\\­mÜ—%:eSa*ÑF\"B²R*ËM·bqã\\U{€¯.C‹îİej{(ÈÙ$!*H
W“íIjá²Äf¡*´@»EÀ¦í»w·Sv+¸ûÃcU”@OÀ‚?¹§cô>„f\\×şHç\0]¸ÃD<ê“wn¾ùHH9FB€ysj¦æªôŠÇÆVZ¸ş	ilû·-[‚—T]p¤ê&?’*‹[³JuOØ§x¡W‡¼i·ÔŞ%÷HPÑ	>›üi°*e’İÏb‰_@B3¥
)\0iÄŠÑ„Zª[0óMAl„áx½Æta.f:÷Œ’Q·óÒ¶ñGŠIöx¯*\\¤İhõ÷ØÏˆâ,eÆîS¹ \'ZO“\'¤ŒÄŸ¹íá…3œ•$E%­†•ömXcKAÊ™T¶|JíOÃİÿ\0g¸‚€ö[QAÆj…¿cäÕÚä•F¶zåhr?Q®ºI«±èJv­‰èéE²-Ù´€|„É¨&ôw˜!&Lô¨«%:ÑÁtvƒÈÑ$GZ1N÷‚tu¨Q¢y4r7™©\"ïfç]Çjâ:vL¸C¿LFü«+Ë[Ù¡ãIY#â‹d’4ßßTp«fgjĞÑ›¤.Ü$˜?­i¨ªUÑ+NÀw¤*ãC¥±´ÒM‘¦R UÉ	€ór\0ŞcQ­\'7ÒXÁêÈMXÑ\0Æõ….Ï_>”˜á\0Ö”ÇWµó{ÎõT¾Æl\0ùòÇ--	\\8Buä9QÅlM¸Ùqà¬Hk®ûÖªc<ìò^T‰~’áF³Ö±rº³Ğb·ø%Ví±pÒÓ3ï¬æä­£AEKÓ!upã(QZ@Ó˜?©oLãÇºbIt$l:íŒJ£cB°„¨’ u¦U¥*¶ˆOâ™Ü(A&z
İñ1{³ÊüC+oŠdUrU¬ÙtyÉ/¹„h6:k¥hrèÃ©\0è<ªV³iTj	•Õ`«]ÅÍ †Ğ¢¾ğ-JÛÙ’	ôÔÕ<øù#GÆÉKkeçÂ<lòXR‰/-y–Rc\\Ó¦¼üüëX«ØöxüŸJ¾ËW‡ñ|ØÅ¢V”½}x°‰$e\'Ä\'ù*³…—>d“M+²…®Ö÷[·.r8£nSáR¢§5äó3ÈUI$Í¦¶í‰Sıu!Û€¢¦­ÒNh	0<€£ç–b)sH¥–M\'!^ã+Å:Û×ÙJ…-$ ’W²R	$ëî£ÉÅ‘³”iİ†\'ix†Í»¿zIY
-(¨n¢¿çT§Óf„’O ³ã»ia@û6Rºì´Ÿ-Q«wn)
öJ¥Y~U+°Ú¾‚í)„\0…¸B\\0€¨kÊšSÓö@(±¶jäBCi1ß<€?ğÇ®äúQ:Olœrçõ\0-ƒWX­Ó÷0İ«m†¬í2Èe)ñg:FüùÌš%’/Z:ppJŸî¹ÿ\0ˆš}¥­ˆ½qn¬¼{”0Ü¢\0Ñ!3°Ÿy¦Ætí¡N4œbô;³á{KEXã%IÄîí¬Ô—Ö”’p­KNäíx÷ÑNMº}ÅW¿¾¿è”pşŞ+l•2Ú™¶}„–Â “˜(Í%:ù¯mª‘¸¾O¿öÿ\0Ù)2Q‰¶¢ÚCgÂ|HPÒ@½İ+¸Û\\Y×u,¨¼ø…’‰×/!à>¦ÓQqWnåİÓ«Î¤f!´¶ßZ¦îö_ä”T0†ìœ‚Ú€ÜlOÓØ.NK[º¿ysª±Å N_#<Á?ÁSmòÊŞÊ±ü&Ë±,?¸Ş/†¼¦;²JB»¼¹•3*\"dzŸZ¼ïŠâû3•siûİã-âİ¥?t†ÿ\0a¦ud¬Î9	€¨*ÑqbÒC,s¸°ÆoÒPÓ`%M¬m”¥ZŸ)€O#½rVvLj;[^/Àğ;îñn\\_Û;lÚ
cÆ¨ZDt%*£ä™SZÕ,†¯*EªYPaìáJ’\\Œ°O IgJCV^¥TÃx4ë8KŸ†¶›KiIWEzîÖi~û­Òè¦øóˆÕ„#S«ï†nå1Y)ø+Ò­âÇËØÊÏ>6¤W|!Á¸¯hü`›&ìn¶Ë(.ÊÔ‰lÌª	“ËZÓŒx~ç’ó¼—%Æ\'²0°ÿ\0}ÊÕä´§s -I}\'r5Ğê’‘åVW?¹æ®O¶Yı‘ö„vitê¬,Úd©S™\"+ƒrç ’}(´‚dÓtu!Fl‚DŸÒ\'öl­{yÁSÀ8¢JAün<ªGÅZû‡Å>Ï‹8í¿İ±{Ö£Øyiã^ƒN)ÙÜ+Øı‰ZÉ‰Ö¬Ç\'°§Ø‚°ç?Í=ôÏ˜ˆŒZWBFÙ`I>T|<}ÙÂÙt)3¾Õ*H†©Rt<ÈÚ‹^À´ûBzl&ˆš0O•wìw]˜$Aøu¨‘1à2C ™ÜšÍò©š-\'°Ç;Sç©ª˜õ¢öM­\0Cêl˜Å>Š•ï7\\Ìà$êRƒ}Ğ!4çW_bô¤ÿ\0I73	×Z¯™úK>*j_bdÆ‰ÓC½aË³×A.#€cy´±Ú­\'x PÎUfƒjH÷^¹•\'÷š~5l­N1z\"Í,¯“¨óëZÍV3Ì_,½&Çz@>úóyåN_‚-¥HaÌ}ªH*¥\'é.(µÚa«¥DiÊªUÓ\"×qÛ‚B	Üû?¥hE¤»:W{I¡+›–ÆT¶©èÔQÉöÄÎ.KHã|;r—²Ó†ÒkĞ`òaUg•òü,®WOşÀjÃŞJaL8`xµ ²ÅôÌi`È·Âµ}˜*l ¨@ùÔ©Æ]12Ã–’9F±˜‰çM¶È½hÜˆ>µÛZ\\w.;Î‚[]’‹L›ğ‡-:•,%¢™Ì­aS ôª1êıÍ=¾©¦Ä$áwL§šüó2-DóÎ\'jÌ¯SLôxrI¥÷,‹~\"A¹[N)KbØ–Šæv#1>áÌó5MÃ¹]ë%Ul‹q+ssd”\\!æ¶uN\\:ÙB¼Z«\"Fº“&6¶ŒÇO¦TË7\'´8Ã±«LmüMÇs0mk‡—h~`§NêV£Ã·Q¥Y”9ì¡óT%Æ%ûÙmõÍÍ£N¨.ÖÙõ«»B›yœÜçSĞh9ÍÊ©èÜÂù­–Ú²´+9\0A¿ÁT›öEü}&#“ğg8oQÔ‘B›§Ğ%Ì[î¸Í²!÷V®ñÅ¬ÓiHz\0#:~£¥âèlıÅ­î)sx´©ÛÑ™Hl ©)Txf}ñPÕ>AÆEGØ‚àW.”+q¶TòBŞ+\\•‡H‰zT©¶ê¨œ0^‡l°Ë‹Îîné\0õaMşbR5“$şÕg›ûşå$£-\0ÃÛ¶[—v©qëd]<
Z²´ÚJ²ˆÜ$rUÔä©]£FPUVN¬q»K×p§lĞÒl¥§
mÓ®AÊ	ûºÔ§Õt/‹õEö:gKÆ }EÂ™hR¡¬•JIÛı€à”bÒ	¶ÊÃyÖJ³	O_í@Û	Ê2–†·8{÷a°d	•k:ÒZaFkckÖıÃ}â
%$G”Ÿ…!+#KÒ@»LÆÿ\0á{F\\¶y%Oº”*Ü¨$©r4OHÍtf8[´Ww%Î_À€;‰—x{Åğ·
op«›†rÂsœÈ^Šöe)\0ƒÊ	ØÍ„šbÜ­UZ´Wà«½—®[qõaèIïBLt&4·¥¥ê·ÑbyÜ´»qKO÷jı´ºÕÍ [o:’¤æ )I)½wŠ™wùq»ĞVå¦oÙmÕ8€öqŞÀ#Ä ”¨‘\0Ú£‹¥ExE&ù<I£#®o½—]R‘ªœ
V‰é^uÓ+C ôùmñWÛ­[¸Ø7:¢´ì¥#BÂ¢n›+dÊ¢øwãYWIw+½òŸZ–’­r\'xä4­LQklóşfd×ì÷ÇØë³l;ƒx:Ù‹ÛEŒFäæºumøP!hJT4„ŸTwÍ¦”øqœ­74›£ÕeVçIAÒ­ÖÊµcaİw¤‚´Š‡_cM<”“â1hv*—Û?œOJD÷°£ø!ı¬3÷ÄR\02Ê¾•Ÿš¸ì°›½8İ‚ÇcÀ\\¬mç[˜ZàƒvŞØÚÛûÃ`É´¥O7[†/˜G-ÄxQUŸ—Oh¿×½Ç>Ãjp­$DDScæ©j„ËáóW$ÀŠ¶JRS´Š¸¤Ú»3Ü\"*Õ¢4D²Hï—¤ î…ìó4Å•¡2Ã¦À×,w+ “5v2åÑMÅÇBGÃ¨ÖhĞ+dÃ‚†H&@¬¿)«ÙÆ‹í±çB‚g\"‚şF´˜:¬Sº*ÑÂÈ.oRˆ×ÜŞ‰\'HèjÛ*Gi„0oñåñªùúÙgÆ®vL9R’ O>µˆöÏY
qLXf	Ò\0‰ ™¼úÏÊºˆr­4ÚPÿ\0/Ci7 Ë[$!ĞŸHªo,“ô–¾T%¡İ·Ø­ĞàÉ>d
T¼ì‰Qß Ã))$Ií0›+4¢H«6yrMÛ4Ö%Hx‹6[Y[d(úë@äÚVŠ»\\0´À$iúS!Ö…NU-®ÇØe›ÍÊÔ[_JFIÍ?Iw!%ÇÜqrX´RR‡´ÉØjrĞn»
Y‹;ÆB–ËB4ÌÕi9C¢ÂùyÆöÜ3‡ßcHïmHg,úQ¿#$!¦
ñpÎWV\'ÛW	`ğô[2;À‰¦Ôï…yY¿Q¶#â&)az<¦û}Ó‹JLj+ê1v“GÇr%´6S¤ÇÒ›T.ïØé·D:æ‰N˜úÑÂÚ‘•FÇÏİI}ìb®Ó,®
ã$ÙªÚÊä)Y*ÔÄ¤€$ÏOĞU<¸Ô·cÆòåÆ[.^ÏqîıĞôŒ‚Kªu@\'
A:¬«2x¸›x³òöã·\"öä-`›ku8÷vÙ…*D%*Yóƒ¦Â‘÷-d|µe|Ói¹ÄÚÎâX/©«®ıb3W\\ $µÖ7«Ô{)Ê´Ò£Ñ}™qjnßSl\\­ö¬Ä[¥Ä¥0%kÄêj–DÚ³CÇ–]Æ7‰[7bÅÊÙqûÓE\0$6˜“v\0&u5EC“èÙ$æ†Xß³†<–ÜJScn’µÜÌ@€Ÿ2IyÔ¿[è|¦ì±Åè¼Ä—tëë=ÚÄ!”¥E3Ã÷¡âãÑ\"wÄğ‹+ÛÌUÆ™Å^KòmÚ#À&œ JŒÎä\'Öºä•$‹PÉÛè·xzÆıÄŞ8T·e)C	|‚:g9‡)éÈQãŒ¥oÜÒŠI.‡VXö!jÚØK=òÒ°ÚoğÎù7t‘Ë×İVãqÛ_ÇîTãÉ&õöÿ\0›âxêÄBØfİ)	Cwhü$÷‘*D‘ì‰é3Ûô¢ÄqÆ	nÓö!¶××ˆöÇ~MÛ.#Lª0#.YIù¤i*ª,Õ;»]ÿ\0ˆˆ†lÔÓˆq$ªá eÂÔÇC¯u.ùmö:P¥e…ºÏtòó½i(¹Ì‰­1+ü™í¶ı({}|^iÇYRa>$Ék»zèM×¥öG/x–İ-Â¥*U˜ğë&‰c¿qM¤ªE-Ú¯7Äø^\'gvÑaÔ^!i:-j€´ùINı&›Êı>ß`ŞHCZ`\\ÒÖÿ\0aœßş=â_Z|­.¬•¥Q¡Ó1×‘ç­>NO±
pPä‘*½ÄŠäÂT¥\"Êü6ÃJp,\0•¡m€u\'Ù# ƒH¦“9eŠiË°Æ9v‹{*Kî¡I¥\0\0S–>POÆ”“¿W¸Ç“—ZE~ëÂï.uµÛa…”[Ô!ÜªQ$ë
ˆ¾´î-Æ’èSËYnÈóø³k¹¹¹qÆÚÏİĞ‚@OMDé]İ—+)Î+â7nß¹¿SŠõ¸¤ëŞ\0|ºšÒ5ÒF>lÏ‹“Dü@¿‹Û¿‚•¤ê IÖ™%Æ(ÍÂŞL‘“éCéØû‰×pj°·İRnm‚ÑZ‰+dB@ó	:\":W”Á)O,¢äwÆ<XâãšRï÷=Œ8Ä÷¢}jûÇ5ÔÏ6Ÿ±¥X)¤•Iò4Üji¶ær«èâİ¥/8\'c½mFNœkc†¬˜(¨PKzÚqû|1xÿ\0YúUL¿K¡¨ø›Ú¥¿İ»EÆÑËï*?:×Àÿ\0ÊAMú„peÑ‰ªY–Í¿I í­ã©+M4\"¨Ê×Ç\'C««•»f¡§Â“”†9©Å¤Šã%7.@Öt¯K‰\'y<íÆnúı†ÈY$u=i/a–öÂÈ<à¢†‰”’Óâ¨Ì ¢5«X^¨©—½çXØU²½h—ğz¡™+3Éúªı˜®,îgÏ:D‹9gO½ÁıôêĞ”ãg*?Š@šŸbjµî@+\' «n‘BÇ¸:€|b±HÎ½%¿U4‰ƒ.Œ£Qå5‹$Ï_	$ºT DëÊ•Cµ¡d#½XHçÓY¡n•†•†-í)“óš§)Û.($–ŒuÂ•i¥rZ\"n#†od¦Ÿ*[‚a©´¿´?F0NçZCÃî9fKIŒYMƒ”ˆj>R~Ä©{ğÌAn„¸HU[&7é&-ÛD¦Ã³R’®øOúª“r÷EÔâºcŒU«v[ÊlÇ(8Ô›é±y\'Ä
Ş*«U%(Sdy™«5´!y4•/¸iAHJT?ÓµéÓÓúÖ—Dãİ4¤\\:N„F†9UÌ#‹ô£?7Î<[)N.»tµ°™Tò×µğÜ¢ªG„ø‡;(ZO²¡¯J×´ÌvŸhé §S9‡JÎã±İ­Ú¡¤­&Q¤ãºY\\å[nxÄ‘U’¦>2m7âË%HZ”‹¦Ó™¤Æ}znMWœmtjàÉº™c½Š7{†İî{¦Ò
$Âä\0~ uGƒä¨ÒEX1¬bÆ÷aîì3‡°¤¥uXJH\0é´Á±L–:ÒÛ–õE‰ÀEoÿ\0-ËT%Kq-°ÙQ2Læ s=#Ÿ•V:2şéËI/¹Ä´óÍ&ÒÙ\0,ÊÒD’U:5ÜÄ
¥9;kFìrÂã{ÆqŞÃ˜:ÓN^¨¶»‚UÎb:¹Î»äIí
ıT`ÕöSø~:ë˜û­Å¹œ©Ä2âÂKğ¸´ƒ:Ê¡JŠÓò\\§ê..eV™We|§¯¯_Ï÷‡˜u¶ô\0i×m“¥W”iıÍL3ÇZè¼ğ»ç.íQnÛ¡W6YCìÆ† ”ƒyôëMõ=G±w_³#	Â±^ÄÛ¼aÆ/-pæa¦RáJ—Õ“¡Q*V¾*œ©uö”$Ÿ-7÷c£´œ\'³IrÓ¸§”¤FR@V]9ô5ÙÊ›ˆ+ÓÈnZ`x]½#ˆ>»Ü9.w¿yF`è3º£mˆsù¡G”.Ño+¼”–¾àœL›×o.¬û´]©+ï\0æH&NF]yÁšD`•Œ–F¢·¡©ã•µge~ûÉeË&7IF©u%1é ô>”Å©¾H=ÃlÃw/‡İR^FfJ€uI=yôéF¡ìÙ^rs!|CÅBl®ĞRË¬¢æİÒ²•«6@È“	ê	È¥~Î•qäú!NévæÒÍõ-ÃfËŠ-¼©)ZT«p…säzÕˆGvRÍ8Wvoˆ5ıêóWv
–†^“•åJtÒ#İ¶“9R”¸§Oì*œ1ıĞjÃ¹s†ˆ¥ğdóê³y…-E@•GN¤üª%%	q`a‚”›Ø–%Ú
ÚÃ,æDİ\\¥ËpÖB
IN‹ô *=F•Æœ›Î«“#îq+øMÓwo]–ÉN¹Ş&GxT€7#_}9Fı%{àù\'²ÄüVÓÉK \0œ–óêTU\0Á2LO]õåGMí³ç¤›ÑÄİwt2ÂNT¨©ÅØGéVZù~¦PSyåÅ
¹Ã×â6Â;×o®»¦Rí²‘ú¨§óßºE÷…x±…=6}ì—….;3à¾Ù¶;ÖÑ³¨jÈúŠÃŸŒÓùËDy?WÓİû¯Ü~Ÿ¶w¥ÂÓ·­¶âTR¤¨Ár5~>6IG’Z<” àêZ³öÂà—›\'úƒŸ·Eúlî$p|»±[oµÇ¸UƒC]óV--Ä‰ã°ööà»”ˆÄÙ×ªªfÿ\0#_pwı£8<ğíÙN Ó§!R°MS—©4èÁG¶|•íO·Æ¸÷½¶2ËÏ$ƒ&µğÅÃ‹%ËÕØÇ
råëUs#[ÅŸ Û.èï¬Õ6e4–ÇIp<©5±Ñ’k’Dom §!:Qµiàrf7“IõL\0ã¼ªù–¹_ı×x“•9ŒI4¶ö6•[\\4—Œ#Ö8•òG–èæ×eÕ\'0ĞÑK4¥‹”¾ÁÜ2Õ‰!,*¤§ÉÙvÔ v\"¼ÏtÌ}•7}ñmÒ¼ÚÕ£[¬ëOZK›q#N¼ÅWıb4¿øéÇHÒ8mö–
IÓ™/Ê‹[9x‹ºµct˜
ªÏ$=‹ĞÃ™:¡ûvï N_*®å_Jkma`å5 ¹J/H=et_kQ
ŠÏÉeÈMËR1c2çŸB+—D¿T¨ì«6‡xéP»¤`I…~¦¸œSlí£Èl7ò¡““§¡Ão”@I‚in7ØØÊÇc\0‘œÇABàš
ÛLíX¥Ã¤ ­«”\"»»t;²‘\0Öw¤ÍÆñoqĞa%.nGZO>KÒL£%Ûâ0ÓÎµ! Î‚­ãÎÖ‘G&%)]P\"ë‚-‰%)
¦­/.qEgàb{@÷8•¢œ¼é\"¼¾ M×4ŒĞ˜ÓJ¹6mYN_I·€pv£Ò®/6ÊÀIíğî[n&}ô¬]¢Ş	¯PK´^–Ö‡\"è«0Ê­&‡ÇÎòKC|Ÿã‡«°¾0qPïpRRgP\"A«œoeärÓöZ¼–”òàS³áqÍúGY×ûiH—ÙvZ‹Oß_’IÙ§.ËCÉI[ıÄÛ-Ãì“¡€w&9ïRâĞÏu?Oş|;ÅKsE›Ä:ÕÃ¥ë¾óØYOµœ€I\0Æû*ê	A}frôÖÅğüRå\'{¾B±ïÖúZJ5îÁ!´e”ØùW4©Fôw6Û”¢qÃm-ñW’®íÇáçÈ—\0˜	å¤é<õ ’ºLn,µß¹lvwŠ¶jöéå<Õ›.ıÆÈhTrå\0éì‰×ŞzP8û¿æhâŸ%Ùrá×‹Ã°M«Éuû°>öâD3ğd\'Ü)‹Š\\}Ë˜d›’“Ú$ã|Ø´æU.å
B
”¡(0 Lï¶‚‰4’KÜ^G,’m±ƒ÷6¸rÖİÅá]½÷‚[!i
TT|¶ó¤¥B×êtëøvV×ÜQhêñ¦İºa9Ø¸L\0¶–
}“3âçR±r¾ÎË•CMèÛñìxvñ»wQ÷¦XM»öÎè €Éå\'Qç¥%E­‰–U“éeq†c“8Çô»ÖÖ†à©ÆHœèÒ$óvéêâJh©,•$—±-â«Æ›ÃÖÃ™İlŒJÜ0¬ä4D)¹€‘å¹¡†)-ƒ—É§ÒØ÷‘Šá¶.²ïxã/>Ó Np¥ #B6Ì÷šsÇÁõüJRò>tjW¦ãl@¿ÙŞ³t¢â%õ¸N\\¥@HÔƒ–AĞ€H;
ˆ§v/;”ºbmÜİÀ‰Â	fâŞø¥¦“
!˜\'¤3®€×4œù²IC»Î%oÀmÓkŞµe‡eBT3=$¡Â’D{RAêNÕÉ\'*jÁsj¿‰gˆ‰âuÒPĞiˆS,¤•d	’t$tå¯Z|áÆ4¿¨¸Né°~3xíºø$‡‰™R’G²<§Q¯>t¸«ØÉ¸¹wÖ1Ìa¤§36i$œ§I×^¿ÃW#ş\\i™ÎüŒ•ì¾ÄÃ‡øIÁnëŠl–$­Z“¯ïY¹ò¶êÍïÅ+mØwÃ“mÛ‡el®éX»kTÿ\0—2DıE‰êŒÊßrQÆÏ¤÷ØSvœí³h	Km¨`¤ÈZ,ĞKvfb•åMŸ1>Ø?Ùÿ\0\"²e_Ğ±µ©Ä­#ÂÛû­ÿ\0hzùS<©¯“.×Bş#ƒÿ\0î‹×¹ç°ú†‰YZØkğ`©_LØ½uG–?MX_2–…ÛÅnPEË t4Ywb‡½Z
~ôñIĞË†(xS
S¾ºşl°›™j:÷×Î†Rqè”»Xìe|†•[&öjâj)$·^o(òªRFŒol%fô“m Ş“&’Û/cV´Æ°gÈRãÌ
±ƒ<z(çñ¤îQ#¸p¥[6­KÕ£œ]6Â¯ÑbÂÄäY9‰üª#-…’‰¹!û§‘•*Q rÒ«N^âÖ‡ºPƒ=g.NÆ¥]…mò†ÉÆ şõ^Û{,ÒHş<ªÌ*7[¡²@&i©2µ«g(QóÚ§tL4Ë\\é®õæxŸCçfÀ@½Or’÷;MÊg(>µ-Í=›]â
uLJåL²ªènıÛINÃ^tqƒ,‰¤‘»„­PúWd‹Dcœ[®Ç¥–£¦úšHêWr;\0%P$*‚U]	ºæ¡&yE^àÎJÅ™Nq¹’ŸZ	:&/İ
­¨×Y™¡äVôbDœªG*÷@é¾Å’\0Tk¸c®˜iŒr×µ\' Ì™†Şê_Éy%¡™2üµ`kî6¹¼p¡©#Ö­CÄŒRl¡ú—=!£Ww—¢~:Ñ¸Â;:.ravœu¤Œêš¦Úeåöªô(d-}˜©FÀ·¿¾b6‚jŞ6¢´Rš•RĞŠmZlf\\Ğèùß@G‚x¬^åHe¢¦ÚOxâ†À
\\ßÈ(Åi{ÅW*zùÕA’+SÄ\\bŠ^l¹]t/…áÎİáìŞ³”˜PJf ÆÜÉ5 æ£.,ÈX›‡ÌŠÛ^E‚í–2­ÈJĞL¨èLÌrùT¸òÙ
|cOÜVÚÙ¶qœ=):¡°\0ëÌë:q©·Lšº æŒÛa÷.!KÍqp”…(mÓ]HØ{É(rIı‹8²¥?Í÷¸ÁüU‹—Ğ„X¡•\0Œ™…9šë©ªÄ­¥¢ëÉJß¹¹»sş).Y-Ieü¥®ù3¿‰@sÖhÒã\'Ÿ«]’«+‹Ü7·UºÊïT’ ğ•úƒô¥7ÉìĞÇ/EÄ°øK´ƒgl§»Jí.‡SâB•ú¾”9c%_aø³Á7&ÇØï³œ9Å_xhº»U/ÙRòÉÔòô¥q¥iU‘òO±qÛü~å.$¹x¤:Ÿ½!°—\0QÈ¼j:W+»{,O\"”`BQwıS‰mdĞZ²åÅÉl©Ëøpy›ÜM_Ù%É×CK®0câ^%}m©+UŠ‹A¡!JJ¤\09Hš4¹t€–GÆP3
¹^-…¹Š±|•İ;bm·™— éG¤Óø8=•¡–í±–#ÅÍÙâ6ÖÄ%8‚-\\¶geœ¢=ğŠ•äõG@dò¥@{ä9Ã}£¬:Ë7«J%^É)
<òÇ¾ƒ·Æ”ª7A¼O^%÷GÓnËL¶Rçåª§}IÓÖ¤¥ÆÉW8©i®1F“xÃ
îÙ¶ïUp¢…IJAÒg2”tååJQrµ9Î0KdWñ=‚áöANü
ŸÄZ€o¸×§¥Y†7™W.K\"5g¿jÃ
ÈOİ˜Qpå‚¥¨h&u@ø)²J]ìV<²ªöFÑjıÍà–{”­I’’™	œ†<Ô™J)iÙg9Î]vJ¸S€’’|2Vµ+2“®§ov•C.iHÒÇâÇÓ,Ü+CVjµC`\'Ø9U7f¢ÇjÓpœKí+ÁÖA¾ı»gà	äX3¯òjøi<M³Ïübşd?}¾eC„’¢ Cˆ*²ö«UA™;Jhª¸ÿ\0²«Ø»4Å¸kJeæÂíæÃÁ>~şDÖbRdhØ“M¸O¦|‹ãÄø‰oğ,Y…ZßX¼¦AÆÄy¨¯[†pÏd¹ã|œñ²8>½¿`sc¼HëÒ¥è¯÷¡Â	ı)mQ®ÅÒĞ#]c‘ÚI¡µÉÛB
„ü)n½Æğ×(9=zÒÚ±ğiwØFÙèPªÒŠ-©Ó¢]Ão(%(ïT­2ÄÖGšÛfÿ\0‹’,#Š¶·Ğ¦ƒ:j˜5[\'v\\Ë%¢ºÄ°g-oµZaGa^‹u(tyl¾+AlG
-Û¶è>hh1fNN,foQÆ¥ı-[\\eQĞ˜š¸å«EÂÚTKğÎ\0vıƒpÒ]Z2É)LŠÇÉññ‘µ…ó\\¬{bl\\RR²@ÓZ¿‹\"Ù››
Äé2;vOxzÎµ~&|¢ëLn\'`yiGØšíÑˆ7/Ú¹°—.ú$)Ç:’˜¬×ã³ĞÇÌM
i³ (^wê’Ğ¢qD.5Bñ41y1÷1x‚HŒÚm\\±0?Sq£—‰$„™òŠrƒ÷,ßd<Ân\\ëIÍ¸²Êı$…³˜n|…g5NnN]övƒ›B9r¨kÜ”­œ© `dÔ§DJ>èU“\0\0<B‚Nö>¶(£”@Tûö¡H&éR8D•i\0×0c+mûşPå);ìû ıº^Zãs´èd¢¼ñrÓèâŞÀ5ª„kÊŠSgG¸úİ!ˆ!<¹Õy;E˜$‚:„¢T°›“UÔ]—.»`»ÌU	Ì3¬I«0Âûe\'’*ÆÍº§‘˜é<çùçMk€·-’®ìûí6-Cmøî.£l£ªÆç•
å¢%J73Øı‘}pk,6æÍ¶KÍåÊ\\pxQ\"}Ğ#”Ó±á–]É™>O‘òÚ£ÈjNÊÕÀM~¶šR,ûĞ€NÙˆÌ@ô|E_ñ£8:‘™<êQd³—¸€È,¼±æ$işL*i´[ğ%ó! ‡aíö³ü3’VèD	\'1÷zü6®Ã‘í^„yUª@«KàÅûx\0¡³?:B¦åümzº)ÊÔÊä»léRHQk@ gÂ®‡wZòr´Â˜V8¼Í·v¥;n„fÏ¡V»=¨%«+z{Æ×ˆ<«”{Ai[™I:ÈyHõÒƒ‡ò	är÷ğN.ÍÖßÜ­Ë¥x›vs)9Jr$À×M©y\"£¸—||’wìgkz•$YÚ¸›voBœSë„!#B¥@ÔE
Ç¯Py$Ö£üIƒœSo†ÙÛ 8·”¡ir±—Ø$fËÈLÅWù2w}!Ë;ŠJ>â˜;†àW(KIï·R¤(I  #1ó™>@Q¼k2nLq:0xµ·yJyVkiK˜Îµ5<µ?¥8I÷Ğ¼¹bİ}„XÄ-ñmÍ7Kbã1Ÿ!GÏ–»PJm©ÆäÈân•i„1hÊÔ®ùÅ%S—_)cÊ¬Á?tSÈšn•‘ëÜG>3{
¸¸[Šm”¶	Òvş)ú÷)¹I?úµˆ;ˆ[ÛÚ]•¸ÀÉ­Qt¥¸¦Ùc›¤Â¾¶±¶û›w¬¶¬É	&ğ˜#œ\0R7\'É–ââ£Æ üG8«Ë»RŠ;ÀC|Ê„tı©¼un{5ŞÓn{± (…Ì¨§a§¦¾sI›NÚ±ê.•­l¸iìSîèp(6T¶Ó¤À?/\'›O’-ãñy¤¥i\"áàşÎ\\u`\\6Ö«\0§Y\'S¯JÌË—z7á‹Œj\'¶\\,›$Â†‘˜@ĞB©¹ÛØØA½1{›¹Ùºë‰…-\'*Nd…WÚ-¨*ııšxTâ}°b¼Jâ\0k
±p4¢…å“ïöG¾·<(rqHñß’S{Ùìœa82ÙµJˆ·D’ Ÿ¾ú½š>–dø²nHÂî\\Šc¼Aå#Hıë+
wHØÉ­£Éo³rxŸ¹ã|ÜœSH74^·ÿ\07™Dü=*ö¿¥Ÿÿ\0«şŒ­ŸÇ^^6—Ôº>ÛÛ¤ ¼Ö¤¤ïGŒ=˜E¼3½H#AÖ«<©:eÅã7ÿ\0HrFS5:!¯~Æ•…¾ŸËò®ù±#äÏ¥Ñ±‡¿Æµ6,Y*Ònİô(xO¾…Ê|c+¤J8^íû7À-*IÜV_“Ê:fÇŒ²Eú‘d[áïbÃ0h€v:MyÉN8½ÏM‹²öøÇeÎ¾‘pâJ@2LS°üO‡¥›áJK“ÿ\0qf;\'»Ç0U)œ‰€r¨ŒärT?ŠÃ]†<ø©h¥ñ¾Ä¬/NVTÚ ¡Ò½–\'Hmöx+Âò1å|VÑjğoià¼ å»­”(I9‘â\'ûyW˜òü—È¸³Òx¾_ÊñÚÈ¶Š©ÜIXÅÃÅ0µ(ÊMz¸cX¢—àñùsK>Gzİh³<ªÌJ’k®„Pt\"òSJÙÊ*&5/ crvØ0¼¤§~S3V¸¡+$–¬çï.…ujxD‡)}Âv/¸´è}ÕS$R“n¬ Ú<ÍVmj-«Lp†‰:íCz·^Á|1@€RÊöj`´¬?iáG™¬ùíš°ú\"È	lgZÇÁSk¦&êÈ9yLÑE
n»a;F¼µ¡—ä8_héôå¯•t¸´´rÂ€pÏÎ¢]›Lw¦a#ĞÅ*¬skª3mÇ©É&Î¾*›9\\e¼ùÔû‚ê¾Ã;ÛÃnÙ(2¨ëO„yv*sã@„¿yxH•<êËŒ Pç—# ­‰Jedk¾m)Ÿ²-Çl±»2ìkím¶U–ƒšâıÄøŸôÿ\0™]./“Ğr’„mÍànÎ0îÂíğ\\Ğ6Öq.(Jİ_5¸yŸ
|`ò:^Æ^\\œ}L¾x
k†°­´,HWçYÛâkc*J(ÁÏ–İ¶yWí‹ÀGˆ¸s³`w÷ês¼¸s/´µ«)9¤U™ÃüŞiikø”£)q¯wı(vyÁX»á·!L8’\'mQòåt×äôZ”GxæåÊ†ÉŸ§oç•QÇ$ökdÆš¤€+À­+vòÑÇR–ò–Ğ¼„òÜ9kÓãVã“òedñû•«†\\±{¹}*y
2Œ©…|£mêìeöeÎÅ[³WÆÖÉËGìñÌ«,Ê“§ÇçEMn@NJ¸Ç±±-{·AC…HYË:+ÊJ5ôÅ¦ùZbö Â•n?\"|jJ„É:Ò—W¡ë#ÇO¯æÃ1?¼¶øKØ@$«e\'Y¼Ï¤P8ESC¡™»¡ãøòM£wHRûkQ`¨{ …sTö1äåŒÙâ[9•K	Hñ dG¿Y×~‚§‚˜šñ½ºÃ8Ëèw1RŞ^DO‚N‘åûÔJ ©“nräa˜‚0ÌNñ§-!M:Îò
H…\'È’ QsWC\'%L÷¸³-rĞRÒ²¹#ò’\'H×åN‚ÿ\0ò)Rô°ÛQ}‰¡Ô-M¶™IPT(i©9ĞK]2É ‰SL°•!a¨˜Rd“\'R}Ô¶åì·ı”{ÜâŠ¸q°Ù%°³©Ô®c—ózjT·±
nN—A‹,<İ§\"“”¦A@ıj¬²5Ñ©‡™ap—g—7IQ!À’T53Ğrò¬ì™Ò¾,ØÁâ8şå¿Â˜†Ë.-¥$’­‡•gË4§Ñ¨ñ(«,ƒ‚µnÀÇ…>c–Şï*SôşÃ!&ô>g*‡_FR’çÏö¤9[»\0qºŸw9áJª‰;\0<É¡Ü¥E™8¨?±kv?ÂMp·b«—]	h©\'U©@­dü¸
ößÀáåİ,ø—²än?rÜã ›|2enù¨Î½ŸëTFğ”w7*}…¥\'ÿ\00­eA5Ñ³7Éh3Äj.i/4—Y}²ÊĞ¡!@È:|*ÎL\\ñÉ2¼r8Í3É¡ÿ\0ütp×¹q{Â8›œ7ˆg+U«À½n Ê7H™ØÇ•VÅ—>8Ò|’özş¾ã3bÃ–|¤©ı×ıjãÿ\0²ÏöBµ+ÂÖFÊ\\d¤á÷Õiùn¦¸¿Ïı—üÕ©ZşıˆÕ†ÛÊIéTògkišĞñşá5ğƒ€RŞQU^dÖì±úOÚÇ‚a)ºĞş¹û„¾öCø-ÖI9sk ŠróST%øR‹èu„ğÿ\0tşe2 kbiY|‹Uc#ã¸û;M¥Ê[Kdi¬ëY9!É]šøfã*ûqK—.ì²¡Î*ŒŒ¬ÓÉs‰¬#»Âpµ[åÏ¡ÊOZì†IÙZ¡4D“†²]uÛÆ3©D’@ÜÖŸÌ•(Á”+nRHfçaWˆé “ \"\0õ«Ïš.ì©<ò=!’{*°¾·Wt‡á4ÿ\0şW.7¶\'ÿ\0ˆÃ™uı>=Ùã,Û™H<Åm`øÄõ˜^OÀ]úüœG†1)ÅmÏı@o[¸¼¬YV¤y¬¿ò0·jĞ!)2ANUt«m£=EÛ_úe‘îçWl¡T®7TsÚfˆ!õ“áµDúëIÉKacmI0³W9ôÓÔU5–WÆ¨~ÒOSH’¦LwìÃ[–Á‘\0UfÇŒ›ı‚èPB5\"|:¨í³Nõ¡Fb¾šĞË²`şÇ+:ÆıuÒ¡!f”t‰Ê…¤Jo¡WIPˆĞùÔE%Ù-ÛèI´ä¨©}´8÷ÚĞïµW¸ç.JòÏ´6¨\\¯DRìÒûÂƒmŒËY€©\' 7JÙö,^û2q÷ıİÄ`nØÛ¼|._~	#¨Iñ…e\'ô&Êù%ıL¾8#ì•Isˆ±íø‰Ê}ê2~ÈÌö¨©/;AåŸ`}vmnÑk¶¿¿#3j¸Gz­?2”¹„ú;+ğ£†?æ;ehù¹sËŒƒX½¾·i6¶M’œ£m€ÁêiXq¹zcĞys|¯©Û\'|34‡ŞºCc*\0eÓ©õÛâkj8–q­˜SÉ,²m’[¦Óqpİ¢·‰è\\#orOşêĞÁyìÒå%Rı¤àñ=ÕİàI@¶OŞ×T&2|4™¿•×ldcÎoìŠgxKÃ»O»ş””®Õûd¾T#*•˜ÄG(øò¬¯ˆÂXéÉön|¹É/b+‰p.ï”øBTQ)™çî¬>m=¶x“TÑUñ\0«+Ç†Ô\"†#]¼ÅYÅ“–™G&
_’õ¯utÚÔAH>#ÌëÖ¯&âì¡<jú\0âxw$²íÒ	€Úõ$ó«PË(GÔÌüş/7é@{ÜåÇJ‹ì#LÉ„çmô«1Ï’(KÆ”V¡Üç‚{·$¥MåÍÎOœSRU¡ÓKzÚÜ:ÊİRr…>
“tfˆÿ\0¥w¶Ær·É3oº°ÛjP&$£Y:h:Wå8¶©1lDXÙ¸ëe/¨{\'¨ëÎº)9ÓxÒ÷°/ZØ¥Ae*Bˆ	;ŸNµÍ«ÑÑU°w{÷¥=té1˜iÊ:×?±+w6\'yˆ2‚‚R!CÂvÒN»TÆƒ,‘FìßyÕ€”)KZa;\0™¥É¤7r	wxÛm¬’Ù3¤dÍ%æ„zvË0ñe4¢ká\'®Şi ûêW²‚`‡„{ª®Lÿ\0ÀĞÅàpî¿¿ÁsvyÙ\\Bœ»iâ÷¶¬™sÒ+;6w\'£o£m/â^/\"Ù–İû»YÌ<\0@Õ?	ª?‚ö4É†©îíĞ·RQÒ¿•®Ã›İH~Œ›%wŠüU¨k:kÖ:PÉß¹1†ô5¾oºb½ÛÒ™qIİxWwÄ®qBŞf¬\0KY‡…O/@òƒ>¥5¥áxï$Ñ‹ño-`ÅòÓÙnpıc³±JÒCî—
º…;‘?ûó5î£ÙóÊS’¿rEÇŠï^iŸó¬<³I¬/!êß{ÚOw÷‡?(Z>QU\\t»%X½kkgA•Ì‘èJ~9=¦ãjÌÄp×¬•÷¶	JÚW‹/4U[“ŒíR
¼^ÃÄã7l<o$ yü˜qg8è­ÓÃ-Kg›»[ûaX»Ï_à(Nzá*-„•[-^ïgİ^_?<.ñ½}Ÿı—ÆøŒf½kşÏ/ñÏd¼eÙªŠñ\\ÕÛİ .³e#OxAÅ\'S\\_çşÍ_Ÿ;‹¿ïìASÅ=ÚŠJ`t¢ı#kL5å9t‡âÖ\0Ti¬Òÿ\0I%l?ÖGÜIŞ)µ\0”‰Òbx³;õ˜Ò´$%·\05:š—ãIö<¨^‚	ãF²\0¢(©£vZ™¨å\\b‚*†úT~¢%ç_BwMop˜ QÖŠ>,ãìòã$\"Ş3f\0\0¤sÒàÈİˆYqİ±İ·Záè’ ”¹x³›ª,ãó ‘ÃœzÃ¯ABËQ½wè&£gKâ÷BX‚,qÖHSiAåxùá÷>ã²£ã^rÕN\\Û5 Ô€9W¬ğ¾ ¥P›<wÄ>İÊ¨T|
ôÚ½…lğ)èMJ×Såd¿Á¦ÖR°&5ç\\Ö[cÃx¦À ë§*OÃs¥HY¬e`ë#](%yÇdãt»kšu¬,Ñ©Qé<Y§Ç+»)\\´•h³,ªû6àrÜ2vŠ¦Õ2úšqB$\"\"éXº¡â@;ÒmûJÌu`*ÄäÑ(û‘,µ¡T\'@G>¼¨ÕY2à~Êx³´\'’œº½j`Üäe=efSR¢æê
ÁÉ–—)½‘ìûìuˆ¶‹.Æ‰6XL{–#à*ş/+Üª?Õ™9¾#ª
ÿ\0¿æzc‚ûà®Ë,Òæ€áÖ7§[çSßÜ9—úUÈø¸¡ºäÿ\0?õìe¿+&EM×ì>±µÌ·¯pÛYÃºº÷ éOÇŠİ°\'’£H#sÆXV	‡­Û[U;p©€£u«RrÔì¹a‚;{+âÅ<ÏğAÙ³Ä8ı>µ©Ë•ÈRô1ÌÇ Ã•dÇü™\\Yd‡²Â6M`ØB-­T;¶ÄoÔûÿ\0ZÙÅ)Ò22äoÜ+nÂ0k$ ‰û»yÕ?™g—¼˜÷×Ir•
ºˆÅIu»wTVJÏá•õqz¨û“˜ûÅhÊ)(ãEÊîlbşœG‡±8šå*Bú@(<Æ¨ù[t½‹^:¥lñVÄ‡íƒ`•Y²›?Ü Á¸ÔGºkÍË/#e#Ò|;pI×¹c9†$å*öƒç¹;¦zˆ:{#ØÇ³ˆ²¤¸ÒJ¶&> Q’‹úŠŸ‹{,rÅ²»fÈmR¢‘$Áé¼U¼y¥îRÑZâ8ÎàCÍdÌ4JÉ$•n3Sè¤ñ¤èó(¹
@P*L…¥C—._Î´ößbå…5K±¥Å³yˆîÂÕ…‡25Ñ^x#Ü–À+Ã›7C*aCš¶UqfimèÎŸ¹¦iXl¶
ßqNi#;Ğ¼ûö —‰FÛrÑ×B»û¾ña9vÉ¶Ñ¾škÖfO|@~ªùíìŸ[%Nd¦\"¿J	æJ’DãğæÕ7£«L…0‚òÔµ Ç÷¤ËÈŸúQoÃàãMÿ\0Ad`­¹“,ÈÕcaä&‡çÉÓlt|Qaœ\0váü­6§	$u¤O3ÿ\0S¢ö‹Ò²Òà¾ÉİÇmË«w\"I:	óëŸ“=ti¬½Hµ¸²Öğ‡ŸMÅ¨/÷›¦B£òÏ”ùÕidrvØJ*-6ì´pÌ!6ve`)â¬¡¯»ëJÛl³%aÌ3‡J İ8P„{¦Î¾„Ñ¬o·ÿ\0’-ôƒ©i»Kt¶Ş‚J‚G/^´-¯`S“~à»¤äRT s’iRMôY‹ÑÄC÷)·a=ã¯”%:Iéó¡Šrt»;&Ur~Å˜¬¾áœ7h,êĞ7qBI*>j\"½·aŠ_egÌş!ä<Ó”¾ì–`6‰şµoj”Œ–«nÜGÿ\0©½Oş¤ŸjÍñÆdÃÕ’ñ7|@Ûc\\£6‡m }MyÜ¯”¨ô˜W‰1kŞa×ŠÊ–g®ßµ“UCa²Nr½ƒ&HŒ¨PŸJ”êCiVƒ¶›«D“¨q¨>¿Íhe‘øRß¶RØl„€¼ÙT$/Ö™ÂVıÈœy ›×!%76§)Ò@ |ôùÕ¹ãŒÕYJ3”]¤
·¸mA¦’ãJİ—6/íXù¼gÖl^B—oe7ÚÙ/;DJŞE—ô|DÉûÅ”4¹ÿ\0R}•|=õœüD·‰×û#Iy2§¿ïïÿ\0³Ë¡ı†xÛ†Vóøšâ+d‚®í¿Â¸ş…W¸š[–\\[É_u¿éßûŒğÏ|©şìóÆ;ÃØ—Ş¹k‰Ù\\aÏ Y¹iM¨xî¦FpËô²e	Ão xYYGM\"¦¨Zuº¶Ê”`@ÁŞ¡´»,Aklt–²$æ½yR¯he=±ªÁÏï£UB¦ø´%!½I3¸Ñ§d§ª±£ŠS®Lr¦%ÅråøCh·9Ò uŞ\"¢ùvs¤”‰6q÷¦á*…
Îò!Åİ>>DÕ/ñ{;V‹œª\\@ƒÍ§²Ïj™äø)İ0#zú¡ñ˜èÙiJöS56KTv‹Eæ
)ç¥šè•ÖaÅ	JdkÎb…I}Î’•m	¢İÄ-2’5÷Q¹&€§{,\\XÌAŠó~EóÑë¼T”4à*pk\'Î¡t’å å ŸpĞoT§vkC¤m&`K¦BÜ¯°®ƒßc—ÌØá¶ß^¼BZ··l­k>I–øöÆShôgßaÎ:â¤´ş4å¿[ªtğï®@ÿ\0¡:\'ÿ\02…Y%¨ÄKË-»ı«ıÏSöoö\"à^m»ŒBÕXåÒ<EìD… Ì BG¾jŞ/İÏßØÏËæËé‹Ï¶Áğt3knÒhxRÚ‘å:p­¬X*).Œl™oofÜâ4Ş©H·(B»Š•ZFúÕ©cPú™V3ré\0ñÜA¦VË@®òåÂ2ıçFÑ\'üƒ~{ô¨ŒSOğtœ“ıÈç]-›d’·_VTƒ¹Â©dÉ{‘o\\ı(…ánc7åım›×ÉYy!Ë©ªŒ³Ï—±¡Î!Æ$÷…ğ‚–—v´Âİğ O²¼}=Şu±Ãå%dóy “cÅÕq±oAØcõ?
}p}•ş©k¤/|àSÈh¥J\0òÒ7*:!>»üªpEJN_`3Ê•}ÎñK6¦mœï²‘&7yg_†ƒÒ¬E¦ÜÙZZJ!›ì)»[í™’Ûh€:€ ~µŸ$Úl¿Ò>wc¸oü=öƒâ~îR—®Ôîñ9ŒÏÆkÍdU=_WÈ¹°ğµ3ÆÕ—Tnqã+¡óx`-§D8H“E±®UĞßáÆ®ÆP„€$”)>#üš†“ËŞEcÆ—\'Ä\\RĞB@4ÛûS#\'xà×E_Äı]Y,©¤¥:J¢¬Ç.¶.xRv¶Cï;;¼e T#90v&›ó“EgS±Ïe×ÆçîéHÌwÒ‹æÑË$¶jã±#m(Él\\BÈ“0<è‘È^4Vú9Å;â-¶å€¹cJ‡}ƒı,ZÑÛ”c*eKıéFá;	®ùñö\'å%¤;Ã{*Å®iÅÛ©FrÄ‘®´·1é%îIp^ÆwJiE¸Ûš„ëI–vÖ‡,é–¯öVåµòËª	lÆU Dsi<”˜÷¶[8/
?‡2ØuôÛÀ>¥~µÊ=§¡s|ºV^‹d®âÙ—®\\)ÊJ–GI‘§”×qQİ°ñEÊ“¤ƒÖï\"Í„!–ÒÊwÜÏYÓİÈQóP^”Å{nÄeù”r©@	ŞO:S“»{»÷;QïS€X1îı((¯`MêYZ“¹« ¥½ècu¤ìÛ\0Mî*ş\"úB›¶Hüäj|ôúÖ¿ãó—Ì—·G™ø·—KäÇ¿rdê‰q#)Zmm–Ş“ª¼AFzl7é^Ãã/¹â2Êä¢IxJÖMÓ€…wN¾LnTGÿ\0ÔiYåPV;Æ…Íƒ­[7¸İëÛÄ$}jÆjİ³yk gŞaJ$j²¹Š	êZ\0†s†¡;’‚ŞÜèZwtCÜyí
U ¶£ğ:şôÇÛİiº`Zâ(p[^¤ èjxòËÜ5lèe·¯ä(T&A÷{©ø-ú_e\\½òKBÊÃ­ïZ+HBùwŒò>cù½X–6´ÊñÊ¬{„-ŸÁZÎ£BŸZ¡“dõ¦hãÎ×{I€”Üõ£¢]HˆõéJP”{äàã^Ëpn:ÃUi‹aÖXÍ«‰ÿ\0ñ°TŸ4«qî4¬¾<ûqßİi‡ÊÉ‹Iëù£Ê©ıƒ0õ©ÛÎº^é’,®ül(ôİ>ù¬¼>|?Cä¿:ÏşÍL^N<¿R¯Ûş.ñe<QÙíÑ·Æğk‹b		| ©¥ù¥cCU>t[âôşÌÒŠ¥qÚû‘náEZÈ éQt¨î6Õv\"ûˆm)\0Aëqä‰ı×ZÂTFXè4ó«jÚBZrLA\0’@Ñ[‚zQÖ¬SU¤cÊ!Gmt¢K“Ù2rJš3âC„
úÔåñ¾g¸¼~SÄ·¢#Å\\Låó‹V}Íjø¾:Š2¼Ï7•¤ÈkØJT˜	Ò7­u™£Î~·ÃÃ-×K#“c_ê6óA)Újaq­!6ŠRuÜÑ;b›Kÿ\0gIZ’\0ò¨ÚD8Å´Ém‚vZLrŠÉÈîLô:ã[HSÓ¬5Û£”R–İ–gg}ñj!áûÌA%W9{»tÔâ¡\"¨Ê[®Ëé®;g©;4ÿ\0ø÷EªÙ¸ã¬x¸òµş—‚êO‘t‰ÿ\0ÒŸ}3åäÉøÿ\0úÿ\0q_60õ#Ò¼3Ù	','1','test','2016-05-19 13:33:11');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------
