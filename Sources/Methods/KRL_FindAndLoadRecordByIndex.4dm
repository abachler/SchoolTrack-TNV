//%attributes = {}
  // KRL_FindAndLoadRecordByIndex()
  // Por: Alberto Bachler: 08/03/13, 16:51:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_cargarEnEscritura)
C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_campo;$y_tabla;$y_valorBuscado)
If (False:C215)
	C_POINTER:C301(KRL_FindAndLoadRecordByIndex ;$1)
	C_POINTER:C301(KRL_FindAndLoadRecordByIndex ;$2)
	C_BOOLEAN:C305(KRL_FindAndLoadRecordByIndex ;$3)
End if 

$y_campo:=$1
$y_valorBuscado:=$2
$b_cargarEnEscritura:=False:C215

If (Count parameters:C259=3)
	$b_cargarEnEscritura:=$3
End if 

  //CUERPO
$l_recNum:=Find in field:C653($y_campo->;$y_valorBuscado->)
$y_tabla:=Table:C252(Table:C252($y_campo))
KRL_GotoRecord ($y_tabla;$l_recNum;$b_cargarEnEscritura)

$0:=$l_recNum

