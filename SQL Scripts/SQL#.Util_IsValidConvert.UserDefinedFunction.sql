SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_IsValidConvert](@ValueToConvert [nvarchar](max), @ConvertToDataTypes [nvarchar](4000), @DecimalPrecision [smallint], @DecimalScale [smallint])
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[IsValidConvert]
GO
