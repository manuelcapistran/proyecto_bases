--autor(es)
--fecha de creacion 
--descripcion 

--drop table if EXISTS entidad;
create table entidad (

    entidad_id  NUMBER(10,0)    NOT NULL,
    nombre      VARCHAR2(40)    NOT NULL,
    clave       VARCHAR2(40)    NOT NULL,
    CONSTRAINT entidad_pk PRIMARY KEY (entidad_id)
);

--drop table if EXISTS placa;
create table placa(
    placa_id            NUMBER(10,0)    NOT NULL,
    num_placa           VARCHAR2(10)    NOT NULL,
    es_activa           boolean         NOT NULL,
    fecha_asignacion    DATE            NOT NULL,
    entidad_id          NUMBER(10,0)    NOT NULL,
    CONSTRAINT placa_pk PRIMARY KEY (placa_id),
    CONSTRAINT placa_entidad_id_fk FOREIGN KEY (entidad_id)
        REFERENCES entidad(entidad_id)
);

--drop table if exists propietario;
create table propietario(
    propietario_id  NUMBER(10,0) NOT NULL,
    nombre          VARCHAR2(40) NOT NULL,
    ap_paterno      VARCHAR2(40) NOT NULL,
    ap_materno      VARCHAR2(40) NOT NULL,
    RFC             VARCHAR2(13) NOT NULL,
    CURP            VARCHAR2 (10) ,
    email           VARCHAR2(40) NOT NULL,
    CONSTRAINT propietario_pk PRIMARY KEY (propietario_id)
);

--drop TABLE if EXISTS licencia;
create table licencia (
    licencia_id         NUMBER(10,0)    NOT NULL,
    foto                BLOB            NOT NULL,
    firma               BLOB            NOT NULL,
    huella              BLOB            NOT NULL,
    num_licencia        VARCHAR2(10)    NOT NULL, 
    tipo                VARCHAR2(1)     NOT NULL,
    fecha_emision       DATE            NOT NULL,   
    fecha_vencimiento   DATE            NOT NULL,
    propietario_id      NUMBER(10,0)    NOT NULL,
    licencia_anterior_id NUMBER(10,0)   NOT NULL,
    CONSTRAINT licencia_pk PRIMARY KEY (licencia_id),
    CONSTRAINT licencia_propietario_id_fk FOREIGN KEY (propietario_id)
        REFERENCES propietario(propietario_id),
    CONSTRAINT licencia_anterior_id_fk FOREIGN KEY (licencia_anterior_id)
        REFERENCES licencia(licencia_id)
);

--drop table if EXISTS falta;
create table falta(
    folio                       NUMBER(3,0)     NOT NULL,
    propietario_id              NUMBER(10,0)    NOT NULL,
    fecha                       DATE            NOT NULL,
    descripcion                 VARCHAR2(50)    NOT NULL,
    cantidad_puntos_negativos   NUMBER(3,0)     NOT NULL,
    detalle_falta               VARCHAR2(200)   NOT NULL,
    CONSTRAINT falta_propietario_id_fk FOREIGN KEY(propietario_id)
        REFERENCES propietario(propietario_id),
    CONSTRAINT falta_pk PRIMARY KEY (folio,propietario_id)
);

--drop table if exists marca;
create table marca(

    marca_id    NUMBER(10,0)    NOT NULL, 
    clave       VARCHAR2(10)    NOT NULL,
    descripcion VARCHAR2(20)    NOT NULL,
    CONSTRAINT marca_pk PRIMARY KEY (marca_id)

);

--drop table if EXISTS modelo ;
create table modelo(

    modelo_id   NUMBER(10,0)    NOT NULL,
    nombre      VARCHAR2(50)    NOT NULL,
    anio        NUMBER(4,0)     NOT NULL,
    marca_id    NUMBER(10,0)    NOT NULL,
    CONSTRAINT modelo_pk PRIMARY KEY (modelo_id),
    CONSTRAINT modelo_marca_id_fk FOREIGN KEY (marca_id)
        REFERENCES marca(marca_id)

);

----DROP table if EXISTS estatus_vehiculo;
create table estatus_vehiculo(
    estatus_vehiculo_id     NUMBER(10,0) NOT NULL,
    clave                   VARCHAR2(10) NOT NULL,
    descripcion             VARCHAR2(50) NOT NULL,
    CONSTRAINT estatus_vehiculo_pk PRIMARY KEY (estatus_vehiculo_id)
);

----DROP table if EXISTS vehiculo ;
create table vehiculo(
    vehiculo_id             NUMBER(10,0)    NOT NULL,
    num_serie_dispositivo   VARCHAR2(18)    NOT NULL,
    fecha_estatus           DATE            NOT NULL,
    es_de_carga             VARCHAR2(1)     NOT NULL,
    es_transporte_publico   VARCHAR2(1)     NOT NULL,
    es_particular           VARCHAR2(1)     NOT NULL,
    num_serie_vehiculo      VARCHAR2(18)    NOT NULL,
    modelo_id               NUMBER(10,0)    NOT NULL,
    propietario_id          NUMBER(10,0)    NOT NULL,
    estatus_vehiculo_id     NUMBER(10,0)    NOT NULL,
    placa_id                NUMBER(10,0)    NOT NULL,
    CONSTRAINT vehiculo_pk PRIMARY KEY (vehiculo_id),
    CONSTRAINT vehiculo_modelo_id_fk FOREIGN KEY(modelo_id)
        REFERENCES modelo(modelo_id),
    CONSTRAINT vehiculo_propietario_id_fk FOREIGN KEY(propietario_id)
        REFERENCES propietario(propietario_id),
    CONSTRAINT vehiculo_estatus_vehiculo_id_fk FOREIGN KEY(estatus_vehiculo_id)
        REFERENCES estatus_vehiculo(estatus_vehiculo_id),
    CONSTRAINT vehiculo_placa_id_fk FOREIGN KEY (placa_id)
        REFERENCES placa(placa_id)
);

--DROP table if EXISTS de_carga;
CREATE table de_carga(
    vehiculo_id NUMBER(10,0) NOT NULL,
    num_remolques NUMBER(1,0),
    capacidad_toneladas NUMBER(6,3) NOT NULL,
    capacidad_metros_cub NUMBER(6,3),
    CONSTRAINT de_carga_vehiculo_id_fk FOREIGN KEY(vehiculo_id)
        REFERENCES vehiculo(vehiculo_id),
    CONSTRAINT de_carga_pk PRIMARY KEY (vehiculo_id)
    
);

--DROP table if EXISTS transporte_publico;
create table transporte_publico(
    vehiculo_id NUMBER(10,0) NOT NULL,
    tipo_transporte_publico VARCHAR2(1) NOT NULL,
    tipo_licencia_req VARCHAR2(1) NOT NULL,
    pasajeros_sentados NUMBER(2,0) NOT NULL,
    pasajeros_parados NUMBER(2,0) NOT NULL,
    CONSTRAINT transporte_publico_vehiculo_id_fk FOREIGN KEY (vehiculo_id)
        REFERENCES vehiculo(vehiculo_id),
    CONSTRAINT transporte_publico_pk PRIMARY KEY(vehiculo_id)
);

--DROP table if EXISTS particular;
create table particular (
    vehiculo_id NUMBER(10,0) NOT NULL,
    num_bolsas_aire NUMBER(1,0) NOT NULL,
    frenos_abs boolean NOT NULL,
    tipo_transmision VARCHAR2(1) NOT NULL,
    CONSTRAINT particular_vehiculo_id_fk FOREIGN KEY (vehiculo_id)
        REFERENCES vehiculo(vehiculo_id),
    CONSTRAINT particular_pk PRIMARY KEY(vehiculo_id)
);

--DROP table if EXISTS historico_estatus_vehiculo;
CREATE table historico_estatus_vehiculo(
    historico_estatus_vehiculo_id NUMBER(10,0) NOT NULL,
    fecha_estatus DATE NOT NULL,
    vehiculo_id NUMBER(10,0) NOT NULL,
    estatus_vehiculo_id NUMBER(10,0) NOT NULL,
    CONSTRAINT historico_estatus_vehiculo_pk PRIMARY KEY(historico_estatus_vehiculo_id),
    CONSTRAINT historico_vehiculo_id_fk FOREIGN KEY(vehiculo_id)
        REFERENCES vehiculo(vehiculo_id),
    CONSTRAINT historico_estatus_vehiculo_id_fk FOREIGN KEY(estatus_vehiculo_id)
        REFERENCES estatus_vehiculo(estatus_vehiculo_id)
);

drop table if EXISTS verificacion;
create table verificacion(
    verificacion_id NUMBER(10,0) NOT NULL,
    fecha_verificacion DATE NOT NULL,
    folio VARCHAR2(10) NOT NULL,
    clave_verificentro VARCHAR2(5) NOT NULL,
    registro_mediciones CLOB NOT NULL,
    vehiculo_id NUMBER(10,0) NOT NULL,
    CONSTRAINT verificacion_pk PRIMARY KEY (verificacion_id),
    CONSTRAINT verificacion_vehiculo_id FOREIGN KEY (vehiculo_id)
        REFERENCES vehiculo(vehiculo_id)
);
--DROP table if EXISTS gas;
CREATE table gas (
    gas_id NUMBER(10,0) NOT NULL,
    clave VARCHAR2(5) NOT NULL,
    descripcion VARCHAR2(20) NOT NULL,
    CONSTRAINT gas_pk PRIMARY KEY (gas_id)
);
--DROP table if EXISTS reporte_verificentro;
CREATE table reporte_verificentro(
    gas_id NUMBER(2,0) NOT NULL,
    verificacion_id NUMBER(10,0) NOT NULL,
    valor_medido NUMBER(4,4) NOT NULL,
    CONSTRAINT reporte_verificentro_gas_fk FOREIGN KEY (gas_id)
        REFERENCES gas(gas_id),
    CONSTRAINT reporte_verificentro_verificacion_fk FOREIGN KEY(verificacion_id)
        REFERENCES verificacion(verificacion_id),
    CONSTRAINT reporte_verificentro_pk PRIMARY KEY (gas_id,verificacion_id)
);

--DROP table if EXISTS reporte_emisiones;
CREATE table reporte_emisiones(
    reporte_emisiones_id NUMBER(10,0) NOT NULL,
    fecha_registro DATE NOT NULL,
    valor_medido NUMBER(4,4) NOT NULL,
    gas_id NUMBER(2,0) NOT NULL,
    vehiculo_id NUMBER(10,0) NOT NULL,
    CONSTRAINT reporte_emisiones_pk PRIMARY KEY (reporte_emisiones_id),
    CONSTRAINT reporte_gas_fk FOREIGN KEY(gas_id)
        REFERENCES gas(gas_id),
    CONSTRAINT reporte_vehiculo_fk FOREIGN KEY(vehiculo_id)
        REFERENCES vehiculo(vehiculo_id)
);
--DROP table if EXISTS notificacion;
create table notificacion(
    notificacion_id NUMBER(10,0) NOT NULL,
    num_notificacion NUMBER(10,0) NOT NULL,
    fecha_envio DATE NOT NULL,
    CONSTRAINT notificacion_pk PRIMARY KEY(notificacion_id)
);
--DROP table if EXISTS reporte_emisiones_notificacion;
CREATE table reporte_emisiones_notificacion(
    reporte_emisiones_id NUMBER(10,0) NOT NULL,
    notificacion_id NUMBER(10,0) NOT NULL,
    CONSTRAINT reporte_notificacion_emisiones_fk FOREIGN KEY(reporte_emisiones_id)
        REFERENCES reporte_emisiones(reporte_emisiones_id),
    CONSTRAINT reporte_notificacion_notificaciones_fk FOREIGN KEY(notificacion_id)
        REFERENCES notificacion(notificacion_id),
    CONSTRAINT reporte_notificaciones_pk PRIMARY KEY(reporte_emisiones_id,notificacion_id)
);
