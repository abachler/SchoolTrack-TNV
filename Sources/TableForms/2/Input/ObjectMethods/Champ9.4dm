Self:C308->:=ST_Format (Self:C308)
AL_ProcesaNombres 

If (<>vlSTR_UsarSoloUnApellido=1)
	[Alumnos:2]Familia_Número:24:=AL_RelateToFamily 
End if 
If ([Alumnos:2]Sexo:49="_")
	[Alumnos:2]Sexo:49:=""
End if 