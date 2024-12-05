/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     Archivo principal
*/

Prompt concetando a PDB &p_pdb
connect sys&p_sys_pwd/@&p_pdb as sysdba

--crear roles
CREATE ROLE rol_admin;
CREATE ROLE rol_invitado;

-- Asignar privilegios a los roles
GRANT CREATE TABLE, CREATE SESSION, CREATE SEQUENCE, CREATE PROCEDURE TO rol_admin;
GRANT CREATE SESSION TO rol_invitado;

drop user if EXISTS &p_usuario_admin cascade;
create user &p_usuario_admin identified by &p_password quota unlimited on users;

drop user if exists &p_usuario_invitado cascade;
create user &p_usuario_invitado IDENTIFIED by &p_password QUOTA UNLIMITED on users;


-- Asignar los roles a los usuarios
GRANT rol_admin TO &p_usuario_admin;
GRANT rol_invitado TO &p_usuario_invitado

DISCONNECT
