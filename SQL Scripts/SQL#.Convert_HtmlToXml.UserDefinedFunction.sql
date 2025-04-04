SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Convert_HtmlToXml](@Document [nvarchar](max), @DocumentUri [nvarchar](4000), @CaseFolding [nvarchar](50))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.SgmlReader].[SGMLReader].[HtmlToXml]
GO
