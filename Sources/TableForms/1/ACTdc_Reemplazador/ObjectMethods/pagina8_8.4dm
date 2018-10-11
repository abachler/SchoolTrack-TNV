Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($vl_idApdoAsignado;$i;$vl_choice)
		ARRAY LONGINT:C221($DA_Return;0)
		C_LONGINT:C283($vl_col;$vl_line)
		
		LISTBOX GET CELL POSITION:C971(lb_doc2Reemp;$vl_col;$vl_line;$vy_pointer)
		
		RESOLVE POINTER:C394($vy_pointer;$vt_nomVar;$vl_table;$vl_field)
		
		
		If ($vt_nomVar#"abACTlb_Reemp")
			If ($vl_line<=Size of array:C274(abACTlb_Reemp))
				If ($vt_nomVar#"atACTlb_Estado2Asignar")
					If (abACTlb_Reemp{$vl_line})
						$vt_options:=__ ("(Reemplazar")  //1
					Else 
						$vt_options:=__ ("Reemplazar")  //1
					End if 
					If (abACTlb_Reemp{$vl_line})
						$vt_options:=$vt_options+";"+__ ("No Reemplazar")  //2
					Else 
						$vt_options:=$vt_options+";"+__ ("(No Reemplazar")  //2
					End if 
					$vt_options:=$vt_options+";(-;"
					$vt_options:=$vt_options+__ ("Reemplazar Todos para Apoderado")  //4
					$vt_options:=$vt_options+";"+__ ("No Reemplazar Todos para Apoderado")  //5
					$vt_options:=$vt_options+";"+__ ("(Asignar este estado a todos")  //6
				Else 
					$vt_options:=__ ("(Reemplazar")+";"+__ ("(No Reemplazar")
					$vt_options:=$vt_options+";(-;"
					$vt_options:=$vt_options+__ ("(Reemplazar Todos para Apoderado")  //4
					$vt_options:=$vt_options+";"+__ ("(No Reemplazar Todos para Apoderado")  //5
					$vt_options:=$vt_options+";"+__ ("Asignar este estado a todos los seleccionados")  //6
				End if 
				
				$vl_choice:=Pop up menu:C542($vt_options)
				
				If ($vl_choice>0)
					Case of 
						: ($vl_choice=1)
							abACTlb_Reemp{$vl_line}:=True:C214
							$vl_idApdoAsignado:=alACTlb_ReempTitular{$vl_line}
							  //For ($i;1;Size of array(alACTlb_ReempTitular))
							  //$vl_apoderado:=alACTlb_ReempTitular{$vl_line}
							  //If ($vl_idApdoAsignado#$vl_apoderado)
							  //abACTlb_Reemp{$vl_line}:=False
							  //End if 
							  //End for 
							ACTdc_OpcionesReemplazoMasivo ("ValidaSeleccionados";->$vl_idApdoAsignado)
							
						: ($vl_choice=2)
							abACTlb_Reemp{$vl_line}:=False:C215
							
						: ($vl_choice=4)
							$vl_idApdoAsignado:=alACTlb_ReempTitular{$vl_line}
							alACTlb_ReempTitular{0}:=$vl_idApdoAsignado
							AT_SearchArray (->alACTlb_ReempTitular;"=";->$DA_Return)
							For ($i;1;Size of array:C274($DA_Return))
								abACTlb_Reemp{$DA_Return{$i}}:=True:C214
							End for 
							ACTdc_OpcionesReemplazoMasivo ("ValidaSeleccionados";->$vl_idApdoAsignado)
							
						: ($vl_choice=5)
							$vl_idApdoAsignado:=alACTlb_ReempTitular{$vl_line}
							alACTlb_ReempTitular{0}:=$vl_idApdoAsignado
							AT_SearchArray (->alACTlb_ReempTitular;"=";->$DA_Return)
							For ($i;1;Size of array:C274($DA_Return))
								abACTlb_Reemp{$DA_Return{$i}}:=False:C215
							End for 
						: ($vl_choice=6)
							$vt_Estado:=atACTlb_Estado2Asignar{$vl_line}
							$vl_Estado:=alACTlb_EstadoID2Asignar{$vl_line}
							For ($i;1;Size of array:C274(abACTlb_Reemp))
								If (abACTlb_Reemp{$i})
									atACTlb_Estado2Asignar{$i}:=$vt_Estado
									alACTlb_EstadoID2Asignar{$i}:=$vl_Estado
								End if 
							End for 
					End case 
					
					ACTdc_OpcionesReemplazoMasivo ("CalculaMonto2Reemplazar")
					
				End if 
			End if 
		End if 
End case 