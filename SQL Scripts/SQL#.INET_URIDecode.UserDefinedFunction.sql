SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[INET_URIDecode](@EncodedURI [nvarchar](4000))
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#.Network].[INET].[URIDecode]
GO
