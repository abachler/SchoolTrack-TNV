//%attributes = {}
  //WSget_EventosSoporte_SNTII

  //`xShell, Alberto Bachler
  //Metodo: WSget_SupportEvents
  //Por Administrator
  //Creada el 13/04/2005, 14:53:37
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****

C_TEXT:C284($rolBD;$1;$vtTS_UserName;$2;$codigoPais)
C_TEXT:C284(vtWS_ResultString)
C_BLOB:C604(vx_Blob)

  //****INICIALIZACIONES****
$rolBD:=$1
$vtTS_UserName:=$2
$codigoPais:=<>vtXS_CountryCode

  //****CUERPO****
error:=0
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

WEB SERVICE SET PARAMETER:C777("rolBD";$rolBD)
WEB SERVICE SET PARAMETER:C777("codigoPais";$codigoPais)
WEB SERVICE SET PARAMETER:C777("UserName";$vtTS_UserName)
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
WEB SERVICE CALL:C778(vtWS_Schoolnet_URL;vtWS_SchoolNet_SoapAction;"WSget_SupportEvents";vtWS_Schoolnet_Namespace;Web Service dynamic:K48:1)
EM_ErrorManager ("Clear")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vtWS_ResultString;"ERRstring")
	WEB SERVICE GET RESULT:C779(vx_Blob;"EVENTSblob";*)
	BLOB_ExpandBlob_byPointer (->vx_Blob)
	$0:=vx_Blob
End if 


  //****LIMPIEZA****
