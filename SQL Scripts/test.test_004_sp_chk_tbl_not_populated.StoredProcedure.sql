SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:      Terry Watts
-- Create date: 05-FEB-2024
-- Description: Tests the sp_main_import_stage_0 rtn
--
-- tested rtn PRECNDITIONS  : none
-- tested rtn POSTCONDITIONS: 
-- Test strategy:
-- 1 start with clean database
-- 2 run tested rtn
-- 3 check POSTCONDITIONS
--    a Use table and UseStaging tables have rows
-- =======================================================
CREATE PROCEDURE [test].[test_004_sp_chk_tbl_not_populated]
AS
BEGIN
   PRINT '000: test_sp_chk_tbl_not_populated: starting, clring applog table';
   TRUNCATE TABLE AppLog;
   PRINT '005:checking AppLog has no rows using sp_chk_tbl_not_populated';
   EXEC dbo.sp_chk_tbl_not_populated 'AppLog'; -- ok no rows

   BEGIN TRY
      PRINT '010: checking AppLog has rows when it does not';
      PRINT '015: expect an exception here';
      EXEC sp_chk_tbl_populated 'AppLog'; -- oops
      THROW 50000, 'oops expected an exception here',1;
   END TRY
   BEGIN CATCH
      PRINT '020: OK caught expected exception';
   END CATCH

   -- now add a row:
   PRINT '025: Oinserting 1 row in AppLog table';
   INSERT INTO AppLog (fn) VALUES('test_sp_chk_tbl_not_populated');
   PRINT '030: checking AppLog has 1 row';
   EXEC sp_chk_tbl_populated 'AppLog'; -- ok 1 rows
   PRINT '035: OK AppLog has 1 row';

   BEGIN TRY
   PRINT '040: checking sp_chk_tbl_not_populated throws an exception when appLog has a row';
      EXEC dbo.sp_chk_tbl_not_populated 'AppLog'; -- oops
      THROW 50000, '045: oops. expected an exception here',1;
   END TRY
   BEGIN CATCH
      PRINT '050: OK caught expected exception';
   END CATCH

   PRINT '055: test passed';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_004_sp_chk_tbl_not_populated';
*/
GO
