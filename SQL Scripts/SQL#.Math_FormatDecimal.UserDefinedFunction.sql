SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Math_FormatDecimal](@TheNumber [numeric](38, 18), @NumberFormat [nvarchar](4000), @Culture [nvarchar](10))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[MATH].[FormatDecimal]
GO
