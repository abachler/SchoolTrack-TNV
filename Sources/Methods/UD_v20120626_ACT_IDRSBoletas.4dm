//%attributes = {}
  //UD_v20120626_ACT_IDRSBoletas

If (ACT_AccountTrackInicializado )
	  //20120626 RCH Se asigna el valor -1 a documentos para razon social principal para hacer validacion de documentos duplicados...
	$vl_proc:=IT_UThermometer (1;0;"Verificando dato...")
	MESSAGES OFF:C175
	READ WRITE:C146([ACT_Boletas:181])
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=0)
	APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25:=-1)
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	IT_UThermometer (-2;$vl_proc)
End if 