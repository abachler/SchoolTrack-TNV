
READ WRITE:C146([XShell_FatObjects:86])
$recNUM:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;vt_LastFatObjectName)
If ($recNUM>=0)
	GOTO RECORD:C242([XShell_FatObjects:86];$recNUM)
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->at_ref_field_temp;->at_rev_new_value_temp;->ab_confirm_fields_temp;->at_rev_new_value_edit_temp)
	SAVE RECORD:C53([XShell_FatObjects:86])
End if 
KRL_UnloadReadOnly (->[XShell_FatObjects:86])

SN3_ActuaDatos_LoadRev (1;->vt_LastFatObjectName)

LISTBOX SELECT ROW:C912(*;"lb_per_names";1)
