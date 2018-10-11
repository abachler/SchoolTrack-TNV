//%attributes = {}
  //ACTwp_ObtieneFechaDesdeString

C_TEXT:C284($1;$t_fecha)
C_DATE:C307($0)

$t_fecha:=$1

$l_dia:=Num:C11(Substring:C12($t_fecha;1;2))
$l_mes:=Num:C11(Substring:C12($t_fecha;4;2))
$l_year:=Num:C11(Substring:C12($t_fecha;8;4))

$0:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_year)