//%attributes = {}
  //ACT_DivisaPais

ARRAY TEXT:C222($atACT_codPais;0)
ARRAY TEXT:C222($atACT_moneda;0)
ARRAY TEXT:C222($atACT_simbolo;0)

ACTinit_CreateMonedas ("LlenaCodPais";->$atACT_codPais)
ACTinit_CreateMonedas ("LlenaNombreMoneda";->$atACT_moneda)
ACTinit_CreateMonedas ("LlenaSimbolo";->$atACT_simbolo)

$vl_existe:=Find in array:C230($atACT_codPais;<>gCountryCode)
If ($vl_existe>0)
	$0:=$atACT_moneda{$vl_existe}+";"+$atACT_simbolo{$vl_existe}
Else 
	$0:="Peso Chileno;$"
End if 
