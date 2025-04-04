SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================
-- Author:      Terry Watts
-- Create date: 24-NOV-2023
--
-- Description: removes square brackets from string
-- in any position in the string
--
-- PRECONDITIONS:
--    none
--
-- POSTCONDITIONS:
--    [ ] brackets removed
--
-- Tests:
-- =============================================
CREATE FUNCTION [dbo].[fnDeSquareBracket](@s NVARCHAR(4000))
RETURNS NVARCHAR(4000)
AS
BEGIN
   RETURN REPLACE(REPLACE(@s, '[', ''), ']', '');
END
/*
   EXEC test.sp_crt_tst_rtns 'dbo.fnDeSquareBracket', 69
*/
GO
