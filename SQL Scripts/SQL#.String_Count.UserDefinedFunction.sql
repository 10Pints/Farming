SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_Count](@StringValue [nvarchar](max), @Search [nvarchar](max), @StartAt [int], @ComparisonType [int], @CountOverlap [bit])
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[Count]
GO
