SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 07-NOV-2023
-- Description: Tests the sp_import_useStaging rtn
-- Strategy:
-- Set up test import file
-- Clear the use staging table
-- Run import
-- Check the UseStaging table populated OK (row cnt, some row col vals)
-- ================================================================================================
CREATE PROCEDURE [test].[test_011_sp_import_UseStaging]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE
    @fn              NVARCHAR(35) = 'test_sp_import_UseStaging'
   ,@cnt             INT
   ,@exp             INT
   ,@imprt_tsv_file  NVARCHAR(MAX) = 'D:\Dev\Repos\Farming\Data\Use.txt'

   EXEC sp_log 1, @fn, '01: starting';
   -- Set up test import file
   -- Clear the type staging table
   EXEC sp_log 1, @fn, '02: Clearing the type staging tables';
   EXEC sp_clear_staging_tables 1;
   -- Set up expected test data
   CREATE TABLE #tmpUseStaging
   (
       [use_id]  INT
      ,[use_nm]  NVARCHAR(50)
   );
   
   EXEC sp_log 1, @fn, '05: creating the check data in #tmpUseStaging';
   INSERT INTO #tmpUseStaging 
   VALUES
    (1, 'Acaricide')
   ,(2, 'Adjuvant')
   ,(3, 'Antibiotic')
   ,(4, 'Bactericide')
   ,(5, 'Biological Fungicide')
   ,(6, 'Biological Herbicide')
   ,(7, 'Biological Insecticide')
   ,(8, 'Bleaching Agent')
   ,(9, 'Disinfectant')
   ,(10, 'Emulsifier')
   ,(11, 'Foliar antitranspirant')
   ,(12, 'Fumigant')
   ,(13, 'Fungicide')
   ,(14, 'Growth Regulator')
   ,(15, 'Herbicide')
   ,(16, 'Insecticide')
   ,(17, 'Miticide')
   ,(18, 'Molluscicide')
   ,(19, 'Nematicide')
   ,(20, 'Others')
   ,(21, 'Ripener')
   ,(22, 'Rodenticide')
   ,(23, 'Soil Sterilant')
   ,(24, 'Sticker')
   ,(25, 'Wetting Agent')
   ;
   -- Chk type staging has no rows
   EXEC sp_log 1, @fn, '10: calling tSQLt.AssertEmptyTable ''UseStaging''';
   exec tSQLt.AssertEmptyTable 'UseStaging';

   -- Run import
   EXEC sp_log 1, @fn, '15: running tested import rtn sp_import_UseStaging';
   EXEC sp_import_UseStaging @imprt_tsv_file;

   -- Check the type staging table populated OK (row cnt=5, some row col vals)
   EXEC sp_log 1, @fn, '20: running chks: sp_chk_table_count';
   EXEC sp_chk_table_count 'UseStaging', 5;

   -- Chk some row col vals
   EXEC sp_log 1, @fn, '25: running chks: tSQLt.AssertEqualsTable';
   -- SELECT * FROM #tmpUseStaging
   -- SELECT * FROM UseStaging
   EXEC tSQLt.AssertEqualsTable '#tmpUseStaging', 'UseStaging';
   EXEC sp_log 1, @fn, '99: leaving all tests passed';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_011_sp_import_UseStaging';
*/
GO
