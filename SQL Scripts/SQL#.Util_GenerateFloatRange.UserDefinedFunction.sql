SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_GenerateFloatRange](@StartNum [float], @EndNum [float], @Step [float])
RETURNS  TABLE (
	[FloatNum] [int] NULL,
	[FloatVal] [float] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[GenerateFloatRange]
GO
