//%attributes = {}
  //LOC_GetNacionalidad

If (Count parameters:C259=1)
	$codPais:=$1
Else 
	$codPais:=<>vtXS_CountryCode
End if 

Case of 
	: ($codPais="cl")
		$0:="Chilena"
	: ($codPais="ar")
		$0:="Argentina"
	: ($codPais="co")
		$0:="Colombiana"
	: ($codPais="pe")
		$0:="Peruana"
	: ($codPais="mx")
		$0:="Mexicana"
	: ($codPais="ve")
		$0:="Venezolana"
	Else 
		$0:=""
End case 