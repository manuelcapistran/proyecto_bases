-- Secuencia para la tabla ENTIDAD
CREATE SEQUENCE seq_entidad_id
    START WITH 1001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla PLACA
CREATE SEQUENCE seq_placa_id
    START WITH 2001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla PROPIETARIO
CREATE SEQUENCE seq_propietario_id
    START WITH 3001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla LICENCIA
CREATE SEQUENCE seq_licencia_id
    START WITH 4001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla FALTA
CREATE SEQUENCE seq_falta_folio
    START WITH 5001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla MARCA
CREATE SEQUENCE seq_marca_id
    START WITH 6001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla MODELO
CREATE SEQUENCE seq_modelo_id
    START WITH 7001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla ESTATUS_VEHICULO
CREATE SEQUENCE seq_estatus_vehiculo_id
    START WITH 8001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla VEHICULO
CREATE SEQUENCE seq_vehiculo_id
    START WITH 9001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla DE_CARGA
-- No se requiere secuencia, ya que VEHICULO_ID es clave primaria relacionada.

-- Secuencia para la tabla TRANSPORTE_PUBLICO
-- No se requiere secuencia, ya que VEHICULO_ID es clave primaria relacionada.

-- Secuencia para la tabla PARTICULAR
-- No se requiere secuencia, ya que VEHICULO_ID es clave primaria relacionada.

-- Secuencia para la tabla HISTORICO_ESTATUS_VEHICULO
CREATE SEQUENCE seq_historico_estatus_vehiculo_id
    START WITH 10001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla VERIFICACION
CREATE SEQUENCE seq_verificacion_id
    START WITH 11001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla GAS
CREATE SEQUENCE seq_gas_id
    START WITH 12001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla REPORTE_EMISIONES
CREATE SEQUENCE seq_reporte_emisiones_id
    START WITH 13001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla NOTIFICACION
CREATE SEQUENCE seq_notificacion_id
    START WITH 14001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Secuencia para la tabla REPORTE_EMISIONES_NOTIFICACION
-- No requiere secuencia porque su clave primaria es compuesta.

-- Secuencia para la tabla HISTORICO_PROPIETARIO_VEHICULO
CREATE SEQUENCE seq_historico_propietario_vehiculo_id
    START WITH 15001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
