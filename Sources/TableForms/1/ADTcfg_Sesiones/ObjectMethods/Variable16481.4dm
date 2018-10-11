$noTime:=False:C215
For ($j;1;Size of array:C274(atPST_GroupName))
	If (aiPST_ExamTime{$j}=0)
		$noTime:=True:C214
		$j:=Size of array:C274(atPST_GroupName)+1
	End if 
End for 
If (Not:C34($noTime))
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
	KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
	KRL_UnloadReadOnly (->[ADT_Examenes:122])
	AL_UpdateArrays (xALP_Exams;0)
	ADTcfg_LoadSesionesEX 
	AL_UpdateArrays (xALP_Exams;-2)
	AL_SetLine (xALP_Exams;0)
	_O_DISABLE BUTTON:C193(bDeleteSesion)
Else 
	CD_Dlog (0;__ ("Antes de poder crear sesiones de exámenes debe configurar las horas de los exámenes para cada grupo en Configuración/Grupos Etarios: Definiciones."))
End if 