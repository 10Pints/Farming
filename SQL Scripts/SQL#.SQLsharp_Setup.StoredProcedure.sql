SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [SQL#].[SQLsharp_Setup]
	@SQLsharpSchema [sysname] = N'SQL#',
	@SQLsharpAssembly [sysname] = N'',
	@JustPrintSQL [bit] = False
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [SQL#].[SQLsharp].[Setup]
GO
