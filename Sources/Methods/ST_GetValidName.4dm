//%attributes = {}
  //28/05/15 J.V
  //ST_GetValidName
  // Metodo recibe un solo parametro
  // limpia la cadena de los carateres que no se pueden utilizar en windows para la creacion de archivos
  //se valida que solo el cambio sea solo para windows, ya que mac no presenta esta dificultad



C_TEXT:C284($1;$text;$0)

$text:=$1
If (SYS_IsWindows )
	$text:=Replace string:C233($text;"/";"")
	$text:=Replace string:C233($text;":";"")
	$text:=Replace string:C233($text;"?";"")
	$text:=Replace string:C233($text;">";"")
	$text:=Replace string:C233($text;"<";"")
	$text:=Replace string:C233($text;"|";"")
	$text:=Replace string:C233($text;"*";"")
Else 
	$text:=Replace string:C233($text;":";"")
End if 
$0:=ST_ClrWildChars (ST_ClearSpaces (ST_ClearExtraCR ($text)))
