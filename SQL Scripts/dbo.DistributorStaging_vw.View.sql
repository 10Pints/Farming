SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==============================================================================
-- Author:      Terry Watts
-- Create date: 05-MAR-2024
-- Description: separates the manufacturers
--
-- CHANGES:
--
-- ==============================================================================
CREATE VIEW [dbo].[DistributorStaging_vw]
AS
SELECT distributor_name, value as manufacturer_name
FROM DistributorStaging CROSS APPLY string_split(manufacturers, ',');

/*
SELECT * FROM DistributorStaging_vw
*/
GO
