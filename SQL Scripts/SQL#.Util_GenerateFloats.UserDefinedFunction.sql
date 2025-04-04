SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_GenerateFloats](@StartNum [float], @TotalNums [int], @Step [float])
RETURNS  TABLE (
	[FloatNum] [int] NULL,
	[FloatVal] [float] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[GenerateFloats]
GO
