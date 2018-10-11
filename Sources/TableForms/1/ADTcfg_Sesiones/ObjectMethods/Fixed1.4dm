$actualSize:=Size of array:C274(aLPST_SesionID)

Case of 
	: (Self:C308-><$actualSize)
		$elementsTodelete:=$actualSize-Self:C308->
		OK:=CD_Dlog (0;__ ("Usted disminuyó el numero de sesiones. \rSolo serán eliminadas las sesiones sin aspirantes asignados. \r\r¿Desea realmente eliminar las sesiones sin aspirantes asignados?");__ ("");__ ("Sí");__ ("Cancelar"))
		If (ok=1)
			While (Semaphore:C143("Updating_Exams"))
				DELAY PROCESS:C323(Current process:C322;15)
			End while 
			$HaySesionDisp:=False:C215
			For ($i;$actualSize;1;-1)
				START TRANSACTION:C239
				READ WRITE:C146([ADT_SesionesDeExamenes:123])
				READ WRITE:C146([ADT_Examenes:122])
				QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=aLPST_SesionID{$i})
				If ([ADT_SesionesDeExamenes:123]Attendance:4=0)
					$HaySesionDisp:=True:C214
					QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=[ADT_SesionesDeExamenes:123]ID:1)
					ok:=KRL_DeleteSelection (->[ADT_Examenes:122])
					If (ok=1)
						If (Not:C34(Locked:C147([ADT_SesionesDeExamenes:123])))
							DELETE RECORD:C58([ADT_SesionesDeExamenes:123])
							$elementsTodelete:=$elementsTodelete-1
							If ($elementsTodelete=0)
								$i:=0
							End if 
							VALIDATE TRANSACTION:C240
						Else 
							CANCEL TRANSACTION:C241
						End if 
					Else 
						CANCEL TRANSACTION:C241
					End if 
				Else 
					CANCEL TRANSACTION:C241
				End if 
				KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
				KRL_UnloadReadOnly (->[ADT_Examenes:122])
			End for 
			CLEAR SEMAPHORE:C144("Updating_Exams")
			Case of 
				: (($elementsTodelete#0) & ($HaySesionDisp))
					CD_Dlog (0;__ ("No fue posible eliminar algunas de las sesiones de exámenes porque están en uso."))
				: (Not:C34($HaySesionDisp))
					CD_Dlog (0;__ ("No hay sesiones sin aspirantes asignados para eliminar."))
			End case 
		End if 
	: (Self:C308->>$actualSize)
		$rowsToInsert:=Self:C308->-$actualsize
		$recordsToInsert:=$rowsToInsert*(Size of array:C274(atPST_GroupName)*ipst_Sections)
		For ($i;1;$rowsToInsert)
			CREATE RECORD:C68([ADT_SesionesDeExamenes:123])
			[ADT_SesionesDeExamenes:123]ID:1:=SQ_SeqNumber (->[ADT_SesionesDeExamenes:123]ID:1)
			SAVE RECORD:C53([ADT_SesionesDeExamenes:123])
			For ($j;1;Size of array:C274(atPST_GroupName))
				For ($k;1;ipst_Sections)
					CREATE RECORD:C68([ADT_Examenes:122])
					[ADT_Examenes:122]ID:1:=SQ_SeqNumber (->[ADT_Examenes:122]ID:1)
					[ADT_Examenes:122]ID_Sesion:12:=[ADT_SesionesDeExamenes:123]ID:1
					[ADT_Examenes:122]Group:6:=atPST_GroupName{$j}
					[ADT_Examenes:122]Section:7:=Char:C90(64+$k)
					[ADT_Examenes:122]Date_Exam:2:=[ADT_SesionesDeExamenes:123]Date_Session:2
					[ADT_Examenes:122]Time_Exam:3:=aiPST_ExamTime{$j}
					[ADT_Examenes:122]Secs:8:=SYS_DateTime2Secs ([ADT_Examenes:122]Date_Exam:2;[ADT_Examenes:122]Time_Exam:3)
					SAVE RECORD:C53([ADT_Examenes:122])
				End for 
			End for 
		End for 
		KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
		KRL_UnloadReadOnly (->[ADT_Examenes:122])
End case 
viPST_NbSesions:=Records in table:C83([ADT_SesionesDeExamenes:123])
AL_UpdateArrays (xALP_Exams;0)
ADTcfg_LoadSesionesEX 
AL_UpdateArrays (xALP_Exams;-2)
AL_SetLine (xALP_Exams;0)
_O_DISABLE BUTTON:C193(bDeleteSesion)