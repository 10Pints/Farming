SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--========================================================================================
-- Author:           Terry Watts
-- Create date:      10-Dec-2023
-- Description:      test helper rtn for the fnTstCrtTstHdr rtn being tested
-- Tested rtn desc:
--  hlpr rtn to create the header  
--  
-- PRECONDITIONS:  
-- PRE01: test.DescTable  pop'd  
-- PRE02: test.ParamTable pop'd  
--
-- Tested rtn params: 
--    @tstd_rtn       NVARCHAR(100),
--    @max_param_len  INT,
--    @fnType         NCHAR(2),
--    @descTable      TABLE TYPE,
--    @paramTable     TABLE TYPE
--========================================================================================
CREATE PROCEDURE [test].[hlpr_083_sp_clear_staging_tables_chk]
    @all_tabls BIT
AS
BEGIN
   DECLARE
       @fn           NVARCHAR(35)   = N'hlpr_083_clr_stgng_tbl_chk'

   EXEC sp_log 1, @fn, '00: starting, @all_tabls: ', @all_tabls;

   IF @all_tabls = 1
   BEGIN
      EXEC sp_log 1, @fn, '05: checking primary tables not populated';
      EXEC dbo.sp_chk_tbl_not_populated 'ActionStaging';
      EXEC dbo.sp_chk_tbl_not_populated 'PathogenTypeStaging';
      EXEC dbo.sp_chk_tbl_not_populated 'TypeStaging';
      EXEC dbo.sp_chk_tbl_not_populated 'UseStaging';
   END
   ELSE
   BEGIN
      EXEC sp_log 1, @fn, '10: checking primary tables are populated';
      EXEC dbo.sp_chk_tbl_populated 'ActionStaging';
      EXEC dbo.sp_chk_tbl_populated 'PathogenTypeStaging';
      EXEC dbo.sp_chk_tbl_populated 'TypeStaging';
      EXEC dbo.sp_chk_tbl_populated 'UseStaging';
   END

   /*SELECT table_name from list_tables_vw where table_name like '%staging'
AND table_name NOT IN ('ActionStaging','PathogenTypeStaging','TypeStaging','UseStaging');
*/
   EXEC sp_log 1, @fn, '15: checking secondary staging tables not populated';
   EXEC dbo.sp_chk_tbl_not_populated 'ChemicalActionStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ChemicalProductStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ChemicalStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ChemicalUseStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'CompanyStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'CropPathogenStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'CropStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ImportCorrectionsStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'PathogenChemicalStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'PathogenStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ProductCompanyStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ProductStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ProductUseStaging';
END
/*
EXEC tSQLt.Run 'test.test_083_sp_clear_staging_tables'
*/
GO
