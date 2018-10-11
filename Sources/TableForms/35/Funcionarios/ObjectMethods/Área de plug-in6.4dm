Case of 
	: (alProEvt=AL Single click event)
		$line:=AL_GetLine (xalp_BUFunc)
		IT_SetButtonState (($line>0);->bDelFunc)
	: (alProEvt=5)
		$line:=AL_GetLine (Self:C308->)
		$lineRec:=AL_GetLine (xalp_BUListaFunc)
		If ($line>0)
			$text:="Observaciones"
			$choice:=Pop up menu:C542($text)
			If ($choice=1)
				vtACT_ObsDocs:=at_observacion{$line}
				WDW_OpenFormWindow (->[xxACT_DesctosXItem:103];"ACTpgs_ObsDocumentar";0;Palette form window:K39:9;__ ("Observaciones Documento"))
				DIALOG:C40([xxACT_DesctosXItem:103];"ACTpgs_ObsDocumentar")
				CLOSE WINDOW:C154
				If (ok=1)
					at_observacion{$line}:=vtACT_ObsDocs
					READ WRITE:C146([BU_Rutas_Inscripciones:35])
					QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=alBU_IdRecorrido{$lineRec};*)
					QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Profesor:3=alBU_PFID{$line})
					If (Records in selection:C76([BU_Rutas_Inscripciones:35])=1)
						[BU_Rutas_Inscripciones:35]Observacion_Inscripcion:10:=at_observacion{$line}
						SAVE RECORD:C53([BU_Rutas_Inscripciones:35])
						KRL_UnloadReadOnly (->[BU_Rutas_Inscripciones:35])
					End if 
				End if 
			End if 
		End if 
End case 