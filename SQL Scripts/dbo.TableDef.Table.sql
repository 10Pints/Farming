SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableDef](
	[table_id] [int] NOT NULL,
	[table_nm] [nvarchar](50) NOT NULL,
	[table_type] [nvarchar](50) NULL,
	[sub_type] [nvarchar](50) NULL,
	[pop_order] [int] NULL
) ON [PRIMARY]
GO
