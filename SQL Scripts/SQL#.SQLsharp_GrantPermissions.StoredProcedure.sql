SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [SQL#].[SQLsharp_GrantPermissions]
	@GrantTo [nvarchar](4000),
	@PrintSqlInsteadOfExecute [bit] = False
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [SQL#].[SQLsharp].[GrantPermissions]
GO
