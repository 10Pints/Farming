SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_IsNumeric](@StringValue [nvarchar](4000), @NumberTypeMask [int])
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[IsNumeric]
GO
