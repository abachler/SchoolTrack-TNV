$semana:=AT_array2text (-><>at_NombreNivelesRegulares)
$choice:=Pop up menu:C542($semana)
If ($choice>0)
	nivelNombre2:=<>at_NombreNivelesRegulares{$choice}
	vl_nivel2:=<>al_NumeroNivelRegular{$choice}
End if 