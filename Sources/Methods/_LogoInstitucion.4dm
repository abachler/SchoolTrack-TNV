//%attributes = {}
  //_LogoInstitucion

C_PICTURE:C286($0)
If (Count parameters:C259=1)
	$0:=SR_GetOrganisationLogo ($1)
Else 
	$0:=SR_GetOrganisationLogo 
End if 