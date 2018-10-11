//%attributes = {}
  //BWR_OnCloseBoxFormEvent


  //****DECLARACIONES****
C_BOOLEAN:C305($trapped)

  //****INICIALIZACIONES****
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

  //****CUERPO****
$trapped:=dhBWR_OnCloseBoxFormEvent ($tablePointer)

If (Not:C34($trapped))
	bClose:=1
	BWR_DispatchButtonActions ($tablePointer)
End if 

  //****LIMPIEZA****




