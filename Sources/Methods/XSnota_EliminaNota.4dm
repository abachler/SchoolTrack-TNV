//%attributes = {}
  // XSnota_EliminaNota(llave: &T) -> resultado: &T
  // Por: Alberto Bachler K.: 11-03-15, 17:57:37
  //  ---------------------------------------------
  // elimina la aanotació´n asociada al registro correspondiente a la llave pasada
  // retorna:
  // * -1 si el registro existe pero no pudo ser eliminado
  // * 0 si el registro no existe
  // * 1 si el registro fue eliminado
  //  ---------------------------------------------
C_LONGINT:C283($l_recNum;$l_resultado)
C_TEXT:C284($t_llave)

$t_llave:=$1
$l_recNum:=Find in field:C653([xShell_RecordNotes:283]Llave:4;$t_llave)
If ($l_recNum>No current record:K29:2)
	OK:=KRL_DeleteRecord (->[xShell_RecordNotes:283];$l_recNum)
	$l_resultado:=Choose:C955(OK=1;1;-1)
Else 
	$l_resultado:=0
End if 

