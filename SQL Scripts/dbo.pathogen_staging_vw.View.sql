SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ======================================================================================================
-- Author:		 Terry Watts
-- Create date: 29-JUL-2023
-- Description: splits the individual pathogen out of the pathogens column in Staging2 
--
-- PRECONDITIONS: 
-- Dependencies: Staging2 table
-- ======================================================================================================
CREATE VIEW [dbo].[pathogen_staging_vw]
AS
SELECT TOP 100000 stg2_id, cs.value AS pathogen_nm FROM staging2 
CROSS APPLY STRING_SPLIT(pathogens, ',') cs 
WHERE cs.value NOT IN ('')
ORDER BY stg2_id, cs.value
;

/*
SELECT TOP 50 * FROM pathogen_staging_vw;
*/
GO
