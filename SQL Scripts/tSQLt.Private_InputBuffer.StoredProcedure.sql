SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_InputBuffer]
  @InputBuffer NVARCHAR(MAX) OUTPUT
AS
BEGIN
  CREATE TABLE #inputbuffer(EventType sysname, Parameters SMALLINT, EventInfo NVARCHAR(MAX));
  INSERT INTO #inputbuffer
  EXEC('DBCC INPUTBUFFER(@@SPID) WITH NO_INFOMSGS;');
  SELECT @InputBuffer = I.EventInfo FROM #inputbuffer AS I;
END;
GO
