If (<>aNivelT>0)
	$nivelNombre:=<>aNivelT{<>aNivelT}
	$nivNum:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nivelNombre;->[xxSTR_Niveles:6]NoNivel:5)
	vNivelInterno2:=$nivNum
	vNivel2:=$nivelNombre
	If (vNivelInterno2<vNivelInterno1)
		vNivelInterno1:=$nivNum
		vNivel1:=$nivelNombre
	End if 
End if 