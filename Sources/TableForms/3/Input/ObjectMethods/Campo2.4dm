
If ((Old:C35([Cursos:3]Letra_Oficial_del_Curso:18)#"") & ([Cursos:3]Letra_Oficial_del_Curso:18=""))
	[Cursos:3]Letra_Oficial_del_Curso:18:=Old:C35([Cursos:3]Letra_Oficial_del_Curso:18)
	ModernUI_Notificacion (__ ("La letra de de un curso existente no puede ser dejada en blanco");__ ("Se restableció la letra del curso registrada anteriormente");__ ("Cerrar"))
	
Else 
	[Cursos:3]Nombre_Oficial_Curso:15:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Abreviatura_Oficial:35)+"-"+[Cursos:3]Letra_Oficial_del_Curso:18
	
End if 