SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportCorrectionsStaging](
	[id] [int] NOT NULL,
	[id2] [int] IDENTITY(1,1) NOT NULL,
	[search_clause] [nvarchar](max) NULL,
	[search_clause_cont] [nvarchar](max) NULL,
	[case_sensitive] [nvarchar](max) NULL,
	[not_clause] [nvarchar](max) NULL,
	[replace_clause] [nvarchar](max) NULL,
	[latin_name] [nvarchar](65) NULL,
	[common_name] [nvarchar](25) NULL,
	[local_name] [nvarchar](25) NULL,
	[alt_names] [nvarchar](max) NULL,
	[note_clause] [nvarchar](max) NULL,
	[crops] [nvarchar](max) NULL,
	[sql] [nvarchar](max) NULL,
	[doit] [nvarchar](max) NULL,
	[command] [nvarchar](max) NULL,
	[must_update] [nvarchar](max) NULL,
	[field] [nvarchar](max) NULL,
	[table] [nvarchar](max) NULL,
	[comments] [nvarchar](max) NULL,
	[exp_cnt] [nvarchar](max) NULL,
	[chk] [nvarchar](max) NULL,
	[dummy] [nvarchar](max) NULL,
	[created] [datetime] NULL,
	[import_id] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImportCorrectionsStaging]  WITH CHECK ADD  CONSTRAINT [FK_ImportCorrectionsStaging_Import] FOREIGN KEY([import_id])
REFERENCES [dbo].[Import] ([import_id])
GO
ALTER TABLE [dbo].[ImportCorrectionsStaging] CHECK CONSTRAINT [FK_ImportCorrectionsStaging_Import]
GO
