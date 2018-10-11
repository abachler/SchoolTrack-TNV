  // [Profesores].Input.seleccionProfesor()
  // Por: Alberto Bachler K.: 26-03-14, 17:11:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$t_estadoCivil:=Listas_Popup ("Estado Civil";->[Profesores:4]Estado_civil:18)
Case of 
	: ($t_estadoCivil=__ ("Fallecido(a)"))
		[Profesores:4]Estado_civil:18:=$t_estadoCivil
		[Profesores:4]Fallecido:70:=True:C214
		PF_RegistraFallecimiento 
		If (Not:C34([Profesores:4]Fallecido:70))
			[Profesores:4]Estado_civil:18:=Old:C35([Profesores:4]Estado_civil:18)
		End if 
		
	: ($t_estadoCivil="")
	Else 
		[Profesores:4]Estado_civil:18:=$t_estadoCivil
		[Profesores:4]Fecha_Deceso:71:=!00-00-00!
		[Profesores:4]Fallecido:70:=False:C215
End case 


OBJECT SET VISIBLE:C603(*;"muerte@";[Profesores:4]Fallecido:70)
OBJECT SET ENTERABLE:C238([Profesores:4]Inactivo:62;[Profesores:4]Fallecido:70)

