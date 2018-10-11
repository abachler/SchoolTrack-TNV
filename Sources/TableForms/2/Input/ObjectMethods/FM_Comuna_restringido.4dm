If (Self:C308->>0)
	[Familia:78]Comuna:8:=Self:C308->{Self:C308->}
End if 

If (Modified:C32([Familia:78]Comuna:8))
	AL_ActualizaDireccionFamilia (->[Familia:78]Comuna:8)
End if 