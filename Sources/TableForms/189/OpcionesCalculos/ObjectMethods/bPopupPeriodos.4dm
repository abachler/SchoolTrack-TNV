If (vl_PeriodoSeleccionado<=Size of array:C274(atSTR_Periodos_Nombre))
	$result:=Pop up menu:C542(vtSTR_PeriodosPopupMenu;vl_PeriodoSeleccionado)
Else 
	$result:=Pop up menu:C542(vtSTR_PeriodosPopupMenu;0)
End if 


If ($result>Size of array:C274(atSTR_Periodos_Nombre))  //se trata de la evaluación final
	vl_PeriodoSeleccionado:=-1
Else 
	vl_PeriodoSeleccionado:=$result
End if 

MPA_OpcionesCalculos_Finales 

