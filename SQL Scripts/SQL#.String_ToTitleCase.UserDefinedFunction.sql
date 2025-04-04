SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_ToTitleCase](@StringValue [nvarchar](max), @CultureNameOrLCID [nvarchar](100))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[STRING].[ToTitleCase]
GO
