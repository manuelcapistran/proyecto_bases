/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     Archivo principal
*/


whenever  sqlerror exit rollback

Prompt Creación de usuarios Proyecto
accept p_iniciales default 'sbm' prompt 'Iniciales [sbm]: '
accept p_password  default '123456789' prompt 'Password para usuario [123456789]: ' hide
accept p_pdb  default 'sbmbd_s1' prompt 'Nombre de servicio de la PDB [sbmbd_s1]: ' hide
define p_usuario_invitado= &p_iniciales._proy_invitado 
define p_usuario_admin= &p_iniciales._proy_admin

promp ingrese contraseña de la pdb del proyecto
accept p_sys_pwd default 'system1' prompt 'Password del usuario sys [system1]' hide

set serveroutput on
@s-01-usuarios.sql

Prompt conectando como usuario &p_usuario_admin
connect &p_usuario_admin/&p_password@&p_pdb

Prompt creando objetos
@s-02-entidades.sql
@s-03-tablas-temporales.sql
@s-04-tablas-externas.sql
@S-05-secuencias.sql
@s-06-indices.sql
@s-07-sinonimos.sql
@s-08-vistas.sql
@s-09-carga-inicial.sql
--DISCONNECT
set define off
