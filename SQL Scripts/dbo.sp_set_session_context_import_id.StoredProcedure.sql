SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================
-- Author:		  Terry Watts
-- Create date:  19-AUG-2023
-- Description:  SETS the import_id session context
-- ==========================================================
CREATE PROCEDURE [dbo].[sp_set_session_context_import_id]
   @val  INT
AS
BEGIN
   DECLARE     @key     NVARCHAR(30)
   SET @key = dbo.fnGetSessionKeyImportId();
   EXEC sp_set_session_context @key, @val;
END
/*
EXEC sp_set_session_context_import_id 240530
PRINT CONCAT('import_id: [', dbo.fnGetSessionValueImportId(),']');
*/
GO
