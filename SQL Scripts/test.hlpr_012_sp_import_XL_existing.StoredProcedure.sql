SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================================================================================
-- Author:      Terry Watts
-- Create date: 29-FEB-2024
-- Description: helper procedure for the sp_bulk_import test rtn test.test_sp_bulk_import
--
-- Tested rtn description: imports an Excel sheet into an existing table
--
-- Preconditions:
--
-- Postconditions
--
-- Test strategy:
-- 1 SETUP:
-- 2 run tested rtn
-- 3 check POSTCONDITIONS
-- ============================================================================================================================================
CREATE PROCEDURE [test].[hlpr_012_sp_import_XL_existing]
    @spreadsheet  NVARCHAR(400)  -- path to xls
   ,@range        NVARCHAR(100)  -- like 'Corrections_221008$A:P' OR 'Corrections_221008$'
   ,@table        NVARCHAR(60)   -- existing table
   ,@clr_first    BIT            -- if 1 then delete the table contets first
   ,@fields       NVARCHAR(4000) -- comma separated list
   ,@exp_row_cnt  INT            = NULL
   ,@chk_row_spec NVARCHAR(500)  = NULL
   ,@chk_fld_nm   NVARCHAR(60)   = NULL
   ,@exp_fld_val  NVARCHAR(500)  = NULL

AS
BEGIN
   DECLARE
    @fn           NVARCHAR(35)   = N'HLPR_IMPRT_XL_XSTNG'
   ,@cmd          NVARCHAR(4000)
   ,@act_row_cnt  INT            = NULL
   ,@act_fld_val  NVARCHAR(500)  = NULL
   ,@log_level    INT

   SET @log_level = dbo.fnGetLogLevel();

   EXEC sp_log 2, @fn,'00: starting
spreadsheet:  [', @spreadsheet,']
range:        [', @range,']
table:        [', @table,']
clr_first:    [', @clr_first,']
fields:       [', @fields,']
log_level:    [',@log_level,']'
;

   -------------------------------------------------------------------------------
   -- 1. Setup
   -------------------------------------------------------------------------------

   -------------------------------------------------------------------------------
   -- 2 run tested rtn
   -------------------------------------------------------------------------------
   EXEC sp_log 2, @fn,'05: running tested routine...';

   EXEC sp_import_XL_existing
          @spreadsheet  = @spreadsheet
         ,@range        = @range
         ,@table        = @table
         ,@clr_first    = @clr_first
         ,@fields       = @fields

   IF @log_level <2
   BEGIN
      SET @cmd=CONCAT('SELECT * FROM [', @table,']');
      EXEC( @cmd);
   END

   -------------------------------------------------------------------------------
   -- 3 check row count
   -------------------------------------------------------------------------------
   IF @exp_row_cnt IS NOT NULL
   BEGIN
      EXEC sp_log 2, @fn,'10: checking exp row count...';
      SET @cmd = CONCAT('SELECT @act_row_cnt = COUNT(*) FROM [',@table, ']');
      EXEC sp_executesql @cmd, N'@act_row_cnt INT OUT', @act_row_cnt OUT;
      EXEC tSQLt.AssertEquals @exp_row_cnt, @act_row_cnt, 'row_cnt mismatch';
   END

   -------------------------------------------------------------------------------
   -- 3 check a field value
   -------------------------------------------------------------------------------
   IF @chk_row_spec IS NOT NULL
   BEGIN
      EXEC sp_log 2, @fn,'15: checking row spec: ', @chk_row_spec, '...';

      IF @chk_fld_nm  IS NOT NULL
      BEGIN
         EXEC sp_log 2, @fn,'20: checking field ', @chk_fld_nm;

         IF @exp_fld_val IS NOT NULL
         BEGIN
            EXEC sp_log 2, @fn,'25: checking field value for row spec: ', @chk_row_spec,' field [', @chk_fld_nm, '] expect [',@exp_fld_val,'] ...';
            SET @cmd = CONCAT('SELECT @act_fld_val = [',@chk_fld_nm,'] FROM [',@table, '] WHERE ',  @chk_row_spec);
            EXEC sp_executesql @cmd, N'@act_fld_val NVARCHAR(500) OUT', @act_fld_val OUT;
            EXEC tSQLt.AssertEquals @exp_fld_val, @act_fld_val, 'fld_val mismatch';
         END
      END
   END

   EXEC sp_log 2, @fn, '99: leaving, OK';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_sp_bulk_import';
*/
GO
