//%attributes = {}
  // UD_v20131014_StatusRegistrosMT()
  // Por: Alberto Bachler: 14/10/13, 15:41:38
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


ALL RECORDS:C47([BBL_Registros:66])

ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$al_RecNums;"")
$l_proceso:=IT_Progress (1;0;0;"Normalizando status de registros MediaTrack ...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Registros:66])
	GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{$i_registros})
	$l_indiceStatus:=Find in array:C230(<>aCpyStatus;[BBL_Registros:66]Status:10)
	If ($l_indiceStatus>0)
		[BBL_Registros:66]StatusID:34:=<>aCpyStatusId{$l_indiceStatus}
	End if 
	SAVE RECORD:C53([BBL_Registros:66])
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)
KRL_UnloadReadOnly (->[BBL_Registros:66])

