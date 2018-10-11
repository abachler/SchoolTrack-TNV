ARRAY LONGINT:C221($al_SelectedLines;0)
ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
$line:=AL_GetLine (ALP_AvisosAgrupadosXPagar)
Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (ALP_AvisosAgrupadosXPagar)
		If ($col=1)
			If ($line#0)
				If (abACT_ASelectedAgrupado{$line})
					abACT_ASelectedAgrupado{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAgrupado{$line})
				Else 
					abACT_ASelectedAgrupado{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAgrupado{$line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)
			End if 
		End if 
		
	: (alProEvt=2)
		APPEND TO ARRAY:C911($al_SelectedLines;$line)
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		ARRAY LONGINT:C221($al_SelectedLines;0)
	: (alProEvt=5)
		If (abACT_ASelectedAgrupado{$line})
			$text:="Mostrar cargos del período...;(-;No pagar"
		Else 
			$text:="Mostrar cargos del período...;(-;Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				ACTpgs_LoadCargosAviso (->$al_SelectedLines)
				ARRAY LONGINT:C221($al_SelectedLines;0)
			: ($choice=3)
				If (abACT_ASelectedAgrupado{$line})
					abACT_ASelectedAgrupado{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAgrupado{$line})
				Else 
					abACT_ASelectedAgrupado{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAgrupado{$line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)
			: ($choice=5)
				For ($i;1;Size of array:C274(abACT_ASelectedAgrupado))
					abACT_ASelectedAgrupado{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAgrupado{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)
			: ($choice=6)
				For ($i;1;Size of array:C274(abACT_ASelectedAgrupado))
					abACT_ASelectedAgrupado{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAgrupado{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)
		End case 
	: (alProEvt=6)
		$text:="(Mostrar cargos del período...."
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ASelectedAgrupado))
					abACT_ASelectedAgrupado{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAgrupado{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedAgrupado))
					abACT_ASelectedAgrupado{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAgrupado{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)
		End case 
End case 

ACTpgs_MarkNotMark ("DesdeAgrupado";->$al_SelectedLines)
If (modCargos)
	ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
End if 
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas4")

ACTdesc_OpcionesGenerales ("CalculaDesdeIngresoPago")  //20170506 RCH

AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)