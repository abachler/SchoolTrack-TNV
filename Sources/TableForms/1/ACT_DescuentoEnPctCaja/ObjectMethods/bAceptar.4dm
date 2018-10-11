If (vr_pctDscto>0)
	ARRAY LONGINT:C221($al_SelectedLines;0)
	Case of 
		: (btn_total=1)
			Case of 
				: (vbACT_CargosDesdeAviso)
					For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
						abACT_ASelectedAvisos{$i}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
						APPEND TO ARRAY:C911($al_SelectedLines;$i)
					End for 
					
				: (vbACT_CargosDesdeItems)
					For ($i;1;Size of array:C274(abACT_ASelectedItem))
						abACT_ASelectedItem{$i}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedItem{$i})
						APPEND TO ARRAY:C911($al_SelectedLines;$i)
					End for 
					
				: (vbACT_CargosDesdeAlumnos)
					For ($i;1;Size of array:C274(abACT_ASelectedAlumno))
						abACT_ASelectedAlumno{$i}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAlumnos{$i})
						APPEND TO ARRAY:C911($al_SelectedLines;$i)
					End for 
					
				: (vbACT_CargosDesdeAgrupado)
					For ($i;1;Size of array:C274(abACT_ASelectedAgrupado))
						abACT_ASelectedAgrupado{$i}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAgrupado{$i})
						APPEND TO ARRAY:C911($al_SelectedLines;$i)
					End for 
			End case 
			
	End case 
	C_REAL:C285($vr_MontoDescuento)
	If (vl_tipoDcto=1)
		Case of 
			: (btn_total=1)
				$vr_MontoDescuento:=Round:C94(vrACT_MontoAdeudadoAfecto*(vr_pctDscto/100);<>vlACT_Decimales)
				
			: (btn_seleccionado=1)
				$vr_MontoDescuento:=Round:C94(vrACT_SeleccionadoAfecto*(vr_pctDscto/100);<>vlACT_Decimales)
				
		End case 
	Else 
		Case of 
			: (btn_total=1)
				$vr_MontoDescuento:=Round:C94(vrACT_MontoAdeudadoExento*(vr_pctDscto/100);<>vlACT_Decimales)
				
			: (btn_seleccionado=1)
				$vr_MontoDescuento:=Round:C94(vrACT_SeleccionadoExento*(vr_pctDscto/100);<>vlACT_Decimales)
				
		End case 
	End if 
	Case of 
		: (vl_tipoDcto=1)
			vrACT_MontoDesctoAfecto:=$vr_MontoDescuento
		: (vl_tipoDcto=2)
			vrACT_MontoDesctoExento:=$vr_MontoDescuento
	End case 
	
	Case of 
		: (vbACT_CargosDesdeAviso)
			ACTpgs_MarkNotMark ("DesdeAvisos";->$al_SelectedLines)
		: (vbACT_CargosDesdeItems)
			ACTpgs_MarkNotMark ("DesdeItems";->$al_SelectedLines)
		: (vbACT_CargosDesdeAlumnos)
			ACTpgs_MarkNotMark ("DesdeAlumnos";->$al_SelectedLines)
		: (vbACT_CargosDesdeAgrupado)
			ACTpgs_MarkNotMark ("DesdeAgrupado";->$al_SelectedLines)
	End case 
	ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
End if 