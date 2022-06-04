USE [GD1C2022]

--SELECT * FROM gd_esquema.Maestra
IF NOT EXISTS (SELECT * FROM sys.schemas where name = 'MANTECA')
BEGIN 
	EXEC ('CREATE SCHEMA [MANTECA]')
END
GO

CREATE TABLE [MANTECA].[Piloto]
	(
	[ID_PILOTO] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Piloto PRIMARY KEY,--Agergo el ID para idenficarla
	[PILOTO_NOMBRE] [nvarchar](50) NOT NULL,
	[PILOTO_APELLIDO] [nvarchar](50) NOT NULL,
	[PILOTO_NRO_DOCUMENTO] [nvarchar](15) NULL,
	[PILOTO_TIPO_DOCUMENTO] [nvarchar](5) NULL,
	[PILOTO_NACIONALIDAD] [nvarchar] (50) NOT NULL,
	[PILOTO_FECHA_NACIMIENTO] [date] NOT NULL,
	--UNIQUE (PILOTO_NRO_DOCUMENTO, PILOTO_TIPO_DOCUMENTO)
	)
GO	

CREATE TABLE [MANTECA].[Escuderia]
	(
	[ID_ESCUDERIA] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Escuderia PRIMARY KEY,--Agergo el ID para idenficarla
	[ESCUDERIA_NOMBRE] [nvarchar](255) NOT NULL,
	[ESCUDERIA_NACIONALIDAD] [nvarchar] (255) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Auto]
	(
	[ID_AUTO] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Auto PRIMARY KEY,--Agergo el ID para idenficarla
	[AUTO_NUMERO] int NOT NULL,
	[ID_ESCUDERIA] int NOT NULL,							--FK a Escuderia o lo relaciono con el ID de la escuderia
	[AUTO_MODELO] [nvarchar](255) NOT NULL,
	[AUTO_DESCRIPCION] [nvarchar] (255) NULL,
	--UNIQUE(AUTO_DESCRIPCION)
	)
GO		

CREATE TABLE [MANTECA].[Medicion]
	(
	[ID_MEDICION] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Medicion PRIMARY KEY,--Agergo el ID para idenficarla --FK
	[FECHA_HORA] [datetime] NULL,
	[ID_CARRERA] int NOT NULL,							    --FK a Carrera o lo relaciono con el ID de la carrera
	[ID_SECTOR] int NOT NULL,							    --FK a Sector o lo relaciono con el ID deL sector
	[DISTANCIA_RECORRIDA_CARRERA] [decimal] (18,6) NOT NULL,
	[ID_AUTO] int NOT NULL                             --FK a Auto o lo relaciono con el ID del auto
	)
GO	

CREATE TABLE [MANTECA].[Medicion_Auto]
	(
	[ID_MEDICION] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Medicion_Auto PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_AUTO] int NOT NULL,                             --FK a Auto o lo relaciono con el ID del auto
	[ID_PILOTO] int NOT NULL,							    --FK a Piloto o lo relaciono con el ID del piloto
	[VUELTA_NUMERO] [decimal](18,0) NOT NULL,
	[DISTANCIA_RECORRIDA_VUELTA] [decimal] (18,2) NOT NULL,
	[TIEMPO_DE_VUELTA] [decimal] (18,10) NOT NULL,
	[POSICION] [decimal] (18,0) NOT NULL,
	[VELOCIDAD] [decimal] (18,2) NOT NULL,
	[COMBUSTIBLE] [decimal] (18,2) NOT NULL
	)
GO

CREATE TABLE [MANTECA].[Medicion_Motor]
	(
	[ID_MEDICION] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Medicion_Motor PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_MOTOR] int NOT NULL,                             --FK a Motor o lo relaciono con el ID del motor
	[POTENCIA_MOMENTANEA] [decimal](18,6) NOT NULL,
	[TEMP_ACEITE] [decimal] (18,6) NOT NULL,
	[TEMP_AGUA] [decimal] (18,6) NOT NULL,
	[RPM] [decimal] (18,6) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Medicion_Neumatico]
	(
	[ID_MEDICION] int NOT NULL,--Agergo el ID para idenficarla
	[PROFUNDIDAD] [decimal] (18,6) NOT NULL,
	[POSICION] [nvarchar](255) NOT NULL,                     --PK
	[PRESION] [decimal] (18,6) NOT NULL,
	[TEMPERATURA] [decimal] (18,6) NOT NULL,
	[ID_NEUMATICO] int NOT NULL,							    --FK a Neumatico o lo relaciono con el ID del neumatico
	PRIMARY KEY(ID_MEDICION, POSICION)
	)
GO	

CREATE TABLE [MANTECA].[Medicion_Frenos]
	(
	[ID_MEDICION] int IDENTITY (1, 1) NOT NULL,--Agergo el ID para idenficarla
	[GROSOR_PASTILLA] [decimal] (18,2) NOT NULL,
	[POSICION] [nvarchar](255) NOT NULL,                     --PK
	[TEMPERATURA] [decimal] (18,2) NOT NULL,
	[ID_FRENO] int NOT NULL,							    --FK a Freno o lo relaciono con el ID del freno
	PRIMARY KEY(ID_MEDICION, POSICION)
	)
GO	

CREATE TABLE [MANTECA].[Medicion_Caja_De_Cambios]
	(
	[ID_MEDICION] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Medicion_Caja PRIMARY KEY,--Agergo el ID para idenficarla
	[CAJA] [nvarchar] (255) NOT NULL,
	[TEMPERATURA_ACEITE] [decimal] (18,2) NOT NULL,
	[RPM] [decimal] (18,2) NOT NULL,
	[DESGASTE_PORCENTUAL_ACUMULADO] [decimal] (18,2) NOT NULL,
	[ID_CAJA_CAMBIO] int NOT NULL,							    --FK a Caja de cambios o lo relaciono con el ID de la caja de cambios
	)
GO	

CREATE TABLE [MANTECA].[Motor]
	(
	[ID_MOTOR] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Motor PRIMARY KEY,--Agergo el ID para idenficarla
	[MODELO] [nvarchar](255) NOT NULL,
	[NRO_SERIE] [nvarchar] (255) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Neumatico]
	(
	[ID_NEUMATICO] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Neumatico PRIMARY KEY,--Agergo el ID para idenficarla
	[NEUMATICO_NOMBRE] [nvarchar](255) NULL,
	[NEUMATICO_TIPO] [nvarchar] (255) NULL,
	[NRO_SERIE] [nvarchar] (255) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Freno]
	(
	[ID_FRENO] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Freno PRIMARY KEY,--Agergo el ID para idenficarla
	[FRENO_NOMBRE] [nvarchar](255) NULL,
	[NRO_SERIE] [nvarchar] (255) NOT NULL,
	[TAMANIO_DISCO] [decimal] (18,2) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Caja_de_Cambios]
	(
	[ID_CAJA_CAMBIO] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Caja_Cambio PRIMARY KEY,--Agergo el ID para idenficarla
	[CAJA_CAMBIO_NOMBRE] [nvarchar](255) NULL,
	[CAJA_CAMBIO_MODELO] [nvarchar] (50) NOT NULL,
	[NRO_SERIE] [nvarchar] (255) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Carrera]
	(
	[ID_CARRERA] int NOT NULL CONSTRAINT PK_Carrera PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_CIRCUITO] int NOT NULL,                             --FK a circuito o lo relaciono con el ID del circuito
	[CARRERA_FECHA_INICIO] [DATE] NOT NULL,
	[CARRERA_FECHA_FIN] [DATE] NULL,
	[VUELTAS_TOTAL] int NOT NULL,
	[CARRERA_CLIMA] [nvarchar] (100) NOT NULL,
	[CARRERA_LONGITUD] [decimal] (18,2) NOT NULL
	)
GO

CREATE TABLE [MANTECA].[Circuito]
	(
	[ID_CIRCUITO] int NOT NULL CONSTRAINT PK_Circuito PRIMARY KEY,--Agergo el ID para idenficarla
	[CIRCUITO_NOMBRE] [nvarchar](255) NOT NULL,
	[CIRCUITO_DESCRIPCION] [nvarchar] (50) NULL,
	[CIRCUITO_PAIS] [nvarchar] (255) NOT NULL
	)
GO	

CREATE TABLE [MANTECA].[Sector]
	(
	[ID_SECTOR] int NOT NULL CONSTRAINT PK_Sector PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_CIRCUITO] int NOT NULL,                             --FK a circuito o lo relaciono con el ID del circuito
	[SECTOR_NOMBRE] [nvarchar] (255) NULL,
	[SECTOR_DESCRIPCION] [nvarchar] (255) NULL,
	[SECTOR_LONGITUD] [decimal] (18,2) NOT NULL,
	[SECTOR_TIPO] [nvarchar] (255) NOT NULL
	)
GO

CREATE TABLE [MANTECA].[Incidente]
	(
	[ID_INCIDENTE] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Incidente PRIMARY KEY,--Agergo el ID para idenficarla
	[INCIDENTE_TIEMPO] [decimal] (18,10) NULL,
	[INCIDENTE_BANDERA] [nvarchar] (255) NULL,
	[ID_SECTOR] int NOT NULL                             --FK a Sector o lo relaciono con el ID del Sector
	)
GO

CREATE TABLE [MANTECA].[Auto_Incidentado]
	(
	[ID_AUTO_INCIDENTADO] int NOT NULL IDENTITY (1, 1),
	[ID_INCIDENTE] int NOT NULL,  --PK,FK
	[ID_AUTO] int NOT NULL,  --PK, FK
	[ID_TIPO_INCIDENTE] int NOT NULL, --FK a Tipo Incidente
	[NRO_VUELTA] [decimal] (18,0) NULL,
	PRIMARY KEY(ID_AUTO_INCIDENTADO, ID_INCIDENTE, ID_AUTO)
	)
GO

CREATE TABLE [MANTECA].[Tipo_Incidente]
	(
	[ID_TIPO_INCIDENTE] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Tipo_Incidente PRIMARY KEY,--Agergo el ID para idenficarla
	[TIPO_INCIDENTE] [nvarchar] (255) NULL,
	[TIPO_INCIDENTE_DESCRIPCION] [nvarchar] (255) NULL                          
	)
GO

CREATE TABLE [MANTECA].[Parada_En_Box]
	(
	[ID_PARADA] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Parada_Box PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_AUTO] int NOT NULL,                             --FK a Auto o lo relaciono con el ID del auto
	[NUMERO_VUELTA] [decimal] (18,0) NULL,
	[PARADA_DURACION] [decimal] (18,2) NULL
	)
GO

CREATE TABLE [MANTECA].[Cambio_De_Neumatico]
	(
	[ID_CAMBIO_NEUMATICO] int NOT NULL IDENTITY (1, 1) CONSTRAINT PK_Cambio_Neumatico PRIMARY KEY,--Agergo el ID para idenficarla
	[ID_NEUMATICO_ANTERIOR] int NOT NULL,                             --FK a Neumatico o lo relaciono con el ID del Neumatico anterior
	[ID_NEUMATICO_NUEVO] int NOT NULL,                             --FK a Neumatico o lo relaciono con el ID del Neumatico nuevo
	[ID_PARADA] int NOT NULL,                             --FK a Parada o lo relaciono con el ID de la Parada
	[POSICION] [nvarchar] (255) NULL
	)
GO

--Se agregan las FK

--Auto
ALTER TABLE [MANTECA].[Auto]
ADD CONSTRAINT FK_ESCUDERIA FOREIGN KEY(ID_ESCUDERIA) REFERENCES [MANTECA].Escuderia(ID_ESCUDERIA);

--Medicion
--ALTER TABLE [MANTECA].[Medicion]
--ADD CONSTRAINT FK_MEDICION FOREIGN KEY(ID_MEDICION) REFERENCES [MANTECA].Medicion_Auto(ID_MEDICION);--, [MANTECA].Medicion_Motor(ID_MEDICION), [MANTECA].Medicion_Neumatico(ID_MEDICION), [MANTECA].Medicion_Frenos(ID_MEDICION), [MANTECA].Medicion_Caja_De_Cambios(ID_MEDICION);

ALTER TABLE [MANTECA].[Medicion]
ADD CONSTRAINT FK_CARRERA FOREIGN KEY(ID_CARRERA) REFERENCES [MANTECA].Carrera(ID_CARRERA);

ALTER TABLE [MANTECA].[Medicion]
ADD CONSTRAINT FK_SECTOR_MEDICION FOREIGN KEY(ID_SECTOR) REFERENCES [MANTECA].Sector(ID_SECTOR);

ALTER TABLE [MANTECA].[Medicion]
ADD CONSTRAINT FK_AUTO_MEDICION FOREIGN KEY(ID_AUTO) REFERENCES [MANTECA].Auto(ID_AUTO);

--Medicion Auto
ALTER TABLE [MANTECA].[Medicion_Auto]
ADD CONSTRAINT FK_NRO_AUTO FOREIGN KEY(ID_AUTO) REFERENCES [MANTECA].Auto(ID_AUTO);

ALTER TABLE [MANTECA].[Medicion_Auto]
ADD CONSTRAINT FK_PILOTO FOREIGN KEY(ID_PILOTO) REFERENCES [MANTECA].Piloto(ID_PILOTO);

--Medicion Motor
ALTER TABLE [MANTECA].[Medicion_Motor]
ADD CONSTRAINT FK_MOTOR FOREIGN KEY(ID_MOTOR) REFERENCES [MANTECA].Motor(ID_MOTOR);

--Medicion Neumatico
ALTER TABLE [MANTECA].[Medicion_Neumatico]
ADD CONSTRAINT FK_NEUMATICO FOREIGN KEY(ID_NEUMATICO) REFERENCES [MANTECA].Neumatico(ID_NEUMATICO);

--Medicion Freno
ALTER TABLE [MANTECA].[Medicion_Frenos]
ADD CONSTRAINT FK_FRENO FOREIGN KEY(ID_FRENO) REFERENCES [MANTECA].Freno(ID_FRENO);

--Medicion Caja De Cambios
ALTER TABLE [MANTECA].[Medicion_Caja_De_Cambios]
ADD CONSTRAINT FK_CAJA_CAMBIO FOREIGN KEY(ID_CAJA_CAMBIO) REFERENCES [MANTECA].Caja_De_Cambios(ID_CAJA_CAMBIO);

--Carrera
ALTER TABLE [MANTECA].[Carrera]
ADD CONSTRAINT FK_CIRCUITO_CARRERA FOREIGN KEY(ID_CIRCUITO) REFERENCES [MANTECA].Circuito(ID_CIRCUITO);

--Sector
ALTER TABLE [MANTECA].[Sector]
ADD CONSTRAINT FK_CIRCUITO_SECTOR FOREIGN KEY(ID_CIRCUITO) REFERENCES [MANTECA].Circuito(ID_CIRCUITO);

--Incidente
ALTER TABLE [MANTECA].[Incidente]
ADD CONSTRAINT FK_SECTOR_INCIDENTE FOREIGN KEY(ID_SECTOR) REFERENCES [MANTECA].Sector(ID_SECTOR);

--Auto Incidentado
ALTER TABLE [MANTECA].[Auto_Incidentado]
ADD CONSTRAINT FK_INCIDENTE FOREIGN KEY(ID_INCIDENTE) REFERENCES [MANTECA].Incidente(ID_INCIDENTE);

ALTER TABLE [MANTECA].[Auto_Incidentado]
ADD CONSTRAINT FK_NUMERO_AUTO FOREIGN KEY(ID_AUTO) REFERENCES [MANTECA].Auto(ID_AUTO);

ALTER TABLE [MANTECA].[Auto_Incidentado]
ADD CONSTRAINT FK_TIPO_INCIDENTE FOREIGN KEY(ID_TIPO_INCIDENTE) REFERENCES [MANTECA].Tipo_Incidente(ID_TIPO_INCIDENTE);

--Parada en Box
ALTER TABLE [MANTECA].[Parada_En_Box]
ADD CONSTRAINT FK_AUTO_PARADA FOREIGN KEY(ID_AUTO) REFERENCES [MANTECA].Auto(ID_AUTO);

--Cambio De Neumaticos
ALTER TABLE [MANTECA].[Cambio_De_Neumatico]
ADD CONSTRAINT FK_NEUMATICO_ANTERIOR FOREIGN KEY(ID_NEUMATICO_ANTERIOR) REFERENCES [MANTECA].Neumatico(ID_NEUMATICO);

ALTER TABLE [MANTECA].[Cambio_De_Neumatico]
ADD CONSTRAINT FK_NEUMATICO_NUEVO FOREIGN KEY(ID_NEUMATICO_NUEVO) REFERENCES [MANTECA].Neumatico(ID_NEUMATICO);

ALTER TABLE [MANTECA].[Cambio_De_Neumatico]
ADD CONSTRAINT FK_PARADA FOREIGN KEY(ID_PARADA) REFERENCES [MANTECA].Parada_En_Box(ID_PARADA);