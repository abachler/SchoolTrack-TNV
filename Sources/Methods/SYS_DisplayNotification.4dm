//%attributes = {}
  // MÉTODO: SYS_DisplayNotification
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/06/11, 11:06:06
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // SYS_DisplayNotification()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$t_Title;$2;$t_message)
C_LONGINT:C283($l_Seconds;$3)
$t_Title:=$1
$t_message:=$2
$l_Seconds:=5


  // CODIGO PRINCIPAL
If (Count parameters:C259=3)
	$l_seconds:=$3
End if 


$p:=New process:C317("SYS_Notify";32000;"$notification";$t_Title;$t_message;$l_Seconds)