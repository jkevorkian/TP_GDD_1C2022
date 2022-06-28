SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Auto`;
DROP TABLE IF EXISTS `Piloto`;
DROP TABLE IF EXISTS `Carrera`;
DROP TABLE IF EXISTS `Circuito`;
DROP TABLE IF EXISTS `Sector`;
DROP TABLE IF EXISTS `Medición`;
DROP TABLE IF EXISTS `Motor`;
DROP TABLE IF EXISTS `Neumático`;
DROP TABLE IF EXISTS `Caja de cambios`;
DROP TABLE IF EXISTS `Tipo_incidente`;
DROP TABLE IF EXISTS `Entity1`;
DROP TABLE IF EXISTS `Tiempo`;
DROP TABLE IF EXISTS `Medicion`;
DROP TABLE IF EXISTS `Parada_en_box`;
DROP TABLE IF EXISTS `Freno`;
DROP TABLE IF EXISTS `Incidente`;
DROP TABLE IF EXISTS `Circuito`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Auto` (
    `id_auto` INTEGER(11) NOT NULL,
    `nro_auto` INTEGER(11) NOT NULL,
    `modelo` VARCHAR(255) NOT NULL,
    `descripcion` VARCHAR(255) NOT NULL,
    `escuderia_nombre` VARCHAR(255) NOT NULL,
    `escuderia_nacionalidad` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_auto`)
);

CREATE TABLE `Piloto` (
    `id_piloto` INTEGER(11) NOT NULL,
    `nombre` VARCHAR(50) NOT NULL,
    `apellido` VARCHAR(50) NOT NULL,
    `nro_documento` VARCHAR(15) NOT NULL,
    `tipo_documento` VARCHAR(5) NOT NULL,
    `nacionalidad` VARCHAR(50) NOT NULL,
    `fecha_nacimiento` DATE NOT NULL,
    PRIMARY KEY (`id_piloto`),
    UNIQUE (`nro_documento`, `tipo_documento`)
);

CREATE TABLE `Carrera` (
    `id_carrera` INTEGER(11) NOT NULL,
    `fecha_fin` DATE NOT NULL,
    `vueltas_total` INTEGER(3) NOT NULL,
    `clima` VARCHAR(100) NOT NULL,
    `longitud` DECIMAL(18,2) NOT NULL,
    `circuito_nombre` VARCHAR(255) NOT NULL,
    `circuito_pais` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_carrera`)
);

CREATE TABLE `Circuito` (
    `id_circuito` INTEGER(11) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `descipción` VARCHAR(255) NOT NULL,
    `pais` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_circuito`)
);

CREATE TABLE `Sector` (
    `id_sector` INTEGER(11) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `descipcion` VARCHAR(255) NOT NULL,
    `longitud` DECIMAL(18,2) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    `circuito_nombre` VARCHAR(255) NOT NULL,
    `pais` VARCHAR(255) NOT NULL,
    `circuito_nombre` VARCHAR(255) NOT NULL,
    `circuito_pais` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_sector`)
);

CREATE TABLE `Medición` (
    `id_medicion` INTEGER(11) NOT NULL,
    `id_carrera` INTEGER(11) NOT NULL,
    `id_sector` INTEGER(11) NOT NULL,
    `id_auto` INTEGER(11) NOT NULL,
    PRIMARY KEY (`id_medicion`)
);

CREATE TABLE `Motor` (
    `id_motor` INTEGER(11) NOT NULL,
    `modelo` VARCHAR(255) NOT NULL,
    `nro_serie` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_motor`)
);

CREATE TABLE `Neumático` (
    `id_neumático` INTEGER(11) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    `nro_serie` VARCHAR(255) NOT NULL,
    `posicion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_neumático`)
);

CREATE TABLE `Caja de cambios` (
    `id_caja_cabio` INTEGER(11) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `modelo` VARCHAR(50) NOT NULL,
    `nro_serie` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_caja_cabio`)
);

CREATE TABLE `Tipo_incidente` (
    `id_tipo_incidente` INTEGER(11) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    `descripcion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_tipo_incidente`)
);

CREATE TABLE `Entity1` (
);

CREATE TABLE `Tiempo` (
    `id_tiempo` INTEGER(11) NOT NULL,
    `fecha` DATETIME NOT NULL,
    `anio` INTEGER(4) NOT NULL,
    `cuatrimestre` INTEGER(1) NOT NULL,
    `mes` INTEGER(2) NOT NULL,
    `semana` INTEGER(2) NOT NULL,
    `dia_semana` VARCHAR(10) NOT NULL,
    `Hora` INTEGER(2) NOT NULL,
    `minuto` INTEGER(2) NOT NULL,
    `segundo` INTEGER(2) NOT NULL,
    PRIMARY KEY (`id_tiempo`)
);

CREATE TABLE `Medicion` (
    `id_tiempo` INTEGER(10) NOT NULL,
    `id_motor` INTEGER(10) NOT NULL,
    `id_neumatico` INTEGER(10) NOT NULL,
    `id_caja_de_cambios` INTEGER(10) NOT NULL,
    `id_piloto` INTEGER(10) NOT NULL,
    `id_medicion` INTEGER NOT NULL,
    `id_auto` INTEGER(10) NOT NULL,
    `id_sector` INTEGER(10) NOT NULL,
    `id_carrera` INTEGER(10) NOT NULL,
    `id_freno` INTEGER(10) NOT NULL,
    `combustible` DECIMAL(18,2) NOT NULL,
    `distancia_recorrida_en_carrera` DECIMAL(18,6) NOT NULL,
    `nro_vuelta` DECIMAL(18,0) NOT NULL,
    `distancia_recorrida_en_vuelta` DECIMAL(18,2) NOT NULL,
    `posicion` DECIMAL(18,0) NOT NULL,
    `velocidad` DECIMAL(18,2) NOT NULL,
    `tiempo_de_vuelta` DECIMAL(18,10) NOT NULL,
    `motor_potencia_momentanea` DECIMAL(18,6) NOT NULL,
    `motor_temp_aceite` DECIMAL(18,6) NOT NULL,
    `motor_temp_agua` DECIMAL(18,6) NOT NULL,
    `motor_rpm` DECIMAL(18,6) NOT NULL,
    `neumatico_profundidad` DECIMAL(18,6) NOT NULL,
    `neumatico_presion` DECIMAL(18,6) NOT NULL,
    `neumatico_temperatura` DECIMAL(18,6) NOT NULL,
    `freno_grosor_pastilla` VARCHAR NOT NULL,
    `freno_temperatura` DECIMAL(18,2) NOT NULL,
    `caja_de_cambios_caja` VARCHAR(255) NOT NULL,
    `caja_de_cambios_temperatura_aceite` DECIMAL(18,2) NOT NULL,
    `caja_de_cambios_rpm` DECIMAL(18,2) NOT NULL,
    `caja_de_cambios_desgaste_porcentual_acumulado` DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (`id_tiempo`, `id_motor`, `id_neumatico`, `id_caja_de_cambios`, `id_piloto`, `id_auto`, `id_sector`, `id_carrera`, `id_freno`)
);

CREATE TABLE `Parada_en_box` (
    `id_carrera` INTEGER(10) NOT NULL,
    `id_neumatico_anterior` INTEGER(11) NOT NULL,
    `id_neumatico_nuevo` INTEGER(11) NOT NULL,
    `nro_auto` INTEGER(11) NOT NULL,
    `id_tiempo` INTEGER(11) NOT NULL,
    `nro_vuelta` DECIMAL(18,0) NOT NULL,
    `id_piloto` INTEGER(10) NOT NULL,
    `Column26` INTEGER NOT NULL,
    `id_sector` INTEGER(10) NOT NULL,
    `duracion` DECIMAL(18,2) NOT NULL,
    `posición` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_carrera`, `id_neumatico_anterior`, `id_neumatico_nuevo`, `nro_auto`, `id_tiempo`, `id_piloto`, `id_sector`)
);

CREATE TABLE `Freno` (
    `id_freno` INTEGER(10) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `nro_serie` VARCHAR(255) NOT NULL,
    `tamanio_disco` DECIMAL(18,2) NOT NULL,
    `posicion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_freno`)
);

CREATE TABLE `Incidente` (
    `id_sector` INTEGER(10) NOT NULL,
    `id_carrera` INTEGER(10) NOT NULL,
    `nro_auto` INTEGER(10) NOT NULL,
    `id_tiempo` INTEGER(10) NOT NULL,
    `id_piloto` INTEGER(10) NOT NULL,
    `bandera` VARCHAR(255) NOT NULL,
    `tiempo` TIMESTAMP NOT NULL,
    `nro_vuelta` DECIMAL(18, 0) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    `descipción` VARCHAR(255) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_sector`, `id_carrera`, `nro_auto`, `id_tiempo`, `id_piloto`)
);

CREATE TABLE `Circuito` (
    `id_circuito` INTEGER(11) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `pais` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_circuito`)
);
