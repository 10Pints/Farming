SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[OS_EventLogRead](@LogName [nvarchar](4000), @MachineName [nvarchar](4000), @Source [nvarchar](4000), @EntryType [nvarchar](4000), @InstanceID [nvarchar](4000), @Category [nvarchar](4000), @UserName [nvarchar](4000), @Message [nvarchar](4000), @TimeGeneratedBegin [datetime], @TimeGeneratedEnd [datetime], @IndexBegin [int], @IndexEnd [int], @RegExOptionsList [nvarchar](4000))
RETURNS  TABLE (
	[Index] [int] NULL,
	[Category] [nvarchar](500) NULL,
	[EntryType] [nvarchar](50) NULL,
	[InstanceId] [bigint] NULL,
	[Source] [nvarchar](500) NULL,
	[TimeGenerated] [datetime] NULL,
	[TimeWritten] [datetime] NULL,
	[UserName] [nvarchar](100) NULL,
	[Message] [nvarchar](max) NULL,
	[Data] [varbinary](max) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.OS].[OS].[EventLogRead]
GO
