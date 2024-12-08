/*
@Autor:           Belmont Muñoz Samuel
                  Capistrán Manuel
@Fecha creación:  dd/mm/yyyy
@Descripción:     s15-3
*/

CREATE OR REPLACE FUNCTION verificar_placa_activa (
    p_num_placa VARCHAR2
) RETURN VARCHAR2 IS
    v_activa BOOLEAN;
BEGIN
    SELECT es_activa
    INTO v_activa
    FROM placa
    WHERE num_placa = p_num_placa;

    IF v_activa THEN
        RETURN 'Placa activa';
    ELSE
        RETURN 'Placa inactiva';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Placa no encontrada';
END;
/
