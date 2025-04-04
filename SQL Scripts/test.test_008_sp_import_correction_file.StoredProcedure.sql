SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================================
-- Author:      Terry Watts
-- Create date: 06-NOV-2023
-- Description: tests the sp_import_corrections_file rtn
-- =============================================================
CREATE PROCEDURE [test].[test_008_sp_import_correction_file]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE
       @fn                 NVARCHAR(35)   = 'tst_imp_corctn_files'
      ,@import_root        NVARCHAR(450)  = 'D:\Dev\Repos\Farming_Dev\Data\'
      ,@correction_files   NVARCHAR(MAX)
      ,@act_rowcnt         INT            = -1
      ,@act_file           NVARCHAR(450)

-------Assemble
   EXEC sp_log 2, @fn,'01: starting, SETUP';
   SET @correction_files = 'abc.txt,defg.txt'
   EXEC tSQLt.SpyProcedure 'dbo.sp_import_corrections_file';

-------Act
   EXEC sp_log 2, @fn; 
   EXEC sp_log 2, @fn,'---------------------------------'; 
   EXEC sp_log 2, @fn,'02: GREEN TESTS' 
   EXEC sp_log 2, @fn,'---------------------------------'; 
   EXEC test.hlpr_008_sp_import_correction_file @import_root, @correction_files, 0

   /*
------- Test
   SELECT * FROM dbo.sp_import_corrections_file_SpyProcedureLog;
   SELECT @act_rowcnt = COUNT(*) FROM dbo.sp_import_corrections_file_SpyProcedureLog;
   EXEC sp_log 2, @fn,'05: TEST row count: ',@act_rowcnt;
   SELECT * FROM dbo.sp_import_corrections_file_SpyProcedureLog
   EXEC tSQLt.AssertEquals 2, @act_rowcnt, 'expected 2 rows'
   SELECT @act_file = import_tsv_file FROM dbo.sp_import_corrections_file_SpyProcedureLog
   WHERE _id_=1;

   EXEC sp_log 2, @fn,'05: TEST row details match - row 1';
   EXEC tSQLt.AssertEquals 'D:\Dev\Repos\Farming_Dev\Data\abc.txt', @act_file;
   SELECT @act_file = import_tsv_file FROM dbo.sp_import_corrections_file_SpyProcedureLog
   WHERE _id_=2;
   EXEC sp_log 2, @fn,'10: TEST row details match - row 3';
   EXEC tSQLt.AssertEquals 'D:\Dev\Repos\Farming_Dev\Data\defg.txt', @act_file;

-------Act
   EXEC sp_log 2, @fn; 
   EXEC sp_log 2, @fn,'---------------------------------'; 
   EXEC sp_log 2, @fn,'15: RED TESTS' 
   EXEC sp_log 2, @fn,'---------------------------------'; 

EXEC sp_log 2, @fn,'20: TEST hlpr_sp_import_corrections_files @import_root, NULL';
   EXEC test.hlpr_sp_import_correction_files @import_root, NULL, 1;
   EXEC sp_log 2, @fn,'30: TEST hlpr_sp_import_corrections_files @import_root, ''''';
   EXEC test.hlpr_sp_import_correction_files @import_root, '', 1;
   * /
   EXEC sp_log 2, @fn,'40: TEST hlpr_sp_import_corrections_files NULL, @correction_files';
   EXEC test.hlpr_sp_import_correction_file NULL, @correction_files, 1;
   / *
   EXEC sp_log 2, @fn,'50: TEST hlpr_sp_import_corrections_files '''', @correction_files';
   EXEC test.hlpr_sp_import_correction_files '', @correction_files, 1;
   EXEC sp_log 2, @fn,'99: leaving, all tests PASSED';
   */

END
/*
EXEC tSQLt.Run 'test.test_sp_import_correction_file'
*/
GO
