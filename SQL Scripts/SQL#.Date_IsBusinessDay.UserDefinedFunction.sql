SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_IsBusinessDay](@TheDate [datetime], @ExcludeDaysMask [bigint])
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[DATE].[IsBusinessDay]
GO
