SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================
-- Author:      Terry Watts
-- Create date: 12-OCT-2023
-- Description: Lists the table FKs for the @primary_table parameter
-- ====================================================================
CREATE FUNCTION [dbo].[fnListFKeysForPrimaryTable](@primary_table nvarchar(4000))
RETURNS table
AS
   RETURN
      SELECT * FROM dbo.fnListFkeys(NULL, NULL) WHERE primary_tbl_nm = @primary_table;

/*
SELECT * FROM dbo.fnListFKeysForPrimaryTable('Chemical')
*/
GO
