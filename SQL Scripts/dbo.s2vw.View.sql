SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===================================================
-- Author:		 Terry Watts
-- Create date: 07-JUL-20223
-- Description: List the id,  Pathogens in id order 
-- ===================================================
CREATE  VIEW [dbo].[s2vw] 
AS
   SELECT stg2_id, pathogens
   FROM Staging2 

/*
SELECT TOP  50 * FROM s2vw;
*/
GO
