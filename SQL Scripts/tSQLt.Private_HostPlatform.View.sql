SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [tSQLt].[Private_HostPlatform] AS SELECT host_platform FROM sys.dm_os_host_info;
GO
