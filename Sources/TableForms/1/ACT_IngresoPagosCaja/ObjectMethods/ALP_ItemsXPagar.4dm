ARRAY LONGINT:C221($al_SelectedLines;0)
$line:=AL_GetLine (ALP_ItemsXPagar)
ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (ALP_ItemsXPagar)
		If ($col=1)
			If ($line#0)
				If (abACT_ASelectedItem{$line})
					abACT_ASelectedItem{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedItem{$line})
				Else 
					abACT_ASelectedItem{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedItem{$line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				AL_UpdateArrays (ALP_ItemsXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
			End if 
		End if 
		
	: (alProEvt=2)
		APPEND TO ARRAY:C911($al_SelectedLines;$line)
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		ARRAY LONGINT:C221($al_SelectedLines;0)
	: (alProEvt=5)
		  //$line:=AL_GetLine (ALP_ItemsXPagar)
		If (abACT_ASelectedItem{$line})
			$text:="Mostrar cargos del ítem...;(-;No pagar"
		Else 
			$text:="Mostrar cargos del ítem...;(-;Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				ACTpgs_LoadCargosAviso (->$al_SelectedLines)
				ARRAY LONGINT:C221($al_SelectedLines;0)
			: ($choice=3)
				If (abACT_ASelectedItem{$line})
					abACT_ASelectedItem{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedItem{$line})
				Else 
					abACT_ASelectedItem{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedItem{$line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				AL_UpdateArrays (ALP_ItemsXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
			: ($choice=5)
				For ($i;1;Size of array:C274(abACT_ASelectedItem))
					abACT_ASelectedItem{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedItem{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_ItemsXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
			: ($choice=6)
				For ($i;1;Size of array:C274(abACT_ASelectedItem))
					abACT_ASelectedItem{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedItem{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_ItemsXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		End case 
	: (alProEvt=6)
		$text:="(Mostrar cargos del ítem...."
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ASelectedItem))
					abACT_ASelectedItem{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedItem{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_ItemsXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedItem))
					abACT_ASelectedItem{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedItem{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_ItemsXPagar;-1)
				  //ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		End case 
End case 

ACTpgs_MarkNotMark ("DesdeItems";->$al_SelectedLines)
If (modCargos)
	ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
End if 
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas2")

ACTdesc_OpcionesGenerales ("CalculaDesdeIngresoPago")  //20170506 RCH

AL_UpdateArrays (ALP_ItemsXPagar;-1)