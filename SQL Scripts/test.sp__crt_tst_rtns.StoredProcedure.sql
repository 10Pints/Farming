SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================
-- Author:      Terry Watts
-- Create date: 15-APR-2024
-- Description: Creates both the main and the helper test rtns
-- for the given tested rtn
--
-- Responibilities:
-- 1: creates both scripts
-- 2. runs the script to compile the stored procedure in the db
--
-- Postconditions:
-- POST 01: IF @tst_rtn_num is specfied then must be > 0
-- POST 02: IF @tst_rtn_num is specfied then must not be already used
-- POST 03: @q_tstd_rtn can either be <schema_nm>.<rtn name> or <rtn name> and must uniquely define
-- POST 04: must uniquely define exactly 1 routine if rtn does not exists -> 58000, 'Routine does not exist'
-- POST 05: if more than 1 rtn exists -> 58001, 'more than 1 routine match the tested routine paramater'
-- POST 06: @crt_or_alter must be one of {'A', 'C', NULL}  If null default: 'C' -> 58002 '@crt_or_alter paramater must be one of {'A', 'C', NULL}'
--
-- Algorithm
--    INIT crt_tst_rtns_init
--    Create the hlpr rtn (script and procdure from script)
--    Create the mn rtn  (script and procdure from script)
--
-- Tests: test_068_sp_crt_tst_rtns
--
-- Changes:
-- 231124: added remove [] brackets to make it easier to set up tests
-- 240724: removed the compile ferature as have difficulty in getting this to work programmatically
--         now manually copy paste from the test.TstHlpr table
-- ==================================================================
CREATE PROCEDURE [test].[sp__crt_tst_rtns]
    @qrn       NVARCHAR(100)  -- including schema
   ,@trn       INT            = NULL
   ,@cora      NCHAR(1)       = 'C'
   ,@ad_stp    BIT            = 1    -- used in testing to identify a step with a unique name (not an incremental int id)
   ,@tst_mode  BIT            = 1
   ,@stop_stg  INT            = 99
   ,@folder    NVARCHAR(500)
AS
BEGIN
   DECLARE 
    @fn              NVARCHAR(35)   = 'sp_crt_tst_rtns'
   ,@n               INT

   SET NOCOUNT ON;

   BEGIN TRY
      EXEC sp_log 2, @fn, '00: starting:
   @qrn     :[',@qrn      ,']
   @trn     :[',@trn      ,']
   @cora    :[',@cora     ,']
   @ad_stp  :[',@ad_stp   ,']
   @ad_stp  :[',@ad_stp   ,']
   @tst_mode:[',@tst_mode ,']
   @stop_stg:[',@stop_stg ,']
   ';

      ----------------------------------------------------------------------------------------
      -- INIT crt_tst_rtns_init
      ----------------------------------------------------------------------------------------
      EXEC sp_log 2, @fn, '05: test.calling sp_crt_tst_fn_hlpr';
      EXEC test.sp_crt_tst_rtns_init @qrn, @trn, @cora, @ad_stp, @tst_mode, @stop_stg

      ----------------------------------------------------------------------------------------
      -- Create the hlpr rtn (script and procdure from script)
      ----------------------------------------------------------------------------------------
      EXEC test.sp_crt_tst_hlpr @folder;
      EXEC sp_log 3, @fn, '50: stopping early - while TDD';

      ----------------------------------------------------------------------------------------
      -- Create the mn rtn  (script and procdure from script)
      ----------------------------------------------------------------------------------------
      EXEC sp_log 2, @fn, '10: calling test.sp_crt_tst_fn_mn';
      EXEC test.sp_crt_tst_mn @folder;

      ----------------------------------------------------------------------------------------
      --    Completed processing
      ----------------------------------------------------------------------------------------
      EXEC sp_log 2, @fn, '10: Completed processing'
   END TRY
   BEGIN CATCH
      EXEC sp_log_exception @fn;
      THROW;
   END CATCH

   EXEC sp_log 2, @fn, '999 leaving, OK';
END
/*
SELECT * FROM test.fnGetUntestedRtns();

TRUNCATE TABLE AppLog;
EXEC tSQLt.Run 'test.test_068_sp__crt_tst_rtns';
EXEC tSQLt.RunAll;
*/
GO
