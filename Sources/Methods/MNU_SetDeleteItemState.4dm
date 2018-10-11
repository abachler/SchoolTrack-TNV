//%attributes = {}
C_BOOLEAN:C305($1;$2;$force;$forceTo)
If (Count parameters:C259=2)
	$force:=$1
	$forceTo:=$2
End if 
If ($force)
	MNU_SetMenuItemState ($forceTo;2;18)
Else 
	If (Size of array:C274(aBrSelect)>0)
		If (USR_checkRights ("D";yBWR_currentTable))
			ENABLE MENU ITEM:C149(2;18;Current process:C322)
		Else 
			DISABLE MENU ITEM:C150(2;18;Current process:C322)
		End if 
	Else 
		DISABLE MENU ITEM:C150(2;18;Current process:C322)
	End if 
End if 