//%attributes = {}
  //xAL_ACT_CB_GenDesctos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
ARRAY INTEGER:C220($aInt;2;0)

AL_GetCurrCell (xALP_Desctos;$col;$row)
$0:=True:C214
If ($2=7)
	  //$0:=False
	$0:=True:C214  //20180907 RCH Ticket 215404
Else 
	If (b1=1)
		$decimales:=1
	Else 
		If ($col>3)
			$vt_monedaItem:=atACT_DesctosMoneda{Find in array:C230(alACT_RefsCargos;alACT_GlosasIDs{$col-3})}
			$decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaItem))
		Else 
			$vt_monedaItem:=ST_GetWord (ACT_DivisaPais ;1;";")
			$decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaItem))
		End if 
	End if 
	
	If (b1=1)
		Case of 
			: ($col=2)
				If ((arACT_DesctoXAlumno{$row}>100) | (arACT_DesctoXAlumno{$row}<0))
					BEEP:C151
					arACT_DesctoXAlumno{$row}:=arACT_DesctoXAlumno{0}
					  //$0:=False
				Else 
					arACT_DesctoXAlumno{$row}:=Round:C94(arACT_DesctoXAlumno{$row};<>vlACT_Decimales)
				End if 
			: ($col>3)
				If ((apACT_Glosas{$col-3}->{$row}>100) | (apACT_Glosas{$col-3}->{$row}<0))
					BEEP:C151
					apACT_Glosas{$col-3}->{$row}:=apACT_Glosas{$col-3}->{0}
					  //$0:=False
				Else 
					apACT_Glosas{$col-3}->{$row}:=Round:C94(apACT_Glosas{$col-3}->{$row};$decimales)
				End if 
		End case 
	Else 
		Case of 
			: ($col=2)
				If (arACT_DesctoXAlumno{$row}<0)
					BEEP:C151
					arACT_DesctoXAlumno{$row}:=arACT_DesctoXAlumno{0}
					  //$0:=False
				Else 
					arACT_DesctoXAlumno{$row}:=Round:C94(arACT_DesctoXAlumno{$row};<>vlACT_Decimales)
				End if 
			: ($col>3)
				If (apACT_Glosas{$col-3}->{$row}<0)
					BEEP:C151
					apACT_Glosas{$col-3}->{$row}:=apACT_Glosas{$col-3}->{0}
					  //$0:=False
				Else 
					apACT_Glosas{$col-3}->{$row}:=Round:C94(apACT_Glosas{$col-3}->{$row};$decimales)
				End if 
		End case 
	End if 
	If ($0)
		Case of 
			: (($col>3) & ($row=1))
				AL_SetHdrStyle (xALP_Desctos;$col;"Tahoma";9;1)
				$size:=Size of array:C274(atACT_NombreAlumnos)
				ARRAY INTEGER:C220($aInt;2;0)
				ARRAY INTEGER:C220($aInt;2;$size)
				For ($i;1;$size)
					$aInt{1}{$i}:=1
					$aInt{2}{$i}:=(3*$i)-1
				End for 
				AL_SetCellStyle (xALP_Desctos;0;0;0;0;$aInt;0)
			: ($col>3)
				AL_SetHdrStyle (xALP_Desctos;$col;"Tahoma";9;1)
				AL_SetCellStyle (xALP_Desctos;1;$row-1;0;0;$aInt;0)
			: ($col=2)
				AL_SetCellStyle (xALP_Desctos;1;$row;0;0;$aInt;0)
				For ($header;4;Size of array:C274(atACT_Glosas)+3)
					AL_SetHdrStyle (xALP_Desctos;$header;"Tahoma";9;1)
				End for 
		End case 
		ARRAY INTEGER:C220($aInt;2;0)
		AL_SetCellStyle (xALP_Desctos;$col;$row;0;0;$aInt;0)
		If (AL_GetCellMod (xALP_Desctos)=1)
			Case of 
				: (($col>3) & ($row=1))
					For ($i;3;Size of array:C274(apACT_Glosas{$col-3}->);3)
						$vt_monedaItem:=atACT_DesctosMoneda{Find in array:C230(alACT_RefsCargos;alACT_GlosasIDs{$col-3})}
						
						If (b2=1)
							$newDesctoCta:=ACTut_retornaMontoEnMoneda (arACT_DesctoXAlumno{$i-1};ST_GetWord (ACT_DivisaPais ;1;";");Current date:C33(*);$vt_monedaItem)
							$newDescto:=$newDesctoCta+apACT_Glosas{$col-3}->{1}+apACT_Glosas{$col-3}->{$i}
							If ($newDescto>apACT_Glosas{$col-3}->{$i-1})
								$newDescto:=apACT_Glosas{$col-3}->{$i-1}
								If (Not:C34(ACTdesctos_FindCell ($col;$i;->aDisColumns;->aDisRows)))
									AL_SetCellColor (xALP_Desctos;$col;$i;0;0;$aInt;"White";0;"Red";0)
								End if 
							Else 
								If (Not:C34(ACTdesctos_FindCell ($col;$i;->aDisColumns;->aDisRows)))
									If (Mod:C98($i;2)=0)
										AL_SetCellRGBColor (xALP_Desctos;$col;$i;0;0;$aInt;0;0;0;255;255;255)
									Else 
										AL_SetCellRGBColor (xALP_Desctos;$col;$i;0;0;$aInt;0;0;0;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue)
									End if 
								End if 
							End if 
						Else 
							$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaItem))
							$desctoTotal:=apACT_Glosas{$col-3}->{$i}+apACT_Glosas{$col-3}->{1}+arACT_DesctoXAlumno{$i-1}
							If ($desctoTotal>100)
								$desctoTotal:=100
								If (Not:C34(ACTdesctos_FindCell ($col;$i;->aDisColumns;->aDisRows)))
									AL_SetCellColor (xALP_Desctos;$col;$i;0;0;$aInt;"White";0;"Red";0)
								End if 
							Else 
								If (Not:C34(ACTdesctos_FindCell ($col;$i;->aDisColumns;->aDisRows)))
									If (Mod:C98($i;2)#0)
										AL_SetCellRGBColor (xALP_Desctos;$col;$i;0;0;$aInt;0;0;0;255;255;255)
									Else 
										AL_SetCellRGBColor (xALP_Desctos;$col;$i;0;0;$aInt;0;0;0;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue)
									End if 
								End if 
							End if 
							$newDescto:=Round:C94(apACT_Glosas{$col-3}->{$i-1}*$desctoTotal/100;$vl_decimales)
						End if 
						apACT_Glosas{$col-3}->{$i+1}:=apACT_Glosas{$col-3}->{$i-1}-$newDescto
					End for 
				: ($col>3)
					$vt_monedaItem:=atACT_DesctosMoneda{Find in array:C230(alACT_RefsCargos;alACT_GlosasIDs{$col-3})}
					If (b2=1)
						$newDesctoCta:=ACTut_retornaMontoEnMoneda (arACT_DesctoXAlumno{$row-1};ST_GetWord (ACT_DivisaPais ;1;";");Current date:C33(*);$vt_monedaItem)
						$newDescto:=$newDesctoCta+apACT_Glosas{$col-3}->{1}+apACT_Glosas{$col-3}->{$row}
						If ($newDescto>apACT_Glosas{$col-3}->{$row-1})
							$newDescto:=apACT_Glosas{$col-3}->{$row-1}
							AL_SetCellColor (xALP_Desctos;$col;$row;0;0;$aInt;"White";0;"Red";0)
						Else 
							If (Mod:C98($row;2)=0)
								AL_SetCellRGBColor (xALP_Desctos;$col;$row;0;0;$aInt;0;0;0;255;255;255)
							Else 
								AL_SetCellRGBColor (xALP_Desctos;$col;$row;0;0;$aInt;0;0;0;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue)
							End if 
						End if 
					Else 
						$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaItem))
						$desctoTotal:=apACT_Glosas{$col-3}->{$row}+apACT_Glosas{$col-3}->{1}+arACT_DesctoXAlumno{$row-1}
						If ($desctoTotal>100)
							$desctoTotal:=100
							AL_SetCellColor (xALP_Desctos;$col;$row;0;0;$aInt;"White";0;"Red";0)
						Else 
							If (Mod:C98($row;2)#0)
								AL_SetCellRGBColor (xALP_Desctos;$col;$row;0;0;$aInt;0;0;0;255;255;255)
							Else 
								AL_SetCellRGBColor (xALP_Desctos;$col;$row;0;0;$aInt;0;0;0;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue)
							End if 
						End if 
						$newDescto:=Round:C94(apACT_Glosas{$col-3}->{$row-1}*$desctoTotal/100;$vl_decimales)
					End if 
					apACT_Glosas{$col-3}->{$row+1}:=apACT_Glosas{$col-3}->{$row-1}-$newDescto
				: ($col=2)
					For ($i;1;Size of array:C274(apACT_Glosas))
						$vt_monedaItem:=atACT_DesctosMoneda{Find in array:C230(alACT_RefsCargos;alACT_GlosasIDs{$i})}
						If (b2=1)
							$newDesctoCta:=ACTut_retornaMontoEnMoneda (arACT_DesctoXAlumno{$row};ST_GetWord (ACT_DivisaPais ;1;";");Current date:C33(*);$vt_monedaItem)
							$newDescto:=$newDesctoCta+apACT_Glosas{$i}->{1}+apACT_Glosas{$i}->{$row+1}
							If ($newDescto>apACT_Glosas{$i}->{$row})
								$newDescto:=apACT_Glosas{$i}->{$row}
								If (Not:C34(ACTdesctos_FindCell ($i+3;$row+1;->aDisColumns;->aDisRows)))
									AL_SetCellColor (xALP_Desctos;$i+3;$row+1;0;0;$aInt;"White";0;"Red";0)
								End if 
							Else 
								If (Not:C34(ACTdesctos_FindCell ($i+3;$row+1;->aDisColumns;->aDisRows)))
									If (Mod:C98($row+1;2)=0)
										AL_SetCellRGBColor (xALP_Desctos;$i+3;$row+1;0;0;$aInt;0;0;0;255;255;255)
									Else 
										AL_SetCellRGBColor (xALP_Desctos;$i+3;$row+1;0;0;$aInt;0;0;0;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue)
									End if 
								End if 
							End if 
						Else 
							$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaItem))
							$desctoTotal:=apACT_Glosas{$i}->{$row+1}+apACT_Glosas{$i}->{1}+arACT_DesctoXAlumno{$row}
							If ($desctoTotal>100)
								$desctoTotal:=100
								If (Not:C34(ACTdesctos_FindCell ($i+3;$row+1;->aDisColumns;->aDisRows)))
									AL_SetCellColor (xALP_Desctos;$i+3;$row+1;0;0;$aInt;"White";0;"Red";0)
								End if 
							Else 
								If (Not:C34(ACTdesctos_FindCell ($i+3;$row+1;->aDisColumns;->aDisRows)))
									If (Mod:C98($row+1;2)#0)
										AL_SetCellRGBColor (xALP_Desctos;$i+3;$row+1;0;0;$aInt;0;0;0;255;255;255)
									Else 
										AL_SetCellRGBColor (xALP_Desctos;$i+3;$row+1;0;0;$aInt;0;0;0;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue)
									End if 
								End if 
							End if 
							$newDescto:=Round:C94(apACT_Glosas{$i}->{$row}*$desctoTotal/100;$vl_decimales)
						End if 
						apACT_Glosas{$i}->{$row+2}:=apACT_Glosas{$i}->{$row}-$newDescto
					End for 
			End case 
			ACTdesctos_CalculaTotales 
		End if 
		For ($w;1;Size of array:C274(alACT_GlosasIDs)+1)
			aFooterL2{$w}:=Round:C94(aFooterL1{$w}-aFooterL3{$w};$decimales)
			$footer:=String:C10(aFooterL1{$w};"|Despliegue_ACT_Pagos")+"\r"+String:C10(aFooterL2{$w};"|Despliegue_ACT_Pagos")+"\r"+String:C10(aFooterL3{$w};"|Despliegue_ACT_Pagos")
			AL_SetFooters (xALP_Desctos;$w+3;1;$footer)
		End for 
		AL_UpdateArrays (xALP_Desctos;-1)
		REDRAW WINDOW:C456
	End if 
End if 