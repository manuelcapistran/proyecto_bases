/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     Archivo principal
*/

-- Script: s-03-tablas-temporales.sql

-- Crear una tabla temporal para almacenar datos combinados de emisiones
CREATE GLOBAL TEMPORARY TABLE temp_emisiones_reporte (
    vehiculo_id NUMBER(10,0),
    vehiculo_serie VARCHAR2(18),
    tipo_gas VARCHAR2(5),
    promedio_emisiones NUMBER(10,4),
    total_emisiones NUMBER(10,4),
    fecha_inicio DATE,
    fecha_fin DATE
) ON COMMIT PRESERVE ROWS;

-- Insertar datos desnormalizados en la tabla temporal
INSERT INTO temp_emisiones_reporte (vehiculo_id, vehiculo_serie, tipo_gas, promedio_emisiones, total_emisiones, fecha_inicio, fecha_fin)
SELECT 
    r.vehiculo_id,
    v.num_serie_vehiculo,
    g.descripcion AS tipo_gas,
    AVG(r.valor_medido) AS promedio_emisiones,
    SUM(r.valor_medido) AS total_emisiones,
    TRUNC(SYSDATE, 'YEAR') AS fecha_inicio,
    SYSDATE AS fecha_fin
FROM 
    reporte_emisiones r
JOIN 
    vehiculo v ON r.vehiculo_id = v.vehiculo_id
JOIN 
    gas g ON r.gas_id = g.gas_id
WHERE 
    r.fecha_registro BETWEEN TRUNC(SYSDATE, 'YEAR') AND SYSDATE
GROUP BY 
    r.vehiculo_id, v.num_serie_vehiculo, g.descripcion;

-- Consultar los datos de la tabla temporal
SELECT * FROM temp_emisiones_reporte;
