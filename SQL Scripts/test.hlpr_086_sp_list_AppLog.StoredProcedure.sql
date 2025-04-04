SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================================================================
-- Author:           Terry Watts
-- Create date:      07-MAR-2024
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
--==============================================================================================================
CREATE PROCEDURE [test].[hlpr_086_sp_list_AppLog]
    @test_num     NVARCHAR(70)
   ,@fnFilter     NVARCHAR(50)   = NULL  -- DEFAULT = ALL
   ,@msgFilter    NVARCHAR(128)  = NULL  -- DEFAULT = ALL
   ,@minIdFilter  INT            = NULL  -- DEFAULT = ALL
   ,@maxIdFilter  INT            = NULL  -- DEFAULT = ALL
   ,@levelFilter  INT            = NULL  -- DEFAULT = ALL
   ,@asc          BIT            = NULL  -- DEFAULT = DESC, 1= ASC, 0=desc
   -- expected results
   ,@exp_rows     BIT            = NULL
   ,@exp_row_cnt  INT            = NULL
   ,@exp_first_id INT            = NULL
   ,@exp_ex_num   INT            = NULL
   ,@exp_ex_msg   NVARCHAR(100)  = NULL
AS
BEGIN
   DECLARE
    @fn           NVARCHAR(35)   = N'hlpr_086_LST_APPLOG'
   ,@act          NVARCHAR(200)
   ,@act_ex_num   INT
   ,@act_ex_msg   NVARCHAR(500)
   ,@line         NVARCHAR(60) = '----------------------------------'
   ,@ex_thrown    BIT = 0
   ,@act_row_cnt  INT = -1
   ,@act_first_id INT = -1
   ,@tst_msg_id   NVARCHAR(500)

   PRINT ' ';
   PRINT CONCAT(@line, ' test ', @test_num, ' ', @line);

   EXEC sp_log 1, @fn, '000: starting,
test_num     [', @test_num   , ']
fnFilter     [', @fnFilter   , ']
msgFilter    [', @msgFilter  , ']
minIdFilter  [', @minIdFilter, ']
maxIdFilter  [', @maxIdFilter, ']
levelFilter  [', @levelFilter, ']
asc          [', @asc        , ']
exp_rows     [', @exp_rows   , ']
exp_row_cnt  [', @exp_row_cnt, ']
exp_first_id [', @exp_first_id,']
exp_ex_num   [', @exp_ex_num,  ']
exp_ex_msg   [', @exp_ex_msg,  ']'
;

   ---------------------------------------------------------------------------
   -- SETUP
   ---------------------------------------------------------------------------
   SET @tst_msg_id = CONCAT('test ',@test_num);
   TRUNCATE TABLE Test.AppLogTest;
   EXEC test.hlpr_086_sp_list_AppLog_pop_tst_dta;

   ---------------------------------------------------------------------------
   -- Call tested fn
   ---------------------------------------------------------------------------
   IF @exp_ex_num IS NULL
   BEGIN
      EXEC sp_log 1, @fn, '005: calling sp_list_AppLog...';
      --SELECT * FROM AppLog;

      INSERT INTO Test.AppLogTest( id, [level], row_count, fn, msg, msg2, msg3, msg4)
      EXEC sp_list_AppLog
          @fnFilter    = @fnFilter
         ,@msgFilter   = @msgFilter
         ,@minIdFilter = @minIdFilter
         ,@maxIdFilter = @maxIdFilter
         ,@levelFilter = @levelFilter
         ,@asc         = @asc
         ;

      SET @act_row_cnt = @@ROWCOUNT;
      --SELECT * FROM Test.AppLogTest ORDER BY [order];
      EXEC sp_log 1, @fn, '010: ret frm sp_list_AppLog row cnt: ',@act_row_cnt;

   END
   ELSE
   BEGIN
      BEGIN TRY
         -- Expect exception here
         EXEC sp_log 1, @fn, '015: calling sp_list_AppLog (expect an exception to be thrown)';

         INSERT INTO Test.AppLogTest( id, [level], row_count, fn, msg, msg2, msg3, msg4)
            EXEC sp_list_AppLog
                @fnFilter    = @fnFilter
               ,@msgFilter   = @msgFilter
               ,@minIdFilter = @minIdFilter
               ,@maxIdFilter = @maxIdFilter
               ,@levelFilter = @levelFilter
               ,@asc         = @asc
               ;

         EXEC sp_log 4, @fn, '020: expected exception was NOT thrown';
      END TRY
      BEGIN CATCH
         SET @ex_thrown = 1;
         EXEC sp_log 1, @fn, '025: the expected exception was thrown';
         -- Always test the exception num 
         EXEC sp_log 1, @fn, '030: checking the exception number';
         SET @act_ex_num = ERROR_NUMBER();
         EXEC tSQLt.AssertEquals @exp_ex_num, @act_ex_num, @tst_msg_id;

         IF @exp_ex_msg IS NOT NULL
         BEGIN
            -- Test the exception msg if the expected value is supplied
            EXEC sp_log 1, @fn, '035: checking the exception message';
            SET @act_ex_msg = ERROR_MESSAGE();
            EXEC tSQLt.AssertEquals @exp_ex_msg, @act_ex_msg, @tst_msg_id;
         END
      END CATCH

      EXEC tSQLt.AssertEquals 1, @ex_thrown, '040: The expected exception was not thrown';
   END

   ---------------------------------------------------------------------------
   -- Test results
   ---------------------------------------------------------------------------
   -- Test the row count if the expected value is supplied
   -- if expect some rows NB cant expect no rows with this chk - for that use @exp_row_cnt
   IF @exp_rows     IS NOT NULL 
   BEGIN
      EXEC sp_log 1, @fn, '045: chk has rows';
      EXEC tSQLt.AssertNotEquals 0, @act_row_cnt, @tst_msg_id;
   END

   IF @exp_row_cnt  IS NOT NULL
   BEGIN
      EXEC sp_log 1, @fn, '050: chk row count';
      EXEC tSQLt.AssertEquals @exp_row_cnt, @act_row_cnt, @tst_msg_id--, ' chk row count';
   END

  IF @exp_first_id IS NOT NULL 
   BEGIN
      EXEC sp_log 1, @fn, '055: chk first id';
      SET @act_first_id = (SELECT TOP 1 id FROM test.AppLogTest ORDER BY [order]);
      EXEC tSQLt.AssertEquals @exp_first_id, @act_first_id, @tst_msg_id--, ' chk first id';
   END

   ---------------------------------------------------------------------------
   -- TESTING COMPLETE
   ---------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '900: testing complete'
   EXEC sp_log 1, @fn, '999: leaving, OK'
END
/*
EXEC tSQLt.Run 'test.test_086_sp_list_AppLog';
EXEC sp_list_applog
*/
GO
