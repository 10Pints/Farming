SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:      Terry Watts
-- Create date: 29-FEB-2024
-- Description: Tests the sp_import_XL_existing routine
--
-- Tested rtn description: imports an Excel sheet into an existing table
--
-- Preconditions:
--
-- Postconditions
--
-- Test strategy:
-- 1 SETUP:
-- 2 run tested rtn
-- 3 check POSTCONDITIONS
-- =======================================================
CREATE PROCEDURE [test].[test_012_sp_import_XL_existing]
AS
BEGIN
   DECLARE
      @fn             NVARCHAR(35)   = N'TST_IMPRT_XL_EXSTNG'
     ,@old_log_level INT = dbo.fnGetLogLevel()

   BEGIN TRY
      -------------------------------------------------------------------------------
      -- 1. Setup
      -------------------------------------------------------------------------------
      EXEC sp_log 2, @fn,'05: setup';
      TRUNCATE TABLE AppLog;

      -------------------------------------------------------------------------------
   -- 2 run tested rtn
      -------------------------------------------------------------------------------
      EXEC test.hlpr_012_sp_import_XL_existing
             @spreadsheet  = 'D:\Dev\Repos\Farming\Data\TableDef.xlsx'
            ,@range        = 'TableType$A:B'
            ,@table        = 'TableType'
            ,@clr_first    = 1
            ,@fields       = 'id,name'
            ,@exp_row_cnt  = 8
            ,@chk_row_spec = 'id=4'
            ,@chk_fld_nm   = 'name'
            ,@exp_fld_val  = 'primary static data'

      EXEC test.hlpr_012_sp_import_XL_existing
             @spreadsheet  = 'D:\Dev\Repos\Farming\Data\TableDef.xlsx'
            ,@range        = 'TableType$A:B'
            ,@table        = 'TableType'
            ,@clr_first    = 1
            ,@fields       = NULL

      -------------------------------------------------------------------------------
   -- 3 check POSTCONDITIONS
      -------------------------------------------------------------------------------
   END TRY
   BEGIN CATCH
      EXEC sp_set_log_level @old_log_level;
      THROW;
   END CATCH

   EXEC sp_set_log_level @old_log_level;
   EXEC sp_log 2, @fn, '99: leaving, PASSED';
END
/*
--EXEC sp_set_log_level 2;
EXEC tSQLt.RunAll 3;
EXEC tSQLt.Run 'test.test_012_sp_import_XL_existing';
*/
GO
