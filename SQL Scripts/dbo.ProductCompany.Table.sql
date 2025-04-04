SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCompany](
	[product_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[product_nm] [nvarchar](50) NULL,
	[company_nm] [nvarchar](60) NULL,
 CONSTRAINT [PK_ProductCompany] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductCompany]  WITH CHECK ADD  CONSTRAINT [FK_ProductCompany_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[Company] ([company_id])
GO
ALTER TABLE [dbo].[ProductCompany] CHECK CONSTRAINT [FK_ProductCompany_company]
GO
ALTER TABLE [dbo].[ProductCompany]  WITH CHECK ADD  CONSTRAINT [FK_ProductCompany_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[ProductCompany] CHECK CONSTRAINT [FK_ProductCompany_product]
GO
