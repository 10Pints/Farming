SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChemicalUseStaging](
	[chemical_nm] [nvarchar](100) NOT NULL,
	[use_nm] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ChemicalUseStaging] PRIMARY KEY CLUSTERED 
(
	[chemical_nm] ASC,
	[use_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChemicalUseStaging]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalUseStaging_ChemicalStaging] FOREIGN KEY([chemical_nm])
REFERENCES [dbo].[ChemicalStaging] ([chemical_nm])
GO
ALTER TABLE [dbo].[ChemicalUseStaging] CHECK CONSTRAINT [FK_ChemicalUseStaging_ChemicalStaging]
GO
ALTER TABLE [dbo].[ChemicalUseStaging]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalUseStaging_UseStaging] FOREIGN KEY([use_nm])
REFERENCES [dbo].[UseStaging] ([use_nm])
GO
ALTER TABLE [dbo].[ChemicalUseStaging] CHECK CONSTRAINT [FK_ChemicalUseStaging_UseStaging]
GO
