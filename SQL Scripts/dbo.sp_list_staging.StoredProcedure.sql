SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================================================
-- Author:      Terry Watts
-- Create date: 25-JUNE-2023
-- Description: useful as a search for corrections, lists the crops and the occurrences of the 
--              pathogen_clause in the staging table
-- ===========================================================================================
CREATE PROC [dbo].[sp_list_staging]
   @where_subclause1 NVARCHAR(100), 
   @where_subclause2 NVARCHAR(100)=NULL, 
   @where_subclause3 NVARCHAR(100)=NULL, 
   @and_not_clause1  NVARCHAR(200)=NULL,
   @and_not_clause2  NVARCHAR(200)=NULL,
   @and_not_clause3  NVARCHAR(200)=NULL,
   @top              INT = 100
AS
BEGIN
   DECLARE 
       @sql                      NVARCHAR(MAX)
      ,@select_clause            NVARCHAR(MAX)
      ,@select_distinct_clause   NVARCHAR(MAX)
      ,@from_clause              NVARCHAR(MAX)
      ,@where_clause             NVARCHAR(MAX)
      ,@ids                      NVARCHAR(MAX)
      ,@nl                       NVARCHAR(2) = NCHAR(0x0a) + NCHAR(0x0d)

   SET @select_clause         = CONCAT('SELECT TOP ',@top, ' stg1_id , pathogens as [S1.pathogens                   .], crops as [S1.crops], ingredient as [S1.ingredient]');
   SET @select_distinct_clause= 'SELECT distinct pathogens, crops, ingredient';
   SET @from_clause           = 'FROM staging1'
   SET @where_clause          = CONCAT('WHERE pathogens LIKE ''', @where_subclause1, '''');

   IF @where_subclause2 IS NOT NULL SET @where_clause = CONCAT(@where_clause, ' AND pathogens LIKE '''    , @where_subclause2, '''');
   IF @where_subclause3 IS NOT NULL SET @where_clause = CONCAT(@where_clause, ' AND pathogens LIKE '''    , @where_subclause3, '''');

   IF @and_not_clause1 IS NOT NULL SET @where_clause  = CONCAT(@where_clause, ' AND pathogens NOT LIKE ''', @and_not_clause1 , ''''); 
   IF @and_not_clause2 IS NOT NULL SET @where_clause  = CONCAT(@where_clause, ' AND pathogens NOT LIKE ''', @and_not_clause2 , ''''); 
   IF @and_not_clause3 IS NOT NULL SET @where_clause  = CONCAT(@where_clause, ' and pathogens not like ''', @and_not_clause3 , '''');

   -- distinct pathogens that match filter
   SET @sql = CONCAT(@select_distinct_clause, @nl, @from_clause, @nl, @where_clause);
   PRINT CONCAT('@sql:', @nl, @sql);
   EXEC sp_executesql @sql;

   -- all pathogens that match filter
   SET @sql = CONCAT(@select_clause, @nl, @from_clause, @nl, @where_clause);
   PRINT CONCAT('@sql:', @nl, @sql);
   EXEC sp_executesql @sql;

   -- counts
   SET @sql = CONCAT(
   'SELECT S.pathogens AS [s1.pathogens                                                                  .]
 , Count(s.stg1_id) as [count]
FROM
(
   SELECT DISTINCT pathogens
   FROM staging1 
',   @where_clause, '
) AS A
JOIN STAGING1 as S on A.PATHOGENS = s.PATHOGENS
GROUP BY s.pathogens 
ORDER BY ut.dbo.fnLen(s.pathogens) DESC, S.Pathogens ASC;'
);
   PRINT CONCAT('@sql:', @nl, @sql);
   EXEC sp_executesql @sql;
END
/*
EXEC sp_list_staging
   @where_subclause1 ='toll', 
   @where_subclause2 =NULL, 
   @where_subclause3 =NULL, 
   @and_not_clause1  =NULL,
   @and_not_clause2  =NULL,
   @and_not_clause3  =NULL,
   @top              = 100

*/
GO
