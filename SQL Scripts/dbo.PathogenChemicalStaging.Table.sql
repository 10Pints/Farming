SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PathogenChemicalStaging](
	[pathogen_nm] [nvarchar](100) NOT NULL,
	[chemical_nm] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_PathogenChemicalStaging] PRIMARY KEY CLUSTERED 
(
	[pathogen_nm] ASC,
	[chemical_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_PathogenChemicalStaging_chemical_nm] ON [dbo].[PathogenChemicalStaging]
(
	[chemical_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [UQ_PathogenChemicalStaging] ON [dbo].[PathogenChemicalStaging]
(
	[pathogen_nm],
	[chemical_nm]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PathogenChemicalStaging]  WITH CHECK ADD  CONSTRAINT [FK_PathogenChemicalStaging_ChemicalStaging] FOREIGN KEY([chemical_nm])
REFERENCES [dbo].[ChemicalStaging] ([chemical_nm])
GO
ALTER TABLE [dbo].[PathogenChemicalStaging] CHECK CONSTRAINT [FK_PathogenChemicalStaging_ChemicalStaging]
GO
