USE [GD1C2022]

DROP TABLE [MANTECA].[BI_Auto]
DROP TABLE [MANTECA].[BI_Escuderia]
DROP TABLE [MANTECA].[BI_Piloto]
DROP TABLE [MANTECA].[BI_Carrera] --esta no estaba 
DROP TABLE [MANTECA].[BI_Circuito]
DROP TABLE [MANTECA].[BI_Sector] --esta no estaba
DROP TABLE [MANTECA].[BI_Tipo_Sector]
DROP TABLE [MANTECA].[BI_Neumatico] --esta no estaba
DROP TABLE [MANTECA].[BI_Tipo_Neumatico]
DROP TABLE [MANTECA].[BI_Tipo_incidente]
DROP TABLE [MANTECA].[BI_Fecha]
DROP TABLE [MANTECA].[BI_Medicion]
DROP TABLE [MANTECA].[BI_Parada_en_box]
DROP TABLE [MANTECA].[BI_Incidente]


DROP PROC CargaDesgastesNeumaticosDelDer
DROP PROC CargaDesgastesNeumaticosDelIzq
DROP PROC CargaDesgastesNeumaticosTraDer
DROP PROC CargaDesgastesNeumaticosTraIzq
DROP PROC CargaDesgastesFrenosDelDer
DROP PROC CargaDesgastesFrenosDelIzq
DROP PROC CargaDesgastesFrenosTraDer
DROP PROC CargaDesgastesFrenosTraIzq

DROP VIEW [MANTECA].[Desgaste]
DROP VIEW [MANTECA].[Mejor_tiempo_vuelta_por_escuderia_por_circuito_por_anio] 
DROP VIEW [MANTECA].[3_circuitos_mayor_consumo_combustible]
DROP VIEW [MANTECA].[Max_vel_por_auto_en_cada_tipo_sector_en_cada_circuito]
DROP VIEW [MANTECA].[Prom_escuderia_en_parada_por_cuatrimestre]
DROP VIEW [MANTECA].[cant_paradas_escuderia_por_anio]
DROP VIEW [MANTECA].[3_circuitos_mayor_tiempo_paradas]
DROP VIEW [MANTECA].[3_circuitos_mas_peligrosos_del_anio]
DROP VIEW [MANTECA].[Promedio_incidentes_escuderia_por_anio_por_tipo_sector]