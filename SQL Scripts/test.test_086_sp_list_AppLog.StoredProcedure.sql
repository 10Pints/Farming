SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================================================================================
-- Author:      Terry Watts
-- Create date: 07-MAR-2024
-- Description: Tests the fnGetFileNameFromPath rtn
--
-- Tested rtn description:
-- Description: convenient wrapper for fnListApplog
--
-- Parameters:    Mandatory,optional M/O
-- @import_file  [O] the import source file can be a tsv or xlsx file
-- @fnFilter     [O] -- DEFAULT = ALL
-- @msgFilter    [O] -- DEFAULT = ALL
-- @idFilter     [O] -- DEFAULT = ALL
-- @levelFilter  [O] -- DEFAULT = ALL
-- @asc          [O] -- DEFAULT = DESC, 1= ASC, 0=desc
--
-- Preconditions: none
--
-- Postconditions:
-- POST01:
-- 
-- RULES:
-- RULE01:
--========================================================================================
CREATE PROCEDURE [test].[test_086_sp_list_AppLog]
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE
    @fn              NVARCHAR(35) = 'TST_086_LST_APPLOG'
   ,@act_row_cnt     INT
   ,@old_log_level   INT

   BEGIN TRY
      SET @old_log_level = dbo.fnGetLogLevel();
      EXEC sp_set_log_level 1;  -- Log level has to be L1 for this test to work

      EXEC sp_log 2, @fn, '000: starting';

      -------------------------------------------------------------------------------
      -- 1 OFF SETUP:
      -------------------------------------------------------------------------------
      EXEC sp_log 1, @fn, '005: test 01: setup';
      EXEC sp_reset_CallRegister;

      -------------------------------------------------------------------------------
      -- Run tests
      -------------------------------------------------------------------------------
      EXEC sp_log 1, @fn, '010: running tests';

      -------------------------------------------------------------------------------
   -- TEST 001: LIST ALL desc
      -------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '001 LIST ALL DESC DEF'
         ,@fnFilter     = NULL
         ,@msgFilter    = NULL
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@levelFilter  = NULL
         ,@asc          = NULL
         ,@exp_rows     = 1
         ,@exp_first_id = 1
         ,@exp_row_cnt  = 33
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

      -------------------------------------------------------------------------------
      -- TEST 002: 'MN_IMPORT', @fnFilter spec@asc=1   -- LIST the main import rtn, asc spec
      -------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '002 LIST ALL ASC spec'
         ,@fnFilter     = 'MN_IMPORT'
         ,@msgFilter    = NULL
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@asc          = 1
         ,@exp_rows     = 1
         ,@exp_first_id = 2
         ,@exp_row_cnt  = 3
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

      -------------------------------------------------------------------------------
      -- TEST 004: LIST MN_IMPORT DESC spec
      -------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '003 LIST MN_IMPORT DESC spec'
         ,@fnFilter     = 'MN_IMPORT'
         ,@msgFilter    = NULL
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@levelFilter  = NULL
         ,@asc          = 0
         ,@exp_first_id = 23
         ,@exp_rows     = 1
         ,@exp_row_cnt  = 3
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

      -------------------------------------------------------------------------------
      -- TEST 005: Multiple fns
      -------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '004 LIST MN_IMPORT DESC spec'
         ,@fnFilter     = 'MN_IMPORT,POP STG TBLS,BLK_IMPRT_TSV'
         ,@msgFilter    = NULL
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@levelFilter  = NULL
         ,@asc          = 0
         ,@exp_first_id = 31
         ,@exp_rows     = 1
         ,@exp_row_cnt  = 22
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

         IF EXISTS (SELECT 1 FROM test.AppLogTest 
         WHERE (fn NOT LIKE '%MN_IMPORT%' 
            AND fn NOT LIKE '%POP STG TBLS%' 
            AND fn NOT LIKE '%BLK_IMPRT_TSV%' ))
               EXEC tSQLt.Fail 'Test 004 LIST MN_IMPORT DESC spec lists fns other than the required ones';

      -------------------------------------------------------------------------------
      -- TEST 006: msg filter
      -------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '006: msg filter'
         ,@fnFilter     = NULL
         ,@msgFilter    = '%starting%'
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@levelFilter  = NULL
         ,@asc          = NULL
         ,@exp_first_id = 1
         ,@exp_rows     = 1
         ,@exp_row_cnt  = 8
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 007: id filter
      ---------------------------------------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '007: id filter'
         ,@minIdFilter  = 13
         ,@exp_first_id = 13
         ,@exp_row_cnt  = 21;

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 007: id filter
      ---------------------------------------------------------------------------------------------------------------
      EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '008: id filter'
         ,@fnFilter     = NULL
         ,@msgFilter    = NULL
         ,@minIdFilter  = 7
         ,@maxIdFilter  = 22
         ,@levelFilter  = NULL
         ,@asc          = NULL
         ,@exp_first_id = 7
         ,@exp_rows     = NULL
         ,@exp_row_cnt  = 16
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 008: level filter
      ---------------------------------------------------------------------------------------------------------------
         EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '009: level filter'
         ,@fnFilter     = NULL
         ,@msgFilter    = NULL
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@levelFilter  = 3
         ,@asc          = 1
         ,@exp_first_id = 4
         ,@exp_rows     = NULL
         ,@exp_row_cnt  = 13
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 009: combo 1 POP STG TBLS, id>=9  exp 13 rows
      ---------------------------------------------------------------------------------------------------------------
         EXEC test.hlpr_086_sp_list_AppLog
          @test_num     = '010: combo 1'
         ,@fnFilter     = 'POP STG TBLS'
         ,@msgFilter    = NULL
         ,@minIdFilter  = NULL
         ,@maxIdFilter  = NULL
         ,@levelFilter  = NULL
         ,@asc          = 1
         ,@exp_first_id = NULL
         ,@exp_rows     = NULL
         ,@exp_row_cnt  = 17
         ,@exp_ex_num   = NULL
         ,@exp_ex_msg   = NULL;

   --SELECT * FROM Test.AppLogTest ORDER BY [order];
   --SELECT * FROM AppLog

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 011: 
      ---------------------------------------------------------------------------------------------------------------

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 012: 
      ---------------------------------------------------------------------------------------------------------------

      ---------------------------------------------------------------------------------------------------------------
      -- TEST 013: 
      ---------------------------------------------------------------------------------------------------------------

      -------------------------------------------------------------------------------
      -- TESTING COMPLETE
      -------------------------------------------------------------------------------
      EXEC sp_log 2, @fn, '900: testing complete'
   END TRY
   BEGIN CATCH
      EXEC sp_set_log_level @old_log_level;
      THROW;
   END CATCH

   EXEC sp_set_log_level @old_log_level;
   EXEC sp_log 1, @fn, '999: leaving all tests passed';
END
/*
EXEC tSQLt.RunAll;
--EXEC sp_set_log_level 1
EXEC tSQLt.Run 'test.test_086_sp_list_AppLog';
*/
GO
