SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_LRAP_221018_240326](
	[stg2_id] [int] NOT NULL,
	[company] [nvarchar](70) NULL,
	[ingredient] [nvarchar](150) NULL,
	[product] [nvarchar](100) NULL,
	[concentration] [nvarchar](35) NULL,
	[formulation_type] [nvarchar](10) NULL,
	[uses] [nvarchar](100) NULL,
	[toxicity_category] [int] NULL,
	[registration] [nvarchar](65) NULL,
	[expiry] [nvarchar](30) NULL,
	[entry_mode] [nvarchar](60) NULL,
	[crops] [nvarchar](65) NULL,
	[pathogens] [nvarchar](360) NULL,
	[rate] [nvarchar](200) NULL,
	[mrl] [nvarchar](200) NULL,
	[phi] [nvarchar](200) NULL,
	[phi_resolved] [nvarchar](120) NULL,
	[reentry_period] [nvarchar](250) NULL,
	[notes] [nvarchar](250) NULL,
	[comment] [nvarchar](500) NULL,
	[import_nm] [nvarchar](20) NULL,
	[import_id] [int] NULL,
	[created] [datetime] NULL
) ON [PRIMARY]
GO
