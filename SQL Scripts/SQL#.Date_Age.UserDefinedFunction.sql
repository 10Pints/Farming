SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_Age](@StartDate [datetime], @EndDate [datetime], @LeapYearHandling [nvarchar](4000), @IncludeDays [bit])
RETURNS [float] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[DATE].[Age]
GO
