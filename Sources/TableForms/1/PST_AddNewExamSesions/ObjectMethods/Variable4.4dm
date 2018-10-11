AL_UpdateArrays (xALP_sections;0)
AL_UpdateArrays (xALP_Groups;0)
$abort:=False:C215
For ($i;1;Size of array:C274(aiPST_ExamTime))
	If (aiPST_ExamTime{$i}=0)
		$abort:=True:C214
	End if 
End for 
If (($abort=False:C215) & (vdPST_NewSesionDate>!00-00-00!))
	CREATE RECORD:C68([ADT_SesionesDeExamenes:123])
	[ADT_SesionesDeExamenes:123]ID:1:=SQ_SeqNumber (->[ADT_SesionesDeExamenes:123]ID:1)
	[ADT_SesionesDeExamenes:123]Date_Session:2:=vdPST_NewSesionDate
	[ADT_SesionesDeExamenes:123]Place:3:=""
	SAVE RECORD:C53([ADT_SesionesDeExamenes:123])
	KRL_ReloadAsReadOnly (->[ADT_SesionesDeExamenes:123])
	$rnCandidato:=Record number:C243([ADT_Candidatos:49])
	$group:=[ADT_Candidatos:49]Grupo:21
	$selectedExam:=-MAXLONG:K35:2
	For ($i;1;Size of array:C274(atPST_GroupName))
		For ($k;1;ipst_Sections)
			$section:=Char:C90(64+$k)
			$secs:=SYS_DateTime2Secs ([ADT_SesionesDeExamenes:123]Date_Session:2;aiPST_ExamTime{$i})
			$time:=aiPST_ExamTime{$i}
			QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=[ADT_SesionesDeExamenes:123]ID:1;*)
			QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Group:6=atPST_GroupName{$i};*)
			QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Section:7=$section)
			If (Records in selection:C76([ADT_Examenes:122])=0)
				CREATE RECORD:C68([ADT_Examenes:122])
				[ADT_Examenes:122]ID:1:=SQ_SeqNumber (->[ADT_Examenes:122]ID:1)
				[ADT_Examenes:122]ID_Sesion:12:=[ADT_SesionesDeExamenes:123]ID:1
				[ADT_Examenes:122]Group:6:=atPST_GroupName{$i}
				[ADT_Examenes:122]Section:7:=$section
				[ADT_Examenes:122]Date_Exam:2:=[ADT_SesionesDeExamenes:123]Date_Session:2
				[ADT_Examenes:122]Time_Exam:3:=$time
				[ADT_Examenes:122]Secs:8:=SYS_DateTime2Secs ([ADT_Examenes:122]Date_Exam:2;[ADT_Examenes:122]Time_Exam:3)
				SAVE RECORD:C53([ADT_Examenes:122])
				KRL_ReloadAsReadOnly (->[ADT_SesionesDeExamenes:123])
			End if 
			If ((atPST_GroupName{$i}=$group) & ($selectedExam=-MAXLONG:K35:2))
				$selectedExam:=Record number:C243([ADT_Examenes:122])
			End if 
		End for 
	End for 
	READ WRITE:C146([ADT_Candidatos:49])
	READ ONLY:C145([ADT_Examenes:122])
	GOTO RECORD:C242([ADT_Examenes:122];$selectedExam)
	GOTO RECORD:C242([ADT_Candidatos:49];$rnCandidato)
	[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
	SAVE RECORD:C53([ADT_Candidatos:49])
	PST_ReadParameters 
	ACCEPT:C269
Else 
	CD_Dlog (0;__ ("Por favor ingrese la fecha de la sesión de exámenes y la hora de examen para cada grupo."))
End if 
AL_UpdateArrays (xALP_sections;-2)
AL_UpdateArrays (xALP_Groups;-2)