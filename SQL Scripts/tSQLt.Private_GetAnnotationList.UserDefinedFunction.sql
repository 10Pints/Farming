SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [tSQLt].[Private_GetAnnotationList](@ProcedureDefinition [nvarchar](max))
RETURNS  TABLE (
	[AnnotationNo] [int] NULL,
	[Annotation] [nvarchar](max) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.Annotations].[GetAnnotationList]
GO
