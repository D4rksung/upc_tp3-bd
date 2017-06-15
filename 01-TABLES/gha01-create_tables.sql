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


CREATE TABLE TP3_VETERINARIA.dbo.GHA_Categoria_Alimento (
	CodigoCategoria bigint,
	Nombre varchar(100),
	CONSTRAINT PK_GHA_Categoria_Alimento PRIMARY KEY (CodigoCategoria)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Sub_Categoria_Alimento (
	CodigoSubCategoria bigint NOT NULL IDENTITY(1,1),
	CodigoCategoria bigint NOT NULL,
	Nombre varchar(100) NOT NULL,
	CONSTRAINT PK_GHA_Sub_Categoria_Alimento PRIMARY KEY (CodigoSubCategoria),
	CONSTRAINT FK_GHA_Sub_Categoria_Alimento_GHA_Categoria_Alimento FOREIGN KEY (CodigoCategoria) REFERENCES TP3_VETERINARIA.dbo.GHA_Categoria_Alimento(CodigoCategoria)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Unidad_Medida (
	CodigoUnidadMedida bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	CONSTRAINT PK_GHA_Unidad_Medida PRIMARY KEY (CodigoUnidadMedida)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Tipo_Componente_Alimenticio (
	CodigoTipoComponenteAlimenticio bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	CONSTRAINT PK_GHA_Tipo_Componente_Alimenticio PRIMARY KEY (CodigoTipoComponenteAlimenticio)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Componente_Alimenticio (
	CodigoComponenteAlimenticio bigint NOT NULL IDENTITY(1,1),
	CodigoTipoComponenteAlimenticio bigint NOT NULL,
	Nombre varchar(100) NOT NULL,
	CodigoUnidadMedida bigint NOT NULL,
	CONSTRAINT PK_GHA_Componente_Alimenticio PRIMARY KEY (CodigoComponenteAlimenticio),
	CONSTRAINT FK_GHA_Componente_Alimenticio_GHA_Tipo_Componente_Alimenticio FOREIGN KEY (CodigoTipoComponenteAlimenticio) REFERENCES TP3_VETERINARIA.dbo.GHA_Tipo_Componente_Alimenticio(CodigoTipoComponenteAlimenticio),
	CONSTRAINT FK_GHA_Componente_Alimenticio_GHA_Unidad_Medida FOREIGN KEY (CodigoUnidadMedida) REFERENCES TP3_VETERINARIA.dbo.GHA_Unidad_Medida(CodigoUnidadMedida)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Marca (
	CodigoMarca bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	CONSTRAINT PK_GHA_Marca PRIMARY KEY (CodigoMarca)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Alimento (
	CodigoAlimento bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	CodigoMarca bigint,
	CodigoUnidadMedida bigint NOT NULL,
	Cantidad int NOT NULL,
	CodigoSubCategoria bigint NOT NULL,
	CONSTRAINT PK_GHA_Alimento PRIMARY KEY (CodigoAlimento),
	CONSTRAINT FK_GHA_Alimento_GHA_Marca FOREIGN KEY (CodigoMarca) REFERENCES TP3_VETERINARIA.dbo.GHA_Marca(CodigoMarca),
	CONSTRAINT FK_GHA_Alimento_GHA_Sub_Categoria_Alimento FOREIGN KEY (CodigoSubCategoria) REFERENCES TP3_VETERINARIA.dbo.GHA_Sub_Categoria_Alimento(CodigoSubCategoria),
	CONSTRAINT FK_GHA_Alimento_GHA_Unidad_Medida FOREIGN KEY (CodigoUnidadMedida) REFERENCES TP3_VETERINARIA.dbo.GHA_Unidad_Medida(CodigoUnidadMedida)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Detalle_Alimento_Componente (
	CodigoAlimento bigint NOT NULL IDENTITY(1,1),
	CodigoComponenteAlimenticio bigint NOT NULL,
	Cantidad int NOT NULL,
	CONSTRAINT PK_GHA_Detalle_Alimento_Componente PRIMARY KEY (CodigoAlimento,CodigoComponenteAlimenticio),
	CONSTRAINT FK_GHA_Detalle_Alimento_Componente_GHA_Alimento FOREIGN KEY (CodigoAlimento) REFERENCES TP3_VETERINARIA.dbo.GHA_Alimento(CodigoAlimento),
	CONSTRAINT FK_GHA_Detalle_Alimento_Componente_GHA_Componente_Alimenticio FOREIGN KEY (CodigoComponenteAlimenticio) REFERENCES TP3_VETERINARIA.dbo.GHA_Componente_Alimenticio(CodigoComponenteAlimenticio)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Nivel_BMI (
	CodigoNivelBMI bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	Minimo float NOT NULL,
	Maximo float NOT NULL,
	CONSTRAINT PK_GHA_Nivel_BMI PRIMARY KEY (CodigoNivelBMI)
)


CREATE TABLE TP3_VETERINARIA.dbo.GCP_Condicion_Medica (
	CodigoCondicionMedica bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	Descripcion varchar(100) NOT NULL,
	CONSTRAINT PK_GCP_Condicion_Medica PRIMARY KEY (CodigoCondicionMedica)
)

CREATE TABLE TP3_VETERINARIA.dbo.GCP_Especie_Condicion_Medica (
	CodigoEspecie int NOT NULL IDENTITY(1,1),
	CodigoCondicionMedica bigint NOT NULL,
	CONSTRAINT PK_GCP_Especie_Condicion_Medica PRIMARY KEY (CodigoEspecie,CodigoCondicionMedica),
	CONSTRAINT FK_GCP_Especie_Condicion_Medica_GCP_Especie FOREIGN KEY (CodigoEspecie) REFERENCES TP3_VETERINARIA.dbo.GCP_Especie(CodigoEspecie),
	CONSTRAINT FK_GCP_Especie_Condicion_Medica_GCP_Condicion_Medica FOREIGN KEY (CodigoCondicionMedica) REFERENCES TP3_VETERINARIA.dbo.GCP_Condicion_Medica(CodigoCondicionMedica)
)

CREATE TABLE TP3_VETERINARIA.dbo.GCP_Mascota_Condicion_Medica (
	CodigoMascota int NOT NULL,
	CodigoCondicionMedica bigint NOT NULL,
	FechaInicio date NOT NULL,
	FechaFin date,
	CONSTRAINT PK_GCP_Mascota_Condicion_Medica PRIMARY KEY (CodigoCondicionMedica,CodigoMascota),
	CONSTRAINT FK_GCP_Mascota_Condicion_Medica_GCP_Mascota FOREIGN KEY (CodigoMascota) REFERENCES TP3_VETERINARIA.dbo.GCP_Mascota(CodigoMascota),
	CONSTRAINT FK_GCP_Mascota_Condicion_Medica_GCP_Condicion_Medica FOREIGN KEY (CodigoCondicionMedica) REFERENCES TP3_VETERINARIA.dbo.GCP_Condicion_Medica(CodigoCondicionMedica)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Plan_Alimenticio (
	CodigoPlanAlimenticio bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	Descripcion varchar(250),
	CodigoEspecie bigint NOT NULL,
	CodigoCondicionMedica bigint NOT NULL,
	CONSTRAINT PK_GHA_Plan_Alimenticio PRIMARY KEY (CodigoPlanAlimenticio),
	CONSTRAINT FK_GHA_Plan_Alimenticio_GCP_Especie FOREIGN KEY (CodigoEspecie) REFERENCES TP3_VETERINARIA.dbo.GCP_Especie(CodigoEspecie),
	CONSTRAINT FK_GHA_Plan_Alimenticio_GCP_Condicion_Medica FOREIGN KEY (CodigoCondicionMedica) REFERENCES TP3_VETERINARIA.dbo.GCP_Condicion_Medica(CodigoCondicionMedica)
) 

CREATE TABLE TP3_VETERINARIA.dbo.GCP_Etapa_Vida (
	CodigoEtapaVida bigint NOT NULL IDENTITY(1,1),
	Nombre varchar(100) NOT NULL,
	CONSTRAINT PK_GCP_Etapa_Vida PRIMARY KEY (CodigoEtapaVida)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Criterio_Plan_Alimenticio (
	CodigoCriterioPlanAlimenticio bigint NOT NULL IDENTITY(1,1),
	CodigoPlanAlimenticio bigint NOT NULL,
	CodigoRaza int NOT NULL,
	CodigoNivelBMI bigint NOT NULL,
	CodigoEtapaVida bigint NOT NULL,
	CONSTRAINT PK_GHA_Criterio_Plan_Alimenticio PRIMARY KEY (CodigoCriterioPlanAlimenticio),
	CONSTRAINT FK_GHA_Criterio_Plan_Alimenticio_GHA_Plan_Alimenticio FOREIGN KEY (CodigoPlanAlimenticio) REFERENCES TP3_VETERINARIA.dbo.GHA_Plan_Alimenticio(CodigoPlanAlimenticio),
	CONSTRAINT FK_GHA_Criterio_Plan_Alimenticio_GCP_Raza FOREIGN KEY (CodigoRaza) REFERENCES TP3_VETERINARIA.dbo.GCP_Raza(CodigoRaza),
	CONSTRAINT FK_GHA_Criterio_Plan_Alimenticio_GHA_Nivel_BMI FOREIGN KEY (CodigoNivelBMI) REFERENCES TP3_VETERINARIA.dbo.GHA_Nivel_BMI(CodigoNivelBMI),
	CONSTRAINT FK_GHA_Criterio_Plan_Alimenticio_GCP_Etapa_Vida FOREIGN KEY (CodigoEtapaVida) REFERENCES TP3_VETERINARIA.dbo.GCP_Etapa_Vida(CodigoEtapaVida)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Plan_Programacion_Dia (
	CodigoPlanProgramacionDia bigint NOT NULL IDENTITY(1,1),
	CodigoPlanAlimenticio bigint NOT NULL,
	NumeroDia int NOT NULL,
	CONSTRAINT PK_GHA_Plan_Programacion_Dia PRIMARY KEY (CodigoPlanProgramacionDia),
	CONSTRAINT FK_GHA_Plan_Programacion_Dia_GHA_Plan_Alimenticio FOREIGN KEY (CodigoPlanAlimenticio) REFERENCES TP3_VETERINARIA.dbo.GHA_Plan_Alimenticio(CodigoPlanAlimenticio)
)

CREATE TABLE TP3_VETERINARIA.dbo.GHA_Comida (
	CodigoComida bigint NOT NULL IDENTITY(1,1),
	NombreComida varchar(100) NOT NULL,
	HoraInicio time NOT NULL,
	HoraFin time NOT NULL,
	CONSTRAINT PK_GHA_Comida PRIMARY KEY (CodigoComida)
)


CREATE TABLE TP3_VETERINARIA.dbo.GHA_Plato (
	CodigoProgramacionDia bigint NOT NULL,
	CodigoComida bigint NOT NULL,
	CodigoAlimento bigint NOT NULL,
	CONSTRAINT PK_GHA_Plato PRIMARY KEY (CodigoProgramacionDia,CodigoComida,CodigoAlimento),
	CONSTRAINT GHA_Plato_GHA_Plan_Programacion_Dia_FK FOREIGN KEY (CodigoComida) REFERENCES TP3_VETERINARIA.dbo.GHA_Plan_Programacion_Dia(CodigoPlanProgramacionDia),
	CONSTRAINT GHA_Plato_GHA_Comida_FK FOREIGN KEY (CodigoComida) REFERENCES TP3_VETERINARIA.dbo.GHA_Comida(CodigoComida),
	CONSTRAINT GHA_Plato_GHA_Alimento_FK FOREIGN KEY (CodigoAlimento) REFERENCES TP3_VETERINARIA.dbo.GHA_Alimento(CodAlimento)
) 