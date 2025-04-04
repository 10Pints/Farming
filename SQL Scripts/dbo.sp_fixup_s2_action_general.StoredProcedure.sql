SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Terry Watts
-- Create date: 22-OCT-2022
-- Description: fixup the entry mode
--
-- PRECONDITIONS: none
--
-- POSTCONDITIONS:                                                Exception:
--    POST 01: IF if now rows were processed from the EntryModeFixup table 50697, 'Error in sp_fixup_s2_action_general: No rows were processed', 1;
--    POST 02: IF 'Early post-emergent' still exists i staging2            50698, 'Error in sp_fixup_s2_action_general: Early post-emergent still exists in S2.entry_mode', 1
--    POST 03: IF unrecognised routine                                     50699, 'Error in sp_fixup_s2_action_general: unrecognised routine <rtn>', 1;
--    POST 04: EntryModeFixup table has rows
-- =============================================
CREATE PROCEDURE [dbo].[sp_fixup_s2_action_general]
   @fixup_cnt       INT = NULL OUT
AS
BEGIN
   SET NOCOUNT OFF;
   DECLARE
       @fn              NVARCHAR(35)   = 'FIXUP_S2_ACTION_GEN'
      ,@delta           INT            = 0
      ,@cursor          CURSOR
      ,@id              INT            = 0
      ,@routine         NVARCHAR(50)
      ,@search_clause   NVARCHAR(50)
      ,@clause_1        NVARCHAR(50)
      ,@clause_2        NVARCHAR(50)
      ,@clause_3        NVARCHAR(50)
      ,@error_msg       NVARCHAR(500)
      ,@msg             NVARCHAR(500)

   EXEC sp_log 1, @fn, '00 starting @row_cnt: ', @fixup_cnt;
   EXEC sp_register_call @fn;

   -- POST 04: EntryModeFixup table has rows
   EXEC sp_chk_tbl_populated 'EntryModeFixup';

   EXEC sp_log 1, @fn, '01 importing ACTIONStaging fixup from : ', @fixup_cnt;
   SET @cursor = CURSOR FOR
      SELECT id, routine, search_clause, clause_1, clause_2, clause_3
      FROM EntryModeFixup order by id;

   OPEN @cursor;
   EXEC sp_log 1, @fn, '05: @@FETCH_STATUS before first fetch: [', @@FETCH_STATUS, ']';
   FETCH NEXT FROM @cursor INTO @id, @routine, @search_clause, @clause_1, @clause_2, @clause_3;

   IF @@FETCH_STATUS <> 0
   BEGIN
      -- POST 01: IF if now rows were processed from the EntryModeFixup table 50697, 'Error in sp_fixup_s2_action_general: No rows were processed', 1;
      SET @error_msg = CONCAT('06: Error in sp_fixup_s2_action_general: fetch status: ', @@FETCH_STATUS, ' opening cursor to the EntryModeFixup table');
      EXEC sp_log 4, @fn, @error_msg;
      THROW 54501, @error_msg,1;
   END

   WHILE (@@FETCH_STATUS = 0)
   BEGIN
      BEGIN TRY
         IF @routine = 'sp_fixup_s2_action_general_hlpr'
         BEGIN
            EXEC sp_log 1, @fn, '20: calling sp_fixup_s2_action_general_hlpr
 @id           =@id            [',@id,']
,@search_clause=@search_clause [',@search_clause,']
,@replace_clause=@clause_1     [',@clause_1,']
,@delta=@fixup_cnt OUT ';

            EXEC sp_fixup_s2_action_general_hlpr 
                @index           = @id
               ,@search_clause   = @search_clause
               ,@replace_clause  = @clause_1
               ,@fixup_cnt       = @fixup_cnt OUT
               ,@must_update     = 0;
         END
         ELSE IF @routine = 'sp_fixup_s2_action_general_hlpr2'
         BEGIN
            EXEC sp_log 1, @fn, '20: calling sp_fixup_s2_action_general_hlpr2';
            EXEC sp_fixup_s2_action_general_hlpr2
                @index                    = @id
               ,@replace_clause           = @search_clause
               ,@ingredient_search_clause = @clause_1
               ,@entry_mode_operator      = @clause_2
               ,@entry_mode_clause        = @clause_3
               ,@fixup_cnt                = @fixup_cnt
               ,@must_update              = 0

          EXEC sp_log 1, @fn, '21: @fixup_cnt: ', @fixup_cnt;
         END
         ELSE
         BEGIN
            -- POST 03: IF unrecognised routine  throw ex: 50699, 'Error in sp_fixup_s2_action_general: unrecognised routine <rtn>', 1;
            SET @error_msg = CONCAT('Error in sp_fixup_s2_action_general: unrecognised routine [',@routine,']');
            EXEC sp_log 4, @fn, '20: ', @error_msg;
            THROW 50699, @error_msg, 1;
         END

         -- Increment the fixup cnt
         SET @delta = @@ROWCOUNT;
         IF @fixup_cnt IS NOT NULL SET @fixup_cnt = @fixup_cnt + @delta;

         EXEC sp_log 1, @fn, '10:
   @id: [', @id, ']
   @routine:       [', @routine, ']
   @search_clause: [', @search_clause, ']
   @clause_1:      [', @clause_1, ']
   @clause_2:      [', @clause_2, ']
   @clause_3:      [', @clause_3, ']
   rows updated:   [', @delta, ']
   @fixup_cnt:     [', @fixup_cnt, ']'
   ;

         FETCH NEXT FROM @cursor INTO @id, @routine, @search_clause, @clause_1, @clause_2, @clause_3;
      END TRY
      BEGIN CATCH
         SET @error_msg = Ut.dbo.fnGetErrorMsg();
         EXEC sp_log 4, @fn, '50: caught exception
   @id: [', @id, ']
   @routine:       [', @routine, ']
   @search_clause: [', @search_clause, ']
   @clause_1:      [', @clause_1, ']
   @clause_2:      [', @clause_2, ']
   @clause_3:      [', @clause_3, ']
   rows updated:   [', @delta, ']
   @fixup_cnt:     [', @fixup_cnt, ']
   exception:      [', @error_msg, ']'
   ;
         THROW;
      END CATCH
   END

   --------------------------------------------------------------------------------------
   -- POSTCONDITION checks
   --------------------------------------------------------------------------------------
   IF @id = 0
   BEGIN
      ;THROW 50697, 'Error in sp_fixup_s2_action_general: No rows were processed', 1;
   END

   --------------------------------------------------------------------------------------
   -- Processing completed OK
   --------------------------------------------------------------------------------------
   EXEC sp_log 1, @fn, '99: leaving, @fixup_cnt: ', @fixup_cnt;
END
/*
-------------------------------------------------------
EXEC sp_fixup_s2_action_general;
*/
GO
