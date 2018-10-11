//%attributes = {}
  // Método: TGR_ADT_Candidatos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:55:19
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
				
				If ([ADT_Candidatos:49]Fecha_de_presentación:5=!00-00-00!)
					[ADT_Candidatos:49]secs_Presentación:23:=0
				End if 
				If ([ADT_Candidatos:49]secs_Presentación:23#Old:C35([ADT_Candidatos:49]secs_Presentación:23))
					If ([ADT_Candidatos:49]secs_Presentación:23=0)
						[ADT_Candidatos:49]Fecha_de_presentación:5:=!00-00-00!
						[ADT_Candidatos:49]Hora_de_presentación:18:=?00:00:00?
					End if 
				End if 
				
				READ ONLY:C145([Alumnos:2])
				If ([ADT_Candidatos:49]ID_Exam:29#Old:C35([ADT_Candidatos:49]ID_Exam:29))
					
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
					$oldExamID:=Old:C35([ADT_Candidatos:49]ID_Exam:29)
					If ([ADT_Candidatos:49]ID_Exam:29=0)
						[ADT_Candidatos:49]secs_Exam:24:=0
						[ADT_Candidatos:49]Hora_de_examen:19:=?00:00:00?
						[ADT_Candidatos:49]ID_Exam:29:=0
						[ADT_Candidatos:49]ID_Sesión:28:=0
						[ADT_Candidatos:49]Sección:26:=[ADT_Examenes:122]Section:7
						[ADT_Candidatos:49]Examinador:8:=[ADT_Examenes:122]Responsable:5
					End if 
					
					
					If ($oldExamID#0)
						READ WRITE:C146([ADT_Examenes:122])
						QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID:1=$oldExamID)
						While (Locked:C147([ADT_Examenes:122]))
							DELAY PROCESS:C323(Current process:C322;10)
							LOAD RECORD:C52([ADT_Examenes:122])
						End while 
						If ([Alumnos:2]Sexo:49#"")
							[ADT_Examenes:122]Boys:10:=[ADT_Examenes:122]Boys:10-(Num:C11([Alumnos:2]Sexo:49="M"))
							[ADT_Examenes:122]Girls:9:=[ADT_Examenes:122]Girls:9-(Num:C11([Alumnos:2]Sexo:49="F"))
						End if 
						SAVE RECORD:C53([ADT_Examenes:122])
					End if 
					UNLOAD RECORD:C212([ADT_Examenes:122])
					
					If ([ADT_Candidatos:49]ID_Exam:29#0)
						QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
						READ WRITE:C146([ADT_Examenes:122])
						QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID:1=[ADT_Candidatos:49]ID_Exam:29)
						While (Locked:C147([ADT_Examenes:122]))
							DELAY PROCESS:C323(Current process:C322;10)
							LOAD RECORD:C52([ADT_Examenes:122])
						End while 
						[ADT_Candidatos:49]ID_Sesión:28:=[ADT_Examenes:122]ID_Sesion:12
						[ADT_Candidatos:49]secs_Exam:24:=[ADT_Examenes:122]Secs:8
						[ADT_Candidatos:49]Fecha_de_examen:7:=[ADT_Examenes:122]Date_Exam:2
						[ADT_Candidatos:49]Hora_de_examen:19:=[ADT_Examenes:122]Time_Exam:3
						[ADT_Candidatos:49]Sección:26:=[ADT_Examenes:122]Section:7
						[ADT_Candidatos:49]Grupo:21:=[ADT_Examenes:122]Group:6
						[ADT_Candidatos:49]Examinador:8:=[ADT_Examenes:122]Responsable:5
						[ADT_Examenes:122]Boys:10:=[ADT_Examenes:122]Boys:10+(Num:C11([Alumnos:2]Sexo:49="M"))
						[ADT_Examenes:122]Girls:9:=[ADT_Examenes:122]Girls:9+(Num:C11([Alumnos:2]Sexo:49="F"))
						SAVE RECORD:C53([ADT_Examenes:122])
						UNLOAD RECORD:C212([ADT_Examenes:122])
					End if 
				End if 
				
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
				[ADT_Candidatos:49]Familia_numero:30:=[Alumnos:2]Familia_Número:24
				[ADT_Candidatos:49]RUT:46:=[Alumnos:2]RUT:5
				  //UNLOAD RECORD([Alumnos]) basta con dejar la tabla de alumnos en read only para que el registro no quede tomado
				
				If ([ADT_Candidatos:49]Familia_numero:30#Old:C35([ADT_Candidatos:49]Familia_numero:30))
					READ WRITE:C146([ADT_Entrevistas:121])
					QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=Old:C35([ADT_Candidatos:49]Familia_numero:30))
					[ADT_Entrevistas:121]ID_familia:5:=0
					SAVE RECORD:C53([ADT_Entrevistas:121])
					KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
					  //READ ONLY([Familia])
					  //QUERY([Familia];[Familia]Numero=[ADT_Candidatos]Familia_numero)
					  //If (Not([Familia]Es_Postulante))
					  //[ADT_Candidatos]Fecha_de_Entrevista:=!00-00-00!
					  //[ADT_Candidatos]Hora_de_entrevista:=?00:00:00?
					  //[ADT_Candidatos]Entrevistador:=""
					  //[ADT_Candidatos]secs_Presentación:=0
					  //[ADT_Candidatos]Fecha_de_presentación:=!00-00-00!
					  //[ADT_Candidatos]Hora_de_presentación:=?00:00:00?
					  //End if 
				Else 
					  //READ ONLY([Familia])
					  //QUERY([Familia];[Familia]Numero=[ADT_Candidatos]Familia_numero)
					  //If (Not([Familia]Es_Postulante))
					  //[ADT_Candidatos]Fecha_de_Entrevista:=!00-00-00!
					  //[ADT_Candidatos]Hora_de_entrevista:=?00:00:00?
					  //[ADT_Candidatos]Entrevistador:=""
					  //[ADT_Candidatos]secs_Presentación:=0
					  //[ADT_Candidatos]Fecha_de_presentación:=!00-00-00!
					  //[ADT_Candidatos]Hora_de_presentación:=?00:00:00?
					  //End if 
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ WRITE:C146([ADT_Examenes:122])
				QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID:1=[ADT_Candidatos:49]ID_Exam:29)
				While (Locked:C147([ADT_Examenes:122]))
					DELAY PROCESS:C323(Current process:C322;10)
					LOAD RECORD:C52([ADT_Examenes:122])
				End while 
				[ADT_Examenes:122]Boys:10:=[ADT_Examenes:122]Boys:10-(Num:C11([Alumnos:2]Sexo:49="M"))
				[ADT_Examenes:122]Girls:9:=[ADT_Examenes:122]Girls:9-(Num:C11([Alumnos:2]Sexo:49="F"))
				SAVE RECORD:C53([ADT_Examenes:122])
				KRL_UnloadReadOnly (->[ADT_Examenes:122])
				
				READ WRITE:C146([xxADT_MetaDataValues:80])
				QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Candidato:4=[ADT_Candidatos:49]Candidato_numero:1)
				DELETE SELECTION:C66([xxADT_MetaDataValues:80])
				KRL_UnloadReadOnly (->[xxADT_MetaDataValues:80])
		End case 
	End if 
End if 