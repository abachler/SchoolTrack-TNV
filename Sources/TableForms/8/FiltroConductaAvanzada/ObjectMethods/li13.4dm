$cursos:=AT_array2text (->at_cursos)

$choice:=Pop up menu:C542($cursos)

If ($choice>0)
	vt_Cursos:=at_cursos{$choice}
	vi_selectedcurso:=$choice
End if 