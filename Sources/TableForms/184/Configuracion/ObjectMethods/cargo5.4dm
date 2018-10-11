IT_Clairvoyance (Self:C308;->atACT_PItemNombreCargo;"";True:C214)
If (Form event:C388=On Data Change:K2:15)
	$vl_pos:=Find in array:C230(atACT_PItemNombreCargo;vtACT_ItemCargo)
	If ($vl_pos#-1)
		vlACT_ItemCargo:=alACT_PItemIDCargo{$vl_pos}
	Else 
		vtACT_ItemCargo:=""
		vlACT_ItemCargo:=0
	End if 
End if 
