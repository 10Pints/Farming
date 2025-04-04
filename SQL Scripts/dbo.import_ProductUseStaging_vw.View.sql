SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================================
-- Author:      Terry Watts
-- Create date: 07-OCT-2023
-- Description: lists the products and their associated uses from the main tables
-- ==================================================================================
CREATE VIEW [dbo].[import_ProductUseStaging_vw]
AS
SELECT product_nm, use_nm
FROM ProductUseStaging;
/*
SELECT * FROM import_ProductUseStaging_vw;
*/
GO
