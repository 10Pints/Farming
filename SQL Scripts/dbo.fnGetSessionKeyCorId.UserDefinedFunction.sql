SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================================
-- Author:		 Terry Watts
-- Create date: 19-AUG-2023
-- Description: returns the cor_id key used in the Staging2 update trigger
--    to determine if need a new entry in the correction log
-- ==============================================================================
CREATE FUNCTION [dbo].[fnGetSessionKeyCorId] ()
RETURNS NVARCHAR(30)
AS
BEGIN
	RETURN N'cor_id';
END
GO
