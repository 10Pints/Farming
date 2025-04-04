SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================================
-- Author:		 Terry Watts
-- Create date: 27-JUN-20223
-- Description: used for teh bulk import of 221008 fmt imports
-- =============================================================
CREATE VIEW [dbo].[RegisteredPesticideImport_221018_vw]
AS
SELECT 
       stg1_id
      ,company
      ,ingredient
      ,product
      ,concentration
      ,formulation_type
      ,[uses]
      ,toxicity_category
      ,registration
      ,expiry
      ,entry_mode
      ,crops
      ,pathogens
      ,import_nm
  FROM [dbo].[staging1];

/*
SELECT TOP 50 * FROM RegisteredPesticideImport_221018_vw;
*/
GO
