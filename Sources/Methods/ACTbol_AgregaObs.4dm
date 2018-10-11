//%attributes = {}
  //ACTbol_AgregaObs
C_TEXT:C284($1;$t_parametro)
C_BOOLEAN:C305($0;$b_hecho)
C_LONGINT:C283($l_Error)
C_LONGINT:C283($l_idBoleta)
C_TEXT:C284($t_obsDocTrib)

$t_parametro:=$1
ST_Deconcatenate (";";$t_parametro;->$l_Error;->$l_idBoleta;->$t_obsDocTrib)

KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)
If (ok=1)
	[ACT_Boletas:181]Observacion:18:=[ACT_Boletas:181]Observacion:18+Choose:C955([ACT_Boletas:181]Observacion:18#"";"\r";"")+$t_obsDocTrib
	[ACT_Boletas:181]DTE_error_envio_mail:51:=($l_Error=1)
	SAVE RECORD:C53([ACT_Boletas:181])
	$b_hecho:=True:C214
Else 
	If (Records in selection:C76([ACT_Boletas:181])=0)
		$b_hecho:=True:C214
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Boletas:181])

$0:=$b_hecho