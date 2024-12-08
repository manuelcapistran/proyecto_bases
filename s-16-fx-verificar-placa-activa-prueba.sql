/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s16-3
*/

DECLARE
    v_estado VARCHAR2(50);
BEGIN
    v_estado := verificar_placa_activa('ABC123'); -- Cambia el número de placa según tus datos
    DBMS_OUTPUT.PUT_LINE('Estado de la placa: ' || v_estado);
END;
/
