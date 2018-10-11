_O_C_STRING:C293(80;rmtProf)
Case of 
	: ((Form event:C388=On Load:K2:1) & (rmtProf#"") & ([Profesores:4]Apellido_paterno:3=""))
		Self:C308->:=ST_Format (Self:C308)
		
	: (Form event:C388=On Data Change:K2:15)
		Self:C308->:=ST_Format (Self:C308)
		If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
			[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
		End if 
		
		If (Self:C308->#"")
			OBJECT SET ENTERABLE:C238(*;"Field2";True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*;"Field2";False:C215)
		End if 
End case 