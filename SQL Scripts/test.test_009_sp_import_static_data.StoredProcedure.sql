SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 05-FEB-2024
-- Description: Tests the sp_import_StaticData routine
--
-- Tested rtn desc: imports all the static data
-- Tables:
--   {1. ActionStaging, 2. UseStaging, 3.Distributor, 4. PathogenTypeStaging, 5. PathogenPathogenTypeStaging, 6. TypeStaging}
--
-- Tested rtn Preconditions: none
--
-- Tested rtn Postconditions:
--   POST01: all the imported tables have at least one row

-- Strategy:
-- 1. Clear the static data tables
-- 2. Run import
-- 3. Check all the tables have at least 1 row
-- ================================================================================================
CREATE PROCEDURE [test].[test_009_sp_import_static_data]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE 
    @fn              NVARCHAR(35) = 'test_sp_import_static_data'

   EXEC sp_log 1, @fn, '000: starting';
   --------------------------------------------------------------------------------------------
   -- 1. Setup
   --------------------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '005: setup';
   --EXEC sp_reset_CallRegister 'IMPORT_STATIC_DATA';
   EXEC Ut.dbo.sp_set_session_context N'ENFORCE_SINGLE_CALL', 0;

   EXEC sp_log 1, @fn, '010: calling sp_clear_staging_tables';
   EXEC sp_clear_staging_tables 1;

   --------------------------------------------------------------------------------------------
   -- 2. Run routine
   --------------------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '0150: running sp_import_StaticData';
   EXEC sp_import_static_data

   --------------------------------------------------------------------------------------------
   -- 3. Post condition checks: Check all the tables have at least 1 row
   --------------------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '40: Check all the tables have at least 1 row';
   EXEC sp_chk_tbl_populated 'ActionStaging';
   EXEC sp_chk_tbl_populated 'Distributor';
   EXEC sp_chk_tbl_populated 'ForeignKey';
   EXEC sp_chk_tbl_populated 'Import';
   EXEC sp_chk_tbl_populated 'Pathogen';
   EXEC sp_chk_tbl_populated 'PathogenTypeStaging';
   EXEC sp_chk_tbl_populated 'TableDef';
   EXEC sp_chk_tbl_populated 'TableType';
   EXEC sp_chk_tbl_populated 'TypeStaging';
   EXEC sp_chk_tbl_populated 'UseStaging';

   EXEC sp_log 1, @fn, '99: leaving all tests passed';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_009_sp_import_static_data';
SELECT * FROM fKeys_vw
*/
GO
