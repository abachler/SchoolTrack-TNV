If (Self:C308->=1)
	$r:=CD_Dlog (0;__ ("Seleccionando esta opción usted acepta eliminar todas las evaluaciones de aprendizajes existentes.\r\r¿Está usted realmente seguro que es lo que desea hacer?");__ ("");__ ("No");__ ("Si. Eliminar Evaluaciones"))
	If ($r#2)
		Self:C308->:=0
	End if 
End if 