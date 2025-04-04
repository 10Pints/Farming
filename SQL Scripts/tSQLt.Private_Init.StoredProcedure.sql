SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_Init]
AS
BEGIN
  EXEC tSQLt.Private_CleanTestResult;

  UPDATE tSQLt.Private_NullCellTable SET I=I WHERE 'Forcing trigger execution.' != '';

  DECLARE @enable BIT; SET @enable = 1;
  DECLARE @version_match BIT;SET @version_match = 0;
  BEGIN TRY
    EXEC sys.sp_executesql N'SELECT @r = CASE WHEN I.Version = I.ClrVersion THEN 1 ELSE 0 END FROM tSQLt.Info() AS I;',N'@r BIT OUTPUT',@version_match OUT;
  END TRY
  BEGIN CATCH
    RAISERROR('Cannot access CLR. Assembly might be in an invalid state. Try running EXEC tSQLt.EnableExternalAccess @enable = 0; or reinstalling tSQLt.',16,10);
    RETURN;
  END CATCH;
  SELECT @version_match = CASE WHEN I.SqlVersion = I.InstalledOnSqlVersion THEN 1 ELSE 0 END FROM tSQLt.Info() AS I WHERE @version_match = 1;
  IF(@version_match = 0)
  BEGIN
    RAISERROR('tSQLt is in an invalid state. Please reinstall tSQLt.',16,10);
    RETURN;
  END;

  IF(NOT EXISTS(SELECT 1 FROM tSQLt.Info() WHERE SqlEdition = 'SQL Azure'))
  BEGIN
    EXEC tSQLt.EnableExternalAccess @enable = @enable, @try = 1;
  END;
END;
GO
