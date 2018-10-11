//%attributes = {}
  //AL_Eximiciones


If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	ARRAY INTEGER:C220(<>aExmNo;0)
	ARRAY DATE:C224(<>aExmDate;0)
	ARRAY TEXT:C222(<>aStdWhNme;0)
	ARRAY TEXT:C222(aPaName;0)
	ARRAY TEXT:C222(<>aStdClass;0)
	ARRAY LONGINT:C221(<>aStdId;0)
	  //MENU BAR(4)
	  //WDW_Open (580;400;0;4;"Registro de eximiciones";"wdwCloseDlog")
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Eximición";0;4;__ ("Registro de eximiciones"))
	DIALOG:C40([xxSTR_Constants:1];"STR_Eximición")
	CLOSE WINDOW:C154
	ARRAY INTEGER:C220(<>aExmNo;0)
	ARRAY DATE:C224(<>aExmDate;0)
	ARRAY TEXT:C222(<>aStdWhNme;0)
	ARRAY TEXT:C222(aPaName;0)
	ARRAY TEXT:C222(<>aStdClass;0)
	ARRAY LONGINT:C221(<>aStdId;0)
End if 