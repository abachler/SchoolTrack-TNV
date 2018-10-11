C_POINTER:C301($y_variableColumna)
C_LONGINT:C283($l_colum;$l_linea)
$result:=Pop up menu:C542(AT_array2text (->atMPA_EtapasArea;";");0)
vt_nivel:=atMPA_EtapasArea{$result}
LISTBOX GET CELL POSITION:C971(lb_dimaprendizajes;$l_colum;$l_linea;$y_variableColumna)
If ($l_linea>0)
	MPA_CargaDatosColorCeldas ("dimension";->lb_dimaprendizajes;alMPA_NivelDesde{$result};alMPA_NivelHasta{$result})
Else 
	LISTBOX GET CELL POSITION:C971(lb_ejesaprendizajes;$l_colum;$l_linea;$y_variableColumna)
	If ($l_linea>0)
		MPA_CargaDatosColorCeldas ("eje";->lb_ejesaprendizajes;alMPA_NivelDesde{$result};alMPA_NivelHasta{$result})
	Else 
		MPA_CargaDatosColorCeldas ("area";->lb_asignaturasArea;alMPA_NivelDesde{$result};alMPA_NivelHasta{$result})
	End if 
End if 

