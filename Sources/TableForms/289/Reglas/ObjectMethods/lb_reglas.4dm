C_LONGINT:C283($vl_col;$vl_line)
C_POINTER:C301($vy_var)

LISTBOX GET CELL POSITION:C971(lb_reglas;$vl_col;$vl_line;$vy_var)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		
		If (Size of array:C274($vy_var->)>0)
			If ($vl_line>0)
				ACTcfg_OpcionesListaMatrices ("EditaLinea";->alACT_ReglasMatricesID{$vl_line})
			End if 
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		If ($vy_var=->alACT_ReglasMatricesAlumnos)
			C_TEXT:C284($t_set)
			$t_set:="CuentasCtesNoAfectas"
			If (abACT_ReglasMatricesInactivo{$vl_line})
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				CREATE SET:C116([ACT_CuentasCorrientes:175];$t_set)
			Else 
				CREATE EMPTY SET:C140([ACT_CuentasCorrientes:175];$t_set)
				For ($l_indice;1;$vl_line-1)
					If (Not:C34(abACT_ReglasMatricesInactivo{$l_indice}))
						ACTcfg_OpcionesListaMatrices ("BuscaCuentas";->alACT_ReglasMatricesID{$l_indice})
						CREATE SET:C116([ACT_CuentasCorrientes:175];"ctasctes")
						UNION:C120($t_set;"ctasctes";$t_set)
					End if 
				End for 
			End if 
			ACTcfg_OpcionesListaMatrices ("VerAlumnos";->alACT_ReglasMatricesID{$vl_line};->$t_set)
			SET_ClearSets ($t_set;"ctasctes")
		End if 
		
	: (Form event:C388=On Row Moved:K2:32)
		ACTcfg_OpcionesListaMatrices ("Guardar")
		
		
End case 

