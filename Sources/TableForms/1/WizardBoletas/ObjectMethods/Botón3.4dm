AL_ExitCell (xALP_WizDocTrib)
If (modbol)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer salir del asistente sin confirmar los cambios realizados?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 