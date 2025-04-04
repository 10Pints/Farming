SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================================
-- Author:		 Terry Watts
-- Create date: 09-NOV-2023
-- Description: generic clean up rtn for tests to clean up instead of using transactions
-- =======================================================================================
CREATE PROCEDURE [test].[cleanup_test_no_transaction] 
AS
BEGIN
	SET NOCOUNT ON;
   DECLARE
       @fn                 NVARCHAR(35)   = N'TST_CLEANUP_NO_TXN'
   EXEC sp_log 1, @fn, 'called';
END
GO
