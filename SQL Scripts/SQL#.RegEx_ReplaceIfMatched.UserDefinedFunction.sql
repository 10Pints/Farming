SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_ReplaceIfMatched](@ExpressionToValidate [nvarchar](max), @RegularExpression [nvarchar](max), @Replacement [nvarchar](4000), @NotFoundReplacement [nvarchar](max), @Count [int], @StartAt [int], @RegExOptionsList [nvarchar](4000))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[ReplaceIfMatched]
GO
