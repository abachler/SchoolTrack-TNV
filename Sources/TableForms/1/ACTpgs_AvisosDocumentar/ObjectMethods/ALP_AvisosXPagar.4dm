ARRAY LONGINT:C221($al_SelectedLines;0)
$line:=AL_GetLine (ALP_AvisosXPagar)
ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (ALP_AvisosXPagar)
		If ($col=1)
			If ($line#0)
				If (abACT_ASelectedAvisos{$line})
					abACT_ASelectedAvisos{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$line})
				Else 
					abACT_ASelectedAvisos{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$line})
				End if 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
			End if 
		End if 
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
	: (alProEvt=2)
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
	: (alProEvt=5)
		If (abACT_ASelectedAvisos{$line})
			$text:="Mostrar cargos del aviso...;(-;No pagar"
		Else 
			$text:="Mostrar cargos del aviso...;(-;Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				ACTpgs_LoadCargosAviso (->$al_SelectedLines)
			: ($choice=3)
				If (abACT_ASelectedAvisos{$line})
					abACT_ASelectedAvisos{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$line})
				Else 
					abACT_ASelectedAvisos{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$line})
				End if 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
			: ($choice=5)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
			: ($choice=6)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
		End case 
		If ($choice#0)
			ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		End if 
	: (alProEvt=6)
		$text:="(Mostrar cargos del aviso...."
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
		End case 
End case 

C_DATE:C307(vdACT_FechaPago)  //pagos desde disponible, pestña Pagos
If (vdACT_FechaPago=!00-00-00!)
	vdACT_FechaPago:=Current date:C33(*)
End if 
ACTpgs_MarkNotMark ("DesdeAvisos";->$al_SelectedLines)
If (modCargos)
	ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
End if 
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas1")