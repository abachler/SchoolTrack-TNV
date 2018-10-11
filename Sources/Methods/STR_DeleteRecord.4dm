//%attributes = {}
  //STR_DeleteRecord
C_LONGINT:C283($deleted;$0)
C_POINTER:C301($1)
C_BOOLEAN:C305($locked)

$TablePointer:=$1
$deleted:=-1
$locked:=Locked:C147($TablePointer->)
If (Not:C34($locked))
	$deleted:=dhSTR_DeleteRecord ($TablePointer)
	If ($deleted=-1)
		DELETE RECORD:C58($TablePointer->)
		LOG_RegisterEvt ("Eliminación de un registro de la tabla "+API Get Virtual Table Name (Table:C252($TablePointer));Table:C252($TablePointer))
	End if 
Else 
	CD_Dlog (0;"__(El registro se encuentra bloqueado.)")
End if 
$0:=$deleted


