
DECLARE
    v_pedido_id NUMBER := 101;
    v_total     NUMBER;
    v_categoria VARCHAR2(20);
BEGIN
    --total del pedido
    SELECT Total INTO v_total
    FROM Pedidos
    WHERE PedidoID = v_pedido_id;

    IF v_total <= 400 THEN
        v_categoria := 'BAJO';
    ELSIF v_total > 400 AND v_total <= 700 THEN
        v_categoria := 'MEDIO';
    ELSE
        v_categoria := 'ALTO';
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- resultado de Clasificación ---');
    DBMS_OUTPUT.PUT_LINE('pedido ID: ' || v_pedido_id);
    DBMS_OUTPUT.PUT_LINE('monto Total: ' || v_total);
    DBMS_OUTPUT.PUT_LINE('categoria: ' || v_categoria);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('error: ' || v_pedido_id || ' no existe.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('error.');
END;
/