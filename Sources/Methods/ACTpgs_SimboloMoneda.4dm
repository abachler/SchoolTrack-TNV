//%attributes = {}
  //ACTpgs_SimboloMoneda

C_TEXT:C284($vt_key;$vt_simbolo)
If (<>gCountryCode="")
	STR_ReadGlobals 
End if 
For ($i;1;Size of array:C274(atACT_MonedaCargo))
	$vt_key:=""
	$vt_simbolo:=""
	$vt_key:=<>gCountryCode+"."+atACT_MonedaCargo{$i}
	$vt_simbolo:=KRL_GetTextFieldData (->[xxACT_Monedas:146]Key:10;->$vt_key;->[xxACT_Monedas:146]Simbolo:4)
	If ($vt_simbolo#"")
		  //If (arACT_MontoMoneda{$i}>0)
		atACT_MonedaSimbolo{$i}:=$vt_simbolo+" "+String:C10(arACT_MontoMoneda{$i};"|Real_4DecIfNec")
		  //Else 
		  //atACT_MonedaSimbolo{$i}:=""
		  //End if 
	Else 
		atACT_MonedaSimbolo{$i}:=""
	End if 
End for 