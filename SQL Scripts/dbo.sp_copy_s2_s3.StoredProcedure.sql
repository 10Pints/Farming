SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================================
-- Author:      Terry Watts
-- Create date: 09-JUL-2023
-- Description: Caches a copy of Staging2 to Staging3 
--    Do after any stage once S2 is populated
--
-- CHANGES:
-- 231103: turned auto increment off so SET IDENTITY_INSERT ON/OFF not needed
-- ==============================================================================
CREATE PROCEDURE [dbo].[sp_copy_s2_s3]
AS
BEGIN
   DECLARE
       @fn           NVARCHAR(35)  = N'CPY_S2_S3'

   SET NOCOUNT OFF;
   EXEC sp_log 2, @fn,'00: Caching COPYING staging2 to staging3 (backup) starting';

   TRUNCATE TABLE Staging3;

   INSERT INTO dbo.Staging3
   (
       stg_id
      ,company
      ,ingredient
      ,product
      ,concentration
      ,formulation_type
      ,uses
      ,toxicity_category
      ,registration
      ,expiry
      ,entry_mode
      ,crops
      ,pathogens
      ,rate
      ,mrl
      ,phi
      ,phi_resolved
      ,reentry_period
      ,notes
      ,comment
   )
   SELECT 
       stg2_id
      ,company
      ,ingredient
      ,product
      ,concentration
      ,formulation_type
      ,uses
      ,toxicity_category
      ,registration
      ,expiry
      ,entry_mode
      ,crops
      ,pathogens
      ,rate
      ,mrl
      ,phi
      ,phi_resolved
      ,reentry_period
      ,notes
      ,Comment
     FROM Staging2;

   EXEC sp_log 2, @fn,'99: leaving: OK';
END
/*
EXEC sp_copy_s2_s3
*/
GO
