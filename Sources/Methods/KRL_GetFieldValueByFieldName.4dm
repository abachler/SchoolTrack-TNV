//%attributes = {}
  //KRL_GetFieldValueByFieldName

C_TEXT:C284($fieldName;$1)
C_POINTER:C301($fieldPointer;$valuePointer;$2;$0)

$fieldName:=$1
$valuePointer:=$2
$fieldPointer:=KRL_GetFieldPointerByName ($fieldName)

$valuePointer->:=$fieldPointer->


