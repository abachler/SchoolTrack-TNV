//%attributes = {}
  // TMT_EliminaAsignacion()
  // Por: Alberto Bachler: 18/05/13, 17:46:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumAsignacioHorario)

If (False:C215)
	C_LONGINT:C283(TMT_EliminaAsignacion ;$0)
	C_LONGINT:C283(TMT_EliminaAsignacion ;$1)
End if 
$l_recNumAsignacioHorario:=$1

$0:=KRL_DeleteRecord (->[TMT_Horario:166];$l_recNumAsignacioHorario)

