SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CorrectionLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[stg_id] [int] NULL,
	[cor_id] [int] NULL,
	[old] [nvarchar](250) NULL,
	[new] [nvarchar](250) NULL,
	[search_clause] [nvarchar](250) NULL,
	[replace_clause] [nvarchar](150) NULL,
	[not_clause] [nvarchar](150) NULL,
	[row_cnt] [int] NULL,
 CONSTRAINT [PK_CorrectionLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
