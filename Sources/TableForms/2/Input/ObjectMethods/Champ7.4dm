Self:C308->:=ST_Format (Self:C308)
AL_ProcesaNombres 

If (<>vlSTR_UsarSoloUnApellido#1)
	[Alumnos:2]Familia_Número:24:=AL_RelateToFamily 
Else 
	If (Self:C308->#"")
		OBJECT SET ENTERABLE:C238(*;"Champ8";True:C214)
	Else 
		OBJECT SET ENTERABLE:C238(*;"Champ8";False:C215)
	End if 
End if 