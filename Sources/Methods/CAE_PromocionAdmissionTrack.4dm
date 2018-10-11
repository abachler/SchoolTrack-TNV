//%attributes = {}
  //CAE_PromocionAdmissionTrack

C_LONGINT:C283($records;$estadoTerm)
C_BLOB:C604($blob)

$admissionTrackIsInitialized:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
If ($admissionTrackIsInitialized=1)
	
	If (cbDeleteArchive=1)
		READ WRITE:C146([xxADT_PostulacionesHistoricas:112])
		If (vlADT_YearDeleteArchives>0)
			$date:=DT_GetDateFromDayMonthYear (1;1;vlADT_YearDeleteArchives)
			QUERY:C277([xxADT_PostulacionesHistoricas:112];[xxADT_PostulacionesHistoricas:112]Fecha_Inscripcion:5<$date)
		Else 
			ALL RECORDS:C47([xxADT_PostulacionesHistoricas:112])
		End if 
		If (Records in selection:C76([xxADT_PostulacionesHistoricas:112])>0)
			$result:=KRL_DeleteSelection (->[xxADT_PostulacionesHistoricas:112];True:C214;__ ("Eliminando registros de postulaciones históricas..."))
		End if 
		KRL_UnloadReadOnly (->[xxADT_PostulacionesHistoricas:112])
	End if 
	
	READ WRITE:C146([ADT_Candidatos:49])
	$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
	If ($estadoTerm#0)
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_SitFinal:51=$estadoTerm)
	Else 
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16=("Aceptado y confirmado"))
	End if 
	
	  //Mono 07-12-2011: desde 11151 los registros de ADT no se eliminan cuando entran a ST solo queda marcado en el campo [ADT_Candidatos]Transf_ST
	QUERY SELECTION:C341([ADT_Candidatos:49];[ADT_Candidatos:49]Transf_ST:68=False:C215)
	
	ARRAY LONGINT:C221($RNCandidatos;0)
	ARRAY LONGINT:C221($idCandidate;0)
	ARRAY LONGINT:C221($aNivel;0)
	SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$idCandidate;[ADT_Candidatos:49]Postula_a:6;$aNivel)
	LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$RNCandidatos;"")
	READ WRITE:C146([Alumnos:2])
	For ($i;1;Size of array:C274($idCandidate))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$idCandidate{$i})
		[Alumnos:2]nivel_numero:29:=$aNivel{$i}
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$aNivel{$i})
		[Alumnos:2]Nivel_Nombre:34:=[xxSTR_Niveles:6]Nivel:1
		[Alumnos:2]Nivel_al_que_ingreso:35:=[Alumnos:2]Nivel_Nombre:34
		$curso:=[xxSTR_Niveles:6]Abreviatura:19+"-ADT"
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
		If (Records in selection:C76([Cursos:3])=0)
			CREATE RECORD:C68([Cursos:3])
			[Cursos:3]Curso:1:=$curso
			[Cursos:3]Letra_del_curso:9:="ADT"
			[Cursos:3]Letra_Oficial_del_Curso:18:="ADT"
			[Cursos:3]Nivel_Nombre:10:=[xxSTR_Niveles:6]Nivel:1
			[Cursos:3]Nivel_Numero:7:=[Alumnos:2]nivel_numero:29
			[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6;True:C214)
			SAVE RECORD:C53([Cursos:3])
		End if 
		[Alumnos:2]curso:20:=[Cursos:3]Curso:1
		[Alumnos:2]Status:50:=""  //se cargara en el trigger de alumnos
		SAVE RECORD:C53([Alumnos:2])
		AL_CreaRegistros 
	End for 
	KRL_UnloadReadOnly (->[Alumnos:2])
	CREATE SELECTION FROM ARRAY:C640([ADT_Candidatos:49];$RNCandidatos;"")
	ARRAY LONGINT:C221($aIDs;0)
	SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$aIDs)
	ADTcdd_DeleteEducacionAnterior (->$aIDs;"al")
	DELETE SELECTION:C66([ADT_Candidatos:49])
	
	If (False:C215)
		If ($estadoTerm#0)
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_SitFinal:51#$estadoTerm)
		Else 
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16#("Aceptado y confirmado"))
		End if 
		
		CREATE SET:C116([ADT_Candidatos:49];"PostulationsToBeDeleted")
		
		KRL_RelateSelection (->[Familia:78]Numero:1;->[ADT_Candidatos:49]Familia_numero:30)
		CREATE SET:C116([Familia:78];"FamiliesToBeDeleted")
		
		USE SET:C118("PostulationsToBeDeleted")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1)
		ARRAY LONGINT:C221($aAL2Delete;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aAL2Delete;"")
		For ($x;1;Size of array:C274($aAL2Delete))
			READ WRITE:C146([Alumnos:2])
			GOTO RECORD:C242([Alumnos:2];$aAL2Delete{$x})
			$result:=ADTcdd_DeleteAlumno 
			READ WRITE:C146([ADT_Candidatos:49])
			$rnCdd:=Find in field:C653([ADT_Candidatos:49]Candidato_numero:1;[Alumnos:2]numero:1)
			GOTO RECORD:C242([ADT_Candidatos:49];$rnCdd)
			If (bDeleteRejected=0)
				CREATE RECORD:C68([xxADT_PostulacionesHistoricas:112])
				[xxADT_PostulacionesHistoricas:112]ID:4:=SQ_SeqNumber (->[xxADT_PostulacionesHistoricas:112]ID:4)
				[xxADT_PostulacionesHistoricas:112]RUT:1:=[ADT_Candidatos:49]RUT:46
				[xxADT_PostulacionesHistoricas:112]Apellidos_y_Nombres:2:=[Alumnos:2]apellidos_y_nombres:40
				[xxADT_PostulacionesHistoricas:112]Fecha_Inscripcion:5:=[ADT_Candidatos:49]Fecha_de_Inscripción:2
				[xxADT_PostulacionesHistoricas:112]Sit_Final:6:=[ADT_Candidatos:49]Situación_final:16
				$otRef:=OT New 
				OT PutString ($otRef;"NombrePadre";[ADT_Candidatos:49]Padre_nombre:33)
				OT PutString ($otRef;"NombreMadre";[ADT_Candidatos:49]Madre_nombre:34)
				OT PutDate ($otRef;"FechaInscripcion";[ADT_Candidatos:49]Fecha_de_Inscripción:2)
				OT PutString ($otRef;"Inscriptor";[ADT_Candidatos:49]Inscriptor:3)
				OT PutString ($otRef;"CalInscripcion";[ADT_Candidatos:49]Calificación_Inscripción:11)
				OT PutText ($otRef;"ObsInscripcion";[ADT_Candidatos:49]Observaciones_inscripción:10)
				OT PutText ($otRef;"Recomendacion";[ADT_Candidatos:49]Recomendación:9)
				OT PutString ($otRef;"Entrevistador";[ADT_Candidatos:49]Entrevistador:20)
				OT PutString ($otRef;"CalEntrevista";[ADT_Candidatos:49]Calificación_entrevista:13)
				OT PutText ($otRef;"ObsEntrevista";[ADT_Candidatos:49]Observaciones_entrevista:12)
				OT PutString ($otRef;"Examinador";[ADT_Candidatos:49]Examinador:8)
				OT PutReal ($otRef;"PuntajeExamen";[ADT_Candidatos:49]Puntaje_examen:15)
				OT PutText ($otRef;"ObsExamen";[ADT_Candidatos:49]Observaciones_examen:14)
				OT PutReal ($otRef;"EvConductual";[ADT_Candidatos:49]Evaluación_conductual:38)
				OT PutString ($otRef;"SitFinal";[ADT_Candidatos:49]Situación_final:16)
				
				$blob:=OT ObjectToNewBLOB ($otRef)
				OT Clear ($otRef)
				[xxADT_PostulacionesHistoricas:112]xData:3:=$blob
				COMPRESS BLOB:C534([xxADT_PostulacionesHistoricas:112]xData:3;1)
				SAVE RECORD:C53([xxADT_PostulacionesHistoricas:112])
			End if 
			DELETE RECORD:C58([ADT_Candidatos:49])
			ARRAY LONGINT:C221($aIDs;0)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIDs)
			ADTcdd_DeleteEducacionAnterior (->$aIDs;"al")
			DELETE RECORD:C58([Alumnos:2])
		End for 
		
		USE SET:C118("FamiliesToBeDeleted")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
		While (Not:C34(End selection:C36([Familia:78])))
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
			If ($records#0)
				REMOVE FROM SET:C561([Familia:78];"FamiliesToBeDeleted")
			End if 
			NEXT RECORD:C51([Familia:78])
		End while 
		SET QUERY DESTINATION:C396(0)
		
		USE SET:C118("FamiliesToBeDeleted")
		KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5)
		CREATE SET:C116([Personas:7];"padres")
		KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6)
		CREATE SET:C116([Personas:7];"madres")
		UNION:C120("padres";"madres";"PersonsToBeDeleted")
		SET_ClearSets ("Padres";"Madres")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
		While (Not:C34(End selection:C36([Personas:7])))
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
			If ($records#0)
				REMOVE FROM SET:C561([Personas:7];"PersonsToBeDeleted")
			End if 
			NEXT RECORD:C51([Personas:7])
		End while 
		SET QUERY DESTINATION:C396(0)
		
		USE SET:C118("FamiliesToBeDeleted")
		$result:=KRL_DeleteSelection (->[Familia:78])
		USE SET:C118("PersonsToBeDeleted")
		ARRAY LONGINT:C221($aIDs;0)
		SELECTION TO ARRAY:C260([Personas:7]No:1;$aIDs)
		ADTcdd_DeleteEducacionAnterior (->$aIDs;"pe")
		$result:=KRL_DeleteSelection (->[Personas:7])
		KRL_UnloadReadOnly (->[Alumnos:2])
		
		SET_ClearSets ("PostulationsToBeDeleted";"FamiliesToBeDeleted";"PersonsToBeDeleted")
		
	End if 
	
	READ WRITE:C146([ADT_Examenes:122])
	READ WRITE:C146([ADT_SesionesDeExamenes:123])
	READ WRITE:C146([ADT_Entrevistas:121])
	ALL RECORDS:C47([ADT_Examenes:122])
	ALL RECORDS:C47([ADT_SesionesDeExamenes:123])
	ALL RECORDS:C47([ADT_Entrevistas:121])
	$result:=KRL_DeleteSelection (->[ADT_Examenes:122];True:C214;__ ("Eliminando registros de exámenes..."))
	$result:=KRL_DeleteSelection (->[ADT_SesionesDeExamenes:123];True:C214;__ ("Eliminando registros de sesiones de exámenes..."))
	$result:=KRL_DeleteSelection (->[ADT_Entrevistas:121];True:C214;__ ("Eliminando registros de entrevistas..."))
	
	  //PREF_Set (0;"ADT_Inicializado";"0")
	xxADT_ConservarConfiguracion 
	
	KRL_UnloadReadOnly (->[ADT_Examenes:122])
	KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
	KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
	KRL_UnloadReadOnly (->[ADT_Candidatos:49])
	KRL_UnloadReadOnly (->[Alumnos:2])
End if 