//%attributes = {}
  //SR_FormatoRUT

$0:=String:C10(Num:C11(Substring:C12($1;1;Length:C16($1)-1));"##.###.###")+"-"+$1[[Length:C16($1)]]