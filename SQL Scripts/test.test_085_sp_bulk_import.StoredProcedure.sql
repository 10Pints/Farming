SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================================================================================
-- Author:      Terry Watts
-- Create date:      07-MAR-2024
-- Description: Tests the fnGetFileNameFromPath rtn
--
-- Tested rtn description:
-- Description: imports a tsv or xlsx file
--
-- Parameters:    Mandatory,optional M/O
-- @import_file  [M] the import source file can be a tsv or xlsx file
--                   if an XL file then the normal format for the sheet is field names in the top row including an id for ease of debugging 
--                   data issues
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
-- RULES:
-- if a tsv then must specify table and optionally the view
--    if the view is not specified then it is set as Import<table>_vw
-- if an Excel file then range defaults to 'Sheet1$'
-- @fields is only relevant when importing an Excel file
--    if not specified then it is taken from the excel header (first row)
--
-- @is_new: if this is set then the table is created based on the spreadsheet header
-- 
-- Preconditions:
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
--========================================================================================
CREATE PROCEDURE [test].[test_085_sp_bulk_import]
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE 
    @fn           NVARCHAR(35) = 'TST_085_BULK_IMPORT'
   ,@act_row_cnt  INT

   EXEC sp_log 1, @fn, '000: starting';

   -------------------------------------------------------------------------------
   -- 1 OFF SETUP: 
   -------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '005: test 01: setup';

   -------------------------------------------------------------------------------
   -- Run tests
   -------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '010: running tests';

   -------------------------------------------------------------------------------
-- TEST 001: POST01: @import_file must not be null or '' OR exception 63240, 'import_file must be specified'
   -------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '001 POST01 f !null'
   ,@import_file= NULL
   ,@table      = NULL
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = NULL
   ,@clr_first  = NULL
   ,@is_new     = NULL
   ,@expect_rows= NULL
   ,@exp_row_cnt= NULL
   ,@exp_ex_num = 63240
   ,@exp_ex_msg = 'import file must be specified';

   -------------------------------------------------------------------------------
   -- TEST 002: POST02: @import_file must exist OR exception 63241, 'import_file must exist'
   -------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '002: POST02 f m xst'
   ,@import_file= 'non existant file'
   ,@table      = NULL
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = NULL
   ,@clr_first  = NULL
   ,@is_new     = NULL
   ,@expect_rows= NULL
   ,@exp_row_cnt= NULL
   ,@exp_ex_num = 63241
   ,@exp_ex_msg = 'import file [non existant file] must exist';

   -------------------------------------------------------------------------------
   -- TEST 003: POST03: if @is_new is false then (table must exist      OR exception 63242, 'table must exist if @is_new is false')
   -------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '003: POST03 !new->t m xst'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\ImportCorrections 231025 231106-0000.xlsx'
   ,@table      = 'non existant table'
   ,@view       = NULL
   ,@range      = 'Corrections_221008$'
   ,@fields     = NULL
   ,@clr_first  = NULL
   ,@is_new     = 0   
   ,@expect_rows= NULL
   ,@exp_row_cnt= NULL
   ,@exp_ex_num = 63241
   ,@exp_ex_msg = 'import file [D:\Dev\Repos\Farming\Data\ImportCorrections 231025 231106-0000.xlsx] must exist';

   -------------------------------------------------------------------------------
   -- TEST 004: POST04: if @is_new is true then (table must not exist  OR exception 63243, 'table must not exist if @is_new is true'))
   -------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '004: POST04 new->tbl mst not exst'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\ImportCorrections 221018 230816-2000.xlsx'
   ,@table      = 'CropStaging' -- 
   ,@view       = NULL
   ,@range      = 'ImportCorrections$A:S'
   ,@fields     = NULL
   ,@clr_first  = NULL
   ,@is_new     = 1
   ,@expect_rows= NULL
   ,@exp_row_cnt= NULL
   ,@exp_ex_num = 63243
   ,@exp_ex_msg = 'table must not exist if @is_new is true';

   -------------------------------------------------------------------------------
   -- TEST 005: POST05: if import file is a tsv file then @view must be specified OR exception 63244 'the view must be specified for a tsv import'
   -------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '005: POST05 tsv->vw m spec'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\Use.txt'
   ,@table      = 'Non Existant Table'
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = 'id,name'
   ,@clr_first  = NULL
   ,@is_new     = 0
   ,@expect_rows= NULL
   ,@exp_row_cnt= NULL
   ,@exp_ex_num = 63244
   ,@exp_ex_msg = 'table must exist if @is_new is false';

   ---------------------------------------------------------------------------------------------------------------
-- RULES:
   ---------------------------------------------------------------------------------------------------------------

   ---------------------------------------------------------------------------------------------------------------
-- TEST 006: POST06: @table: if xl import then @table must be specified or deducable from the sheet name 
-- or file name OR exception 63245
   ---------------------------------------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '006: POST06 deduce tbl nm'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\PathogenTypeBadTblNm.xlsx'
   ,@table      = NULL
   ,@view       = NULL
   ,@range      = 'BadTbleNamy$'
   ,@fields     = NULL
   ,@clr_first  = NULL
   ,@is_new     = 0
   ,@expect_rows= 1
   ,@exp_row_cnt= 11
   ,@exp_ex_num = 63244
   ,@exp_ex_msg = 'table must exist if @is_new is false'

   ---------------------------------------------------------------------------------------------------------------
-- TEST 007: POST07: @table: if a tsv then must specify table or the file name is the table 
   ---------------------------------------------------------------------------------------------------------------
/*   DELETE FROM ProductUse;
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '007: POST07 tsv->f nm'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\PathogenTypeBadTblNm.txt'
   ,@table      = NULL
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = 'Product,Type'
   ,@clr_first  = NULL
   ,@is_new     = 0
   ,@expect_rows= 1
   ,@exp_row_cnt= 11
   ,@exp_ex_num = NULL
   ,@exp_ex_msg = NULL
   ,@act_row_cnt = @act_row_cnt OUT;

   EXEC tSQLt.AssertEquals 11, @act_row_cnt, 'Test 007, row count mismatch'
*/
   ---------------------------------------------------------------------------------------------------------------
-- TEST 008: POST08: @view: if a tsv file then if the view is not specified then it is set as Import_<table>_vw
   ---------------------------------------------------------------------------------------------------------------
   DELETE FROM ProductUse;
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '008: POST08 tsv ^ !vw -> deduce vw nm'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\ProductUseStaging.txt'
   ,@table      = NULL
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = 'product_nm,use_nm'
   ,@clr_first  = NULL
   ,@is_new     = 0
   ,@expect_rows= 1
   ,@exp_row_cnt= 11
   ,@exp_ex_num = NULL
   ,@exp_ex_msg = NULL
   ,@act_row_cnt = @act_row_cnt OUT;

   EXEC tSQLt.AssertEquals 11, @act_row_cnt, 'Test 008, row count mismatch'

   ---------------------------------------------------------------------------------------------------------------
-- TEST 009: POST09: @range: if an Excel file then range defaults to 'Sheet1$'
   ---------------------------------------------------------------------------------------------------------------
   DELETE FROM PathogenStaging;
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '009: POST09 xl ^ rng IS NULL->deduce rng'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\Pathogen2.xlsx'
   ,@table      = 'PathogenStaging'
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = NULL -- 'Pathogen_nm,PathogenType_nm'
   ,@clr_first  = 1
   ,@is_new     = 0
   ,@expect_rows= 1
   ,@exp_row_cnt= 357
   ,@exp_ex_num = NULL
   ,@exp_ex_msg = NULL
   ,@act_row_cnt = @act_row_cnt OUT;

   EXEC tSQLt.AssertEquals 357, @act_row_cnt, 'Test 009, row count mismatch'

   ---------------------------------------------------------------------------------------------------------------
-- TEST 010: POST10: @fields:if an Excel file then @fields is optional
--          if not specified then it is taken from the excel header (first row)
--          also test if range is whole sheet that it still imports ok
   ---------------------------------------------------------------------------------------------------------------
   DELETE FROM PathogenStaging;
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '010: POST10 xl ^ f IS NULL->deduce f'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\Pathogen.xlsx'
   ,@table      = 'PathogenStaging'
   ,@view       = NULL
   ,@range      = 'Pathogen$A:B'
   ,@fields     = NULL
   ,@clr_first  = 1
   ,@is_new     = 0
   ,@expect_rows= 1
   ,@exp_row_cnt= 363
   ,@exp_ex_num = NULL
   ,@exp_ex_msg = NULL

   ---------------------------------------------------------------------------------------------------------------
-- TEST 011: POST11: @fields:if a tsv file then @fields is mandatory OR EXCEPTION 63245, 'POST11: if a tsv file
-- then @fields is must be specified'
   ---------------------------------------------------------------------------------------------------------------
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '011:PO11: tsv file->@fields is mandatory OR EXCEPTION 63245,'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\PathogenType.txt'
   ,@table      = 'PathogenType'
   ,@view       = NULL
   ,@range      = NULL
   ,@fields     = NULL
   ,@clr_first  = 1
   ,@is_new     = 0
   ,@expect_rows= 1
   ,@exp_row_cnt= NULL
   ,@exp_ex_num = 63245
   ,@exp_ex_msg = 'if a tsv file then @fields must be specified'

   ---------------------------------------------------------------------------------------------------------------
-- TEST 012: POST12: @is_new: if this is set and @fields is null 
-- then the table is created with fields taken from the spreadsheet header
   ---------------------------------------------------------------------------------------------------------------
   DROP TABLE IF EXISTS PathogenType_test;
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '012: POST12: @is_new=1 ^ @fields is null->ded f'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\PathogenType.xlsx'
   ,@table      = 'PathogenType_test'
   ,@view       = NULL
   ,@range      = PathogenType$
   ,@fields     = NULL
   ,@clr_first  = NULL
   ,@is_new     = 1
   ,@expect_rows= 1
   ,@exp_row_cnt= 11
   ,@exp_ex_num = NULL
   ,@exp_ex_msg = NULL

   DROP TABLE IF EXISTS PathogenType_test;

   ---------------------------------------------------------------------------------------------------------------
-- TEST 013: POST12: @is_new: if this is set and @fields is not null 
-- then the table is created with the supplied fields and not taken from the spreadsheet header
   ---------------------------------------------------------------------------------------------------------------
   DROP TABLE IF EXISTS PathogenType_test2;
   EXEC [test].[hlpr_085_sp_bulk_import]
    @test_num   = '013:if new and @fields specd'
   ,@import_file= 'D:\Dev\Repos\Farming\Data\PathogenType2.xlsx'
   ,@table      = 'PathogenType_test2'
   ,@view       = NULL
   ,@range      = 'PathogenType$A:B'
   ,@fields     = 'pathogenType_id,pathogenType_nm'
   ,@clr_first  = NULL
   ,@is_new     = 1
   ,@expect_rows= 1
   ,@exp_row_cnt= 11
   ,@exp_ex_num = NULL
   ,@exp_ex_msg = NULL

   DROP TABLE IF EXISTS PathogenType_test2;
   -------------------------------------------------------------------------------
   -- TESTING COMPLETE
   -------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '900: testing complete'
EXEC sp_log 1, @fn, '999: leaving all tests passed';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_085_sp_bulk_import';
*/
GO
