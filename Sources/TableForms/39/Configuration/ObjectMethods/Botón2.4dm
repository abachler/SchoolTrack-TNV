If (sElements#0)
	$el:=sElements
Else 
	$el:=Size of array:C274(sElements)+1
End if 
sElements:=0
sValue:=""

If ([xShell_List:39]Form_TableNumber:12=0)
	$tablePointer:=->[xShell_List:39]
Else 
	$tablePointer:=Table:C252([xShell_List:39]Form_TableNumber:12)
End if 
WDW_OpenFormWindow ($tablePointer;[xShell_List:39]Form_Name:6;-1;Movable form dialog box:K39:8;pLists{pLists};"WDW_Closedlog")
DIALOG:C40($tablePointer->;[xShell_List:39]Form_Name:6)
CLOSE WINDOW:C154
AL_UpdateArrays (xALP_Tables;0)
If (ok=1)
	INSERT IN ARRAY:C227(sElements;1)
	sElements{1}:=sValue
	changed:=True:C214
	  //157382
	If ([xShell_List:39]PopupArrayName:3="◊at_EventosAsignatura")
		CFG_ST_BlockEvtAsigNiveles ("new";sValue)
	End if 
End if 
SORT ARRAY:C229(sElements;>)
$el:=Find in array:C230(sElements;sValue)
AL_UpdateArrays (xALP_Tables;-2)
If ($el>0)
	ARRAY INTEGER:C220(aLines;1)
	aLines{1}:=$el
	AL_SetSelect (xALP_Tables;aLines)
Else 
	ARRAY INTEGER:C220(aLines;0)
	AL_SetSelect (xALP_Tables;aLines)
	_O_DISABLE BUTTON:C193(bDel)
	_O_DISABLE BUTTON:C193(bEdit)
	_O_DISABLE BUTTON:C193(bInfos)
End if 


TBL_SetListApparence 