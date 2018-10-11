If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 

$ref:=Create document:C266("")
If (ok=1)
	$path:=document
	ARRAY TEXT:C222(aHeaders;27)
	AT_Inc (0)
	aHeaders{AT_Inc }:="Identificador"
	aHeaders{AT_Inc }:="Afecto a Intereses"
	aHeaders{AT_Inc }:="Modo de Pago"
	aHeaders{AT_Inc }:="Día de Cargo"
	aHeaders{AT_Inc }:="Código Mandato PAC"
	aHeaders{AT_Inc }:="ID Banco Cta. Cte."
	aHeaders{AT_Inc }:="Titular Cta. Cte. Nombre"
	aHeaders{AT_Inc }:="Titular Cta. Cte. Apellido Paterno"
	aHeaders{AT_Inc }:="Titular Cta. Cte. Apellido Materno"
	aHeaders{AT_Inc }:="Identificador Nacional Titular Cta. Cte."
	aHeaders{AT_Inc }:="Número Cta. Cte."
	aHeaders{AT_Inc }:="Código Mandato PAT"
	aHeaders{AT_Inc }:="ID Banco Emisor Tarjeta"
	aHeaders{AT_Inc }:="Tipo Tarjeta"
	aHeaders{AT_Inc }:="Titular Tarjeta Nombre"
	aHeaders{AT_Inc }:="Titular Tarjeta Apellido Paterno"
	aHeaders{AT_Inc }:="Titular Tarjeta Apellido Materno"
	aHeaders{AT_Inc }:="Identificador Nacional Titular Tarjeta"
	aHeaders{AT_Inc }:="Número Tarjeta"
	aHeaders{AT_Inc }:="Mes Vencimiento Tarjeta"
	aHeaders{AT_Inc }:="Año Vencimiento Tarjeta"
	aHeaders{AT_Inc }:="Es Tarjeta Internacional"
	aHeaders{AT_Inc }:="Dirección Envío Correpondencia"
	aHeaders{AT_Inc }:="Comuna Envío Correpondencia"
	aHeaders{AT_Inc }:="Código Postal Envío Correspondencia"
	aHeaders{AT_Inc }:="Ciudad Envío Correspondencia"
	aHeaders{AT_Inc }:="Email envío Documento Electrónico"
	$text:=AT_array2text (->aHeaders;"\t")
	AT_Initialize (->aHeaders)
	IO_SendPacket ($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	  //$msg:="Archivo generado con éxito."+"\r"+"Podrá encontrarlo en "+"\r\r"+$path
	  //CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
	
	ACTcd_DlogWithShowOnDisk (document;0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
End if 

USE CHARACTER SET:C205(*;0)