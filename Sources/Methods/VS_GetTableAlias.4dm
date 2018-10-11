//%attributes = {}
  //VS_GetTableAlias

_O_C_STRING:C293(3;$country;$langage;$1;$2)
C_LONGINT:C283($3;$tableRecTable)
_O_C_STRING:C293(80;$0)

$country:=$1
$langage:=$2
$tableRecTable:=$3

$0:=XSvs_nombreTablaLocal_Numero ($tableRecTable;$country;$langage)
