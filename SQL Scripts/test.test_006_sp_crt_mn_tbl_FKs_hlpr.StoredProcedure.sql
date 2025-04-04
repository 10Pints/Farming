SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================================================
-- Author:      Terry Watts
-- Create date: 05-NOV-2023
-- Description: Tests the sp_create_main_table_FKs_hlpr rtn
-- Note:        the cleanup rtn: test.cleanup_test_sp_create_main_table_FKs_hlpr will reinstate the FKs
-- =====================================================================================================
----[@tSQLt:NoTransaction]('test.cleanup_tst_sp_crt_mn_tbl_FKs_hlpr')
CREATE PROCEDURE [test].[test_006_sp_crt_mn_tbl_FKs_hlpr]
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE 
       @fn  NVARCHAR(30)   = 'TST_CRT_MN_TBL_FKS_HLPR'
      ,@act INT
      ,@exp INT;

   EXEC sp_log 2, @fn, '01: starting';
   -- strategy:
   -- SETUP:
   -- DROP existing keys
   EXEC sp_crt_mn_tbl_FKs 0;
   TRUNCATE TABLE ChemicalAction;
   TRUNCATE TABLE ChemicalProduct;

   -- Green tests                                @fk_nm                         @fk_tbl            @fk_fld        @pk_tbl     @pk_fld       @exp_error=-   
   EXEC test.hlpr_006_sp_crt_mn_tbl_FKs_hlpr 'FK_ChemicalAction_Chemical' , 'ChemicalAction',  'chemical_id', 'Chemical', 'chemical_id', 0;
   EXEC test.hlpr_006_sp_crt_mn_tbl_FKs_hlpr 'FK_ChemicalProduct_Chemical', 'ChemicalProduct', 'chemical_id', 'Chemical', 'chemical_id';
   EXEC test.hlpr_006_sp_crt_mn_tbl_FKs_hlpr 'FK_ChemicalProduct_Product' , 'ChemicalProduct', 'product_id' , 'Product' , 'product_id';
   
   -- Red tests
   EXEC sp_log 2, @fn, '99: leaving: ALL TEST PASSED';
END
/*
EXEC tSQLt.RunAll;
EXEC tSQLt.Run 'test.test_006_sp_crt_mn_tbl_FKs_hlpr';
*/
GO
