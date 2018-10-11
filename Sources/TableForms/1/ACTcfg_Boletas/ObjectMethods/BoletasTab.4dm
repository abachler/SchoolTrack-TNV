  //FORM GOTO PAGE(Selected list items(Self->))

C_LONGINT:C283($vl_ref)
C_TEXT:C284($vt_text)
GET LIST ITEM:C378(hl_ACT_cfgDocTrib;Selected list items:C379(hl_ACT_cfgDocTrib);$vl_ref;$vt_text)

If ($vl_ref=4)
	Case of 
		: (<>gCountryCode="cl")
			
		: (<>gCountryCode="mx")
			$vl_ref:=5
			
		: (<>gCountryCode="ar")  //20150620 RCH
			$vl_ref:=6
			
	End case 
End if 
FORM GOTO PAGE:C247($vl_ref)