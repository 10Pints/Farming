SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_IsMatch](@ExpressionToValidate [nvarchar](max), @RegularExpression [nvarchar](max), @StartAt [int], @RegExOptionsList [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[IsMatch]
GO
