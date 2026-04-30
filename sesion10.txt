CREATE OR REPLACE PROCEDURE actualizar_total_pedidos (
    p_cliente_id IN Pedidos.ClienteID%TYPE, 
    p_porcentaje IN NUMBER DEFAULT 10      
) IS
    CURSOR c_pedidos_cliente IS
        SELECT PedidoID, Total
        FROM Pedidos
        WHERE ClienteID = p_cliente_id
        FOR UPDATE OF Total; 
    v_total_anterior Pedidos.Total%TYPE;
    v_nuevo_total    Pedidos.Total%TYPE;
    v_contador       NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- actualizando del ID: ' || p_cliente_id || ' ---');
    DBMS_OUTPUT.PUT_LINE('--- porcentaje de aumento aplicado: ' || p_porcentaje || '% ---');

    FOR r_pedido IN c_pedidos_cliente LOOP
        v_total_anterior := r_pedido.Total;
        
        v_nuevo_total := v_total_anterior * (1 + (p_porcentaje / 100));

        UPDATE Pedidos
        SET Total = v_nuevo_total
        WHERE CURRENT OF c_pedidos_cliente;

        v_contador := v_contador + 1;
        
        DBMS_OUTPUT.PUT_LINE('pedido ID: ' || r_pedido.PedidoID || 
                             ' | anterior: ' || v_total_anterior || 
                             ' | nuevo: ' || v_nuevo_total);
    END LOOP;

    IF v_contador > 0 THEN
        DBMS_OUTPUT.PUT_LINE('se actualizo: ' || v_contador || ' pedidos.');
        COMMIT; 
    ELSE
        DBMS_OUTPUT.PUT_LINE('el cliente no tiene pedidos registrados o no existe');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('error ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE calcular_costo_detalle (
    p_detalle_id IN DetallesPedidos.DetalleID%TYPE, 
    p_costo_total IN OUT NUMBER                     
) IS
    v_nombre_prod Productos.Nombre%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- iniciando calculo de id: ' || p_detalle_id || ' ---');

    SELECT (d.Cantidad * p.Precio), p.Nombre
    INTO p_costo_total, v_nombre_prod
    FROM DetallesPedidos d
    JOIN Productos p ON d.ProductoID = p.ProductoID
    WHERE d.DetalleID = p_detalle_id;

    DBMS_OUTPUT.PUT_LINE('producto: ' || v_nombre_prod);
    DBMS_OUTPUT.PUT_LINE('exito.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_costo_total := 0; 
        DBMS_OUTPUT.PUT_LINE('el ID ' || p_detalle_id || ' no fue encontrado en DetallesPedidos.');
    
    WHEN OTHERS THEN
        p_costo_total := -1; 
        DBMS_OUTPUT.PUT_LINE('error ' || SQLERRM);
END;
/