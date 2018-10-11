//%attributes = {}
  //PST_closeAdmissions

C_LONGINT:C283($records)
C_BLOB:C604($blob)

START TRANSACTION:C239
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ADT_CloseAdmission";0;8;__ ("Cierre del proceso de admisión"))
DIALOG:C40([xxSTR_Constants:1];"ADT_CloseAdmission")
CLOSE WINDOW:C154
If (ok=1)
	$result:=1
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
	
	  //AUTOMATIC RELATIONS(True;False)
	  //READ WRITE([ADT_Candidatos])
	  //QUERY([ADT_Candidatos];[ADT_Candidatos]Situación_final=("Aceptado y confirmado");*)
	  //QUERY([ADT_Candidatos]; & [ADT_Candidatos]Curso#"";*)
	  //QUERY([ADT_Candidatos]; & [ADT_Candidatos]Terminado=False)
	  //SELECTION TO ARRAY([ADT_Candidatos]Candidato_numero;$idCandidate;[Alumnos]Número;$idStudent;[ADT_Candidatos]Curso;$aClass)
	  //
	  //If (Records in set("lockedSet")=0)
	  //SORT ARRAY($idCandidate;$aClass;>)
	  //KRL_RelateSelection (->[Alumnos]Número;->[ADT_Candidatos]Candidato_numero;"")
	  //ORDER BY([Alumnos];[Alumnos]Número;>)
	  //READ WRITE([Alumnos])
	  //ARRAY TO SELECTION($aClass;[Alumnos]Curso)
	  //If (Records in set("lockedSet")=0)
	  //APPLY TO SELECTION([Alumnos];GetStudNivel )
	  //End if 
	  //DELETE SELECTION([ADT_Candidatos])
	  //End if 
	  //AUTOMATIC RELATIONS(False;False)
	
	  //If (Records in set("LockedSet")=0)
	If ($result=1)
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16#("Aceptado y confirmado"))
		CREATE SET:C116([ADT_Candidatos:49];"PostulationsToBeDeleted")
		
		KRL_RelateSelection (->[Familia:78]Numero:1;->[ADT_Candidatos:49]Familia_numero:30)
		CREATE SET:C116([Familia:78];"FamiliesToBeDeleted")
		
		USE SET:C118("PostulationsToBeDeleted")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1)
		ARRAY LONGINT:C221($aAL2Delete;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aAL2Delete;"")
		For ($x;1;Size of array:C274($aAL2Delete))
			GOTO RECORD:C242([Alumnos:2];$aAL2Delete{$x})
			READ WRITE:C146([Alumnos:2])
			$result:=ADTcdd_DeleteAlumno 
			If ($result=1)
				If (Not:C34(Locked:C147([Alumnos:2])))
					READ WRITE:C146([ADT_Candidatos:49])
					$rnCdd:=Find in field:C653([ADT_Candidatos:49]Candidato_numero:1;[Alumnos:2]numero:1)
					GOTO RECORD:C242([ADT_Candidatos:49];$rnCdd)
					If (bDeleteRejected=1)
						DELETE RECORD:C58([ADT_Candidatos:49])
					Else 
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
						DELETE RECORD:C58([ADT_Candidatos:49])
					End if 
					DELETE RECORD:C58([Alumnos:2])
				Else 
					$result:=0
					$x:=Size of array:C274($aAL2Delete)+1
				End if 
			Else 
				$x:=Size of array:C274($aAL2Delete)+1
			End if 
		End for 
		If ($result=1)
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
				Else 
					  //20130111 RCH
					If ([Personas:7]Saldo_Ejercicio:85#0)  // no se elimina 
						REMOVE FROM SET:C561([Personas:7];"PersonsToBeDeleted")
						  //20130320 Para no eliminar las familias.
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
						QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
						REMOVE FROM SET:C561([Familia:78];"FamiliesToBeDeleted")
					End if 
				End if 
				NEXT RECORD:C51([Personas:7])
			End while 
			SET QUERY DESTINATION:C396(0)
			
			USE SET:C118("FamiliesToBeDeleted")
			$result:=KRL_DeleteSelection (->[Familia:78])
			If ($result=1)
				USE SET:C118("PersonsToBeDeleted")
				$result:=KRL_DeleteSelection (->[Personas:7])
			End if 
			KRL_UnloadReadOnly (->[Alumnos:2])
		End if 
		SET_ClearSets ("PostulationsToBeDeleted";"FamiliesToBeDeleted";"PersonsToBeDeleted")
		If ($result=1)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando archivos de alumnos..."))
			ARRAY LONGINT:C221($aRecNum;0)
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=-2)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNum;"")
			For ($i;1;Size of array:C274($aRecNum))
				GOTO RECORD:C242([Alumnos:2];$arecNUM{$i})
				$id:=[Alumnos:2]numero:1
				$class:=[Alumnos:2]curso:20
				$recNUM:=$aRecNum{$i}
				AL_CreaRegistros 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);__ ("Verificando archivos de alumnos..."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		If ($result=1)
			KRL_UnloadReadOnly (->[ADT_Examenes:122])
			KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
			KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
			
			READ WRITE:C146([ADT_Examenes:122])
			READ WRITE:C146([ADT_SesionesDeExamenes:123])
			READ WRITE:C146([ADT_Entrevistas:121])
			ALL RECORDS:C47([ADT_Examenes:122])
			ALL RECORDS:C47([ADT_SesionesDeExamenes:123])
			ALL RECORDS:C47([ADT_Entrevistas:121])
			$result:=KRL_DeleteSelection (->[ADT_Examenes:122];True:C214;__ ("Eliminando registros de exámenes..."))
			If ($result=1)
				$result:=KRL_DeleteSelection (->[ADT_SesionesDeExamenes:123];True:C214;__ ("Eliminando registros de sesiones de exámenes..."))
			End if 
			If ($result=1)
				$result:=KRL_DeleteSelection (->[ADT_Entrevistas:121];True:C214;__ ("Eliminando registros de entrevistas..."))
			End if 
			ADT_CreateDefaultPrefs 
			KRL_UnloadReadOnly (->[ADT_Examenes:122])
			KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
			KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
			KRL_UnloadReadOnly (->[ADT_Candidatos:49])
			KRL_UnloadReadOnly (->[Alumnos:2])
		End if 
	End if 
	If ((Records in set:C195("LockedSet")=0) & ($result=1))
		VALIDATE TRANSACTION:C240
		CD_Dlog (0;__ ("El proceso de postulaciones ha sido cerrado. AdmissionTrack se cerrará."))
		$ADTPosition:=Find in array:C230(<>atXS_ModuleNames;"AdmissionTrack")
		If ($ADTPosition#-1)
			$moduleProcessIDADT:=<>alXS_ModuleProcessID{$ADTPosition}
			BRING TO FRONT:C326($moduleProcessIDADT)
			POST KEY:C465(27;0;$moduleProcessIDADT)
		End if 
	Else 
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("El proceso de cierre no se ha podido llevar a cabo debido a que hay registros en uso. Inténtelo de nuevo más tarde."))
	End if 
Else 
	CANCEL TRANSACTION:C241
End if 