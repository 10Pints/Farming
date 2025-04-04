SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:      Terry Watts
-- Create date: 05-FEB-2024
-- Description: Tests the sp_main_import_stage_0 rtn
--
-- tested rtn Description: helper rtn to check a table does not  contain any items in the given field
--    If it does logs an error and adds to the error table
-- tested rtn PRECNODITIONS  : none
-- tested rtn POSTCONDITIONS: 
-- Test strategy:
-- 1 start with clean database
-- 2 run tested rtn
-- 3 check POSTCONDITIONS
--    a Use table and UseStaging tables have rows
-- =======================================================
CREATE PROCEDURE [test].[test_001_sp_chk_table_not_contains]
AS
BEGIN
   DECLARE
     @fn             NVARCHAR(35)   = N'TST_CHK_TBL_NOT_CONTNS'
    ,@err_cnt_total  INT = 0

   EXEC sp_log 2, @fn,'00: starting';
   TRUNCATE TABLE AppLog;

   EXEC sp_chk_table_not_contains 'Crop','crop_nm','IN'
         , ''' Beans'',''  Popcorn)'',''Banana (Cavendish) (Post- harvest treatment)'', ''Banana (Cavendish) as insecticidal soap'',''Cowpea and other beans'',''Soybeans & other beans'''
         ,@err_cnt_total OUT;

   EXEC sp_log 2, @fn,'05: @err_cnt_total: ', @err_cnt_total;

   EXEC sp_chk_table_not_contains 'Staging2', 'pathogens', 'LIKE', '''''',@err_cnt_total OUT;

   EXEC sp_log 2, @fn, '@err_cnt_total: ', @err_cnt_total

   EXEC sp_chk_table_not_contains 'Pathogen', 'pathogenType_id', 'IS NULL', @err_cnt_total = @err_cnt_total OUT;

   IF @err_cnt_total > 0
      SELECT * FROM importErrors;

   EXEC sp_log 2, @fn, '99: leaving, count: ', @err_cnt_total;
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_001_sp_chk_table_not_contains';
*/
GO
