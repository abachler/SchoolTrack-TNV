  //[Alumnos].Input.NotasH_AgregarAsignatura

KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6)
$key:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key)
If (($recNum<0) | ([xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8=0) | ([xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9=0))
	$r:=CD_Dlog (0;__ ("No se han definido las propiedades de evaluación del registro histórico para el nivel ")+[xxSTR_Niveles:6]Nivel:1+__ (" en el año ")+String:C10([Alumnos_SintesisAnual:210]Año:2)+__ ("\r\r¿Desea hacerlo ahora?");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]ID_Institucion:1;=;<>gInstitucion)
		ORDER BY:C49([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;<)
		WDW_OpenFormWindow (->[xxSTR_HistoricoNiveles:191];"Propiedades";-5;8;__ ("Años anteriores: ")+[xxSTR_Niveles:6]Nivel:1)
		KRL_ModifyRecord (->[xxSTR_HistoricoNiveles:191];"Propiedades")
		CLOSE WINDOW:C154
		$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key)
	End if 
End if 

If (($recNum>=0) & ([xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8#0) & ([xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9#0))  //MONO TICKET 210909
	$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
	vt_text2:=""
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[Alumnos_SintesisAnual:210]Año:2)
	hl_EstilosHistoricos:=New list:C375
	hl_EstilosHistoricos:=HL_Selection2List (->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5;->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
	
	If ([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16=0)
		$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key;True:C214)
		If (([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16=0) | (BLOB size:C605([xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7)>32))
			[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=viSTR_Periodos_NumeroPeriodos
		End if 
		
		If ([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16=0)
			[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=5
		End if 
		SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
		KRL_ReloadAsReadOnly (->[xxSTR_HistoricoNiveles:191])
	End if 
	
	ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
	hl_EstilosActuales:=New list:C375
	hl_EstilosActuales:=HL_Selection2List (->[xxSTR_EstilosEvaluacion:44]Name:2;->[xxSTR_EstilosEvaluacion:44]ID:1)
	
	hl_EstilosEvaluacion:=New list:C375
	APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos almacenados en el año "+$nombreAñoEscolar;-1;hl_EstilosHistoricos;True:C214)
	APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos vigentes en el año actual";-2;hl_EstilosActuales;True:C214)
	vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
	
	
	REDUCE SELECTION:C351([Asignaturas_Historico:84];0)
	READ WRITE:C146([Alumnos_Calificaciones:208])
	$title:=[Alumnos:2]Nombre_Común:30+__ (", año ")+$nombreAñoEscolar+", "+[Alumnos_SintesisAnual:210]Curso:7
	WDW_OpenFormWindow (->[Alumnos_Calificaciones:208];"NuevoRegistroHistorico";-1;8;$title)
	FORM SET INPUT:C55([Alumnos_Calificaciones:208];"NuevoRegistroHistorico")
	ADD RECORD:C56([Alumnos_Calificaciones:208];*)
	CLOSE WINDOW:C154
	
	If ((OK=1) & (Record number:C243([Asignaturas_Historico:84])>0))
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		READ WRITE:C146([Alumnos_Calificaciones:208])
		LOAD RECORD:C52([Alumnos_Calificaciones:208])
		ALh_RecalcHistoric 
	End if 
	
	If (([Alumnos:2]nivel_numero:29=12) & ([Alumnos_Historico:25]Nivel:11>8) & (<>vtXS_CountryCode="cl"))
		[Alumnos:2]Chile_PromedioEMedia:73:=AL_PromedioUChile_cl 
		SAVE RECORD:C53([Alumnos:2])
	End if 
	al_LoadHNotas 
	REDRAW WINDOW:C456
	If (vb_HistoricoEditable)
		_O_ENABLE BUTTON:C192(bEditaHistoricos)
		OBJECT SET VISIBLE:C603(*;"unlocked";True:C214)
		OBJECT SET VISIBLE:C603(*;"locked";False:C215)
		OBJECT SET ENTERABLE:C238(*;"Historic@";True:C214)
		OBJECT SET COLOR:C271(*;"Historic@";-6)
		_O_ENABLE BUTTON:C192(bAddHSubject)
	End if 
Else 
	CD_Dlog (0;__ ("No es posible crear un registro histórico de calificaciones sin haber establecido previamente las propiedades de evaluación del registro histórico del nivel correspondiente."))
End if 
