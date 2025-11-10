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
-- 2. CLIENTES (id_TipoUsuario = 2)  aaaaa
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
--INSERT PARA LA TABLA MECANICOS

INSERT INTO Mecanico (id_Usuario,Especialidad,Costo_Hora)
values (1, 'Electricidad',15000)

INSERT INTO Mecanico (id_Usuario,Especialidad,Costo_Hora)
values (2,'Mecanica', 12000)

INSERT INTO Mecanico (id_Usuario,Especialidad,Costo_Hora)
values (3,'Pintura',18000)

-- INSERT PARA LA TABLA CLIENTES

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (4, 'Lavalle 1856', '5-7-2022')

INSERT INTO Cliente (,Direccion, Fecha_Alta)
values (5,'Mendoza 1243', '4-3-2023')

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (6,'Cordero 1150','2-6-2023')

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (7,'San Gines 510','3-4-2021')

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (8,'Maximino Perez 2354','7-8-2022')

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (9,'Belgrano 662','6-6-2024')

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (10,'Maipu 1046','2-5-2025')

GO

-- AQUI IRIA LA TABLA DE MOTOS Y SERVICIOS.

-- INSERT DE MOTOS 
INSERT INTO Motos (id_Usuario, Marca, Modelo, Patente)
VALUES
(4, 'Yamaha', 'FZ25', 'AA123BB'),
(5, 'Honda', 'CG150', 'AC456CD'),
(6, 'Bajaj', 'Dominar 400', 'AE789EF'),
(7, 'Motomel', 'Sirius 200', 'AG321GH'),
(8, 'Corven', 'Energy 110', 'AH654IJ'),
(9, 'Kawasaki', 'Z400', 'AJ321KL'),
(10, 'Suzuki', 'GN125', 'AK987MN');


-- INSERT DE SERVICIO

INSERT INTO Servicio (Descripcion)
VALUES 
('Mantenimiento general'),
('Cambio de aceite'),
('Reparación de motor'),
('Ajuste de frenos'),
('Revisión eléctrica');




-- -----------------------------------------------------
--  INSERCIÓN DE LA TABLA ESTADO
-- -----------------------------------------------------

SET IDENTITY_INSERT Estado ON; -- Permite insertar IDs explícitos si es necesario.

INSERT INTO Estado (id_Estado, Descripcion) VALUES
(1, 'Ingreso y Diagnóstico'),
(2, 'Esperando Presupuesto'),
(3, 'En Reparación'),
(4, 'Control de Calidad'),
(5, 'Listo para Retirar'),
(6, 'Entregado');

SET IDENTITY_INSERT Estado OFF;
GO

-- -----------------------------------------------------
--  INSERCIÓN DE HECHOS (REPARACION)
-- -----------------------------------------------------
--Utilizamos los datos insertados ya previos.

-- Reparación 1: Mantenimiento General (Moto: AA123BC, Cliente: Sofía, Mecánico: Martín)
INSERT INTO Reparacion (id_Moto, id_Mecanico, id_Servicio, id_Estado, fecha_Ingreso, Descripcion)
VALUES
(
    -- id_Moto de la patente 'AA123BC' (Moto 1)
    (SELECT id_Moto FROM Motos WHERE Patente = 'AA123BC'), 
    -- id_Mecanico de 'Martín Gómez' (ID 1)
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400401'), 
    -- Servicio: Mantenimiento General (Asumimos ID 1)
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Mantenimiento General'), 
    -- Estado: En Reparación (ID 3)
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'En Reparación'), 
    '2025-10-20',
    'Cambio de aceite, filtro de aire y pastillas de freno delanteras.'
);

-- Reparación 2: Reparación de Motor (Moto: DD456EE, Cliente: Diego, Mecánico: Javier)
INSERT INTO Reparacion (id_Moto, id_Mecanico, id_Servicio, id_Estado, fecha_Ingreso, fecha_Salida, costo_Total)
VALUES
(
    -- id_Moto de la patente 'DD456EE' (Moto 2)
    (SELECT id_Moto FROM Motos WHERE Patente = 'DD456EE'), 
    -- id_Mecanico de 'Javier Rodríguez' (ID 2)
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), 
    -- Servicio: Reparación de Motor (Asumimos ID 2)
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Reparación de Motor'), 
    -- Estado: Entregado (ID 6)
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Entregado'), 
    '2025-09-01',
    '2025-09-15',
    35000.75 -- Reparación finalizada y facturada
);

-- Reparación 3: Sistema Eléctrico (Moto: FF789GG, Cliente: Valeria, Mecánico: Lucas)
INSERT INTO Reparacion (id_Moto, id_Mecanico, id_Servicio, id_Estado, fecha_Ingreso, Descripcion)
VALUES
(
    -- id_Moto de la patente 'FF789GG' (Moto 3)
    (SELECT id_Moto FROM Motos WHERE Patente = 'FF789GG'), 
    -- id_Mecanico de 'Lucas Pérez' (ID 3)
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400403'), 
    -- Servicio: Sistema Eléctrico (Asumimos ID 3)
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Sistema Eléctrico'), 
    -- Estado: Esperando Presupuesto (ID 2)
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Esperando Presupuesto'), 
    '2025-10-30',
    'Falla intermitente en luces de giro.'
);
GO