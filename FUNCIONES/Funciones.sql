use TallerMecanicoMotos
GO
CREATE OR ALTER FUNCTION FN_ContarServiciosEjecutadosPorMecanico
(
    -- 1. Parámetro de entrada: DNI del Mecánico
    @DniMecanico VARCHAR(20)
)
RETURNS INT -- La función devolverá un valor entero (el conteo)
AS
BEGIN
    DECLARE @idUsuarioMecanico INT;
    DECLARE @TotalServicios INT;

    -- A. Obtener el id_Usuario del Mecánico de forma robusta (eliminando espacios)
    SET @idUsuarioMecanico = (
        SELECT id_Usuario 
        FROM Usuario 
        WHERE LTRIM(RTRIM(Dni)) = LTRIM(RTRIM(@DniMecanico))
    );

    -- B. Validar: Si el DNI no existe, retornamos 0
    IF @idUsuarioMecanico IS NULL
    BEGIN
        RETURN 0;
    END

    -- C. Lógica de Conteo: Contar los registros en DetalleServicio
    SELECT @TotalServicios = COUNT(id_Detalle)
    FROM DetalleServicio
    WHERE id_Mecanico = @idUsuarioMecanico;

    -- D. Retornar el resultado
    RETURN @TotalServicios;
END
GO

SELECT 
    '40400403' AS Dni_Mecanico, 
    dbo.FN_ContarServiciosEjecutadosPorMecanico('40400403') AS Total_Servicios_Ejecutados;
GO
-- Ejemplo 2: Prueba con un DNI que no existe (Debe devolver 0)
SELECT 
    '99999999' AS Dni_Mecanico, 
    dbo.FN_ContarServiciosEjecutadosPorMecanico('99999999') AS Total_Servicios_Ejecutados;
GO