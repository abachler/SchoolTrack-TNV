//%attributes = {}
  // BBLdbu_BuildCards()
  // Por: Alberto Bachler: 17/09/13, 13:17:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_registros;$l_proceso)

ARRAY LONGINT:C221($al_RecNums;0)

ALL RECORDS:C47([BBL_Items:61])

LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
$l_proceso:=IT_Progress (1;$l_proceso;0;__ ("Actualizando fichas catalográficas..."))
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
	BBLitm_ActualizaFichasCatalogo 
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
KRL_UnloadReadOnly (->[BBL_Items:61])
$l_proceso:=IT_Progress (-1;$l_proceso)



