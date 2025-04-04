SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [SQL#].[DB_BulkCopy]
	@SourceType [nvarchar](4000) = N'',
	@SourceConnection [nvarchar](4000) = N'',
	@SourceQuery [nvarchar](4000),
	@DestinationConnection [nvarchar](4000) = N'',
	@DestinationTableName [nvarchar](4000),
	@BatchSize [int] = 0,
	@NotifyAfterRows [int] = 0,
	@TimeOut [int] = 30,
	@ColumnMappings [nvarchar](4000) = N'',
	@BulkCopyOptionsList [nvarchar](4000) = N'',
	@SourceCommandTimeout [int] = 30,
	@RowsCopied [bigint] = -1 OUTPUT
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [SQL#.DB].[DB].[BulkCopy]
GO
