If (vtSN3_CurrDataType="ingreso")
	$r:=CD_Dlog (0;__ ("Se dispone a copiar la configuracion de ")+vtSNT_ConfigLevelRD+__ (" a los niveles seleccionados. Esta operación no se puede deshacer.\r\r¿Está seguro?");__ ("");__ ("Si");__ ("No"))
Else 
	If (rDatosActuales=1)
		$r:=CD_Dlog (0;__ ("Se dispone a copiar la configuracion de ")+vtSN3_CurrDataType+__ (" de ")+vtSNT_ConfigLevel+__ (" a los niveles seleccionados. Esta operación no se puede deshacer.\r\r¿Está seguro?");__ ("");__ ("Si");__ ("No"))
	Else 
		$r:=CD_Dlog (0;__ ("Se dispone a copiar la configuracion completa de ")+vtSNT_ConfigLevel+__ (" a los niveles seleccionados. Esta operación no se puede deshacer.\r\r¿Está seguro?");__ ("");__ ("Si");__ ("No"))
	End if 
End if 
If ($r=1)
	ACCEPT:C269
End if 