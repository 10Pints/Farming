SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[ResultSetFilter]
	@ResultsetNo [int],
	@Command [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[ResultSetFilter]
GO
