//%attributes = {}
  //UD_v20140522_ACT_Venc

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_proc)
	STR_ReadGlobals 
	If ((<>gCountryCode="ar") | (<>gCountryCode="co"))
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		
		
		$l_proc:=IT_UThermometer (1;0;"Verificando vencimiento de Documentos en cartera...")
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]FechaPago:4>=!2014-01-01!;*)
		QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4;*)
		QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]FechaVencimiento:27#!00-00-00!)
		Case of 
			: (<>gCountryCode="ar")
				APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=[ACT_Documentos_de_Pago:176]Fecha:13+30)
			: (<>gCountryCode="co")
				APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=[ACT_Documentos_de_Pago:176]Fecha:13+30)
			Else 
				  //APPLY TO SELECTION([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]FechaVencimiento:=[ACT_Documentos_de_Pago]Fecha+60) queda igual...
		End case 
		
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
		Case of 
			: (<>gCountryCode="ar")
				APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30)
			: (<>gCountryCode="co")
				APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30)
			Else 
				  //[ACT_Documentos_en_Cartera]Fecha_Vencimiento:=[ACT_Documentos_en_Cartera]Fecha_Doc+60
		End case 
		
		IT_UThermometer (-2;$l_proc)
		
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
		
	End if 
End if 