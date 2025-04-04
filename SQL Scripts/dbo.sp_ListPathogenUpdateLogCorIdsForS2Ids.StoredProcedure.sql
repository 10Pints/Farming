SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================================================
-- Author:      Terry Watts
-- Create date: 24-MAR-2024
-- Description: returns the cor ids that effected the changes in the pathogen import XL fixup
--
-- CHANGES:
-- ======================================================================================================
CREATE PROC [dbo].[sp_ListPathogenUpdateLogCorIdsForS2Ids]
   @s2_ids NVARCHAR(400) -- comma separated list o6 stg2_id
AS
BEGIN
   DECLARE @cmd NVARCHAR(2000)

   DROP TABLE IF EXISTS temp;

   IF @s2_ids IS NOT NULL
   BEGIN
      SET @cmd = CONCAT('SELECT * into temp FROM
(
SELECT s.fixup_id,row_cnt
FROM S2UpdateSummary s 
LEFT JOIN S2Updatelog L ON s.fixup_id=L.fixup_id
WHERE L.stg2_id IN (', ut.dbo.fnTrim2(SUBSTRING(@s2_ids,1,400), ','),') 
) AS X'
);

      PRINT @cmd;
      EXEC (@cmd);
      SELECT * FROM temp;
   END
   ELSE
      SELECT 'No changes found';

END
/*
EXEC sp_ListPathogenUpdateLogCorIdsForS2Ids '7976';
EXEC sp_ListPathogenUpdateLogCorIdsForS2Ids '7976,5053,7976';
*/
GO
