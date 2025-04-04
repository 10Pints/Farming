SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_Replace](@Expression [nvarchar](max), @Find [nvarchar](max), @Replacement [nvarchar](max))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[STRING].[Replace]
GO
