SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Author:      Terry Watts
-- Create date: 06-NOV-2023
-- Description: hlpr for the sp_import_corrections_file test rtn
-- ================================================================
CREATE PROCEDURE [test].[hlpr_008_sp_import_correction_file]
    @import_root        NVARCHAR(450)
   ,@correction_file    NVARCHAR(MAX)
   ,@exp_ex             BIT
AS
BEGIN
	SET NOCOUNT ON;
   DECLARE
       @fn        NVARCHAR(35)   = 'hlpr_imp_corctn_file'
      ,@error_msg NVARCHAR(500)
      ,@flag      BIT = 0

   EXEC sp_log 1, @fn,'01: starting,
@import_root    :[', @import_root, ']
@correction_file:[', @correction_file, ']
@exp_ex         :[', @exp_ex, ']'
;

   IF @exp_ex = 0
   BEGIN
      EXEC sp_log 1, @fn,'02: in IF @exp_ex = 0 calling tested rtn, expect exception = false';
      EXEC dbo.sp_import_corrections_file @import_root, @correction_file ;
      EXEC sp_log 1, @fn,'03: in IF @exp_ex = 0 ret frm tested rtn OK';
      EXEC sp_log 1, @fn,'10: leaving OK, did not get exception and did not expect one';
      RETURN 0;
   END
   ELSE
   BEGIN
      BEGIN TRY
         EXEC sp_log 1, @fn,'20: in IF @exp_ex = 1 calling tested rtn, expect exception = true';
         EXEC dbo.sp_import_corrections_file @import_root, @correction_file;
         SET @error_msg = 'oops! Expected exception was NOT thrown, so throwing ex 53485'
         EXEC sp_log 4, @fn, '25: ', @error_msg; 
         SET @flag = 1;
         THROW 53485, @error_msg, 1;
      END TRY
      BEGIN CATCH
         EXEC sp_log 1, @fn,'40: In exception handler, @flag= ', @flag;

         IF @flag = 1 
         BEGIN
            EXEC sp_log 1, @fn,'45: In exception handler @flag = 1, throwing exception 53485: Expected exception was NOT thrown';
            THROW; -- We threw this exception and it should be passed on
         END

         IF @exp_ex = 1
         BEGIN
            EXEC sp_log 1, @fn,'50: caught expected exception, OK';
         END
      END CATCH

      EXEC sp_log 1, @fn,'99: leaving OK';
   END
END
/*
   EXEC tSQLt.Run'test.test_sp_import_correction_file';
*/
GO
