//%attributes = {}
  //ACTiecv_actualizaEstado
C_LONGINT:C283($l_id;$l_estadoAsignar)
C_BOOLEAN:C305($b_hecho;$0)

$l_id:=$1
$l_estadoAsignar:=$2

KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_id;True:C214)
If (ok=1)
	[ACT_IECV:253]estado:14:=[ACT_IECV:253]estado:14 ?+ $l_estadoAsignar
	SAVE RECORD:C53([ACT_IECV:253])
	$b_hecho:=True:C214
Else 
	$b_hecho:=False:C215
End if 
KRL_UnloadReadOnly (->[ACT_IECV:253])

$0:=$b_hecho