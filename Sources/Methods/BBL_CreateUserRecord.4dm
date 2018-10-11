//%attributes = {}
  //BBL_CreateUserRecord


MESSAGES OFF:C175
$table:=$1
READ WRITE:C146([BBL_Lectores:72])
Case of 
	: ($table=4)  //profesores  
		  //la información de los registros de profesores prima sobre cualquier otro registro relacionado con el lector (alumno o apoderado)
		  //el registro del lector es actualizado desde el registro de profesor
		
		$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]Número_de_Profesor:30;->[Profesores:4]Numero:1;True:C214)
		If (($recNum<0) & ([Profesores:4]ID_Persona:65>0))  //me aseguro que no exista un registro de lector relacionado previamente con la persona relacionada con el profesor
			$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]Número_de_Profesor:30;->[Profesores:4]ID_Persona:65;True:C214)
		End if 
		If ($recNum<0)
			CREATE RECORD:C68([BBL_Lectores:72])
			[BBL_Lectores:72]ID:1:=SQ_SeqNumber (->[BBL_Lectores:72]ID:1)
			[BBL_Lectores:72]ID_GrupoLectores:37:=-2
			[BBL_Lectores:72]Regla:4:=<>SMT_DEFAULTUSERRULE
			If ([BBL_Lectores:72]Regla:4="")
				[BBL_Lectores:72]Regla:4:="GEN"
			End if 
			
			$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
			If ($el>0)
				[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
			End if 
		End if 
		
		[BBL_Lectores:72]ID_GrupoLectores:37:=-2
		$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
		If ($el>0)
			[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
		End if 
		[BBL_Lectores:72]Seccion_o_curso:5:=[Profesores:4]Departamento:14
		[BBL_Lectores:72]Número_de_Profesor:30:=[Profesores:4]Numero:1
		[BBL_Lectores:72]Número_de_Persona:31:=[Profesores:4]ID_Persona:65
		[BBL_Lectores:72]Número_de_alumno:6:=[Profesores:4]ID_ExAlumno:69
		[BBL_Lectores:72]RUT:7:=[Profesores:4]RUT:27
		[BBL_Lectores:72]IDNacional_2:33:=[Profesores:4]IDNacional_2:42
		[BBL_Lectores:72]IDNacional_3:34:=[Profesores:4]IDNacional_3:43
		[BBL_Lectores:72]Nombres:11:=[Profesores:4]Nombres:2
		[BBL_Lectores:72]Apellido_paterno:12:=[Profesores:4]Apellido_paterno:3
		[BBL_Lectores:72]Apellido_materno:13:=[Profesores:4]Apellido_materno:4
		[BBL_Lectores:72]NombreCompleto:3:=[Profesores:4]Apellidos_y_nombres:28
		[BBL_Lectores:72]Nombre_Comun:35:=[Profesores:4]Nombre_comun:21
		[BBL_Lectores:72]Dirección:14:=[Profesores:4]Dirección:8
		[BBL_Lectores:72]Código_postal:15:=[Profesores:4]Codigo_postal:33
		[BBL_Lectores:72]Comuna:16:=[Profesores:4]Comuna:10
		[BBL_Lectores:72]Ciudad:17:=[Profesores:4]Ciudad:11
		[BBL_Lectores:72]Región_o_Estado:18:=[Profesores:4]Region_o_Estado:12
		[BBL_Lectores:72]Telephono:21:=[Profesores:4]Telefono_domicilio:24
		[BBL_Lectores:72]eMail:41:=[Profesores:4]eMail_profesional:38
		[BBL_Lectores:72]Sexo:23:=[Profesores:4]Sexo:5
		[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Profesores:4]Fecha_de_nacimiento:6
		[BBL_Lectores:72]Fotografia:32:=[Profesores:4]Fotografia:59
		BBLpat_GeneraCodigoBarra 
		
		
	: ($table=7)  //apoderados
		
		  // si la persona es simultáneamente una relación familiar y un profesor su condición de profesor debe primar
		  //el registro de lector relacionado con el apoderado y el profesor no es actualizado a partir del registro de apoderado
		$recNumProfesor:=Find in field:C653([Profesores:4]ID_Persona:65;[Personas:7]No:1)
		If (($recNumProfesor<0) & ([Personas:7]ID_Profesor:78=0))
			$actualizarRegistro:=True:C214
		Else 
			$actualizarRegistro:=False:C215
		End if 
		
		If ($actualizarRegistro)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]No:1;True:C214)
			If ($recNum<0)
				CREATE RECORD:C68([BBL_Lectores:72])
				[BBL_Lectores:72]ID:1:=SQ_SeqNumber (->[BBL_Lectores:72]ID:1)
				[BBL_Lectores:72]Regla:4:=<>SMT_DEFAULTUSERRULE
				If ([BBL_Lectores:72]Regla:4="")
					[BBL_Lectores:72]Regla:4:="GEN"
				End if 
			End if 
			
			[BBL_Lectores:72]ID_GrupoLectores:37:=-3
			$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
			If ($el>0)
				[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
			End if 
			[BBL_Lectores:72]Seccion_o_curso:5:="Apoderados"
			[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
			[BBL_Lectores:72]Número_de_Profesor:30:=[Personas:7]ID_Profesor:78
			[BBL_Lectores:72]Número_de_alumno:6:=[Personas:7]ID_ExAlumno:87
			[BBL_Lectores:72]RUT:7:=[Personas:7]RUT:6
			[BBL_Lectores:72]IDNacional_2:33:=[Personas:7]IDNacional_2:37
			[BBL_Lectores:72]IDNacional_3:34:=[Personas:7]IDNacional_3:38
			[BBL_Lectores:72]Nombres:11:=[Personas:7]Nombres:2
			[BBL_Lectores:72]Apellido_paterno:12:=[Personas:7]Apellido_paterno:3
			[BBL_Lectores:72]Apellido_materno:13:=[Personas:7]Apellido_materno:4
			[BBL_Lectores:72]NombreCompleto:3:=[Personas:7]Apellidos_y_nombres:30
			[BBL_Lectores:72]Nombre_Comun:35:=[Personas:7]Nombre_Comun:60
			[BBL_Lectores:72]Dirección:14:=[Personas:7]Direccion:14
			[BBL_Lectores:72]Código_postal:15:=[Personas:7]Codigo_postal:15
			[BBL_Lectores:72]Comuna:16:=[Personas:7]Comuna:16
			[BBL_Lectores:72]Ciudad:17:=[Personas:7]Ciudad:17
			[BBL_Lectores:72]Región_o_Estado:18:=[Personas:7]Region_o_Estado:18
			[BBL_Lectores:72]Telephono:21:=[Personas:7]Telefono_domicilio:19
			[BBL_Lectores:72]eMail:41:=[Personas:7]eMail:34
			[BBL_Lectores:72]Sexo:23:=[Personas:7]Sexo:8
			[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Personas:7]Fecha_de_nacimiento:5
			[BBL_Lectores:72]Fotografia:32:=[Personas:7]Fotografia:43
			BBLpat_GeneraCodigoBarra 
		End if 
		
		
	: ($table=2)  //alumnos
		$actualizarRegistro:=False:C215
		Case of 
			: ([Alumnos:2]nivel_numero:29>=1000)
				  //si es ex alumno me aseguro que no exista como profesor o apoderado
				  //si hay registros de personas o profesores relacionados con el ex-alumno priman los registros de profesores o personas
				$recNumPersona:=Find in field:C653([Personas:7]ID_ExAlumno:87;[Alumnos:2]numero:1)
				$recNumProfesor:=Find in field:C653([Profesores:4]ID_ExAlumno:69;[Alumnos:2]numero:1)
				If (($recNumPersona<0) & ($recNumProfesor<0))
					$actualizarRegistro:=True:C214
				End if 
				
			: ([Alumnos:2]nivel_numero:29>-1002)  //alumno actual
				  //si es alumno actual la información del registro es utilizada para actualizar el registro del lector
				QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6=[Alumnos:2]numero:1)
				$actualizarRegistro:=True:C214
				
			: ([Alumnos:2]nivel_numero:29<=-1002)  //admisiones
				  //los alumnos en admisión no son considerados
				$recNum:=Find in field:C653([BBL_Lectores:72]Número_de_alumno:6;[Alumnos:2]numero:1)  //MONO actualizaré información si el lector existe
				If ($recNum>=0)
					$actualizarRegistro:=True:C214
				End if 
		End case 
		
		
		If ($actualizarRegistro)
			
			$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]numero:1;True:C214)
			
			If (($recNum<0))
				CREATE RECORD:C68([BBL_Lectores:72])
				[BBL_Lectores:72]ID:1:=SQ_SeqNumber (->[BBL_Lectores:72]ID:1)
				  //20110922 AS Solo se asigna cuando se crea un nuevo registro.
				[BBL_Lectores:72]Regla:4:=<>SMT_DEFAULTUSERRULE
				
				  //20120225 RCH Para ser consistente con el on load de lectores, si la regla es vacia se deja con GEN.
				If ([BBL_Lectores:72]Regla:4="")
					[BBL_Lectores:72]Regla:4:="GEN"
				End if 
				
			End if 
			
			If ([Alumnos:2]nivel_numero:29>=1000)
				[BBL_Lectores:72]ID_GrupoLectores:37:=-4
				$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
				If ($el>0)
					[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
				End if 
			Else 
				[BBL_Lectores:72]ID_GrupoLectores:37:=-1
				$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
				If ($el>0)
					[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
				End if 
			End if 
			  //MONO 149211
			Case of 
				: (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]nivel_numero:29=Nivel_Retirados))
					[BBL_Lectores:72]Seccion_o_curso:5:="RET ("+[Alumnos:2]curso:20+")"
				: ([Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta)
					[BBL_Lectores:72]Observaciones:19:="Reorganizado en Admisión desde el curso "+Old:C35([Alumnos:2]curso:20)+"\r"+[BBL_Lectores:72]Observaciones:19
					[BBL_Lectores:72]Seccion_o_curso:5:=[Alumnos:2]curso:20
				Else 
					[BBL_Lectores:72]Seccion_o_curso:5:=[Alumnos:2]curso:20
			End case 
			
			[BBL_Lectores:72]Nivel:29:=[Alumnos:2]Nivel_Nombre:34
			[BBL_Lectores:72]Número_de_alumno:6:=[Alumnos:2]numero:1
			[BBL_Lectores:72]Número_de_Profesor:30:=0
			[BBL_Lectores:72]Número_de_Persona:31:=0
			[BBL_Lectores:72]RUT:7:=[Alumnos:2]RUT:5
			[BBL_Lectores:72]IDNacional_2:33:=[Alumnos:2]IDNacional_2:71
			[BBL_Lectores:72]IDNacional_3:34:=[Alumnos:2]IDNacional_3:70
			[BBL_Lectores:72]Nombres:11:=[Alumnos:2]Nombres:2
			[BBL_Lectores:72]Apellido_paterno:12:=[Alumnos:2]Apellido_paterno:3
			[BBL_Lectores:72]Apellido_materno:13:=[Alumnos:2]Apellido_materno:4
			[BBL_Lectores:72]NombreCompleto:3:=[Alumnos:2]apellidos_y_nombres:40
			[BBL_Lectores:72]Nombre_Comun:35:=[Alumnos:2]Nombre_Común:30
			[BBL_Lectores:72]Dirección:14:=[Alumnos:2]Direccion:12
			[BBL_Lectores:72]Código_postal:15:=[Alumnos:2]Codigo_Postal:13
			[BBL_Lectores:72]Comuna:16:=[Alumnos:2]Comuna:14
			[BBL_Lectores:72]Ciudad:17:=[Alumnos:2]Ciudad:15
			[BBL_Lectores:72]Región_o_Estado:18:=[Alumnos:2]Región_o_estado:16
			[BBL_Lectores:72]Telephono:21:=[Alumnos:2]Telefono:17
			[BBL_Lectores:72]eMail:41:=[Alumnos:2]eMAIL:68
			[BBL_Lectores:72]Sexo:23:=[Alumnos:2]Sexo:49
			[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Alumnos:2]Fecha_de_nacimiento:7
			[BBL_Lectores:72]Fotografia:32:=[Alumnos:2]Fotografía:78
			BBLpat_GeneraCodigoBarra 
		End if 
		
End case 

SAVE RECORD:C53([BBL_Lectores:72])
UNLOAD RECORD:C212([BBL_Lectores:72])
READ ONLY:C145([BBL_Lectores:72])
