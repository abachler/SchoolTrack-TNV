//%attributes = {}
  //PST_SelectExam

ARRAY LONGINT:C221(IDS_Examen;0)
ARRAY TEXT:C222(atPST_LugarExamen;0)


READ ONLY:C145([ADT_Examenes:122])
QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21)

If (Records in selection:C76([ADT_Examenes:122])>0)
	SELECTION TO ARRAY:C260([ADT_Examenes:122]ID_Sesion:12;aLPST_SelEXmID;[ADT_Examenes:122]Section:7;asPST_SelEXmSections;[ADT_Examenes:122]Girls:9;aiPST_SelEXmGirls;[ADT_Examenes:122]Boys:10;aiPST_SelEXmBoys;[ADT_Examenes:122]Total:11;aiPST_SelEXmTotal;[ADT_Examenes:122]Secs:8;aLPST_SelEXmSecs;[ADT_Examenes:122]Date_Exam:2;adPST_SelEXmDate;[ADT_Examenes:122]Time_Exam:3;aLPST_SelEXmTime;[ADT_Examenes:122]ID:1;IDS_Examen)
	
	For ($i;1;Size of array:C274(aLPST_SelEXmID))
		QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=aLPST_SelEXmID{$i})
		APPEND TO ARRAY:C911(atPST_LugarExamen;[ADT_SesionesDeExamenes:123]Place:3)
	End for 
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"PST_SelectExam";7;Palette form window:K39:9;__ ("Asignación de fecha de exámen"))
	DIALOG:C40([xxSTR_Constants:1];"PST_SelectExam")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;__ ("No hay sesiones de examenes disponibles para el grupo ")+[ADT_Candidatos:49]Grupo:21+__ ("."))
End if 
