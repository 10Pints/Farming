SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_FirstDayOfMonth](@TheDate [datetime], @NewHour [int], @NewMinute [int], @NewSecond [int], @NewMillisecond [int])
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[DATE].[FirstDayOfMonth]
GO
