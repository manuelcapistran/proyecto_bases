/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     tablas externas, como ejemplo en clase
*/

-- Crear un directorio para el archivo externo
prompt creando directorio vehiculos_dir
CONNECT sys/system1@MCPBD_S1 AS SYSDBA; -- en mi caso
CREATE OR REPLACE DIRECTORY vehiculos_dir AS '/unam/bd/proyecto/ext'; -- en mi caso
GRANT READ, WRITE ON DIRECTORY vehiculos_dir TO mcp_proy_admin; -- en mi caso


prompt Conectando con usuario mcp_proy_admin para crear la tabla externa
connect MCP_PROY_ADMIN/manuel@MCPBD_S1 -- en mi caso

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vehiculos_externos';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignora si no existe
END;
/

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
        BADFILE vehiculos_dir: 'vehiculos_ext_bad.log'
        LOGFILE vehiculos_dir: 'vehiculos_ext.log'
        FIELDS TERMINATED BY ',' 
        LRTRIM
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
    LOCATION ('vehiculos_externos.csv')
)
REJECT LIMIT UNLIMITED;



-- Consultar datos desde la tabla externa
SELECT * FROM vehiculos_externos;


/*
hay que crear un nuevo directorio, en mi caso /unam/bd/proyecto/ext
se tuvo que cambiar los permisos
El usuario oracle necesita permisos de lectura, escritura y ejecución
 para el directorio ext y por lo menos permisos de lectura para los
 demás directorios, se asigna y 777 al directorio ext
 */
