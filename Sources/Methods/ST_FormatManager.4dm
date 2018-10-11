//%attributes = {}
  //ST_FormatManager

C_LONGINT:C283($numPages;$width;$height)
C_BOOLEAN:C305($fixedWidth;$fixedHeight)
C_TEXT:C284($title)
FORM GET PROPERTIES:C674([xShell_Dialogs:114];"FormatManager";$width;$height;$numPages;$fixedWidth;$fixedHeight;$title)
ST_LoadModuleFormatExceptions 
tExcept:=ST_ClearExtraCR (AT_array2text (->at_ExcepcionesFormato;"\r"))
CFG_OpenConfigPanel (->[xShell_Dialogs:114];"FormatManager";0;$title)
tExcept:=Replace string:C233(ST_ClearExtraCR (tExcept);Char:C90(0);"")
ARRAY TEXT:C222(at_ExcepcionesFormato;0)
AT_Text2Array (->at_ExcepcionesFormato;tExcept;"\r")
BLOB_Variables2Blob (->myBlob;0;->at_ExcepcionesFormato)
PREF_SetBlob (0;"Excepciones formateo "+vsBWR_CurrentModule;myBlob)
tExcept:=""
VS_LoadAutoFormatRefs 