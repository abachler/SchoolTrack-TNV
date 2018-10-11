//%attributes = {}
  //KRL_GetFieldPointer

$tablePointer:=$1
C_POINTER:C301($0;$1;yXS_GenericFieldPointer)
EXECUTE FORMULA:C63("yXS_GenericFieldPointer:=->["+Table name:C256($tablePointer)+"]"+$2)
$0:=yXS_GenericFieldPointer