$ref:=Create document:C266("")
If (ok=1)
	$path:=document
	ARRAY TEXT:C222(aHeaders;6)
	AT_Inc (0)
	aHeaders{AT_Inc }:="Código de Barras"
	aHeaders{AT_Inc }:="Fecha de Préstamo (Desde)"
	aHeaders{AT_Inc }:="Fecha de Devolución (Hasta)"
	aHeaders{AT_Inc }:="Rut del Lector"
	aHeaders{AT_Inc }:="Dígito Verificador"
	aHeaders{AT_Inc }:="Días de Renovación"
	
	$text:=AT_array2text (->aHeaders;"\t")
	AT_Initialize (->aHeaders)
	IO_SendPacket ($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	  //$msg:="Archivo generado con éxito."+"\r"+"Podrá encontrarlo en "+"\r\r"+$path
	CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
End if 