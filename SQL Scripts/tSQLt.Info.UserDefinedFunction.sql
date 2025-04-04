SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Info]()
RETURNS TABLE
AS
RETURN
SELECT Version = '1.0.7950.1808',
       ClrVersion = (SELECT tSQLt.Private::Info()),
       ClrSigningKey = (SELECT tSQLt.Private::SigningKey()),
       InstalledOnSqlVersion = (SELECT SqlVersion FROM tSQLt.Private_InstallationInfo()),
       V.SqlVersion,
       V.SqlBuild,
       V.SqlEdition,
       V.HostPlatform
  FROM
  (
    SELECT CAST(PSSV.Major+'.'+PSSV.Minor AS NUMERIC(10,2)) AS SqlVersion,
           CAST(PSSV.Build+'.'+PSSV.Revision AS NUMERIC(10,2)) AS SqlBuild,
           PSV.Edition AS SqlEdition,
           PHP.host_platform AS HostPlatform
          FROM tSQLt.Private_SqlVersion() AS PSV
         CROSS APPLY tSQLt.Private_SplitSqlVersion(PSV.ProductVersion) AS PSSV
         CROSS JOIN tSQLt.Private_HostPlatform AS PHP
  )V;
GO
