//%attributes = {}
  //WSget_TSDocuments

  //`xShell, Alberto Bachler
  //Metodo: WSget_SupportEvents
  //Por Administrator
  //Creada el 13/04/2005, 14:53:37
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****

C_TEXT:C284($schoolId;$1;$vtTS_UserName;$2)
C_TEXT:C284(vtWS_ResultString)
C_BLOB:C604($vx_Blob)

  //****INICIALIZACIONES****
$schoolId:=$1
If (Count parameters:C259=2)
	$words:=$2
Else 
	$words:=""
End if 

  //****CUERPO****
error:=0
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

WEB SERVICE SET PARAMETER:C777("ID";$schoolId)
WEB SERVICE SET PARAMETER:C777("Words";$words)
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
WEB SERVICE CALL:C778("https://intranet.colegium.com/4DSOAP/";"SchoolNetII_WebServices#WSout_ListaDocumentosSoporte";"WSout_ListaDocumentosSoporte";"http://intranet.colegium.com/namespace_SchoolNetII";Web Service dynamic:K48:1)
EM_ErrorManager ("Clear")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vtWS_ResultString;"ERRstring")
	WEB SERVICE GET RESULT:C779($vx_Blob;"TSDocumentsBlob";*)
	BLOB_ExpandBlob_byPointer (->$vx_Blob)
End if 
$0:=$vx_Blob


  //****LIMPIEZA****

