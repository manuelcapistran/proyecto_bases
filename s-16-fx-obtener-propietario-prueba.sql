/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s16-2
*/

DECLARE
    v_nombre VARCHAR2(120);
BEGIN
    v_nombre := obtener_nombre_propietario(1); -- Cambia el ID según la carga inicial
    DBMS_OUTPUT.PUT_LINE('Nombre completo del propietario: ' || v_nombre);
END;
/
