Case of 
	: (alProEvt=AL Single click event)
		$line:=AL_GetLine (Self:C308->)
		$lineRec:=AL_GetLine (xalp_ListaRec)
		IT_SetButtonState (($line>0);->bDelAL)
		$col:=AL_GetColumn (Self:C308->)
		If ($line>0)
			If ($col=4)
				If (atBU_ALDesciende{$line})
					atBU_ALDesciende{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_Acompañado{$line})
				Else 
					atBU_ALDesciende{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_Acompañado{$line})
				End if 
				READ WRITE:C146([BU_Rutas_Inscripciones:35])
				QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=alBU_IdRecorrido{$lineRec};*)
				QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2=alBU_ALID{$line})
				If (Records in selection:C76([BU_Rutas_Inscripciones:35])=1)
					If (atBU_ALDesciende{$line})
						[BU_Rutas_Inscripciones:35]Acompañado_por:7:=atBU_ALAcompañado{$line}
						[BU_Rutas_Inscripciones:35]solo_o_acompañado:5:=True:C214
					Else 
						[BU_Rutas_Inscripciones:35]Acompañado_por:7:=""
						[BU_Rutas_Inscripciones:35]solo_o_acompañado:5:=False:C215
						atBU_ALAcompañado{$line}:=""
					End if 
					SAVE RECORD:C53([BU_Rutas_Inscripciones:35])
					KRL_UnloadReadOnly (->[BU_Rutas_Inscripciones:35])
				End if 
				AL_UpdateArrays (Self:C308->;-1)
			End if 
		End if 
	: (alProEvt=5)
		$line:=AL_GetLine (Self:C308->)
		$lineRec:=AL_GetLine (xalp_ListaRec)
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
					QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2=alBU_ALID{$line})
					If (Records in selection:C76([BU_Rutas_Inscripciones:35])=1)
						[BU_Rutas_Inscripciones:35]Observacion_Inscripcion:10:=at_observacion{$line}
						SAVE RECORD:C53([BU_Rutas_Inscripciones:35])
						KRL_UnloadReadOnly (->[BU_Rutas_Inscripciones:35])
					End if 
				End if 
			End if 
		End if 
End case 

