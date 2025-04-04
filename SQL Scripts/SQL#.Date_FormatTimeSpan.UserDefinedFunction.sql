SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_FormatTimeSpan](@StartDate [datetime], @EndDate [datetime], @OutputFormat [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[DATE].[FormatTimeSpan]
GO
