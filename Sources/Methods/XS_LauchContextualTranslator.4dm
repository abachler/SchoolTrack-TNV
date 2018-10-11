//%attributes = {}
  //XS_LauchContextualTranslator

C_LONGINT:C283(vlXS_DelimTop)
C_LONGINT:C283(vlXS_DelimLeft)
C_LONGINT:C283(vlXS_DelimBottom)
C_LONGINT:C283(vlXS_DelimRight)
C_POINTER:C301(tablePtr)
C_TEXT:C284($1)
If (<>lUSR_CurrentUserID<0)
	$method:=$1
	$table:=ST_GetWord ($method;1;".")
	$form:=ST_GetWord ($method;2;".")
	$page:=FORM Get current page:C276
	
	EXECUTE FORMULA:C63("tablePtr:=->"+$table)
	If (Process state:C330(<>vlXS_TranslatorProc)<0)
		<>vlXS_TranslatorProc:=New process:C317("XS_ContextualTranslator";Pila_256K;"Traductor Contextual";Current process:C322;Table:C252(tablePtr);$form;$page)
	Else 
		SET PROCESS VARIABLE:C370(<>vlXS_TranslatorProc;vlXS_TransTable;Table:C252(tablePtr);vtXS_TransForm;$form;vlXS_TransPage;$page)
		POST OUTSIDE CALL:C329(<>vlXS_TranslatorProc)
		SHOW PROCESS:C325(<>vlXS_TranslatorProc)
		BRING TO FRONT:C326(<>vlXS_TranslatorProc)
	End if 
End if 