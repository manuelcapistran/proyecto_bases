--autor(es)
--fecha de creacion 
--descripcion esta es una idea de como se puede implementar

-- Crear un directorio para el archivo externo
CREATE OR REPLACE DIRECTORY vehiculos_dir AS '/unam/bd/proyecto';
GRANT READ, WRITE ON DIRECTORY vehiculos_dir TO mcp_proy_admin;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vehiculos_externos';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignora si no existe
END;


-- Crear la tabla externa
CREATE TABLE vehiculos_externos (
    vehiculo_id    NUMBER(10, 0),
    placa          VARCHAR2(10),
    marca          VARCHAR2(20),
    modelo         VARCHAR2(20),
    anio           NUMBER(4, 0),
    es_carga       CHAR(1)
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY vehiculos_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ',' 
        MISSING FIELD VALUES ARE NULL
        ( 
            vehiculo_id    CHAR(10),
            placa          CHAR(10),
            marca          CHAR(20),
            modelo         CHAR(20),
            anio           CHAR(4),
            es_carga       CHAR(1)
        )
    )
    LOCATION ('vehiculos_externos.txt')
)
REJECT LIMIT UNLIMITED;

-- Consultar datos desde la tabla externa
SELECT * FROM vehiculos_externos;

-- Ejemplo: Filtrar solo vehículos de carga
SELECT * 
FROM vehiculos_externos
WHERE es_carga = 'Y';

SELECT OBJECT_TYPE, OBJECT_NAME 
FROM USER_OBJECTS 
WHERE OBJECT_NAME = 'VEHICULOS_EXTERNOS';

DROP TABLE vehiculos_externos;
