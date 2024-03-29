USE [GD1C2022]


INSERT INTO [MANTECA].Piloto
(PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_NACIONALIDAD, PILOTO_FECHA_NACIMIENTO)
SELECT DISTINCT PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_NACIONALIDAD, PILOTO_FECHA_NACIMIENTO FROM gd_esquema.Maestra;--ok

INSERT INTO [MANTECA].Escuderia
(ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD)
SELECT DISTINCT ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD FROM gd_esquema.Maestra--ok

INSERT INTO [MANTECA].Auto
(AUTO_NUMERO, ID_ESCUDERIA, AUTO_MODELO)
SELECT AUTO_NUMERO, E.ID_ESCUDERIA, AUTO_MODELO FROM gd_esquema.Maestra
JOIN [MANTECA].Escuderia E ON E.ESCUDERIA_NOMBRE = gd_esquema.Maestra.ESCUDERIA_NOMBRE
GROUP BY AUTO_NUMERO, ID_ESCUDERIA, AUTO_MODELO--ok

INSERT INTO [MANTECA].Circuito
(ID_CIRCUITO, CIRCUITO_NOMBRE, CIRCUITO_PAIS)
SELECT DISTINCT CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS FROM gd_esquema.Maestra--ok

INSERT INTO [MANTECA].Carrera
(CARRERA_FECHA_INICIO, ID_CARRERA, CARRERA_CLIMA, CARRERA_LONGITUD, VUELTAS_TOTAL, ID_CIRCUITO)
SELECT DISTINCT CARRERA_FECHA, CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA, CARRERA_CANT_VUELTAS, C.ID_CIRCUITO FROM gd_esquema.Maestra
JOIN [MANTECA].CIRCUITO C ON C.ID_CIRCUITO=gd_esquema.Maestra.CIRCUITO_CODIGO
GROUP BY CARRERA_FECHA, CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA, CARRERA_CANT_VUELTAS, C.ID_CIRCUITO
ORDER BY CODIGO_CARRERA	asc--ok

INSERT INTO [MANTECA].Sector
(ID_SECTOR, SECTOR_TIPO, SECTOR_LONGITUD, ID_CIRCUITO)
SELECT DISTINCT CODIGO_SECTOR, SECTO_TIPO, SECTOR_DISTANCIA, C.ID_CIRCUITO FROM gd_esquema.Maestra
JOIN [MANTECA].CIRCUITO C ON C.ID_CIRCUITO=gd_esquema.Maestra.CIRCUITO_CODIGO
GROUP BY CODIGO_SECTOR, SECTO_TIPO, SECTOR_DISTANCIA, C.ID_CIRCUITO
ORDER BY CODIGO_SECTOR ASC

INSERT INTO [MANTECA].Incidente
(INCIDENTE_BANDERA, ID_SECTOR, INCIDENTE_TIEMPO)
SELECT INCIDENTE_BANDERA, S.ID_SECTOR, INCIDENTE_TIEMPO FROM gd_esquema.Maestra
JOIN [MANTECA].SECTOR S ON S.ID_SECTOR=gd_esquema.Maestra.CODIGO_SECTOR
WHERE INCIDENTE_BANDERA IS NOT NULL
GROUP BY INCIDENTE_BANDERA, S.ID_SECTOR, INCIDENTE_TIEMPO 


INSERT INTO [MANTECA].Tipo_incidente
(TIPO_INCIDENTE)
SELECT INCIDENTE_TIPO  FROM gd_esquema.Maestra
WHERE INCIDENTE_TIPO IS NOT NULL
--------------------------------------AUTO INCIDENTADO-------------------------------------	TODO
INSERT INTO [MANTECA].Auto_incidentado 
(NRO_VUELTA, ID_INCIDENTE, ID_AUTO, ID_TIPO_INCIDENTE,ID_SECTOR,CARRERA_FECHA)
SELECT INCIDENTE_NUMERO_VUELTA, I.ID_INCIDENTE, A.ID_AUTO, T.ID_TIPO_INCIDENTE,CODIGO_SECTOR,CARRERA_FECHA FROM gd_esquema.Maestra
JOIN [MANTECA].Incidente I ON I.INCIDENTE_BANDERA = Maestra.INCIDENTE_BANDERA AND I.INCIDENTE_TIEMPO = Maestra.INCIDENTE_TIEMPO
JOIN [MANTECA].Auto A ON a.AUTO_MODELO = Maestra.AUTO_MODELO and A.AUTO_NUMERO = Maestra.AUTO_NUMERO
JOIN [MANTECA].Tipo_incidente T ON T.TIPO_INCIDENTE = Maestra.INCIDENTE_TIPO
WHERE I.INCIDENTE_BANDERA IS NOT NULL
GROUP BY INCIDENTE_NUMERO_VUELTA, I.ID_INCIDENTE, A.ID_AUTO, T.ID_TIPO_INCIDENTE,CODIGO_SECTOR,CARRERA_FECHA--OK

INSERT INTO [MANTECA].Parada_En_box
(NUMERO_VUELTA, PARADA_DURACION, ID_AUTO, ID_CIRCUITO)
SELECT PARADA_BOX_VUELTA, PARADA_BOX_TIEMPO, A.ID_AUTO, C.ID_CIRCUITO FROM gd_esquema.Maestra
JOIN [MANTECA].Auto A ON A.AUTO_NUMERO=Maestra.AUTO_NUMERO AND A.AUTO_MODELO=Maestra.AUTO_MODELO
JOIN [MANTECA].Circuito	C ON C.ID_CIRCUITO=Maestra.CIRCUITO_CODIGO
WHERE PARADA_BOX_VUELTA IS NOT NULL AND PARADA_BOX_TIEMPO IS NOT NULL
GROUP BY PARADA_BOX_TIEMPO,PARADA_BOX_VUELTA, A.ID_AUTO, C.ID_CIRCUITO--OK

INSERT INTO [MANTECA].Medicion
(ID_MEDICION, ID_CARRERA, ID_SECTOR, DISTANCIA_RECORRIDA_CARRERA, ID_AUTO)
SELECT TELE_AUTO_CODIGO, C.ID_CARRERA, S.ID_SECTOR, TELE_AUTO_DISTANCIA_CARRERA, A.ID_AUTO FROM gd_esquema.Maestra
JOIN [MANTECA].Carrera C ON C.CARRERA_FECHA_INICIO = Maestra.CARRERA_FECHA AND C.CARRERA_LONGITUD = Maestra.CARRERA_TOTAL_CARRERA
				AND C.VUELTAS_TOTAL = Maestra.CARRERA_CANT_VUELTAS AND C.CARRERA_CLIMA = Maestra.CARRERA_CLIMA
JOIN [MANTECA].Sector S ON S.ID_SECTOR=Maestra.CODIGO_SECTOR AND S.SECTOR_TIPO=Maestra.SECTO_TIPO AND S.SECTOR_LONGITUD=SECTOR_DISTANCIA
JOIN [MANTECA].Auto A ON A.AUTO_MODELO = Maestra.AUTO_MODELO AND A.AUTO_NUMERO = Maestra.AUTO_NUMERO
WHERE TELE_AUTO_DISTANCIA_CARRERA IS NOT NULL
GROUP BY C.ID_CARRERA, S.ID_SECTOR, TELE_AUTO_DISTANCIA_CARRERA, A.ID_AUTO, TELE_AUTO_CODIGO--ok?
ORDER BY TELE_AUTO_CODIGO ASC

INSERT INTO [MANTECA].Medicion_auto
( VUELTA_NUMERO, DISTANCIA_RECORRIDA_VUELTA, POSICION, TIEMPO_DE_VUELTA, VELOCIDAD, COMBUSTIBLE, ID_PILOTO, ID_AUTO , CODIGO_MEDICION)
SELECT TELE_AUTO_NUMERO_VUELTA, TELE_AUTO_DISTANCIA_VUELTA, TELE_AUTO_POSICION, TELE_AUTO_TIEMPO_VUELTA,
        TELE_AUTO_VELOCIDAD, TELE_AUTO_COMBUSTIBLE , p.ID_PILOTO, a.ID_AUTO, m.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Piloto p ON p.PILOTO_NOMBRE = gd_esquema.Maestra.PILOTO_NOMBRE AND p.PILOTO_APELLIDO = gd_esquema.Maestra.PILOTO_APELLIDO
JOIN [MANTECA].Auto a ON a.AUTO_MODELO = gd_esquema.Maestra.AUTO_MODELO AND a.AUTO_NUMERO = gd_esquema.Maestra.AUTO_NUMERO
JOIN [MANTECA].Medicion m ON m.ID_MEDICION=gd_esquema.Maestra.TELE_AUTO_CODIGO
WHERE TELE_AUTO_NUMERO_VUELTA IS NOT NULL 
        AND TELE_AUTO_DISTANCIA_VUELTA IS NOT NULL
        AND TELE_AUTO_POSICION IS NOT NULL
        AND TELE_AUTO_TIEMPO_VUELTA IS NOT NULL
        AND TELE_AUTO_VELOCIDAD IS NOT NULL
        AND TELE_AUTO_COMBUSTIBLE IS NOT NULL
GROUP BY TELE_AUTO_NUMERO_VUELTA , p.ID_PILOTO , a.ID_AUTO, TELE_AUTO_DISTANCIA_VUELTA , TELE_AUTO_POSICION , TELE_AUTO_TIEMPO_VUELTA , TELE_AUTO_VELOCIDAD , TELE_AUTO_COMBUSTIBLE, m.ID_MEDICION--OK?
ORDER BY m.ID_MEDICION asc 

INSERT INTO [MANTECA].Caja_de_cambios
(CAJA_CAMBIO_MODELO, NRO_SERIE)
SELECT DISTINCT TELE_CAJA_MODELO, TELE_CAJA_NRO_SERIE FROM gd_esquema.Maestra
WHERE TELE_CAJA_MODELO IS NOT NULL--OK

INSERT INTO [MANTECA].Medicion_caja_de_cambios
(CAJA,RPM, TEMPERATURA_ACEITE, DESGASTE_PORCENTUAL_ACUMULADO, ID_CAJA_CAMBIO, MEDICION_AUTO)
SELECT TELE_CAJA_MODELO, TELE_CAJA_RPM, TELE_CAJA_TEMP_ACEITE, TELE_CAJA_DESGASTE, C.ID_CAJA_CAMBIO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Caja_de_Cambios C ON C.CAJA_CAMBIO_MODELO = Maestra.TELE_CAJA_MODELO 
						AND C.NRO_SERIE = Maestra.TELE_CAJA_NRO_SERIE
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=Maestra.TELE_AUTO_CODIGO
WHERE TELE_CAJA_MODELO IS NOT NULL
GROUP BY TELE_CAJA_MODELO, TELE_CAJA_RPM, TELE_CAJA_TEMP_ACEITE, TELE_CAJA_DESGASTE, C.ID_CAJA_CAMBIO, M.ID_MEDICION --OK?	
ORDER BY M.ID_MEDICION ASC

INSERT INTO [MANTECA].Motor
(MODELO, NRO_SERIE)
SELECT DISTINCT TELE_MOTOR_MODELO, TELE_MOTOR_NRO_SERIE FROM gd_esquema.Maestra
WHERE TELE_MOTOR_MODELO IS NOT NULL--OK

INSERT INTO [MANTECA].Medicion_Motor
(POTENCIA_MOMENTANEA, RPM, TEMP_ACEITE, TEMP_AGUA, ID_MOTOR, MEDICION_AUTO)
SELECT TELE_MOTOR_POTENCIA, TELE_MOTOR_RPM, TELE_MOTOR_TEMP_ACEITE, TELE_MOTOR_TEMP_AGUA, M.ID_MOTOR, ME.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Motor M ON M.MODELO = Maestra.TELE_MOTOR_MODELO
			AND M.NRO_SERIE = Maestra.TELE_MOTOR_NRO_SERIE
JOIN [MANTECA].Medicion_Auto ME ON ME.ID_MEDICION=TELE_AUTO_CODIGO
WHERE TELE_MOTOR_POTENCIA IS NOT NULL
GROUP BY TELE_MOTOR_POTENCIA, TELE_MOTOR_RPM, TELE_MOTOR_TEMP_ACEITE, TELE_MOTOR_TEMP_AGUA, M.ID_MOTOR, ME.ID_MEDICION--OK?
ORDER BY ME.ID_MEDICION ASC

INSERT INTO [MANTECA].Neumatico
(NRO_SERIE, NEUMATICO_TIPO)
SELECT TELE_NEUMATICO1_NRO_SERIE  , NEUMATICO1_TIPO_VIEJO  FROM gd_esquema.Maestra
        WHERE TELE_NEUMATICO1_NRO_SERIE IS NOT NULL
        GROUP BY TELE_NEUMATICO1_NRO_SERIE  , NEUMATICO1_TIPO_VIEJO 
		UNION
        SELECT TELE_NEUMATICO2_NRO_SERIE  , NEUMATICO2_TIPO_VIEJO FROM gd_esquema.Maestra
        WHERE TELE_NEUMATICO2_NRO_SERIE IS NOT NULL
        GROUP BY TELE_NEUMATICO2_NRO_SERIE , NEUMATICO2_TIPO_VIEJO
        UNION
        SELECT TELE_NEUMATICO3_NRO_SERIE  , NEUMATICO3_TIPO_VIEJO FROM gd_esquema.Maestra
        WHERE TELE_NEUMATICO2_NRO_SERIE IS NOT NULL
        GROUP BY TELE_NEUMATICO3_NRO_SERIE , NEUMATICO3_TIPO_VIEJO
        UNION
        SELECT TELE_NEUMATICO4_NRO_SERIE  , NEUMATICO4_TIPO_VIEJO FROM gd_esquema.Maestra
        WHERE TELE_NEUMATICO2_NRO_SERIE IS NOT NULL
        GROUP BY TELE_NEUMATICO4_NRO_SERIE , NEUMATICO4_TIPO_VIEJO--OK




INSERT INTO [MANTECA].Freno
(NRO_SERIE, TAMANIO_DISCO)
SELECT DISTINCT TELE_FRENO1_NRO_SERIE, TELE_FRENO1_TAMANIO_DISCO FROM gd_esquema.Maestra
WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL
UNION
SELECT DISTINCT TELE_FRENO2_NRO_SERIE, TELE_FRENO2_TAMANIO_DISCO FROM gd_esquema.Maestra
WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL
UNION
SELECT DISTINCT TELE_FRENO3_NRO_SERIE, TELE_FRENO3_TAMANIO_DISCO FROM gd_esquema.Maestra
WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL
UNION
SELECT DISTINCT TELE_FRENO4_NRO_SERIE, TELE_FRENO4_TAMANIO_DISCO FROM gd_esquema.Maestra
WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL--ok

INSERT INTO [MANTECA].Medicion_frenos
(GROSOR_PASTILLA, POSICION, TEMPERATURA, ID_FRENO, MEDICION_AUTO)
SELECT DISTINCT TELE_FRENO1_GROSOR_PASTILLA, TELE_FRENO1_POSICION, TELE_FRENO1_TEMPERATURA,F.ID_FRENO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Freno F ON F.NRO_SERIE = Maestra.TELE_FRENO1_NRO_SERIE
			AND F.TAMANIO_DISCO = Maestra.TELE_FRENO1_TAMANIO_DISCO
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
WHERE TELE_FRENO1_POSICION IS NOT NULL
UNION
SELECT TELE_FRENO2_GROSOR_PASTILLA, TELE_FRENO2_POSICION, TELE_FRENO2_TEMPERATURA, F.ID_FRENO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Freno F ON F.NRO_SERIE = Maestra.TELE_FRENO2_NRO_SERIE
			AND F.TAMANIO_DISCO = Maestra.TELE_FRENO2_TAMANIO_DISCO
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
WHERE TELE_FRENO2_POSICION IS NOT NULL
UNION
SELECT TELE_FRENO3_GROSOR_PASTILLA,TELE_FRENO3_POSICION, TELE_FRENO3_TEMPERATURA, F.ID_FRENO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Freno F ON F.NRO_SERIE = Maestra.TELE_FRENO3_NRO_SERIE
			AND F.TAMANIO_DISCO = Maestra.TELE_FRENO3_TAMANIO_DISCO
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
WHERE TELE_FRENO3_POSICION IS NOT NULL
UNION
SELECT TELE_FRENO4_GROSOR_PASTILLA, TELE_FRENO4_POSICION, TELE_FRENO4_TEMPERATURA, F.ID_FRENO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Freno F ON F.NRO_SERIE = Maestra.TELE_FRENO4_NRO_SERIE
			AND F.TAMANIO_DISCO = Maestra.TELE_FRENO4_TAMANIO_DISCO
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
WHERE TELE_FRENO4_POSICION IS NOT NULL--ok?
ORDER BY M.ID_MEDICION ASC

INSERT INTO [MANTECA].Medicion_Neumatico
(POSICION, PRESION, PROFUNDIDAD, TEMPERATURA, ID_NEUMATICO, MEDICION_AUTO)
SELECT TELE_NEUMATICO1_POSICION, TELE_NEUMATICO1_PRESION, TELE_NEUMATICO1_PROFUNDIDAD, TELE_NEUMATICO1_TEMPERATURA , n.ID_NEUMATICO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Neumatico n ON n.NRO_SERIE = gd_esquema.Maestra.TELE_NEUMATICO1_NRO_SERIE
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
UNION
SELECT TELE_NEUMATICO2_POSICION, TELE_NEUMATICO2_PRESION, TELE_NEUMATICO2_PROFUNDIDAD, TELE_NEUMATICO2_TEMPERATURA , n.ID_NEUMATICO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Neumatico n ON n.NRO_SERIE = gd_esquema.Maestra.TELE_NEUMATICO2_NRO_SERIE
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
UNION
SELECT TELE_NEUMATICO3_POSICION, TELE_NEUMATICO3_PRESION, TELE_NEUMATICO3_PROFUNDIDAD, TELE_NEUMATICO3_TEMPERATURA , n.ID_NEUMATICO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Neumatico n ON n.NRO_SERIE = gd_esquema.Maestra.TELE_NEUMATICO3_NRO_SERIE
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
UNION
SELECT TELE_NEUMATICO4_POSICION, TELE_NEUMATICO4_PRESION, TELE_NEUMATICO4_PROFUNDIDAD, TELE_NEUMATICO4_TEMPERATURA , n.ID_NEUMATICO, M.ID_MEDICION FROM gd_esquema.Maestra
JOIN [MANTECA].Neumatico n ON n.NRO_SERIE = gd_esquema.Maestra.TELE_NEUMATICO4_NRO_SERIE
JOIN [MANTECA].Medicion_Auto M ON M.ID_MEDICION=TELE_AUTO_CODIGO
ORDER BY M.ID_MEDICION ASC

INSERT INTO [MANTECA].Cambio_De_Neumatico
(ID_NEUMATICO_ANTERIOR, ID_NEUMATICO_NUEVO, ID_PARADA, POSICION)
SELECT N.ID_NEUMATICO  , N2.ID_NEUMATICO , p.ID_PARADA , NEUMATICO1_POSICION_VIEJO  FROM gd_esquema.Maestra
		JOIN MANTECA.neumatico N ON N.NRO_SERIE = NEUMATICO1_NRO_SERIE_VIEJO
		JOIN MANTECA.neumatico N2 ON N2.NRO_SERIE = NEUMATICO1_NRO_SERIE_NUEVO
		JOIN MANTECA.Auto a 
					ON a.AUTO_MODELO = gd_esquema.Maestra.AUTO_MODELO 
					AND a.AUTO_NUMERO = gd_esquema.Maestra.AUTO_NUMERO
		JOIN MANTECA.Parada_En_Box p 
					ON p.ID_AUTO = a.id_auto
		WHERE NEUMATICO1_NRO_SERIE_VIEJO  IS NOT NULL
		AND NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
		AND NEUMATICO1_TIPO_NUEVO IS NOT NULL
		GROUP BY    NEUMATICO1_TIPO_VIEJO ,   NEUMATICO1_TIPO_NUEVO , N.ID_NEUMATICO , N2.ID_NEUMATICO , p.ID_PARADA  , NEUMATICO1_POSICION_VIEJO 
		UNION
		SELECT N.ID_NEUMATICO  , N2.ID_NEUMATICO , p.ID_PARADA , NEUMATICO2_POSICION_VIEJO  FROM gd_esquema.Maestra
		JOIN MANTECA.neumatico N ON N.NRO_SERIE = NEUMATICO2_NRO_SERIE_VIEJO
		JOIN MANTECA.neumatico N2 ON N2.NRO_SERIE = NEUMATICO2_NRO_SERIE_NUEVO
		JOIN MANTECA.Auto a 
					ON a.AUTO_MODELO = gd_esquema.Maestra.AUTO_MODELO 
					AND a.AUTO_NUMERO = gd_esquema.Maestra.AUTO_NUMERO
		JOIN MANTECA.Parada_En_Box p 
					ON p.ID_AUTO = a.id_auto
		WHERE NEUMATICO1_NRO_SERIE_VIEJO  IS NOT NULL
		AND NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
		AND NEUMATICO1_TIPO_NUEVO IS NOT NULL
		GROUP BY  N.ID_NEUMATICO , N2.ID_NEUMATICO , p.ID_PARADA  , NEUMATICO2_POSICION_VIEJO 
		UNION
		SELECT N.ID_NEUMATICO  , N2.ID_NEUMATICO , p.ID_PARADA , NEUMATICO3_POSICION_VIEJO  FROM gd_esquema.Maestra
		JOIN MANTECA.neumatico N ON N.NRO_SERIE = NEUMATICO3_NRO_SERIE_VIEJO
		JOIN MANTECA.neumatico N2 ON N2.NRO_SERIE = NEUMATICO3_NRO_SERIE_NUEVO
		JOIN MANTECA.Auto a 
					ON a.AUTO_MODELO = gd_esquema.Maestra.AUTO_MODELO 
					AND a.AUTO_NUMERO = gd_esquema.Maestra.AUTO_NUMERO
		JOIN MANTECA.Parada_En_Box p 
					ON p.ID_AUTO = a.id_auto
		WHERE NEUMATICO1_NRO_SERIE_VIEJO  IS NOT NULL
		AND NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
		AND NEUMATICO1_TIPO_NUEVO IS NOT NULL
		GROUP BY  N.ID_NEUMATICO , N2.ID_NEUMATICO , p.ID_PARADA  , NEUMATICO3_POSICION_VIEJO 
		UNION
		SELECT N.ID_NEUMATICO  , N2.ID_NEUMATICO , p.ID_PARADA , NEUMATICO4_POSICION_VIEJO  FROM gd_esquema.Maestra
		JOIN MANTECA.neumatico N ON N.NRO_SERIE = NEUMATICO4_NRO_SERIE_VIEJO
		JOIN MANTECA.neumatico N2 ON N2.NRO_SERIE = NEUMATICO4_NRO_SERIE_NUEVO
		JOIN MANTECA.Auto a 
					ON a.AUTO_MODELO = gd_esquema.Maestra.AUTO_MODELO 
					AND a.AUTO_NUMERO = gd_esquema.Maestra.AUTO_NUMERO
		JOIN MANTECA.Parada_En_Box p 
					ON p.ID_AUTO = a.id_auto
		WHERE NEUMATICO1_NRO_SERIE_VIEJO  IS NOT NULL
		AND NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
		AND NEUMATICO1_TIPO_NUEVO IS NOT NULL
		GROUP BY  N.ID_NEUMATICO , N2.ID_NEUMATICO , p.ID_PARADA  , NEUMATICO4_POSICION_VIEJO

