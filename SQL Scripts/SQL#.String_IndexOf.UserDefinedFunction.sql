SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_IndexOf](@StringValue [nvarchar](max), @SearchValue [nvarchar](4000), @StartIndex [int], @ComparisonType [int])
RETURNS [int] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[IndexOf]
GO
