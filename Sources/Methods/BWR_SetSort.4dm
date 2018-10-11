//%attributes = {}
  //BWR_SetSort

C_LONGINT:C283($orden1;$orden2;$orden3;$orden4;$orden5;$orden6)

$trapped:=dhBWR_SetSort 
If (Not:C34($trapped))
	  //If (Size of array(alBWR_recordNumber)>0)
	$orderCriteria:=ST_CountWords (vtBWR_sortOrder;1;",")
	Case of 
		: ($ordercriteria>=6)
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$orden4:=Num:C11(ST_GetWord (vtBWR_sortOrder;4;","))
			$orden5:=Num:C11(ST_GetWord (vtBWR_sortOrder;5;","))
			$orden6:=Num:C11(ST_GetWord (vtBWR_sortOrder;6;","))
			$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
			If ($sortString="")
				AL_SetSort (xALP_Browser;$orden1;$orden2;$orden3;$orden4;$orden5;$orden6)
			Else 
				EXECUTE FORMULA:C63($SortString)
			End if 
			
		: ($ordercriteria=5)
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$orden4:=Num:C11(ST_GetWord (vtBWR_sortOrder;4;","))
			$orden5:=Num:C11(ST_GetWord (vtBWR_sortOrder;5;","))
			$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
			If ($sortString="")
				AL_SetSort (xALP_Browser;$orden1;$orden2;$orden3;$orden4;$orden5)
			Else 
				EXECUTE FORMULA:C63($SortString)
			End if 
			
		: ($ordercriteria=4)
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$orden4:=Num:C11(ST_GetWord (vtBWR_sortOrder;4;","))
			$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
			If ($sortString="")
				AL_SetSort (xALP_Browser;$orden1;$orden2;$orden3;$orden4)
			Else 
				EXECUTE FORMULA:C63($SortString)
			End if 
			
		: ($ordercriteria=3)
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
			If ($sortString="")
				AL_SetSort (xALP_Browser;$orden1;$orden2;$orden3)
			Else 
				EXECUTE FORMULA:C63($SortString)
			End if 
			
		: ($ordercriteria=2)
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
			If ($sortString="")
				AL_SetSort (xALP_Browser;$orden1;$orden2)
			Else 
				EXECUTE FORMULA:C63($SortString)
			End if 
			
		: ($ordercriteria=1)
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
			If ($sortString="")
				AL_SetSort (xALP_Browser;$orden1)
			Else 
				EXECUTE FORMULA:C63($SortString)
			End if 
			
	End case 
	  //End if 
End if 