If (Self:C308->#Old:C35(Self:C308->))
	For ($i;1;Size of array:C274(aNtaIdAlumno))
		BM_CreateRequest ("CalculaPromediosGenerales";String:C10(aNtaIdAlumno{$i});String:C10(aNtaIdAlumno{$i}))
	End for 
End if 