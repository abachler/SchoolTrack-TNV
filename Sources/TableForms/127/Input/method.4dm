Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([Alumnos_ObsOrientacion:127]Alumno_Numero:1=0)
			[Alumnos_ObsOrientacion:127]RegistradaPor_Nombre:3:=<>tUSR_CurrentUser
			[Alumnos_ObsOrientacion:127]RegistradaPor_Numero:7:=<>lUSR_RelatedTableUserID
			[Alumnos_ObsOrientacion:127]Alumno_Numero:1:=[Alumnos:2]numero:1
			[Alumnos_ObsOrientacion:127]Categoría:4:="General"
			[Alumnos_ObsOrientacion:127]Fecha_observación:2:=Current date:C33(*)
		End if 
		SET WINDOW TITLE:C213(__ ("Registro de Observación ")+[Alumnos_ObsOrientacion:127]Categoría:4+__ (" para ")+[Alumnos:2]apellidos_y_nombres:40)
		If (Not:C34(USR_checkRights ("M";->[Alumnos_Orientacion:15])))
			OBJECT SET ENTERABLE:C238(*;"@";False:C215)
			_O_DISABLE BUTTON:C193(b_Eliminar)
			_O_DISABLE BUTTON:C193(b_OK)
		Else 
			OBJECT SET ENTERABLE:C238(*;"@";True:C214)
			_O_ENABLE BUTTON:C192(b_Eliminar)
			_O_ENABLE BUTTON:C192(b_OK)
		End if 
End case 
