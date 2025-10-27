CREATE DATABASE TallerMecanicoMotos;

-- TABLA: TipoUsuario
CREATE TABLE TipoUsuario (
    id_TipoUsuario INT PRIMARY KEY IDENTITY(1,1), 
    Descripcion VARCHAR(255) NOT NULL UNIQUE
);

-- TABLA: Servicio
CREATE TABLE Servicio (
    id_Servicio  INT PRIMARY KEY IDENTITY(1,1), 
    Descripcion VARCHAR(255) NOT NULL UNIQUE
);

-- TABLA: Estado
CREATE TABLE Estado (
    id_Estado INT PRIMARY KEY IDENTITY(1,1), 
    Descripcion VARCHAR(255) NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- 2. TABLA PRINCIPAL DE USUARIOS (CON FK)
-- -----------------------------------------------------
-- TABLA: Usuario
CREATE TABLE Usuario (
    id_Usuario INT PRIMARY KEY IDENTITY(1,1),
    id_TipoUsuario INT NOT NULL,  -- FK a TipoUsuario
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Dni VARCHAR(20) UNIQUE,
    Telefono VARCHAR(50),
    Email VARCHAR(255),
    
    -- Restricción de Clave Foránea
    CONSTRAINT fk_Usuario_TipoUsuario
        FOREIGN KEY (id_TipoUsuario)
        REFERENCES TipoUsuario (id_TipoUsuario)
        -- CAMBIO AQUÍ: RESTRICT se reemplaza por NO ACTION
        ON DELETE NO ACTION 
        ON UPDATE CASCADE 
);