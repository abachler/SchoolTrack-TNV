//%attributes = {}
  //ST_ReplaceAccentedChars

  //RCH 2008-07-07 Cuando se pasaba, por ejemplo, el texto AccountTrack, este método devolvía accountTrack.
  //Se cambio el Replace string por la llamada al método ST_ReplaceCharByAsciiCode
$text:=$1

$text:=ST_ReplaceCharByAsciiCode ($text;"á";"a")
$text:=ST_ReplaceCharByAsciiCode ($text;"é";"e")
$text:=ST_ReplaceCharByAsciiCode ($text;"í";"i")
$text:=ST_ReplaceCharByAsciiCode ($text;"ó";"o")
$text:=ST_ReplaceCharByAsciiCode ($text;"ú";"u")
$text:=ST_ReplaceCharByAsciiCode ($text;"à";"a")
$text:=ST_ReplaceCharByAsciiCode ($text;"è";"e")
$text:=ST_ReplaceCharByAsciiCode ($text;"ì";"i")
$text:=ST_ReplaceCharByAsciiCode ($text;"ò";"o")
$text:=ST_ReplaceCharByAsciiCode ($text;"ù";"u")
$text:=ST_ReplaceCharByAsciiCode ($text;"ä";"a")
$text:=ST_ReplaceCharByAsciiCode ($text;"ë";"e")
$text:=ST_ReplaceCharByAsciiCode ($text;"ï";"i")
$text:=ST_ReplaceCharByAsciiCode ($text;"ö";"o")
$text:=ST_ReplaceCharByAsciiCode ($text;"ü";"u")
$text:=ST_ReplaceCharByAsciiCode ($text;"â";"a")
$text:=ST_ReplaceCharByAsciiCode ($text;"ê";"e")
$text:=ST_ReplaceCharByAsciiCode ($text;"î";"i")
$text:=ST_ReplaceCharByAsciiCode ($text;"ô";"o")
$text:=ST_ReplaceCharByAsciiCode ($text;"û";"u")
$text:=ST_ReplaceCharByAsciiCode ($text;"ñ";"n")
$text:=ST_ReplaceCharByAsciiCode ($text;"ç";"c")
$text:=ST_ReplaceCharByAsciiCode ($text;"ç";"c")
$text:=ST_ReplaceCharByAsciiCode ($text;"ã";"a")
$text:=ST_ReplaceCharByAsciiCode ($text;"õ";"o")

$text:=ST_ReplaceCharByAsciiCode ($text;"Á";"A")
$text:=ST_ReplaceCharByAsciiCode ($text;"É";"E")
$text:=ST_ReplaceCharByAsciiCode ($text;"Í";"I")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ó";"O")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ú";"U")
$text:=ST_ReplaceCharByAsciiCode ($text;"À";"A")
$text:=ST_ReplaceCharByAsciiCode ($text;"È";"E")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ì";"I")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ò";"O")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ù";"U")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ä";"A")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ë";"E")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ï";"I")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ö";"O")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ü";"U")
$text:=ST_ReplaceCharByAsciiCode ($text;"Â";"A")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ê";"E")
$text:=ST_ReplaceCharByAsciiCode ($text;"Î";"I")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ô";"O")
$text:=ST_ReplaceCharByAsciiCode ($text;"Û";"U")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ñ";"N")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ç";"C")
$text:=ST_ReplaceCharByAsciiCode ($text;"Ã";"a")
$text:=ST_ReplaceCharByAsciiCode ($text;"Õ";"o")
$0:=$text