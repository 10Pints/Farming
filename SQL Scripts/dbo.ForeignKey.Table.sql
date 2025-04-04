SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForeignKey](
	[id] [float] NOT NULL,
	[fk_nm] [nvarchar](255) NULL,
	[foreign_table_nm] [nvarchar](255) NULL,
	[primary_tbl_nm] [nvarchar](255) NULL,
	[schema_nm] [nvarchar](255) NULL,
	[fk_col_nm] [nvarchar](255) NULL,
	[pk_col_nm] [nvarchar](255) NULL,
	[unique_constraint_name] [nvarchar](255) NULL,
	[ordinal] [float] NULL,
 CONSTRAINT [PK_ForeignKey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_ForeignKey_fk_nm] ON [dbo].[ForeignKey]
(
	[fk_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
