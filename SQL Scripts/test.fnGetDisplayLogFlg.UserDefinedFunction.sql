SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================
-- Author:      Terry
-- Create date: 06-FEB-2021
-- Description: Gets the display log flag
-- Tests: [test].[test 030 chkTestConfig]
-- ===============================================================
CREATE FUNCTION [test].[fnGetDisplayLogFlg]()
RETURNS BIT
AS
BEGIN
   RETURN CONVERT(BIT, SESSION_CONTEXT(test.fnGetDisplayLogFlgKey()));
END
/*
EXEC test.[test 030 chkTestConfig]
EXEC tSQLt.Run 'test.test 030 chkTestConfig'
EXEC tSQLt.RunAll
*/
GO
