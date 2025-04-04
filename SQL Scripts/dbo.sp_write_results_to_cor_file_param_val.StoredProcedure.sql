SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================================================================
-- Author:      Terry Watts
-- Create date: 15-MAR-2024
-- Description: This routine performs teh parameter validation for sp_write_results_to_cor_file
--
-- Parameters:
--  @cor_file_path : the corrections Excel full file path
--  @cor_range     : the specified range to write to - uses the columns act_cnt and results
--
-- POSTCONDITIONS:
-- POST 01: @cor_file_path must be specified exception 90000, 'The cor file must be specified'
-- POST 02: @cor_file_path must be an .xlsx file or exception 90001, 'The cor file [',@cor_file_path,'] must be an Excel file'
-- POST 03: cor_file_pathfile must exist or exception 90002, 'The cor file [',@cor_file_path,'] does not exist'
-- POST 04: results written back to @cor_file_path or error message logged
-- =========================================================================================================
CREATE PROCEDURE [dbo].[sp_write_results_to_cor_file_param_val]
    @cor_file        NVARCHAR(132)
   ,@cor_file_path   NVARCHAR(1000)
   ,@cor_range       NVARCHAR(1000) = 'Corrections$A:S'
AS
BEGIN
   DECLARE
    @fn        NVARCHAR(35)   = N'WRT RES2COR F VAL'
   ,@sql       NVARCHAR(MAX)

   -----------------------------------------------------------------------------------------------------------
   -- Validating parameters
   -----------------------------------------------------------------------------------------------------------
   EXEC sp_log 1, @fn,'00 starting
@cor_file     [', @cor_file     , ']
@cor_file_path[', @cor_file_path, ']
@cor_range    [', @cor_range    , ']';

-- POST 02: @cor_file_path must be an .xlsx file or exception 90000, 'The cor file [',@cor_file_path,'] must be an Excel file'
   IF ((@cor_file IS NULL) OR (@cor_file=''))
      EXEC sp_raise_exception 90000, 'The cor file must be specified', @fn=@fn

   IF ((@cor_file_path IS NULL) OR (@cor_file_path=''))
      EXEC sp_raise_exception 90004, 'The cor file path must be specified', @fn=@fn


-- POST 02: @cor_file_path must be an .xlsx file or exception 90000, 'The cor file [',@cor_file_path,'] must be an Excel file'
   IF CHARINDEX('.xlsx', @cor_file_path) = 0
      EXEC sp_raise_exception 90001, 'The cor file [',@cor_file_path,'] must be an Excel file', @fn=@fn

   -- POST 03: cor_file_pathfile must exist or exception 90001, 'The cor file [',@cor_file_path,'] does not exist'
   if Ut.dbo.fnFileExists(@cor_file_path) = 0
      EXEC sp_raise_exception 90002, 'The cor file [',@cor_file_path,'] does not exist', @fn=@fn;

   EXEC sp_log 1, @fn, '99: leaving, OK';
END
GO
