SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[AssertResultSetsHaveSameMetaData]
	@expectedCommand [nvarchar](max),
	@actualCommand [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[AssertResultSetsHaveSameMetaData]
GO
