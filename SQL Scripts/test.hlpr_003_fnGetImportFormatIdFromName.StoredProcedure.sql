SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 06-NOV-2023
-- Description: Test helper the fnGetImportIdFromName() fn 
-- ================================================================================================
CREATE PROCEDURE [test].[hlpr_003_fnGetImportFormatIdFromName] @inp NVARCHAR(MAX), @exp INT
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE
       @fn  NVARCHAR(35)   = N'TST_HLPR_fnGetImportFormatIdFromName'
      ,@act INT

   SET @act = dbo.fnGetImportFormatIdFromName(@inp);
   EXEC sp_log 2, @fn,'@inp= ', @inp,' @exp= ', @exp,' @act= ', @act;
   EXEC tSQLt.AssertEquals @exp, @act;
END
GO
