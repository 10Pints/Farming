SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[INET_AddressToNumber](@IPAddress [nvarchar](4000))
RETURNS [bigint] WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#.Network].[INET].[AddressToNumber]
GO
