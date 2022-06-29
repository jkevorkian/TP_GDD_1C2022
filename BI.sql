USE [GD1C2022]
CREATE TABLE [MANTECA].[BI_Auto] (
    id_auto INT NOT NULL,
    nro_auto INT NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    escuderia_nombre VARCHAR(255) NOT NULL,
    escuderia_nacionalidad VARCHAR(255) NOT NULL,
	id_escuderia INT NOT NULL,
    PRIMARY KEY (id_auto)
);

INSERT INTO MANTECA.BI_Auto
(id_auto, nro_auto, modelo, descripcion, escuderia_nombre, escuderia_nacionalidad, id_escuderia)
SELECT a.ID_AUTO, a.AUTO_NUMERO, a.AUTO_MODELO, a.AUTO_DESCRIPCION, e.ESCUDERIA_NOMBRE, e.ESCUDERIA_NACIONALIDAD, a.ID_ESCUDERIA
FROM MANTECA.Auto a
JOIN MANTECA.Escuderia e ON e.ID_ESCUDERIA = a.ID_ESCUDERIA

CREATE TABLE [MANTECA].[BI_Piloto] (
    id_piloto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nro_documento VARCHAR(15) NOT NULL,
    tipo_documento VARCHAR(5) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY (id_piloto),
);

INSERT INTO MANTECA.BI_Piloto
(id_piloto, nombre, apellido, nro_documento, tipo_documento, nacionalidad, fecha_nacimiento)
SELECT P.ID_PILOTO, P.PILOTO_NOMBRE, P.PILOTO_NRO_DOCUMENTO, P.PILOTO_TIPO_DOCUMENTO, P.PILOTO_NACIONALIDAD, P.PILOTO_FECHA_NACIMIENTO FROM MANTECA.PILOTO P

CREATE TABLE [MANTECA].[BI_Carrera] (
    id_carrera INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    vueltas_totales INT NOT NULL,
    clima VARCHAR(100) NOT NULL,
    longitud DECIMAL(18,2) NOT NULL,
    circuito_nombre VARCHAR(255) NOT NULL,
    circuito_pais VARCHAR(255) NOT NULL,
	id_circuito INT NOT NULL,
    PRIMARY KEY (id_carrera)
);

INSERT INTO MANTECA.BI_Carrera
(id_carrera,fecha_inicio,fecha_fin,vueltas_totales,clima,longitud,id_circuito)
SELECT ID_CARRERA,CARRERA_FECHA_INICIO,CARRERA_FECHA_FIN,VUELTAS_TOTAL,CARRERA_CLIMA,CARRERA_LONGITUD,ID_CIRCUITO FROM MANTECA.Carrera


CREATE TABLE [MANTECA].[BI_Sector] (
    id_sector INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descipcion VARCHAR(255) NOT NULL,
    longitud DECIMAL(18,2) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    circuito_nombre VARCHAR(255) NOT NULL,
    circuito_pais VARCHAR(255) NOT NULL,
	id_circuito INT NOT NULL,
    PRIMARY KEY (id_sector)
);

INSERT INTO MANTECA.BI_Sector
(id_sector, nombre, descipcion, longitud, tipo, circuito_nombre, circuito_pais, id_circuito)
SELECT ID_SECTOR, SECTOR_NOMBRE, SECTOR_DESCRIPCION, SECTOR_LONGITUD, SECTOR_TIPO, CIRCUITO_NOMBRE, CIRCUITO_PAIS, s.ID_CIRCUITO
FROM MANTECA.Sector s
JOIN MANTECA.Circuito c ON s.ID_CIRCUITO = c.ID_CIRCUITO

CREATE TABLE [MANTECA].[BI_Motor] (
    id_motor INT NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_motor)
);

INSERT INTO MANTECA.BI_Motor
(id_motor, modelo, nro_serie)
SELECT ID_MOTOR, MODELO, NRO_SERIE FROM MANTECA.Motor

CREATE TABLE [MANTECA].[BI_Neumatico] (
    id_neumático INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_neumático)
);

INSERT INTO MANTECA.BI_Neumatico
(id_neumático, nombre, tipo, nro_serie)
SELECT ID_NEUMATICO, NEUMATICO_NOMBRE, NEUMATICO_TIPO, NRO_SERIE FROM MANTECA.Neumatico

CREATE TABLE [MANTECA].[BI_Caja_de_cambios] (
    id_caja_cambio INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_caja_cambio)
);

INSERT INTO MANTECA.BI_Caja_de_cambios
(id_caja_cambio, nombre, modelo, nro_serie)
SELECT C.ID_CAJA_CAMBIO, C.CAJA_CAMBIO_NOMBRE, C.CAJA_CAMBIO_MODELO, C.NRO_SERIE FROM MANTECA.Caja_de_cambios C

CREATE TABLE [MANTECA].[BI_Tipo_incidente] (
    id_tipo_incidente INT NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tipo_incidente)
);

INSERT INTO MANTECA.BI_Tipo_incidente
(id_tipo_incidente, tipo, descripcion)
SELECT T.ID_TIPO_INCIDENTE, T.TIPO_INCIDENTE, T.TIPO_INCIDENTE_DESCRIPCION FROM MANTECA.Tipo_Incidente T

CREATE TABLE [MANTECA].[BI_Fecha] (
	ID_FECHA int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Fecha PRIMARY KEY,
	FECHA_ANIO INT,
	FECHA_MES INT,
	FECHA_DIA INT,
	FECHA_CUATRIMESTRE TINYINT
);

CREATE TABLE [MANTECA].[BI_Medicion] (
    id_fecha INT NOT NULL,
    id_motor INT NOT NULL,
    id_neumatico INT NOT NULL,
    id_caja_de_cambios INT NOT NULL,
    id_piloto INT NOT NULL,
    id_medicion INTEGER NOT NULL,
    id_auto INT NOT NULL,
    id_sector INT NOT NULL,
    id_carrera INT NOT NULL,
    id_freno INT NOT NULL,
    combustible DECIMAL(18,2) NOT NULL,
    distancia_recorrida_en_carrera DECIMAL(18,6) NOT NULL,
    nro_vuelta DECIMAL(18,0) NOT NULL,
    distancia_recorrida_en_vuelta DECIMAL(18,2) NOT NULL,
    posicion DECIMAL(18,0) NOT NULL,
    velocidad DECIMAL(18,2) NOT NULL,
    tiempo_de_vuelta DECIMAL(18,10) NOT NULL,
    motor_potencia_momentanea DECIMAL(18,6) NOT NULL,
    motor_temp_aceite DECIMAL(18,6) NOT NULL,
    motor_temp_agua DECIMAL(18,6) NOT NULL,
    motor_rpm DECIMAL(18,6) NOT NULL,
    neumatico_profundidad DECIMAL(18,6) NOT NULL,
    neumatico_presion DECIMAL(18,6) NOT NULL,
    neumatico_temperatura DECIMAL(18,6) NOT NULL,
    freno_grosor_pastilla VARCHAR NOT NULL,
    freno_temperatura DECIMAL(18,2) NOT NULL,
    caja_de_cambios_caja VARCHAR(255) NOT NULL,
    caja_de_cambios_temperatura_aceite DECIMAL(18,2) NOT NULL,
    caja_de_cambios_rpm DECIMAL(18,2) NOT NULL,
    caja_de_cambios_desgaste_porcentual_acumulado DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (id_fecha, id_motor, id_neumatico, id_caja_de_cambios, id_piloto, id_auto, id_sector, id_carrera, id_freno)
);

INSERT INTO MANTECA.BI_Medicion
(id_fecha, id_motor, id_neumatico, id_caja_de_cambios, id_piloto, id_auto, id_sector, id_carrera, id_freno, combustible, distancia_recorrida_en_carrera, nro_vuelta, distancia_recorrida_en_vuelta, 
posicion, velocidad, tiempo_de_vuelta, motor_potencia_momentanea, motor_temp_aceite, motor_temp_agua, motor_rpm, neumatico_profundidad, neumatico_presion, neumatico_temperatura, freno_grosor_pastilla,
freno_temperatura, caja_de_cambios_caja, caja_de_cambios_temperatura_aceite, caja_de_cambios_rpm, caja_de_cambios_desgaste_porcentual_acumulado)
SELECT f.ID_FECHA, ID_MOTOR, ID_NEUMATICO, ID_CAJA_CAMBIO, ID_PILOTO, m.ID_AUTO, ID_SECTOR, ID_CARRERA, ID_FRENO, COMBUSTIBLE, DISTANCIA_RECORRIDA_CARRERA, VUELTA_NUMERO, DISTANCIA_RECORRIDA_VUELTA,
ma.POSICION, VELOCIDAD, TIEMPO_DE_VUELTA, POTENCIA_MOMENTANEA, mm.TEMP_ACEITE, mm.TEMP_AGUA, mm.RPM, mn.PROFUNDIDAD, mn.PRESION, mn.TEMPERATURA, mf.GROSOR_PASTILLA,
mf.TEMPERATURA, mc.CAJA, mc.TEMPERATURA_ACEITE, mc.RPM, mc.DESGASTE_PORCENTUAL_ACUMULADO FROM MANTECA.Medicion m
JOIN MANTECA.Medicion_Auto ma ON m.ID_MEDICION = ma.ID_MEDICION
JOIN MANTECA.Medicion_Caja_De_Cambios mc ON m.ID_MEDICION = mc.ID_MEDICION
JOIN MANTECA.Medicion_Frenos mf ON m.ID_MEDICION = mf.ID_MEDICION
JOIN MANTECA.Medicion_Motor mm ON m.ID_MEDICION = mm.ID_MEDICION
JOIN MANTECA.Medicion_Neumatico mn ON m.ID_MEDICION = mn.ID_MEDICION
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(m.FECHA_HORA) AND f.FECHA_MES = MONTH(m.FECHA_HORA) AND f.FECHA_DIA = DAY(m.FECHA_HORA)



CREATE TABLE [MANTECA].[BI_Parada_en_box] (
    id_carrera INT NOT NULL,
    id_neumatico_anterior INT NOT NULL,
    id_neumatico_nuevo INT NOT NULL,
    nro_auto INT NOT NULL,
    id_fecha INT NOT NULL,
    nro_vuelta DECIMAL(18,0) NOT NULL,
    id_piloto INT NOT NULL,
    id_sector INT NOT NULL,
    duracion DECIMAL(18,2) NOT NULL,
    posición VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_carrera, id_neumatico_anterior, id_neumatico_nuevo, nro_auto, id_fecha, id_piloto, id_sector)
);

CREATE TABLE [MANTECA].[BI_Freno] (
    id_freno INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    tamanio_disco DECIMAL(18,2) NOT NULL,
    posicion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_freno)
);

INSERT INTO MANTECA.BI_freno
(id_freno,nombre,nro_serie,tamanio_disco)
SELECT ID_FRENO,FRENO_NOMBRE,NRO_SERIE,TAMANIO_DISCO FROM MANTECA.Freno

CREATE TABLE [MANTECA].[BI_Incidente] (
    id_sector INT NOT NULL,
    id_carrera INT NOT NULL,
    id_auto INT NOT NULL,
    id_fecha INT NOT NULL,
    id_piloto INT NOT NULL,
    bandera VARCHAR(255) NOT NULL,
    nro_vuelta DECIMAL(18, 0) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    descipción VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_sector, id_carrera, id_auto, id_fecha, id_piloto)
);

INSERT INTO MANTECA.BI_Incidente 
(id_sector, id_carrera, id_auto, id_fecha,  id_fecha, bandera, nro_vuelta, tipo)
SELECT ID_SECTOR, id_carrera, ai.ID_AUTO, id_fecha, ID_PILOTO, INCIDENTE_BANDERA, NRO_VUELTA, TIPO_INCIDENTE FROM MANTECA.Incidente i
JOIN MANTECA.Auto_Incidentado ai ON ai.ID_INCIDENTE = i.ID_INCIDENTE
JOIN MANTECA.Tipo_Incidente t ON t.ID_TIPO_INCIDENTE = ai.ID_TIPO_INCIDENTE
JOIN MANTECA.Medicion_Auto ma ON ma.ID_AUTO = ai.ID_AUTO


CREATE PROCEDURE MANTECA.carga_BI_Fecha
AS
BEGIN
WITH fecha (anio, mes, dia, cuatrimestre)
AS
(
select (YEAR(CARRERA_FECHA_INICIO)) AS 'ANIO', MONTH(CARRERA_FECHA_INICIO), DAY(CARRERA_FECHA_INICIO), CASE MONTH(CARRERA_FECHA_INICIO)
       WHEN '1' then '1'
       WHEN '2' then '1'
       WHEN '3' then '1'
       WHEN '4' then '1'
       WHEN '5' then '2'
       WHEN '6'  then '2'
       WHEN '7' then '2'
       WHEN '8' then '2'
       WHEN '9' then '3'
       WHEN '10' then '3'
       WHEN '11' then '3'
       WHEN '12' then '3'
     END  AS 'CUATRIMESTRE'
     from MANTECA.Carrera
    -- ORDER BY 1 ASC, 2 ASC

UNION
select DISTINCT (YEAR(CARRERA_FECHA_FIN)), MONTH(CARRERA_FECHA_FIN), DAY(CARRERA_FECHA_FIN), CASE MONTH(CARRERA_FECHA_FIN)
       WHEN '1' then '1'
       WHEN '2' then '1'
       WHEN '3' then '1'
       WHEN '4' then '1'
       WHEN '5' then '2'
       WHEN '6'  then '2'
       WHEN '7' then '2'
       WHEN '8' then '2'
       WHEN '9' then '3'
       WHEN '10' then '3'
       WHEN '11' then '3'
       WHEN '12' then '3'
     END  AS 'CUATRIMESTRE'
     from MANTECA.Carrera
     --ORDER BY 1,2,3
/*UNION
select DISTINCT (YEAR(FECHA_HORA)), MONTH(FECHA_HORA), DAY(FECHA_HORA),CASE MONTH(FECHA_HORA)
       WHEN '1' then '1'
       WHEN '2' then '1'
       WHEN '3' then '1'
       WHEN '4' then '1'
       WHEN '5' then '2'
       WHEN '6'  then '2'
       WHEN '7' then '2'
       WHEN '8' then '2'
       WHEN '9' then '3'
       WHEN '10' then '3'
       WHEN '11' then '3'
       WHEN '12' then '3'
     END  AS 'CUATRIMESTRE'
     from MANTECA.Medicion*/
)INSERT INTO [MANTECA].BI_Fecha (FECHA_ANIO,FECHA_MES,FECHA_DIA,FECHA_CUATRIMESTRE) SELECT distinct 
    anio, mes,dia, cuatrimestre
    from fecha
     ORDER BY anio, mes,dia, cuatrimestre
 END;
GO

EXECUTE [GD1C2022].[MANTECA].carga_BI_Fecha;
GO

/*CREATE VIEW mejor_tiempo_vuelta AS
SELECT id_circuito, 
min ((SELECT max(tiempo_de_vuelta) FROM BI_Medicion 

GROUP BY id_circuito, nro_vuelta, id_escuderia))
FROM BI_Medicion
GROUP BY id_circuito, nro_vuelta, id_escuderia
*/