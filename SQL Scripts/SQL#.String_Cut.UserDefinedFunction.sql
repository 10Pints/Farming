SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_Cut](@StringValue [nvarchar](max), @Delimiter [nvarchar](4000), @Fields [nvarchar](4000))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[STRING].[Cut]
GO
