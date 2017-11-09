CREATE TABLE [dbo].[BwTreeDetail]
(
	[Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	[Path] VARCHAR(256) NOT NULL,
	[PathHash] AS CHECKSUM([Path]) PERSISTED,
	[Value] VARCHAR(256) NOT NULL,
	[ValueHash] AS CHECKSUM([Value]) PERSISTED
)
GO

CREATE INDEX IX_BwTreeDetail_ValueHash ON dbo.BwTreeDetail (ValueHash, PathHash)
INCLUDE (Id, [Path], [Value])