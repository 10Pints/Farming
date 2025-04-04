SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [SQL#].[SQLsharp_SetSecurity]
	@PermissionSet [int],
	@AssemblyName [nvarchar](4000) = N'',
	@SetTrustworthyIfNoUser [bit] = False,
	@DoNotPrintSuccessMessage [bit] = False
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [SQL#].[SQLsharp].[SetSecurity]
GO
