SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[RegEx_CaptureGroupCapture4k](@ExpressionToValidate [nvarchar](4000), @RegularExpression [nvarchar](4000), @CaptureGroupNumber [int], @MatchNumber [int], @CaptureNumber [int], @NotFoundReplacement [nvarchar](4000), @StartAt [int], @Length [int], @RegExOptionsList [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[REGEX].[CaptureGroupCapture]
GO
