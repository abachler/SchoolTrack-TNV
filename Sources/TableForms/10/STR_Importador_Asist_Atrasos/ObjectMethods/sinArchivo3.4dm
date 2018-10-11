$ref:=Create document:C266("")
If (ok=1)
	$path:=document
	ARRAY TEXT:C222(aHeaders;14)
	AT_Inc (0)
	aHeaders{AT_Inc }:="Identificador"
	aHeaders{AT_Inc }:="Fecha"
	aHeaders{AT_Inc }:="Hora de llegada"
	
	$text:=AT_array2text (->aHeaders;"\t")
	AT_Initialize (->aHeaders)
	IO_SendPacket ($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	  //$msg:="Archivo generado con éxito."+"\r"+"Podrá encontrarlo en "+"\r\r"+$path
	CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
End if 