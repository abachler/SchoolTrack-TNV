//%attributes = {}
  //ST_FormatManager2

  //C_LONGINT($numPages;$width;$height)
  //C_BOOLEAN($fixedWidth;$fixedHeight)
  //C_TEXT($title)
  //FORM GET PROPERTIES([xShell_Dialogs];"FormatManager";$width;$height;$numPages;$fixedWidth;$fixedHeight;$title)
ST_LoadModuleFormatExceptions 
tExcept:=ST_ClearExtraCR (AT_array2text (->at_ExcepcionesFormato;"\r"))
CFG_OpenConfigPanel (->[xShell_Dialogs:114];"FormatManager2";0;__ ("Formato de Nombres"))
tExcept:=Replace string:C233(ST_ClearExtraCR (tExcept);Char:C90(0);"")
ARRAY TEXT:C222(at_ExcepcionesFormato;0)
AT_Text2Array (->at_ExcepcionesFormato;tExcept;"\r")
BLOB_Variables2Blob (->myBlob;0;->at_ExcepcionesFormato)
PREF_SetBlob (0;"Excepciones formateo "+vsBWR_CurrentModule;myBlob)
tExcept:=""
VS_LoadAutoFormatRefs 