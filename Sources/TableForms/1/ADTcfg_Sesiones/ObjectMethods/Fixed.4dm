$line:=AL_GetLine (xALP_Exams)
If ($line>0)
	START TRANSACTION:C239
	READ WRITE:C146([ADT_SesionesDeExamenes:123])
	QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=aLPST_SesionID{$line})
	$rnSesion:=Record number:C243([ADT_SesionesDeExamenes:123])
	$idSesion:=[ADT_SesionesDeExamenes:123]ID:1
	If ([ADT_SesionesDeExamenes:123]Attendance:4=0)
		READ WRITE:C146([ADT_Examenes:122])
		QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=$idSesion)
		OK:=KRL_DeleteSelection (->[ADT_Examenes:122])
		If (ok=1)
			READ WRITE:C146([ADT_SesionesDeExamenes:123])
			GOTO RECORD:C242([ADT_SesionesDeExamenes:123];$rnSesion)
			If (Not:C34(Locked:C147([ADT_SesionesDeExamenes:123])))
				DELETE RECORD:C58([ADT_SesionesDeExamenes:123])
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("El registro de sesión está en uso por otro usuario o proceso. Por favor intente eliminarlo más tarde."))
			End if 
		Else 
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("Hay registros de exámenes que ha sido imposible eliminar por estar en uso. Intente la eliminación más tarde."))
		End if 
	Else 
		ok:=CD_Dlog (0;__ ("Esta sesión tiene postulantes inscritos. \rSi la elimina deberá re-asignar la fecha de examen a todos ellos.\r¿Desea realmente eliminar esta sesión?");__ ("");__ ("No");__ ("Sí"))
		If (ok=2)
			$date:=[ADT_SesionesDeExamenes:123]Date_Session:2
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Fecha_de_examen:7=$date)
			ARRAY DATE:C224(aDate1;0)
			ARRAY LONGINT:C221(aLong1;0)
			ARRAY LONGINT:C221(aLong2;0)
			ARRAY DATE:C224(aDate1;Records in selection:C76([ADT_Candidatos:49]))
			ARRAY LONGINT:C221(aLong1;Records in selection:C76([ADT_Candidatos:49]))
			ARRAY LONGINT:C221(aLong2;Records in selection:C76([ADT_Candidatos:49]))
			OK:=KRL_Array2Selection (->aLong2;->[ADT_Candidatos:49]ID_Exam:29;->aLong1;->[ADT_Candidatos:49]secs_Exam:24;->aDate1;->[ADT_Candidatos:49]Fecha_de_examen:7;->aLong1;->[ADT_Candidatos:49]Hora_de_examen:19)
			AT_Initialize (->aDate1;->aLong1)
			If (OK=1)
				READ WRITE:C146([ADT_Examenes:122])
				QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=$idSesion)
				OK:=KRL_DeleteSelection (->[ADT_Examenes:122])
				If (ok=1)
					READ WRITE:C146([ADT_SesionesDeExamenes:123])
					GOTO RECORD:C242([ADT_SesionesDeExamenes:123];$rnSesion)
					If (Not:C34(Locked:C147([ADT_SesionesDeExamenes:123])))
						DELETE RECORD:C58([ADT_SesionesDeExamenes:123])
						VALIDATE TRANSACTION:C240
					Else 
						CANCEL TRANSACTION:C241
						CD_Dlog (0;__ ("El registro de sesión está en uso por otro usuario o proceso. Por favor intente eliminarlo más tarde."))
					End if 
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("Hay registros de exámenes que ha sido imposible eliminar por estar en uso. Intente la eliminación más tarde."))
				End if 
			Else 
				CD_Dlog (0;__ ("Hay registros de candidatos en uso a los cuales fue imposible modificarles la fecha y hora del exámen. Intente la eliminación más tarde."))
				CANCEL TRANSACTION:C241
			End if 
		End if 
	End if 
	viPST_NbSesions:=Records in table:C83([ADT_SesionesDeExamenes:123])
	AL_UpdateArrays (xALP_Exams;0)
	ADTcfg_LoadSesionesEX 
	AL_UpdateArrays (xALP_Exams;-2)
	AL_SetLine (xALP_Exams;0)
	_O_DISABLE BUTTON:C193(bDeleteSesion)
End if 