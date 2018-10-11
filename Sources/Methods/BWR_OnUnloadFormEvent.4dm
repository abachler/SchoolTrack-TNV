//%attributes = {}
  //BWR_OnUnloadFormEvent

If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 



dhBWR_OnUnloadForm ($tablePointer)
UNLOAD RECORD:C212($tablePointer->)
  //KRL_ReloadAsReadOnly ($tablePointer) `reemplazado por UNLOAD RECORD por ABK 16/02/2005
vb_RecordInInputForm:=False:C215
