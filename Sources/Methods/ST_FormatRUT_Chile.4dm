//%attributes = {}
  //ST_FormatRUT_Chile

$rut:=$1
$0:=String:C10(Num:C11(Substring:C12($rut;1;Length:C16($rut)-1));"##.###.###-")+Substring:C12($rut;Length:C16($rut);1)