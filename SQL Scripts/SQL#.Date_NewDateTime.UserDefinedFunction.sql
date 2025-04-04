SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Date_NewDateTime](@Year [int], @Month [int], @Day [int], @Hour [int], @Minute [int], @Second [int], @Millisecond [int])
RETURNS [datetime] WITH EXECUTE AS CALLER, RETURNS NULL ON NULL INPUT
AS 
EXTERNAL NAME [SQL#].[DATE].[NewDateTime]
GO
