//%attributes = {}
  //UD_v20140814_Boletas

If (ACT_AccountTrackInicializado )
	
	READ WRITE:C146([ACT_Boletas:181])
	ARRAY LONGINT:C221($aQR_Longint1;0)
	C_LONGINT:C283($l_proc)
	
	$l_proc:=IT_UThermometer (1;0;"Verificando boletas…")
	
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]AfectaIVA:9=False:C215;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Monto_Afecto:4>0)
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=!2014-05-01!)
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aQR_Longint1)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Monto_Afecto:4:=0)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Monto_IVA:5:=0)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Monto_Exento:30:=[ACT_Boletas:181]Monto_Total:6)
		LOG_RegisterEvt ("Ajuste de monto IVA en boletas exentas para boletas número: "+AT_array2text (->$aQR_Longint1;", ";"### ### ###"))
		
	End if 
	IT_UThermometer (-2;$l_proc)
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	
End if 