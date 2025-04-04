SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================
-- Author:      Terry Watts
-- Create date: 03-NOV-2023
-- Description: Tests the fnGetImportIdFromName() fn
-- ===================================================
CREATE PROCEDURE [test].[test_002_fnGetImportIdFromName]
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;

   DECLARE
    @fn  NVARCHAR(35)   = N'TST_fnGetImprtIdFrmNm'
   ,@act INT
   ,@exp INT;

   -- strategy:
   --    try the 3 valid strings
   --    try invalid string, empty string null string

   EXEC sp_log 2, @fn,'starting';
   -- Green tests
   EXEC test.hlpr_002_fnGetImportIdFromName '221018', 1;
   EXEC test.hlpr_002_fnGetImportIdFromName 'D:\Dev\Repos\Farming_Dev\Data\LRAP-96221008 Import\LRAP-221018.txt', 1;
   EXEC test.hlpr_002_fnGetImportIdFromName '230721', 2;
   EXEC test.hlpr_002_fnGetImportIdFromName 'D:\Dev\Repos\Farming_Dev\Data\221018 Import\LRAP-230721.tsv'       , 2;
   EXEC test.hlpr_002_fnGetImportIdFromName '231025', 3;
   EXEC test.hlpr_002_fnGetImportIdFromName 'D:\Dev\Repos\Farming_Dev\Data\LRAP-96221008 Import\LRAP-231025'    , 3;

   -- import an null filepath
   EXEC test.hlpr_002_fnGetImportIdFromName NULL    , -1;
   -- import an empty filepath
   EXEC test.hlpr_002_fnGetImportIdFromName ''      , -1;
   -- import an filepath with an unhandled format
   EXEC test.hlpr_002_fnGetImportIdFromName '23102' , -1;
   EXEC test.hlpr_002_fnGetImportIdFromName '240215', -1;
   EXEC sp_log 2, @fn,'leaving, PASSED';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_002_fnGetImportIdFromName';
*/
GO
