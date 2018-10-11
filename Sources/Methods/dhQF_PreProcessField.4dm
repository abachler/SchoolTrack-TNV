//%attributes = {}
  // dhQF_PreProcessField()
  // por Adrián Sepulveda 18/01/2013 
  // ---------------------------------------------
  // modificado por Alberto Bachler: 22/02/13, 10:43:40
  // transformado en función que devuelve un valor literal
  // ---------------------------------------------
C_POINTER:C301($1;$y_campo)
C_TEXT:C284($2;$t_valor)
C_TEXT:C284($0)
C_LONGINT:C283($l_indice)

$y_campo:=$1
$t_valor:=$2
Case of 
	: (KRL_isSameField ($y_campo->;->[Personas:7]ACT_modo_de_pago_new:95))
		$l_indice:=Find in array:C230(<>atACT_FormasDePago2D{3};$t_valor)
		If ($l_indice#-1)
			$y_campo->:=->[Personas:7]ACT_id_modo_de_pago:94
			$t_valor:=<>atACT_FormasDePago2D{1}{$l_indice}
		End if 
End case 

$0:=$t_valor
