USE TP3_VETERINARIA
CREATE TABLE dbo.GHA_Lugar
(
	CodigoLugar BIGINT IDENTITY(1,1) NOT NULL,
	DescripcionLugar VARCHAR(100) NOT NULL
)
ALTER TABLE dbo.GHA_Lugar ADD CONSTRAINT PK_GHA_Lugar PRIMARY KEY (CodigoLugar)
CREATE TABLE dbo.GHA_Lugar_Estado
(
	CodigoLugarEstado BIGINT IDENTITY(1,1) NOT NULL,
	CodigoLugar BIGINT NOT NULL,
	Estado_lugar VARCHAR(20) NOT NULL,
	Periodo INT NOT NULL,
	FechaDia DATE NOT NULL
)

ALTER TABLE dbo.GHA_Lugar_Estado ADD CONSTRAINT PK_GHA_Lugar_Estado PRIMARY KEY(CodigoLugarEstado)
ALTER TABLE dbo.GHA_Lugar_Estado ADD CONSTRAINT FK_GHA_Lugar_Estado_Lugar FOREIGN KEY (CodigoLugar) REFERENCES dbo.GHA_Lugar(CodigoLugar)

CREATE TABLE dbo.GCP_Cliente
(
	CodigoCliente INT IDENTITY(1,1) NOT NULL,
	NombreCliente VARCHAR(150) NOT NULL,
	DireccionCliente VARCHAR(150) NOT NULL
)

ALTER TABLE dbo.GCP_Cliente ADD CONSTRAINT PK_GCP_Cliente PRIMARY KEY(CodigoCliente)

CREATE TABLE dbo.GCP_Especie
(
	CodigoEspecie INT IDENTITY(1,1) NOT NULL,
	DescripcionEspecie VARCHAR(100) NOT NULL
)

ALTER TABLE dbo.GCP_Especie ADD CONSTRAINT PK_GCP_Especie PRIMARY KEY(CodigoEspecie)

CREATE TABLE dbo.GCP_Raza
(
	CodigoRaza INT IDENTITY(1,1) NOT NULL,
	CodigoEspecie INT NOT NULL,
	NombreRaza VARCHAR(100) NOT NULL
)

ALTER TABLE dbo.GCP_Raza ADD CONSTRAINT PK_GCP_Raza PRIMARY KEY(CodigoRaza)
ALTER TABLE dbo.GCP_Raza ADD CONSTRAINT FK_GCP_Raza_GCP_Especie FOREIGN KEY(CodigoEspecie) REFERENCES dbo.GCP_Especie(CodigoEspecie)

CREATE TABLE dbo.GCP_Mascota
(
	CodigoMascota INT IDENTITY(1,1) NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoRaza INT NOT NULL,
	NombreMascota VARCHAR(150) NOT NULL
)

ALTER TABLE dbo.GCP_Mascota ADD CONSTRAINT PK_GCP_Mascota PRIMARY KEY(CodigoMascota)
ALTER TABLE dbo.GCP_Mascota ADD CONSTRAINT FK_GCP_Mascota_GCP_Cliente FOREIGN KEY(CodigoCliente) REFERENCES dbo.GCP_Cliente (CodigoCliente)
ALTER TABLE dbo.GCP_Mascota ADD CONSTRAINT FK_GCP_Mascota_GCP_Raza FOREIGN KEY(CodigoRaza) REFERENCES dbo.GCP_Raza (CodigoRaza)

CREATE TABLE dbo.GHA_Reserva
(
	CodigoReserva BIGINT IDENTITY(1,1) NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoMascota INT NOT NULL,
	FechaRegistro DATE NOT NULL,
	EstadoReserva SMALLINT NOT NULL
)

ALTER TABLE dbo.GHA_Reserva ADD CONSTRAINT PK_GHA_Reserva PRIMARY KEY(CodigoReserva)
ALTER TABLE dbo.GHA_Reserva ADD CONSTRAINT FK_GHA_Reserva_GCP_Cliente FOREIGN KEY(CodigoCliente) REFERENCES dbo.GCP_Cliente(CodigoCliente)
ALTER TABLE dbo.GHA_Reserva ADD CONSTRAINT FK_GHA_Reserva_GCP_Mascota FOREIGN KEY(CodigoMascota) REFERENCES dbo.GCP_Mascota(CodigoMascota)
ALTER TABLE dbo.GHA_Reserva ADD CONSTRAINT DF_GHA_Reserva_FechaRegistro DEFAULT(GETDATE()) FOR FechaRegistro

CREATE TABLE dbo.GHA_Lugar_Reserva
(
	CodigoLugarReserva BIGINT IDENTITY(1,1) NOT NULL,
	CodigoReserva BIGINT NOT NULL,
	CodigoLugar BIGINT NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin DATE NOT NULL
)

ALTER TABLE dbo.GHA_Lugar_Reserva ADD CONSTRAINT PK_GHA_Lugar_Reserva PRIMARY KEY(CodigoLugarReserva)
ALTER TABLE dbo.GHA_Lugar_Reserva ADD CONSTRAINT FK_GHA_Lugar_Reserva_GHA_Reserva FOREIGN KEY(CodigoReserva) REFERENCES dbo.GHA_Reserva(CodigoReserva)
ALTER TABLE dbo.GHA_Lugar_Reserva ADD CONSTRAINT FK_GHA_Lugar_Reserva_GHA_Lugar FOREIGN KEY(CodigoLugar) REFERENCES dbo.GHA_Lugar(CodigoLugar)

CREATE TABLE dbo.GHA_Hospedaje
(
	CodigoHospedaje BIGINT IDENTITY(1,1) NOT NULL,
	CodigoReserva BIGINT NULL,
	CodigoCliente INT NOT NULL,
	CodigoMascota INT NOT NULL,
	FechaRegistro DATE NOT NULL,
	EstadoHospedaje SMALLINT NOT NULL
)
ALTER TABLE dbo.GHA_Hospedaje ADD CONSTRAINT PK_GHA_Hospedaje PRIMARY KEY(CodigoHospedaje)
ALTER TABLE dbo.GHA_Hospedaje ADD CONSTRAINT FK_GHA_Hospedaje_GHA_Reserva FOREIGN KEY(CodigoReserva) REFERENCES dbo.GHA_Reserva(CodigoReserva)
ALTER TABLE dbo.GHA_Hospedaje ADD CONSTRAINT FK_GHA_Hospedaje_GCP_Cliente FOREIGN KEY(CodigoCliente) REFERENCES dbo.GCP_Cliente(CodigoCliente)
ALTER TABLE dbo.GHA_Hospedaje ADD CONSTRAINT FK_GHA_Hospedaje_GCP_Mascota FOREIGN KEY(CodigoMascota) REFERENCES dbo.GCP_Mascota(CodigoMascota)
ALTER TABLE dbo.GHA_Hospedaje ADD CONSTRAINT DF_GHA_Hospedaje_FechaRegistro DEFAULT(GETDATE()) FOR FechaRegistro

CREATE TABLE dbo.GHA_Lugar_Hospedaje
(
	CodigoLugarHopedaje BIGINT IDENTITY(1,1) NOT NULL,
	CodigoHospedaje BIGINT NOT NULL,
	CodigoLugar BIGINT NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin DATE NOT NULL
)

ALTER TABLE dbo.GHA_Lugar_Hospedaje ADD CONSTRAINT PK_GHA_Lugar_Hospedaje PRIMARY KEY(CodigoLugarHopedaje)
ALTER TABLE dbo.GHA_Lugar_Hospedaje ADD CONSTRAINT FK_GHA_Lugar_Hospedaje_GHA_Hospedaje FOREIGN KEY(CodigoHospedaje) REFERENCES dbo.GHA_Hospedaje(CodigoHospedaje)
ALTER TABLE dbo.GHA_Lugar_Hospedaje ADD CONSTRAINT FK_GHA_Lugar_Hospedaje_GHA_Lugar FOREIGN KEY(CodigoLugar) REFERENCES dbo.GHA_Lugar(CodigoLugar)
