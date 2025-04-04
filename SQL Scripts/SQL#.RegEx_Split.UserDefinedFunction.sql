SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_Split](@ExpressionToValidate [nvarchar](max), @RegularExpression [nvarchar](max), @Count [int], @StartAt [int], @RegExOptionsList [nvarchar](4000))
RETURNS  TABLE (
	[MatchNum] [int] NULL,
	[Value] [nvarchar](max) NULL,
	[StartPos] [int] NULL,
	[EndPos] [int] NULL,
	[Length] [int] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[Split]
GO
