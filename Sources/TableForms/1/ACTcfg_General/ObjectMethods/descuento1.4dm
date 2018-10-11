IT_Clairvoyance (Self:C308;->atACT_PItemNombreDcto;"";True:C214)
If (Form event:C388=On Data Change:K2:15)
	$vl_pos:=Find in array:C230(atACT_PItemNombreDcto;vtACT_Item)
	If ($vl_pos#-1)
		vlACT_Item:=alACT_PItemIDDcto{$vl_pos}
	Else 
		vtACT_Item:=""
		vlACT_Item:=0
	End if 
End if 