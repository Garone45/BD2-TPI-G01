use TallerMecanicoMotos

-- -----------------------------------------------------------------
-- Vista 1: V_Reparaciones_Activas
-- -----------------------------------------------------------------
-- Proposito: Muestra un resumen de todas las reparaciones que no estan
-- finalizadas, incluyendo datos del cliente y del mecánico asignado.
-- -----------------------------------------------------------------
GO
CREATE VIEW V_Reparaciones_Activas AS
SELECT
    R.id_Reparacion,
    R.Fecha_Ingreso,
    M.Marca AS Marca_Moto,
    M.Patente AS Patente_Moto,
    U_Cli.Nombre AS Nombre_Cliente,
    U_Cli.Apellido AS Apellido_Cliente,
    U_Cli.Telefono AS Telefono_Cliente,
    CONCAT(U_Mec.Nombre, ' ', U_Mec.Apellido) AS Nombre_Mecanico_Asignado,
    R.Descripcion AS Descripcion_Problema,
    E.Descripcion AS Estado_Actual
FROM Reparacion R
JOIN Estado E ON R.id_Estado = E.id_Estado
JOIN Motos M ON R.id_Moto = M.id_Moto
JOIN Cliente C ON M.id_Usuario = C.id_Usuario
JOIN Usuario U_Cli ON C.id_Usuario = U_Cli.id_Usuario
JOIN Mecanico Mec ON R.id_Mecanico = Mec.id_Usuario
JOIN Usuario U_Mec ON Mec.id_Usuario = U_Mec.id_Usuario

WHERE
    E.Descripcion NOT IN ('Finalizado', 'Entregado', 'Cancelado');

-- -----------------------------------------------------------------
-- Vista 2: V_Resumen_Facturacion
-- -----------------------------------------------------------------
-- Proposito: Muestra un resumen de las reparaciones FINALIZADAS
-- con el costo total, listas para pasar al cliente o para el historial.
-- -----------------------------------------------------------------
GO
CREATE VIEW V_Resumen_Facturacion AS
SELECT
    R.id_Reparacion,
    R.Fecha_Ingreso,
    R.Fecha_Salida,
    M.Patente AS Patente_Moto,
    U.Dni AS DNI_Cliente,
    CONCAT(U.Nombre, ' ', U.Apellido) AS Nombre_Completo_Cliente,
    E.Descripcion AS Estado_Reparacion,
    R.Costo_Total
FROM Reparacion R
JOIN Motos M ON R.id_Moto = M.id_Moto
JOIN Cliente C ON M.id_Usuario = C.id_Usuario
JOIN Usuario U ON C.id_Usuario = U.id_Usuario
JOIN Estado E ON R.id_Estado = E.id_Estado
WHERE
    E.Descripcion IN ('Finalizado', 'Entregado');

-- -----------------------------------------------------------------
-- Vista 3: V_Detalle_Servicios_Por_Reparacion
-- -----------------------------------------------------------------
-- Propósito: Desglosa todos los servicios individuales realizados
-- en cada reparación, con el costo de cada uno y qué mecánico lo hizo.
-- -----------------------------------------------------------------
GO
CREATE VIEW V_Detalle_Servicios_Por_Reparacion AS
SELECT
    DS.id_Reparacion,
    S.Descripcion AS Descripcion_Servicio,
    CONCAT(U.Nombre, ' ', U.Apellido) AS Nombre_Mecanico_Ejecutor,
    DS.CostoxServicio AS Costo_del_Servicio
FROM DetalleServicio DS
JOIN Servicio S ON DS.id_Servicio = S.id_Servicio
JOIN Mecanico Mec ON DS.id_Mecanico = Mec.id_Usuario
JOIN Usuario U ON Mec.id_Usuario = U.id_Usuario;

-- -----------------------------------------------------------------
-- Vista 4: V_Productividad_Mecanicos
-- -----------------------------------------------------------------
-- Propósito: Vista de reporte avanzada que agrupa por mecánico
-- para contar cuántos servicios hizo y sumar el total facturado.
-- -----------------------------------------------------------------
GO
CREATE VIEW V_Productividad_Mecanicos AS
SELECT
    Mec.id_Usuario AS ID_Mecanico,
    CONCAT(U.Nombre, ' ', U.Apellido) AS Nombre_Completo_Mecanico,
    Mec.Especialidad AS Especialidad_Mecanico,
    COUNT(DS.id_Detalle) AS Total_Servicios_Realizados,
    COALESCE(SUM(DS.CostoxServicio), 0) AS Total_Facturado_Por_Servicios
FROM Mecanico Mec
JOIN Usuario U ON Mec.id_Usuario = U.id_Usuario
LEFT JOIN DetalleServicio DS ON Mec.id_Usuario = DS.id_Mecanico
GROUP BY
    Mec.id_Usuario,
    U.Nombre,
    U.Apellido,
    Mec.Especialidad;

-- -----------------------------------------------------------------
-- Vista 5: VW_DIAS_EN_TALLER
-- -----------------------------------------------------------------
-- Propósito: Vista de reporte cuantos dias lleva una moto en el taller.
-- -----------------------------------------------------------------
CREATE VIEW V_DIAS_EN_TALLER_POR_MOTO AS
SELECT
    R.Id_Reparacion,
    M.Patente AS Patente_Moto,
    M.Marca AS Marca_Moto,
    -- Datos del Cliente para identificr la moto
    UC.Nombre AS Nombre_Cliente,
    UC.Apellido AS Apellido_Cliente,
    R.fecha_Ingreso,
    E.Descripcion AS Estado_Actual,
    -- Columna calculada: Días en Taller (Elemento esencial)
    DATEDIFF(day, R.fecha_Ingreso, ISNULL(R.fecha_Salida, GETDATE())) AS Dias_en_Taller
FROM
    Reparacion AS R
INNER JOIN
    Motos AS M ON R.Id_Moto = M.Id_Moto
-- JOIN para obtener los datos del USUARIO (Cliente) que es dueño de la Moto
INNER JOIN
    Usuario AS UC ON M.id_Usuario = UC.Id_Usuario 
-- JOIN a la tabla de catálogo Estado
INNER JOIN
    Estado AS E ON R.Id_estado = E.Id_Estado;
