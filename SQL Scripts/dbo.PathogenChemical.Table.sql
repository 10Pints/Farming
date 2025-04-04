SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PathogenChemical](
	[pathogen_id] [int] NOT NULL,
	[chemical_id] [int] NOT NULL,
	[pathogenType_id] [int] NOT NULL,
	[pathogen_nm] [nvarchar](100) NULL,
	[chemical_nm] [nvarchar](50) NULL,
	[created] [datetime] NOT NULL,
 CONSTRAINT [PK_PathogenChemical] PRIMARY KEY CLUSTERED 
(
	[pathogen_id] ASC,
	[chemical_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PathogenChemical_chemical] ON [dbo].[PathogenChemical]
(
	[chemical_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PathogenChemical_pathogen] ON [dbo].[PathogenChemical]
(
	[pathogen_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_PathogenChemical] ON [dbo].[PathogenChemical]
(
	[pathogen_id] ASC,
	[chemical_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PathogenChemical] ADD  CONSTRAINT [DF_PathogenChemical_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[PathogenChemical]  WITH CHECK ADD  CONSTRAINT [FK_PathogenChemical_Chemical] FOREIGN KEY([chemical_id])
REFERENCES [dbo].[Chemical] ([chemical_id])
GO
ALTER TABLE [dbo].[PathogenChemical] CHECK CONSTRAINT [FK_PathogenChemical_Chemical]
GO
ALTER TABLE [dbo].[PathogenChemical]  WITH CHECK ADD  CONSTRAINT [FK_PathogenChemical_Pathogen] FOREIGN KEY([pathogen_id])
REFERENCES [dbo].[Pathogen] ([pathogen_id])
GO
ALTER TABLE [dbo].[PathogenChemical] CHECK CONSTRAINT [FK_PathogenChemical_Pathogen]
GO
ALTER TABLE [dbo].[PathogenChemical]  WITH CHECK ADD  CONSTRAINT [FK_PathogenChemical_type] FOREIGN KEY([pathogenType_id])
REFERENCES [dbo].[PathogenType] ([pathogenType_id])
GO
ALTER TABLE [dbo].[PathogenChemical] CHECK CONSTRAINT [FK_PathogenChemical_type]
GO
