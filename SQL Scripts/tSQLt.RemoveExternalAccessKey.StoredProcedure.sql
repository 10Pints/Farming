SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RemoveExternalAccessKey]
AS
BEGIN
  EXEC tSQLt.Private_Print @Message='tSQLt.RemoveExternalAccessKey is deprecated. Please use tSQLt.RemoveAssemblyKey instead.';
  EXEC tSQLt.RemoveAssemblyKey;
RETURN;
END;
GO
