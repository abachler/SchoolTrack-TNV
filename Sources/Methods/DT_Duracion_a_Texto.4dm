//%attributes = {}
  // DT_Duracion_a_Texto()
  // Por: Alberto Bachler K.: 23-09-15, 11:21:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TIME:C306($1)
C_TEXT:C284($0)

C_LONGINT:C283($l_dias;$l_Horas;$l_horasTotalDias;$l_minutos;$l_segundos)
C_TIME:C306($h_duracion)
C_TEXT:C284($t_duracion)


If (False:C215)
	C_TIME:C306(DT_Duracion_a_Texto ;$1)
	C_TEXT:C284(DT_Duracion_a_Texto ;$0)
End if 


$h_duracion:=$1
If ($h_duracion<0)
	$h_duracion:=$h_duracion*-1
End if 

$t_duracion:=Time string:C180($h_duracion)
$l_Horas:=Num:C11(ST_GetWord ($t_duracion;1;":"))
$l_minutos:=Num:C11(ST_GetWord ($t_duracion;2;":"))
$l_segundos:=Num:C11(ST_GetWord ($t_duracion;3;":"))
If ($l_Horas>24)
	$l_minutos:=Num:C11(ST_GetWord ($t_duracion;2;":"))
	$l_segundos:=Num:C11(ST_GetWord ($t_duracion;3;":"))
	$l_dias:=Int:C8($l_Horas/24)
	$l_horasTotalDias:=$l_dias*24
	$l_Horas:=$l_Horas-$l_horasTotalDias
	$h_duracion:=$h_duracion-($l_horasTotalDias*60*60)
	$t_duracion:=Time string:C180($h_duracion)
	$l_minutos:=Num:C11(ST_GetWord ($t_duracion;2;":"))
	$l_segundos:=Num:C11(ST_GetWord ($t_duracion;3;":"))
	$t_duracion:=String:C10($l_dias)+__ (" día(s), ")+String:C10($l_Horas;"00")+"h "+String:C10($l_minutos;"00")+"m "+String:C10($l_segundos;"00")+"s."
Else 
	Case of 
		: ($l_Horas>0)
			$t_duracion:=String:C10($l_Horas;"00")+"h "+String:C10($l_minutos;"00")+"m "+String:C10($l_segundos;"00")+"s."
		: ($l_minutos>0)
			$t_duracion:=String:C10($l_minutos;"00")+"m "+String:C10($l_segundos;"00")+"s."
		: ($l_segundos>0)
			$t_duracion:=String:C10($l_segundos;"00")+"s."
		Else 
			$t_duracion:="-"
	End case 
End if 
$0:=$t_duracion