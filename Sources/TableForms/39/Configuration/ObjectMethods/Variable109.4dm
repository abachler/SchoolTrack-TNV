If (pLists>0)
	vText:=""
	If (changed)
		READ WRITE:C146([xShell_List:39])
		  //QUERY([Tables];[Tables]Listname=vListName)
		$arrayPointer:=Get pointer:C304([xShell_List:39]ArrayName1:5)
		COPY ARRAY:C226(sElements;$arrayPointer->)
		BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;$arrayPointer)
		SAVE RECORD:C53([xShell_List:39])
		UNLOAD RECORD:C212([xShell_List:39])
		READ ONLY:C145([xShell_List:39])
	End if 
	AL_UpdateArrays (xALP_Tables;0)
	ARRAY TEXT:C222(sElements;0)
	READ WRITE:C146([xShell_List:39])
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=pLists{pLists})
	sLayout:=[xShell_List:39]Form_Name:6
	$arrayPointer:=Get pointer:C304([xShell_List:39]ArrayName1:5)
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;$arrayPointer)
	COPY ARRAY:C226($arrayPointer->;sElements)
	SORT ARRAY:C229(sElements;>)
	
	vListName:=pLists{pLists}
	Changed:=False:C215
	sElements:=0
	IT_SetButtonState (False:C215;->bDel;->bEdit;->bInfos)
	AL_UpdateArrays (xALP_Tables;-2)
	ARRAY INTEGER:C220(aLines;0)
	AL_SetSelect (xALP_Tables;aLines)
	
	TBL_SetListApparence 
	
Else 
	pLists:=Find in array:C230(pLists;vListName)
End if 