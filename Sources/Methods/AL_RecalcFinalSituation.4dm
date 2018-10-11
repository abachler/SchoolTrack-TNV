//%attributes = {}
  //AL_RecalcFinalSituation
C_TEXT:C284($taskUUID;$2;$taskProgressMessage;$clientName;$3)
C_REAL:C285($taskProgressRatio)
C_LONGINT:C283($taskStatus)
C_BLOB:C604($xRecNums;$1)
ARRAY LONGINT:C221($aRecNums;0)


If (<>vb_BloquearModifSituacionFinal)
	If (Application type:C494#4D Server:K5:6)
		CD_Dlog (0;"Cualquier acción que afecte la situación académica de los alumnos ha sido bloquea"+"da a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
		OK:=0
	End if 
Else 
	
	
	Case of 
		: (Count parameters:C259=3)
			$xRecNums:=$1
			$taskUUID:=$2
			$clientName:=$3
			
		: (Count parameters:C259=2)
			$xRecNums:=$1
			$taskUUID:=$2
			
		: (Count parameters:C259=1)
			$xRecNums:=$1
			
		: ((Count parameters:C259=0) & (Application type:C494#4D Server:K5:6))
			USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums)
			BLOB_Variables2Blob (->$xRecNums;0;->$aRecNums)
	End case 
	
	
	
	EVS_LoadStyles 
	PERIODOS_Init 
	
	vb_AsignaSituacionFinal:=False:C215
	<>NoBatchProcessor:=True:C214
	$taskProgressRatio:=0
	$taskProgressMessage:="Calculando situación final..."
	BLOB_Blob2Vars (->$xRecNums;0;->$aRecNums)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;$taskProgressMessage)
	For ($i;1;Size of array:C274($aRecNums))
		$taskProgressRatio:=$i/Size of array:C274($aRecNums)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$taskProgressRatio)
		READ WRITE:C146([Alumnos:2])
		GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
		dbu_fEvalStudentSit2 ([Alumnos:2]numero:1)
		If (error=0)
			SAVE RECORD:C53([Alumnos:2])
		Else 
			$i:=Size of array:C274($aRecNums)
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	<>NoBatchProcessor:=False:C215
End if 