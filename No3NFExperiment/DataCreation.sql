

alter FUNCTION [dbo].[fVirtualProducts]
(
	@targetRows int,
	@nProducts int,
	@productTypes VARCHAR(256),
	@departments VARCHAR(256),
	@Guid uniqueidentifier,
	@now datetime2
)
RETURNS TABLE
AS
RETURN
	select distinct
		N ProductId
		,c22.Element ProductType
		,c6.Element Department
		,DATEADD(day, c4.RandColumn, GETUTCDATE() ) EffectiveDateTime
	from dbo.VirtualSequence(@targetRows)
	outer apply
	dbo.RandomNumberColumn(1, @nProducts, @Guid) c1
	outer apply
	dbo.RandomIndexFromCSV( @productTypes, ',', @Guid ) c21
	outer apply
	dbo.CSVElementAt( @productTypes, c21.RandColumn, default ) c22
	outer apply
	dbo.RandomNumberColumn(1,2,@Guid) c4
	outer apply
	dbo.RandomIndexFromCSV( @departments, ',', @Guid ) c5
	outer apply
	dbo.CSVElementAt( @departments, c5.RandColumn, default ) c6
go
declare
	@targetRows int = 100,
	@nStores int = 10,
	@nProducts int = 5,
	@nVariants int = 2,
	@priceStreams NVARCHAR(100) = 'A,B,C',
	@Guid uniqueidentifier = NEWID(),
	@now datetime2 = GETUTCDATE()
	;

	USE [WriteModel]
GO

insert into No3NFExperiment.dbo.BwTreeDetail(Id, [Path], [Value])
SELECT NEWID() Id, [Path], [Value]
FROM (
SELECT * FROM [dbo].[fVirtualProducts] (
  10000
  ,5
  ,'TOP,BOTTOMS,SHOES,COATS,HATS,DRESSES'
  ,'MW,WW'
  ,NEWID()
  ,GETUTCDATE())
UNPIVOT
   ([Value] FOR [Path] IN 
      ([ProductType], [Department])
)AS unpvt
) x
GO


