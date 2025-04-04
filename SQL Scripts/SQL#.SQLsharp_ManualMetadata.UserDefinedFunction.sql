SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[SQLsharp_ManualMetadata]()
RETURNS  TABLE (
	[Key] [nvarchar](50) NULL,
	[Value] [sql_variant] NULL,
	[Datatype] [nvarchar](50) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[SQLsharp].[ManualMetadata]
GO
