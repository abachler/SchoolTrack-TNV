$text:=AT_array2text (->at_IDNacional_NamesCtas)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
	ACTpgs_ClearDlogVars 
	  //CANCEL TRANSACTION
	GOTO OBJECT:C206(vsACT_RUTCta)
	vlACT_IdentificadorCta:=$choice
	vs_IdentificadorCta:=at_IDNacional_NamesCtas{$choice}
	If ($choice=3)
		OBJECT SET FORMAT:C236(vsACT_RUTCta;"###.###.###-#")
	Else 
		OBJECT SET FORMAT:C236(vsACT_RUTCta;"")
	End if 
End if 