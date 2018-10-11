Case of 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Double Clicked:K2:5))
		
		C_TEXT:C284($vt_linea1;$vt_linea2)
		C_LONGINT:C283($l_col;$l_fila)
		C_POINTER:C301($y_array;$y_field1;$y_field2)
		
		LISTBOX GET CELL POSITION:C971(lb_centroCostoXNivel;$l_col;$l_fila;$y_array)
		
		$vt_linea1:=String:C10(alACT_CCXN_NivelID{$l_fila})+"."+atACT_CCXN_Nivel{$l_fila}+"."+atACT_CCXN_CentroCosto{$l_fila}+"."+atACT_CCXN_CentroCostoContra{$l_fila}
		$vt_linea1:=$vt_linea1+atACT_CCXN_CodAux{$l_fila}+"."+atACT_CCXN_CodAuxCC{$l_fila}+"."+atACT_CCXN_CodPlanCtas{$l_fila}+"."+atACT_CCXN_CodPlanCCtas{$l_fila}
		
		Case of 
			: ($l_col=1)
				
			: (($l_col=6) | ($l_col=9))  // centro de costos y contra centro de costos
				If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))  //20131007 RCH si no tiene privilegios para editar, no puede hacerlo
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;1)
					ARRAY TEXT:C222(atACT_CentroCosto;0)
					COPY ARRAY:C226(<>asACT_Centro;atACT_CentroCosto)
					
					APPEND TO ARRAY:C911(atACT_CentroCosto;__ ("Ninguno"))
					
					<>aChoicePtrs{1}:=->atACT_CentroCosto
					TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1)
					If (ok=1)
						
						If (atACT_CentroCosto{choiceIdx}=__ ("Ninguno"))
							atACT_CentroCosto{choiceIdx}:=""
						End if 
						$y_array->{$l_fila}:=atACT_CentroCosto{choiceIdx}
						
						If (vbACTcfg_EnItemsEsp)
							$y_field1:=->vsACT_CentroInteresesIE  //20131007 RCH
							$y_field2:=->vsACT_CCentroInteresesIE
						Else 
							$y_field1:=->[xxACT_Items:179]Centro_de_Costos:21
							$y_field2:=->[xxACT_Items:179]CCentro_de_costos:23
						End if 
						
						Case of 
							: ($l_col=6)
								If ($y_field1->#$y_array->{$l_fila})
									abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
								End if 
							: ($l_col=9)
								If ($y_field2->#$y_array->{$l_fila})
									abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
								End if 
						End case 
						
						
						If ((atACT_CCXN_CentroCosto{$l_fila}=$y_field1->) & (atACT_CCXN_CentroCostoContra{$l_fila}=$y_field2->))
							abACT_CCXN_UsarConfItem{$l_fila}:=True:C214
						End if 
						
					End if 
				Else 
					BEEP:C151
				End if 
				
				
			: (($l_col=5) | ($l_col=8))  // codigos auxiliares de cuenta y de contracuentas
				If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;1)
					ARRAY TEXT:C222(atACT_CodAuxiliares;0)
					COPY ARRAY:C226(<>asACT_CodAuxCta;atACT_CodAuxiliares)
					
					APPEND TO ARRAY:C911(atACT_CodAuxiliares;__ ("Ninguno"))
					<>aChoicePtrs{1}:=->atACT_CodAuxiliares
					
					If ($l_col=5)
						TBL_ShowChoiceList (0;"Seleccione código auxiliar";1)
					Else 
						TBL_ShowChoiceList (0;"Seleccione código auxiliar de contra cuentas";1)
					End if 
					
					If (ok=1)
						
						If (atACT_CodAuxiliares{choiceIdx}=__ ("Ninguno"))
							atACT_CodAuxiliares{choiceIdx}:=""
						End if 
						$y_array->{$l_fila}:=atACT_CodAuxiliares{choiceIdx}
						
						If (vbACTcfg_EnItemsEsp)
							$y_field1:=->vsACT_CodInteresesIE
							$y_field2:=->vsACT_CCodInteresesIE
						Else 
							$y_field1:=->[xxACT_Items:179]CodAuxCta:27
							$y_field2:=->[xxACT_Items:179]CodAuxCCta:28
						End if 
						
						Case of 
							: ($l_col=5)
								If ($y_field2->#$y_array->{$l_fila})
									abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
								End if 
							: ($l_col=8)
								If ($y_field2->#$y_array->{$l_fila})
									abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
								End if 
						End case 
						
						
						If ((atACT_CCXN_CodAux{$l_fila}=$y_field1->) & (atACT_CCXN_CodAuxCC{$l_fila}=$y_field2->))
							abACT_CCXN_UsarConfItem{$l_fila}:=True:C214
						Else 
							abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
						End if 
						
					End if 
				Else 
					BEEP:C151
				End if 
				
				
			: (($l_col=4) | ($l_col=7))  // codigo plan de cuentas y contracuentas contables
				If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
					
					C_TEXT:C284($vt_CodAuxCta)
					
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;1)
					
					ARRAY TEXT:C222(atACT_PlanesCta;0)
					ARRAY TEXT:C222(atACT_CodAuxiliares;0)
					ARRAY TEXT:C222(atACT_TempPlanesCta;0)
					
					COPY ARRAY:C226(<>asACT_CuentaCta;atACT_PlanesCta)
					COPY ARRAY:C226(<>asACT_CodAuxCta;atACT_CodAuxiliares)
					COPY ARRAY:C226(<>asACT_CuentaCta;atACT_TempPlanesCta)
					
					APPEND TO ARRAY:C911(atACT_PlanesCta;__ ("Ninguno"))
					APPEND TO ARRAY:C911(atACT_CodAuxiliares;__ ("Ninguno"))
					<>aChoicePtrs{1}:=->atACT_PlanesCta
					
					If ($l_col=4)
						TBL_ShowChoiceList (0;"Seleccione código plan de cuentas";1)
					Else 
						TBL_ShowChoiceList (0;"Seleccione código plan de contra cuentas";1)
					End if 
					
					If (ok=1)
						
						If (atACT_PlanesCta{choiceIdx}=__ ("Ninguno"))
							atACT_PlanesCta{choiceIdx}:=""
							atACT_CodAuxiliares{choiceIdx}:=""
						End if 
						
						$y_array->{$l_fila}:=atACT_PlanesCta{choiceIdx}
						If (Find in array:C230(atACT_TempPlanesCta;atACT_PlanesCta{choiceIdx})>-1)
							$vt_CodAuxCta:=atACT_CodAuxiliares{Find in array:C230(atACT_TempPlanesCta;atACT_PlanesCta{choiceIdx})}
						Else 
							$vt_CodAuxCta:=""
						End if 
						
						
						
						If (vbACTcfg_EnItemsEsp)
							$y_field1:=->vsACT_CentroInteresesIE
							$y_field2:=->vsACT_CCentroInteresesIE
						Else 
							$y_field1:=->[xxACT_Items:179]No_de_Cuenta_Contable:15
							$y_field2:=->[xxACT_Items:179]No_CCta_contable:22
						End if 
						
						Case of 
							: ($l_col=4)
								atACT_CCXN_CodAux{$l_fila}:=$vt_CodAuxCta
								If ($y_field2->#$y_array->{$l_fila})
									abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
								End if 
							: ($l_col=7)
								atACT_CCXN_CodAuxCC{$l_fila}:=$vt_CodAuxCta
								If ($y_field2->#$y_array->{$l_fila})
									abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
								End if 
						End case 
						
						
						If ((atACT_CCXN_CodPlanCtas{$l_fila}=$y_field1->) & (atACT_CCXN_CodPlanCCtas{$l_fila}=$y_field2->))
							abACT_CCXN_UsarConfItem{$l_fila}:=True:C214
						Else 
							abACT_CCXN_UsarConfItem{$l_fila}:=False:C215
						End if 
						
					End if 
					
					
					
					
					
				Else 
					BEEP:C151
				End if 
		End case 
		
		$vt_linea2:=String:C10(alACT_CCXN_NivelID{$l_fila})+"."+atACT_CCXN_Nivel{$l_fila}+"."+atACT_CCXN_CentroCosto{$l_fila}+"."+atACT_CCXN_CentroCostoContra{$l_fila}
		$vt_linea2:=$vt_linea2+atACT_CCXN_CodAux{$l_fila}+"."+atACT_CCXN_CodAuxCC{$l_fila}+"."+atACT_CCXN_CodPlanCtas{$l_fila}+"."+atACT_CCXN_CodPlanCCtas{$l_fila}
		
		
		abACT_CCXN_UsarConfItem{$l_fila}:=Choose:C955($vt_linea1=$vt_linea2;True:C214;False:C215)
		
		
		
End case 