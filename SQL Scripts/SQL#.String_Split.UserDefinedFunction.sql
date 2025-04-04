SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_Split](@StringValue [nvarchar](max), @Separator [nvarchar](4000), @SplitOption [int])
RETURNS  TABLE (
	[SplitNum] [int] NULL,
	[SplitVal] [nvarchar](max) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[Split]
GO
