SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_PadRight](@StringValue [nvarchar](max), @StringWidth [int], @PadCharacter [nvarchar](4000))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[STRING].[PadRight]
GO
