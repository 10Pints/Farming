SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 07-NOV-2023
-- Description: Test helper for the sp_import_typeStaging routine
--
-- Strategy:
--    Set up test import file
--    Clear the type staging table
--    Run import
--    Check the type staging table populated OK (row cnt, some row col vals)
-- ================================================================================================
CREATE PROCEDURE [test].[hlpr_010_sp_import_TypeStaging]
    @test_num     NVARCHAR(100)
   ,@import_file  NVARCHAR(500)
   ,@range        NVARCHAR(100)
   ,@exp_row_cnt  INT               = NULL
   ,@exp_ex_num   INT               = NULL
   ,@exp_ex_msg   NVARCHAR(100)     = NULL
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE 
    @fn              NVARCHAR(35)   = 'hlpr_sp_import_typeStaging'
   ,@cnt             INT
   ,@exp             INT
   ,@act_row_cnt     INT            = 0
   ,@act_ex_num      INT            = -1
   ,@act_ex_msg      NVARCHAR(500)
   ,@line            NVARCHAR(100)  = '-------------------------------------'
   ,@ex_thrown       BIT            = 0

   PRINT CONCAT( @line, ' test ', @test_num, ' ', @line);
   EXEC sp_log 1, @fn,'000: starting
test_num:   [', @test_num, ']
import_file:[', @import_file, ']
range      :[', @range      , ']
exp_row_cnt:[', @exp_row_cnt, ']';

   ---------------------------------------------------------------------------
   -- Test setup
   ---------------------------------------------------------------------------
   -- Clear the type staging table
   EXEC sp_log 1, @fn, '002: Clearing the type staging tables';
   DELETE FROM TypeStaging;
   EXEC tSQLt.AssertEmptyTable 'TypeStaging';

   ---------------------------------------------------------------------------
   -- Call tested fn
   ---------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '020: calling tested routine';

   IF @exp_ex_num IS NULL
   BEGIN
      EXEC sp_log 1, @fn, 'do NOT expect an exception to be thrown';

      EXEC sp_import_typeStaging
         @import_file = @import_file
        ,@range       = @range
        ,@row_cnt     = @act_row_cnt OUT;

      EXEC sp_log 1, @fn, 'an exception was not thrown - which is expected in this test';
   END
   ELSE
   BEGIN
      BEGIN TRY
         -- Expect exception here
         EXEC sp_log 1, @fn, 'expect an exception to be thrown';

         EXEC sp_import_typeStaging
            @import_file = @import_file
           ,@range       = @range
           ,@row_cnt     = @act_row_cnt OUT

         EXEC sp_log 4, @fn, 'expected exception was NOT thrown';
      END TRY
      BEGIN CATCH
         SET @ex_thrown = 1;
         EXEC sp_log 1, @fn, 'an exception was thrown - which is expected in this test';
         -- Always test the exception num 
         EXEC sp_log 1, @fn, 'checking the exception number';
         SET @act_ex_num = ERROR_NUMBER();
         EXEC tSQLt.AssertEquals @exp_ex_num, @act_ex_num, 'test ',@test_num;

         IF @exp_ex_msg IS NOT NULL
         BEGIN
            -- Test the exception msg if the expected value is supplied
            EXEC sp_log 1, @fn, 'checking the exception message';
            SET @act_ex_msg = ERROR_MESSAGE();
            EXEC tSQLt.AssertEquals @exp_ex_msg, @act_ex_msg, 'test ',@test_num;
         END
      END CATCH

      EXEC tSQLt.AssertEquals 1, @ex_thrown, 'Expected an exception to be thrown, but it was not', @test_num;
      RETURN -- no more testing if exception thrown
   END

   ---------------------------------------------------------------------------
   -- Test
   ---------------------------------------------------------------------------
   -- Check the type staging table populated OK (row cnt=5, some row col vals) 
   EXEC sp_log 1, @fn, '20: running chks: sp_chk_table_count';
   EXEC tSQLt.AssertEquals @exp_row_cnt, @act_row_cnt;
   EXEC sp_chk_table_count 'TypeStaging', @exp_row_cnt;

   -- Chk row col vals
   EXEC sp_log 1, @fn, '25: running chks: tSQLt.AssertEqualsTable';
   EXEC tSQLt.AssertEqualsTable '#tmpTypeStaging', 'TypeStaging', @test_num, 'detailed test failed';

   ------------------------------------------------------
   -- Test passed
   ------------------------------------------------------
   EXEC sp_log 1, @fn, '999: test ', @test_num,' passed';
END
/*
EXEC tSQLt.Run 'test.test_sp_import_typeStaging';
*/
GO
