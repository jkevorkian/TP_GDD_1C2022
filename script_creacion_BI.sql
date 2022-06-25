USE [GD1C2022]

CREATE TABLE [MANTECA].BI_Fecha(
FECHA_NRO int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Fecha PRIMARY KEY,
FECHA_ANIO INT,
FECHA_MES INT,
FECHA_DIA INT,
FECHA_CUATRIMESTRE TINYINT
)
GO

CREATE TABLE [MANTECA].[BI_Auto]
	(
	[ID_AUTO] int NOT NULL CONSTRAINT PK_BI_Auto PRIMARY KEY,--Agrego el ID para idenficarla
	[ID_ESCUDERIA] int NOT NULL,							--FK a Escuderia o lo relaciono con el ID de la escuderia
	[ID_PARADA] int NOT NULL
	)
GO

CREATE TABLE [MANTECA].[BI_Sector]
	(
	[ID_SECTOR] int NOT NULL CONSTRAINT PK_BI_Sector PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_CIRCUITO] int NOT NULL,                             --FK a circuito o lo relaciono con el ID del circuito
	[SECTOR_TIPO] [nvarchar] (255) NOT NULL
	)
GO

CREATE TABLE [MANTECA].[BI_Parada_En_Box]
	(
	[ID_PARADA] int NOT NULL CONSTRAINT PK_BI_Parada_Box PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_AUTO] int NOT NULL,                             --FK a Auto o lo relaciono con el ID del auto
	[PARADA_DURACION] [decimal] (18,2) NULL
	)
GO

CREATE TABLE [MANTECA].[BI_Medicion_Auto]
	(
	[ID_MEDICION] int NOT NULL CONSTRAINT PK_BI_Medicion_Auto PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_AUTO] int NOT NULL,                             --FK a Auto o lo relaciono con el ID del auto
	[ID_PILOTO] int NOT NULL,							    --FK a Piloto o lo relaciono con el ID del piloto
	[VUELTA_NUMERO] [decimal](18,0) NOT NULL,
	[DISTANCIA_RECORRIDA_VUELTA] [decimal] (18,2) NOT NULL,
	[TIEMPO_DE_VUELTA] [decimal] (18,10) NOT NULL,
	[VELOCIDAD] [decimal] (18,2) NOT NULL,
	[COMBUSTIBLE] [decimal] (18,2) NOT NULL,
	[CODIGO_MEDICION] int NOT NULL --FK a Medicion
	)
GO

CREATE TABLE [MANTECA].[BI_Medicion_Motor]
	(
	[ID_MEDICION] int NOT NULL CONSTRAINT PK_BI_Medicion_Motor PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_MOTOR] int NOT NULL,                             --FK a Motor o lo relaciono con el ID del motor
	[POTENCIA_MOMENTANEA] [decimal](18,6) NOT NULL,
	[MEDICION_AUTO] int NOT NULL --FK a medicion_auto
	)
GO	

CREATE TABLE [MANTECA].[BI_Medicion_Neumatico]
	(
	[ID_MEDICION] int NOT NULL,--Agergo el ID para idenficarla
	[PROFUNDIDAD] [decimal] (18,6) NOT NULL,
	[POSICION] [nvarchar](255) NOT NULL,                     --PK
	[ID_NEUMATICO] int NOT NULL,							    --FK a Neumatico o lo relaciono con el ID del neumatico
	[MEDICION_AUTO] int NOT NULL --FK a medicion_auto
	PRIMARY KEY(ID_MEDICION, POSICION)
	)
GO	


CREATE TABLE [MANTECA].[BI_Medicion_Frenos]
	(
	[ID_MEDICION] int NOT NULL,--Agergo el ID para idenficarla
	[GROSOR_PASTILLA] [decimal] (18,2) NOT NULL,
	[POSICION] [nvarchar](255) NOT NULL,                     --PK
	[ID_FRENO] int NOT NULL,							    --FK a Freno o lo relaciono con el ID del freno
	[MEDICION_AUTO] int NOT NULL --FK a medicion_auto
	PRIMARY KEY(ID_MEDICION, POSICION)
	)
GO	

CREATE TABLE [MANTECA].[BI_Medicion_Caja_De_Cambios]
	(
	[ID_MEDICION] int NOT NULL CONSTRAINT PK_Medicion_Caja PRIMARY KEY,--Agergo el ID para idenficarla
	[DESGASTE_PORCENTUAL_ACUMULADO] [decimal] (18,2) NOT NULL,
	[ID_CAJA_CAMBIO] int NOT NULL,							    --FK a Caja de cambios o lo relaciono con el ID de la caja de cambios
	[MEDICION_AUTO] int NOT NULL --FK a medicion_auto
	)
GO	


CREATE TABLE [MANTECA].[BI_Auto_Incidentado]
	(
	[ID_AUTO_INCIDENTADO] int NOT NULL,
	[ID_INCIDENTE] int NOT NULL,  --PK,FK
	[ID_AUTO] int NOT NULL,  --PK, FK
	PRIMARY KEY(ID_AUTO_INCIDENTADO, ID_INCIDENTE, ID_AUTO)
	)
GO

CREATE TABLE [MANTECA].BI_Hecho_Desgaste(
ID_DESGASTE int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Desgaste PRIMARY KEY,
ID_AUTO int,
ID_MEDICION int, 
NUMERO_VUELTA [decimal] (18,0),
DESGASTE_MOTOR INT,
DESGASTE_NEUMATICO_DEL_DER INT,
DESGASTE_NEUMATICO_DEL_IZQ INT,
DESGASTE_NEUMATICO_TRAS_DER INT,
DESGASTE_NEUMATICO_TRAS_IZQ INT,
DESGASTE_FRENO_1 INT,
DESGASTE_FRENO_2 INT,
DESGASTE_FRENO_3 INT,
DESGASTE_FRENO_4 INT,
DESGASTE_CAJA INT
)
GO


--MIGRACION
--BI_AUTO
INSERT INTO [MANTECA].BI_AUTO
SELECT A.ID_AUTO, A.ID_ESCUDERIA FROM [MANTECA].AUTO A

--BI_SECTOR
INSERT INTO [MANTECA].BI_Sector
SELECT ID_SECTOR, ID_CIRCUITO, SECTOR_TIPO FROM [MANTECA].Sector

--BI_PARADA
INSERT INTO [MANTECA].BI_Parada_En_Box
SELECT ID_PARADA, ID_AUTO, PARADA_DURACION FROM [MANTECA].Parada_En_Box

--BI_MEDICION_AUTO
INSERT INTO [MANTECA].BI_Medicion_Auto
SELECT ID_MEDICION, ID_AUTO, ID_PILOTO, VUELTA_NUMERO, DISTANCIA_RECORRIDA_VUELTA, TIEMPO_DE_VUELTA, VELOCIDAD, COMBUSTIBLE, CODIGO_MEDICION FROM [MANTECA].Medicion_Auto

--BI_MEDICION_MOTOR
INSERT INTO [MANTECA].BI_Medicion_Motor
SELECT ID_MEDICION, ID_MOTOR, POTENCIA_MOMENTANEA, MEDICION_AUTO FROM [MANTECA].Medicion_Motor

--BI_MEDICION_NEUMATICO
INSERT INTO [MANTECA].BI_Medicion_Neumatico
SELECT ID_MEDICION, PROFUNDIDAD, POSICION ID_NEUMATICO, MEDICION_AUTO FROM [MANTECA].Medicion_Neumatico

--BI_MEDICION_FRENOS
INSERT INTO [MANTECA].BI_Medicion_Frenos
SELECT ID_MEDICION, GROSOR_PASTILLA, POSICION ID_FRENO, MEDICION_AUTO FROM [MANTECA].Medicion_Frenos

--BI_MEDICION_CAJA_DE_CAMBIOS
INSERT INTO [MANTECA].BI_Medicion_Caja_De_Cambios
SELECT ID_MEDICION, DESGASTE_PORCENTUAL_ACUMULADO, ID_CAJA_CAMBIO, MEDICION_AUTO FROM [MANTECA].Medicion_Caja_De_Cambios

--BI_AUTO_INCIDENTADO
INSERT INTO [MANTECA].BI_Auto_Incidentado
SELECT ID_AUTO_INCIDENTADO, ID_INCIDENTE, ID_AUTO FROM [MANTECA].Auto_Incidentado


--VISTA 4 M�xima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito.
CREATE VIEW
AS

GO 















		