POST KEY:C465(Character code:C91("'");256)
If (<>at_NombreNivelesActivos>0)
	$nombreNivel:=<>at_NombreNivelesActivos{<>at_NombreNivelesActivos}
	$seccion:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nombreNivel;->[xxSTR_Niveles:6]Sección:9)
	<>aListSect:=Find in array:C230(<>aListSect;$seccion)
	<>aCursos:=0
End if 