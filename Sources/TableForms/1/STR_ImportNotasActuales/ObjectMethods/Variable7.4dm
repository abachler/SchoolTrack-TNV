C_TEXT:C284($texto)
C_LONGINT:C283($r)
Case of 
	: (t1=1)
		$texto:="SÓLO NOTAS PARCIALES"
	: (t2=1)
		$texto:="NOTAS PARCIALES Y PROMEDIOS"
	: (t3=1)
		$texto:="SOLO OBSERVACIONES"
End case 

$r:=CD_Dlog (0;__ ("Usted se dispone a importar ")+$texto+__ (" para el año actual.\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	ACCEPT:C269
End if 