USE [GD1C2022]
CREATE TABLE [MANTECA].[BI_Auto] (
    id_auto INT NOT NULL,
    nro_auto INT NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    escuderia_nombre VARCHAR(255) NOT NULL,
    escuderia_nacionalidad VARCHAR(255) NOT NULL,
	id_escuderia INT NOT NULL,
    PRIMARY KEY (id_auto)
);

INSERT INTO MANTECA.BI_Auto
(id_auto, nro_auto, modelo, escuderia_nombre, escuderia_nacionalidad, id_escuderia)
SELECT a.ID_AUTO, a.AUTO_NUMERO, a.AUTO_MODELO, e.ESCUDERIA_NOMBRE, e.ESCUDERIA_NACIONALIDAD, a.ID_ESCUDERIA
FROM MANTECA.Auto a
JOIN MANTECA.Escuderia e ON e.ID_ESCUDERIA = a.ID_ESCUDERIA

CREATE TABLE [MANTECA].[BI_Piloto] (
    id_piloto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY (id_piloto),
);

INSERT INTO MANTECA.BI_Piloto
(id_piloto, nombre, apellido, nacionalidad, fecha_nacimiento)
SELECT P.ID_PILOTO, P.PILOTO_NOMBRE, P.PILOTO_APELLIDO, P.PILOTO_NACIONALIDAD, P.PILOTO_FECHA_NACIMIENTO FROM MANTECA.PILOTO P

CREATE TABLE [MANTECA].[BI_Carrera] (
    id_carrera INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    vueltas_totales INT NOT NULL,
    clima VARCHAR(100) NOT NULL,
    longitud DECIMAL(18,2) NOT NULL,
    circuito_nombre VARCHAR(255) NOT NULL,
    circuito_pais VARCHAR(255) NOT NULL,
	id_circuito INT NOT NULL,
    PRIMARY KEY (id_carrera)
);

INSERT INTO MANTECA.BI_Carrera
(id_carrera,fecha_inicio,vueltas_totales,clima,longitud,circuito_nombre, circuito_pais, id_circuito)
SELECT ID_CARRERA,CARRERA_FECHA_INICIO,VUELTAS_TOTAL,CARRERA_CLIMA,CARRERA_LONGITUD,CIRCUITO_NOMBRE, CIRCUITO_PAIS, ca.ID_CIRCUITO FROM MANTECA.Carrera ca
JOIN MANTECA.Circuito c ON c.ID_CIRCUITO = ca.ID_CIRCUITO


CREATE TABLE [MANTECA].[BI_Sector] (
    id_sector INT NOT NULL,
    longitud DECIMAL(18,2) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    circuito_nombre VARCHAR(255) NOT NULL,
    circuito_pais VARCHAR(255) NOT NULL,
	id_circuito INT NOT NULL,
    PRIMARY KEY (id_sector)
);

INSERT INTO MANTECA.BI_Sector
(id_sector, longitud, tipo, circuito_nombre, circuito_pais, id_circuito)
SELECT ID_SECTOR, SECTOR_LONGITUD, SECTOR_TIPO, CIRCUITO_NOMBRE, CIRCUITO_PAIS, s.ID_CIRCUITO
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
    tipo VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_neumático)
);

INSERT INTO MANTECA.BI_Neumatico
(id_neumático, tipo, nro_serie)
SELECT ID_NEUMATICO, NEUMATICO_TIPO, NRO_SERIE FROM MANTECA.Neumatico

CREATE TABLE [MANTECA].[BI_Caja_de_cambios] (
    id_caja_cambio INT NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_caja_cambio)
);

INSERT INTO MANTECA.BI_Caja_de_cambios
(id_caja_cambio, modelo, nro_serie)
SELECT C.ID_CAJA_CAMBIO, C.CAJA_CAMBIO_MODELO, C.NRO_SERIE FROM MANTECA.Caja_de_cambios C

CREATE TABLE [MANTECA].[BI_Tipo_incidente] (
    id_tipo_incidente INT NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tipo_incidente)
);

INSERT INTO MANTECA.BI_Tipo_incidente
(id_tipo_incidente, tipo)
SELECT T.ID_TIPO_INCIDENTE, T.TIPO_INCIDENTE FROM MANTECA.Tipo_Incidente T

CREATE TABLE [MANTECA].[BI_Fecha] (
	ID_FECHA int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Fecha PRIMARY KEY,
	FECHA_ANIO INT,
	FECHA_MES INT,
	FECHA_DIA INT,
	FECHA_CUATRIMESTRE TINYINT
);

INSERT INTO MANTECA.BI_Fecha
(FECHA_ANIO, FECHA_MES, FECHA_DIA, FECHA_CUATRIMESTRE)
SELECT (YEAR(CARRERA_FECHA_INICIO)) AS 'ANIO', MONTH(CARRERA_FECHA_INICIO), DAY(CARRERA_FECHA_INICIO), CASE MONTH(CARRERA_FECHA_INICIO)
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
ORDER BY 1, 2, 3, 4

CREATE TABLE [MANTECA].[BI_Freno] (
    id_freno INT NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    tamanio_disco DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (id_freno)
);

INSERT INTO MANTECA.BI_freno
(id_freno,nro_serie,tamanio_disco)
SELECT ID_FRENO,NRO_SERIE,TAMANIO_DISCO FROM MANTECA.Freno f

CREATE TABLE [MANTECA].[BI_Medicion] (
    id_medicion INTEGER NOT NULL,
    id_fecha INT NULL,
    id_motor INT NOT NULL,
    id_neumatico INT NOT NULL,
    id_caja_de_cambios INT NOT NULL,
    id_piloto INT NOT NULL,
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
    freno_grosor_pastilla DECIMAL(18,2) NOT NULL,
    freno_temperatura DECIMAL(18,2) NOT NULL,
    caja_de_cambios_caja VARCHAR(255) NOT NULL,
    caja_de_cambios_temperatura_aceite DECIMAL(18,2) NOT NULL,
    caja_de_cambios_rpm DECIMAL(18,2) NOT NULL,
    caja_de_cambios_desgaste_porcentual_acumulado DECIMAL(18,2) NOT NULL,
    --PRIMARY KEY (id_fecha, id_motor, id_neumatico, id_caja_de_cambios, id_piloto, id_auto, id_sector, id_carrera, id_freno)
);

/*ALTER TABLE [MANTECA].[BI_Medicion]
ADD
FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
FOREIGN KEY (id_motor) REFERENCES [MANTECA].BI_Motor,
FOREIGN KEY (id_neumatico) REFERENCES [MANTECA].BI_Neumatico,
FOREIGN KEY (id_caja_de_cambios) REFERENCES [MANTECA].BI_Caja_de_cambios,
FOREIGN KEY (id_piloto) REFERENCES [MANTECA].BI_piloto,
FOREIGN KEY (id_auto) REFERENCES [MANTECA].BI_Auto,
FOREIGN KEY (id_sector) REFERENCES [MANTECA].BI_Sector,
FOREIGN KEY (id_carrera) REFERENCES [MANTECA].BI_Carrera,
FOREIGN KEY (id_freno) REFERENCES [MANTECA].BI_Freno
*/
INSERT INTO MANTECA.BI_Medicion
(id_fecha, id_medicion, id_motor, id_neumatico, id_caja_de_cambios, id_piloto, id_auto, id_sector, id_carrera, id_freno, combustible, distancia_recorrida_en_carrera, nro_vuelta, distancia_recorrida_en_vuelta, 
posicion, velocidad, tiempo_de_vuelta, motor_potencia_momentanea, motor_temp_aceite, motor_temp_agua, motor_rpm, neumatico_profundidad, neumatico_presion, neumatico_temperatura, freno_grosor_pastilla,
freno_temperatura, caja_de_cambios_caja, caja_de_cambios_temperatura_aceite, caja_de_cambios_rpm, caja_de_cambios_desgaste_porcentual_acumulado)
SELECT f.ID_FECHA, m.ID_MEDICION, ID_MOTOR, ID_NEUMATICO, ID_CAJA_CAMBIO, ID_PILOTO, m.ID_AUTO, ID_SECTOR, m.ID_CARRERA, ID_FRENO, COMBUSTIBLE, DISTANCIA_RECORRIDA_CARRERA, VUELTA_NUMERO, DISTANCIA_RECORRIDA_VUELTA,
ma.POSICION, VELOCIDAD, TIEMPO_DE_VUELTA, POTENCIA_MOMENTANEA, mm.TEMP_ACEITE, mm.TEMP_AGUA, mm.RPM, mn.PROFUNDIDAD, mn.PRESION, mn.TEMPERATURA, mf.GROSOR_PASTILLA,
mf.TEMPERATURA, mc.CAJA, mc.TEMPERATURA_ACEITE, mc.RPM, mc.DESGASTE_PORCENTUAL_ACUMULADO FROM MANTECA.Medicion m
JOIN MANTECA.Medicion_Auto ma ON m.ID_MEDICION = ma.ID_MEDICION
JOIN MANTECA.Medicion_Caja_De_Cambios mc ON m.ID_MEDICION = mc.ID_MEDICION
JOIN MANTECA.Medicion_Frenos mf ON m.ID_MEDICION = mf.ID_MEDICION
JOIN MANTECA.Medicion_Motor mm ON m.ID_MEDICION = mm.ID_MEDICION
JOIN MANTECA.Medicion_Neumatico mn ON m.ID_MEDICION = mn.ID_MEDICION
JOIN MANTECA.BI_Carrera c ON c.id_carrera = m.ID_CARRERA
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(c.fecha_inicio) AND f.FECHA_MES = MONTH(c.fecha_inicio) AND f.FECHA_DIA = DAY(c.fecha_inicio)



CREATE TABLE [MANTECA].[BI_Parada_en_box] (
	id_parada INT,--PRIMARY KEY,
    id_carrera INT  NULL,
   -- id_neumatico_anterior INT NULL,
   -- id_neumatico_nuevo INT NULL,
    id_auto INT  NULL,
    id_fecha INT NOT NULL,
    id_piloto INT  NULL,
    nro_vuelta DECIMAL(18,0)  NULL,
    duracion DECIMAL(18,2)  NULL,
   -- posicion VARCHAR(255)  NULL
    --PRIMARY KEY (id_carrera, id_neumatico_anterior, id_neumatico_nuevo, id_auto, id_fecha, id_piloto, id_sector)
);
/*
ALTER TABLE [MANTECA].[BI_Parada_en_box]
ADD
--FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
--FOREIGN KEY (id_neumatico_anterior) REFERENCES [MANTECA].BI_Neumatico,
--FOREIGN KEY (id_neumatico_nuevo) REFERENCES [MANTECA].BI_Neumatico,
--FOREIGN KEY (id_auto) REFERENCES [MANTECA].BI_Auto,
--FOREIGN KEY (id_carrera) REFERENCES [MANTECA].BI_Carrera,
--FOREIGN KEY (id_piloto) REFERENCES [MANTECA].BI_Piloto,
--FOREIGN KEY (id_sector) REFERENCES [MANTECA].BI_Sector*/

INSERT INTO MANTECA.BI_Parada_en_box
(id_parada, id_carrera, id_auto, nro_vuelta, id_piloto, duracion, id_fecha)
SELECT DISTINCT TOP 1000  pb.ID_PARADA, c.ID_CARRERA, pb.ID_AUTO, pb.NUMERO_VUELTA, ma.ID_PILOTO, pb.PARADA_DURACION, f.ID_FECHA
FROM MANTECA.Parada_En_Box pb
JOIN MANTECA.Medicion_Auto ma ON ma.ID_AUTO = pb.ID_AUTO AND pb.NUMERO_VUELTA = ma.VUELTA_NUMERO
JOIN MANTECA.Carrera c ON pb.ID_CIRCUITO = c.ID_CIRCUITO
--LEFT JOIN MANTECA.Medicion m ON m.ID_MEDICION = ma.ID_MEDICION
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(c.CARRERA_FECHA_INICIO) AND f.FECHA_MES = MONTH(c.CARRERA_FECHA_INICIO) AND f.FECHA_DIA = DAY(c.CARRERA_FECHA_INICIO)
--GROUP BY pb.ID_PARADA, m.ID_CARRERA, cn.ID_NEUMATICO_ANTERIOR, cn.ID_NEUMATICO_NUEVO, pb.ID_AUTO,NUMERO_VUELTA, ma.ID_PILOTO, m.ID_SECTOR, pb.PARADA_DURACION, cn.POSICION

CREATE TABLE [MANTECA].[BI_Incidente] (
	id_incidente INT NOT NULL,
    id_sector INT NOT NULL,
    --id_carrera INT NOT NULL,
    id_auto INT NOT NULL,
    id_fecha INT NOT NULL,
    tipo VARCHAR(255) NULL,
	nro_vuelta DECIMAL(18,0),
	id_auto_incidentado INT NOT NULL,
    --PRIMARY KEY (id_sector, id_carrera, id_auto, id_fecha, id_piloto)
);
/*
ALTER TABLE [MANTECA].[BI_Medicion]
ADD
--FOREIGN KEY (id_sector) REFERENCES [MANTECA].BI_Sector,
--FOREIGN KEY (id_carrera) REFERENCES [MANTECA].BI_Carrera,
--FOREIGN KEY (id_auto) REFERENCES [MANTECA].BI_Auto,
--FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
--FOREIGN KEY (id_piloto) REFERENCES [MANTECA].BI_piloto
*/
INSERT INTO MANTECA.BI_Incidente 
(id_incidente, id_sector, id_auto, tipo,nro_vuelta,id_auto_incidentado,id_fecha)
SELECT ai.ID_INCIDENTE, ai.ID_SECTOR, ai.ID_AUTO, ai.ID_TIPO_INCIDENTE , ai.NRO_VUELTA, ai.ID_AUTO_INCIDENTADO, f.ID_FECHA FROM MANTECA.Auto_Incidentado ai
--JOIN MANTECA.Auto_Incidentado ai ON ai.ID_INCIDENTE = i.ID_INCIDENTE
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(ai.carrera_fecha) AND f.FECHA_MES = MONTH(ai.carrera_fecha) AND f.FECHA_DIA = DAY(ai.carrera_fecha)
--JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(m.FECHA_HORA) AND f.FECHA_MES = MONTH(m.FECHA_HORA) AND f.FECHA_DIA = DAY(m.FECHA_HORA)
--JOIN MANTECA.Carrera c ON YEAR(CARRERA_FECHA_INICIO) = f.FECHA_ANIO AND MONTH(CARRERA_FECHA_INICIO) = f.FECHA_MES AND DAY(CARRERA_FECHA_INICIO) = f.FECHA_DIA




--VISTAS--

/* Vista modelo

CREATE VIEW Nombre_vista 
(codigo,apellido,nombre,estado) AS 
SELECT etcetc

*/


/*
 Desgaste promedio de cada componente de cada auto por vuelta por
circuito.
Tener en cuenta que, para el cálculo del desgaste de los neumáticos, se
toma la diferencia de mm del mismo entre la medición inicial y final de
cada vuelta. Lo mismo aplica para el desgaste de frenos.
Para el cálculo del desgaste del motor se toma en cuenta la perdida de
potencia. */



/*
 Mejor tiempo de vuelta de cada escudería por circuito por año.
El mejor tiempo está dado por el mínimo tiempo en que un auto logra
realizar una vuelta de un circuito.*/

CREATE VIEW mejor_tiempo_vuelta AS
SELECT id_circuito, 
min ((SELECT max(tiempo_de_vuelta) FROM BI_Medicion 

GROUP BY id_circuito, nro_vuelta, id_escuderia))
FROM BI_Medicion
GROUP BY id_circuito, nro_vuelta, id_escuderia


/*
 Los 3 de circuitos con mayor consumo de combustible promedio.*/
/*
CREATE VIEW V_circuitos_con_mayor_consumo_combustible 
(id_circuito) AS 
SELECT TOP 3 id_circuito 
FROM BI_Medicion HECHO
GROUP BY id_carrera, id_auto, id_tiempo
ORDER BY
SELECT combustible FROM BI_Medicion I WHERE min(HECHO.id_tiempo) = I.id_tiempo) group by id_carrera, id_auto, id_tiempo) - 
SELECT combustible FROM BI_Medicion I WHERE max(HECHO.id_tiempo) = I.id_tiempo) group by id_carrera, id_auto, id_tiempo)
*/
/*
 Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada
circuito.12*/



/*
 Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre.*/



/*
 Cantidad de paradas por circuito por escudería por año.*/



/*
 Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en
boxes.*/



/*
 Los 3 circuitos más peligrosos del año, en función mayor cantidad de
incidentes.*/



/*
 Promedio de incidentes que presenta cada escudería por año en los
distintos tipo de sectores
*/