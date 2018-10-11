//%attributes = {}
  //dhSync_PostProcessData
C_POINTER:C301($1;$y_campo)

$y_campo:=$1

Case of 
	: (KRL_isSameField (->[Alumnos:2]Apellido_paterno:3;$y_campo))
		AL_ProcesaNombres 
	: (KRL_isSameField (->[Alumnos:2]Apellido_materno:4;$y_campo))
		AL_ProcesaNombres 
	: (KRL_isSameField (->[Alumnos:2]Nombres:2;$y_campo))
		AL_ProcesaNombres 
	: (KRL_isSameField (->[Alumnos:2]Fecha_de_nacimiento:7;$y_campo))
		If ([Alumnos:2]Fecha_de_nacimiento:7#Old:C35([Alumnos:2]Fecha_de_nacimiento:7))
			READ WRITE:C146([Alumnos_ControlesMedicos:99])
			QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos:2]numero:1)
			While (Not:C34(End selection:C36([Alumnos_ControlesMedicos:99])))
				[Alumnos_ControlesMedicos:99]Edad:4:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7;[Alumnos_ControlesMedicos:99]Fecha:2)
				SAVE RECORD:C53([Alumnos_ControlesMedicos:99])
				NEXT RECORD:C51([Alumnos_ControlesMedicos:99])
			End while 
			KRL_UnloadReadOnly (->[Alumnos_ControlesMedicos:99])
		End if 
	: (KRL_isSameField (->[Profesores:4]Nombres:2;$y_campo))
		[Profesores:4]Nombres:2:=ST_Format (->[Profesores:4]Nombres:2)
		[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" ")
		[Profesores:4]Apellidos_y_nombres:28:=ST_Format (->[Profesores:4]Apellidos_y_nombres:28)
		[Profesores:4]Nombres_apellidos:40:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
		[Profesores:4]Nombres_apellidos:40:=ST_Format (->[Profesores:4]Nombres_apellidos:40)
		[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1))
		If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
			[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
		End if 
	: (KRL_isSameField (->[Profesores:4]Apellido_paterno:3;$y_campo))
		[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" ")
		[Profesores:4]Apellidos_y_nombres:28:=ST_Format (->[Profesores:4]Apellidos_y_nombres:28)
		[Profesores:4]Nombres_apellidos:40:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
		[Profesores:4]Nombres_apellidos:40:=ST_Format (->[Profesores:4]Nombres_apellidos:40)
		[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1))
		If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
			[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
		End if 
	: (KRL_isSameField (->[Profesores:4]Apellido_materno:4;$y_campo))
		[Profesores:4]Apellido_materno:4:=ST_Format (->[Profesores:4]Apellido_materno:4)
		[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" ")
		[Profesores:4]Apellidos_y_nombres:28:=ST_Format (->[Profesores:4]Apellidos_y_nombres:28)
		[Profesores:4]Nombres_apellidos:40:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
		[Profesores:4]Nombres_apellidos:40:=ST_Format (->[Profesores:4]Nombres_apellidos:40)
		[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1))
		If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
			[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
		End if 
End case 