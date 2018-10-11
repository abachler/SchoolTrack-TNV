If (aYearsACT=1)
	Case of 
		: (alProEvt=1)
			$line:=AL_GetLine (xALP_DocsDepositados)
			If (((Shift down:C543) & (Macintosh control down:C544) & (Macintosh option down:C545)) | ((Shift down:C543) & (Windows Alt down:C563) & (Windows Ctrl down:C562)))
				If (USR_IsGroupMember_by_GrpName ("Administración"))
					$msg:=__ ("¿Desea realmente anular el depósito?")
					$r:=CD_Dlog (0;$msg;__ ("");__ ("No");__ ("Anular"))
					If ($r=2)
						START TRANSACTION:C239
						READ WRITE:C146([ACT_Documentos_de_Pago:176])
						QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=aACT_ApdosDDID{$line};*)
						QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
						$lockedDocdePago:=Locked:C147([ACT_Documentos_de_Pago:176])
						[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
						[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
						  //SAVE RECORD([ACT_Documentos_de_Pago])
						ACTdp_fSave 
						ACTpgs_CreacionDocCartera (-4)
						If (Not:C34($lockedDocdePago) & (ok=1))
							VALIDATE TRANSACTION:C240
							$0:=1
						Else 
							CANCEL TRANSACTION:C241
							  //$msg:="El documento de pago está en uso. No puede ser eliminado."
							CD_Dlog (0;__ ("El documento de pago está en uso. No puede ser eliminado."))
						End if 
						AL_UpdateArrays (xALP_DocsDepositados;0)
						ACTpp_LoadDocsDepositados 
						AL_UpdateArrays (xALP_DocsDepositados;-2)
						AL_SetLine (xALP_DocsDepositados;0)
						ALP_SetAlternateLigneColor (xALP_DocsDepositados;Size of array:C274(aACT_ApdosDDID))
						_O_DISABLE BUTTON:C193(bProtestar)
					End if 
				Else 
					USR_ALERT_UserHasNoRights (4)
				End if 
			Else 
				IT_SetButtonState (($line#0);->bProtestar)
			End if 
		: (alProEvt=2)
			$line:=AL_GetLine (xALP_DocsDepositados)
			
			  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
			$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
			$yBWR_currentTable:=yBWR_currentTable
			$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
			$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
			
			  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
			yBWR_currentTable:=->[ACT_Documentos_de_Pago:176]
			vyBWR_CustomArrayPointer:=->aACT_ApdosDDID
			aACT_ApdosDDID:=$line
			vyBWR_CustonFieldRefPointer:=->[ACT_Documentos_de_Pago:176]ID:1
			vlBWR_BrowsingMethod:=BWR Array Browsing
			
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=aACT_ApdosDDID{$line};*)
			QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
			
			WDW_OpenFormWindow (->[ACT_Documentos_de_Pago:176];"Input";0;4;__ ("Detalle del Documento Depositado"))
			DIALOG:C40([ACT_Documentos_de_Pago:176];"Input")
			CLOSE WINDOW:C154
			UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
			UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
			UNLOAD RECORD:C212([ACT_Pagos:172])
			
			  //reestablecemos el metodo de navegación previo
			vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
			yBWR_currentTable:=$yBWR_currentTable
			vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
			vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
			BWR_SetInputFormButtons 
			
	End case 
Else 
	IT_SetButtonState (False:C215;->bProtestar)
End if 