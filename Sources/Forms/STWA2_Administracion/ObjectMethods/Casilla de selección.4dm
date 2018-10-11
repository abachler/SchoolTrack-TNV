If (Self:C308->=1)
	$t_mensaje:=__ ("Deshabilitar el acceso via web desconectará a los usuarios conectados actualmente e impedirá la conexión via web en el futuro.\r")
	$t_mensaje:=$t_mensaje+__ ("¿Está seguro de querer deshabilitar el acceso via web?")
	$r:=CD_Dlog (0;$t_mensaje;"";__ ("Si");__ ("No"))
	If ($r=1)
		If (Size of array:C274(atSTWA2_SessionUUID)>0)
			For ($i;1;Size of array:C274(atSTWA2_SessionUUID))
				$uuid:=atSTWA2_SessionUUID{$i}
				STWA2_Session_UnsetSession ($uuid)
			End for 
		End if 
	Else 
		Self:C308->:=0
	End if 
End if 
PREF_Set (0;"DeshabilitarSTWA";String:C10(Self:C308->))