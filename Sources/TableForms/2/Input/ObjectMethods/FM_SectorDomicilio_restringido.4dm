If (Self:C308->>0)
	[Familia:78]Sector_Domicilio:44:=Self:C308->{Self:C308->}
End if 

If (Modified:C32([Familia:78]Sector_Domicilio:44))
	AL_ActualizaDireccionFamilia (->[Familia:78]Sector_Domicilio:44)
End if 