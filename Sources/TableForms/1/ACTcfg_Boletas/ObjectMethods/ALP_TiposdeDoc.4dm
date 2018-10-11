Case of 
	: (alProEvt=1)
		$Col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($row>0);->bDelDoc)
		If ($row>0)
			Case of 
				: ($col=1)
					If (atACT_Cats{$row}#__ ("Seleccionar..."))
						If (abACT_DocPorDefecto{$row}=False:C215)
							$accept:=ACTcfg_SearchCatDocs (alACT_IDCat{$row};$row)
							If ($accept)
								abACT_DocPorDefecto{$row}:=True:C214
								GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_DocPorDefecto{$row})
							Else 
								BEEP:C151
								abACT_DocPorDefecto{$row}:=False:C215
								apACT_DocPorDefecto{$row}:=apACT_DocPorDefecto{$row}*0
							End if 
						Else 
							abACT_DocPorDefecto{$row}:=False:C215
							apACT_DocPorDefecto{$row}:=apACT_DocPorDefecto{$row}*0
						End if 
					End if 
					ACTcfg_SetDocRowsColor 
					If ((abACT_DocPorDefecto{$row}) & (atACT_RazonSocial{$row}#""))
						atACT_RazonSocial{$row}:=""
						alACT_RazonSocial{$row}:=0
						BEEP:C151
					End if 
				: ($col=5)
					If (abACT_DocPorDefecto{$row})
						BEEP:C151
					Else 
						If (abACT_Afecta{$row}=True:C214)
							abACT_Afecta{$row}:=False:C215
							GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_Afecta{$row})
						Else 
							abACT_Afecta{$row}:=True:C214
							GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_Afecta{$row})
						End if 
					End if 
			End case 
		End if 
		AL_UpdateArrays (Self:C308->;-1)
End case 