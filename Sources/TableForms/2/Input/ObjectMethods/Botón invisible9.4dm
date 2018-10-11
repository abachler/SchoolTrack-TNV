
If (vi_LineasPorFila>3)
	vi_LineasPorFila:=vi_LineasPorFila-1
	OBJECT GET COORDINATES:C663(xALP_ConductaAlumnos;$left;$top;$right;$bottom)
	If (SYS_IsWindows )
		$altoLineaTexto:=12
	Else 
		$altoLineaTexto:=11
	End if 
	AL_SetHeight (xALP_ConductaAlumnos;2;2;vi_LineasPorFila;1;2;1)
	AL_UpdateArrays (xALP_ConductaAlumnos;-2)
End if 
REDRAW WINDOW:C456