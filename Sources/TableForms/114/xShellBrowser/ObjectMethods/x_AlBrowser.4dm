  //REDRAW(xALP_Browser)
Case of 
	: (ALProEvt=AL Sort button event)
		If (Contextual click:C713)
			ARRAY LONGINT:C221(abrSelect;0)
			$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
			If (vtBWR_OnHRClickMethod#"")
				If (API Does Method Exist (vtBWR_OnHRClickMethod)=1)
					KRL_ExecuteMethod (vtBWR_OnHRClickMethod)
				End if 
			End if 
		Else 
			AL_GetSort (Self:C308->;$col)
			$sortString:="AL_SetSort(xALP_Browser;"+String:C10($col)+")"
			PREF_Set (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);$SortString)
		End if 
		BWR_SetSelectionDependantItems 
	: ((ALProEvt=AL Single click event) | (alProEvt=AL Select all event))
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		If (vtBWR_OnClickMethod#"")
			If (API Does Method Exist (vtBWR_OnClickMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnClickMethod)
			End if 
		End if 
		BWR_SetSelectionDependantItems 
	: (ALProEvt=AL Double click event)
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		If (vtBWR_OnDClickMethod#"")
			If (API Does Method Exist (vtBWR_OnDClickMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnDClickMethod)
			End if 
		Else 
			BWR_OpenRecord 
			ALProEvt:=0  //
		End if 
		BWR_SetSelectionDependantItems 
	: ((ALProEvt=AL Null event) & (Menu selected:C152#0))
		
		
	: (ALProEvt=AL Empty Area Single click)  //empty area single click
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		If (vtBWR_OnEClickMethod#"")
			If (API Does Method Exist (vtBWR_OnEClickMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnEClickMethod)
			End if 
		End if 
		BWR_SetSelectionDependantItems 
	: (ALProevt=AL Empty Area Double click)  //empty area double click
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		If (vtBWR_OnEDClickMethod#"")
			If (API Does Method Exist (vtBWR_OnEDClickMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnEDClickMethod)
			End if 
		End if 
		BWR_SetSelectionDependantItems 
	: (ALProEvt=AL Single Control Click)  //right clcik on area with data
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		If (vtBWR_OnRClickMethod#"")
			If (API Does Method Exist (vtBWR_OnRClickMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnRClickMethod)
			End if 
		End if 
		BWR_SetSelectionDependantItems 
	: (ALProEvt=AL Empty Area Control Click)  //right click on empty area
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		If (vtBWR_OnERClickMethod#"")
			If (API Does Method Exist (vtBWR_OnERClickMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnERClickMethod)
			End if 
		End if 
		BWR_SetSelectionDependantItems 
End case 
