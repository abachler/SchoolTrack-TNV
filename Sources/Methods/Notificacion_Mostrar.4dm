//%attributes = {}
  // Notificacion_Mostrar()
  // Por: Alberto Bachler: 22/10/13, 11:19:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_segundos)
C_TEXT:C284($t_mensaje;$t_titulo)


$t_titulo:=$1
$t_mensaje:=$2


DISPLAY NOTIFICATION:C910($t_titulo;$t_mensaje;10)

