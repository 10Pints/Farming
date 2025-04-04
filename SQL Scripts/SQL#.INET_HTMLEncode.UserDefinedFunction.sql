SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[INET_HTMLEncode](@DecodedHTML [nvarchar](max), @WhiteSpaceHandling [nvarchar](4000), @ContinuousEncoding [bit])
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Network].[INET].[HTMLEncode]
GO
