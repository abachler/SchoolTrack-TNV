$resp:=CD_Dlog (0;__ ("¿Desea realmente cerrar la consola de atrasos?");__ ("");__ ("Si");__ ("No"))
If ($resp=1)
	CANCEL:C270
End if 
