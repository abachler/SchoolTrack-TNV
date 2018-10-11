//%attributes = {}
  // MÉTODO: EV2_Literal_Sistema
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/22/11, 11:53:14
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Usar para convertir un literal aplicación a literal sistema
  // cuando sea necesario convertir un literal a numérico
  // 
  // PARÁMETROS
  // EV2_Literal_Sistema(calificacion: T)
  // -> calificación usando separador decimal configurado en sistema 
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($t_literal;$1;$0)
$t_literal:=$1

  // CODIGO PRINCIPAL
$t_literal:=Replace string:C233($t_literal;",";<>tXS_RS_DecimalSeparator)
$t_literal:=Replace string:C233($t_literal;".";<>tXS_RS_DecimalSeparator)

$0:=$t_literal
