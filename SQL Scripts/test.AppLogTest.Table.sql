SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [test].[AppLogTest](
	[id] [int] NOT NULL,
	[fn] [nvarchar](50) NULL,
	[level] [int] NULL,
	[row_count] [int] NULL,
	[order] [int] IDENTITY(1,1) NOT NULL,
	[msg] [nvarchar](max) NULL,
	[msg2] [nvarchar](max) NULL,
	[msg3] [nvarchar](max) NULL,
	[msg4] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppLogTest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
