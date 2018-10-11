  //[alumnos_HistoricoNotas].input.vs_subjectName

IT_Clairvoyance (Self:C308;-><>aAsign;"";True:C214)

If (Form event:C388=On Data Change:K2:15)
	
	$keyNivel:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Asignatura:2=Self:C308->;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4=[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5=[Alumnos_SintesisAnual:210]Año:2;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]ID_AsignaturaOriginal:30=0;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Profesor_Numero:12=0)
	If (Records in selection:C76([Asignaturas_Historico:84])=0)
		  //OK:=CD_Dlog (0;"Esta asignatura no existe en los registros históricos del nivel en este año."+<>cr+<>cr+"¿Desea usted crearla?";"";"Si";"No")
		OK:=CD_Dlog (0;"Esta asignatura es nueva para los alumnos que no han cursado, en el colegio, el nivel y año seleccionado.\r\r¿Desea usted agregar esta asignatura?";"";"Si";"No")
		If (OK=1)
			CREATE RECORD:C68([Asignaturas_Historico:84])
			[Asignaturas_Historico:84]Año:5:=[Alumnos_SintesisAnual:210]Año:2
			[Asignaturas_Historico:84]Asignatura:2:=Self:C308->
			[Asignaturas_Historico:84]Nivel:4:=[Alumnos_SintesisAnual:210]NumeroNivel:6
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=Self:C308->)
			[Asignaturas_Historico:84]Materia_UUID:45:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
			[Asignaturas_Historico:84]Incluida_En_Actas:7:=True:C214
			[Asignaturas_Historico:84]Nombre_interno:3:=[Asignaturas_Historico:84]Asignatura:2
			[Asignaturas_Historico:84]ID_RegistroHistorico:1:=SQ_SeqNumber (->[Asignaturas_Historico:84]ID_RegistroHistorico:1)
			[Asignaturas_Historico:84]Promediable:6:=True:C214
			SAVE RECORD:C53([Asignaturas_Historico:84])
			[Alumnos_Calificaciones:208]ID_Asignatura:5:=[Asignaturas_Historico:84]ID_AsignaturaOriginal:30
			[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas_Historico:84]Asignatura:2
			[Alumnos_Calificaciones:208]NombreInternoAsignatura:8:=[Asignaturas_Historico:84]Nombre_interno:3
			[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493:=[Asignaturas_Historico:84]ID_RegistroHistorico:1
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			OBJECT SET ENABLED:C1123(hl_EstilosEvaluacion;True:C214)
			OBJECT SET VISIBLE:C603(*;"notasHistoricas@";True:C214)
			OBJECT SET VISIBLE:C603(*;"estiloEvaluacion@";True:C214)
			
			OBJECT SET ENTERABLE:C238(*;"AprobacionDiferida@";True:C214)
			OBJECT SET ENTERABLE:C238([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88;True:C214)
			OBJECT SET ENTERABLE:C238(*;"vLabel@";False:C215)
			HIGHLIGHT TEXT:C210([Asignaturas_Historico:84]Nombre_interno:3;Length:C16([Asignaturas_Historico:84]Nombre_interno:3)+1;Length:C16([Asignaturas_Historico:84]Nombre_interno:3)+1)
			
			$key:="0."+String:C10([Asignaturas_Historico:84]Nivel:4)+"."+String:C10([Asignaturas_Historico:84]Año:5)
			[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
			vt_Text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
			
		End if 
	Else 
		[Alumnos_Calificaciones:208]ID_Asignatura:5:=[Asignaturas_Historico:84]ID_AsignaturaOriginal:30
		[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas_Historico:84]Asignatura:2
		[Alumnos_Calificaciones:208]NombreInternoAsignatura:8:=[Asignaturas_Historico:84]Nombre_interno:3
		[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493:=[Asignaturas_Historico:84]ID_RegistroHistorico:1
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		OBJECT SET VISIBLE:C603(*;"estiloEvaluacion@";True:C214)
		OBJECT SET VISIBLE:C603(*;"notasHistoricas@";True:C214)
		vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
		
		
		OBJECT SET ENTERABLE:C238(*;"AprobacionDiferida@";True:C214)
		OBJECT SET ENTERABLE:C238([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88;True:C214)
	End if 
	AL_ShowHideObjectHistoricos 
End if 
