SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [test].[Results](
	[rtn_nm] [nvarchar](60) NULL,
	[rtn_ty] [nvarchar](5) NULL,
	[schema_nm] [nvarchar](25) NULL,
	[param_nm] [nvarchar](60) NULL,
	[ordinal_position] [int] NULL,
	[param_ty_nm] [nvarchar](25) NULL,
	[is_output] [bit] NULL,
	[has_default_value] [bit] NULL,
	[is_nullable] [bit] NULL
) ON [PRIMARY]
GO
