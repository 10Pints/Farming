SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:      Terry Watts
-- Create date: 05-NOV-2023
-- Description: Tests the fnGetImportIdFromName routine
-- ========================================================
CREATE PROCEDURE [test].[hlpr_006_sp_crt_mn_tbl_FKs_hlpr]
       @fk_nm     NVARCHAR(100)
      ,@fk_tbl    NVARCHAR(100)
      ,@fk_fld    NVARCHAR(60)
      ,@pk_tbl    NVARCHAR(100)
      ,@pk_fld    NVARCHAR(60)
      ,@exp_error BIT = 0
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE
       @fn                          NVARCHAR(30)   = 'CRT_MN_TBL_FKS_HLPR'
      ,@act                         INT
      ,@exp                         INT
      ,@rc                          INT
      ,@sql                         NVARCHAR(MAX)
      ,@error_msg                   NVARCHAR(500)
      ,@CONSTRAINT_CATALOG          NVARCHAR(100) = NULL
      ,@CONSTRAINT_SCHEMA           NVARCHAR(100) = NULL
      ,@UNIQUE_CONSTRAINT_CATALOG   NVARCHAR(100) = NULL
      ,@UNIQUE_CONSTRAINT_SCHEMA    NVARCHAR(100) = NULL
      ,@UNIQUE_CONSTRAINT_NAME      NVARCHAR(100) = NULL
      ,@MATCH_OPTION                NVARCHAR(100) = NULL
      ,@UPDATE_RULE                 NVARCHAR(100) = NULL
      ,@DELETE_RULE                 NVARCHAR(100) = NULL

   BEGIN TRY
      EXEC sp_log 2, @fn, '01: starting';
      SET @sql = CONCAT('ALTER TABLE [', @fk_tbl, '] DROP CONSTRAINT IF EXISTS ', @fk_nm,';');
      EXEC sp_log 2, @fn, '02: DROP CONSTRAINT IF EXISTS ', @fk_nm;
      EXEC @rc=sp_executesql @sql;

      IF @rc <> 0
      BEGIN
         EXEC sp_log 4, @fn, '02: DROP CONSTRAINT IF EXISTS failed', @fk_nm;
         THROW 52414, 'DROP CONSTRAINT IF EXISTS failed', 1;
      END

      -- Call the tested rtn
      EXEC sp_log 1, @fn, '03:  Calling sp_crt_mn_tbl_FKs_hlpr'
      EXEC dbo.sp_crt_mn_tbl_FKs_hlpr @fk_nm, @fk_tbl, @fk_fld, @pk_tbl, @pk_fld;
      EXEC sp_log 1, @fn, '04:  ret from sp_crt_mn_tbl_FKs_hlpr';
   END TRY
   BEGIN CATCH
      IF @exp_error = 0
      BEGIN
         SET @error_msg = CONCAT('50: Caught unexpected exception: ', Ut.dbo.fnGetErrorMsg());
         EXEC sp_log 4, @fn, '
@fk_nm    : ', @fk_nm, '
@fk_tbl   : ', @fk_tbl   ,'
@fk_fld   : ', @fk_fld   ,'
@pk_tbl   : ', @pk_tbl   ,'
@pk_fld   : ', @pk_fld   ,'
@exp_error: ', @exp_error,'
';

         EXEC sp_log 4, @fn, @error_msg;
         THROW;
      END
      ELSE
        EXEC sp_log 2, @fn, '05: Expected exception occurred';
   END CATCH

   IF @rc<> 0
   BEGIN
      SET @error_msg = ut.dbo.fnGetErrorMsg();
      SET @error_msg = CONCAT('06: failed to drop FK, ', @error_msg);
      EXEC sp_log 4, @fn, @error_msg;
      ;THROW 587412, @error_msg, 1;
   END

   -- chk existence of key
   EXEC sp_log 2, @fn, 'Chking the existence and fields of key ',@fk_nm;
/*
CONSTRAINT_CATALOG	CONSTRAINT_SCHEMA	CONSTRAINT_NAME	UNIQUE_CONSTRAINT_CATALOG	UNIQUE_CONSTRAINT_SCHEMA	UNIQUE_CONSTRAINT_NAME	MATCH_OPTION	UPDATE_RULE	DELETE_RULE
Farming_Dev          dbo               FK_Crop_Import	   Farming_Dev                dbo	                     PK_Import               SIMPLE	      NO ACTION	NO ACTION
*/

   SELECT
       @CONSTRAINT_CATALOG        = CONSTRAINT_CATALOG
      ,@CONSTRAINT_SCHEMA         = CONSTRAINT_SCHEMA
      ,@UNIQUE_CONSTRAINT_CATALOG = UNIQUE_CONSTRAINT_CATALOG
      ,@UNIQUE_CONSTRAINT_SCHEMA  = UNIQUE_CONSTRAINT_SCHEMA
      ,@UNIQUE_CONSTRAINT_NAME	 = UNIQUE_CONSTRAINT_NAME
      ,@MATCH_OPTION	             = MATCH_OPTION
      ,@UPDATE_RULE	             = UPDATE_RULE
      ,@DELETE_RULE               = DELETE_RULE
   FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
   WHERE constraint_name = @fk_nm;

   EXEC tSQLt.AssertNotEquals NULL      , @CONSTRAINT_CATALOG         , 'CONSTRAINT_CATALOG NULL: Create FK failed to create FK in db';
   EXEC tSQLt.AssertEquals 'Farming_Dev', @CONSTRAINT_CATALOG         , 'CONSTRAINT_CATALOG        mismatch should be Farming_Dev';
   EXEC tSQLt.AssertEquals 'dbo'        , @CONSTRAINT_SCHEMA          , 'CONSTRAINT_SCHEMA         mismatch should be dbo   ';
   EXEC tSQLt.AssertEquals 'Farming_Dev', @UNIQUE_CONSTRAINT_CATALOG  , 'UNIQUE_CONSTRAINT_CATALOG mismatch should be Farming_Dev';
   EXEC tSQLt.AssertEquals 'dbo'        , @UNIQUE_CONSTRAINT_SCHEMA   , 'UNIQUE_CONSTRAINT_SCHEMA  mismatch should be dbo   ';
--   EXEC tSQLt.AssertEquals @fk_nm      , @UNIQUE_CONSTRAINT_NAME     , 'UNIQUE_CONSTRAINT_NAME    mismatch should be the fk name';
   EXEC tSQLt.AssertEquals 'SIMPLE'     , @MATCH_OPTION               , 'MATCH_OPTION mismatch should be SIMPLE  ';
   EXEC tSQLt.AssertEquals 'NO ACTION'  , @UPDATE_RULE                , 'UPDATE_RULE  mismatch should be NO ACTION';
   EXEC tSQLt.AssertEquals 'NO ACTION'  , @DELETE_RULE                , 'DELETE_RULE  mismatch should be NO ACTION';

   EXEC sp_log 2, @fn, 99,'
@fk_nm    : ', @fk_nm, '
@fk_tbl   : ', @fk_tbl   ,'
@fk_fld   : ', @fk_fld   ,'
@pk_tbl   : ', @pk_tbl   ,'
@pk_fld   : ', @pk_fld   ,'

test      : PASSED';

END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_006_sp_crt_mn_tbl_FKs_hlpr';
*/
GO
