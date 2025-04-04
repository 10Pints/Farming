SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================================================================================
-- Author:      Terry Watts
-- Create date: 28-FEB-2024
-- Description: Tests the sp_clear_staging_tables rtn
--
-- Tested rtn description:
-- Deletes the contents of the staging tables based on the @clr_primary_tables parameter
-- if the @cpt is     set then all tables should be cleared INCLUDING {Actionstaging, Typestaging, UseStaging}
-- if the @cpt is not set then all tables should be cleared EXCEPT    {Actionstaging, Typestaging, UseStaging}
--
-- Strategy:
-- 0: SETUP: clear all staging tables, pop all tables with 1 row manually
-- 1: Test @cpt     set expect all tables cleared INCLUDING {Actionstaging, Typestaging, UseStaging}
-- 0: SETUP: clear all staging tables, pop all tables with 1 row manually
-- 2: Test @cpt not set expect all tables cleared EXCEPT    {Actionstaging, Typestaging, UseStaging}
-- =============================================================================================================
CREATE PROCEDURE [test].[test_083_sp_clear_staging_tables]
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE 
    @fn              NVARCHAR(35) = 'TST_083_CLR_STGNG_TBLS'

   EXEC sp_log 1, @fn, '00: starting';
   -- 0: SETUP: clear all staging tables, pop all tables with 1 row manually
   EXEC sp_log 1, @fn, '05: test 01: setup';
   EXEC test.hlpr_083_sp_clear_staging_tables_init
   EXEC sp_log 1, @fn, '10: test 01: calling tested rtn';
   -- 1: Test with @cpt set expect all tables cleared INCLUDING {Actionstaging, Typestaging, UseStaging}
   -- Check primary tables not populated
   -- Check non primary tables not populated
   EXEC sp_clear_staging_tables 1
   EXEC sp_log 1, @fn, '15: test 01: testing result';
   EXEC test.hlpr_083_sp_clear_staging_tables_chk 1

   -- 0: SETUP: clear all staging tables, pop all tables with 1 row manually
   EXEC sp_log 1, @fn, '20: test 02: setup';
   EXEC test.hlpr_083_sp_clear_staging_tables_init
   EXEC sp_log 1, @fn, '25: test 02: calling tested rtn';

   -- 2: Test with @cpt not set expect only secondary tables cleared i.e. not    {Actionstaging, Typestaging, UseStaging}
   EXEC sp_clear_staging_tables 0
   EXEC sp_log 1, @fn, '30: test 02: testing result';

   -- Check primary tables populated
   -- Check non primary tables not populated
   EXEC test.hlpr_083_sp_clear_staging_tables_chk 0

EXEC sp_log 1, @fn, '99: leaving all tests passed';
END
/*
EXEC tSQLt.Run 'test.test_083_sp_clear_staging_tables';
*/
GO
