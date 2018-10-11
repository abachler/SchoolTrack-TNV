//%attributes = {}
  //BWR_SaveChanges


If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 


$dontSave:=dhBWR_SaveChanges ($tablePointer)

If ($dontSave)
	$0:=3
Else 
	$0:=CD_Dlog (0;__ ("¿Guardar las modificaciones antes de cerrar?");__ ("");__ ("Guardar");__ ("Cancelar");__ ("No"))
End if 