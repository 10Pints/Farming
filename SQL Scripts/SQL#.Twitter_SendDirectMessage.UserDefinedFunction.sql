SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Twitter_SendDirectMessage](@ConsumerKey [nvarchar](100), @ConsumerSecret [nvarchar](100), @AccessToken [nvarchar](100), @AccessTokenSecret [nvarchar](100), @Message [nvarchar](4000), @Recipient [nvarchar](20))
RETURNS [bigint] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Twitterizer].[TWITTER].[SendDirectMessage]
GO
