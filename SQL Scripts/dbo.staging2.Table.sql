SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging2](
	[stg2_id] [int] NOT NULL,
	[company] [nvarchar](70) NULL,
	[ingredient] [nvarchar](150) NULL,
	[product] [nvarchar](100) NULL,
	[concentration] [nvarchar](35) NULL,
	[formulation_type] [nvarchar](10) NULL,
	[uses] [nvarchar](100) NULL,
	[toxicity_category] [int] NULL,
	[registration] [nvarchar](65) NULL,
	[expiry] [nvarchar](30) NULL,
	[entry_mode] [nvarchar](60) NULL,
	[crops] [nvarchar](65) NULL,
	[pathogens] [nvarchar](360) NULL,
	[rate] [nvarchar](200) NULL,
	[mrl] [nvarchar](200) NULL,
	[phi] [nvarchar](200) NULL,
	[phi_resolved] [nvarchar](120) NULL,
	[reentry_period] [nvarchar](250) NULL,
	[notes] [nvarchar](250) NULL,
	[comment] [nvarchar](500) NULL,
	[created] [datetime] NULL,
 CONSTRAINT [PK_staging2] PRIMARY KEY CLUSTERED 
(
	[stg2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_staging2_chemical] ON [dbo].[staging2]
(
	[ingredient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_staging2_crops] ON [dbo].[staging2]
(
	[crops] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_staging2_pathogens] ON [dbo].[staging2]
(
	[pathogens] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Terry Watts
-- Create date: 30-JAN-2024
-- Description: debug aid
-- =============================================
CREATE TRIGGER [dbo].[sp_Staging2_update_trigger]
   ON [dbo].[staging2] FOR UPDATE
AS 
BEGIN
   SET NOCOUNT ON;
   DECLARE
    @fn              NVARCHAR(35) = N'S2_UPDATE_TRIG'
   ,@id_key          NVARCHAR(30) = N'FIXUP_ROW_ID'
   ,@fixup_id        INT       -- xl row id
   ,@cor_log_flg_key NVARCHAR(30) = N'COR_LOG_FLG'
   ,@search_cls_key  NVARCHAR(30) = N'SEARCH_CLAUSE'
   ,@replace_cls_key NVARCHAR(30) = N'REPLACE_CLAUSE'
   ,@search_clause   NVARCHAR(100)
   ,@replace_clause  NVARCHAR(100)
   ,@cor_flg         INT          = 0
   ,@cnt             INT

   SELECT @cnt = COUNT(*) FROM inserted;

   BEGIN TRY
      SET @cor_flg = Ut.dbo.fnGetSessionContextAsInt(@cor_log_flg_key);
      IF @cor_flg = 1
      BEGIN
         SET @search_clause  = Ut.dbo.fnGetSessionContextAsString(@search_cls_key);
         SET @replace_clause = Ut.dbo.fnGetSessionContextAsString(@replace_cls_key);
         SET @fixup_id = Ut.dbo.fnGetSessionContextAsInt(@id_key);
         --EXEC sp_log 1, @fn,'00: starting #rows: ',@cnt, ' fixup id: ',@fixup_id, ' @search_clause:[',@search_clause,']';

         -- Log update summary
         INSERT INTO S2UpdateSummary (fixup_id, search_clause, replace_clause, row_cnt)
         SELECT @fixup_id, SUBSTRING(@search_clause, 1,100), SUBSTRING(@replace_clause, 1,100), @cnt;

         -- Log update details
         INSERT INTO S2UpdateLog (fixup_id, stg2_id, old_pathogens, new_pathogens)
         SELECT @fixup_id, d.stg2_id, d.pathogens, i.pathogens
         FROM deleted d JOIN inserted i on d.stg2_id=i.stg2_id
         WHERE d.pathogens <> i.pathogens;
      END
   END TRY
   BEGIN CATCH
      EXEC sp_log_exception @fn, ' fixup id: ',@fixup_id;
      THROW;
   END CATCH
END
/*
PRINT Ut.dbo.fnGetSessionContextAsInt(N'COR_LOG_FLG');
*/
GO
ALTER TABLE [dbo].[staging2] DISABLE TRIGGER [sp_Staging2_update_trigger]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'resolved to days' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'staging2', @level2type=N'COLUMN',@level2name=N'phi_resolved'
GO
