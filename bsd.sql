
CREATE DATABASE IF NOT EXISTS curso_topicos;
USE curso_topicos;


CREATE USER IF NOT EXISTS 'curso_topicos'@'localhost' IDENTIFIED BY 'curso2025';
GRANT ALL PRIVILEGES ON curso_topicos.* TO 'curso_topicos'@'localhost';
FLUSH PRIVILEGES;

-- Crear tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Ciudad VARCHAR(50),
    FechaNacimiento DATE
);

-- Crear tabla Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    Total DECIMAL(10,2),
    FechaPedido DATE,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Crear tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Precio DECIMAL(10,2)
);

-- Crear tabla DetallesPedidos
CREATE TABLE IF NOT EXISTS DetallesPedidos (
    DetalleID INT PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    Cantidad INT,
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Insertar datos en Clientes
INSERT INTO Clientes (ClienteID, Nombre, Ciudad, FechaNacimiento) VALUES 
(1, 'Juan Perez', 'Santiago', '1990-05-15'),
(2, 'María Gomez', 'Valparaiso', '1985-10-20'),
(3, 'Ana Lopez', 'Santiago', '1995-03-10');

-- Insertar datos en Pedidos
INSERT INTO Pedidos (PedidoID, ClienteID, Total, FechaPedido) VALUES 
(101, 1, 600, '2025-03-01'),
(102, 1, 300, '2025-03-02'),
(103, 2, 800, '2025-03-03');

-- Insertar datos en Productos
INSERT INTO Productos (ProductoID, Nombre, Precio) VALUES 
(1, 'Laptop', 1200),
(2, 'Mouse', 25);

-- Insertar datos en DetallesPedidos
INSERT INTO DetallesPedidos (DetalleID, PedidoID, ProductoID, Cantidad) VALUES 
(1, 101, 1, 2), -- Pedido 101: 2 Laptops
(2, 101, 2, 5); -- Pedido 101: 5 Mouse

COMMIT;
SELECT * FROM Clientes;
SELECT * FROM Pedidos;
SELECT * FROM Productos;
SELECT * FROM DetallesPedidos;