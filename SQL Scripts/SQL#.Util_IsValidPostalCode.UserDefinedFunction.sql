SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_IsValidPostalCode](@CountryCode [nvarchar](4000), @PostalCode [nvarchar](4000))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[IsValidPostalCode]
GO
