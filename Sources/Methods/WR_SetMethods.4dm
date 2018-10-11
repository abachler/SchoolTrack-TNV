//%attributes = {}
  //WR_SetMethods

$trapped:=False:C215
$trapped:=dhWR_SetMethods 
If (Not:C34($trapped))
	Case of 
		: (vsBWR_CurrentModule="SchoolTrack")
			ARRAY TEXT:C222($aMethodNames;0)
			ARRAY LONGINT:C221($aMethodIds;0)
			4D_GetMethodList (->$aMethodNames;->$aMethodIds)
			$aMethodNames{0}:="_WRST_"
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$aMethodNames;">>";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO LIST:C376(hl_Methods;$aMethodNames{$DA_Return{$i}};$DA_Return{$i})
			End for 
		: (vsBWR_CurrentModule="AccountTrack")
			ARRAY TEXT:C222($aMethodNames;0)
			ARRAY LONGINT:C221($aMethodIds;0)
			4D_GetMethodList (->$aMethodNames;->$aMethodIds)
			$aMethodNames{0}:="_WRACT_"
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$aMethodNames;">>";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO LIST:C376(hl_Methods;$aMethodNames{$DA_Return{$i}};$DA_Return{$i})
			End for 
	End case 
End if 