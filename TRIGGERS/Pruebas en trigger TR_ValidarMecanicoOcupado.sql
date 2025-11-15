-- Ejecutar la corrección del SP antes de la prueba, si no lo has hecho:
-- ALTER PROCEDURE SP_RegistrarOrdenCompleta ... (con el VALUES ajustado)

-- PRUEBA 1: INTENTO DE ASIGNACIÓN AL MECÁNICO 1 (OCUPADO EN ESTADO 3)
USE TallerMecanicoMotos
EXEC SP_RegistrarOrdenCompleta2
    @Patente = 'AH654IJ', -- Moto disponible (Corven Energy 110)
    @MecanicoPrincipalDni = '40400401', -- DNI de Martín Gómez (ID 1 - OCUPADO)
    @DescripcionOrden = 'Revisión por alta temperatura de motor.',
    @ServicioDesc = 'Revisión eléctrica', 
    @CostoServicio = 9500.00,
    @MecanicoDetalleDni = '40400401';

	-- PRUEBA 2: INTENTO DE ASIGNACIÓN AL MECÁNICO 3 (LIBRE EN ESTADO 2)

EXEC SP_RegistrarOrdenCompleta2 
    @Patente = 'AJ321KL', -- Moto disponible (Kawasaki Z400)
    @MecanicoPrincipalDni = '40400403', -- DNI de Lucas Pérez (ID 3 - LIBRE)
    @DescripcionOrden = 'Revisión general y cambio de neumáticos.',
    @ServicioDesc = 'Mantenimiento general', 
    @CostoServicio = 25000.00,
    @MecanicoDetalleDni = '40400403';