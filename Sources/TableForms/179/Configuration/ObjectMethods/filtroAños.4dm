C_LONGINT:C283($page)
C_TEXT:C284($itemText)
C_REAL:C285($itemRef)
GET LIST ITEM:C378(al_FiltroYears;*;$itemRef;$itemText)

If ($itemRef>0)
	PREF_Set (0;"ACT_pref_filtroItems";$itemText)
	
	AL_UpdateArrays (xALP_Items;0)
	ACTitems_CargaLista ($itemText)
	AL_UpdateArrays (xALP_Items;-2)
	
	ACTitems_CargaItemConf 
End if 