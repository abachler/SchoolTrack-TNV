//%attributes = {}
  // TMT_EliminaAsignaciones()
  // Por: Alberto Bachler: 18/05/13, 17:46:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)

C_POINTER:C301($y_recNumAsignaciones_al)

If (False:C215)
	C_LONGINT:C283(TMT_EliminaAsignaciones ;$0)
	C_POINTER:C301(TMT_EliminaAsignaciones ;$1)
End if 

$y_recNumAsignaciones_al:=$1

CREATE SELECTION FROM ARRAY:C640([TMT_Horario:166];$y_recNumAsignaciones_al->)
$0:=KRL_DeleteSelection (->[TMT_Horario:166])

