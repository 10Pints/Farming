SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_Split4k](@StringValue [nvarchar](4000), @Separator [nvarchar](4000), @SplitOption [int])
RETURNS  TABLE (
	[SplitNum] [int] NULL,
	[SplitVal] [nvarchar](4000) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[Split]
GO
