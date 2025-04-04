SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportCorrections](
	[id] [int] NOT NULL,
	[command] [nvarchar](50) NULL,
	[search_clause] [nvarchar](max) NULL,
	[not_clause] [nvarchar](500) NULL,
	[replace_clause] [nvarchar](500) NULL,
	[case_sensitive] [bit] NULL,
	[latin_name] [nvarchar](65) NULL,
	[common_name] [nvarchar](25) NULL,
	[local_name] [nvarchar](25) NULL,
	[alt_names] [nvarchar](100) NULL,
	[note_clause] [nvarchar](max) NULL,
	[crops] [nvarchar](150) NULL,
	[doit] [nvarchar](20) NULL,
	[must_update] [bit] NULL,
	[comments] [nvarchar](max) NULL,
	[exp_cnt] [int] NULL,
	[act_cnt] [int] NULL,
	[results] [nvarchar](100) NULL,
	[chk] [nvarchar](max) NULL,
	[created] [datetime] NULL,
	[updated] [datetime] NULL,
 CONSTRAINT [PK_ImportCorrections] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
