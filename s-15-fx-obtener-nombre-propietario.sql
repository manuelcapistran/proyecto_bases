/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s15-2
*/

CREATE OR REPLACE FUNCTION obtener_nombre_propietario (
    p_propietario_id NUMBER
) RETURN VARCHAR2 IS
    v_nombre_completo VARCHAR2(120);
BEGIN
    SELECT nombre || ' ' || ap_paterno || ' ' || ap_materno
    INTO v_nombre_completo
    FROM propietario
    WHERE propietario_id = p_propietario_id;

    RETURN v_nombre_completo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Propietario no encontrado';
END;
/
