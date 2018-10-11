//%attributes = {}
  // MÉTODO: EV2_Literal_Aplicacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/22/11, 11:20:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Usar para convertir un literal sistema(usando separador decimal sistema)
  // a literal aplicacion(generalmente solo para representación visual)
  //
  // PARÁMETROS
  // EV2_Literal_Aplicacion(calificacion: T)
  // -> calificación usando separador decimal definido en la aplicación
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($t_literal;$1;$0)
$t_literal:=$1

  // CODIGO PRINCIPAL
$t_literal:=Replace string:C233($t_literal;",";<>vs_AppDecimalSeparator)
$t_literal:=Replace string:C233($t_literal;".";<>vs_AppDecimalSeparator)

$0:=$t_literal
