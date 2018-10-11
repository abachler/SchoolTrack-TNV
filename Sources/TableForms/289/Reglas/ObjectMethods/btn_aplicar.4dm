C_LONGINT:C283($l_resp)
If (Size of array:C274(atACT_ReglasMatricesNombre)>0)
	$l_resp:=CD_Dlog (0;"Si continúa se asignarán las matrices de cargo según las configuraciones de las reglas."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
	If ($l_resp=1)
		ACTcfg_OpcionesListaMatrices ("Guardar")
		ACTcfg_OpcionesListaMatrices ("AplicaMatrices")
	End if 
Else 
	BEEP:C151
End if 