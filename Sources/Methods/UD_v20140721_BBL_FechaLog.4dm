//%attributes = {}
  //UD_v20140721_BBL_FechaLog

READ WRITE:C146([xxBBL_Logs:41])
ALL RECORDS:C47([xxBBL_Logs:41])

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando fechas de log de MT...")
While (Not:C34(End selection:C36([xxBBL_Logs:41])))
	[xxBBL_Logs:41]Date_log:1:=[xxBBL_Logs:41]Date_log:1
	SAVE RECORD:C53([xxBBL_Logs:41])
	NEXT RECORD:C51([xxBBL_Logs:41])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxBBL_Logs:41])/Records in selection:C76([xxBBL_Logs:41]))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

KRL_UnloadReadOnly (->[xxBBL_Logs:41])