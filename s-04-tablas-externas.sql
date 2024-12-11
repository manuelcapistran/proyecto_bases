/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     tablas externas, como ejemplo en clase
*/
prompt creando directorio vehiculos_dir
disconnect
prompt creando directorio vehiculos_dir
CONNECT sys/&p_sys_pwd@&p_pdb AS SYSDBA;
CREATE OR REPLACE DIRECTORY vehiculos_dir AS '/unam/bd/proyecto/ext';
GRANT READ, WRITE ON DIRECTORY vehiculos_dir TO &p_usuario_admin;
disconnect

prompt Conectando con usuario &p_usuario_admin para crear la tabla externa
CONNECT &p_usuario_admin/&p_password@&p_pdb; 

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

