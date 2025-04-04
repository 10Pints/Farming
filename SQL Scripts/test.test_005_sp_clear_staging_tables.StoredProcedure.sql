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
-- 2: Test @cpt not set expect all tables cleared EXCEPT    {Actionstaging, Typestaging, UseStaging}
-- =============================================================================================================
CREATE PROCEDURE [test].[test_005_sp_clear_staging_tables]
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE 
    @fn              NVARCHAR(35) = 'TST_CLR_STGNG_TBLS'

   EXEC sp_log 1, @fn, '01: starting';
   -- 0: SETUP: clear all staging tables
   EXEC sp_log 1, @fn, '10: clearing table ChemicalProductStaging     '; DELETE FROM ChemicalActionStaging;
   EXEC sp_log 1, @fn, '15: clearing table ChemicalProductStaging     '; DELETE FROM ChemicalProductStaging;
   EXEC sp_log 1, @fn, '20: clearing table ChemicalUseStaging         '; DELETE FROM ChemicalUseStaging;
   EXEC sp_log 1, @fn, '25: clearing table CropPathogenStaging        '; DELETE FROM CropPathogenStaging;
   EXEC sp_log 1, @fn, '30: clearing table PathogenChemicalStaging    '; DELETE FROM PathogenChemicalStaging;
   EXEC sp_log 1, @fn, '35: clearing table ProductCompanyStaging      '; DELETE FROM ProductCompanyStaging;
   EXEC sp_log 1, @fn, '40: clearing table ProductUseStaging          '; DELETE FROM ProductUseStaging;

   --------------------------------------------------------------------------------------------------------
   -- Clear core staging tables
   --------------------------------------------------------------------------------------------------------
   EXEC sp_log 2, @fn, '45: clearing core staging tables'
   EXEC sp_log 2, @fn, '46: clearing table ChemicalStaging            '; DELETE FROM ChemicalStaging;
   EXEC sp_log 2, @fn, '50: clearing table CropStaging                '; DELETE FROM CropStaging;
   EXEC sp_log 2, @fn, '55: clearing table ImportCorrectionsStaging   '; DELETE FROM ImportCorrectionsStaging;
   EXEC sp_log 2, @fn, '65: clearing table PathogenStaging            '; DELETE FROM PathogenStaging;
   EXEC sp_log 2, @fn, '70: clearing table CompanyStaging             '; DELETE FROM CompanyStaging;
   EXEC sp_log 2, @fn, '75: clearing table ProductStaging             '; DELETE FROM ProductStaging;

   --------------------------------------------------------------------------------------------------------
   -- Clear primary tables
   --------------------------------------------------------------------------------------------------------
   EXEC sp_log 2, @fn, '80: clearing table ActionStaging              '; DELETE FROM ActionStaging;
   EXEC sp_log 2, @fn, '85: clearing table PathogenTypeStaging        '; DELETE FROM PathogenTypeStaging;
   EXEC sp_log 2, @fn, '90: clearing table TypeStaging                '; DELETE FROM TypeStaging;
   EXEC sp_log 2, @fn, '95: clearing table UseStaging                 '; DELETE FROM UseStaging;

   --------------------------------------------------------------------------------------------------------
   -- Check all tables pop
   --------------------------------------------------------------------------------------------------------
   EXEC sp_chk_tbl_not_populated 'ActionStaging';
   EXEC sp_chk_tbl_not_populated 'ChemicalActionStaging';
   EXEC sp_chk_tbl_not_populated 'ChemicalProductStaging';
   EXEC sp_chk_tbl_not_populated 'ChemicalStaging';
   EXEC sp_chk_tbl_not_populated 'ChemicalUseStaging';
   EXEC sp_chk_tbl_not_populated 'CompanyStaging';
   EXEC sp_chk_tbl_not_populated 'CropPathogenStaging';
   EXEC sp_chk_tbl_not_populated 'CropStaging';
   EXEC sp_chk_tbl_not_populated 'ImportCorrectionsStaging';
   EXEC sp_chk_tbl_not_populated 'PathogenChemicalStaging';
   EXEC sp_chk_tbl_not_populated 'PathogenStaging';
   EXEC sp_chk_tbl_not_populated 'PathogenTypeStaging';
   EXEC sp_chk_tbl_not_populated 'ProductCompanyStaging';
   EXEC sp_chk_tbl_not_populated 'ProductStaging';
   EXEC sp_chk_tbl_not_populated 'ProductUseStaging';
   EXEC sp_chk_tbl_not_populated 'TypeStaging';
   EXEC sp_chk_tbl_not_populated 'UseStaging';

   --------------------------------------------------------------------------------------------------------
   -- Pop all tables with 1 row manually
   --------------------------------------------------------------------------------------------------------
   INSERT INTO ActionStaging              (action_id,action_nm)               VALUES (1,'test_data');
   INSERT INTO PathogenTypeStaging        (pathogenType_id, pathogenType_nm)  VALUES (3,'test_data');
   INSERT INTO TypeStaging                ([type_id] ,[type_nm])              VALUES (2 ,'test_data');
   INSERT INTO UseStaging                 (use_id ,use_nm)                    VALUES (4,'test_data');

   INSERT INTO ChemicalStaging            (chemical_nm)                 VALUES('test_data');
   INSERT INTO CompanyStaging             (company_nm)                  VALUES('test_data');
   INSERT INTO CropStaging                (crop_nm)                     VALUES('test_data');
   INSERT INTO ImportCorrectionsStaging   (id ,search_clause)           VALUES(1,'test_data');
   INSERT INTO PathogenStaging            (pathogen_nm)                 VALUES('test_data');
   INSERT INTO ProductStaging             (product_nm)                  VALUES('test_data');

   INSERT INTO ChemicalActionStaging      (chemical_nm, action_nm)      VALUES('test_data','test_data');
   INSERT INTO ChemicalProductStaging     (chemical_nm, product_nm)     VALUES('test_data','test_data');
   INSERT INTO ChemicalUseStaging         (chemical_nm, use_nm)         VALUES('test_data','test_data');
   INSERT INTO CropPathogenStaging        (crop_nm, pathogen_nm)        VALUES('test_data','test_data');
   INSERT INTO PathogenChemicalStaging    (pathogen_nm, chemical_nm)    VALUES('test_data','test_data');
   INSERT INTO ProductCompanyStaging      (product_nm, company_nm)      VALUES('test_data','test_data');
   INSERT INTO ProductUseStaging          (product_nm, use_nm)          VALUES('test_data','test_data');

   --------------------------------------------------------------------------------------------------------
   -- Check all tables pop
   --------------------------------------------------------------------------------------------------------
   EXEC sp_chk_tbl_populated'ActionStaging';
   EXEC sp_chk_tbl_populated'ChemicalActionStaging';
   EXEC sp_chk_tbl_populated'ChemicalProductStaging';
   EXEC sp_chk_tbl_populated'ChemicalStaging';
   EXEC sp_chk_tbl_populated'ChemicalUseStaging';
   EXEC sp_chk_tbl_populated'CompanyStaging';
   EXEC sp_chk_tbl_populated'CropPathogenStaging';
   EXEC sp_chk_tbl_populated'CropStaging';
   EXEC sp_chk_tbl_populated'ImportCorrectionsStaging';
   EXEC sp_chk_tbl_populated'PathogenChemicalStaging';
   EXEC sp_chk_tbl_populated'PathogenStaging';
   EXEC sp_chk_tbl_populated'PathogenTypeStaging';
   EXEC sp_chk_tbl_populated'ProductCompanyStaging';
   EXEC sp_chk_tbl_populated'ProductStaging';
   EXEC sp_chk_tbl_populated'ProductUseStaging';
   EXEC sp_chk_tbl_populated'TypeStaging';
   EXEC sp_chk_tbl_populated'UseStaging';

   --------------------------------------------------------------------------------------------------------
   -- Testing complete
   --------------------------------------------------------------------------------------------------------

EXEC sp_log 1, @fn, '99: leaving all tests passed';
END

/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_005_sp_clear_staging_tables';
select * from list_staging_tables_vw
*/
GO
