SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================
-- Author:      Terry Watts
-- Create date: 06-NOV-2023
-- Description: Tests the fnGetImportFormatIdFromName() routine
-- ==============================================================
CREATE PROCEDURE [test].[test_003_fnGetImportFormatIdFromName]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE @act INT
   ,@exp INT;
   -- strategy: 
   --    try the 3 valid strings
   --    try invalid string, empty string null string

   -- Green tests
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '221018', 1;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName 'D:\Dev\Repos\Farming_Dev\Data\LRAP-96221008 Import\LRAP-221018.txt', 1;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '230721', 2;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName 'D:\Dev\Repos\Farming_Dev\Data\LRAP-96221008 Import\LRAP-230721.tsv', 2;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '231025', 2;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName 'D:\Dev\Repos\Farming_Dev\Data\LRAP-96221008 Import\LRAP-231025', 2;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName 'asdf221018zyz', 1;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '230721zyz'    , 2;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '231025zyz'    , 2;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '230722zyz'    ,-1;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '23072zyz'     ,-1;

   -- import an null filepath
   EXEC test.hlpr_003_fnGetImportFormatIdFromName NULL, -1;
   -- import an empty filepath
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '', -1;
   -- import an filepath with an unhandled format
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '23102', -1;
   EXEC test.hlpr_003_fnGetImportFormatIdFromName '240215', -1;
END

/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_003_fnGetImportFormatIdFromName';
PRINT dbo.fnGetImportFormatIdFromName('asdf221008zyz'); -- should be  1
PRINT dbo.fnGetImportFormatIdFromName('230721zyz');     -- should be  2
PRINT dbo.fnGetImportFormatIdFromName('231025zyz');     -- should be  2
PRINT dbo.fnGetImportFormatIdFromName('230722zyz');     -- should be -1
PRINT dbo.fnGetImportFormatIdFromName('23072zyz');      -- should be -1
*/
GO
