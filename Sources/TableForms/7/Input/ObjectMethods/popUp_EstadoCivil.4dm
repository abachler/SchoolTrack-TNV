  // [Personas].Input.seleccionProfesor()
  // Por: Alberto Bachler K.: 26-03-14, 17:11:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$t_estadoCivil:=Listas_Popup ("Estado Civil";->[Personas:7]Estado_civil:10)
Case of 
	: ($t_estadoCivil=__ ("Fallecido(a)"))
		[Personas:7]Estado_civil:10:=$t_estadoCivil
		[Personas:7]Fallecido:88:=True:C214
		PP_RegistraFallecimiento 
		If (Not:C34([Personas:7]Fallecido:88))
			[Personas:7]Estado_civil:10:=Old:C35([Personas:7]Estado_civil:10)
		End if 
		
	: ($t_estadoCivil="")
	Else 
		[Personas:7]Estado_civil:10:=$t_estadoCivil
		[Personas:7]Fecha_Deceso:89:=!00-00-00!
		[Personas:7]Fallecido:88:=False:C215
End case 


