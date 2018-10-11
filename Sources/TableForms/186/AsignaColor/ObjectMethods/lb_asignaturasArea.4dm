C_LONGINT:C283($i;$l_colum;$l_linea;$srcElement;$srcProcess)
C_POINTER:C301($srcObject;$y_variableColumna)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		LISTBOX GET CELL POSITION:C971(lb_asignaturasArea;$l_colum;$l_linea;$y_variableColumna)
		$l_linea:=Choose:C955($l_linea>0;$l_linea;1)
		QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]ID:1=al_IDAreaAprendizajes{$l_linea})
		BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
		
		  // Para evitar que se carguen los parentesis.
		For ($i;1;Size of array:C274(atMPA_EtapasArea))
			atMPA_EtapasArea{$i}:=Replace string:C233(Replace string:C233(atMPA_EtapasArea{$i};"(";"[");")";"]")
		End for 
		
		vt_nivel:=atMPA_EtapasArea{1}
		MPA_CargaDatosColorCeldas ("area";->lb_asignaturasArea;alMPA_NivelDesde{1};alMPA_NivelHasta{1})
		For ($i;1;Size of array:C274(lb_ejesaprendizajes))
			lb_ejesaprendizajes{$i}:=False:C215
		End for 
		For ($i;1;Size of array:C274(lb_dimaprendizajes))
			lb_dimaprendizajes{$i}:=False:C215
		End for 
		For ($i;1;Size of array:C274(lb_logrosaprendizajes))
			lb_logrosaprendizajes{$i}:=False:C215
		End for 
End case 

