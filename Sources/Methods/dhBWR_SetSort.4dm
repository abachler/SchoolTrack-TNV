//%attributes = {}
  //dhBWR_SetSort

C_BOOLEAN:C305($trapped;$0)

Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				$sortString:=PREF_fGet (USR_GetUserID ;"OrdenamientoPanel#"+String:C10(vlBWR_SelectedTableRef);"")
				If ($sortString="")
					If (<>gOrdenNta=1)
						AL_SetSort (xALP_Browser;3;4;1)
						$trapped:=True:C214
					End if 
				Else 
					EXECUTE FORMULA:C63($SortString)
					$trapped:=True:C214
				End if 
		End case 
End case 

$0:=$trapped

