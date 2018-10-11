  //alumnos.Horario.xPL_Horario

If (Form event:C388=On Load:K2:1)
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	
	ARRAY TEXT:C222(aSTR_Horario_Dia1;0)
	ARRAY TEXT:C222(aSTR_Horario_Dia2;0)
	ARRAY TEXT:C222(aSTR_Horario_Dia3;0)
	ARRAY TEXT:C222(aSTR_Horario_Dia4;0)
	ARRAY TEXT:C222(aSTR_Horario_Dia5;0)
	ARRAY TEXT:C222(aSTR_Horario_Dia6;0)
	ARRAY TEXT:C222(aSTR_Horario_Dia7;0)
	ARRAY LONGINT:C221(aColorDia1;0)
	ARRAY LONGINT:C221(aColorDia2;0)
	ARRAY LONGINT:C221(aColorDia3;0)
	ARRAY LONGINT:C221(aColorDia4;0)
	ARRAY LONGINT:C221(aColorDia5;0)
	ARRAY LONGINT:C221(aColorDia6;0)
	ARRAY LONGINT:C221(aColorDia7;0)
	$s:=Size of array:C274(aiSTR_Horario_HoraNo)
	ARRAY TEXT:C222(aSTR_Horario_Dia1;$s)
	ARRAY TEXT:C222(aSTR_Horario_Dia2;$s)
	ARRAY TEXT:C222(aSTR_Horario_Dia3;$s)
	ARRAY TEXT:C222(aSTR_Horario_Dia4;$s)
	ARRAY TEXT:C222(aSTR_Horario_Dia5;$s)
	ARRAY TEXT:C222(aSTR_Horario_Dia6;$s)
	ARRAY TEXT:C222(aSTR_Horario_Dia7;$s)
	ARRAY LONGINT:C221(aColorDia1;$s)
	ARRAY LONGINT:C221(aColorDia2;$s)
	ARRAY LONGINT:C221(aColorDia3;$s)
	ARRAY LONGINT:C221(aColorDia4;$s)
	ARRAY LONGINT:C221(aColorDia5;$s)
	ARRAY LONGINT:C221(aColorDia6;$s)
	ARRAY LONGINT:C221(aColorDia7;$s)
	dDate:=Current date:C33(*)
	hHeure:=Current time:C178(*)
	$cr:="\r"
	READ ONLY:C145([Alumnos_Calificaciones:208])
	READ ONLY:C145([TMT_Horario:166])
	READ ONLY:C145([Asignaturas:18])
	READ ONLY:C145([Profesores:4])
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	
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
			DELETE FROM ARRAY:C228($aSala;$i)
			DELETE FROM ARRAY:C228($aSubject;$i)
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
			$ptr->{$aHour{$i}}:=$aSubject{$i}+"\r"+$aTeacher{$i}+"\r"+"Sala: "+$aSala{$i}
			$ptrClr->{$aHour{$i}}:=$aTeacherColors{$i}
			If (($aSelection{$i}) | ($aElectiva{$i}))
				INSERT IN ARRAY:C227(a2Int{1};1;1)
				INSERT IN ARRAY:C227(a2Int{2};1;1)
				a2Int{1}{1}:=$aDay{$i}+3
				a2Int{2}{1}:=$i
			End if 
		End if 
	End for 
	
	If (vlSTR_Horario_SabadoLabor=0)
		$err:=PL_SetArraysNam (Self:C308->;1;8;"aiSTR_Horario_HoraNo";"alSTR_Horario_Desde";"alSTR_Horario_Hasta";"aSTR_Horario_Dia1";"aSTR_Horario_Dia2";"aSTR_Horario_Dia3";"aSTR_Horario_Dia4";"aSTR_Horario_Dia5")
		PL_SetWidths (Self:C308->;1;8;14;25;25;102;102;102;102;102)
		PL_SetHeaders (Self:C308->;1;8;"";"";"";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes")
	Else 
		$err:=PL_SetArraysNam (Self:C308->;1;9;"aiSTR_Horario_HoraNo";"alSTR_Horario_Desde";"alSTR_Horario_Hasta";"aSTR_Horario_Dia1";"aSTR_Horario_Dia2";"aSTR_Horario_Dia3";"aSTR_Horario_Dia4";"aSTR_Horario_Dia5";"aSTR_Horario_Dia6")
		PL_SetWidths (Self:C308->;1;9;14;25;25;85;85;85;85;85;85)
		PL_SetFormat (Self:C308->;9;"";2)
		PL_SetHeaders (Self:C308->;1;9;"";"";"";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes";"Sábado")
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
	PL_SetHeight (Self:C308->;1;1;5;0)
	PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
	PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
	PL_SetDividers (Self:C308->;0.3;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetCellStyle (Self:C308->;0;0;0;0;a2Int;2)
	
	If (vUseColor=1)
		ARRAY INTEGER:C220(a2Int;2;0)
		For ($i;1;6)
			$ptrClr:=Get pointer:C304("aColorDia"+String:C10($i))
			For ($j;1;Size of array:C274($ptrClr->))
				$color:=PV Color to index:P13000:248 ($ptrClr->{$j})
				If ($color=16)  //no hay clases o pusieron profesor en negro
					$color:=0
				End if 
				PL_SetCellColor (Self:C308->;$i+3;$j;$i+3;$j;a2Int;"";0;"";$color)
			End for 
		End for 
	End if 
End if 