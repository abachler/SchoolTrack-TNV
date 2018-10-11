//%attributes = {}
  //MNU_SetMenuItemState

C_BOOLEAN:C305($1)
C_LONGINT:C283($i)
C_LONGINT:C283(${2})
For ($i;2;Count parameters:C259;2)
	If ($1)
		ENABLE MENU ITEM:C149(${$i};${$i+1};Current process:C322)
	Else 
		DISABLE MENU ITEM:C150(${$i};${$i+1};Current process:C322)
	End if 
End for 