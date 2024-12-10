/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s10
*/

-- 1
-- Consulta con Joins (inner join y left outer join)
-- Obtener información de vehículos junto con su propietario y modelo
SELECT 
    V.VEHICULO_ID,
    V.NUM_SERIE_VEHICULO,
    P.NOMBRE AS PROPIETARIO,
    M.NOMBRE AS MODELO,
    M.ANIO,
    E.DESCRIPCION AS ESTATUS
FROM 
    VEHICULO V
INNER JOIN 
    PROPIETARIO P ON V.PROPIETARIO_ID = P.PROPIETARIO_ID
INNER JOIN 
    MODELO M ON V.MODELO_ID = M.MODELO_ID
LEFT JOIN 
    ESTATUS_VEHICULO E ON V.ESTATUS_VEHICULO_ID = E.ESTATUS_VEHICULO_ID;


-- 2
-- Obtener el promedio de emisiones por tipo de gas
SELECT 
    G.DESCRIPCION AS TIPO_GAS,
    AVG(RE.VALOR_MEDIDO) AS PROMEDIO_EMISIONES
FROM 
    REPORTE_EMISIONES RE
INNER JOIN 
    GAS G ON RE.GAS_ID = G.GAS_ID
GROUP BY 
    G.DESCRIPCION
HAVING 
    AVG(RE.VALOR_MEDIDO) < (SELECT AVG(VALOR_MEDIDO) FROM REPORTE_EMISIONES);

-- 3
-- Subconsulta
-- Consultar propietarios con vehículos que tienen emisiones mayores al promedio
SELECT 
    P.NOMBRE AS PROPIETARIO,
    P.EMAIL
FROM 
    PROPIETARIO P
WHERE 
    P.PROPIETARIO_ID IN (
        SELECT DISTINCT V.PROPIETARIO_ID
        FROM VEHICULO V
        INNER JOIN REPORTE_EMISIONES RE ON V.VEHICULO_ID = RE.VEHICULO_ID
        WHERE RE.VALOR_MEDIDO > (SELECT AVG(VALOR_MEDIDO) FROM REPORTE_EMISIONES)
    );

-- 4
--Consulta que Involucra un Sinónimo
-- Crear el sinónimo (esto debe ejecutarse previamente como un usuario con permisos)
CREATE OR REPLACE SYNONYM SINONIMO_VERIFICACION FOR VERIFICACION;

-- Usar el sinónimo en la consulta
SELECT 
    FOLIO, 
    CLAVE_VERIFICENTRO, 
    FECHA_VERIFICACION 
FROM 
    SINONIMO_VERIFICACION;


-- 5
-- Consulta con Tabla Externa
-- Consultar datos de la tabla externa (vehiculos_externos debe estar creada)
SELECT 
    VEHICULO_ID, 
    MARCA, 
    MODELO, 
    ANIO, 
    ES_CARGA 
FROM 
    VEHICULOS_EXTERNOS
WHERE 
    ANIO > 2020;


-- 6
-- Consulta con álgebra relacional (INTERSECT y MINUS)
-- Intersect: Obtener vehículos que tienen reportes tanto en REPORTE_EMISIONES como en REPORTE_VERIFICENTRO
SELECT VEHICULO_ID 
FROM REPORTE_EMISIONES
INTERSECT
SELECT VEHICULO_ID 
FROM VERIFICACION;

-- Minus: Obtener vehículos con reportes de emisiones pero sin verificaciones
SELECT VEHICULO_ID 
FROM REPORTE_EMISIONES
MINUS
SELECT VEHICULO_ID 
FROM VERIFICACION;


-- 7
-- Consulta con GROUP BY y funciones de agregación
-- Obtener el número de vehículos por estatus
SELECT 
    E.DESCRIPCION AS ESTATUS, 
    COUNT(V.VEHICULO_ID) AS NUMERO_VEHICULOS
FROM 
    VEHICULO V
INNER JOIN 
    ESTATUS_VEHICULO E ON V.ESTATUS_VEHICULO_ID = E.ESTATUS_VEHICULO_ID
GROUP BY 
    E.DESCRIPCION
HAVING 
    COUNT(V.VEHICULO_ID) > 0;


-- 8
-- Consulta que involucra una tabla temporal
-- Crear la tabla temporal previamente
CREATE GLOBAL TEMPORARY TABLE TEMP_EMISIONES (
    VEHICULO_ID NUMBER(10, 0),
    GAS_ID NUMBER(10, 0),
    PROMEDIO_EMISIONES NUMBER(10, 4)
) ON COMMIT PRESERVE ROWS;

-- Insertar datos en la tabla temporal
INSERT INTO TEMP_EMISIONES (VEHICULO_ID, GAS_ID, PROMEDIO_EMISIONES)
SELECT 
    RE.VEHICULO_ID, 
    RE.GAS_ID, 
    AVG(RE.VALOR_MEDIDO) AS PROMEDIO_EMISIONES
FROM 
    REPORTE_EMISIONES RE
GROUP BY 
    RE.VEHICULO_ID, RE.GAS_ID;

-- Consultar los datos de la tabla temporal
SELECT * 
FROM TEMP_EMISIONES
WHERE PROMEDIO_EMISIONES > 0.05;


-- 9
-- Consulta con funciones de agregación y subconsultas
-- Obtener el propietario con el vehículo más nuevo
SELECT 
    P.NOMBRE AS PROPIETARIO, 
    P.EMAIL, 
    V.NUM_SERIE_VEHICULO, 
    M.NOMBRE AS MODELO, 
    M.ANIO
FROM 
    PROPIETARIO P
INNER JOIN 
    VEHICULO V ON P.PROPIETARIO_ID = V.PROPIETARIO_ID
INNER JOIN 
    MODELO M ON V.MODELO_ID = M.MODELO_ID
WHERE 
    M.ANIO = (SELECT MAX(ANIO) FROM MODELO);
