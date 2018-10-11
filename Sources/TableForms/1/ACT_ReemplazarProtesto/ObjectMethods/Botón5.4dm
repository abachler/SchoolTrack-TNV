If ((vlACT_ReempPor=2) | (vlACT_ReempPor=3))
	
	If ((vACT_BancoNombre="") | (vACT_Cuenta="") | (vACT_Serie="") | (vACT_FechaDoc=!00-00-00!))
		
		CD_Dlog (0;__ ("Faltan datos del cheque."))
		
	Else 
		
		If (vlACT_ReempPor=3)
			
			  //SET QUERY DESTINATION(Into variable ;$duplicados)
			  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]Ch_BancoCodigo=vACT_BancoCodigo;*)
			  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Ch_Cuenta=vACT_Cuenta;*)
			  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]NoSerie=vACT_Serie)
			  //SET QUERY DESTINATION(Into current selection )
			
			C_LONGINT:C283($duplicados)
			$duplicados:=ACTdc_buscaDuplicados (2;vACT_Serie;vACT_Cuenta;vACT_BancoCodigo)
			
			If ($duplicados>0)
				
				CD_Dlog (0;__ ("Para este banco y esta cuenta ya existe un cheque con este número de serie."))
				GOTO OBJECT:C206(vACT_Serie)
				
			Else 
				
				ACCEPT:C269
				
			End if 
			
		Else 
			
			ACCEPT:C269
			
		End if 
		
	End if 
	
Else 
	
	ACCEPT:C269
	
End if 