//%attributes = {}
  //UD_v20120809_ActualizaCompoundI

C_LONGINT:C283($p)
ALL RECORDS:C47([BBL_ItemMarcFields:205])
SELECTION TO ARRAY:C260([BBL_ItemMarcFields:205];$al_RecNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"verificando datos...")
For ($i;1;Size of array:C274($al_RecNum))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNum))
	READ WRITE:C146([BBL_ItemMarcFields:205])
	GOTO RECORD:C242([BBL_ItemMarcFields:205];$al_RecNum{$i})
	[BBL_ItemMarcFields:205]CompoundIndex:4:=String:C10([BBL_ItemMarcFields:205]ID_Item:1)+"."+String:C10([BBL_ItemMarcFields:205]FieldRef:2)+"_"+[BBL_ItemMarcFields:205]SubFieldRef:3
	SAVE RECORD:C53([BBL_ItemMarcFields:205])
	READ ONLY:C145([BBL_ItemMarcFields:205])
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])