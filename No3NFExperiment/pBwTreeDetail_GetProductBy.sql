CREATE PROCEDURE [dbo].[pBwTreeDetail_GetProductBy]
	@ProductType VARCHAR(256) = NULL,
	@Department VARCHAR(256) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @p1 INT = CHECKSUM('ProductType')
	DECLARE @v1 INT = CHECKSUM(@ProductType)
	DECLARE @p2 INT = CHECKSUM('Department')
	DECLARE @v2 INT = CHECKSUM(@Department)

	SELECT @v1 v1, @v2 v2

	EXEC [dbo].[pBwTreeDetail_GetProductsByHash] @p1, @v1, @p2, @v2
END

