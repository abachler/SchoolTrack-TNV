//%attributes = {}
  //BBL_LinkUserRecord

C_LONGINT:C283($0)
$0:=0

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Personas:7])
Case of 
	: (($1=-1) | ($1=-4))  //alumnos
		Case of 
			: ([BBL_Lectores:72]RUT:7#"")
				QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[BBL_Lectores:72]RUT:7)
			: (([BBL_Lectores:72]Apellido_materno:13="") & ([BBL_Lectores:72]Nombres:11#""))
				QUERY:C277([Alumnos:2];[Alumnos:2]Apellido_paterno:3=[BBL_Lectores:72]Apellido_paterno:12;*)
				QUERY:C277([Alumnos:2]; & [Alumnos:2]Nombres:2=[BBL_Lectores:72]Nombres:11)
			: (([BBL_Lectores:72]Apellido_materno:13="") & ([BBL_Lectores:72]Nombres:11=""))
				QUERY:C277([Alumnos:2];[Alumnos:2]Apellido_paterno:3=[BBL_Lectores:72]Apellido_paterno:12)
			Else 
				QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=[BBL_Lectores:72]NombreCompleto:3)
		End case 
		If ($1=-4)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>12)
		End if 
		Case of 
			: (Records in selection:C76([Alumnos:2])=0)
				  //$msg:=RP_GetIdxString (21202;32)
				  //$msg:=Replace string(RP_GetIdxString (21202;32);"^0";◊atBBL_GruposLectores{◊atBBL_GruposLectores})
				OK:=CD_Dlog (0;Replace string:C233(__ ("No existe ningún registro de ^0 en SchoolTrack que corresponda a los datos registrados para este lector.\rEl lector no puede ser relacionado con ningún registro en SchoolTrack.");__ ("^0");<>atBBL_GruposLectores{<>atBBL_GruposLectores}))
			: (Records in selection:C76([Alumnos:2])=1)
				[BBL_Lectores:72]Seccion_o_curso:5:=[Alumnos:2]curso:20
				[BBL_Lectores:72]Comuna:16:=[Alumnos:2]Nivel_Nombre:34
				[BBL_Lectores:72]Número_de_alumno:6:=[Alumnos:2]numero:1
				[BBL_Lectores:72]RUT:7:=[Alumnos:2]RUT:5
				[BBL_Lectores:72]Nombres:11:=[Alumnos:2]Nombres:2
				[BBL_Lectores:72]Apellido_paterno:12:=[Alumnos:2]Apellido_paterno:3
				[BBL_Lectores:72]Apellido_materno:13:=[Alumnos:2]Apellido_materno:4
				[BBL_Lectores:72]NombreCompleto:3:=[Alumnos:2]apellidos_y_nombres:40
				[BBL_Lectores:72]Dirección:14:=[Alumnos:2]Direccion:12
				[BBL_Lectores:72]Código_postal:15:=[Alumnos:2]Codigo_Postal:13
				[BBL_Lectores:72]Comuna:16:=[Alumnos:2]Comuna:14
				[BBL_Lectores:72]Ciudad:17:=[Alumnos:2]Ciudad:15
				[BBL_Lectores:72]Región_o_Estado:18:=[Alumnos:2]Región_o_estado:16
				[BBL_Lectores:72]Telephono:21:=[Alumnos:2]Telefono:17
				[BBL_Lectores:72]Sexo:23:=[Alumnos:2]Sexo:49
				[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Alumnos:2]Fecha_de_nacimiento:7
				[BBL_Lectores:72]Fotografia:32:=[Alumnos:2]Fotografía:78
				SAVE RECORD:C53([BBL_Lectores:72])
				$0:=[BBL_Lectores:72]Número_de_alumno:6
			Else 
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aGenNme;[Alumnos:2]numero:1;<>aGenId;[Alumnos:2]curso:20;aText1)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>aGenNme
				<>aChoicePtrs{3}:=->aText1
				<>aChoicePtrs{3}:=-><>aGenID
				TBL_ShowChoiceList (1)
				If ((ok=1) & (choiceIdx>0))
					[BBL_Lectores:72]Seccion_o_curso:5:=[Alumnos:2]curso:20
					[BBL_Lectores:72]Comuna:16:=[Alumnos:2]Nivel_Nombre:34
					[BBL_Lectores:72]Número_de_alumno:6:=[Alumnos:2]numero:1
					[BBL_Lectores:72]RUT:7:=[Alumnos:2]RUT:5
					[BBL_Lectores:72]Nombres:11:=[Alumnos:2]Nombres:2
					[BBL_Lectores:72]Apellido_paterno:12:=[Alumnos:2]Apellido_paterno:3
					[BBL_Lectores:72]Apellido_materno:13:=[Alumnos:2]Apellido_materno:4
					[BBL_Lectores:72]NombreCompleto:3:=[Alumnos:2]apellidos_y_nombres:40
					[BBL_Lectores:72]Dirección:14:=[Alumnos:2]Direccion:12
					[BBL_Lectores:72]Código_postal:15:=[Alumnos:2]Codigo_Postal:13
					[BBL_Lectores:72]Comuna:16:=[Alumnos:2]Comuna:14
					[BBL_Lectores:72]Ciudad:17:=[Alumnos:2]Ciudad:15
					[BBL_Lectores:72]Región_o_Estado:18:=[Alumnos:2]Región_o_estado:16
					[BBL_Lectores:72]Telephono:21:=[Alumnos:2]Telefono:17
					[BBL_Lectores:72]Sexo:23:=[Alumnos:2]Sexo:49
					[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Alumnos:2]Fecha_de_nacimiento:7
					[BBL_Lectores:72]Fotografia:32:=[Alumnos:2]Fotografía:78
					SAVE RECORD:C53([BBL_Lectores:72])
					$0:=[BBL_Lectores:72]Número_de_alumno:6
				End if 
		End case 
		
	: ($1=-2)  //profesores o administrativos
		Case of 
			: ([BBL_Lectores:72]RUT:7#"")
				QUERY:C277([Profesores:4];[Profesores:4]RUT:27=[BBL_Lectores:72]RUT:7)
			: ([BBL_Lectores:72]Apellido_materno:13="")
				QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=[BBL_Lectores:72]Apellido_paterno:12;*)
				QUERY:C277([Profesores:4]; & [Profesores:4]Nombres:2=[BBL_Lectores:72]Nombres:11)
			Else 
				QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28=[BBL_Lectores:72]NombreCompleto:3)
		End case 
		Case of 
			: (Records in selection:C76([Profesores:4])=0)
				
			: (Records in selection:C76([Profesores:4])=1)
				[BBL_Lectores:72]Seccion_o_curso:5:=[Profesores:4]Departamento:14
				[BBL_Lectores:72]Número_de_Profesor:30:=[Profesores:4]Numero:1
				[BBL_Lectores:72]RUT:7:=[Profesores:4]RUT:27
				[BBL_Lectores:72]Nombres:11:=[Profesores:4]Nombres:2
				[BBL_Lectores:72]Apellido_paterno:12:=[Profesores:4]Apellido_paterno:3
				[BBL_Lectores:72]Apellido_materno:13:=[Profesores:4]Apellido_materno:4
				[BBL_Lectores:72]NombreCompleto:3:=[Profesores:4]Apellidos_y_nombres:28
				[BBL_Lectores:72]Dirección:14:=[Profesores:4]Dirección:8
				[BBL_Lectores:72]Código_postal:15:=[Profesores:4]Codigo_postal:33
				[BBL_Lectores:72]Comuna:16:=[Profesores:4]Comuna:10
				[BBL_Lectores:72]Ciudad:17:=[Profesores:4]Ciudad:11
				[BBL_Lectores:72]Región_o_Estado:18:=[Profesores:4]Region_o_Estado:12
				[BBL_Lectores:72]Telephono:21:=[Profesores:4]Telefono_domicilio:24
				[BBL_Lectores:72]Sexo:23:=[Profesores:4]Sexo:5
				[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Profesores:4]Fecha_de_nacimiento:6
				[BBL_Lectores:72]Fotografia:32:=[Profesores:4]Fotografia:59
				SAVE RECORD:C53([BBL_Lectores:72])
				
				
			Else 
				SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;<>aGenNme;[Profesores:4]Numero:1;<>aGenId;[Profesores:4]Departamento:14;aText1)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>aGenNme
				<>aChoicePtrs{2}:=->aText1
				<>aChoicePtrs{3}:=-><>aGenID
				TBL_ShowChoiceList (1)
				If ((ok=1) & (choiceIdx>0))
					[BBL_Lectores:72]Seccion_o_curso:5:=[Profesores:4]Departamento:14
					[BBL_Lectores:72]Número_de_Profesor:30:=[Profesores:4]Numero:1
					[BBL_Lectores:72]RUT:7:=[Profesores:4]RUT:27
					[BBL_Lectores:72]Nombres:11:=[Profesores:4]Nombres:2
					[BBL_Lectores:72]Apellido_paterno:12:=[Profesores:4]Apellido_paterno:3
					[BBL_Lectores:72]Apellido_materno:13:=[Profesores:4]Apellido_materno:4
					[BBL_Lectores:72]NombreCompleto:3:=[Profesores:4]Apellidos_y_nombres:28
					[BBL_Lectores:72]Dirección:14:=[Profesores:4]Dirección:8
					[BBL_Lectores:72]Código_postal:15:=[Profesores:4]Codigo_postal:33
					[BBL_Lectores:72]Comuna:16:=[Profesores:4]Comuna:10
					[BBL_Lectores:72]Ciudad:17:=[Profesores:4]Ciudad:11
					[BBL_Lectores:72]Región_o_Estado:18:=[Profesores:4]Region_o_Estado:12
					[BBL_Lectores:72]Telephono:21:=[Profesores:4]Telefono_domicilio:24
					[BBL_Lectores:72]Sexo:23:=[Profesores:4]Sexo:5
					[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Profesores:4]Fecha_de_nacimiento:6
					[BBL_Lectores:72]Fotografia:32:=[Profesores:4]Fotografia:59
					SAVE RECORD:C53([BBL_Lectores:72])
					$0:=[BBL_Lectores:72]Número_de_Profesor:30
				End if 
		End case 
		
	: ($1=-3)  //apoderados
		Case of 
			: ([BBL_Lectores:72]RUT:7#"")
				QUERY:C277([Personas:7];[Personas:7]RUT:6=[BBL_Lectores:72]RUT:7)
			: ([BBL_Lectores:72]Apellido_materno:13="")
				QUERY:C277([Personas:7];[Personas:7]Apellido_paterno:3=[BBL_Lectores:72]Apellido_paterno:12;*)
				QUERY:C277([Personas:7]; & [Personas:7]Nombres:2=[BBL_Lectores:72]Nombres:11)
			Else 
				QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=[BBL_Lectores:72]NombreCompleto:3)
		End case 
		Case of 
			: (Records in selection:C76([Profesores:4])=0)
				OK:=CD_Dlog (0;Replace string:C233(__ ("No existe ningún registro de ^0 en SchoolTrack que corresponda a los datos registrados para este lector.\rEl lector no puede ser relacionado con ningún registro en SchoolTrack.");__ ("^0");<>atBBL_GruposLectores{<>atBBL_GruposLectores}))
			: (Records in selection:C76([Personas:7])=1)
				If ([Personas:7]Es_ProfesorActivo:77)
					OK:=CD_Dlog (0;__ ("El registro relacionado corresponde a una persona con relación con alumnos en el colegio que también es funcionario de la institución.\rLa relación se establecerá con el registro del funcionario y se asignará al lector el grupo correspondiente."))
					[BBL_Lectores:72]Seccion_o_curso:5:=""
					[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
					[BBL_Lectores:72]RUT:7:=[Personas:7]RUT:6
					[BBL_Lectores:72]Nombres:11:=[Personas:7]Nombres:2
					[BBL_Lectores:72]Apellido_paterno:12:=[Personas:7]Apellido_paterno:3
					[BBL_Lectores:72]Apellido_materno:13:=[Personas:7]Apellido_materno:4
					[BBL_Lectores:72]NombreCompleto:3:=[Personas:7]Apellidos_y_nombres:30
					[BBL_Lectores:72]Dirección:14:=[Personas:7]Direccion:14
					[BBL_Lectores:72]Código_postal:15:=[Personas:7]Codigo_postal:15
					[BBL_Lectores:72]Comuna:16:=[Personas:7]Comuna:16
					[BBL_Lectores:72]Ciudad:17:=[Personas:7]Ciudad:17
					[BBL_Lectores:72]Región_o_Estado:18:=[Personas:7]Region_o_Estado:18
					[BBL_Lectores:72]Telephono:21:=[Personas:7]Telefono_domicilio:19
					[BBL_Lectores:72]Sexo:23:=[Personas:7]Sexo:8
					[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Personas:7]Fecha_de_nacimiento:5
					[BBL_Lectores:72]Fotografia:32:=[Personas:7]Fotografia:43
					[BBL_Lectores:72]ID_GrupoLectores:37:=-2
					$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
					[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
					<>atBBL_GruposLectores:=$el
					$0:=[BBL_Lectores:72]Número_de_Profesor:30
					SAVE RECORD:C53([BBL_Lectores:72])
				Else 
					[BBL_Lectores:72]Seccion_o_curso:5:=""
					[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
					[BBL_Lectores:72]RUT:7:=[Personas:7]RUT:6
					[BBL_Lectores:72]Nombres:11:=[Personas:7]Nombres:2
					[BBL_Lectores:72]Apellido_paterno:12:=[Personas:7]Apellido_paterno:3
					[BBL_Lectores:72]Apellido_materno:13:=[Personas:7]Apellido_materno:4
					[BBL_Lectores:72]NombreCompleto:3:=[Personas:7]Apellidos_y_nombres:30
					[BBL_Lectores:72]Dirección:14:=[Personas:7]Direccion:14
					[BBL_Lectores:72]Código_postal:15:=[Personas:7]Codigo_postal:15
					[BBL_Lectores:72]Comuna:16:=[Personas:7]Comuna:16
					[BBL_Lectores:72]Ciudad:17:=[Personas:7]Ciudad:17
					[BBL_Lectores:72]Región_o_Estado:18:=[Personas:7]Region_o_Estado:18
					[BBL_Lectores:72]Telephono:21:=[Personas:7]Telefono_domicilio:19
					[BBL_Lectores:72]Sexo:23:=[Personas:7]Sexo:8
					[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Personas:7]Fecha_de_nacimiento:5
					[BBL_Lectores:72]Fotografia:32:=[Personas:7]Fotografia:43
					SAVE RECORD:C53([BBL_Lectores:72])
					$0:=[BBL_Lectores:72]Número_de_Persona:31
				End if 
				
			Else 
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;<>aGenNme;[Personas:7]No:1;<>aGenId;[Personas:7]Direccion:14;aText1)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>aGenNme
				<>aChoicePtrs{2}:=->aText1
				<>aChoicePtrs{3}:=-><>aGenID
				TBL_ShowChoiceList (1)
				If ((ok=1) & (choiceIdx>0))
					If ([Personas:7]Es_ProfesorActivo:77)
						OK:=CD_Dlog (0;__ ("No existe ningún registro de ^0 en SchoolTrack que corresponda a los datos registrados para este lector.\rEl lector no puede ser relacionado con ningún registro en SchoolTrack."))
						[BBL_Lectores:72]Seccion_o_curso:5:=""
						[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
						[BBL_Lectores:72]RUT:7:=[Personas:7]RUT:6
						[BBL_Lectores:72]Nombres:11:=[Personas:7]Nombres:2
						[BBL_Lectores:72]Apellido_paterno:12:=[Personas:7]Apellido_paterno:3
						[BBL_Lectores:72]Apellido_materno:13:=[Personas:7]Apellido_materno:4
						[BBL_Lectores:72]NombreCompleto:3:=[Personas:7]Apellidos_y_nombres:30
						[BBL_Lectores:72]Dirección:14:=[Personas:7]Direccion:14
						[BBL_Lectores:72]Código_postal:15:=[Personas:7]Codigo_postal:15
						[BBL_Lectores:72]Comuna:16:=[Personas:7]Comuna:16
						[BBL_Lectores:72]Ciudad:17:=[Personas:7]Ciudad:17
						[BBL_Lectores:72]Región_o_Estado:18:=[Personas:7]Region_o_Estado:18
						[BBL_Lectores:72]Telephono:21:=[Personas:7]Telefono_domicilio:19
						[BBL_Lectores:72]Sexo:23:=[Personas:7]Sexo:8
						[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Personas:7]Fecha_de_nacimiento:5
						[BBL_Lectores:72]Fotografia:32:=[Personas:7]Fotografia:43
						[BBL_Lectores:72]ID_GrupoLectores:37:=-2
						$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
						[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{$el}
						<>atBBL_GruposLectores:=$el
						$0:=[BBL_Lectores:72]Número_de_Profesor:30
						SAVE RECORD:C53([BBL_Lectores:72])
					Else 
						[BBL_Lectores:72]Seccion_o_curso:5:=""
						[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
						[BBL_Lectores:72]RUT:7:=[Personas:7]RUT:6
						[BBL_Lectores:72]Nombres:11:=[Personas:7]Nombres:2
						[BBL_Lectores:72]Apellido_paterno:12:=[Personas:7]Apellido_paterno:3
						[BBL_Lectores:72]Apellido_materno:13:=[Personas:7]Apellido_materno:4
						[BBL_Lectores:72]NombreCompleto:3:=[Personas:7]Apellidos_y_nombres:30
						[BBL_Lectores:72]Dirección:14:=[Personas:7]Direccion:14
						[BBL_Lectores:72]Código_postal:15:=[Personas:7]Codigo_postal:15
						[BBL_Lectores:72]Comuna:16:=[Personas:7]Comuna:16
						[BBL_Lectores:72]Ciudad:17:=[Personas:7]Ciudad:17
						[BBL_Lectores:72]Región_o_Estado:18:=[Personas:7]Region_o_Estado:18
						[BBL_Lectores:72]Telephono:21:=[Personas:7]Telefono_domicilio:19
						[BBL_Lectores:72]Sexo:23:=[Personas:7]Sexo:8
						[BBL_Lectores:72]Fecha_de_nacimiento:22:=[Personas:7]Fecha_de_nacimiento:5
						[BBL_Lectores:72]Fotografia:32:=[Personas:7]Fotografia:43
						SAVE RECORD:C53([BBL_Lectores:72])
						$0:=[BBL_Lectores:72]Número_de_Persona:31
					End if 
				End if 
		End case 
	Else 
		[BBL_Lectores:72]Número_de_alumno:6:=0
		[BBL_Lectores:72]Número_de_Persona:31:=0
		[BBL_Lectores:72]Número_de_Profesor:30:=0
		$0:=0
End case 

If ($0#0)
	[BBL_Lectores:72]NombreCompleto:3:=ST_Format (->[BBL_Lectores:72]NombreCompleto:3)
	[BBL_Lectores:72]Nombre_Comun:35:=ST_Format (->[BBL_Lectores:72]Nombre_Comun:35)
	[BBL_Lectores:72]Apellido_paterno:12:=ST_Format (->[BBL_Lectores:72]Apellido_paterno:12)
	[BBL_Lectores:72]Apellido_materno:13:=ST_Format (->[BBL_Lectores:72]Apellido_materno:13)
	[BBL_Lectores:72]Nombres:11:=ST_Format (->[BBL_Lectores:72]Nombres:11)
	[BBL_Lectores:72]Dirección:14:=ST_Format (->[BBL_Lectores:72]Dirección:14)
	[BBL_Lectores:72]Comuna:16:=ST_Format (->[BBL_Lectores:72]Comuna:16)
	[BBL_Lectores:72]Ciudad:17:=ST_Format (->[BBL_Lectores:72]Ciudad:17)
	[BBL_Lectores:72]Región_o_Estado:18:=ST_Format (->[BBL_Lectores:72]Región_o_Estado:18)
	SAVE RECORD:C53([BBL_Lectores:72])
End if 

