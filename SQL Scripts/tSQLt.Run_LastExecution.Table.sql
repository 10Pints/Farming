SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tSQLt].[Run_LastExecution](
	[TestName] [nvarchar](max) NULL,
	[SessionId] [int] NULL,
	[LoginTime] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
