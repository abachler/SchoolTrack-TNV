//%attributes = {}
  //IT_TypedListValueIsOK

$arrayPointer:=$1
$objectPointer:=$2

If (Find in array:C230($arrayPointer->;$objectPointer->)=-1)
	CD_Dlog (0;ST_Uppercase ($objectPointer->)+__ (" no es un valor autorizado para este campo.\rDebe ingresar un valor válido o seleccionarlo en la lista desplegable."))
	$objectPointer->:=""
	$0:=False:C215
Else 
	$0:=True:C214
End if 