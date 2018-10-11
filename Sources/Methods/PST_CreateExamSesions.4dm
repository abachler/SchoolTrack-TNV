//%attributes = {}
  //PST_CreateExamSesions

C_TIME:C306($TIME)
ALL RECORDS:C47([ADT_SesionesDeExamenes:123])
$sesions:=Records in table:C83([ADT_SesionesDeExamenes:123])
If (viPST_NbSesions>$sesions)
	For ($i;1;viPST_NbSesions-$sesions)
		CREATE RECORD:C68([ADT_SesionesDeExamenes:123])
		[ADT_SesionesDeExamenes:123]ID:1:=SQ_SeqNumber (->[ADT_SesionesDeExamenes:123]ID:1)
		SAVE RECORD:C53([ADT_SesionesDeExamenes:123])
	End for 
End if 

ALL RECORDS:C47([ADT_SesionesDeExamenes:123])
$sesions:=Records in table:C83([ADT_SesionesDeExamenes:123])
If (($sesions>0) & (Size of array:C274(atPST_GroupName)>0) & (iPST_sections>0))
	For ($j;1;$sesions)
		GOTO SELECTED RECORD:C245([ADT_SesionesDeExamenes:123];$j)
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
					[ADT_Examenes:122]Section:7:=Char:C90(64+$k)
					[ADT_Examenes:122]Date_Exam:2:=[ADT_SesionesDeExamenes:123]Date_Session:2
					[ADT_Examenes:122]Time_Exam:3:=$time
					[ADT_Examenes:122]Secs:8:=SYS_DateTime2Secs ([ADT_Examenes:122]Date_Exam:2;[ADT_Examenes:122]Time_Exam:3)
				End if 
				SAVE RECORD:C53([ADT_Examenes:122])
			End for 
		End for 
	End for 
End if 