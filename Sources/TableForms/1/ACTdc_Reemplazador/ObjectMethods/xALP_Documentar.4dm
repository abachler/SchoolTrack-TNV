Case of 
	: (alProEvt=5)
		$line:=AL_GetLine (Self:C308->)
		If ($line>0)
			$text:="Observaciones"
			$choice:=Pop up menu:C542($text)
			If ($choice=1)
				vtACT_ObsDocs:=atACT_ObsDoc{$line}
				WDW_OpenFormWindow (->[xxACT_DesctosXItem:103];"ACTpgs_ObsDocumentar";0;Palette form window:K39:9;__ ("Observaciones Documento"))
				DIALOG:C40([xxACT_DesctosXItem:103];"ACTpgs_ObsDocumentar")
				CLOSE WINDOW:C154
				If (ok=1)
					atACT_ObsDoc{$line}:=vtACT_ObsDocs
				End if 
			End if 
		End if 
End case 