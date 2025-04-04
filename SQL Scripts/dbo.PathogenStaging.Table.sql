SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PathogenStaging](
	[pathogen_nm] [nvarchar](100) NOT NULL,
	[pathogenType_nm] [nvarchar](50) NULL,
 CONSTRAINT [PK_PathogenStaging] PRIMARY KEY CLUSTERED 
(
	[pathogen_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PathogenStaging]  WITH CHECK ADD  CONSTRAINT [FK_PathogenStaging_PathogenTypeStaging] FOREIGN KEY([pathogenType_nm])
REFERENCES [dbo].[PathogenTypeStaging] ([pathogenType_nm])
GO
ALTER TABLE [dbo].[PathogenStaging] CHECK CONSTRAINT [FK_PathogenStaging_PathogenTypeStaging]
GO
