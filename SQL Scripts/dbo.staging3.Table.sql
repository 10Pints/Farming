SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging3](
	[stg_id] [int] NOT NULL,
	[company] [nvarchar](max) NULL,
	[ingredient] [nvarchar](max) NULL,
	[product] [nvarchar](max) NULL,
	[concentration] [nvarchar](max) NULL,
	[formulation_type] [nvarchar](50) NULL,
	[uses] [nvarchar](max) NULL,
	[toxicity_category] [nvarchar](50) NULL,
	[registration] [nvarchar](100) NULL,
	[expiry] [nvarchar](100) NULL,
	[entry_mode] [nvarchar](60) NULL,
	[crops] [nvarchar](max) NULL,
	[pathogens] [nvarchar](max) NULL,
	[rate] [nvarchar](200) NULL,
	[mrl] [nvarchar](200) NULL,
	[phi] [nvarchar](200) NULL,
	[phi_resolved] [nvarchar](120) NULL,
	[reentry_period] [nvarchar](250) NULL,
	[notes] [nvarchar](max) NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_staging3] PRIMARY KEY CLUSTERED 
(
	[stg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'resolved to days' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'staging3', @level2type=N'COLUMN',@level2name=N'phi_resolved'
GO
