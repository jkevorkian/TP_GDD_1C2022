CREATE TABLE BI_Auto (
    id_auto INT NOT NULL,
    nro_auto INT NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    escuderia_nombre VARCHAR(255) NOT NULL,
    escuderia_nacionalidad VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_auto)
);

CREATE TABLE BI_Piloto (
    id_piloto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nro_documento VARCHAR(15) NOT NULL,
    tipo_documento VARCHAR(5) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY (id_piloto),
    UNIQUE (nro_documento, tipo_documento)
);

CREATE TABLE BI_Carrera (
    id_carrera INT NOT NULL,
    fecha_fin DATE NOT NULL,
    vueltas_total INT NOT NULL,
    clima VARCHAR(100) NOT NULL,
    longitud DECIMAL(18,2) NOT NULL,
    circuito_nombre VARCHAR(255) NOT NULL,
    circuito_pais VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_carrera)
);

CREATE TABLE BI_Sector (
    id_sector INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descipcion VARCHAR(255) NOT NULL,
    longitud DECIMAL(18,2) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    circuito_nombre VARCHAR(255) NOT NULL,
    circuito_pais VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_sector)
);

CREATE TABLE BI_Medición (
    id_medicion INT NOT NULL,
    id_carrera INT NOT NULL,
    id_sector INT NOT NULL,
    id_auto INT NOT NULL,
    PRIMARY KEY (id_medicion)
);

CREATE TABLE BI_Motor (
    id_motor INT NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_motor)
);

CREATE TABLE BI_Neumático (
    id_neumático INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    posicion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_neumático)
);

CREATE TABLE BI_Caja_de_cambios (
    id_caja_cambio INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_caja_cambio)
);

CREATE TABLE BI_Tipo_incidente (
    id_tipo_incidente INT NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tipo_incidente)
);

CREATE TABLE BI_Tiempo (
    id_tiempo INT NOT NULL,
    fecha DATETIME NOT NULL,
    anio INT NOT NULL,
    cuatrimestre INT NOT NULL,
    mes INT NOT NULL,
    semana INT NOT NULL,
    dia_semana VARCHAR(10) NOT NULL,
    Hora INT NOT NULL,
    minuto INT NOT NULL,
    segundo INT NOT NULL,
    PRIMARY KEY (id_tiempo)
);

CREATE TABLE BI_Medicion (
    id_tiempo INT NOT NULL,
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
    PRIMARY KEY (id_tiempo, id_motor, id_neumatico, id_caja_de_cambios, id_piloto, id_auto, id_sector, id_carrera, id_freno)
);

CREATE TABLE BI_Parada_en_box (
    id_carrera INT NOT NULL,
    id_neumatico_anterior INT NOT NULL,
    id_neumatico_nuevo INT NOT NULL,
    nro_auto INT NOT NULL,
    id_tiempo INT NOT NULL,
    nro_vuelta DECIMAL(18,0) NOT NULL,
    id_piloto INT NOT NULL,
    Column26 INTEGER NOT NULL,
    id_sector INT NOT NULL,
    duracion DECIMAL(18,2) NOT NULL,
    posición VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_carrera, id_neumatico_anterior, id_neumatico_nuevo, nro_auto, id_tiempo, id_piloto, id_sector)
);

CREATE TABLE BI_Freno (
    id_freno INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    nro_serie VARCHAR(255) NOT NULL,
    tamanio_disco DECIMAL(18,2) NOT NULL,
    posicion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_freno)
);

CREATE TABLE BI_Incidente (
    id_sector INT NOT NULL,
    id_carrera INT NOT NULL,
    nro_auto INT NOT NULL,
    id_tiempo INT NOT NULL,
    id_piloto INT NOT NULL,
    bandera VARCHAR(255) NOT NULL,
    tiempo TIMESTAMP NOT NULL,
    nro_vuelta DECIMAL(18, 0) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    descipción VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_sector, id_carrera, nro_auto, id_tiempo, id_piloto)
);

CREATE TABLE BI_Circuito (
    id_circuito INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_circuito)
);