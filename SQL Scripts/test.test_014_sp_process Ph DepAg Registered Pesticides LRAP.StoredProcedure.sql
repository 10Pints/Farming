SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================================================
-- Author:		 Terry Watts
-- Create date: 18-JUN-2023
-- Description: Tests the importer for [dbo].[sp_bulk_insert_Ph DepAg Registered Pesticides LRAP]
-- ================================================================================================
CREATE PROCEDURE [test].[test_014_sp_process Ph DepAg Registered Pesticides LRAP]
AS
BEGIN
	SET NOCOUNT ON;
   /* 231103: taken out of the tests for now
   DECLARE
    @cnt INT
   ,@exp INT;

   -- Strategy: clean import 100 page file
   TRUNCATE TABLE dbo.AgriChemicals;
   -- Import 100 pages raw
   EXEC [dbo].[sp_bulk_insert_Ph DepAg Registered Pesticides LRAP] 'D:\Data\Biz\Banana Farming_Dev\Tests\Ph DepAg Registered Pesticides LRAP-221018 001-099.tsv';

   -- Chk the rows imported ok
   SELECT  @cnt = count(*) FROM dbo.[temp];
   EXEC tSQLt.AssertEquals 2764, @cnt, 'Import error: Row count mismatch';

   -- Run the tested routine
   EXEC [dbo].[sp_process Ph DepAg Registered Pesticides LRAP]; 

   SELECT * FROM dbo.[temp];
   SELECT  @cnt = count(*) FROM dbo.[temp];
   PRINT CONCAT('Imported ', @cnt, ' rows');

   EXEC tSQLt.AssertEquals 2666, @cnt, 'Process error: Row count mismatch';
   */
END
GO
