--autor(es)
--fecha de creacion 
--descripcion 

Prompt concetando a PDB mcpbd_s1
connect sys/system1@mcpbd_s1 as sysdba

--crear roles
CREATE ROLE rol_admin;
CREATE ROLE rol_invitado;

-- Asignar privilegios a los roles
GRANT CREATE TABLE, CREATE SESSION, CREATE SEQUENCE, CREATE PROCEDURE TO rol_admin;
GRANT CREATE SESSION TO rol_invitado;

drop user if EXISTS mcp_proy_admin cascade;
create user mcp_proy_admin identified by manuel quota unlimited on users;

drop user if exists mcp_proy_invitado cascade;
create user mcp_proy_invitado IDENTIFIED by manuel QUOTA UNLIMITED on users;


-- Asignar los roles a los usuarios
GRANT rol_admin TO mcp_proy_admin;
GRANT rol_invitado TO mcp_proy_invitado;
