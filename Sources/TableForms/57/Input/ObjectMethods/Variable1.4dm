C_LONGINT:C283($r)
$r:=CD_Dlog (0;__ ("¿Desea Ud. realmente eliminar este registro?");__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	DELETE RECORD:C58([Buses_escolares:57])
	CANCEL:C270
End if 