USE TP3_VETERINARIA

DECLARE @CONTADOR INT,
		@DESCRIPCION VARCHAR(100)

SET @CONTADOR = 1

WHILE @CONTADOR <= 40
BEGIN
	SET @DESCRIPCION = 'CAN' + CASE WHEN @CONTADOR < 10 THEN '0' ELSE '' END + LTRIM(STR(@CONTADOR))

	INSERT INTO dbo.GHA_Lugar (DescripcionLugar) VALUES (@DESCRIPCION)

	SET @CONTADOR = @CONTADOR + 1
END

INSERT INTO dbo.GCP_Cliente (NombreCliente,DireccionCliente) VALUES('Ramos Conde, Juan','Av. Las Américas 7676')
INSERT INTO dbo.GCP_Cliente (NombreCliente,DireccionCliente) VALUES('Ramos Santos, Irvin','Av. Benavides 4500')
INSERT INTO dbo.GCP_Cliente (NombreCliente,DireccionCliente) VALUES('Peña Rios, Luis','Jr. Cusco 206')
INSERT INTO dbo.GCP_Cliente (NombreCliente,DireccionCliente) VALUES('Marino Alvarez, Victor','Av. Angamos 2208')
INSERT INTO dbo.GCP_Cliente (NombreCliente,DireccionCliente) VALUES('Davila Campos, Francisco','Jr. Puno 101')
INSERT INTO dbo.GCP_Cliente (NombreCliente,DireccionCliente) VALUES('Campos Vasquez, Carlos','Av. Aviacion 2905')

INSERT INTO dbo.GCP_Especie (DescripcionEspecie) VALUES ('Perro')
INSERT INTO dbo.GCP_Especie (DescripcionEspecie) VALUES ('Gato')

INSERT INTO dbo.GCP_Raza (CodigoEspecie,NombreRaza) VALUES (1,'Pequinez')
INSERT INTO dbo.GCP_Raza (CodigoEspecie,NombreRaza) VALUES (2,'Siamez')

INSERT INTO dbo.GCP_Mascota (CodigoCliente,CodigoRaza,NombreMascota) VALUES (1,1,'Bobby')
INSERT INTO dbo.GCP_Mascota (CodigoCliente,CodigoRaza,NombreMascota) VALUES (1,2,'Mayra')
