CREATE SCHEMA [test]
GO
EXEC sys.sp_addextendedproperty @name=N'tSQLt.TestClass', @value=1 , @level0type=N'SCHEMA',@level0name=N'test'
GO
