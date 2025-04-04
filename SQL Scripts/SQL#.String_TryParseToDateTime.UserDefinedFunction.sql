SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[String_TryParseToDateTime](@ToParse [nvarchar](50), @TargetDataType [nvarchar](15), @Culture [nvarchar](10))
RETURNS [datetime2](7) WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[STRING].[TryParseToDateTime]
GO
