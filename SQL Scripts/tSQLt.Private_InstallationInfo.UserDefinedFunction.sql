SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_InstallationInfo]() RETURNS TABLE AS RETURN SELECT CAST(16.00 AS NUMERIC(10,2)) AS SqlVersion;
GO
