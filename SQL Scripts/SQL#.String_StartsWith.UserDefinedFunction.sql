SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_StartsWith](@StringValue [nvarchar](max), @SearchValue [nvarchar](4000), @ComparisonType [int])
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[StartsWith]
GO
