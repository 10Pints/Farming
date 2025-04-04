SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================================================================
-- Author:      Terry Watts
-- Create date: 29-MAR-2024
-- Description: returns the import root
--
-- Tests:
--
-- Changes:
-- ===========================================================================================================
CREATE FUNCTION [dbo].[fnGetImportRoot]()
RETURNS NVARCHAR(500)
AS
BEGIN
   RETURN ut.dbo.fnGetSessionContextAsString(dbo.fnGetSessionKeyImportRoot());
END
/*
EXEC tSQLt.RunAll;
*/
GO
