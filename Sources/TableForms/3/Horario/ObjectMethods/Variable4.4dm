  //Método de Objeto: [cursos]horario.xPL_Horario


Case of 
	: (Form event:C388=On Load:K2:1)
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
		
		sCurso:=[Cursos:3]Curso:1
		dDate:=Current date:C33(*)
		hHeure:=Current time:C178(*)
		
		C_TEXT:C284($txtColor)
		C_LONGINT:C283($Red;$Green;$Blue)
		
		C_LONGINT:C283($cantDias)
		
		ARRAY TEXT:C222(aSTR_Horario_Dia1;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia2;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia3;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia4;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia5;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia6;0)
		ARRAY LONGINT:C221(aColorDia1;0)
		ARRAY LONGINT:C221(aColorDia2;0)
		ARRAY LONGINT:C221(aColorDia3;0)
		ARRAY LONGINT:C221(aColorDia4;0)
		ARRAY LONGINT:C221(aColorDia5;0)
		ARRAY LONGINT:C221(aColorDia6;0)
		$s:=Size of array:C274(aiSTR_Horario_HoraNo)
		ARRAY TEXT:C222(aSTR_Horario_Dia1;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia2;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia3;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia4;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia5;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia6;$s)
		ARRAY LONGINT:C221(aColorDia1;$s)
		ARRAY LONGINT:C221(aColorDia2;$s)
		ARRAY LONGINT:C221(aColorDia3;$s)
		ARRAY LONGINT:C221(aColorDia4;$s)
		ARRAY LONGINT:C221(aColorDia5;$s)
		ARRAY LONGINT:C221(aColorDia6;$s)
		
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([TMT_Horario:166])
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([Profesores:4])
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
		KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
		KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
		QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))  //20120817 ASM para mostrar solo los bloques con sesiones activas a la fecha de impresión.
		
		vtSTR_Horario_NombreCiclo:=""
		If (vlSTR_Horario_NoCiclos=2)
			QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]No_Ciclo:14=vlSTR_Horario_CicloNumero)
			vtSTR_Horario_NombreCiclo:="Semana "+Char:C90(vlSTR_Horario_CicloNumero+64)
		End if 
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$aDay;[TMT_Horario:166]NumeroHora:2;$aHour;[TMT_Horario:166]Sala:8;$aSala;[Asignaturas:18]denominacion_interna:16;$aSubject;[Asignaturas:18]Seleccion:17;$aSelection;[Asignaturas:18]Electiva:11;$aElectiva;[Profesores:4]Nombre_comun:21;$aTeacher;[Profesores:4]Color_en_Horario:67;$aTeacherColors)
		For ($i;Size of array:C274($aDay);1;-1)
			If ($aSubject{$i}="")
				DELETE FROM ARRAY:C228($aDay;$i)
				DELETE FROM ARRAY:C228($aHour;$i)
				DELETE FROM ARRAY:C228($aSubject;$i)
				DELETE FROM ARRAY:C228($aSala;$i)
				DELETE FROM ARRAY:C228($aSelection;$i)
				DELETE FROM ARRAY:C228($aElectiva;$i)
				DELETE FROM ARRAY:C228($aTeacher;$i)
				DELETE FROM ARRAY:C228($aTeacherColors;$i)
			End if 
		End for 
		
		ARRAY INTEGER:C220(a2Int;2;0)
		For ($i;1;Size of array:C274($aDay))
			$ptr:=Get pointer:C304("aSTR_Horario_Dia"+String:C10($aDay{$i}))
			$ptrClr:=Get pointer:C304("aColorDia"+String:C10($aDay{$i}))
			If ($aHour{$i}<=Size of array:C274($ptr->))
				$ptr->{$aHour{$i}}:=$ptr->{$aHour{$i}}+("\r"*Num:C11($ptr->{$aHour{$i}}#""))+$aSubject{$i}+"\r"+$aTeacher{$i}+"\r"+"Sala: "+$aSala{$i}
				$ptrClr->{$aHour{$i}}:=$aTeacherColors{$i}
				If (($aSelection{$i}) | ($aElectiva{$i}))
					INSERT IN ARRAY:C227(a2Int{1};1;1)
					INSERT IN ARRAY:C227(a2Int{2};1;1)
					a2Int{1}{1}:=$aDay{$i}+3
					a2Int{2}{1}:=$i
				End if 
			End if 
		End for 
		
		
		$maxLines:=3
		For ($i;1;6)
			For ($j;1;Size of array:C274(aiSTR_Horario_HoraNo))
				$ptr:=(Get pointer:C304("aSTR_Horario_Dia"+String:C10($i)))
				$lines:=ST_countlines ($ptr->{$j})
				If ($lines>$maxLines)
					$maxLines:=$lines
				End if 
			End for 
		End for 
		
		If (vlSTR_Horario_SabadoLabor=0)
			$err:=PL_SetArraysNam (Self:C308->;1;8;"aiSTR_Horario_HoraNo";"alSTR_Horario_Desde";"alSTR_Horario_Hasta";"aSTR_Horario_Dia1";"aSTR_Horario_Dia2";"aSTR_Horario_Dia3";"aSTR_Horario_Dia4";"aSTR_Horario_Dia5")
			PL_SetWidths (Self:C308->;1;8;14;25;25;136;136;136;136;136)
			PL_SetHeaders (Self:C308->;1;8;"";"";"";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes")
			
			
			  //Alexis Bustamante
			  //Integrado en V12 13-06-2016
			  // Modificado por: Alexis Bustamante (03-06-2016)
			  //Ticket 161655 - (ST-CL) Saint Peter´s School (V)
			
			$cantDias:=0
			$cantDias:=5
		Else 
			$err:=PL_SetArraysNam (Self:C308->;1;9;"aiSTR_Horario_HoraNo";"alSTR_Horario_Desde";"alSTR_Horario_Hasta";"aSTR_Horario_Dia1";"aSTR_Horario_Dia2";"aSTR_Horario_Dia3";"aSTR_Horario_Dia4";"aSTR_Horario_Dia5";"aSTR_Horario_Dia6")
			PL_SetWidths (Self:C308->;1;9;14;25;25;113;113;113;113;113;113)
			PL_SetHeaders (Self:C308->;1;9;"";"";"";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes";"Sábado")
			PL_SetFormat (Self:C308->;9;"";2)
			
			  //Alexis Bustamante
			  //Integrado en V12 13-06-2016
			  // Modificado por: Alexis Bustamante (03-06-2016)
			  //Ticket 161655 - (ST-CL) Saint Peter´s School (V)
			
			$cantDias:=0
			$cantDias:=6
		End if 
		PL_SetFormat (Self:C308->;1;"##";2)
		PL_SetFormat (Self:C308->;2;"&/2";2)
		PL_SetFormat (Self:C308->;3;"&/2";2)
		PL_SetFormat (Self:C308->;4;"";2)
		PL_SetFormat (Self:C308->;5;"";2)
		PL_SetFormat (Self:C308->;6;"";2)
		PL_SetFormat (Self:C308->;7;"";2)
		PL_SetFormat (Self:C308->;8;"";2)
		PL_SetHdrOpts (Self:C308->;2)
		PL_SetHeight (Self:C308->;1;1;$maxLines;0)
		PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
		PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
		PL_SetDividers (Self:C308->;0.3;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetCellStyle (Self:C308->;0;0;0;0;a2Int;2)
		
		If (vUseColor=1)
			ARRAY INTEGER:C220(a2Int;2;0)
			
			For ($i;1;$cantDias)
				$ptrClr:=Get pointer:C304("aColorDia"+String:C10($i))
				
				For ($j;1;Size of array:C274($ptrClr->))
					  //$color:=PV Color to index ($ptrClr->{$j})
					
					  // Modificado por: Alexis Bustamante (07-04-2016)
					  // Modificado por: Daniel Ledezma(07-04-2016)
					
					  //En el horario los colores mostrados no eran los mismo asignados
					$txtColor:=SVG_Color_RGB_from_long ($ptrClr->{$j})
					$txtColor:=Replace string:C233($txtColor;"RGB(";"")
					$txtColor:=Replace string:C233($txtColor;")";"")
					
					$Red:=Num:C11(ST_GetWord ($txtColor;1;","))
					$Green:=Num:C11(ST_GetWord ($txtColor;2;","))
					$Blue:=Num:C11(ST_GetWord ($txtColor;3;","))
					$rgbColor:=PV RGB to color:P13000:246 ($Red;$Green;$Blue)
					
					$color:=PV Color to index:P13000:248 ($rgbColor)
					
					If ($color=16)  //no hay clases o pusieron profesor en negro
						$color:=0
					End if 
					
					  //$color:=6
					PL_SetCellColor (Self:C308->;$i+3;$j;$i+3;$j;a2Int;"";0;"";$color)
				End for 
			End for 
		End if 
End case 

