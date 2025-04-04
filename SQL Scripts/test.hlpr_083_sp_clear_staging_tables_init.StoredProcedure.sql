SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================================================================================
-- Author:      Terry Watts
-- Create date: 28-FEB-2024
-- Description: hlpr for the test_clear_staging_tables rtn
-- clean populates the staging tables
--
-- Tested rtn description:
-- Deletes the contents of the staging tables based on the @clr_primary_tables parameter
-- if the @cpt is     set then all tables should be cleared INCLUDING {Actionstaging, Typestaging, UseStaging}
-- if the @cpt is not set then all tables should be cleared EXCEPT    {Actionstaging, Typestaging, UseStaging}
--
-- Strategy:
-- SETUP: clear all the staging tables, pop all tables with 1 row manually
-- =============================================================================================================
CREATE PROCEDURE [test].[hlpr_083_sp_clear_staging_tables_init]
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE 
    @fn              NVARCHAR(35) = 'TST_CLR_STGNG_TBLS_INIT'

   EXEC sp_log 2, @fn, '001: starting';
   -- 0: SETUP: clear all staging tables
   EXEC sp_log 1, @fn, '010: Clearing table ChemicalProductStaging     '; DELETE FROM ChemicalActionStaging;
   EXEC sp_log 1, @fn, '015: Clearing table ChemicalProductStaging     '; DELETE FROM ChemicalProductStaging;
   EXEC sp_log 1, @fn, '020: Clearing table ChemicalUseStaging         '; DELETE FROM ChemicalUseStaging;
   EXEC sp_log 1, @fn, '025: Clearing table CropPathogenStaging        '; DELETE FROM CropPathogenStaging;
   EXEC sp_log 1, @fn, '030: Clearing table PathogenChemicalStaging    '; DELETE FROM PathogenChemicalStaging;
   EXEC sp_log 1, @fn, '035: Clearing table ProductCompanyStaging      '; DELETE FROM ProductCompanyStaging;
   EXEC sp_log 1, @fn, '040: Clearing table ProductUseStaging          '; DELETE FROM ProductUseStaging;

   --------------------------------------------------------------------------------------------------------
   -- Clear core staging tables
   --------------------------------------------------------------------------------------------------------
   EXEC sp_log 2, @fn, '045: Clearing core staging tables'
   EXEC sp_log 1, @fn, '046: Clearing table ChemicalStaging            '; DELETE FROM ChemicalStaging;
   EXEC sp_log 1, @fn, '050: Clearing table CropStaging                '; DELETE FROM CropStaging;
   EXEC sp_log 1, @fn, '055: Clearing table ImportCorrectionsStaging   '; DELETE FROM ImportCorrectionsStaging;
   EXEC sp_log 1, @fn, '065: Clearing table PathogenStaging            '; DELETE FROM PathogenStaging;
   EXEC sp_log 1, @fn, '070: Clearing table CompanyStaging             '; DELETE FROM CompanyStaging;
   EXEC sp_log 1, @fn, '075: Clearing table ProductStaging             '; DELETE FROM ProductStaging;

   --------------------------------------------------------------------------------------------------------
   -- Clear primary tables
   --------------------------------------------------------------------------------------------------------
   EXEC sp_log 2, @fn, '080: Clearing primary staging tables'
   EXEC sp_log 1, @fn, '085: Clearing table ActionStaging              '; DELETE FROM ActionStaging;
   EXEC sp_log 1, @fn, '090: Clearing table PathogenTypeStaging        '; DELETE FROM PathogenTypeStaging;
   EXEC sp_log 1, @fn, '095: Clearing table TypeStaging                '; DELETE FROM TypeStaging;
   EXEC sp_log 1, @fn, '100: Clearing table UseStaging                 '; DELETE FROM UseStaging;

   --------------------------------------------------------------------------------------------------------
   -- Check all staging tables not populated
   --------------------------------------------------------------------------------------------------------
   EXEC sp_log 2, @fn, '105: Check all staging tables are not populated';
   EXEC dbo.sp_chk_tbl_not_populated 'ActionStaging';
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
   EXEC dbo.sp_chk_tbl_not_populated 'PathogenTypeStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ProductCompanyStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ProductStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'ProductUseStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'TypeStaging';
   EXEC dbo.sp_chk_tbl_not_populated 'UseStaging';

   --------------------------------------------------------------------------------------------------------
   -- Pop all tables with 1 row manually
   --------------------------------------------------------------------------------------------------------
   EXEC sp_log 2, @fn, '110: Pop all tables with 1 row manually';
   INSERT INTO ActionStaging        (action_id,action_nm)               VALUES (1,'test_data');
   INSERT INTO PathogenTypeStaging  (pathogenType_id, pathogenType_nm)  VALUES (3,'test_data');
   INSERT INTO TypeStaging          ([type_id] ,[type_nm])              VALUES (2,'test_data');
   INSERT INTO UseStaging           (use_id ,use_nm)                    VALUES (4,'test_data');

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
   EXEC sp_log 2, @fn, '115: Check all tables populated';
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
   -- Setup complete
   --------------------------------------------------------------------------------------------------------
EXEC sp_log 1, @fn, '200: Setup complete';
EXEC sp_log 1, @fn, '999: leaving OK';
END

/*
EXEC tSQLt.Run 'test.test_sp_clear_staging_tables';
select * from list_staging_tables_vw
*/
GO
