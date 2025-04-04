SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChemicalProductStaging](
	[chemical_nm] [nvarchar](100) NOT NULL,
	[product_nm] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ChemicalProductStaging] PRIMARY KEY CLUSTERED 
(
	[chemical_nm] ASC,
	[product_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_ChemicalProductStaging] UNIQUE NONCLUSTERED 
(
	[chemical_nm] ASC,
	[product_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChemicalProductStaging]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalProductStaging_ChemicalStaging] FOREIGN KEY([chemical_nm])
REFERENCES [dbo].[ChemicalStaging] ([chemical_nm])
GO
ALTER TABLE [dbo].[ChemicalProductStaging] CHECK CONSTRAINT [FK_ChemicalProductStaging_ChemicalStaging]
GO
ALTER TABLE [dbo].[ChemicalProductStaging]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalProductStaging_ProductStaging] FOREIGN KEY([product_nm])
REFERENCES [dbo].[ProductStaging] ([product_nm])
GO
ALTER TABLE [dbo].[ChemicalProductStaging] CHECK CONSTRAINT [FK_ChemicalProductStaging_ProductStaging]
GO
