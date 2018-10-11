GET LIST ITEM:C378(HLTAB_ACTcc_Asociados;Selected list items:C379(HLTAB_ACTcc_Asociados);$ref;$text)
Case of 
	: ($ref=1)
		OBJECT SET VISIBLE:C603(*;"xALP_ACTcc_Terceros";False:C215)
		OBJECT SET VISIBLE:C603(*;"Variable238";True:C214)
	: ($ref=2)
		OBJECT SET VISIBLE:C603(*;"Variable238";False:C215)
		OBJECT SET VISIBLE:C603(*;"xALP_ACTcc_Terceros";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"xALP_ACTcc_Terceros";False:C215)
		OBJECT SET VISIBLE:C603(*;"Variable238";True:C214)
End case 