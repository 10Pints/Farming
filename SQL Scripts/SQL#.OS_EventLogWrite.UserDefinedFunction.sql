SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[OS_EventLogWrite](@LogName [nvarchar](4000), @MachineName [nvarchar](4000), @Source [nvarchar](4000), @EntryType [nvarchar](4000), @InstanceID [int], @Category [smallint], @Message [nvarchar](max), @BinaryData [varbinary](8000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.OS].[OS].[EventLogWrite]
GO
