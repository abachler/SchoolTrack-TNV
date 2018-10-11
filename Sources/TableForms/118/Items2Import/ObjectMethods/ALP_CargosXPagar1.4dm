If ((alProEvt=1) | (alProEvt=2))
	line:=AL_GetLine (ALP_CargosXPagar)
	Case of 
		: (vb_selectionItems2Pay)
			Case of 
				: (alProEvt=1)
					$col:=AL_GetColumn (ALP_CargosXPagar)
					If (line#0)
						AL_UpdateArrays (ALP_CargosXPagarO;0)
						AL_UpdateArrays (ALP_CargosXPagar;0)
						If (ab_Item2Import{line})
							ACTcfg_OpcionesImportCargos ("EliminaItemRef";->line)
						Else 
							ACTcfg_OpcionesImportCargos ("RecuperaItemRef";->line)
						End if 
						ACTcfg_OpcionesImportCargos ("OrdenaCargos")
						AL_UpdateArrays (ALP_CargosXPagarO;-2)
						AL_UpdateArrays (ALP_CargosXPagar;-2)
						AL_SetLine (ALP_CargosXPagar;line)
						  //AL_UpdateArrays (ALP_CargosXPagar;-1)
						IT_SetButtonState (Size of array:C274(al_refItemsT)>0;->bCont1;->bCont2)
						REDRAW WINDOW:C456
					End if 
					  //End case 
			End case 
	End case 
	Case of 
		: ((alProEvt=1) | (alProEvt=2))
			line:=AL_GetLine (ALP_CargosXPagar)
			If ((line=0) | (line=1))
				_O_DISABLE BUTTON:C193(bSubir)
			Else 
				_O_ENABLE BUTTON:C192(bSubir)
			End if 
			If ((line=0) | (line=Size of array:C274(al_idItems)))
				_O_DISABLE BUTTON:C193(bBajar)
			Else 
				_O_ENABLE BUTTON:C192(bBajar)
			End if 
	End case 
End if 