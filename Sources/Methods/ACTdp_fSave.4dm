//%attributes = {}
  //ACTdp_fSave 
C_TEXT:C284($vt_retorno;$0)

$vt_retorno:=ACTcfg_OpcionesMovimientos ("ValidaCambioEstadoDctoPago")
$vb_calculoMontos:=False:C215

Case of 
	: (KRL_FieldChanges (->[ACT_Documentos_de_Pago:176]Protestado:36;->[ACT_Documentos_de_Pago:176]Depositado:35;->[ACT_Documentos_de_Pago:176]Fecha:13;->[ACT_Documentos_de_Pago:176]FechaPago:4))
		$vl_idApdo:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
		$vl_idTer:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
		$vb_calculoMontos:=True:C214
End case 
  //20120130 RCH esto debe estar bajo la verificacion de cambio en id_estado porque sino no actualiza el documento en cartera
  //SAVE RECORD([ACT_Documentos_de_Pago])

  //20111027 RCH No se guardaba el estado en el documento en cartera...
If (KRL_FieldChanges (->[ACT_Documentos_de_Pago:176]id_estado:53))
	  //20120130 RCH Se bloqueaba el registro...
	$vb_readOnly:=Read only state:C362([ACT_Documentos_en_Cartera:182])
	$vl_recNum:=Record number:C243([ACT_Documentos_en_Cartera:182])
	
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;True:C214)
	[ACT_Documentos_en_Cartera:182]id_estado:21:=[ACT_Documentos_de_Pago:176]id_estado:53
	[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_de_Pago:176]Estado:14
	SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	
	KRL_ResetPreviousRWMode (->[ACT_Documentos_en_Cartera:182];$vb_readOnly)
	KRL_GotoRecord (->[ACT_Documentos_en_Cartera:182];$vl_recNum)
End if 

  //20120130 RCH esto debe estar bajo la verificacion de cambio en id_estado porque sino no actualiza el documento en cartera
SAVE RECORD:C53([ACT_Documentos_de_Pago:176])

If ($vb_calculoMontos)
	ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosIdsApdoTerceros";->$vl_idApdo;->$vl_idTer)
End if 

$0:=$vt_retorno