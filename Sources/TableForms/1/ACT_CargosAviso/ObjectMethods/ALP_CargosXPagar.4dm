ARRAY LONGINT:C221($al_SelectedLines;0)
C_BOOLEAN:C305($vb_mark)
line:=AL_GetLine (ALP_CargosXPagar)
$col:=AL_GetColumn (ALP_CargosXPagar)
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

If ((line=0) | (line=1))
	_O_DISABLE BUTTON:C193(bSubir)
Else 
	_O_ENABLE BUTTON:C192(bSubir)
End if 
If ((line=0) | (line=Size of array:C274(adACT_CFechaEmision)))
	_O_DISABLE BUTTON:C193(bBajar)
Else 
	_O_ENABLE BUTTON:C192(bBajar)
End if 
If (USR_checkRights ("D";->[ACT_Cargos:173]))
	If (line>0)
		_O_ENABLE BUTTON:C192(bDelCargos)
	Else 
		_O_DISABLE BUTTON:C193(bDelCargos)
	End if 
Else 
	_O_DISABLE BUTTON:C193(bDelCargos)
End if 
AL_UpdateArrays (ALP_CargosXPagar;-1)