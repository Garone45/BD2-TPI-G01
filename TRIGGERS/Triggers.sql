USE TallerMecanicoMotos
GO
--------------------------------------------
--trigger actualizacion fecha salida cuando estado=6
--------------------------------------------
CREATE TRIGGER tr_FechaSalida on Reparacion
AFTER UPDATE
AS
BEGIN
    UPDATE r
    SET r.Fecha_Salida = GETDATE()
    FROM Reparacion r
    INNER JOIN inserted i ON r.id_Reparacion = i.id_Reparacion
    WHERE i.id_Estado = 6;
END

--------------------------------------------
-- trigger que verifique si el mecánico asignado en la nueva reparación
-- ya está trabajando en otra reparación que aún no ha finalizado.
--------------------------------------------

Go
CREATE TRIGGER TR_ValidarMecanicoOcupado
ON Reparacion
AFTER INSERT
AS
BEGIN
    -- Estados de NO OCUPACIÓN:
    -- 2: Esperando Repuesto (Espera logística)
    -- 5: Listo para Retirar (Trabajo terminado)
    -- 6: Listo para entregar (Reparación cerrada)
    
    -- 1. Verificar si la reparación insertada (I) tiene un mecánico que ya está
    --    asignado a otra reparación (R) con un estado ACTIVO (NO es 2, 5 o 6).
    IF EXISTS (
        SELECT 1
        FROM INSERTED AS I 
        INNER JOIN Reparacion AS R ON I.id_Mecanico = R.id_Mecanico
        WHERE 
            -- Condición de Ocupación: R.id_Estado NO debe ser 2, 5 o 6.
            R.id_Estado NOT IN (2, 5, 6) 
            AND R.Id_Reparacion <> I.Id_Reparacion -- No se compara la fila insertada consigo misma.
    )
    BEGIN
        -- Si hay conflicto, revertir y lanzar error
        RAISERROR('Error: El mecánico asignado ya se encuentra ocupado en otra reparación activa (en diagnóstico, reparación o control de calidad).', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO