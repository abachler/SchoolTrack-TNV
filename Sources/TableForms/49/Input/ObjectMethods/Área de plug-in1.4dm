Case of 
	: (alProEvt=1)
		$row:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($row>0);->bDelMetaValue)
	: (alProEvt=AL Single Control Click)
		$col:=AL_GetColumn (Self:C308->)
		If ($col=3)
			$row:=AL_GetLine (Self:C308->)
			IT_SetButtonState (($row>0);->bDelMetaValue)
			If ($row>0)
				If (alADT_MetaDataTypeLong{$row} ?? 1)
					$text:="Eliminar valor;Ingresar o modificar en ventana"
				Else 
					$text:="Eliminar valor"
				End if 
				$choice:=Pop up menu:C542($text)
				Case of 
					: ($choice=1)
						atADT_MetaDataValue{$row}:=""
						AL_UpdateArrays (xALP_MetaDataValues;-1)
					: ($choice=2)
						vt_ScrollableText:=atADT_MetaDataValue{$row}
						WDW_OpenFormWindow (->[xShell_Dialogs:114];"EditScrollableText";-1;Palette form window:K39:9;__ ("Campo: ")+atADT_MetaDataName{$row})
						DIALOG:C40([xShell_Dialogs:114];"EditScrollableText")
						CLOSE WINDOW:C154
						If (ok=1)
							atADT_MetaDataValue{$row}:=vt_ScrollableText
							AL_UpdateArrays (xALP_MetaDataValues;-1)
						End if 
						vt_ScrollableText:=""
				End case 
			End if 
		End if 
End case 