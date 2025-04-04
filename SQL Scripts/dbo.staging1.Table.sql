SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging1](
	[stg1_id] [int] NOT NULL,
	[company] [nvarchar](500) NULL,
	[ingredient] [nvarchar](500) NULL,
	[product] [nvarchar](200) NULL,
	[concentration] [nvarchar](200) NULL,
	[formulation_type] [nvarchar](200) NULL,
	[uses] [nvarchar](200) NULL,
	[toxicity_category] [nvarchar](200) NULL,
	[registration] [nvarchar](100) NULL,
	[expiry] [nvarchar](200) NULL,
	[entry_mode] [nvarchar](200) NULL,
	[crops] [nvarchar](500) NULL,
	[pathogens] [nvarchar](1000) NULL,
	[rate] [nvarchar](200) NULL,
	[mrl] [nvarchar](200) NULL,
	[phi] [nvarchar](200) NULL,
	[reentry_period] [nvarchar](250) NULL,
	[notes] [nvarchar](250) NULL,
	[created] [datetime] NULL,
 CONSTRAINT [PK_staging1] PRIMARY KEY CLUSTERED 
(
	[stg1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
