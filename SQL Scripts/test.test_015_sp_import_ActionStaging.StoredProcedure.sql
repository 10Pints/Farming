SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 07-NOV-2023
-- Description: Tests the sp_import_ActionStaging rtn
-- Strategy:
-- Set up test import file
-- Clear the type staging table
-- Run import
-- Check the type staging table populated OK (row cnt, some row col vals)
-- ================================================================================================
CREATE PROCEDURE [test].[test_015_sp_import_ActionStaging]
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE
    @fn              NVARCHAR(35) = 'test_sp_import_ActionStaging'
   ,@cnt             INT
   ,@exp             INT
   ,@log_level       INT

   SET @log_level = dbo.fnGetLogLevel();
   EXEC sp_log 1, @fn, '01: starting, log level: ',@log_level;
   EXEC Ut.dbo.sp_set_session_context N'ENFORCE_SINGLE_CALL', 0;
   -- Set up test import file
   -- Clear the type staging table
   EXEC sp_log 1, @fn, '02: Clearing the type staging tables';
   EXEC sp_clear_staging_tables 1;

   -- Set up expected test data
   CREATE TABLE #tmpActionStaging
   (
       action_id  INT
      ,action_nm  NVARCHAR(50)
   );


   EXEC sp_log 1, @fn, '05: creating the check data in #tmpActionStaging';
   INSERT INTO #tmpActionStaging(action_id, action_nm)
   VALUES
    ( 1, 'Contact')
   ,( 2, 'Curative')
   ,( 3, 'Fumigant')
   ,( 4, 'Ingested')
   ,( 5, 'Inhaled')
   ,( 6, 'Non-selective')
   ,( 7, 'Post-emergent')
   ,( 8, 'Pre-emergent')
   ,( 9, 'Protective')
   ,(10, 'Selective')
   ,(11, 'Systemic')
   ,(12, 'Therapeutic')
;

   -- Chk type staging has no rows
   EXEC sp_log 1, @fn, '10: calling tSQLt.AssertEmptyTable ''ActionStaging''';
   exec tSQLt.AssertEmptyTable 'ActionStaging';

   -- Run import on the txt file
   EXEC sp_log 1, @fn, '15: running tested import rtn sp_import_ActionStaging';
   EXEC sp_import_ActionStaging 'D:\Dev\Farming\Data\Actions.txt';

   -- Check the type staging table populated OK (row cnt=5, some row col vals) 
   EXEC sp_log 1, @fn, '20: running chks: sp_chk_table_count';
   EXEC sp_chk_table_count 'ActionStaging', 13;

   -- Chk some row col vals
   EXEC sp_log 1, @fn, '25: running chks: tSQLt.AssertEqualsTable';
   EXEC tSQLt.AssertEqualsTable '#tmpActionStaging', 'ActionStaging';

   -- Run import on the xl file
   EXEC sp_log 1, @fn, '15: running tested import rtn sp_import_ActionStaging';
   EXEC sp_import_ActionStaging 'D:\Dev\Farming\Data\Actions.xlsx', @range='Actions$A:B';

   -- Check the type staging table populated OK (row cnt=5, some row col vals) 
   EXEC sp_log 1, @fn, '20: running chks: sp_chk_table_count';
   EXEC sp_chk_table_count 'ActionStaging', 13;

   -- Chk some row col vals
   EXEC sp_log 1, @fn, '25: running chks: tSQLt.AssertEqualsTable';
   EXEC tSQLt.AssertEqualsTable '#tmpActionStaging', 'ActionStaging';

   EXEC sp_log 1, @fn, '99: leaving all tests passed';
END
/*
EXEC tSQLt.RunAll;
EXEC sp_set_log_level 1;
EXEC tSQLt.Run 'test.test_015_sp_import_ActionStaging';
*/
GO
