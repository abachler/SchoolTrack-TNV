//%attributes = {}
  //ACTcfg_Listas

READ WRITE:C146([xShell_List:39])
QUERY:C277([xShell_List:39];[xShell_List:39]Module:4="AccountTrack";*)
QUERY:C277([xShell_List:39]; | [xShell_List:39]Module:4="All")
ARRAY TEXT:C222(pLists;0)
SELECTION TO ARRAY:C260([xShell_List:39]Listname:1;pLists)
SORT ARRAY:C229(pLists)
C_BOOLEAN:C305(changed)
changed:=False:C215
pLists:=1
If (Size of array:C274(pLists)>0)
	vListName:=pLists{1}
	ARRAY TEXT:C222(sElements;0)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=vListName)
	sLayout:=[xShell_List:39]Form_Name:6
	listPtr:=Get pointer:C304([xShell_List:39]ArrayName1:5)
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->sElements)
	SORT ARRAY:C229(sElements;>)
	
	sElements:=0
	IT_SetButtonState (False:C215;->bDel;->bEdit;->bInfos)
	AL_RemoveArrays (xALP_Tables;1;1)
	$err:=AL_SetArraysNam (xALP_Tables;1;1;"sElements")
	AL_SetStyle (xALP_Tables;1;"Tahoma";9;0)
	AL_SetRowOpts (xALP_Tables;1;1;0;0;0)
	AL_SetSortOpts (xALP_Tables;0;0;0;"";0)
	AL_SetMiscOpts (xALP_Tables;1;0;"'";0)
	ARRAY INTEGER:C220(aLines;0)
	AL_SetSelect (xALP_Tables;aLines)
	
	ARRAY TEXT:C222(at_g1;0)
	AT_Text2Array (->at_g1;[xShell_List:39]DefaultValues:10;"\r")
	If (Size of array:C274(at_g1)>0)
		For ($i;1;Size of array:C274(at_g1))
			$pos:=Find in array:C230(sElements;at_g1{$i})
			If ($pos>0)
				AL_SetRowStyle (xALP_Tables;$pos;2)
			End if 
		End for 
	End if 
End if 