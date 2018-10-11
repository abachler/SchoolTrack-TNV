If (vsBWR_CurrentModule="AccountTrack")
	GET LIST ITEM:C378(hlTab_STR_personas;Selected list items:C379(hlTab_STR_personas);$ref;$text)
	vlACT_PagePersonas:=$ref
	ACTpp_OnRecordLoad ($ref)
	FORM GOTO PAGE:C247($ref)
Else 
	BEEP:C151
End if 