SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_Format](@TheDate [datetime], @DateTimeFormat [nvarchar](4000), @Culture [nvarchar](10))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[DATE].[Format]
GO
