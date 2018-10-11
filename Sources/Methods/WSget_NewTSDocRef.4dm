//%attributes = {}
  //WSget_NewTSDocRef

  //`xShell, Alberto Bachler
  //WSget_NewTSDocRef
  //Por Administrator
  //Creada el 13/04/2005, 14:53:37
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****

C_TEXT:C284($schoolId;$1;$2;$DTS;$3)
C_TEXT:C284(vtWS_ResultString)
C_BLOB:C604($vx_Blob;$0)

  //****INICIALIZACIONES****
$rolBd:=$1
$countryCode:=$2
$dts:=$3

  //****CUERPO****
error:=0
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

WEB SERVICE SET PARAMETER:C777("rolBD";$rolBd)
WEB SERVICE SET PARAMETER:C777("codigopais";$countryCode)
WEB SERVICE SET PARAMETER:C777("DTS";$DTS)
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
WEB SERVICE CALL:C778("https://intranet.colegium.com/4DSOAP/";"SchoolNetII_WebServices#WSout_NewTSDocuments";"WSout_NewTSDocuments";"http://intranet.colegium.com/namespace_SchoolNetII";Web Service dynamic:K48:1)
EM_ErrorManager ("Clear")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vtWS_ResultString;"ERRstring")
	WEB SERVICE GET RESULT:C779($vx_Blob;"NewTSDocs";*)
	BLOB_ExpandBlob_byPointer (->$vx_Blob)
End if 

$0:=$vx_Blob

  //****LIMPIEZA****
