SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_NthOccurrenceOfWeekday](@Occurrence [smallint], @Weekday [nvarchar](10), @StartDate [datetime])
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[DATE].[NthOccurrenceOfWeekday]
GO
