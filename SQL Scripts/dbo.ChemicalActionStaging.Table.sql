SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChemicalActionStaging](
	[chemical_nm] [nvarchar](100) NOT NULL,
	[action_nm] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_ChemicalActionStaging] PRIMARY KEY CLUSTERED 
(
	[chemical_nm] ASC,
	[action_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChemicalActionStaging]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalActionStaging_ActionStaging] FOREIGN KEY([action_nm])
REFERENCES [dbo].[ActionStaging] ([action_nm])
GO
ALTER TABLE [dbo].[ChemicalActionStaging] CHECK CONSTRAINT [FK_ChemicalActionStaging_ActionStaging]
GO
ALTER TABLE [dbo].[ChemicalActionStaging]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalActionStaging_ChemicalStaging] FOREIGN KEY([chemical_nm])
REFERENCES [dbo].[ChemicalStaging] ([chemical_nm])
GO
ALTER TABLE [dbo].[ChemicalActionStaging] CHECK CONSTRAINT [FK_ChemicalActionStaging_ChemicalStaging]
GO
