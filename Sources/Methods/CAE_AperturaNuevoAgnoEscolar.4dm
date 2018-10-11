//%attributes = {}
  //CAE_AperturaNuevoAgnoEscolar

<>vb_MsgON:=True:C214

PERIODOS_Init 
PERIODOS_LoadData 

READ WRITE:C146([xxSTR_Periodos:100])
READ WRITE:C146([xxSTR_DatosPeriodos:132])
ALL RECORDS:C47([xxSTR_Periodos:100])
While (Not:C34(End selection:C36([xxSTR_Periodos:100])))
	vlSTR_Periodos_CurrentConfigRef:=[xxSTR_Periodos:100]ID:1
	[xxSTR_Periodos:100]Inicio_Ejercicio:4:=Add to date:C393([xxSTR_Periodos:100]Inicio_Ejercicio:4;1;0;0)
	[xxSTR_Periodos:100]Fin_Ejercicio:5:=Add to date:C393([xxSTR_Periodos:100]Fin_Ejercicio:5;1;0;0)
	
	  //inicialización del calendario
	DT_SetCalendar ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5)
	$otRef:=OT New 
	OT PutArray ($otRef;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
	$blob:=OT ObjectToNewBLOB ($otRef)
	[xxSTR_Periodos:100]Feriados:7:=$blob
	OT Clear ($otRef)
	SAVE RECORD:C53([xxSTR_Periodos:100])
	
	QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=vlSTR_Periodos_CurrentConfigRef)
	While (Not:C34(End selection:C36([xxSTR_DatosPeriodos:132])))
		[xxSTR_DatosPeriodos:132]FechaInicio:3:=Add to date:C393([xxSTR_DatosPeriodos:132]FechaInicio:3;1;0;0)
		[xxSTR_DatosPeriodos:132]FechaTermino:4:=Add to date:C393([xxSTR_DatosPeriodos:132]FechaTermino:4;1;0;0)
		[xxSTR_DatosPeriodos:132]FechaCierre:5:=Add to date:C393([xxSTR_DatosPeriodos:132]FechaCierre:5;1;0;0)
		[xxSTR_DatosPeriodos:132]DiasHabiles:6:=DT_GetWorkingDays ([xxSTR_DatosPeriodos:132]FechaInicio:3;[xxSTR_DatosPeriodos:132]FechaTermino:4)
		SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
		NEXT RECORD:C51([xxSTR_DatosPeriodos:132])
	End while 
	
	
	READ WRITE:C146([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
	APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]FechaTermino:34:=[xxSTR_Periodos:100]Fin_Ejercicio:5)
	APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]FechaInicio:29:=[xxSTR_Periodos:100]Inicio_Ejercicio:4)
	APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]Dias_habiles:20:=[xxSTR_Periodos:100]Dias_Habiles:10)
	UNLOAD RECORD:C212([xxSTR_Niveles:6])
	
	
	NEXT RECORD:C51([xxSTR_Periodos:100])
End while 

NIV_LoadArrays 

ARRAY LONGINT:C221($aRecNums;0)
If (bInitNumMatricula=1)
	$pID:=IT_UThermometer (1;0;__ ("Inicializando Números de matrícula..."))
	Case of 
		: (i1InitNumMatricula=1)
			$numMatricula:=0
			READ WRITE:C146([Alumnos:2])
			QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelRegular)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
				[Alumnos:2]numero_de_matricula:51:=String:C10($i;"00000")
				SAVE RECORD:C53([Alumnos:2])
			End for 
		: (i2InitNumMatricula=1)
			READ WRITE:C146([Alumnos:2])
			For ($j;1;Size of array:C274(<>al_NumeroNivelRegular))
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=<>al_NumeroNivelRegular{$j})
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=<>al_NumeroNivelRegular{$j})
				ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
				LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
				For ($i;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
					[Alumnos:2]numero_de_matricula:51:=[xxSTR_Niveles:6]Abreviatura:19+"-"+String:C10($i;"0000")
					SAVE RECORD:C53([Alumnos:2])
				End for 
			End for 
	End case 
	IT_UThermometer (-2;$pID)
	UNLOAD RECORD:C212([Alumnos:2])
	READ ONLY:C145([Alumnos:2])
End if 
UNLOAD RECORD:C212([xxSTR_Periodos:100])
READ WRITE:C146([xxSTR_Periodos:100])

READ WRITE:C146([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
FIRST RECORD:C50([xxSTR_Constants:1])
[xxSTR_Constants:1]Año:8:=<>gYear+1
[xxSTR_Constants:1]NombreEjercicio:29:=String:C10(<>gYear+1)
SAVE RECORD:C53([xxSTR_Constants:1])
UNLOAD RECORD:C212([xxSTR_Constants:1])
STR_ReadGlobals 


