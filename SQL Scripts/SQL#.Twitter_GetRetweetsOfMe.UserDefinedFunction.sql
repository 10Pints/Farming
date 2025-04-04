SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Twitter_GetRetweetsOfMe](@ConsumerKey [nvarchar](100), @ConsumerSecret [nvarchar](100), @AccessToken [nvarchar](100), @AccessTokenSecret [nvarchar](100), @OptionalParameters [SQL#].[Type_HashTable])
RETURNS  TABLE (
	[StatusID] [bigint] NULL,
	[Created] [datetime] NULL,
	[InReplyToStatusID] [bigint] NULL,
	[InReplyToUserID] [bigint] NULL,
	[IsFavorited] [bit] NULL,
	[IsTruncated] [bit] NULL,
	[Source] [nvarchar](200) NULL,
	[StatusText] [nvarchar](4000) NULL,
	[RecipientID] [bigint] NULL,
	[TimeZone] [nvarchar](100) NULL,
	[ScreenName] [nvarchar](100) NULL,
	[UserName] [nvarchar](100) NULL,
	[UserID] [bigint] NULL,
	[Location] [nvarchar](100) NULL,
	[PlaceID] [nvarchar](50) NULL,
	[PlaceName] [nvarchar](500) NULL,
	[PlaceFullName] [nvarchar](500) NULL,
	[PlaceType] [nvarchar](500) NULL,
	[PlaceCountry] [nvarchar](500) NULL,
	[PlaceLatitude] [float] NULL,
	[PlaceLongitude] [float] NULL,
	[RateLimit] [int] NULL,
	[RateLimitRemaining] [int] NULL,
	[RateLimitReset] [datetime] NULL,
	[PlaceCountryCode] [nvarchar](2) NULL,
	[PlaceAttributes] [xml] NULL,
	[PlaceBoundingBox] [xml] NULL,
	[PlaceURL] [nvarchar](4000) NULL,
	[FavoriteCount] [int] NULL,
	[FilterLevel] [nvarchar](50) NULL,
	[InReplyToScreenName] [nvarchar](100) NULL,
	[Language] [nvarchar](20) NULL,
	[PossiblySensitive] [bit] NULL,
	[QuotedStatusID] [bigint] NULL,
	[RetweetCount] [int] NULL,
	[Retweeted] [bit] NULL,
	[WithheldCopyright] [bit] NULL,
	[WithheldScope] [nvarchar](20) NULL,
	[WithheldInCountries] [nvarchar](4000) NULL,
	[Entities] [xml] NULL,
	[RateLimitResetLocalTime] [datetime] NULL,
	[StatusType] [nvarchar](20) NULL,
	[QuotedStatus] [xml] NULL,
	[QuotedStatusCreatedAt] [datetime] NULL,
	[QuotedStatusCreatedAtLocalTime] [datetime] NULL,
	[CreatedLocalTime] [datetime] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Twitterizer].[TWITTER].[GetRetweetsOfMe]
GO
