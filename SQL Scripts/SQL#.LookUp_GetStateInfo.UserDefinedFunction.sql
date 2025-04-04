SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[LookUp_GetStateInfo](@SearchCode [nvarchar](4000), @CountryCode [nvarchar](4000))
RETURNS  TABLE (
	[NumericCode] [nchar](2) NULL,
	[TwoLetterCode] [nchar](2) NULL,
	[Name] [nvarchar](50) NULL,
	[FlagImage] [varbinary](max) NULL,
	[CountryCode] [nchar](2) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.LookUps].[LookUp].[GetStateInfo]
GO
