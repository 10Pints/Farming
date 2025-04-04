SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[LookUp_GetCountryInfo](@SearchCode [nvarchar](4000))
RETURNS  TABLE (
	[NumericCode] [nchar](3) NULL,
	[TwoLetterCode] [nchar](2) NULL,
	[ThreeLetterCode] [nchar](3) NULL,
	[Name] [nvarchar](50) NULL,
	[FlagImage] [varbinary](max) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.LookUps].[LookUp].[GetCountryInfo]
GO
