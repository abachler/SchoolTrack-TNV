//%attributes = {}
  //xALP_ADT_CBEX_ExamsGroups

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
$0:=True:C214
AL_GetCurrCell (xALP_ExaminationsGroups;$col;$row)
If (AL_GetCellMod (xALP_ExaminationsGroups)=1)
	Case of 
		: ($col=2)
			READ WRITE:C146([ADT_Examenes:122])
			QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=atPST_GroupName{0})
			APPLY TO SELECTION:C70([ADT_Examenes:122];[ADT_Examenes:122]Group:6:=atPST_GroupName{$row})
			KRL_UnloadReadOnly (->[ADT_Examenes:122])
		: ($col=3)
			If (adPST_FromDate{$row}>adPST_ToDate{$row})
				CD_Dlog (0;__ ("La fecha inicial no puede ser posterior a la fecha final."))
				adPST_FromDate{$row}:=!00-00-00!
			End if 
		: ($col=4)
			If (adPST_ToDate{$row}<adPST_FromDate{$row})
				CD_Dlog (0;__ ("La fecha final no puede ser anterior a la fecha inicial."))
				adPST_ToDate{$row}:=!00-00-00!
			End if 
		: ($col=5)
			aiPST_Cupos{$row}:=aiPST_maxpostulantes{$row}-aiPST_Candidates{$row}
			
		: ($col=8)
			READ WRITE:C146([ADT_Examenes:122])
			QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=atPST_GroupName{$row})
			APPLY TO SELECTION:C70([ADT_Examenes:122];[ADT_Examenes:122]Time_Exam:3:=aiPST_ExamTime{$row})
			KRL_UnloadReadOnly (->[ADT_Examenes:122])
	End case 
End if 