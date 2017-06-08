USE BDPetCenter

CREATE PROCEDURE dbo.usp_GrabarReserva
@CodigoCliente INT,
@CodigoMascota INT,
@CodigoLugar BIGINT,
@FechaInicio DATE,
@FechaFin DATE
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoReserva BIGINT

	INSERT INTO dbo.GHA_Reserva(CodigoCliente,CodigoMascota,EstadoReserva)
	VALUES (@CodigoCliente,@CodigoMascota,1)

	SET @CodigoReserva = @@IDENTITY

	INSERT INTO dbo.GHA_Lugar_Reserva(CodigoReserva,CodigoLugar,FechaInicio,FechaFin)
	VALUES (@CodigoReserva,@CodigoLugar,@FechaInicio,@FechaFin)

	UPDATE dbo.GHA_Lugar_Estado
	SET Estado_lugar = 'RESERVADO'
	WHERE CodigoLugar = @CodigoLugar
	AND FechaDia BETWEEN @FechaInicio AND @FechaFin

	SET NOCOUNT OFF
END