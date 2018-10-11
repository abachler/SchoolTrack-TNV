//%attributes = {}
  // LB_FijaColorAlterno()
  //
  //
  // creado por: Alberto Bachler Klein: 06-06-16, 11:09:01
  // -----------------------------------------------------------
C_LONGINT:C283($l_alterno;$l_fondo;$l_primerPlano)
C_TEXT:C284($t_nombreListBox)

$t_nombreListBox:=$1


OBJECT GET RGB COLORS:C1074(*;$t_nombreListBox;$l_primerPlano;$l_fondo;$l_alterno)

$l_alterno:=(243 << 16)+(246 << 8)+250
OBJECT SET RGB COLORS:C628(*;$t_nombreListBox;$l_primerPlano;$l_fondo;$l_alterno)