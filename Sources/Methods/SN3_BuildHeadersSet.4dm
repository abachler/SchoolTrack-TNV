//%attributes = {}
  //SN3_BuildHeadersSet

C_POINTER:C301($fieldPtr;$1)

$fieldPtr:=$1
$set:=$2

KRL_RelateSelection (->[Alumnos:2]numero:1;$fieldPtr;"")
CREATE SET:C116([Alumnos:2];$set)
UNION:C120("headers";$set;"headers")
CLEAR SET:C117($set)