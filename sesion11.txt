CREATE OR REPLACE FUNCTION calcular_edad_cliente (
    p_cliente_id IN Clientes.ClienteID%TYPE 
) RETURN NUMBER IS
    v_fecha_nac DATE;
    v_edad      NUMBER;
BEGIN
    SELECT FechaNacimiento 
    INTO v_fecha_nac
    FROM Clientes
    WHERE ClienteID = p_cliente_id;
    v_edad := FLOOR(MONTHS_BETWEEN(SYSDATE, v_fecha_nac) / 12);
    RETURN v_edad;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('el cliente ' || p_cliente_id || ' no existe.');
                                                                                           
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('error: ' || SQLERRM);
END;
/


CREATE OR REPLACE FUNCTION obtener_precio_promedio 
RETURN NUMBER IS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(Precio) 
    INTO v_promedio 
    FROM Productos;
    IF v_promedio IS NULL THEN
        RETURN 0;
    END IF;
    RETURN v_promedio;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('error: ' || SQLERRM);
END;
/
