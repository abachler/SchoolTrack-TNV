$CurrentPage:=FORM Get current page:C276
$Titular:=vsACT_Titular
$RUTTitular:=vsACT_RUT
Case of 
	: ($CurrentPage=2)
		
	: ($CurrentPage=3)
		vACT_Titular:=$Titular
		vACT_RUTTitular:=$RUTTitular
	: ($CurrentPage=4)
		vtACT_TCTitular:=$Titular
		vtACT_TCRUTTitular:=$RUTTitular
	: ($CurrentPage=5)
		vtACT_LTitular:=$Titular
		vtACT_LRUTTitular:=$RUTTitular
End case 