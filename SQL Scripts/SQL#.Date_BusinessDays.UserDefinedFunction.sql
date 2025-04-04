SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_BusinessDays](@StartDate [datetime], @EndDate [datetime], @ExcludeDaysMask [bigint])
RETURNS [int] WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[DATE].[BusinessDays]
GO
