C_LONGINT:C283($vl_col;$vl_line)
C_POINTER:C301($vy_var)

LISTBOX GET CELL POSITION:C971(lb_reglas;$vl_col;$vl_line;$vy_var)
If ($vl_line>0)
	If (Size of array:C274($vy_var->)>0)
		If ($vl_line>0)
			$l_resp:=CD_Dlog (0;"Se eliminará la definición de regla de asignación de matrices."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
			If ($l_resp=1)
				$l_hecho:=Num:C11(ACTcfg_OpcionesListaMatrices ("EliminaLinea";->alACT_ReglasMatricesID{$vl_line}))
				If ($l_hecho=0)
					CD_Dlog (0;"El registro no pudo ser eliminado.")
				Else 
					ACTcfg_OpcionesListaMatrices ("onLoadConf")
				End if 
			End if 
		End if 
	Else 
		BEEP:C151
	End if 
End if 