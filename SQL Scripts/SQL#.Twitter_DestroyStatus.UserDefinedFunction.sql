SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Twitter_DestroyStatus](@ConsumerKey [nvarchar](100), @ConsumerSecret [nvarchar](100), @AccessToken [nvarchar](100), @AccessTokenSecret [nvarchar](100), @StatusID [bigint])
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Twitterizer].[TWITTER].[DestroyStatus]
GO
