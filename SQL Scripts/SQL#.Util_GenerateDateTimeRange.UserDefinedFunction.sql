SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Util_GenerateDateTimeRange](@StartDateTime [datetime], @EndDateTime [datetime], @Step [int], @StepType [nvarchar](4000))
RETURNS  TABLE (
	[DatetimeNum] [int] NULL,
	[DatetimeVal] [datetime] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[UTILITY].[GenerateDateTimeRange]
GO
