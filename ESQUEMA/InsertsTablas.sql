USE TallerMecanicoMotos;
GO
-- Inserts para la tabla TipoUsuario (Catálogo de Roles)
INSERT INTO TipoUsuario (Descripcion) VALUES ('Mecanico'); -- id_TipoUsuario = 1
INSERT INTO TipoUsuario (Descripcion) VALUES ('Cliente');  -- id_TipoUsuario = 2
INSERT INTO TipoUsuario (Descripcion) VALUES ('Administrador');
GO


-- Inserts para la tabla Usuario

-- ------------------------------
-- 1. MECÁNICOS (id_TipoUsuario = 1)
-- ------------------------------
INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (1, 'Martín', 'Gómez', '40400401', '1155551234', 'martin.gomez@taller.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (1, 'Javier', 'Rodríguez', '40400402', '1155552345', 'javier.rodriguez@taller.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (1, 'Lucas', 'Pérez', '40400403', '1155553456', 'lucas.perez@taller.com');

-- ------------------------------
-- 2. CLIENTES (id_TipoUsuario = 2)
-- ------------------------------
INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Sofía', 'Fernández', '30300304', '1155554567', 'sofia.fernandez@cliente.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Diego', 'López', '30300305', '1155555678', 'diego.lopez@cliente.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Valeria', 'Díaz', '30300306', '1155556789', 'valeria.diaz@cliente.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Andrés', 'Giménez', '30300307', '1155557890', 'andres.gimenez@cliente.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Marina', 'Ruiz', '30300308', '1155558901', 'marina.ruiz@cliente.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Facundo', 'Sánchez', '30300309', '1155559012', 'facundo.sanchez@cliente.com');

INSERT INTO Usuario (id_TipoUsuario, Nombre, Apellido, Dni, Telefono, Email) 
VALUES (2, 'Emilia', 'Castro', '30300310', '1155550123', 'emilia.castro@cliente.com');
GO