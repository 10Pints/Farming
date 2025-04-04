SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distributor](
	[distributor_id] [int] NOT NULL,
	[distributor_name] [nvarchar](50) NULL,
	[region] [nvarchar](50) NULL,
	[province] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[phone 1] [nvarchar](20) NULL,
	[phone 2] [nvarchar](20) NULL,
 CONSTRAINT [PK_Distributor] PRIMARY KEY CLUSTERED 
(
	[distributor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
