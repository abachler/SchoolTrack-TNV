//%attributes = {}
  //ACTreemp_AnulaReemplazaCartera
  //20120525 RCH Se asigna id estado seleccionado. El doc en cartera se actualiza en ACTdp_fSave

C_BOOLEAN:C305($done;$0)
C_LONGINT:C283($vl_idDocCartera;$vl_idEstado)
C_TEXT:C284($vt_params)

$vt_params:=$1
  //$vl_idDocCartera:=$1

ST_Deconcatenate (";";$vt_params;->$vl_idDocCartera;->$vl_idEstado)

  //20120430 RCH Se pasa nuevo id que ya viene en negativo...
  //If ([ACT_Documentos_de_Pago]Protestado)
  //$vl_idDocCartera:=$vl_idDocCartera*-1
  //End if 
KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->$vl_idDocCartera;True:C214)
If (ok=1)
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;True:C214)
	If (ok=1)
		[ACT_Documentos_de_Pago:176]id_estado:53:=$vl_idEstado
		[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
		[ACT_Documentos_de_Pago:176]Nulo:37:=True:C214
		[ACT_Documentos_en_Cartera:182]Reemplazado:14:=True:C214
		SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
		ACTdp_fSave 
		$done:=True:C214
	Else 
		If (Records in selection:C76([ACT_Documentos_de_Pago:176])=0)
			$done:=True:C214
		End if 
	End if 
Else 
	If (Records in selection:C76([ACT_Documentos_en_Cartera:182])=0)
		$done:=True:C214
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
$0:=$done