SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [SQL#].[SQLsharp_SaveManualToDisk]
	@FilePath [nvarchar](2000),
	@CreatePathIfNotExists [bit] = False
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [SQL#_2].[SQLsharp].[SaveManualToDisk]
GO
