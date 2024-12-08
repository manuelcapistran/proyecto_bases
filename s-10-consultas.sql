/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s10
*/
--1
SELECT 
    v.vehiculo_id,
    p.nombre AS propietario,
    pl.num_placa AS placa,
    m.nombre AS modelo,
    ma.descripcion AS marca
FROM 
    vehiculo v
INNER JOIN propietario p ON v.propietario_id = p.propietario_id
INNER JOIN placa pl ON v.placa_id = pl.placa_id
INNER JOIN modelo m ON v.modelo_id = m.modelo_id
INNER JOIN marca ma ON m.marca_id = ma.marca_id;

--2
SELECT 
    p.nombre AS propietario,
    COUNT(v.vehiculo_id) AS total_vehiculos
FROM 
    propietario p
INNER JOIN vehiculo v ON p.propietario_id = v.propietario_id
GROUP BY 
    p.nombre
HAVING COUNT(v.vehiculo_id) > 1;

--3
SELECT 
    p.nombre AS propietario,
    COUNT(v.vehiculo_id) AS total_vehiculos
FROM 
    propietario p
INNER JOIN vehiculo v ON p.propietario_id = v.propietario_id
GROUP BY 
    p.nombre
HAVING COUNT(v.vehiculo_id) > 1;

--4
SELECT 
    g.descripcion AS tipo_gas,
    EXTRACT(YEAR FROM re.fecha_registro) AS anio,
    AVG(re.valor_medido) AS promedio_emisiones
FROM 
    reporte_emisiones re
INNER JOIN gas g ON re.gas_id = g.gas_id
GROUP BY 
    g.descripcion, EXTRACT(YEAR FROM re.fecha_registro)
HAVING AVG(re.valor_medido) > 0.5;

--5
SELECT vehiculo_id 
FROM verificacion
MINUS
SELECT vehiculo_id 
FROM reporte_emisiones;

--6
SELECT DISTINCT p.propietario_id
FROM propietario p
INNER JOIN vehiculo v ON p.propietario_id = v.propietario_id
INNER JOIN modelo m ON v.modelo_id = m.modelo_id
WHERE m.marca_id = (SELECT marca_id FROM marca WHERE descripcion = 'Toyota')
INTERSECT
SELECT DISTINCT p.propietario_id
FROM propietario p
INNER JOIN vehiculo v ON p.propietario_id = v.propietario_id
INNER JOIN modelo m ON v.modelo_id = m.modelo_id
WHERE m.marca_id = (SELECT marca_id FROM marca WHERE descripcion = 'Ford');

--7
SELECT v.vehiculo_id, v.num_serie_vehiculo
FROM vehiculo v
WHERE EXISTS (
    SELECT 1 
    FROM verificacion ver 
    WHERE ver.vehiculo_id = v.vehiculo_id
    GROUP BY ver.vehiculo_id
    HAVING COUNT(*) > 1
);

--8
CREATE SYNONYM prop FOR propietario;

SELECT nombre, ap_paterno, ap_materno
FROM prop;

--9
CREATE VIEW vista_vehiculos AS
SELECT 
    v.vehiculo_id,
    p.nombre AS propietario,
    pl.num_placa AS placa,
    m.nombre AS modelo,
    ma.descripcion AS marca
FROM 
    vehiculo v
INNER JOIN propietario p ON v.propietario_id = p.propietario_id
INNER JOIN placa pl ON v.placa_id = pl.placa_id
INNER JOIN modelo m ON v.modelo_id = m.modelo_id
INNER JOIN marca ma ON m.marca_id = ma.marca_id;

SELECT * FROM vista_vehiculos;

--10
CREATE GLOBAL TEMPORARY TABLE temp_vehiculos_emisiones (
    vehiculo_id NUMBER,
    promedio_emisiones NUMBER
) ON COMMIT PRESERVE ROWS;

INSERT INTO temp_vehiculos_emisiones
SELECT v.vehiculo_id, AVG(re.valor_medido) AS promedio
FROM vehiculo v
INNER JOIN reporte_emisiones re ON v.vehiculo_id = re.vehiculo_id
GROUP BY v.vehiculo_id
HAVING AVG(re.valor_medido) > 0.8;

SELECT * FROM temp_vehiculos_emisiones;
