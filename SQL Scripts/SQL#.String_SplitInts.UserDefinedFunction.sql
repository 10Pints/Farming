SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_SplitInts](@StringValue [nvarchar](max), @Separator [nvarchar](4000), @SplitOption [int], @ReturnNullRowOnNullInput [bit])
RETURNS  TABLE (
	[SplitNum] [int] NULL,
	[SplitVal] [bigint] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[SplitInts]
GO
