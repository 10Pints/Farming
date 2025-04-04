SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_Matches4k](@ExpressionToValidate [nvarchar](4000), @RegularExpression [nvarchar](4000), @StartAt [int], @RegExOptionsList [nvarchar](4000))
RETURNS  TABLE (
	[MatchNum] [int] NULL,
	[Value] [nvarchar](4000) NULL,
	[StartPos] [int] NULL,
	[EndPos] [int] NULL,
	[Length] [int] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[Matches]
GO
