CREATE PROCEDURE [dbo].[pBwTreeDetail_GetProductsByHash]
	@pathHash1 INT,
	@valueHash1 INT,
	@pathHash2 INT,
	@valueHash2 INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT *
	FROM dbo.BwTreeDetail
	WHERE [ValueHash] = @valueHash1
	AND [PathHash] = @pathHash1
	UNION
	SELECT *
	FROM dbo.BwTreeDetail
	WHERE [ValueHash] = @valueHash2
	AND [PathHash] = @pathHash2

	--Alternative
	CREATE TABLE #HashMap
	(
		ValueHash INT NOT NULL,
		PathHash INT NOT NULL,
		PRIMARY KEY (ValueHash, PathHash)
	)

	INSERT INTO #HashMap
	SELECT @valueHash1, @pathHash1
	UNION ALL
	SELECT @valueHash2, @pathHash2

	SELECT d.*
	FROM dbo.BwTreeDetail d
	INNER JOIN #HashMap m
		ON m.ValueHash = d.[ValueHash]
		AND m.PathHash = d.[PathHash]
END