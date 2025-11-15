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