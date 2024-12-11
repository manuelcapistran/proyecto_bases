CONNECT SBM_PROY_ADMIN/123456789@sbmbd_s1; 

prompt CREACION DE PROCEDIMIENTO PR_INSERTAR_NOTIFICACION
accept ENTER DEFAULT 'B'
--primer se ejecuta pr_insertar_notificacion para definicacion de trigger
@s-13-p-pr_insertar_notificacion.sql
@s-14-p-pr_insertar_notificacion-prueba.sql 

prompt CREACION DE PROCEDIMIENTO PR_INSERTAR_FALTA
accept ENTER DEFAULT 'B'
--segundo se ejecuta pr_insertar_falta para prueba de trigger
@s-13-p-pr_insertar_falta.sql
@s-14-p-pr_insertar_falta-prueba.sql

prompt CREACION DE PROCEDIMIENTO tr_falta_puntos_negativos
accept ENTER DEFAULT 'B'
@s-11-t-tr_falta_puntos_negativos.sql
@s-12-t-tr_falta_puntos_negativos-prueba.sql

prompt CREACION DE PROCEDIMIENTO TR_INSERTAR_LICENCIA
accept ENTER DEFAULT 'B'
@s-11-t-tr_insertar_licencia.sql
@s-12-t-tr_insertar_licencia-prueba.sql

prompt CREACION DE PROCEDIMIENTO TR_INSERTAR_TRANSPORTE_PUBLICO
accept ENTER DEFAULT 'B'
@s-11-t-tr_insertar_transporte_publico.sql
@s-12-t-tr_insertar_transporte_publico-prueba.sql

prompt CREACION DE PROCEDIMIENTO tr_notificacion_reporte_emisiones
accept ENTER DEFAULT 'B'
@s-11-t-tr_notificacion_reporte_emisiones.sql
@s-12-t-tr_notificacion_reporte_emisiones-prueba.sql

prompt CREACION DE PROCEDIMIENTO PR_INSERTAR_NOTIFICACION
accept ENTER DEFAULT 'B'
@s-13-p-pr_insertar_licencia.sql
@s-14-p-pr_insertar_licencia-prueba.sql

prompt CREACION DE PROCEDIMIENTO PR_INSERTAR_NOTIFICACION
accept ENTER DEFAULT 'B'
@s-13-p-pr_actualizar_estatus_verif_aprobada.sql
@s-14-p-pr_actualizar_estatus_verif_aprobada-prueba.sql 

prompt CREACION DE PROCEDIMIENTO PR_INSERTAR_NOTIFICACION
accept ENTER DEFAULT 'B'
@s-17-lob-pr_obtener_blob.sql
@s-18-lob-pr_obtener_blob-prueba.sql

prompt CREACION DE PROCEDIMIENTO PR_INSERTAR_NOTIFICACION
accept ENTER DEFAULT 'B'
@s-17-lob-pr_obtener_imagen.sql
@s-18-lob-pr_obtener_imagen-prueba.sql 

DISCONNECT