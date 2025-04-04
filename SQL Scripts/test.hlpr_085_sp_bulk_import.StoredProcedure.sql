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
-- Description: imports a tsv or xlsx file
--
-- Parameters:    Mandatory,optional M/O
-- @import_file  [M] the import source file can be a tsv or xlsx file
--                   if an XL file then the normal format for the sheet is field names in the top row 
--                   including an id for ease of debugging data issues
-- @table        [O] the table to import the data to. 
--                if an XL file defaults to sheet name if not Sheet1$ otherwise file name less the extension
--                if a tsv defaults to file name less the extension
-- @view         [O] if a tsv this is the view used to control which columns are used n the Bulk insert command 
--                   the default is NULL when the view name is constructed as import_<table name>_vw
-- @range        [O] for XL: like 'Corrections_221008$A:P' OR 'Corrections_221008$' default is 'Sheet1$'
-- @fields       [O] for XL: comma separated list
-- @clr_first    [O] if 1 then delete the table contents first           default is 1
-- @is_new       [O] if 1 then create the table - this is a double check default is 0
-- @expect_rows  [O] optional @expect_rows to assert has imported rows   default is 1
--
-- Preconditions: none
--
-- Postconditions:
-- POST01: @import file must not be null or ''             OR exception 63240, 'import_file must be specified'
-- POST02: @import file must exist                         OR exception 63241, 'import_file must exist'
-- POST03: if @is_new is false then (table must exist      OR exception 63242, 'table must exist if @is_new is false')
-- POST04: if @is_new is true  then (table must not exist  OR exception 63243, 'table must not exist if @is_new is true'))
-- POST05: if import file is a tsv file then @view must be specified OR exception 63244 'the view must be specified if thisis a tsv import'
-- 
-- RULES:
-- POST06: @table: if xl import then @table must be specified or deducable from the sheet name or file name OR exception 63245
-- POST07: @table: if a tsv then must specify table or the file name is the table 
-- POST08: @view:  if a tsv file then if the view is not specified then it is set as Import<table>_vw
-- POST09: @range: if an Excel file then range defaults to 'Sheet1$'
-- POST10: @fields:if an Excel file then @fields is optional
--          if not specified then it is taken from the excel header (first row)
-- POST11: @fields:if a tsv file then @fields is mandatory OR EXCEPTION 63245, 'POST11: if a tsv file then @fields is must be specified'
-- POST12: @is_new: if this is set and @fields is null then the table is created with fields taken from the spreadsheet header
--==============================================================================================================
CREATE PROCEDURE [test].[hlpr_085_sp_bulk_import]
    @test_num     NVARCHAR(70)
   ,@import_file  NVARCHAR(1000)
   ,@table        NVARCHAR(60)
   ,@view         NVARCHAR(60)
   ,@range        NVARCHAR(100)    -- for XL: like 'Corrections_221008$A:P' OR 'Corrections_221008$'
   ,@fields       NVARCHAR(4000)   -- for XL: comma separated list
   ,@clr_first    BIT              -- if 1 then delete the table contents first
   ,@is_new       BIT              -- if 1 then create the table - this is a double check
   ,@expect_rows  BIT              -- optional @expect_rows to assert has imported rows
   ,@exp_row_cnt  INT            = NULL
   ,@exp_ex_num   INT            = NULL
   ,@exp_ex_msg   NVARCHAR(100)  = NULL
   ,@act_row_cnt  INT            = NULL OUT
AS
BEGIN
   DECLARE
    @fn           NVARCHAR(35)   = N'hlpr_085_blk_imprt'
   ,@act          NVARCHAR(200)
   ,@act_ex_num   INT
   ,@act_ex_msg   NVARCHAR(500)
   ,@line         NVARCHAR(60) = '----------------------------------'
   ,@ex_thrown    BIT = 0

   PRINT ' ';
   PRINT CONCAT(@line, ' test ', @test_num, ' ', @line);
   EXEC sp_log 1, @fn, '000: starting,
import_file [', @import_file, ']
table:      [', @table      , ']
view:       [', @view       , ']
range:      [', @range      , ']
fields      [', @fields     , ']
clr_first   [', @clr_first  , ']
is_new      [', @is_new     , ']
expect_rows [', @expect_rows, ']
exp_row_cnt [', @exp_row_cnt, ']
exp_ex_num  [', @exp_ex_num , ']
exp_ex_msg  [', @exp_ex_msg , ']';

   ---------------------------------------------------------------------------
   -- SETUP
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   -- Call tested fn
   ---------------------------------------------------------------------------
   IF @exp_ex_num IS NULL AND @exp_ex_msg IS NULL
   BEGIN
      --EXEC sp_log 1, @fn, 'we do NOT expect an exception to be thrown';
      EXEC sp_bulk_import
          @import_file = @import_file
         ,@table       = @table
         ,@view        = @view
         ,@range       = @range
         ,@fields      = @fields
         ,@clr_first   = @clr_first
         ,@is_new      = @is_new
         ,@expect_rows = @expect_rows
         ,@row_cnt     = @act_row_cnt OUT;

      EXEC sp_log 1, @fn, 'expect an exception to be thrown';
   END
   ELSE
   BEGIN
      BEGIN TRY
         -- Expect exception here
         EXEC sp_log 1, @fn, 'expect an exception to be thrown';

         EXEC sp_bulk_import
             @import_file = @import_file
            ,@table       = @table
            ,@view        = @view
            ,@range       = @range
            ,@fields      = @fields
            ,@clr_first   = @clr_first
            ,@is_new      = @is_new
            ,@expect_rows = @expect_rows
            ,@row_cnt     = @act_row_cnt OUT;

         EXEC sp_log 4, @fn, 'expected exception was NOT thrown';
      END TRY
      BEGIN CATCH
         SET @ex_thrown = 1;
         EXEC sp_log 1, @fn, 'expected exception was thrown';
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

      EXEC tSQLt.AssertEquals 1, @ex_thrown, 'Expected an exception to be thrown, but it was not';
      RETURN;
   END

   ---------------------------------------------------------------------------
   -- Test results
   ---------------------------------------------------------------------------
   -- Test the row count if the expected value is supplied
   IF @exp_row_cnt IS NOT NULL EXEC tSQLt.AssertEquals @exp_row_cnt, @act_row_cnt;

   ---------------------------------------------------------------------------
   -- TESTING COMPLETE
   ---------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '900: testing complete'
   EXEC sp_log 1, @fn, '999: leaving, OK'
END
/*
   EXEC tSQLt.Run 'test.test_085_sp_bulk_import;
*/
GO
