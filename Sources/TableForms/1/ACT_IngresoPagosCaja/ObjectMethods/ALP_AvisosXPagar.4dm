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
	: (alProEvt=2)
		APPEND TO ARRAY:C911($al_SelectedLines;$line)
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		ARRAY LONGINT:C221($al_SelectedLines;0)
	: (alProEvt=5)
		  //$line:=AL_GetLine (ALP_AvisosXPagar)
		If (abACT_ASelectedAvisos{$line})
			$text:="Mostrar cargos del aviso...;(-;No pagar"
		Else 
			$text:="Mostrar cargos del aviso...;(-;Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				ACTpgs_LoadCargosAviso (->$al_SelectedLines)
				ARRAY LONGINT:C221($al_SelectedLines;0)
			: ($choice=3)
				If (abACT_ASelectedAvisos{$line})
					abACT_ASelectedAvisos{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$line})
				Else 
					abACT_ASelectedAvisos{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$line})
				End if 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
			: ($choice=5)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
			: ($choice=6)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		End case 
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
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
					abACT_ASelectedAvisos{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		End case 
End case 

ACTpgs_MarkNotMark ("DesdeAvisos";->$al_SelectedLines)
If (modCargos)
	ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
End if 
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas1")

AL_UpdateArrays (ALP_AvisosXPagar;-1)  //20170719 RCH Para que se vea el monto seleccionado

ACTdesc_OpcionesGenerales ("CalculaDesdeIngresoPago")  //20170506 RCH