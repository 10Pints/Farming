SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CropPathogenStaging](
	[crop_nm] [nvarchar](100) NOT NULL,
	[pathogen_nm] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CropPathogenStaging] ON [dbo].[CropPathogenStaging]
(
	[crop_nm] ASC,
	[pathogen_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CropPathogenStaging]  WITH CHECK ADD  CONSTRAINT [FK_CropPathogenStaging_CropStaging] FOREIGN KEY([crop_nm])
REFERENCES [dbo].[CropStaging] ([crop_nm])
GO
ALTER TABLE [dbo].[CropPathogenStaging] CHECK CONSTRAINT [FK_CropPathogenStaging_CropStaging]
GO
