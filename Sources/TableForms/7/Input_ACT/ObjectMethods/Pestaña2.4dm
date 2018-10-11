GET LIST ITEM:C378(HLTAB_ACTpp_Asociados;Selected list items:C379(HLTAB_ACTpp_Asociados);$ref;$text)

Case of 
	: ($ref=1)
		OBJECT SET VISIBLE:C603(*;"Área de plug-in2";False:C215)
		OBJECT SET VISIBLE:C603(*;"Área de plug-in1";True:C214)
	: ($ref=2)
		OBJECT SET VISIBLE:C603(*;"Área de plug-in1";False:C215)
		OBJECT SET VISIBLE:C603(*;"Área de plug-in2";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"Área de plug-in2";False:C215)
		OBJECT SET VISIBLE:C603(*;"Área de plug-in1";True:C214)
End case 