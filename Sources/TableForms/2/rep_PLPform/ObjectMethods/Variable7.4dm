  //Método de Objeto: [Alumnos].rep_PLPform.xPL_List

If (Form event:C388=On Load:K2:1)
	vt_PLConfigMessage:=[xShell_Reports:54]SpecialParameter:18
	
	Case of 
		: (vt_PLConfigMessage="Enfermeria")
			sTitle:="Informe de visitas a Enfermería"
			sSubtitle:=[Alumnos:2]apellidos_y_nombres:40
			QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2>=vinidate;*)
			QUERY:C277([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2<=venddate)
			
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;aDate1;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;aLInt1;[Alumnos_EventosEnfermeria:14]Afeccion:6;aText1;[Alumnos_EventosEnfermeria:14]Tratamiento:7;aText2;[Alumnos_EventosEnfermeria:14]Hora_de_Salida:8;aLInt2;[Alumnos_EventosEnfermeria:14]Destino:9;aText3;[Alumnos_EventosEnfermeria:14]Observaciones:10;aText4)
			$err:=PL_SetArraysNam (Self:C308->;1;7;"aDate1";"aLInt1";"aLInt2";"aText1";"aText2";"aText3";"aText4")
			PL_SetWidths (Self:C308->;1;7;34;33;33;100;100;50;200)
			PL_SetHeaders (Self:C308->;1;7;"Fecha";"Ingreso";"Salida";"Afección";"Tratamiento";"Destino";"Observaciones")
			PL_SetFormat (Self:C308->;1;"0")
			PL_SetFormat (Self:C308->;2;"&/2")
			PL_SetFormat (Self:C308->;3;"&/2")
			PL_SetSort (Self:C308->;-1)
			PL_SetHdrOpts (Self:C308->;2)
			PL_SetHeight (Self:C308->;2;1;0;10)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";8;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";0;1)
			PL_SetBrkRowDiv (Self:C308->;1.25;"Black";"Black";0)
			PL_SetBrkHeight (Self:C308->;0;1;2)
			  //PL_SetBrkText (Self->;0;1;"\\count visita(s) a enfermería";3;1)
			PL_SetBrkText (Self:C308->;0;1;String:C10(Size of array:C274(aDate1))+" visita(s) a enfermería";3;1)
			PL_SetBrkColOpt (Self:C308->;0;0;1;1;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";8;1)
			
		: (vt_PLConfigMessage="Comentarios")
			PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
			sTitle:="Observaciones de los Profesores - "+atSTR_Periodos_Nombre{vPeriodo}
			sSubtitle:=[Alumnos:2]apellidos_y_nombres:40
			
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;aOrder;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;aText1;[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;aText2;[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29;aText3;[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34;aText4;[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39;aText5;[Asignaturas:18]Asignatura:3;$asg;[Profesores:4]Apellidos_y_nombres:28;$prof)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			
			
			
			
			ARRAY TEXT:C222(aText6;Size of array:C274($asg))
			For ($i;1;Size of array:C274($asg))
				aText6{$i}:=$asg{$i}+", "+$prof{$i}
				atext1{$i}:=ST_ClearSpaces (ST_ClearExtraCR (aText1{$i}))+("\r"*2)
				atext2{$i}:=ST_ClearSpaces (ST_ClearExtraCR (aText2{$i}))+("\r"*2)
				atext3{$i}:=ST_ClearSpaces (ST_ClearExtraCR (aText3{$i}))+("\r"*2)
				atext4{$i}:=ST_ClearSpaces (ST_ClearExtraCR (aText4{$i}))+("\r"*2)
				atext5{$i}:=ST_ClearSpaces (ST_ClearExtraCR (aText5{$i}))+("\r"*2)
			End for 
			
			
			
			Case of 
				: (atSTR_Periodos_Nombre=1)
					$err:=PL_SetArraysNam (Self:C308->;1;3;"aText1";"aText6";"aOrder")
				: (atSTR_Periodos_Nombre=2)
					$err:=PL_SetArraysNam (Self:C308->;1;3;"aText2";"aText6";"aOrder")
				: (atSTR_Periodos_Nombre=3)
					$err:=PL_SetArraysNam (Self:C308->;1;3;"aText3";"aText6";"aOrder")
				: (atSTR_Periodos_Nombre=4)
					$err:=PL_SetArraysNam (Self:C308->;1;3;"aText4";"aText6";"aOrder")
				: (atSTR_Periodos_Nombre=5)
					$err:=PL_SetArraysNam (Self:C308->;1;3;"aText5";"aText6";"aOrder")
			End case 
			
			PL_SetSort (Self:C308->;3;2)
			PL_SetColOpts (Self:C308->;2)
			PL_SetHdrOpts (Self:C308->;0)
			PL_SetHeight (Self:C308->;2;1;0;10)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetBkHText (Self:C308->;2;1;"\r"+"\\Breakvalue";4;0)
			PL_SetBkHStyle (Self:C308->;2;0;"Tahoma";9;1)
			PL_SetBkHColOpt (Self:C308->;2;0;0;0;"";"";0)
			PL_SetBkHHeight (Self:C308->;2;2;0)
			PL_SetBkHColor (Self:C308->;2;1;"Black";0;"";13)
	End case 
End if 








