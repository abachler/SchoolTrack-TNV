//%attributes = {}
  //UD_v20131024_ACT_ActNomCopTerce

C_LONGINT:C283($l_indice)
ARRAY LONGINT:C221($alACT_recNums;0)

READ ONLY:C145([ACT_Terceros:138])

ALL RECORDS:C47([ACT_Terceros:138])

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando nombre completo de terceros...")
LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$alACT_recNums;"")
For ($l_indice;1;Size of array:C274($alACT_recNums))
	READ WRITE:C146([ACT_Terceros:138])
	GOTO RECORD:C242([ACT_Terceros:138];$alACT_recNums{$l_indice})
	ACTter_ActualizaNombreCompleto 
	SAVE RECORD:C53([ACT_Terceros:138])
	KRL_UnloadReadOnly (->[ACT_Terceros:138])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274($alACT_recNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)