use TallerMecanicoMotos
GO
CREATE OR ALTER FUNCTION FN_ContarServiciosEjecutadosPorMecanico
(
    -- DNI del Mecánico
    @DniMecanico VARCHAR(20)
)
RETURNS INT -- La función devolverá el conteo
AS
BEGIN
    DECLARE @idUsuarioMecanico INT;
    DECLARE @TotalServicios INT;

    -- A. Obtener el id_Usuario del Mecánico eliminando espacioss
    SET @idUsuarioMecanico = (
        SELECT id_Usuario 
        FROM Usuario 
        WHERE LTRIM(RTRIM(Dni)) = LTRIM(RTRIM(@DniMecanico))
    );

    -- Validar: Si el DNI no existe, retornamos 0
    IF @idUsuarioMecanico IS NULL
    BEGIN
        RETURN 0;
    END

    --  Contar los registros en DetalleServicio
    SELECT @TotalServicios = COUNT(id_Detalle)
    FROM DetalleServicio
    WHERE id_Mecanico = @idUsuarioMecanico;

    -- Retornar el resultado
    RETURN @TotalServicios;
END
GO

SELECT 
    '40400403' AS Dni_Mecanico, 
    dbo.FN_ContarServiciosEjecutadosPorMecanico('40400403') AS Total_Servicios_Ejecutados;
GO
-- Prueba con un DNI que no existe (Debe devolver 0)
SELECT 
    '99999999' AS Dni_Mecanico, 
    dbo.FN_ContarServiciosEjecutadosPorMecanico('99999999') AS Total_Servicios_Ejecutados;
