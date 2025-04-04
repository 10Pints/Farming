SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Convert_Base2ToBase10](@Base2Value [nvarchar](64))
RETURNS [bigint] WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[CONVERT].[Base2ToBase10]
GO
