//%attributes = {}
  //ST_CleanString

C_TEXT:C284($1;$text;$0)
$text:=Replace string:C233($1;<>nbSpace;" ")
$text:=Replace string:C233($text;"\t";" ")
$text:=Replace string:C233($text;"\"";"")
$0:=ST_ClrWildChars (ST_ClearSpaces (ST_ClearExtraCR ($text)))