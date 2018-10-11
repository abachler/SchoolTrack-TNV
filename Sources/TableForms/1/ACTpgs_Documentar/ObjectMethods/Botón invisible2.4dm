$text:=AT_array2text (->at_IDNacional_NamesApdos)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
	ACTpgs_ClearDlogVars 
	  //CANCEL TRANSACTION
	GOTO OBJECT:C206(vsACT_RUTApoderado)
	vlACT_IdentificadorApdo:=$choice
	vs_Identificador:=at_IDNacional_NamesApdos{$choice}
	If ($choice=3)
		OBJECT SET FORMAT:C236(vsACT_RUTApoderado;"###.###.###-#")
	Else 
		OBJECT SET FORMAT:C236(vsACT_RUTApoderado;"")
	End if 
End if 