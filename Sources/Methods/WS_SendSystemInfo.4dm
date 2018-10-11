//%attributes = {}
  //WS_SendSystemInfo

  //`xShell, Alberto Bachler
  //Metodo: proxy_WS_Familias
  //Por abachler
  //Creada el 05/11/2003, 16:11:48
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****

C_TEXT:C284($1;$id;$0)
C_TEXT:C284(vtWS_ResultString)
C_BLOB:C604($blob)

  //****INICIALIZACIONES****
vtWS_Schoolnet_URL:="http://www.colegium.com/4DSOAP"
vtWS_SchoolNet_SoapAction:="SchoolNet_WebServices"
vtWS_Schoolnet_Namespace:="http://www.colegium.com/namespace_colegium"

  //****CUERPO****
error:=0
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$id:=[xShell_ApplicationData:45]ID_Organizacion:17
$blob:=SYS_GetSystemInfos ("OT Blob")
WEB SERVICE SET PARAMETER:C777("ID";$ID)
WEB SERVICE SET PARAMETER:C777("SYSInfo";$blob)
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
$t_error:=WS_CallIntranetWebService ("WS_StoreSysInfo")

EM_ErrorManager ("Clear")

If ($t_error="")
	WEB SERVICE GET RESULT:C779(vtWS_ResultString;"ERRstring";*)  //20180514 RCH Ticket 206788
End if 


  //****LIMPIEZA****

