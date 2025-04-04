SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_IsMatch4k](@ExpressionToValidate [nvarchar](4000), @RegularExpression [nvarchar](4000), @StartAt [int], @RegExOptionsList [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[IsMatch]
GO
