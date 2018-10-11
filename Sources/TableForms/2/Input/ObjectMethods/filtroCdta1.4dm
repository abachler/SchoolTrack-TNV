C_LONGINT:C283($page)
C_TEXT:C284($itemText)
C_REAL:C285($itemRef)
GET LIST ITEM:C378(al_FiltroCdta;*;$itemRef;$itemText)
$page:=Selected list items:C379(vlTab_Conducta)
If ($itemRef>0)
	Case of 
		: ($page=1)
			
		: ($page=2)
			
		: ($page=3)
			AL_CdtaBehaviourFilter ("processListLic";$itemRef;$itemText)
		: ($page=4)
			
		: ($page=5)
			AL_CdtaBehaviourFilter ("processListAnt";$itemRef;$itemText)
		: ($page=6)
			AL_CdtaBehaviourFilter ("processListDtn";$itemRef;$itemText)
		: ($page=7)
			AL_CdtaBehaviourFilter ("processListSpn";$itemRef;$itemText)
	End case 
End if 