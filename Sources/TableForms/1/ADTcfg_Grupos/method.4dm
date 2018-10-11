ARRAY INTEGER:C220(aiPST_Cupos;iPST_Groups)

  //la cantidad máxima de postulantes es ingresable por el usuario
ARRAY LONGINT:C221(aiPST_maxpostulantes;iPST_Groups)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		xALP_Set_ADT_CFG_Grupos 
		PST_ReadParameters 
		ARRAY TEXT:C222(atPST_OriginalGroupNames;0)
		COPY ARRAY:C226(atPST_GroupName;atPST_OriginalGroupNames)
		For ($i;1;Size of array:C274(atPST_GroupName))
			If ((adPST_FromDate{$i}#!00-00-00!) & (adPST_ToDate{$i}#!00-00-00!))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$result)
				QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Grupo:21=atPST_GroupName{$i};*)
				QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Fecha_de_examen:7#!00-00-00!)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				aiPST_Candidates{$i}:=$result
				aiPST_Cupos{$i}:=aiPST_maxpostulantes{$i}-$result
			End if 
		End for 
		AL_UpdateArrays (xALP_ExaminationsGroups;-2)
		AL_SetLine (xALP_ExaminationsGroups;0)
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
