//%attributes = {}
  // DOCL_GuardaMiniatura(uuid:&T; descripcion:&T)
  // Por: Alberto Bachler: 17/09/13, 15:54:30
  //  ---------------------------------------------
  // Guarda una miniautura de una imagen en el registro del documento de la libreria pasado en uuid
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)

C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_miniatura)
C_TEXT:C284($t_uuid)
If (False:C215)
	C_TEXT:C284(DOCL_guardaMiniatura ;$1)
	C_POINTER:C301(DOCL_guardaMiniatura ;$2)
End if 

$t_uuid:=$1
$y_miniatura:=$2

$l_recNum:=KRL_FindAndLoadRecordByIndex (->[DocumentLibrary:234]Auto_UUID:2;->$t_uuid;True:C214)
If (OK=1)
	[DocumentLibrary:234]Thumbnail:4:=$y_miniatura->
	SAVE RECORD:C53([DocumentLibrary:234])
	READ ONLY:C145([DocumentLibrary:234])
	LOAD RECORD:C52([DocumentLibrary:234])
End if 

$0:=OK

