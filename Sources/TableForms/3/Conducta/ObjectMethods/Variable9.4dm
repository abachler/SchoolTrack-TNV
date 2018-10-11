  //[cursos]conducta.xPL_List

C_LONGINT:C283($vl_total)
C_REAL:C285($vr_Porcentaje)

If (Form event:C388=On Load:K2:1)
	C_LONGINT:C283($i;$elementoSeleccionado)
	ARRAY TEXT:C222(aText1;0)
	ARRAY REAL:C219(aReal1;0)
	ARRAY REAL:C219(aReal2;0)
	ARRAY INTEGER:C220(aInt1;0)
	ARRAY INTEGER:C220(aInt2;0)
	ARRAY INTEGER:C220(aInt3;0)
	ARRAY INTEGER:C220(aInt4;0)
	ARRAY INTEGER:C220(aInt5;0)
	ARRAY INTEGER:C220(aInt6;0)
	ARRAY INTEGER:C220(aInt7;0)
	ARRAY INTEGER:C220(aInt8;0)
	
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	  //MONO TICKET 155405
	If (Not:C34(Shift down:C543))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
	End if 
	
	RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
	sProf:=[Profesores:4]Apellidos_y_nombres:28
	sCurso:=[Cursos:3]Curso:1
	sTitle:="Resumen de conducta y asistencia"
	dDate:=Current date:C33(*)
	hHeure:=Current time:C178(*)
	$elementoSeleccionado:=atSTR_Periodos_Nombre
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	If ($elementoSeleccionado<=Size of array:C274(atSTR_Periodos_Nombre))
		atSTR_Periodos_Nombre:=$elementoSeleccionado
	End if 
	$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)
	$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Lates_Mode:16)
	
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdAlumnos;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]nivel_numero:29;$aNivel)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	$arrayPointer:=->aLong1
	AT_RedimArrays (Size of array:C274($aIdAlumnos);->aInt1;->aInt2;->aInt3;->aInt4;->aInt5;->aInt6;->aInt7;->aInt8;->aReal1;->aReal2)
	
	Case of 
		: (($modoRegistroAsistencia=3) | (($modoRegistroAsistencia=3) | ($modoRegistroAtrasos=3)))
			$size:=Size of array:C274(aText1)
			For ($i;1;$size)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Cursos:3]Nivel_Numero:7)+"."+String:C10($aIdAlumnos{$i})
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)
				aInt1{$i}:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
				aInt2{$i}:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
				aInt3{$i}:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
				aInt4{$i}:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
				aInt5{$i}:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
				aInt6{$i}:=[Alumnos_SintesisAnual:210]Castigos:43
				aInt7{$i}:=[Alumnos_SintesisAnual:210]Suspensiones:44
				aReal1{$i}:=Round:C94(viSTR_Calendario_DiasAHoy-aInt1{$i}/viSTR_Calendario_DiasAHoy*100;1)
				aReal2{$i}:=Round:C94(viSTR_Periodos_DiasAgno-aInt1{$i}/viSTR_Periodos_DiasAgno*100;1)
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;10;"aText1";"aInt1";"aInt2";"aInt3";"aInt4";"aInt5";"aInt6";"aInt7";"aReal1";"aReal2")
			sCount:=<>gNombreAgnoEscolar
		: (($modoRegistroAsistencia=1))
			$size:=Size of array:C274(aText1)
			If (atSTR_Periodos_Nombre>0)
				$periodo:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}
				sCount:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
			Else 
				$periodo:=0
				sCount:=<>gNombreAgnoEscolar
			End if 
			For ($i;1;$size)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Cursos:3]Nivel_Numero:7)+"."+String:C10($aIdAlumnos{$i})
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P01_Castigos:110
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111
						: ($periodo=2)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P02_Castigos:139
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140
						: ($periodo=3)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P03_Castigos:168
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169
						: ($periodo=4)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P04_Castigos:197
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198
						: ($periodo=5)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P05_Castigos:226
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227
					End case 
				Else 
					aInt1{$i}:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
					aInt2{$i}:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
					aInt3{$i}:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
					aInt4{$i}:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
					aInt5{$i}:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
					aInt6{$i}:=[Alumnos_SintesisAnual:210]Castigos:43
					aInt7{$i}:=[Alumnos_SintesisAnual:210]Suspensiones:44
				End if 
				aReal1{$i}:=Round:C94(viSTR_Calendario_DiasAHoy-aInt1{$i}/viSTR_Calendario_DiasAHoy*100;1)
				aReal2{$i}:=Round:C94(viSTR_Periodos_DiasAgno-aInt1{$i}/viSTR_Periodos_DiasAgno*100;1)
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;10;"aText1";"aInt1";"aInt2";"aInt3";"aInt4";"aInt5";"aInt6";"aInt7";"aReal1";"aReal2")
			
		: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
			$size:=Size of array:C274(aText1)
			
			If (atSTR_Periodos_Nombre>0)
				$periodo:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}
				sCount:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
			Else 
				$periodo:=0
				sCount:=<>gNombreAgnoEscolar
			End if 
			For ($i;1;$size)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Cursos:3]Nivel_Numero:7)+"."+String:C10($aIdAlumnos{$i})
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P01_Castigos:110
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111
							aInt8{$i}:=[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99
							aReal1{$i}:=[Alumnos_SintesisAnual:210]P01_PorcentajeAsistencia:100
						: ($periodo=2)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P02_Castigos:139
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140
							aInt8{$i}:=[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128
							aReal1{$i}:=[Alumnos_SintesisAnual:210]P02_PorcentajeAsistencia:129
						: ($periodo=3)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P03_Castigos:168
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169
							aInt8{$i}:=[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157
							aReal1{$i}:=[Alumnos_SintesisAnual:210]P03_PorcentajeAsistencia:158
						: ($periodo=4)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P04_Castigos:197
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198
							aInt8{$i}:=[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186
							aReal1{$i}:=[Alumnos_SintesisAnual:210]P04_PorcentajeAsistencia:187
						: ($periodo=5)
							aInt1{$i}:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
							aInt2{$i}:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
							aInt3{$i}:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
							aInt4{$i}:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
							aInt5{$i}:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
							aInt6{$i}:=[Alumnos_SintesisAnual:210]P05_Castigos:226
							aInt7{$i}:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227
							aInt8{$i}:=[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215
							aReal1{$i}:=[Alumnos_SintesisAnual:210]P05_PorcentajeAsistencia:216
					End case 
				Else 
					aInt1{$i}:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
					aInt2{$i}:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
					aInt3{$i}:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
					aInt4{$i}:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
					aInt5{$i}:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
					aInt6{$i}:=[Alumnos_SintesisAnual:210]Castigos:43
					aInt7{$i}:=[Alumnos_SintesisAnual:210]Suspensiones:44
					aInt8{$i}:=[Alumnos_SintesisAnual:210]HorasEfectivas:32
					aReal1{$i}:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
				End if 
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;10;"aText1";"aInt1";"aInt2";"aInt3";"aInt4";"aInt5";"aInt6";"aInt7";"aInt8";"aReal1")
			
	End case 
	
	
	
	
	PL_SetHdrOpts (Self:C308->;2)
	PL_SetHeight (Self:C308->;3;1;1;4)
	PL_SetHdrStyle (Self:C308->;0;"Tahoma";8;1)
	PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
	PL_SetFormat (Self:C308->;2;"###";2;2)
	PL_SetFormat (Self:C308->;3;"###";2;2)
	PL_SetFormat (Self:C308->;4;"###";2;2)
	PL_SetFormat (Self:C308->;5;"###";2;2)
	PL_SetFormat (Self:C308->;6;"###";2;2)
	PL_SetFormat (Self:C308->;7;"###";2;2)
	
	
	PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetBrkStyle (Self:C308->;1;0;"Tahoma";8;1)
	PL_SetSort (Self:C308->;1;2;3;4)
	PL_SetRepeatVal (Self:C308->;1;1)
	PL_SetRepeatVal (Self:C308->;2;1)
	PL_SetRepeatVal (Self:C308->;3;1)
	PL_SetRepeatVal (Self:C308->;4;1)
	PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
	PL_SetBrkHeight (Self:C308->;1;1;2)
	PL_SetBrkText (Self:C308->;0;1;"Totales";0)
	PL_SetBrkText (Self:C308->;0;2;"\\sum";0)
	PL_SetBrkText (Self:C308->;0;3;"\\sum";0)
	PL_SetBrkText (Self:C308->;0;4;"\\sum";0)
	PL_SetBrkText (Self:C308->;0;5;"\\sum";0)
	PL_SetBrkText (Self:C308->;0;6;"\\sum";0)
	PL_SetBrkText (Self:C308->;0;7;"\\sum";0)
	PL_SetBrkText (Self:C308->;0;8;"\\sum";0)
	PL_SetBrkColOpt (Self:C308->;0;0;1;1;"Black";"Black";0)
	PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";8;1)
	
	
	Case of 
		: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
			PL_SetWidths (Self:C308->;1;10;215;35;35;35;35;35;35;35;45;45)
			  // PL_SetHeaders (Self->;1;10;"Alumno";"Inasist.";"Atrasos\rinicio";"Atrasos\rinter\rsesión";"Anot. +";"Anot. -";"Cast.";"Susp.";"Horas\refect.";"%\rAsistencia")
			  // Ticket 157452 SPO 04/04/2016 Se cambia el nombre de la columna de castigo ("Cast.") a Disciplina ("Disc.")
			PL_SetHeaders (Self:C308->;1;10;"Alumno";"Inasist.";"Atrasos\rinicio";"Atrasos\rinter\rsesión";"Anot. +";"Anot. -";"Disc.";"Susp.";"Horas\refect.";"%\rAsistencia")
			PL_SetFormat (Self:C308->;2;"######";2;2)
			PL_SetFormat (Self:C308->;8;"###";2;2)
			  // Modificado por: Saul Ponce (09/12/2017) Ticket Nº 193374, para permitir que se muestren 4 cifras en la columna Horas Efectivas. Antes aparecía "<<<" en lugar de 4 cifras
			  //PL_SetFormat (Self->;9;"###";2;2)
			PL_SetFormat (Self:C308->;9;"###0";2;2)
			PL_SetFormat (Self:C308->;10;"####";2;2)
			PL_SetFormat (Self:C308->;11;"##0"+<>txs_rs_decimalseparator+"0";2;2)
			PL_SetBrkText (Self:C308->;0;10;"\\Average";0)
			PL_SetBrkText (Self:C308->;0;14;"\\Average";0)
			PL_SetBrkStyle (Self:C308->;11;0;"Tahoma";8;1)
		Else 
			PL_SetWidths (Self:C308->;1;10;215;35;35;35;35;35;35;35;45;45)
			  // PL_SetHeaders (Self->;1;11;"Alumno";"Inasist.";"Atrasos\rinicio";"Atrasos\rinter\rsesión";"Anot. +";"Anot. -";"Cast.";"Susp.";"%\rAsistencia"+<>cr+"a la fecha";"%"+<>cr+"en el año")
			  // Ticket 157452 SPO 04/04/2016 Se cambia el nombre de la columna de castigo ("Cast.") a Disciplina ("Disc.")
			PL_SetHeaders (Self:C308->;1;11;"Alumno";"Inasist.";"Atrasos\rinicio";"Atrasos\rinter\rsesión";"Anot. +";"Anot. -";"Disc.";"Susp.";"%\rAsistencia"+"\r"+"a la fecha";"%"+"\r"+"en el año")
			PL_SetFormat (Self:C308->;8;"###";2;2)
			PL_SetFormat (Self:C308->;9;"##0"+<>txs_rs_decimalseparator+"0";2;2)
			PL_SetFormat (Self:C308->;10;"##0"+<>txs_rs_decimalseparator+"0";2;2)
			PL_SetBrkText (Self:C308->;0;9;"\\Average";0)
			PL_SetBrkText (Self:C308->;0;10;"\\Average";0)
	End case 
End if 
