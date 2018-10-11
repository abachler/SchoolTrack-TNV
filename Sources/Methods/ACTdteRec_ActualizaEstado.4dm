//%attributes = {}
  //ACTdteRec_ActualizaEstado

C_LONGINT:C283($l_idDTE)
C_BOOLEAN:C305($b_hecho;$0)
C_TEXT:C284($t_motivo;$1;$t_dato)
C_LONGINT:C283($l_bit)

ST_Deconcatenate ("";$1;->$l_idDTE;->$t_motivo;->$t_dato;->$l_bit)

KRL_FindAndLoadRecordByIndex (->[ACT_DTEs_Recibidos:238]id:1;->$l_idDTE;True:C214)
If (ok=1)
	[ACT_DTEs_Recibidos:238]estado_dte:14:=[ACT_DTEs_Recibidos:238]estado_dte:14 ?+ $l_bit
	[ACT_DTEs_Recibidos:238]motivo_rechazo:15:=$t_motivo
	[ACT_DTEs_Recibidos:238]recinto:17:=$t_dato
	SAVE RECORD:C53([ACT_DTEs_Recibidos:238])
	$b_hecho:=True:C214
Else 
	If (Records in selection:C76([ACT_DTEs_Recibidos:238])=0)
		$b_hecho:=True:C214
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_DTEs_Recibidos:238])

$0:=$b_hecho