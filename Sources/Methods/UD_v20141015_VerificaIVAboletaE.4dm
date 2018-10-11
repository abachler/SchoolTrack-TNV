//%attributes = {}
  //UD_v20141015_VerificaIVAboletaE

If (ACT_AccountTrackInicializado )
	ACTcfg_LoadConfigData (8)
	ACTcfg_LoadConfigData (6)
	READ WRITE:C146([ACT_Boletas:181])
	
	C_LONGINT:C283($l_indice;$l_proc)
	
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	
	$l_proc:=IT_UThermometer (1;0;"Verificando iva en D.T...")
	abACT_Afecta{0}:=False:C215
	AT_SearchArray (->abACT_Afecta;"=";->aQR_Longint2)
	For ($l_indice;1;Size of array:C274(aQR_Longint2))
		APPEND TO ARRAY:C911(aQR_Longint3;alACT_IDDT{aQR_Longint2{$l_indice}})
	End for 
	QUERY WITH ARRAY:C644([ACT_Boletas:181]ID_Documento:13;aQR_Longint3)
	
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]AfectaIVA:9=False:C215;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Monto_Afecto:4>0;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3>=!2014-05-01!;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;aQR_Longint1)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Monto_Afecto:4:=0)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Monto_IVA:5:=0)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Monto_Exento:30:=[ACT_Boletas:181]Monto_Total:6)
		LOG_RegisterEvt ("Ajuste de monto IVA en boletas exentas para boletas número: "+AT_array2text (->aQR_Longint1;", ";"### ### ###"))
	End if 
	
	IT_UThermometer (-2;$l_proc)
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	
	AT_Initialize (->aQR_Longint1;->aQR_Longint2;->aQR_Longint3)
End if 