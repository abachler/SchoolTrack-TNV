BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
PREF_SetBlob (0;"ACT_IPC "+String:C10(vl_LastYear);xBlob)
AL_UpdateArrays (xALP_IPC;0)

vl_LastYear:=Self:C308->{Self:C308->}
xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10(vl_LastYear);xBlob)
If (BLOB size:C605(xBlob)>0)
	BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
	For ($i;1;12)
		aiACT_YearIPC{$i}:=vl_LastYear
	End for 
Else 
	  //$currentyear:=Year of(Current date(*))
	$currentyear:=vl_LastYear
	ARRAY TEXT:C222(atACT_MesIPC;0)
	COPY ARRAY:C226(<>atXS_MonthNames;atACT_MesIPC)
	ARRAY INTEGER:C220(aiACT_YearIPC;0)
	ARRAY REAL:C219(arACT_VariacionIPC;0)
	ARRAY INTEGER:C220(aiACT_YearIPC;12)
	ARRAY TEXT:C222(atACT_MesIPC;12)
	ARRAY REAL:C219(arACT_VariacionIPC;12)
	For ($i;1;12)
		aiACT_YearIPC{$i}:=$currentyear
	End for 
	BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
	PREF_SetBlob (0;"ACT_IPC "+String:C10($currentyear);xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 
  //IT_SetButtonState ((alACT_IPCYEars{alACT_IPCYEars}=Year of(Current date(*)));->bMantenerSincro)
AL_SetEnterable (xALP_IPC;2;1)
AL_UpdateArrays (xALP_IPC;-2)