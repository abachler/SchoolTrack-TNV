//%attributes = {}
  // DT_Milisegundos_a_texto()
  // Por: Alberto Bachler K.: 30-08-14, 11:18:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_LONGINT:C283($l_hora;$l_milisegundos;$l_minutos;$l_restoHora;$l_restoMinutos;$l_segundos)
C_POINTER:C301($y_horaLong;$y_horasLong;$y_horaTexto;$y_minutosLong;$y_segundosLong)
C_TEXT:C284($t_duracion)
C_TIME:C306($h_duracion)


If (False:C215)
	C_TEXT:C284(DT_Milisegundos_a_texto ;$0)
	C_LONGINT:C283(DT_Milisegundos_a_texto ;$1)
	C_POINTER:C301(DT_Milisegundos_a_texto ;$2)
End if 

$l_milisegundos:=$1
If (Count parameters:C259=2)
	$y_duracion_Hora:=$2
	$h_duracion:=$l_milisegundos/1000
	$y_duracion_Hora->:=$h_duracion
End if 

$l_hora:=Int:C8($l_milisegundos/3600000)
$l_restoHora:=$l_milisegundos%3600000

$l_minutos:=Int:C8($l_restoHora/60000)
$l_restoMinutos:=$l_restoHora%60000

If ($l_restoMinutos>0)
	$l_segundos:=Round:C94($l_restoMinutos/1000;0)
Else 
	$l_segundos:=$l_milisegundos/1000
End if 


Case of 
	: ($l_milisegundos=0)
		$t_duracion:="< 0ms"
		
	: ($l_hora>0)
		$t_duracion:=String:C10($l_hora)+"h "+String:C10($l_minutos)+"m "+String:C10($l_segundos)+"s"
		
	: ($l_minutos>0)
		$t_duracion:=String:C10($l_minutos)+"m "+String:C10($l_segundos)+"s"
		
	: ($l_segundos>0)
		$t_duracion:=String:C10($l_segundos)+"s"
		
	: ($l_milisegundos<1000)
		$t_duracion:=String:C10($l_milisegundos)+"ms"
		
End case 



$0:=$t_duracion