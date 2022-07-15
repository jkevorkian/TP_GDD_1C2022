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
    id_circuito INT NOT NULL,
    id_auto INT NOT NULL,
	id_escuderia INT NOT NULL,
    id_fecha INT NOT NULL,
    duracion DECIMAL(18,2)  NULL,
    PRIMARY KEY (id_parada,id_circuito,id_auto,id_escuderia,id_fecha)
);

CREATE TABLE [MANTECA].[BI_Incidente] (
	id_circuito INT NOT NULL,
    id_tipo_sector INT NOT NULL,
	id_escuderia INT NOT NULL,
    id_fecha INT NOT NULL,
    id_tipo_incidente INT NOT NULL,
	PRIMARY KEY (id_circuito,id_tipo_sector,id_escuderia,id_fecha,id_tipo_incidente)
);

CREATE TABLE [MANTECA].[BI_Medicion] ( --circuito,tiposector?,fecha,tipoNeumatico?????,escuderia,auto
    id_fecha INT not NULL,
    --id_neumatico INT NOT NULL,
    id_escuderia INT NOT NULL,
    id_auto INT NOT NULL,
    --id_tipo_sector INT NOT NULL,
    id_circuito INT NOT NULL,
    combustible DECIMAL(18,2) NOT NULL,
    --nro_vuelta DECIMAL(18,0) NOT NULL,
    --distancia_recorrida_en_vuelta DECIMAL(18,2) NOT NULL,
    maxVelocidadFrenada DECIMAL(18,2) NOT NULL,
	maxVelocidadCurva DECIMAL(18,2) NOT NULL,
	maxVelocidadRecta DECIMAL(18,2) NOT NULL,
	vuelta_numero DECIMAL(18,10) NOT NULL,
    tiempo_de_vuelta DECIMAL(18,10) NOT NULL,
    motor_potencia_momentanea DECIMAL(18,6) NOT NULL,
    --neumatico_profundidad DECIMAL(18,6) NOT NULL,
	--neumatico_posicion nvarchar(255) NOT NULL,
    --freno_grosor_pastilla DECIMAL(18,2) NOT NULL,
	--freno_posicion nvarchar(255) NOT NULL,
    caja_de_cambios_desgaste_porcentual_acumulado DECIMAL(18,2) NOT NULL,
	neum1_desgaste DECIMAL (18,2) NULL,
	neum2_desgaste DECIMAL (18,2) NULL,
	neum3_desgaste DECIMAL (18,2) NULL,
	neum4_desgaste DECIMAL (18,2) NULL,
	freno1_desgaste DECIMAL (18,2) NULL,
    freno2_desgaste DECIMAL (18,2) NULL,
	freno3_desgaste DECIMAL (18,2) NULL,
	freno4_desgaste DECIMAL (18,2) NULL,
	--PRIMARY KEY (id_fecha,id_escuderia,id_auto,id_circuito)
);

ALTER TABLE [MANTECA].[BI_Medicion]
ADD
FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
FOREIGN KEY (id_escuderia) REFERENCES [MANTECA].BI_Escuderia,
FOREIGN KEY (id_auto) REFERENCES [MANTECA].BI_Auto,
--FOREIGN KEY (id_tipo_sector) REFERENCES [MANTECA].BI_Tipo_Sector,
FOREIGN KEY (id_circuito) REFERENCES [MANTECA].BI_Circuito
 	
ALTER TABLE [MANTECA].[BI_Parada_en_box]
ADD
FOREIGN KEY (id_fecha) REFERENCES [MANTECA].BI_Fecha,
FOREIGN KEY (id_escuderia) REFERENCES [MANTECA].BI_Escuderia,
FOREIGN KEY (id_circuito) REFERENCES [MANTECA].BI_Circuito

ALTER TABLE [MANTECA].[BI_Incidente]
ADD
FOREIGN KEY (id_tipo_sector) REFERENCES [MANTECA].BI_Tipo_Sector,
FOREIGN KEY (id_circuito) REFERENCES [MANTECA].BI_Circuito,
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
( id_circuito, id_tipo_sector,id_escuderia, id_fecha,id_tipo_incidente)
SELECT s.ID_CIRCUITO ,ts.id_tipo_sector, a.id_escuderia,  f.ID_FECHA, bti.id_tipo_incidente  
FROM MANTECA.Auto_Incidentado ai
JOIN MANTECA.BI_Auto a ON ai.ID_AUTO = a.id_auto
JOIN MANTECA.Sector s ON ai.ID_SECTOR = s.ID_SECTOR
JOIN MANTECA.BI_Tipo_Sector ts ON ts.descripcion = s.SECTOR_TIPO
JOIN MANTECA.Tipo_Incidente ti ON ti.ID_TIPO_INCIDENTE = ai.ID_TIPO_INCIDENTE
JOIN MANTECA.BI_Tipo_incidente bti ON bti.tipo = ti.TIPO_INCIDENTE
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(ai.carrera_fecha) AND f.FECHA_MES = MONTH(ai.carrera_fecha) AND f.FECHA_DIA = DAY(ai.carrera_fecha)
GROUP BY s.ID_CIRCUITO,ts.id_tipo_sector,a.id_escuderia,f.ID_FECHA,bti.id_tipo_incidente

INSERT INTO MANTECA.BI_Medicion
(id_fecha, id_escuderia, id_auto, id_circuito, combustible, maxVelocidadFrenada, maxVelocidadCurva, maxVelocidadRecta, vuelta_numero, tiempo_de_vuelta, motor_potencia_momentanea, caja_de_cambios_desgaste_porcentual_acumulado)
SELECT DISTINCT F.id_fecha,
	   BA.id_escuderia,
	   BA.id_auto,
	   BC.id_circuito,
	   ((SELECT COMBUSTIBLE FROM MANTECA.Medicion_Auto MA2
		left JOIN MANTECA.Medicion MI ON MI.ID_MEDICION=MA2.ID_MEDICION
		WHERE MA2.DISTANCIA_RECORRIDA_VUELTA=0 AND MA2.ID_AUTO=M.ID_AUTO AND MA2.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MI.ID_CARRERA=M.ID_CARRERA
		GROUP BY COMBUSTIBLE, ma2.ID_AUTO, VUELTA_NUMERO)-COMBUSTIBLE/*(SELECT COMBUSTIBLE FROM MANTECA.Medicion_Auto MA3
														   LEFT JOIN MANTECA.Medicion MF ON MF.ID_MEDICION=MA3.ID_MEDICION
													       WHERE MA3.DISTANCIA_RECORRIDA_VUELTA=149 AND MA3.ID_AUTO=M.ID_AUTO AND MA3.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MF.ID_CARRERA=M.ID_CARRERA
														   GROUP BY COMBUSTIBLE, MA3.ID_AUTO, VUELTA_NUMERO)*/) AS 'CONSUMO COMBUSTIBLE POR VUELTA',
	   (SELECT MAX(VELOCIDAD) FROM MANTECA.Medicion_Auto MVF
	    JOIN MANTECA.MEDICION MF ON MF.ID_MEDICION=MVF.ID_MEDICION
		WHERE MVF.ID_AUTO=M.ID_AUTO AND MVF.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MF.ID_SECTOR IN (SELECT ID_SECTOR FROM MANTECA.SECTOR WHERE SECTOR_TIPO='Frenada')) as 'Velocidad Frenada',
		(SELECT MAX(VELOCIDAD) FROM MANTECA.Medicion_Auto MVC
	    JOIN MANTECA.MEDICION MC ON MC.ID_MEDICION=MVC.ID_MEDICION
		WHERE MVC.ID_AUTO=M.ID_AUTO AND MVC.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MC.ID_SECTOR IN (SELECT ID_SECTOR FROM MANTECA.SECTOR WHERE SECTOR_TIPO='Curva')) as 'Velocidad Curva',
		(SELECT MAX(VELOCIDAD) FROM MANTECA.Medicion_Auto MVR
	    JOIN MANTECA.MEDICION MR ON MR.ID_MEDICION=MVR.ID_MEDICION
		WHERE MVR.ID_AUTO=M.ID_AUTO AND MVR.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MR.ID_SECTOR IN (SELECT ID_SECTOR FROM MANTECA.SECTOR WHERE SECTOR_TIPO='Recta')) as 'Velocidad Recta',
		MA.VUELTA_NUMERO,
		MA.TIEMPO_DE_VUELTA,
		((SELECT POTENCIA_MOMENTANEA FROM MANTECA.Medicion_Motor MM
		LEFT JOIN MANTECA.Medicion MI ON MI.ID_MEDICION=MM.ID_MEDICION
		LEFT JOIN MANTECA.Medicion_Auto MAI ON MM.ID_MEDICION=MAI.ID_MEDICION
		WHERE MAI.DISTANCIA_RECORRIDA_VUELTA=0 AND MAI.ID_AUTO=M.ID_AUTO AND MAI.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MI.ID_CARRERA=M.ID_CARRERA
		GROUP BY POTENCIA_MOMENTANEA, MAI.ID_AUTO, VUELTA_NUMERO)-(SELECT POTENCIA_MOMENTANEA FROM MANTECA.Medicion_Motor MMF
														   LEFT JOIN MANTECA.Medicion MF ON MF.ID_MEDICION=MMF.ID_MEDICION
														   LEFT JOIN MANTECA.Medicion_Auto MAF ON MMF.ID_MEDICION=MAF.ID_MEDICION
													       WHERE MAF.DISTANCIA_RECORRIDA_VUELTA=149 AND MAF.ID_AUTO=M.ID_AUTO AND MAF.VUELTA_NUMERO=MA.VUELTA_NUMERO AND MF.ID_CARRERA=M.ID_CARRERA
														   GROUP BY POTENCIA_MOMENTANEA, MAF.ID_AUTO, VUELTA_NUMERO)) AS 'DESGASTE MOTOR POR VUELTA',
		MC.DESGASTE_PORCENTUAL_ACUMULADO
FROM MANTECA.Medicion M
JOIN MANTECA.BI_Auto BA ON M.id_auto=BA.id_auto
JOIN MANTECA.BI_Circuito BC ON M.ID_CARRERA=BC.id_carrera
--JOIN MANTECA.Sector S ON S.ID_SECTOR=M.ID_SECTOR
--JOIN MANTECA.BI_Tipo_Sector TS ON TS.descripcion=S.SECTOR_TIPO
JOIN MANTECA.BI_Fecha f ON f.FECHA_ANIO = YEAR(BC.fecha_inicio) AND f.FECHA_MES = MONTH(BC.fecha_inicio) AND f.FECHA_DIA = DAY(BC.fecha_inicio)
JOIN MANTECA.Medicion_Auto MA ON MA.ID_MEDICION=M.ID_MEDICION
JOIN MANTECA.Medicion_Caja_De_Cambios MC ON MC.ID_MEDICION=M.ID_MEDICION
WHERE MA.DISTANCIA_RECORRIDA_VUELTA=149
GROUP BY F.id_fecha, BA.id_escuderia, BA.id_auto, /*TS.id_tipo_sector,*/ BC.id_circuito, COMBUSTIBLE, M.ID_MEDICION,M.ID_AUTO,MA.VUELTA_NUMERO, M.ID_CARRERA, MA.TIEMPO_DE_VUELTA, MC.DESGASTE_PORCENTUAL_ACUMULADO
ORDER BY 4 DESC ,3 DESC, 9 asc  

--PROCEDURES CARGA DESGASTES NEUMATICOS Y FRENOS
GO
CREATE PROC CargaDesgastesNeumaticosDelDer
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mn.PROFUNDIDAD-mnf.PROFUNDIDAD), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Neumatico MN
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Neumatico mnf ON mnf.ID_NEUMATICO = mn.ID_NEUMATICO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mnf.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mn.POSICION='Delantero Derecho' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mn.POSICION = mnf.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET neum1_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

CREATE PROC CargaDesgastesNeumaticosDelIzq
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mn.PROFUNDIDAD-mnf.PROFUNDIDAD), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Neumatico MN
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Neumatico mnf ON mnf.ID_NEUMATICO = mn.ID_NEUMATICO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mnf.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mn.POSICION='Delantero Izquierdo' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mn.POSICION = mnf.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET neum2_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

CREATE PROC CargaDesgastesNeumaticosTraDer
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mn.PROFUNDIDAD-mnf.PROFUNDIDAD), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Neumatico MN
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Neumatico mnf ON mnf.ID_NEUMATICO = mn.ID_NEUMATICO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mnf.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mn.POSICION='Trasero Derecho' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mn.POSICION = mnf.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET neum3_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

CREATE PROC CargaDesgastesNeumaticosTraIzq
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mn.PROFUNDIDAD-mnf.PROFUNDIDAD), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Neumatico MN
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mn.MEDICION_AUTO
									JOIN MANTECA.Medicion_Neumatico mnf ON mnf.ID_NEUMATICO = mn.ID_NEUMATICO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mnf.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mn.POSICION='Trasero Izquierdo' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mn.POSICION = mnf.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET neum4_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO


CREATE PROC CargaDesgastesFrenosDelDer
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mf.GROSOR_PASTILLA-mff.GROSOR_PASTILLA), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Frenos MF
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Frenos mff ON mff.ID_FRENO = mf.ID_FRENO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mff.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mf.POSICION='Delantero Derecho' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mf.POSICION = mff.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET freno1_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

CREATE PROC CargaDesgastesFrenosDelIzq
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mf.GROSOR_PASTILLA-mff.GROSOR_PASTILLA), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Frenos MF
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Frenos mff ON mff.ID_FRENO = mf.ID_FRENO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mff.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mf.POSICION='Delantero Izquierdo' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mf.POSICION = mff.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET freno2_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

CREATE PROC CargaDesgastesFrenosTraDer
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mf.GROSOR_PASTILLA-mff.GROSOR_PASTILLA), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Frenos MF
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Frenos mff ON mff.ID_FRENO = mf.ID_FRENO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mff.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mf.POSICION='Trasero Derecho' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mf.POSICION = mff.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET freno3_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

CREATE PROC CargaDesgastesFrenosTraIzq
AS
BEGIN
DECLARE @Desgaste decimal(18,2), @auto int, @circuito int, @vuelta decimal(18,0)    
DECLARE cursorDesgastes CURSOR FOR SELECT (mf.GROSOR_PASTILLA-mff.GROSOR_PASTILLA), ma.ID_AUTO,C.ID_CIRCUITO,ma.VUELTA_NUMERO FROM MANTECA.Medicion_Frenos MF
									JOIN MANTECA.Medicion M ON m.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Auto ma ON ma.ID_MEDICION = mf.MEDICION_AUTO
									JOIN MANTECA.Medicion_Frenos mff ON mff.ID_FRENO = mf.ID_FRENO
									JOIN MANTECA.Medicion_Auto maf ON maf.ID_MEDICION = mff.MEDICION_AUTO
									JOIN MANTECA.Carrera C ON M.ID_CARRERA=C.ID_CARRERA
									WHERE mf.POSICION='Trasero Izquierdo' AND  ma.DISTANCIA_RECORRIDA_VUELTA = 0 AND maf.DISTANCIA_RECORRIDA_VUELTA = 149 AND maf.ID_AUTO = ma.ID_AUTO AND maf.VUELTA_NUMERO = ma.VUELTA_NUMERO AND mf.POSICION = mff.POSICION
									ORDER BY M.ID_AUTO DESC, C.ID_CIRCUITO DESC, MA.VUELTA_NUMERO ASC
OPEN cursorDesgastes
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE MANTECA.BI_Medicion SET freno4_desgaste=@Desgaste
WHERE vuelta_numero=@vuelta and id_auto=@auto and id_circuito=@circuito
FETCH NEXT FROM cursorDesgastes
INTO @Desgaste, @auto, @circuito, @vuelta
END
CLOSE cursorDesgastes
DEALLOCATE cursorDesgastes
END
GO

EXEC CargaDesgastesNeumaticosDelDer
EXEC CargaDesgastesNeumaticosDelIzq
EXEC CargaDesgastesNeumaticosTraDer
EXEC CargaDesgastesNeumaticosTraIzq
EXEC CargaDesgastesFrenosDelDer
EXEC CargaDesgastesFrenosDelIzq
EXEC CargaDesgastesFrenosTraDer
EXEC CargaDesgastesFrenosTraIzq

/*
DROP PROC CargaDesgastesNeumaticosDelDer
DROP PROC CargaDesgastesNeumaticosDelIzq
DROP PROC CargaDesgastesNeumaticosTraDer
DROP PROC CargaDesgastesNeumaticosTraIzq
DROP PROC CargaDesgastesFrenosDelDer
DROP PROC CargaDesgastesFrenosDelIzq
DROP PROC CargaDesgastesFrenosTraDer
DROP PROC CargaDesgastesFrenosTraIzq

SELECT * FROM MANTECA.BI_Medicion
*/

