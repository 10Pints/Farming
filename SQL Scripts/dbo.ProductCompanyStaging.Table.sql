SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCompanyStaging](
	[product_nm] [nvarchar](50) NOT NULL,
	[company_nm] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_ProductCompanyStaging] PRIMARY KEY CLUSTERED 
(
	[product_nm] ASC,
	[company_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
