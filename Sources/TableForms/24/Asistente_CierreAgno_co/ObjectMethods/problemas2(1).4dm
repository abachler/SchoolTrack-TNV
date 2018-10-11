<>iptMenu:=2
yBWR_currentTable:=->[Alumnos:2]
TRACE:C157
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??")
CREATE SET:C116([Alumnos:2];"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
BWR_SelectTableData 
SELECT LIST ITEMS BY POSITION:C381(vlXS_BrowserTab;1)
_O_REDRAW LIST:C382(vlXS_BrowserTab)