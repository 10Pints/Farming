SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ListTestAnnotations](
  @TestObjectId INT
)
RETURNS TABLE
AS
RETURN
  SELECT 
      GAL.AnnotationNo,
      REPLACE(GAL.Annotation,'''','''''') AS EscapedAnnotationString,
      'tSQLt.'+GAL.Annotation AS Annotation
    FROM tSQLt.Private_GetAnnotationList(OBJECT_DEFINITION(@TestObjectId))AS GAL;
GO
