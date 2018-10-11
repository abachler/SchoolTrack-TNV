Case of 
	: (alProEvt=1)
		
	: (alProEvt=2)
		C_TEXT:C284($varName)
		C_LONGINT:C283($tableNum;$fieldNum)
		C_LONGINT:C283($centroCostos;$planCuenta;$codAuxCta;$glosaCta)
		C_POINTER:C301($ptr)
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		  //$vx_pointer:=aQR_Pointer2{$col}
		vQR_Pointer1:=aQR_Pointer2{$col}
		
		AL_UpdateArrays (Self:C308->;0)
		Case of 
			: (aQR_Text92{$col}="CuentaContable@")
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>asACT_CuentaCta
				<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
				<>aChoicePtrs{3}:=-><>asACT_GlosaCta
				TBL_ShowChoiceList (0;"Seleccione la Cuenta";2)
				If (ok=1)
					$vt_formato:=ST_GetWord (aQR_Text92{$col};2;";")
					$vl_largo:=Num:C11(ST_GetWord (aQR_Text92{$col};3;";"))
					$vt_relleno:=ST_GetWord (aQR_Text92{$col};4;";")
					$vt_align:=ST_GetWord (aQR_Text92{$col};5;";")
					
					RESOLVE POINTER:C394(vQR_Pointer1;$varName;$tableNum;$fieldNum)
					vQR_Pointer3:=Get pointer:C304($varName)
					If (vlACTusr_modoAsignacionCTA=0)
						If ($vt_relleno="")
							vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo)
						Else 
							vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
						End if 
					End if 
					
					If (vlACTusr_modoAsignacionCTA=1)
						For ($i;$row;Size of array:C274(vQR_Pointer3->))
							If ($vt_relleno="")
								vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo)
							Else 
								vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
							End if 
						End for 
					End if 
					
					If (vlACTusr_modoAsignacionCTA=2)
						If ($vt_relleno="")
							vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo)
						Else 
							vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
						End if 
						$resp:=CD_Dlog (0;"¿Desea asignar los mismos datos a todas las líneas del archivo?";"";"Si";"No")
						If ($resp=1)
							For ($i;1;Size of array:C274(vQR_Pointer3->))
								If ($vt_relleno="")
									vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo)
								Else 
									vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
								End if 
							End for 
						End if 
					End if 
					
					
					
				End if 
			: (aQR_Text92{$col}="CentroCosto@")
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				<>aChoicePtrs{1}:=-><>asACT_Centro
				TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1)
				If (ok=1)
					$vt_formato:=ST_GetWord (aQR_Text92{$col};2;";")
					$vl_largo:=Num:C11(ST_GetWord (aQR_Text92{$col};3;";"))
					$vt_relleno:=ST_GetWord (aQR_Text92{$col};4;";")
					$vt_align:=ST_GetWord (aQR_Text92{$col};5;";")
					  //If ($vt_relleno="")
					  //$vx_pointer->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo)
					  //Else 
					  //$vx_pointer->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
					  //End if 
					RESOLVE POINTER:C394(vQR_Pointer1;$varName;$tableNum;$fieldNum)
					vQR_Pointer3:=Get pointer:C304($varName)
					If ($vt_relleno="")
						vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo)
					Else 
						vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (<>asACT_CuentaCta{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
					End if 
				End if 
			Else 
				If (aQR_Text92{$col}#"")
					  //$vx_getPointer:=Get pointer(ST_GetWord (aQR_Text92{$col};1;";"))
					vQR_Pointer2:=Get pointer:C304(ST_GetWord (aQR_Text92{$col};1;";"))
					If (Not:C34(Undefined:C82(vQR_Pointer2)))
						ARRAY POINTER:C280(<>aChoicePtrs;0)
						ARRAY POINTER:C280(<>aChoicePtrs;1)
						<>aChoicePtrs{1}:=vQR_Pointer2
						TBL_ShowChoiceList (0;"Seleccione...";1)
						If (ok=1)
							$vt_formato:=ST_GetWord (aQR_Text92{$col};2;";")
							$vl_largo:=Num:C11(ST_GetWord (aQR_Text92{$col};3;";"))
							$vt_relleno:=ST_GetWord (aQR_Text92{$col};4;";")
							$vt_align:=ST_GetWord (aQR_Text92{$col};5;";")
							  //If ($vt_relleno="")
							  //$vx_pointer->{$row}:=ACTabc_GetFieldWithFormat ($vx_getPointer->{choiceidx};$vt_formato;$vl_largo)
							  //Else 
							  //$vx_pointer->{$row}:=ACTabc_GetFieldWithFormat ($vx_getPointer->{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
							  //End if 
							RESOLVE POINTER:C394(vQR_Pointer1;$varName;$tableNum;$fieldNum)
							vQR_Pointer3:=Get pointer:C304($varName)
							RESOLVE POINTER:C394(vQR_Pointer2;$varName;$tableNum;$fieldNum)
							vQR_Pointer4:=Get pointer:C304($varName)
							If ($vt_relleno="")
								vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo)
							Else 
								vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
							End if 
							
							If (vlACTusr_modoAsignacionCC=0)
								If ($vt_relleno="")
									vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo)
								Else 
									vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
								End if 
							End if 
							
							If (vlACTusr_modoAsignacionCC=1)
								For ($i;$row;Size of array:C274(vQR_Pointer3->))
									If ($vt_relleno="")
										vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo)
									Else 
										vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
									End if 
								End for 
							End if 
							
							If (vlACTusr_modoAsignacionCC=2)
								If ($vt_relleno="")
									vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo)
								Else 
									vQR_Pointer3->{$row}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
								End if 
								$resp:=CD_Dlog (0;"¿Desea asignar los mismos datos a todas las líneas del archivo?";"";"Si";"No")
								If ($resp=1)
									For ($i;1;Size of array:C274(vQR_Pointer3->))
										If ($vt_relleno="")
											vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo)
										Else 
											vQR_Pointer3->{$i}:=ACTabc_GetFieldWithFormat (vQR_Pointer4->{choiceidx};$vt_formato;$vl_largo;$vt_relleno;$vt_align)
										End if 
									End for 
								End if 
							End if 
							
							
						End if 
					End if 
				End if 
		End case 
		IT_SetButtonState (($row#0);->bClearCCCbl)
		AL_UpdateArrays (Self:C308->;-2)
End case 