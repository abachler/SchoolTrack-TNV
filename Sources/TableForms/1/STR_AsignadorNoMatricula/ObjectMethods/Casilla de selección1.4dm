If (Self:C308->=1)
	OK:=CD_Dlog (0;__ ("¿Esta seguro que desea reasignar los números de matrícula desde 1 en todos los niveles seleccionados?");__ ("");__ ("Si");__ ("No"))
	If (OK=2)
		Self:C308->:=0
	End if 
End if 