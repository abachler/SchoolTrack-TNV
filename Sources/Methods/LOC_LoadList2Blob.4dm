//%attributes = {}
  //LOC_LoadList2Blob

C_POINTER:C301($2;$blobPtr)

$listName:=$1
$blobPtr:=$2

$listRef:=LOC_LoadList ($listName)

LIST TO BLOB:C556($listRef;$blobPtr->)
CLEAR LIST:C377($listRef)