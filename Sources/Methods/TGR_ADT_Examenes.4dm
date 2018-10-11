//%attributes = {}
  // Método: TGR_ADT_Examenes
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:57:16
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		If ([ADT_Examenes:122]Secs:8#Old:C35([ADT_Examenes:122]Secs:8))
			  //If ([ADT_Examenes]Secs=0)
			  //[ADT_Examenes]Date_Exam:=!00/00/00!
			  //[ADT_Examenes]Time_Exam:=†00:00:00†
			  //Else 
			  //[ADT_Examenes]Date_Exam:=SYS_Secs2Date ([ADT_Examenes]Secs)
			  //[ADT_Examenes]Time_Exam:=SYS_Secs2Time ([ADT_Examenes]Secs)
			  //End if 
			READ WRITE:C146([ADT_Candidatos:49])
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Exam:29=[ADT_Examenes:122]ID:1)
			<>vb_AvoidTriggerExecution:=True:C214
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Exam:24:=[ADT_Examenes:122]Secs:8)
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Fecha_de_examen:7:=[ADT_Examenes:122]Date_Exam:2)
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Hora_de_examen:19:=[ADT_Examenes:122]Time_Exam:3)
			<>vb_AvoidTriggerExecution:=False:C215
			KRL_UnloadReadOnly (->[ADT_Candidatos:49])
		End if 
		
		[ADT_Examenes:122]Total:11:=[ADT_Examenes:122]Boys:10+[ADT_Examenes:122]Girls:9
		
		If (([ADT_Examenes:122]Time_Exam:3#Old:C35([ADT_Examenes:122]Time_Exam:3)) | ([ADT_Examenes:122]Date_Exam:2#Old:C35([ADT_Examenes:122]Date_Exam:2)))
			If (([ADT_Examenes:122]Time_Exam:3#?00:00:00?) & ([ADT_Examenes:122]Date_Exam:2#!00-00-00!))
				[ADT_Examenes:122]Secs:8:=SYS_DateTime2Secs ([ADT_Examenes:122]Date_Exam:2;[ADT_Examenes:122]Time_Exam:3)
			Else 
				[ADT_Examenes:122]Secs:8:=0
			End if 
			READ WRITE:C146([ADT_Candidatos:49])
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Exam:29=[ADT_Examenes:122]ID:1)
			<>vb_AvoidTriggerExecution:=True:C214
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Exam:24:=[ADT_Examenes:122]Secs:8)
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Fecha_de_examen:7:=[ADT_Examenes:122]Date_Exam:2)
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Hora_de_examen:19:=[ADT_Examenes:122]Time_Exam:3)
			<>vb_AvoidTriggerExecution:=False:C215
			KRL_UnloadReadOnly (->[ADT_Candidatos:49])
		End if 
		
		If ([ADT_Examenes:122]Total:11#Old:C35([ADT_Examenes:122]Total:11))
			READ WRITE:C146([ADT_SesionesDeExamenes:123])
			QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=[ADT_Examenes:122]ID_Sesion:12)
			[ADT_SesionesDeExamenes:123]Attendance:4:=[ADT_SesionesDeExamenes:123]Attendance:4-Old:C35([ADT_Examenes:122]Total:11)+[ADT_Examenes:122]Total:11
			SAVE RECORD:C53([ADT_SesionesDeExamenes:123])
			KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
		End if 
		
		If ([ADT_Examenes:122]Responsable:5#Old:C35([ADT_Examenes:122]Responsable:5))
			READ WRITE:C146([ADT_Candidatos:49])
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Exam:29=[ADT_Examenes:122]ID:1)
			<>vb_AvoidTriggerExecution:=True:C214
			APPLY TO SELECTION:C70([ADT_Candidatos:49];[ADT_Candidatos:49]Examinador:8:=[ADT_Examenes:122]Responsable:5)
			<>vb_AvoidTriggerExecution:=False:C215
			KRL_UnloadReadOnly (->[ADT_Candidatos:49])
		End if 
	End if 
End if 



