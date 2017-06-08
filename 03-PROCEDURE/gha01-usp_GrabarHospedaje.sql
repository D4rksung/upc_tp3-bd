USE BDPetCenter

CREATE PROCEDURE dbo.usp_GrabarHospedaje
@CodigoReserva BIGINT = NULL,
@CodigoCliente INT,
@CodigoMascota INT,
@CodigoLugar BIGINT,
@FechaInicio DATE,
@FechaFin DATE
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoHospedaje BIGINT

	INSERT INTO dbo.GHA_Hospedaje(CodigoReserva,CodigoCliente,CodigoMascota,EstadoHospedaje)
	VALUES (@CodigoReserva,@CodigoCliente,@CodigoMascota,1)

	SET @CodigoHospedaje = @@IDENTITY

	INSERT INTO dbo.GHA_Lugar_Hospedaje(CodigoHospedaje,CodigoLugar,FechaInicio,FechaFin)
	VALUES (@CodigoHospedaje,@CodigoLugar,@FechaInicio,@FechaFin)

	UPDATE dbo.GHA_Lugar_Estado
	SET Estado_lugar = 'OCUPADO'
	WHERE CodigoLugar = @CodigoLugar
	AND FechaDia BETWEEN @FechaInicio AND @FechaFin

	IF @CodigoReserva IS NOT NULL
	BEGIN
		UPDATE dbo.GHA_Reserva
		SET EstadoReserva = 2
		WHERE CodigoReserva = @CodigoReserva
	END

	SET NOCOUNT OFF
END