//%attributes = {}
  // DTS_GMT_TimeOffset()
  // Por: Alberto Bachler K.: 22-12-13, 19:24:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_DATE:C307($d_fechaLocal)
C_LONGINT:C283($l_desfaseHorario;$l_horaGMT;$l_horaLocal)
C_TIME:C306($h_horaLocal)

If (False:C215)
	C_LONGINT:C283(DTS_GMT_TimeOffset ;$0)
End if 

$d_fechaLocal:=Current date:C33(*)
$h_horaLocal:=?00:00:00?

$l_horaLocal:=0

$t_FechaHoraGMT:=String:C10($d_fechaLocal;ISO date GMT:K1:10;$h_horaLocal)
$t_fechaGMT:=ST_GetWord ($t_FechaHoraGMT;1;"T")
$t_horaGMT:=ST_GetWord ($t_FechaHoraGMT;2;"T")
$l_horaGMT:=Num:C11(ST_GetWord (String:C10($t_horaGMT);1;":"))

$l_año:=Num:C11(ST_GetWord ($t_fechaGMT;1;"-"))
$l_mes:=Num:C11(ST_GetWord ($t_fechaGMT;2;"-"))
$l_dia:=Num:C11(ST_GetWord ($t_fechaGMT;3;"-"))
$d_FechaGMT:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
Case of 
	: ($d_fechaLocal=$d_FechaGMT)
		$l_desfaseHorario:=$l_horaLocal-$l_horaGMT
	: ($d_fechaLocal>$d_FechaGMT)
		$l_desfaseHorario:=24-$l_horaGMT
End case 

$0:=$l_desfaseHorario*60*60

