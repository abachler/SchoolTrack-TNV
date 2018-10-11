//%attributes = {}
  //ACTio_LimpiaNumCuenta
  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 12-03-11, 11:15:10
  // ----------------------------------------------------
  // Método: ACTio_LimpiaNumCuenta
  // Descripción
  // Se debe utilizar al exportar numeros de cuenta en archivos de texto
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($vt_numCta;$1;$0)

$vt_numCta:=$1
$vt_numCta:=Replace string:C233($vt_numCta;"-";"")
$vt_numCta:=Replace string:C233($vt_numCta;" ";"")
$vt_numCta:=Replace string:C233($vt_numCta;"\r";"")
$vt_numCta:=Replace string:C233($vt_numCta;"\r\n";"")

$0:=$vt_numCta