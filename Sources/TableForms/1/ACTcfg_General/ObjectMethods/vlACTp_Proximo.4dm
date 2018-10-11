C_LONGINT:C283(vlACT_oldNumPagare;$vl_records)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vlACT_oldNumPagare:=Self:C308->
		
	: (Form event:C388=On Data Change:K2:15)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]Numero_Pagare:11>=Self:C308->)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($vl_records#0)
			CD_Dlog (0;"Ya existe un pagaré generado con una numeración igual o superior a la ingresada. "+"Si usted mantiene la numeración generará pagarés con folios duplicados.")
		End if 
		If (vlACT_oldNumPagare#Self:C308->)
			LOG_RegisterEvt ("Cambio en numeración de pagaré. Cambió de "+String:C10(vlACT_oldNumPagare)+" a "+String:C10(Self:C308->))
		End if 
		
End case 