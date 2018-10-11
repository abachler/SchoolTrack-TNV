//%attributes = {}
  //UD_v20160924_ACTbol_FechaVenc 

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_proc)
	
	
	READ WRITE:C146([ACT_Boletas:181])
	  //ALL RECORDS([ACT_Boletas])
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=Add to date:C393(Current date:C33(*);-1;0;0))  //20161008 RCH Para buscar solo las boletas del último año...
	MESSAGES OFF:C175
	
	$l_proc:=IT_UThermometer (1;0;"Asignando valor a nuevo campo...")
	<>vb_AvoidTriggerExecution:=True:C214
	APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]FechaVencimiento:54:=[ACT_Boletas:181]FechaEmision:3)
	<>vb_AvoidTriggerExecution:=False:C215
	IT_UThermometer (-2;$l_proc)
	
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	
	LOG_RegisterEvt ("Fecha de Vencimiento asignada a los Documentos Tributarios.")
	If (Records in set:C195("LockedSet")>0)
		ARRAY LONGINT:C221($alACT_idsBoletas;0)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACT_idsBoletas)
		LOG_RegisterEvt ("La fecha de Vencimiento no fue actualizada para los siguientes ids de Documentos Tributarios :"+AT_array2text (->$alACT_idsBoletas;"-";"#########")+". Los registros estaban bloqueados.")
	End if 
End if 