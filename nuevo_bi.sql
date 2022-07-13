USE [GD1C2022]

CREATE TABLE [MANTECA].[BI_Fecha] (
	ID_FECHA int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Fecha PRIMARY KEY,
	FECHA_ANIO INT,
	FECHA_MES INT,
	FECHA_DIA INT,
	FECHA_CUATRIMESTRE TINYINT
);

CREATE TABLE [MANTECA].[BI_Auto] (
    id_auto INT NOT NULL,
	id_escuderia INT,
    PRIMARY KEY (id_auto)
);

CREATE TABLE [MANTECA].[BI_Escuderia] (
    id_escuderia INT NOT NULL,
	nombre nvarchar(255),
    PRIMARY KEY (id_escuderia)
);

CREATE TABLE [MANTECA].[BI_Piloto] (
    id_piloto INT NOT NULL,
    PRIMARY KEY (id_piloto),
);

CREATE TABLE [MANTECA].[BI_Tipo_Neumatico](
	id_tipo_neumatico INT IDENTITY(1,1) NOT NULL,
	descripcion nvarchar(255)
	PRIMARY KEY (id_tipo_neumatico)
);

CREATE TABLE [MANTECA].[BI_Tipo_Sector] (
	id_tipo_sector INT IDENTITY(1,1) NOT NULL,
	descripcion nvarchar(255),
	PRIMARY KEY (id_tipo_sector)
);

CREATE TABLE [MANTECA].[BI_Circuito] (
    id_circuito INT NOT NULL,
	id_carrera INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    PRIMARY KEY (id_carrera)
);

CREATE TABLE [MANTECA].[BI_Tipo_incidente] (
    id_tipo_incidente INT IDENTITY(1,1) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tipo_incidente)
);

CREATE TABLE [MANTECA].[BI_Parada_en_box] (
	id_parada INT,
    id_circuito INT  NULL,
    id_auto INT  NULL,
	id_escuderia INT NULL,
    id_fecha INT NOT NULL,
    duracion DECIMAL(18,2)  NULL,
    PRIMARY KEY (id_parada)
);

CREATE TABLE [MANTECA].[BI_Incidente] (
	id_circuito INT NOT NULL,
    id_tipo_sector INT NOT NULL,
	id_escuderia INT NOT NULL,
    id_fecha INT NOT NULL,
    id_tipo_incidente VARCHAR(255) NULL,
);

ALTER TABLE [MANTECA].[BI_Parada_en_box]
ADD
FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
FOREIGN KEY (id_escuderia) REFERENCES [MANTECA].BI_Escuderia,
FOREIGN KEY (id_circuito) REFERENCES [MANTECA].BI_Circuito

ALTER TABLE [MANTECA].[BI_Incidente]
ADD
FOREIGN KEY (id_tipo_sector) REFERENCES [MANTECA].BI_Tipo_Sector,
FOREIGN KEY (id_circuito) REFERENCES [MANTECA].BI_Circuito,
FOREIGN KEY (id_auto) REFERENCES [MANTECA].BI_Auto,
FOREIGN KEY (id_escuderia) REFERENCES [MANTECA].BI_Escuderia,
FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
FOREIGN KEY (id_tipo_incidente) REFERENCES [MANTECA].BI_Tipo_incidente


INSERT INTO MANTECA.BI_Fecha
(FECHA_ANIO, FECHA_MES, FECHA_DIA, FECHA_CUATRIMESTRE)
SELECT (YEAR(CARRERA_FECHA_INICIO)) AS 'ANIO', MONTH(CARRERA_FECHA_INICIO) 'MES', DAY(CARRERA_FECHA_INICIO) 'DIA', CASE MONTH(CARRERA_FECHA_INICIO)
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

INSERT INTO MANTECA.BI_Auto
(id_auto, id_escuderia)
SELECT a.ID_AUTO, a.ID_ESCUDERIA
FROM MANTECA.Auto a
JOIN MANTECA.Escuderia e ON e.ID_ESCUDERIA = a.ID_ESCUDERIA

INSERT INTO MANTECA.BI_Escuderia
(id_escuderia,nombre)
SELECT ID_ESCUDERIA,ESCUDERIA_NOMBRE
FROM MANTECA.Escuderia

INSERT INTO MANTECA.BI_Piloto
(id_piloto)
SELECT ID_PILOTO FROM MANTECA.PILOTO 

INSERT INTO MANTECA.BI_Tipo_Neumatico
(descripcion)
SELECT DISTINCT NEUMATICO_TIPO FROM MANTECA.Neumatico

INSERT INTO MANTECA.BI_Tipo_Sector
(descripcion)
SELECT DISTINCT SECTOR_TIPO FROM MANTECA.Sector

INSERT INTO MANTECA.BI_Circuito
(id_carrera,fecha_inicio, id_circuito)
SELECT ID_CARRERA,CARRERA_FECHA_INICIO, ca.ID_CIRCUITO FROM MANTECA.Carrera ca
JOIN MANTECA.Circuito c ON c.ID_CIRCUITO = ca.ID_CIRCUITO

INSERT INTO MANTECA.BI_Tipo_incidente
(tipo)
SELECT DISTINCT TIPO_INCIDENTE FROM MANTECA.Tipo_Incidente

INSERT INTO MANTECA.BI_Parada_en_box
(id_parada, id_circuito, id_auto, id_escuderia, id_fecha, duracion)
SELECT DISTINCT pb.ID_PARADA, pb.ID_CIRCUITO, pb.ID_AUTO,a.id_escuderia, f.ID_FECHA ,pb.PARADA_DURACION 
FROM MANTECA.Parada_En_Box pb 
JOIN MANTECA.BI_Auto a ON a.id_auto = pb.ID_AUTO
JOIN MANTECA.BI_Circuito c ON pb.ID_CIRCUITO = c.id_circuito
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(c.fecha_inicio) AND f.FECHA_MES = MONTH(c.fecha_inicio) AND f.FECHA_DIA = DAY(c.fecha_inicio)
GROUP BY pb.ID_PARADA, pb.ID_AUTO, pb.PARADA_DURACION, f.ID_FECHA,pb.ID_CIRCUITO,a.id_escuderia

INSERT INTO MANTECA.BI_Incidente 
( id_circuito, id_tipo_sector, id_auto,id_escuderia, id_fecha,id_tipo_incidente)
SELECT s.ID_CIRCUITO ,ts.id_tipo_sector, a.id_escuderia,  f.ID_FECHA, bti.id_tipo_incidente  
FROM MANTECA.Auto_Incidentado ai
JOIN MANTECA.BI_Auto a ON ai.ID_AUTO = a.id_auto
JOIN MANTECA.Sector s ON ai.ID_SECTOR = s.ID_SECTOR
JOIN MANTECA.BI_Tipo_Sector ts ON ts.descripcion = s.SECTOR_TIPO
JOIN MANTECA.Tipo_Incidente ti ON ti.ID_TIPO_INCIDENTE = ai.ID_TIPO_INCIDENTE
JOIN MANTECA.BI_Tipo_incidente bti ON bti.tipo = ti.TIPO_INCIDENTE
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(ai.carrera_fecha) AND f.FECHA_MES = MONTH(ai.carrera_fecha) AND f.FECHA_DIA = DAY(ai.carrera_fecha)
GROUP BY s.ID_CIRCUITO,ts.id_tipo_sector,a.id_escuderia,f.ID_FECHA,bti.id_tipo_incidente

