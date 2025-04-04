SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Twitter_GetFollowers](@ConsumerKey [nvarchar](100), @ConsumerSecret [nvarchar](100), @AccessToken [nvarchar](100), @AccessTokenSecret [nvarchar](100), @OptionalParameters [SQL#].[Type_HashTable])
RETURNS  TABLE (
	[UserID] [bigint] NULL,
	[ScreenName] [nvarchar](100) NULL,
	[UserName] [nvarchar](100) NULL,
	[IsProtected] [bit] NULL,
	[IsVerified] [bit] NULL,
	[Description] [nvarchar](4000) NULL,
	[CreatedOn] [datetime] NULL,
	[Location] [nvarchar](500) NULL,
	[TimeZone] [nvarchar](100) NULL,
	[UTCOffset] [int] NULL,
	[ProfileImageUri] [nvarchar](2048) NULL,
	[ProfileUri] [nvarchar](2048) NULL,
	[FriendsCount] [int] NULL,
	[NumberOfFollowers] [int] NULL,
	[NumberOfStatuses] [int] NULL,
	[StatusText] [nvarchar](4000) NULL,
	[RateLimit] [int] NULL,
	[RateLimitRemaining] [int] NULL,
	[RateLimitReset] [datetime] NULL,
	[Language] [nvarchar](50) NULL,
	[NumberOfPublicListMemberships] [int] NULL,
	[IsGeoEnabled] [bit] NULL,
	[Following] [bit] NULL,
	[Muting] [bit] NULL,
	[ContributorsEnabled] [bit] NULL,
	[IsTranslator] [bit] NULL,
	[FollowRequestSent] [bit] NULL,
	[NumberOfFavorites] [int] NULL,
	[ProfileImageUriHttps] [nvarchar](2048) NULL,
	[ProfileBackgroundColor] [nvarchar](20) NULL,
	[ProfileTextColor] [nvarchar](20) NULL,
	[ProfileLinkColor] [nvarchar](20) NULL,
	[ProfileSidebarFillColor] [nvarchar](20) NULL,
	[ProfileSidebarBorderColor] [nvarchar](20) NULL,
	[ProfileBackgroundImageUri] [nvarchar](2048) NULL,
	[ProfileBackgroundImageUriHttps] [nvarchar](2048) NULL,
	[ProfileUseBackgroundImage] [bit] NULL,
	[ProfileBackgroundTile] [bit] NULL,
	[DefaultProfile] [bit] NULL,
	[DefaultProfileImage] [bit] NULL,
	[PreviousCursor] [nvarchar](50) NULL,
	[NextCursor] [nvarchar](50) NULL,
	[RateLimitResetLocalTime] [datetime] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#.Twitterizer].[TWITTER].[GetFollowers]
GO
