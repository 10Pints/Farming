SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [tSQLt].[Private_QuoteClassNameForNewTestClass](@ClassName NVARCHAR(MAX))
  RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN 
    CASE WHEN @ClassName LIKE '[[]%]' THEN @ClassName
         ELSE QUOTENAME(@ClassName)
     END;
END;


GO
