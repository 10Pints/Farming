SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================
-- Author:      Terry Watts
-- Create date: 05-NOV-2023
-- Description: cleanup routine for tsql test:
--    test_sp_create_main_table_FKs_hlpr
-- restores the FKs
--
-- CALLED BY: test annotation:
--    [@tSQLt:NoTransaction]('test.cleanup_test_sp_create_main_table_FKs_hlpr')
--    ALTER PROCEDURE [test].[test_sp_create_main_table_FKs_hlpr]
--
-- CHANGES:
-- 231105: do nothng for now as tSQLt framework failes the cleanup
-- ==============================================================================
CREATE PROCEDURE [test].[cleanup_tst_sp_crt_mn_tbl_FKs_hlpr]
AS
BEGIN
   DECLARE
       @fn        NVARCHAR(30)   = 'TST CLNUP TST_CRT_MN_TBL_FKS_HLPR'

   EXEC sp_log 2, @fn, '01: starting'
	SET NOCOUNT ON;
   EXEC sp_crt_mn_tbl_FKs 0; -- drop all first incase some exist
   EXEC sp_crt_mn_tbl_FKs 1; -- recreate FKs
   EXEC sp_log 2, @fn, '99: done'
END
/*
  EXEC test.cleanup_tst_sp_crt_mn_tbl_FKs_hlpr;
*/
GO
