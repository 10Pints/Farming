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
CREATE PROCEDURE [test].[test_016_sp_main_import_stage_0]
AS
BEGIN
   DECLARE @act INT
   ,@exp INT;

   EXEC sp_clear_staging_tables;
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_016_sp_main_import_stage_0';
*/
GO
