C_LONGINT:C283($vl_records)
If ([ACT_Boletas:181]documento_electronico:29)
	If (<>GCOUNTRYCODE="mx")
		If ([ACT_Boletas:181]Numero:11>0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=[ACT_Boletas:181]Numero:11;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Categoria:12=[ACT_Boletas:181]ID_Categoria:12;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=[ACT_Boletas:181]ID_RazonSocial:25;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($vl_records>0)
				BEEP:C151
				[ACT_Boletas:181]Numero:11:=Old:C35([ACT_Boletas:181]Numero:11)
			End if 
		End if 
	Else 
		BEEP:C151
		[ACT_Boletas:181]Numero:11:=Old:C35([ACT_Boletas:181]Numero:11)
	End if 
End if 