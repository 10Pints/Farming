SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_CaptureGroup](@ExpressionToValidate [nvarchar](max), @RegularExpression [nvarchar](max), @CaptureGroupNumber [int], @NotFoundReplacement [nvarchar](max), @StartAt [int], @Length [int], @RegExOptionsList [nvarchar](4000))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[CaptureGroup]
GO
