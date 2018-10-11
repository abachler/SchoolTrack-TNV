AL_UpdateArrays (xALP_Tables;0)
TBL_ClearValue 

SORT ARRAY:C229(sElements;>)
$el:=Find in array:C230(sElements;auxVal)
AL_UpdateArrays (xALP_Tables;Size of array:C274(sElements))
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