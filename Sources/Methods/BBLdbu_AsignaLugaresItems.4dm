//%attributes = {"executedOnServer":true}
  // BBLdbu_AsignaLugaresItems()
  // Por: Alberto Bachler: 17/09/13, 13:16:53
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_proceso)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_lugares;0)

ALL RECORDS:C47([BBL_Items:61])
LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
$l_proceso:=IT_Progress (1;0;0;__ ("Asignando lugares a items en MediaTrack"))
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Items:61])
	GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
	QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]Lugar:13#"")
	DISTINCT VALUES:C339([BBL_Registros:66]Lugar:13;$at_lugares)
	[BBL_Items:61]Lugares:51:=AT_array2text (->$at_lugares;", ")
	SAVE RECORD:C53([BBL_Items:61])
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)
KRL_UnloadReadOnly (->[BBL_Registros:66])
