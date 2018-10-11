If (Form event:C388=On Clicked:K2:4)
	
	<>iptMenu:=2
	yBWR_currentTable:=->[Alumnos:2]
	
	C_LONGINT:C283($i)
	ARRAY LONGINT:C221($al_nivSel;0)
	$y_lbColNoNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColNoNivel")
	$y_lbColSeleccion:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColSeleccion")
	
	For ($i;1;Size of array:C274($y_lbColSeleccion->))
		If ($y_lbColSeleccion->{$i})
			APPEND TO ARRAY:C911($al_nivSel;$y_lbColNoNivel->{$i})
		End if 
	End for 
	
	QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;$al_nivSel)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="";*)
	QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??")
	CREATE SET:C116([Alumnos:2];"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	SELECT LIST ITEMS BY POSITION:C381(vlXS_BrowserTab;1)
	BWR_PanelSettings 
	BWR_SelectTableData 
	_O_REDRAW LIST:C382(vlXS_BrowserTab)
	
End if 