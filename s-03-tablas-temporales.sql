/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:    -- Script: s-03-tablas-temporales.sql
-- Crear una tabla temporal para almacenar datos combinados de emisiones
*/
DISCONNECT
CREATE GLOBAL TEMPORARY TABLE temp_emisiones_reporte (
    vehiculo_id number(10,0) not null,
    vehiculo_num_serie VARCHAR2(18) NOT NULL,
    nombre_modelo varchar2(30) not null, 
    anio_modelo number(4,0) not null,
    nombre_marca varchar2(30) not null,
    NOMBRE_PROPIETARIO varchar2(30) not null,
    APELLIDO_PATERNO_PROPIETARIO varchar2(30) not null,
    rfc varchar2(13) not null,
    gas_id number(10, 0) not null,
    tipo_gas VARCHAR2(30) NOT NULL,
    promedio_emisiones NUMBER(10,4),
    total_emisiones NUMBER(10,4),
    desde_fecha DATE,
    hasta_fecha DATE,
    CONSTRAINT temp_emisiones_pk PRIMARY KEY (vehiculo_id, gas_id)
) ON COMMIT PRESERVE ROWS;
