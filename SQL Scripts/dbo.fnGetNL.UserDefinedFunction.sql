SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Terry Watts
-- Create date: 15-JAN-2020
-- Description: returns standard NL char(s)
-- =============================================
CREATE FUNCTION [dbo].[fnGetNL]()
RETURNS NVARCHAR(2)
AS
BEGIN
   RETURN NCHAR(13)+NCHAR(10)
END
GO
