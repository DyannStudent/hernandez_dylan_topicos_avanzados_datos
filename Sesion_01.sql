
CREATE TABLE DetallesPedidos (DetalleID NUMBER PRIMARY KEY,PedidoID NUMBER,ProductoID NUMBER,Cantidad NUMBER,CONSTRAINT fk_detalle_pedido FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),CONSTRAINT fk_detalle_producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID));

INSERT INTO DetallesPedidos VALUES (1, 101, 1, 2); -- pedido 101 2 Laptops
INSERT INTO DetallesPedidos VALUES (2, 101, 2, 5); -- pedido 101 5 Mouse

SELECT * FROM DetallesPedidos;

