SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_ReplaceIfMatched4k](@ExpressionToValidate [nvarchar](4000), @RegularExpression [nvarchar](4000), @Replacement [nvarchar](4000), @NotFoundReplacement [nvarchar](4000), @Count [int], @StartAt [int], @RegExOptionsList [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[ReplaceIfMatched]
GO
