If (Form event:C388=On Load:K2:1)
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	ARRAY TEXT:C222(atTMT_DayName;0)
	ARRAY INTEGER:C220(alTMT_Hora;0)
	ARRAY TEXT:C222(atTMT_Sala;0)
	ARRAY TEXT:C222(atTMT_Observaciones;0)
	ARRAY LONGINT:C221(alTMT_From;0)
	ARRAY LONGINT:C221(alTMT_To;0)
	If (vt_PLConfigMessage="byClass w/TimeTable")
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$aDay;[TMT_Horario:166]NumeroHora:2;alTMT_Hora;[TMT_Horario:166]Sala:8;atTMT_Sala;[TMT_Horario:166]Observaciones:7;atTMT_Observaciones;[TMT_Horario:166]Desde:3;alTMT_From;[TMT_Horario:166]Hasta:4;alTMT_To)
		ARRAY TEXT:C222(atTMT_DayName;Size of array:C274($aDay))
		For ($i;1;Size of array:C274($aDay))
			atTMT_DayName{$i}:=<>atXS_DayNames{$aDay{$i}+1}
		End for 
	End if 
	$err:=PL_SetArraysNam (xPL_Horario;1;6;"atTMT_DayName";"alTMT_Hora";"alTMT_From";"alTMT_To";"atTMT_Sala";"atTMT_Observaciones")
	PL_SetWidths (xPL_Horario;1;6;50;30;40;40;100;281)
	PL_SetHdrOpts (xPL_Horario;2)
	PL_SetHeight (xPL_Horario;1;1;0;0)
	PL_SetHdrStyle (xPL_Horario;0;"Tahoma";10;1)
	PL_SetStyle (xPL_Horario;0;"Tahoma";10;0)
	PL_SetHeaders (xPL_Horario;1;6;"Día";"Hora";"Desde";"Hasta";"Sala";"Observaciones")
	PL_SetDividers (xPL_Horario;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Horario;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetSort (xPL_Horario;1;2)
	PL_SetFormat (xPL_Horario;0;"";0;0)
	PL_SetFormat (xPL_Horario;2;"###";0;0)
	PL_SetFormat (xPL_Horario;3;"&/2";0;0)
	PL_SetFormat (xPL_Horario;4;"&/2";0;0)
End if 