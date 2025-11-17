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
--INSERT PARA LA TABLA MECANICOS

INSERT INTO Mecanico (id_Usuario,Especialidad,Costo_Hora)
values (1, 'Electricidad',15000)

INSERT INTO Mecanico (id_Usuario,Especialidad,Costo_Hora)
values (2,'Mecanica', 12000)

INSERT INTO Mecanico (id_Usuario,Especialidad,Costo_Hora)
values (3,'Pintura',18000)

-- INSERT PARA LA TABLA CLIENTES

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (4, 'Lavalle 1856', '5-7-2022');

INSERT INTO Cliente (id_Usuario,Direccion, Fecha_Alta)
values (5,'Mendoza 1243', '4-3-2023');

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (6,'Cordero 1150','2-6-2023');

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (7,'San Gines 510','3-4-2021');

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (8,'Maximino Perez 2354','7-8-2022');

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (9,'Belgrano 662','6-6-2024');

INSERT INTO Cliente (id_Usuario, Direccion, Fecha_Alta)
values (10,'Maipu 1046','2-5-2025');

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

GO
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

-- 1. Declaramos TODAS las variables al inicio del lote
DECLARE @idReparacionCreada_1 INT;
DECLARE @idReparacionCreada_2 INT;
DECLARE @idReparacionCreada_3 INT;
DECLARE @idReparacionCreada_4 INT;
DECLARE @idReparacionCreada_5 INT;
DECLARE @idReparacionCreada_6 INT;
DECLARE @idReparacionCreada_7 INT;


-- -----------------------------------------------------
-- Reparación 1: Mantenimiento General (Moto: AA123BB)
-- -----------------------------------------------------

-- 1.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, -- Mecánico principal
    id_Estado, 
    fecha_Ingreso, 
    Descripcion
)
VALUES
(
    (SELECT id_Moto FROM Motos WHERE Patente = 'AA123BB'), -- Patente real de Sofía
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400401'), -- Martín Gómez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'En Reparación'), -- ID 3
    '2025-10-20',
    'Mantenimiento y revisión de frenos de la Yamaha FZ25.'
);

-- 1.2. Capturamos el ID
SET @idReparacionCreada_1 = SCOPE_IDENTITY();

-- 1.3. Insertamos los servicios específicos
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_1,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Mantenimiento general'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400401'), -- Martín Gómez
    15000.00
);

INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_1,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Ajuste de frenos'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400401'), -- Martín Gómez
    7500.00
);

-- -----------------------------------------------------
-- Reparación 2: Reparación de Motor (Moto: AC456CD)
-- -----------------------------------------------------

-- 2.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, 
    id_Estado, 
    fecha_Ingreso, 
    fecha_Salida, 
    costo_Total
)
VALUES
(
    (SELECT id_Moto FROM Motos WHERE Patente = 'AC456CD'), -- Patente real de Diego
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), -- Javier Rodríguez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Entregado'), -- ID 6
    '2025-09-01',
    '2025-09-15',
    35000.75
);

-- 2.2. Capturamos el ID
SET @idReparacionCreada_2 = SCOPE_IDENTITY();

-- 2.3. Insertamos el detalle
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_2,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Reparación de motor'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), -- Javier Rodríguez
    35000.75
);

-- -----------------------------------------------------
-- Reparación 3: Sistema Eléctrico (Moto: AE789EF)
-- -----------------------------------------------------

-- 3.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, 
    id_Estado, 
    fecha_Ingreso, 
    Descripcion
)
VALUES
(
    (SELECT id_Moto FROM Motos WHERE Patente = 'AE789EF'), -- Patente real de Valeria
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400403'), -- Lucas Pérez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Esperando Presupuesto'), -- ID 2
    '2025-10-30',
    'Falla intermitente en luces de giro.'
);

-- 3.2. Capturamos el ID
SET @idReparacionCreada_3 = SCOPE_IDENTITY();

-- 3.3. Insertamos el detalle
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_3,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Revisión eléctrica'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400403'), -- Lucas Pérez
    NULL -- Aún no hay costo
);

-- -----------------------------------------------------
-- Reparación 4: Cambio de Aceite (Moto: AG321GH)
-- -----------------------------------------------------

-- 4.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, 
    id_Estado, 
    fecha_Ingreso, 
    Descripcion
)
VALUES
(   
    (SELECT id_Moto FROM Motos WHERE Patente = 'AG321GH'), -- Patente real de Andrés
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400403'), -- Lucas Pérez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Control de Calidad'), -- ID 4
    '2025-11-1',
    'Cambio de Aceite por kilometraje'
);

-- 4.2. Capturamos el ID
SET @idReparacionCreada_4 = SCOPE_IDENTITY();

-- 4.3. Insertamos el detalle
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_4,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Cambio de aceite'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400403'), -- Lucas Pérez
    10000.00
);

-- -----------------------------------------------------
-- Reparación 5: Revisión eléctrica (Moto: AH654IJ)
-- -----------------------------------------------------

-- 5.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, 
    id_Estado, 
    fecha_Ingreso, 
    Descripcion
)
VALUES
(   
    (SELECT id_Moto FROM Motos WHERE Patente = 'AH654IJ'), -- Patente real de Marina
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), -- Javier Rodríguez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Esperando Presupuesto'), -- ID 2
    '2025-11-5',
    'Falla en CPU'
);

-- 5.2. Capturamos el ID
SET @idReparacionCreada_5 = SCOPE_IDENTITY();

-- 5.3. Insertamos el detalle
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_5,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Revisión eléctrica'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), -- Javier Rodríguez
    16000.00
);

-- -----------------------------------------------------
-- Reparación 6: Cambio de Aceite (Moto: AJ321KL)
-- -----------------------------------------------------

-- 6.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, 
    id_Estado, 
    fecha_Ingreso, 
    Descripcion
)
VALUES
(   
    (SELECT id_Moto FROM Motos WHERE Patente = 'AJ321KL'), -- Patente real de Facundo
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400401'), -- Martín Gómez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Listo para Retirar'), -- ID 5
    '2025-10-1',
    'Mantenimiento y Acondicionamiento General por abandono'
);

-- 6.2. Capturamos el ID
SET @idReparacionCreada_6 = SCOPE_IDENTITY();

-- 6.3. Insertamos el detalle
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_6,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Mantenimiento general'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400401'), -- Martín Gómez
    23000.00
);

-- -----------------------------------------------------
-- Reparación 7: Cambio de Aceite (Moto: AK987MN)
-- -----------------------------------------------------

-- 7.1. Insertamos la cabecera
INSERT INTO Reparacion (
    id_Moto, 
    id_Mecanico, 
    id_Estado, 
    fecha_Ingreso, 
    Descripcion
)
VALUES
(   
    (SELECT id_Moto FROM Motos WHERE Patente = 'AK987MN'), -- Patente real de Emilia
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), -- Javier	Rodríguez
    (SELECT id_Estado FROM Estado WHERE Descripcion = 'Ingreso y Diagnóstico'), -- ID 1
    '2025-11-13',
    'Ajuste de frenos por aire en el circuito'
);

-- 7.2. Capturamos el ID
SET @idReparacionCreada_7 = SCOPE_IDENTITY();

-- 7.3. Insertamos el detalle
INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
VALUES
(
    @idReparacionCreada_7,
    (SELECT id_Servicio FROM Servicio WHERE Descripcion = 'Ajuste de frenos'),
    (SELECT id_Usuario FROM Usuario WHERE Dni = '40400402'), -- Javier	Rodríguez
    NULL -- Aún no hay costo
);




-- -----------------------------------------------------
-- 4. FIN DEL LOTE
-- -----------------------------------------------------
PRINT 'Inserciones en Reparacion y DetalleServicio realizadas con éxito.';
GO
--









