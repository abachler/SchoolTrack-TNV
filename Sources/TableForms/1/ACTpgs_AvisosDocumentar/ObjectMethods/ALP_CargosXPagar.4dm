ARRAY LONGINT:C221($al_SelectedLines;0)
C_BOOLEAN:C305($vb_mark)
line:=AL_GetLine (ALP_CargosXPagar)
$col:=AL_GetColumn (ALP_CargosXPagar)

$vl_alpSelected:=0
Case of 
	: (vbACT_CargosDesdeAviso)
		$vl_alpSelected:=ALP_AvisosXPagar
		
	: (vbACT_CargosDesdeItems)
		$vl_alpSelected:=ALP_ItemsXPagar
		
	: (vbACT_CargosDesdeAlumnos)
		$vl_alpSelected:=ALP_AlumnosXPagar
		
	: (vbACT_CargosDesdeAgrupado)
		$vl_alpSelected:=ALP_AvisosAgrupadosXPagar
		
End case 
$lineSelectedArriba:=AL_GetLine ($vl_alpSelected)

ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
  //20120517 RCH NO se estaba actualizando el icono...
AL_UpdateArrays (ALP_CargosXPagar;0)

Case of 
	: ((alProEvt=1) | (alProEvt=2))
		Case of 
			: ($col=1)
				If (abACT_ASelectedCargo{line})
					abACT_ASelectedCargo{line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{line})
				Else 
					abACT_ASelectedCargo{line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;line)
				$vb_mark:=abACT_ASelectedCargo{line}
		End case 
		
	: (alProEvt=5)
		If (abACT_ASelectedCargo{line})
			$text:="No pagar"
		Else 
			$text:="Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				If (abACT_ASelectedCargo{line})
					abACT_ASelectedCargo{line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{line})
				Else 
					abACT_ASelectedCargo{line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;line)
				$vb_mark:=abACT_ASelectedCargo{line}
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ASelectedCargo))
					abACT_ASelectedCargo{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
					$vb_mark:=abACT_ASelectedCargo{$i}
				End for 
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedCargo))
					abACT_ASelectedCargo{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
					$vb_mark:=abACT_ASelectedCargo{$i}
				End for 
		End case 
	: (alProEvt=6)
		$text:="No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				For ($i;1;Size of array:C274(abACT_ASelectedCargo))
					abACT_ASelectedCargo{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
					$vb_mark:=abACT_ASelectedCargo{$i}
				End for 
			: ($choice=2)
				For ($i;1;Size of array:C274(abACT_ASelectedCargo))
					abACT_ASelectedCargo{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
					$vb_mark:=abACT_ASelectedCargo{$i}
				End for 
		End case 
		
End case 
Case of 
	: (vbACT_CargosDesdeAviso)
		ACTpgs_MarkNotMark ("DesdeCargosDeDocumentar";->$al_SelectedLines;->alACT_AIDAviso;->alACT_CIdsAvisos;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->$vb_mark)
		
	: (vbACT_CargosDesdeItems)
		ACTpgs_MarkNotMark ("DesdeCargosDeDocumentar";->$al_SelectedLines;->alACT_RefItem;->alACT_CRefs;->abACT_ASelectedItem;->apACT_ASelectedItem;->$vb_mark)
		
	: (vbACT_CargosDesdeAlumnos)
		ACTpgs_MarkNotMark ("DesdeCargosDeDocumentar";->$al_SelectedLines;->alACT_AIdsCtas;->alACT_CIDCtaCte;->abACT_ASelectedAlumno;->apACT_ASelectedAlumnos;->$vb_mark)
		
	: (vbACT_CargosDesdeAgrupado)
		ARRAY TEXT:C222($at_fechasCargos;0)
		For ($i;1;Size of array:C274($al_SelectedLines))
			APPEND TO ARRAY:C911($at_fechasCargos;String:C10(Year of:C25(adACT_CFechaEmision{$al_SelectedLines{$i}});"0000")+String:C10(Month of:C24(adACT_CFechaEmision{$al_SelectedLines{$i}});"00"))
		End for 
		AT_DistinctsArrayValues (->$at_fechasCargos)
		ACTpgs_MarkNotMark ("DesdeCargosDeDocumentar";->$al_SelectedLines;->atACT_YearMonthAgrupado;->$at_fechasCargos;->abACT_ASelectedAgrupado;->apACT_ASelectedAgrupado;->$vb_mark)
		
End case 

ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
  //20120517 RCH NO se estaba actualizando el icono...
AL_UpdateArrays (ALP_CargosXPagar;-2)
  //
AL_SetLine ($vl_alpSelected;$lineSelectedArriba)
AL_SetLine (ALP_CargosXPagar;line)
ACTpgs_SetObjectsCargosDocument 