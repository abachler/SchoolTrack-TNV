If (USR_GetUserID <0)
	$vlVS_FieldSelectorOptions:=Pop up menu:C542("Solo la tabla actual;Tablas relacionadas;Tablas del módulo;Todas las tablas;Estructura completa")
Else 
	$vlVS_FieldSelectorOptions:=Pop up menu:C542("Solo la tabla actual;Tablas relacionadas;Tablas del módulo;Todas las tablas")
End if 

If ($vlVS_FieldSelectorOptions>0)
	RObj_BuildTableFieldsLists ($vlVS_FieldSelectorOptions)
End if 