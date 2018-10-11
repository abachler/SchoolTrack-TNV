//%attributes = {}
  //ST_ParseNames


$string:=ST_ClearSpaces ($1)
$string:=Replace string:C233($string;" de la ";"_de_la_")
$string:=Replace string:C233($string;" de ";"_de_")
$string:=Replace string:C233($string;" la ";"_la_")
$string:=Replace string:C233($string;" le ";"_le_")
$string:=Replace string:C233($string;" del ";"_del_")
$string:=Replace string:C233($string;" du ";"_du_")
$string:=Replace string:C233($string;" von ";"_von_")
$string:=Replace string:C233($string;" di ";"_di_")
$string:=Replace string:C233($string;" da ";"_da_")
$string:=Replace string:C233($string;" dal ";"_dal_")
$string:=Replace string:C233($string;" dalla ";"_dalla_")
$string:=Replace string:C233($string;" Mc ";"_Mc_")
$string:=Replace string:C233($string;" Mac ";"_Mac_")

$string:=Replace string:C233($string;"de la ";"de_la_")
$string:=Replace string:C233($string;"de ";"de_")
$string:=Replace string:C233($string;"la ";"la_")
$string:=Replace string:C233($string;"le ";"e_")
$string:=Replace string:C233($string;"del ";"del_")
$string:=Replace string:C233($string;"du ";"du_")
$string:=Replace string:C233($string;"von ";"von_")
$string:=Replace string:C233($string;"di ";"di_")
$string:=Replace string:C233($string;"da ";"da_")
$string:=Replace string:C233($string;"dal ";"dal_")
$string:=Replace string:C233($string;"dalla ";"dalla_")
$string:=Replace string:C233($string;"Mc ";"Mc_")
$string:=Replace string:C233($string;"Mac ";"Mac_")

$0:=ST_GetWord ($string;1)+" "+ST_GetWord ($string;2)