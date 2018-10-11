//%attributes = {}
  //KRL_LoadIndex

C_POINTER:C301($file;$field;$1)
$file:=Table:C252(Table:C252($1))
$field:=$1
ALL RECORDS:C47($file->)
ORDER BY:C49($file->;$field->;>)
REDUCE SELECTION:C351($file->;0)