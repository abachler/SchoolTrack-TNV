//%attributes = {}
  // DOCL_establecePosicion()
  // Por: Alberto Bachler: 20/09/13, 11:28:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)

_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_posicion;$l_posicionActual;$l_recNum)
C_TEXT:C284($t_refRegistro;$t_refTabla;$t_uuid)

ARRAY LONGINT:C221($al_RecNums;0)
If (False:C215)
	C_TEXT:C284(DOCL_establecePosicion ;$1)
	C_LONGINT:C283(DOCL_establecePosicion ;$2)
End if 
$t_uuid:=$1
$l_posicion:=$2

$l_recNum:=KRL_FindAndLoadRecordByIndex (->[DocumentLibrary:234]Auto_UUID:2;->$t_uuid;True:C214)
$t_refTabla:=[DocumentLibrary:234]refTabla:8
$t_refRegistro:=[DocumentLibrary:234]refRegistro:1
$l_posicionActual:=[DocumentLibrary:234]Order:17

QUERY:C277([DocumentLibrary:234];[DocumentLibrary:234]refTabla:8=$t_refTabla;*)
QUERY:C277([DocumentLibrary:234]; & ;[DocumentLibrary:234]refRegistro:1=$t_refRegistro;*)
QUERY:C277([DocumentLibrary:234]; & ;[DocumentLibrary:234]Auto_UUID:2;#;$t_uuid;*)
QUERY:C277([DocumentLibrary:234]; & ;[DocumentLibrary:234]Order:17;>;$l_posicionActual)
ORDER BY:C49([DocumentLibrary:234];[DocumentLibrary:234]Order:17;>)

LONGINT ARRAY FROM SELECTION:C647([DocumentLibrary:234];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([DocumentLibrary:234])
	GOTO RECORD:C242([DocumentLibrary:234];$al_RecNums{$i_registros})
	[DocumentLibrary:234]Order:17:=$l_posicion+$i_registros
	SAVE RECORD:C53([DocumentLibrary:234])
End for 
KRL_UnloadReadOnly (->[DocumentLibrary:234])

$l_recNum:=KRL_FindAndLoadRecordByIndex (->[DocumentLibrary:234]Auto_UUID:2;->$t_uuid;True:C214)
[DocumentLibrary:234]Order:17:=$l_posicion
SAVE RECORD:C53([DocumentLibrary:234])

