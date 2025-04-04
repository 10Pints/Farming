SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 07-NOV-2023
-- Description: Tests the sp_import_typeStaging rtn
--
-- Strategy:
--    Set up test import file
--    Clear the type staging table
--    Run import
--    Check the type staging table populated OK (row cnt, some row col vals) 
-- ================================================================================================
CREATE PROCEDURE [test].[test_010_sp_import_TypeStaging]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE 
    @fn              NVARCHAR(35) = 'test_sp_import_typeStaging'
   ,@imprt_tsv_file  NVARCHAR(500) = 'D:\Dev\Repos\Farming\Data\Type.txt'

   EXEC sp_log 1, @fn, '000: starting';
   ------------------------------------------------------
   -- Set up 1 off things
   ------------------------------------------------------
   EXEC sp_log 1, @fn, '005: 1 off test setup';
   -- Set up expected test data
   -- Clear staging tables
   EXEC sp_log 1, @fn, '010: Clearing the staging tables';
   EXEC sp_clear_staging_tables 1;
   EXEC sp_log 1, @fn, '015: creating the check data in #tmpTypeStaging';
   DROP TABLE IF EXISTS #tmpTypeStaging;

   CREATE TABLE #tmpTypeStaging
   (
       [type_id]  INT
      ,[type_nm]  NVARCHAR(50)
   );
   
   INSERT INTO #tmpTypeStaging 
   VALUES
   (1, 'Chemical'),
   (2, 'Company' ),
   (3, 'Crop'    ),
   (4, 'Pathogen'),
   (5, 'Product' );

   -- Chk type staging has no rows
   exec tSQLt.AssertEmptyTable 'TypeStaging';

   ------------------------------------------------------
   -- Run tests
   ------------------------------------------------------
   EXEC sp_log 1, @fn, '020: running tests';
   EXEC test.hlpr_010_sp_import_TypeStaging
    @test_num    = '001: OK tsv'
   ,@import_file = 'D:\Dev\Repos\Farming\Data\Type.txt'
   ,@range       = NULL
   ,@exp_row_cnt = 5
   ,@exp_ex_num  = NULL
   ,@exp_ex_msg  = NULL

   EXEC test.hlpr_010_sp_import_TypeStaging
    @test_num    = '002: OK xlsx'
   ,@import_file = 'D:\Dev\Repos\Farming\Data\Type.xlsx'
   ,@range       = NULL
   ,@exp_row_cnt = 5
   ,@exp_ex_num  = NULL
   ,@exp_ex_msg  = NULL

   EXEC test.hlpr_010_sp_import_TypeStaging
    @test_num    = '003: non existant tsv file'
   ,@import_file = 'D:\Dev\Repos\Farming\Data\nonexistantfile.tsv'
   ,@range       = NULL
   ,@exp_row_cnt = NULL
   ,@exp_ex_num  = 63241
   ,@exp_ex_msg  = 'import file [D:\Dev\Repos\Farming\Data\nonexistantfile.tsv] must exist'

   EXEC test.hlpr_010_sp_import_TypeStaging
    @test_num    = '004: non existant xlsx file'
   ,@import_file = 'D:\Dev\Repos\Farming\Data\nonexistantfile.xlsx'
   ,@range       = NULL
   ,@exp_row_cnt = NULL
   ,@exp_ex_num  = 63241
   ,@exp_ex_msg  = 'import file [D:\Dev\Repos\Farming\Data\nonexistantfile.xlsx] must exist'

   ------------------------------------------------------
   -- Testing complete
   ------------------------------------------------------
   EXEC sp_log 1, @fn, '99: leaving all tests passed';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_010_sp_import_typeStaging';
*/
GO
