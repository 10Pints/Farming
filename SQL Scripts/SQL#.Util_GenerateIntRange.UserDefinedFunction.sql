SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_GenerateIntRange](@StartNum [int], @EndNum [int], @Step [int])
RETURNS  TABLE (
	[IntNum] [int] NULL,
	[IntVal] [int] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[GenerateIntRange]
GO
