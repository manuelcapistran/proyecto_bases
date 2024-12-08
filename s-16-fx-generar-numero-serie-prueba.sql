/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s16-1
*/

DECLARE
    v_numero_serie VARCHAR2(50);
BEGIN
    v_numero_serie := generar_numero_serie('CAR',0/*modificar*/, 0/*modificar*/, 2023); -- Cambiar IDs según tus datos
    DBMS_OUTPUT.PUT_LINE('Número de serie generado: ' || v_numero_serie);
END;
/
