/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s15-1
*/

CREATE OR REPLACE FUNCTION generar_numero_serie (
    p_tipo VARCHAR2,
    p_marca_id NUMBER,
    p_modelo_id NUMBER,
    p_anio NUMBER
) RETURN VARCHAR2 IS
    v_numero_serie VARCHAR2(50);
BEGIN
    v_numero_serie := p_tipo || '-' || p_marca_id || '-' || p_modelo_id || '-' || p_anio;
    RETURN v_numero_serie;
END;
/
