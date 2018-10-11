//%attributes = {}
$trapped:=dhBWR_SetInterfaceObjects 
If (Not:C34($trapped))
	IT_SetButtonState (USR_checkRights ("A";yBWR_CurrentTable);->bBWR_AddRecord)
	IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_ExcludeSelection)
	IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_SubSelection)
	MNU_SetMenuItemState ((Size of array:C274(abrSelect)>0);2;16)
	MNU_SetMenuItemState ((Size of array:C274(abrSelect)>0);1;2)
End if 