USE TallerMecanicoMotos;
GO
CREATE PROCEDURE SP_ActualizarEstado
    @idReparacion INT,
    @NuevoEstado VARCHAR(50)
AS
BEGIN
    DECLARE @idNuevoEstado INT;

    SET @idNuevoEstado = (SELECT id_Estado FROM Estado WHERE Descripcion = @NuevoEstado);

    IF @idReparacion IS NULL OR @idNuevoEstado IS NULL
    BEGIN
        RAISERROR('Error: Reparación o Estado no válido.', 16, 1);
        RETURN;
    END

    UPDATE Reparacion
    SET id_Estado = @idNuevoEstado
    WHERE id_Reparacion = @idReparacion;
    
    PRINT 'Reparación ' + CAST(@idReparacion AS VARCHAR) + ' actualizada a ' + @NuevoEstado + '.';
END
GO
-------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_RegistrarOrdenCompleta
    -- Parámetros de la Cabecera (Reparacion)
    @Patente VARCHAR(20),
    @MecanicoPrincipalDni VARCHAR(20), -- DNI del Mecánico responsable de la orden
    @DescripcionOrden VARCHAR(255) = NULL,
    
    -- Parámetros del Detalle (Primer Servicio)
    @ServicioDesc VARCHAR(255),
    @CostoServicio DECIMAL(10, 2),
    @MecanicoDetalleDni VARCHAR(20) -- DNI del Mecánico que ejecuta el primer servicio
AS
BEGIN
    -- Declarar variables para guardar los IDs FK
    DECLARE @idMoto INT;
    DECLARE @idMecanicoPrincipal INT;
    DECLARE @idEstadoIngreso INT;
    DECLARE @idServicio INT;
    DECLARE @idMecanicoDetalle INT;
    DECLARE @idReparacionCreada INT;

    -- 1. Obtener los IDs necesarios (Verificación de existencia)
    SET @idMoto = (SELECT id_Moto FROM Motos WHERE Patente = @Patente);
    SET @idMecanicoPrincipal = (SELECT id_Usuario FROM Usuario WHERE Dni = @MecanicoPrincipalDni);
    SET @idServicio = (SELECT id_Servicio FROM Servicio WHERE Descripcion = @ServicioDesc);
    SET @idMecanicoDetalle = (SELECT id_Usuario FROM Usuario WHERE Dni = @MecanicoDetalleDni);
    SET @idEstadoIngreso = (SELECT id_Estado FROM Estado WHERE Descripcion = 'Ingreso y Diagnóstico');

    -- 2. Validación de FKs (Si falla, el SP se detiene)
    IF @idMoto IS NULL OR @idMecanicoPrincipal IS NULL OR @idServicio IS NULL OR @idMecanicoDetalle IS NULL
    BEGIN
        RAISERROR('Error: Patente, Mecánico o Servicio no encontrado. Operación cancelada.', 16, 1);
        RETURN;
    END

    -- 3. INICIO DE LA TRANSACCIÓN 
    BEGIN TRANSACTION;

    BEGIN TRY
        -- A. Insertar la Cabecera de la Reparación 
        INSERT INTO Reparacion (id_Moto, id_Mecanico, id_Estado, Descripcion, fecha_Ingreso) -- Se agrega fecha_Ingreso
        VALUES (@idMoto, @idMecanicoPrincipal, @idEstadoIngreso, @DescripcionOrden, GETDATE()); -- Se usa GETDATE()
        
        -- B. Capturar el ID de Reparacion recién creado
        SET @idReparacionCreada = SCOPE_IDENTITY();

        -- C. Insertar el Detalle del Primer Servicio (M:N) 
        INSERT INTO DetalleServicio (id_Reparacion, id_Servicio, id_Mecanico, CostoXServicio)
        VALUES (@idReparacionCreada, @idServicio, @idMecanicoDetalle, @CostoServicio);

        -- Si ambos inserts fueron exitosos
        COMMIT TRANSACTION;
        PRINT 'Orden de reparación y detalle registrados con éxito. ID de Reparación: ' + CAST(@idReparacionCreada AS VARCHAR);
    END TRY
    BEGIN CATCH
        -- Si algo falla, revertimos
        ROLLBACK TRANSACTION;
        THROW; -- Mantiene el mensaje de error original
    END CATCH
END
GO

CREATE PROCEDURE SP_ActualizarCostoXServicio
    @idDetalle INT,
    @NuevoCosto DECIMAL(10,2)
AS
BEGIN
    UPDATE DetalleServicio
    SET CostoXServicio = @NuevoCosto
    WHERE id_Detalle = @idDetalle;

    PRINT 'Costo del Detalle ' + @idDetalle + ' actualizado a ' + @NuevoCosto + '.';
END
GO

EXEC SP_RegistrarOrdenCompleta 
    @Patente = 'AC456CD',
    @MecanicoPrincipalDni = '40400401', -- Martín Gómez
    @DescripcionOrden = 'Revisión por ruido en embrague.',
    @ServicioDesc = 'Mantenimiento general',
    @CostoServicio = 12000.00,
    @MecanicoDetalleDni = '40400401';

