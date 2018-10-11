//%attributes = {}
  //ST_GetCleanString

C_TEXT:C284($1;$text;$0)
$text:=Replace string:C233($1;<>nbSpace;" ")
$text:=Replace string:C233($text;"\t";" ")
  //$text:=Replace string($text;<>qt;"")
$0:=ST_ClrWildChars (ST_ClearSpaces (ST_ClearExtraCR ($text)))