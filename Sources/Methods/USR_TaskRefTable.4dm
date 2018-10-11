//%attributes = {}
ARRAY TEXT:C222(<>at_lbTaskTypes_names;0)
ARRAY LONGINT:C221(<>al_lbTaskTypes_Ids;0)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Uso del graficador"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_4DChart)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Uso de planilla de calculos"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_4DView)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Uso del procesador de textos"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_4DWrite)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Registro añadido a la tabla"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_AddRecord)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Ejecución de consulta predefinida"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_ExecSavedQuery)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Ejecución de comando"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_Execute)

  //APPEND TO ARRAY(<>at_lbTaskTypes_names;__ ("Ejecución de script avanzado"))
  //APPEND TO ARRAY(<>al_lbTaskTypes_Ids;UE_ExecuteAdvanced)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Exportación de informe"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_ExportReport)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Búsqueda simple"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_Find)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Inicio de sesión"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_ModuleStart)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Previsualización de informe"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_PreviewReport)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Impresión de informe"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_PrintReport)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Editor de consultas"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_QueryEditor)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Creación de informe"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_ReportCreation)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Respaldo manual de la base de datos"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_Backup)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Compactación de la base de datos"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_CompactDB)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Verificación de la base de datos"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_VerifyDB)

  //APPEND TO ARRAY(<>at_lbTaskTypes_names;__ ("Consulta de documentos"))
  //APPEND TO ARRAY(<>al_lbTaskTypes_Ids;UE_SIM_Documents)
APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Reconstrucción de indexes"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_IndexRebuild)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Reconstrucción de la base de datos"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_ExportDB)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Consulta de directorio FTP"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_FTP)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Consulta de tickets de soporte"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_SIM_TS)

APPEND TO ARRAY:C911(<>at_lbTaskTypes_names;__ ("Cambio de pestaña en explorador"))
APPEND TO ARRAY:C911(<>al_lbTaskTypes_Ids;UE_TabSelection)


SORT ARRAY:C229(<>al_lbTaskTypes_Ids;<>at_lbTaskTypes_names;>)

ARRAY LONGINT:C221(<>al_Taks_Executions;Size of array:C274(<>al_lbTaskTypes_Ids))
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
For ($i;1;Size of array:C274(<>al_lbTaskTypes_Ids))
	QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]Event:6=<>al_lbTaskTypes_Ids{$i})
	<>al_Taks_Executions{$i}:=$l_records
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

