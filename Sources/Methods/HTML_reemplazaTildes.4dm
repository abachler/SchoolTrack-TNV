//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 26-05-16, 17:22:33
  // ----------------------------------------------------
  // Método: HTML_reemplazaTildes
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($texto)
$texto:=$1

$texto:=Replace string:C233($texto;"";"&nbsp;")
$texto:=Replace string:C233($texto;"á";"&aacute;";*)
$texto:=Replace string:C233($texto;"é";"&eacute;";*)
$texto:=Replace string:C233($texto;"í";"&iacute;";*)
$texto:=Replace string:C233($texto;"ó";"&oacute;";*)
$texto:=Replace string:C233($texto;"ú";"&uacute;";*)
$texto:=Replace string:C233($texto;"ñ";"&ntilde;";*)

$0:=$texto