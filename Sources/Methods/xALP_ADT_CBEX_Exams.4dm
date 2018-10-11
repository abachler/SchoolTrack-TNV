//%attributes = {}
  //xALP_ADT_CBEX_Exams

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
$0:=True:C214
AL_GetCurrCell (xALP_Exams;$col;$row)
If ($col=5)
	$prof:=Find in array:C230(atADT_Examinadores;asADT_Responsable{$row})
	If ($prof#-1)
		alADT_Responsable_ID{$row}:=alADT_IDFuncEx{$prof}
	End if 
End if 
READ WRITE:C146([ADT_SesionesDeExamenes:123])
QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=aLPST_SesionID{$row})
[ADT_SesionesDeExamenes:123]Place:3:=atADT_Place{$row}
[ADT_SesionesDeExamenes:123]Date_Session:2:=adPst_ExamSesionsDate{$row}
[ADT_SesionesDeExamenes:123]ReservedPG:5:=abADT_ReservedPG{$row}
[ADT_SesionesDeExamenes:123]Responsable:6:=asADT_Responsable{$row}
[ADT_SesionesDeExamenes:123]ID_Responsable:7:=alADT_Responsable_ID{$row}
SAVE RECORD:C53([ADT_SesionesDeExamenes:123])
READ WRITE:C146([ADT_Examenes:122])
QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=[ADT_SesionesDeExamenes:123]ID:1)
FIRST RECORD:C50([ADT_Examenes:122])
While (Not:C34(End selection:C36([ADT_Examenes:122])))
	[ADT_Examenes:122]Date_Exam:2:=[ADT_SesionesDeExamenes:123]Date_Session:2
	[ADT_Examenes:122]Secs:8:=SYS_DateTime2Secs ([ADT_Examenes:122]Date_Exam:2;[ADT_Examenes:122]Time_Exam:3)
	[ADT_Examenes:122]Responsable:5:=[ADT_SesionesDeExamenes:123]Responsable:6
	SAVE RECORD:C53([ADT_Examenes:122])
	NEXT RECORD:C51([ADT_Examenes:122])
End while 
KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])