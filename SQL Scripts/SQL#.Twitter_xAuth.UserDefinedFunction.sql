SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Twitter_xAuth](@ConsumerKey [nvarchar](100), @ConsumerSecret [nvarchar](100), @UserName [nvarchar](100), @Password [nvarchar](100))
RETURNS  TABLE (
	[AccessToken] [nvarchar](100) NULL,
	[AccessTokenSecret] [nvarchar](100) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Twitterizer].[TWITTER].[xAuth]
GO
