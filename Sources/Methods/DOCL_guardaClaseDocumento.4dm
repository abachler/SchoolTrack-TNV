//%attributes = {}
  // DOCL_guardaClaseDocumento(uuid:&T; clase:&T)
  // Por: Alberto Bachler: 17/09/13, 13:40:39
  //  ---------------------------------------------
  // Guarda la clase del documento en la libreria 
  //  La clase del documento permite establecer un tipo de documento especifico (contrato, liquidacion de sueldo, certificado de nacimento, certificado de estudi, etc.)
  //  La clase es un texto libre dejado al arbitrio del desarrollador
  //  Esta clase puede ser pasada como argumento opcional al método DOCL_DocumentosAsociados
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_recNum)
C_TEXT:C284($t_claseDocumento;$t_uuid)

If (False:C215)
	C_LONGINT:C283(DOCL_guardaClaseDocumento ;$0)
	C_TEXT:C284(DOCL_guardaClaseDocumento ;$1)
	C_TEXT:C284(DOCL_guardaClaseDocumento ;$2)
End if 

$t_uuid:=$1
$t_claseDocumento:=$2

$l_recNum:=KRL_FindAndLoadRecordByIndex (->[DocumentLibrary:234]Auto_UUID:2;->$t_uuid;True:C214)
If (OK=1)
	[DocumentLibrary:234]refClase:11:=$t_claseDocumento
	SAVE RECORD:C53([DocumentLibrary:234])
	READ ONLY:C145([DocumentLibrary:234])
	LOAD RECORD:C52([DocumentLibrary:234])
End if 

$0:=OK