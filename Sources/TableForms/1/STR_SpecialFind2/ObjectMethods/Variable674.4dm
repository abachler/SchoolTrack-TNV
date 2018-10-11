If (Self:C308->>0)
	$nivelNombre:=<>aNivelB{<>aNivelB}
	$nivNum:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nivelNombre;->[xxSTR_Niveles:6]NoNivel:5)
	vNivelInterno1:=$nivNum
	vNivel1:=Self:C308->{Self:C308->}
	If (vNivelInterno2<vNivelInterno1)
		vNivelInterno2:=$nivNum
		vNivel2:=$nivelNombre
	End if 
End if 
