If (Self:C308->>0)
	[Familia:78]Comuna:8:=Self:C308->{Self:C308->}
	If ((Old:C35([Familia:78]Comuna:8)#[Familia:78]Comuna:8) & ([Familia:78]Comuna:8#""))
		AL_ActualizaDireccionFamilia (->[Familia:78]Comuna:8)
	End if 
End if 