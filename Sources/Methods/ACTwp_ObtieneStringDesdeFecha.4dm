//%attributes = {}
  //ACTwp_ObtieneStringDesdeFecha



C_DATE:C307($1;$d_fecha)
C_TEXT:C284($0;$t_string)

$d_fecha:=$1
$t_string:=String:C10(Day of:C23($d_fecha);"00")+"/"+String:C10(Month of:C24($d_fecha);"00")+"/"+String:C10(Year of:C25($d_fecha))

$0:=$t_string