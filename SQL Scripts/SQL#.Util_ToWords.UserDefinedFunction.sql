SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_ToWords](@NumericValue [float])
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[ToWords]
GO
