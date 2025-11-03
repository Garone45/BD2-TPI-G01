
-- -----------------------------------------------------
-- 1.  CREACIÓN DE BASE DE DATOS
-- -----------------------------------------------------
CREATE DATABASE TallerMecanicoMotos;
GO
	
USE TallerMecanicoMotos;
GO

-- -----------------------------------------------------
-- 2. TABLAS DE CATÁLOGO / REFERENCIA
-- -----------------------------------------------------
-- TABLA: TipoUsuario (Catálogo de Roles: Cliente, Mecánico, Admin)
CREATE TABLE TipoUsuario (
    id_TipoUsuario INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(255) NOT NULL UNIQUE
);
-- TABLA: Servicio (Catálogo de Trabajos: Mantenimiento, Reparación Motor, etc.)
CREATE TABLE Servicio (
    id_Servicio INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(255) NOT NULL UNIQUE
);
-- TABLA: Estado (Catálogo de Etapas de Reparación: Pendiente, En Curso, Finalizada)
CREATE TABLE Estado (
    id_Estado INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(255) NOT NULL UNIQUE
);
GO

-- -----------------------------------------------------
-- 3. TABLA PRINCIPAL DE USUARIOS
-- -----------------------------------------------------
-- Se usa NO ACTION para evitar borrar un rol si todavía está en uso por algún usuario.
CREATE TABLE Usuario (
    id_Usuario INT PRIMARY KEY IDENTITY(1,1),
    id_TipoUsuario INT NOT NULL,  
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Dni VARCHAR(20) UNIQUE,
    Telefono VARCHAR(50),
    Email VARCHAR(255),
    
    CONSTRAINT fk_Usuario_TipoUsuario
        FOREIGN KEY (id_TipoUsuario)
        REFERENCES TipoUsuario (id_TipoUsuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION 
);
GO

-- -----------------------------------------------------
-- 4. TABLAS DE ESPECIALIZACIÓN (HERENCIA 1:1)
-- -----------------------------------------------------
	--  id_Usuario es PK y FK a la vez.
    -- Esto FUERZA la relación 1:1 con la tabla Usuario (cada Usuario puede ser Cliente SÓLO una vez).
CREATE TABLE Cliente (
    id_Usuario INT PRIMARY KEY, 
    Direccion VARCHAR(255),
    Fecha_Alta DATE NOT NULL,

    CONSTRAINT fk_Cliente_Usuario
        FOREIGN KEY (id_Usuario)
        REFERENCES Usuario (id_Usuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
	-- id_Usuario es PK y FK a la vez.
    -- Mismo caso que la tabla cliente. 
CREATE TABLE Mecanico (
    id_Usuario INT PRIMARY KEY,
    Especialidad VARCHAR(255),
    Costo_Hora FLOAT,

    CONSTRAINT fk_Mecanico_Usuario
        FOREIGN KEY (id_Usuario)
        REFERENCES Usuario (id_Usuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- -----------------------------------------------------
-- 5. TABLA DE ACTIVOS (MOTOS)
-- -----------------------------------------------------
-- FK que define la propiedad: Apunta SÓLO a la tabla Cliente, no a Usuario.
CREATE TABLE Motos (
    id_Moto INT PRIMARY KEY IDENTITY(1,1),
    id_Cliente_Propietario INT NOT NULL, 
    Marca VARCHAR(255) NOT NULL,
    Modelo VARCHAR(255) NOT NULL,
    Patente VARCHAR(20) NOT NULL UNIQUE,
	-- NO ACTION: No se puede borrar un Cliente si tiene motos registradas.
    CONSTRAINT fk_Motos_Cliente
        FOREIGN KEY (id_Cliente_Propietario)
        REFERENCES Cliente (id_Usuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- -----------------------------------------------------
-- 6. TABLA CENTRAL DE HECHOS: REPARACIÓN
-- -----------------------------------------------------

CREATE TABLE Reparacion (
    id_Reparacion INT PRIMARY KEY IDENTITY(1,1),
    -- Claves Foráneas (TODAS NOT NULL: Una reparación DEBE estar vinculada a estos elementos)
    id_Moto INT NOT NULL,              
    id_Mecanico INT NOT NULL,          
    id_Servicio INT NOT NULL,          
    id_Estado INT NOT NULL,            
    
    fecha_Ingreso DATE NOT NULL,
    fecha_Salida DATE,                 
    Descripcion VARCHAR(255),          
    costo_Total FLOAT, 
	
	-- NO ACTION en todas las FKs de la tabla central para evitar el error de ciclo.
    CONSTRAINT fk_Reparacion_Motos
        FOREIGN KEY (id_Moto)
        REFERENCES Motos (id_Moto)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    CONSTRAINT fk_Reparacion_Mecanico
        FOREIGN KEY (id_Mecanico)
        REFERENCES Mecanico (id_Usuario)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
        
    CONSTRAINT fk_Reparacion_Servicio
        FOREIGN KEY (id_Servicio)
        REFERENCES Servicio (id_Servicio)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    CONSTRAINT fk_Reparacion_Estado
        FOREIGN KEY (id_Estado)
        REFERENCES Estado (id_Estado)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO