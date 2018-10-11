C_LONGINT:C283($l_colum;$l_linea)
C_POINTER:C301($y_variableColumna)

LISTBOX GET CELL POSITION:C971(ab_observacion;$l_colum;$l_linea;$y_variableColumna)
Case of 
	: (Form event:C388=On Data Change:K2:15)
		ab_entrevista{$l_linea}:=Not:C34($y_variableColumna->{$l_linea})
End case 