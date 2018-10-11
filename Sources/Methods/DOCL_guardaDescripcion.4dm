//%attributes = {}
  // DOCL_guardaDescripcion()
  // Por: Alberto Bachler: 17/09/13, 15:55:15
  //  ---------------------------------------------
  // Guarda la descripción de un documento 
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_recNum)
C_TEXT:C284($t_descripcion;$t_uuid)

If (False:C215)
	C_LONGINT:C283(DOCL_guardaDescripcion ;$0)
	C_TEXT:C284(DOCL_guardaDescripcion ;$1)
	C_TEXT:C284(DOCL_guardaDescripcion ;$2)
End if 

$t_uuid:=$1
$t_descripcion:=$2

$l_recNum:=KRL_FindAndLoadRecordByIndex (->[DocumentLibrary:234]Auto_UUID:2;->$t_uuid;True:C214)
If (OK=1)
	[DocumentLibrary:234]Document_description:5:=$t_descripcion
	SAVE RECORD:C53([DocumentLibrary:234])
	READ ONLY:C145([DocumentLibrary:234])
	LOAD RECORD:C52([DocumentLibrary:234])
End if 

$0:=OK

