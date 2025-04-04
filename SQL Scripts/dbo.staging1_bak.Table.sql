SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging1_bak](
	[stg1_id] [int] NOT NULL,
	[company] [nvarchar](max) NULL,
	[ingredient] [nvarchar](max) NULL,
	[product] [nvarchar](max) NULL,
	[concentration] [nvarchar](max) NULL,
	[formulation_type] [nvarchar](max) NULL,
	[uses] [nvarchar](max) NULL,
	[toxicity_category] [nvarchar](max) NULL,
	[registration] [nvarchar](max) NULL,
	[expiry] [nvarchar](max) NULL,
	[entry_mode] [nvarchar](max) NULL,
	[crops] [nvarchar](max) NULL,
	[pathogens] [nvarchar](max) NULL,
	[rate] [nvarchar](200) NULL,
	[mrl] [nvarchar](200) NULL,
	[phi] [nvarchar](200) NULL,
	[reentry_period] [nvarchar](250) NULL,
	[notes] [nvarchar](250) NULL,
 CONSTRAINT [PK_staging1_bak] PRIMARY KEY CLUSTERED 
(
	[stg1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
