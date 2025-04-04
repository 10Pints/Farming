SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:      Terry Watts
-- Create date: 05-FEB-2024
-- Description: Tests the sp_chk_tbl_not_populated rtn
-- =======================================================
CREATE PROCEDURE [test].[test_007_sp_chk_tbl_not_populated]
AS
BEGIN
   DECLARE @act INT
   ,@exp INT;

   TRUNCATE TABLE AppLog;
   EXEC dbo.sp_chk_tbl_not_populated 'AppLog'; -- ok no rows
   INSERT INTO AppLog (fn) VALUES('sp_chk_tbl_not_populated');
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_007_sp_chk_tbl_not_populated';
*/
GO
