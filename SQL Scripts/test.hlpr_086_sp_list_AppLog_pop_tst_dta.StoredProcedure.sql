SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================
-- Author:      Terry watts
-- Create date: 09-MAR-2024
-- Description: hlpr routine for hlpr_086_sp_list_AppLog
--              populates AppLog with test data
-- =====================================================================
CREATE PROCEDURE [test].[hlpr_086_sp_list_AppLog_pop_tst_dta]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE
    @fn         NVARCHAR(35)   = N'hlpr_086_LST_APPLOG_ptd'
   ,@log_level  INT -- interferes with the tests too much


   TRUNCATE TABLE AppLog;
   SET @log_level = dbo.fnGetLogLevel() -- interferes with the tests too much
--   EXEC sp_set_log_level 1
   EXEC sp_log 1, @fn, '000: starting, @log_level: ',@log_level
   -- set the log with test data
   EXEC sp_log 2, 'MN_IMPORT', '000: starting';
   EXEC sp_log 1, 'BLK_IMPRT_TSV', '000: starting';
   EXEC sp_log 3, 'POP STG TBLS', '000: starting';
   EXEC sp_log 4, 'POP STG TBLS', '020: problem';
   EXEC sp_log 2, 'CHK_TBL_POPD', '000: starting';
   EXEC sp_log 1, 'POP STG TBLS', '00: starting';
   EXEC sp_log 3, 'POP STG TBLS', '11: Pop ChemicalProductStaging table';
   EXEC sp_log 3, 'POP STG TBLS', '12: Pop ChemicalUseStaging table, calling sp_pop_chemical_use_staging';
   EXEC sp_log 1, 'POP STG TBLS', '12:';
   EXEC sp_log 3, 'POP CHEM ACTN STAGING', '99: leaving OK';
   EXEC sp_log 3, 'POP STG TBLS', '950: leaving OK';
   EXEC sp_log 3, 'POP CPY_S2_S3', '00: Caching COPYING staging2 to staging3 (backup) starting';
   EXEC sp_log 2, 'POP STG TBLS', '13:';
   EXEC sp_log 2, 'POP STG TBLS', '14:';
   EXEC sp_log 3, 'POP CPY_S2_S3', '99: leaving: OK';
   EXEC sp_log 4, 'CHK_TBL_POPD', '00: checking if the table [Staging2]                is populated: (OK), it has 25407 rows';
   EXEC sp_log 2, 'POP CHEM ACTN STAGING', '02: PRE01: S2 table must be populated';
   EXEC sp_log 1, 'DELETE_TABLE', '10: deleted 0 rows from the CropStaging table';
   EXEC sp_log 1, 'MAIN_IMPORT_STAGE_07', '00: starting';
   EXEC sp_log 1, 'MN_IMPORT', 'Stage 07: pop staging';
   EXEC sp_log 1, 'BLK_IMPRT_TSV', '999: leaving OK';
   EXEC sp_log 2, 'MN_IMPORT', '999: leaving';
   EXEC sp_log 1, 'POP STG TBLS', '15:';
   EXEC sp_log 3, 'POP STG TBLS', '17:';
   EXEC sp_log 3, 'POP STG TBLS', '18:';
   EXEC sp_log 3, 'POP STG TBLS', '19:';
   EXEC sp_log 2, 'POP STG TBLS', '15:';
   EXEC sp_log 1, 'POP STG TBLS', '12:';
   EXEC sp_log 3, 'POP STG TBLS', '20:';
   EXEC sp_log 1, 'POP STG TBLS', '99: leaving';
   EXEC sp_log 1, @fn, '999: leaving';

   --IF @log_level <3 EXEC sp_list_AppLog;
END
/*
EXEC tSQLt.RunAll;
EXEC sp_set_log_level 3
EXEC tSQLt.Run 'test.test_086_sp_list_AppLog';
*/
GO
