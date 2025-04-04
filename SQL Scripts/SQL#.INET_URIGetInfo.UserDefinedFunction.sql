SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[INET_URIGetInfo](@URI [nvarchar](4000))
RETURNS  TABLE (
	[AbsolutePath] [nvarchar](4000) NULL,
	[AbsoluteUri] [nvarchar](4000) NULL,
	[Authority] [nvarchar](4000) NULL,
	[DnsSafeHost] [nvarchar](4000) NULL,
	[Fragment] [nvarchar](4000) NULL,
	[HashCode] [int] NULL,
	[Host] [nvarchar](4000) NULL,
	[HostNameType] [nvarchar](50) NULL,
	[IsAbsoluteUri] [bit] NULL,
	[IsDefaultPort] [bit] NULL,
	[IsFile] [bit] NULL,
	[IsLoopback] [bit] NULL,
	[IsUnc] [bit] NULL,
	[IsWellFormedOriginalString] [bit] NULL,
	[LocalPath] [nvarchar](4000) NULL,
	[PathAndQuery] [nvarchar](4000) NULL,
	[Port] [int] NULL,
	[Query] [nvarchar](4000) NULL,
	[Scheme] [nvarchar](50) NULL,
	[UserEscaped] [bit] NULL,
	[UserInfo] [nvarchar](4000) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Network].[INET].[URIGetInfo]
GO
