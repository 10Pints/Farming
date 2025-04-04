SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================
-- Author:       Terry Watts
-- Create Date: 25-AUG-2023
-- Description: gets the pathogens related to the chemicals for each 
-- =================================================================
CREATE VIEW [dbo].[pathogen_chemical_staging_vw]
AS
SELECT DISTINCT TOP 100000
    p.pathogen_nm
   ,ch.chemical_nm
FROM 
          Staging2 s 
LEFT JOIN Ingredient_staging_vw  i  ON s.stg2_id   = i.stg2_id
LEFT JOIN Pathogen_staging_vw    pv ON pv.stg2_id  = s.stg2_id
LEFT join PathogenStaging        p  ON p.pathogen_nm = pv.pathogen_nm
LEFT join ChemicalStaging        ch ON ch.chemical_nm= i.chemical_nm
ORDER BY pathogen_nm, chemical_nm--, stg2_id;
/*
SELECT TOP 1000 * FROM pathogen_chemical_staging_vw
SELECT * FROM dbo.fnListPathogens()
*/
GO
