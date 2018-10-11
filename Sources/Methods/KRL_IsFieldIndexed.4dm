//%attributes = {}
  // KRL_IsFieldIndexed()
  // Por: Alberto Bachler: 04/03/13, 18:19:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_EsIndexado)
C_LONGINT:C283($l_largo;$l_tipo)
C_POINTER:C301($y_campo)

If (False:C215)
	C_BOOLEAN:C305(KRL_IsFieldIndexed ;$0)
	C_POINTER:C301(KRL_IsFieldIndexed ;$1)
End if 

$y_campo:=$1
GET FIELD PROPERTIES:C258($y_campo;$l_tipo;$l_largo;$b_EsIndexado)
$0:=$b_EsIndexado