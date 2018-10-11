//%attributes = {}
C_POINTER:C301($1;$campo)
C_LONGINT:C283($fieldNum)

$campo:=$1
$key:=$2
$nota:=$3


$fieldNum:=Field:C253($campo)
$vs_Key:=$key+"."+String:C10($fieldNum)
$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_InfoCalificaciones:142]Llave:1;->$vs_Key;False:C215)
If ($recNum#-1)
	$dtsModificacion:=DTS_MakeFromDateTime ([xxSTR_InfoCalificaciones:142]Registro_Fecha:3;[xxSTR_InfoCalificaciones:142]Registro_hora:2)
Else 
	If ($nota#"")
		CREATE RECORD:C68([xxSTR_InfoCalificaciones:142])
		[xxSTR_InfoCalificaciones:142]Llave:1:=$vs_Key
		[xxSTR_InfoCalificaciones:142]Registro_Autor:4:=""
		[xxSTR_InfoCalificaciones:142]Registro_Fecha:3:=Current date:C33(*)
		[xxSTR_InfoCalificaciones:142]Registro_hora:2:=Current time:C178(*)-1
		SAVE RECORD:C53([xxSTR_InfoCalificaciones:142])
		$dtsModificacion:=DTS_MakeFromDateTime ([xxSTR_InfoCalificaciones:142]Registro_Fecha:3;[xxSTR_InfoCalificaciones:142]Registro_hora:2)
	Else 
		$dtsModificacion:="00000000000000"
	End if 
End if 
$0:=$dtsModificacion