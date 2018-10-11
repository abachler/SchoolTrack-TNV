//%attributes = {}
  //ST_RetornaSiglaDesdeFrase
  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 11-08-10, 12:03:45
  // ----------------------------------------------------
  // Método: ST_RetornaSiglaDesdeFrase
  // Descripción
  // Genera un nombre corto para un archivo. Por ejemplo desde el nombre de una razon social...
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$vt_text;$vt_retorno;$vt_word)
C_LONGINT:C283($vl_words;$i)

$vt_text:=$1
$vt_text:=Replace string:C233($vt_text;"  ";" ")
$vl_words:=ST_CountWords ($vt_text)
For ($i;1;$vl_words)
	$vt_word:=ST_GetWord ($vt_text;$i;" ")
	$vt_retorno:=$vt_retorno+$vt_word[[1]]
End for 

$0:=$vt_retorno