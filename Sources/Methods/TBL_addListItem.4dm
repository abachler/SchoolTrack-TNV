//%attributes = {}
  //TBL_addListItem

C_PICTURE:C286($bdl)
C_LONGINT:C283($r)
C_POINTER:C301($2)
_O_C_STRING:C293(80;$0)

$popupArrayPointer:=$1

$el:=Find in array:C230(<>ay_xLSTPopUpPointer;$popupArrayPointer)
If ($el>0)
	$listName:=<>aLists{$el}
	READ WRITE:C146([xShell_List:39])
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
	If ([xShell_List:39]Enriquecible:8)
		sValue:=""
		If ([xShell_List:39]Form_TableNumber:12=0)
			$tablePointer:=->[xShell_List:39]
		Else 
			$tablePointer:=Table:C252([xShell_List:39]Form_TableNumber:12)
		End if 
		WDW_OpenFormWindow ($tablePointer;[xShell_List:39]Form_Name:6;-1;Movable form dialog box:K39:8;pLists{pLists};"WDW_Closedlog")
		DIALOG:C40($tablePointer->;[xShell_List:39]Form_Name:6)
		CLOSE WINDOW:C154
		If (ok=1)
			$arrayPointer:=Get pointer:C304([xShell_List:39]ArrayName1:5)
			  //BLOB_Blob2Vars (->[xShell_List]Contents;0;$arrayPointer)
			If (Find in array:C230($arrayPointer->;sValue)=-1)
				AT_Insert (Size of array:C274($arrayPointer->)+1;1;$arrayPointer)
				$arrayPointer->{Size of array:C274($arrayPointer->)}:=sValue
				SORT ARRAY:C229($arrayPointer->;>)
				BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;$arrayPointer)
				If ([xShell_List:39]PopupArrayName:3#"")
					$popUpPointer:=Get pointer:C304([xShell_List:39]PopupArrayName:3)
					If (Not:C34(Is nil pointer:C315($popUpPointer)))
						IT_HandlePopup ("init";$popUpPointer;"";$arrayPointer;[xShell_List:39]Enriquecible:8)
					End if 
				End if 
				  //SAVE RECORD([xShell_List])
				
				  //20140107 ASM Ticket  128514
				TBL_SaveListAndArrays ($arrayPointer)
				UNLOAD RECORD:C212([xShell_List:39])
			End if 
			$0:=sValue
		End if 
	Else 
		CD_Dlog (0;__ ("Fecha"))
	End if 
Else 
	CD_Dlog (0;__ ("The popup name doesn't match any known List name."))
End if 