SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:      Terry Watts
-- Create date: 19-JUN-2023
-- Description: imports all the Pesticide Register files
-- 
-- PRECONDITIONS: none
--
-- POSTCONDITIONS:
--    Ready to call the fixup routne
--
-- ERROR HANDLING by exception handling
-- ========================================================
CREATE PROCEDURE [dbo].[sp_import_pesticide_register_221008]
AS
BEGIN
   DECLARE
        @fn          NVARCHAR(35)  = N'BLK_IMPRT_PEST_REG_221008'
       ,@cnt         INT
       ,@rc          INT
       ,@result_msg  NVARCHAR(500)
       ,@import_root NVARCHAR(500)

   exec sp_log 2, @fn, '01 starting';
   EXEC sp_register_call @fn;
   SET @result_msg = '';
   SET @import_root = CONCAT(ut.dbo.fnGetImportRoot(), 'Exports Ph DepAg Registered Pesticides LRAP-221018.pdf\TSVs', NCHAR(92));

   TRUNCATE TABLE dbo.staging1;
   TRUNCATE TABLE dbo.staging2;

   -- Import all files
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 001-099.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 100-199.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 200-299.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 300-399.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 400-499.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 500-599.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 600-699.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 700-799.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;
   EXEC @rc = [dbo].sp_bulk_insert_pesticide_register_221018  'Ph DepAg Registered Pesticides LRAP-221018 800-819.tsv'; IF @RC <> 0 THROW 60000, '[sp_bulk_insert_pesticide_register]: unhandled error', 1;

   SELECT @cnt = count(*) from dbo.staging1;
   PRINT CONCAT('Imported ', @cnt, ' including header rows'); -- 23524 rows currently 20-JUN-2023
   exec sp_log 2, @fn, '99 leaving, ret: ', @rc;
   RETURN @RC;
END

/*
EXEC dbo.[sp_import_Ph DepAg Registered Pesticides LRAP];
SELECT COUNT(*) FROM TEMP WHERE SHT <101
SELECT book, COUNT(*) FROM TEMP GROUP BY book order by book
*/

GO
