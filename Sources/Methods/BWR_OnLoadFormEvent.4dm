//%attributes = {}
  //BWR_OnLoadFormEvent

  //XS generic code
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

vb_RecordInInputForm:=True:C214


XS_SetInterface 


  //call application specific code
dhBWR_OnLoadFormEvent ($tablePointer)