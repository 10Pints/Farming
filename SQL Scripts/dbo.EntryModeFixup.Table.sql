SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntryModeFixup](
	[id] [float] NULL,
	[routine] [nvarchar](255) NULL,
	[search_clause] [nvarchar](255) NULL,
	[clause_1] [nvarchar](255) NULL,
	[clause_2] [nvarchar](255) NULL,
	[clause_3] [nvarchar](255) NULL
) ON [PRIMARY]
GO
