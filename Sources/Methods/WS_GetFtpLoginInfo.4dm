//%attributes = {}
  // Método: WS_GetFtpLoginInfo
  // 
  // 
  // por Alberto Bachler Klein
  // creación 23/01/18, 02:53:09
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****

C_TEXT:C284($1;$id;$0)
C_TEXT:C284(vtWS_ResultString;vtWS_ftpLoginName;vtWS_ftpPassword;vtWS_ftpDirectory)
C_BLOB:C604($blob)

  //****INICIALIZACIONES****


  //****CUERPO****
error:=0
  //EM_ErrorManager ("Install")
  //EM_ErrorManager ("SetMode";"")

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$rolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
$codigoPais:=[xShell_ApplicationData:45]Código_Pais:26

WEB SERVICE SET PARAMETER:C777("rolBD";$rolBD)
WEB SERVICE SET PARAMETER:C777("codigoPais";$codigoPais)
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)

$t_error:=WS_CallIntranetWebService ("WSsend_LoginInfo")

If ($t_error="")
	WEB SERVICE GET RESULT:C779(vtWS_ResultString;"ERRstring")
	WEB SERVICE GET RESULT:C779(vtWS_ftpLoginName;"login")
	WEB SERVICE GET RESULT:C779(vtWS_ftpPassword;"password")
	WEB SERVICE GET RESULT:C779(vtWS_ftpDirectory;"directory";*)  //20180514 RCH Ticket 206788
	vtWS_ftpDirectory:=""
End if 


  //****LIMPIEZA****
