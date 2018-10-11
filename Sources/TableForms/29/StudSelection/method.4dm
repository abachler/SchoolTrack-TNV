C_LONGINT:C283($i)
C_POINTER:C301(vy_cursoAlumnos_at;vy_listaAlumnos;vy_nivelAlumnos_at;vy_nombresAlumnos_at;vy_recNumAlumnos_al)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IdInscritos;0)
ARRAY POINTER:C280($ay_jerarquia;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		If (XCR_periodoInscripcion_l=0)
			OBJECT SET TITLE:C194(*;"botonInscribir";"Inscribir en todos los períodos")
		Else 
			OBJECT SET TITLE:C194(*;"botonInscribir";"Inscribir en "+atSTR_Periodos_Nombre{XCR_periodoInscripcion_l})
		End if 
		
		QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
		QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Año:3=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Alumno_Numero:1;$al_IdInscritos;[Alumnos_Actividades:28]Periodos_Inscritos:44;$al_periodosInscritos)
		
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=[Actividades:29]Desde_NumeroNivel:5;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=[Actividades:29]Hasta_NumeroNivel:9;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"Retirado@";*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"Promovido@")
		
		Case of 
			: ([Actividades:29]Selección_por_sexo:6=2)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
			: ([Actividades:29]Selección_por_sexo:6=3)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
		End case 
		  //ORDER BY([Alumnos]Nivel_Número;>;[Alumnos]Curso;>;[Alumnos]Apellidos_y_Nombres)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40)
		
		  //ASM 20141022 cambié las variables locales, porque se daba un problema con el Object named .
		vy_listaAlumnos:=OBJECT Get pointer:C1124(Object named:K67:5;"seleccionAlumnos")
		vy_nivelAlumnos_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelAlumnos")
		vy_cursoAlumnos_at:=OBJECT Get pointer:C1124(Object named:K67:5;"cursoAlumnos")
		vy_nombresAlumnos_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreAlumnos")
		vy_recNumAlumnos_al:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumAlumnos")
		
		SELECTION TO ARRAY:C260([Alumnos:2];vy_recNumAlumnos_al->;[Alumnos:2]apellidos_y_nombres:40;vy_nombresAlumnos_at->;[Alumnos:2]Nivel_Nombre:34;vy_nivelAlumnos_at->;[Alumnos:2]curso:20;vy_cursoAlumnos_at->;[Alumnos:2]numero:1;$al_IdAlumnos)
		ARRAY LONGINT:C221(XCR_estiloSeleccionAlumnos_al;Size of array:C274(vy_recNumAlumnos_al->))
		
		
		For ($i;Size of array:C274($al_IdAlumnos);1;-1)
			$l_posicionInscrito:=Find in array:C230($al_IdInscritos;$al_IdAlumnos{$i})
			If ($l_posicionInscrito>0)
				$l_periodosInscritos:=$al_periodosInscritos{$l_posicionInscrito}
				Case of 
					: ($al_periodosInscritos{$l_posicionInscrito}=0)
						XCR_estiloSeleccionAlumnos_al{$i}:=Plain:K14:1
					: ($al_periodosInscritos{$l_posicionInscrito}=1)
						AT_Delete ($i;1;vy_recNumAlumnos_al;vy_nombresAlumnos_at;vy_nivelAlumnos_at;vy_cursoAlumnos_at;->XCR_estiloSeleccionAlumnos_al)
					: (($al_periodosInscritos{$l_posicionInscrito} ?? XCR_periodoInscripcion_l))
						AT_Delete ($i;1;vy_recNumAlumnos_al;vy_nombresAlumnos_at;vy_nivelAlumnos_at;vy_cursoAlumnos_at;->XCR_estiloSeleccionAlumnos_al)
					: ($al_periodosInscritos{$l_posicionInscrito}>1)
						XCR_estiloSeleccionAlumnos_al{$i}:=Italic:K14:3
					Else 
						XCR_estiloSeleccionAlumnos_al{$i}:=Italic:K14:3
				End case 
			Else 
				XCR_estiloSeleccionAlumnos_al{$i}:=Plain:K14:1
			End if 
		End for 
		
		CREATE SET FROM ARRAY:C641([Alumnos:2];vy_recNumAlumnos_al->;"alumnosSeleccionables")
		
		APPEND TO ARRAY:C911($ay_jerarquia;vy_nivelAlumnos_at)
		APPEND TO ARRAY:C911($ay_jerarquia;vy_cursoAlumnos_at)
		APPEND TO ARRAY:C911($ay_jerarquia;vy_nombresAlumnos_at)
		LISTBOX SET HIERARCHY:C1098(*;"seleccionAlumnos";True:C214;$ay_jerarquia)
		LISTBOX COLLAPSE:C1101(*;"seleccionAlumnos";False:C215;lk level:K53:19;2)
		
		OBJECT SET ENABLED:C1123(*;"botonInscribir";False:C215)
		
	: (Form event:C388=On After Keystroke:K2:26)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
		
End case 