READ WRITE:C146([ACT_RazonesSociales:279])
QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=alACTcfg_Razones{atACTcfg_Razones})
If (Records in selection:C76([ACT_RazonesSociales:279])=1)
	If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 8)
		C_LONGINT:C283($vl_col;$vl_line)
		LISTBOX GET CELL POSITION:C971(lbCAF;$vl_col;$vl_line)
		If ($vl_line>0)
			KRL_FindAndLoadRecordByIndex (->[ACT_FoliosDT:293]id:1;->alACT_idCAF{$vl_line};True:C214)
			If (ok=1)
				If ([ACT_FoliosDT:293]enviadoDTE:10)
					CD_Dlog (0;"El código de autorización de folios ha sido enviado y no es posible eliminarlo.")
				Else 
					C_LONGINT:C283($l_records)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_CAF:43=[ACT_FoliosDT:293]id:1;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($l_records>0)
						CD_Dlog (0;"El código de autorización de folios ha sido utilizado y no es posible eliminarlo.")
					Else 
						DELETE RECORD:C58([ACT_FoliosDT:293])
						LOG_RegisterEvt ("El Código de Autorización de Folios (CAF), id: "+String:C10([ACT_FoliosDT:293]id:1)+", fue eliminado.")
						ACTcfgbol_OpcionesDTE ("CargaArreglosCAF";->alACTcfg_Razones{atACTcfg_Razones})
					End if 
				End if 
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
	Else 
		CD_Dlog (0;__ ("Antes de enviar el código de autorización de folios debe verificar la configuración inicial."))
	End if 
End if 
  //KRL_UnloadReadOnly (->[ACT_RazonesSociales])