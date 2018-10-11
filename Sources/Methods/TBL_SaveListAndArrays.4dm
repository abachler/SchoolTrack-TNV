//%attributes = {}
  //TBL_SaveListAndArrays

  //TBL_SaveListAndArrays

C_BOOLEAN:C305($b_CopiarArray)
C_POINTER:C301($y_ArrayCopiar;$y_ArrayOriginal)

ARRAY TEXT:C222($at_CopiaOriginal;0)
ARRAY TEXT:C222($at_FinalUnion;0)
ARRAY TEXT:C222($at_Temporal;0)

$y_ArrayOriginal:=$1
$b_CopiarArray:=False:C215

Case of 
	: (Count parameters:C259=2)
		$y_ArrayCopiar:=$2
		$b_CopiarArray:=True:C214
End case 

COPY ARRAY:C226($y_ArrayOriginal->;$at_CopiaOriginal)

While (Semaphore:C143("Lista"+[xShell_List:39]Listname:1))
	DELAY PROCESS:C323(Current process:C322;5)
End while 

KRL_ReloadInReadWriteMode (->[xShell_List:39])
BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_Temporal)
AT_Union (->$at_CopiaOriginal;->$at_Temporal;->$at_FinalUnion)
BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->$at_FinalUnion)
SAVE RECORD:C53([xShell_List:39])

If ($b_CopiarArray)
	COPY ARRAY:C226($at_FinalUnion;$y_ArrayCopiar->)
End if 

CLEAR SEMAPHORE:C144("Lista"+[xShell_List:39]Listname:1)

KRL_UnloadReadOnly (->[xShell_List:39])

KRL_ExecuteEverywhere ("TBL_LoadListsArrays")
