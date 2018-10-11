$ref:=Create document:C266("")
If (ok=1)
	$path:=document
	ARRAY TEXT:C222(aHeaders;9)
	AT_Inc (0)
	aHeaders{AT_Inc }:="N° de Día de la Semana(1-7)"
	aHeaders{AT_Inc }:="N° de Bloque de Inicio"
	aHeaders{AT_Inc }:="Cantidad de Bloques de Duración"
	aHeaders{AT_Inc }:="Abreviación de la Asignatura"
	  //aHeaders{AT_Inc }:="Denominación Oficial de la Asignatura"
	aHeaders{AT_Inc }:="Nº del Nivel"
	aHeaders{AT_Inc }:="Curso, Clase o Grupo"
	aHeaders{AT_Inc }:="Set"
	aHeaders{AT_Inc }:="Iniciales del Profesor"
	aHeaders{AT_Inc }:="Sala - Salón - Taller - Laboratorio"
	
	$text:=AT_array2text (->aHeaders;"\t")
	AT_Initialize (->aHeaders)
	IO_SendPacket ($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	  //$msg:="Archivo generado con éxito."+"\r"+"Podrá encontrarlo en "+"\r\r"+$path
	CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
End if 