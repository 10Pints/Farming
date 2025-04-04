SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================
-- Author:      Terry Watts
-- Create date: 07-APR-2024
-- Description: Initialises state for both the main and the helper test rtns
--    i.e. populates 2 test tables: RtnDetails, ParamDetails
--
-- Preconditions: none
--
-- Postconditions:
-- POST 01: Test.RtnDetails, Test.ParamDetails tables populated or exception
--          fro exception details see sp_get_rtn_details
--
-- Algorithm
--    Populate Test.RtnDetails, Test.ParamDetails tables
--
-- Changes:
-- 231124: added remove [] brackets to make it easier to set up tests
-- 240415: redesign, rewrite
-- ==================================================================
CREATE PROCEDURE [test].[sp_crt_tst_rtns_init]
    @qrn        NVARCHAR(100) -- tested rtn name including the schema - returns it tidied up if necessary
   ,@trn        INT           = NULL
   ,@cora       NCHAR(1)      = 'C'
   ,@ad_stp     BIT           = 0    -- used in testing to identify a step with a unique name (not an incremental int id)
   ,@tst_mode   BIT           = 1    -- for testing - copy tmp tables to permananent tables for teting
   ,@stop_stage INT           = 12   -- stage 12 for testing - display script
AS
BEGIN
   DECLARE 
      @fn        NVARCHAR(35)   = 'CRT_TST_RTNS_INIT'
     ,@n         INT

   SET NOCOUNT ON;

   EXEC sp_log 2, @fn, '000: starting
@qrn   :[', @qrn,']
@trn   :[', @trn,']
@ad_stp:[', @ad_stp,']'
;

   --  populate the 2 routine details tables
   EXEC test.sp_get_rtn_details @qrn, @trn, @cora, @ad_stp, @tst_mode, @stop_stage, 1 -- 1: throw if error
   SELECT * FROM [test].[RtnDetails];
   SELECT * FROM [test].[ParamDetails];
   EXEC sp_log 2, @fn, '999: leaving OK';
END
/*
EXEC tSQLt.Run 'test.test_068_sp_crt_tst_rtns';

EXEC tSQLt.RunAll;
*/
GO
