SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_LastDayOfMonth](@TheDate [datetime], @NewHour [int], @NewMinute [int], @NewSecond [int], @NewMillisecond [int])
RETURNS [datetime] WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[DATE].[LastDayOfMonth]
GO
