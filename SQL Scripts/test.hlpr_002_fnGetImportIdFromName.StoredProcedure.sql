SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:      Terry Watts
-- Create date: 03-NOV-2023
-- Description: Test helper the fnGetImportIdFromName() fn 
-- ================================================================================================
CREATE PROCEDURE [test].[hlpr_002_fnGetImportIdFromName] @inp NVARCHAR(MAX), @exp INT
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE 
       @fn  NVARCHAR(35)   = N'HLPR_fnGetImprtIdFrmNm'
      ,@act INT

   SET @act = dbo.fnGetImportIdFromName(@inp);
   EXEC sp_log 2, @fn,'@inp= ', @inp,' @exp= ', @exp,' @act= ', @act;
   EXEC tSQLt.AssertEquals @exp, @act;
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_002_fnGetImportIdFromName';
*/
GO
