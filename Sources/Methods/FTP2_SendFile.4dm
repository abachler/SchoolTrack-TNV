//%attributes = {}
  // Método: FTP2_SendFile
  //
  //
  // creado por Alberto Bachler Klein
  // el 11/08/18, 16:35:55
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($b_showProgressOnClient;$b_showProgressOnServer)
C_LONGINT:C283($l_connection;$l_connectionId;$l_error;$l_process)
C_REAL:C285($r_documentSize)
C_TEXT:C284($t_fileName;$t_localPath;$t_message;$t_password;$t_registeredClient;$t_remotePath;$t_siteName;$t_user)
C_OBJECT:C1216($o_ftpParameters)


$o_ftpParameters:=$1

$t_localPath:=OB Get:C1224($o_ftpParameters;"localPath")
$t_remotePath:=OB Get:C1224($o_ftpParameters;"remotePath")
$t_user:=OB Get:C1224($o_ftpParameters;"user")
$t_password:=OB Get:C1224($o_ftpParameters;"password")
$b_showProgressOnServer:=OB Get:C1224($o_ftpParameters;"showProgressOnServer")
$b_showProgressOnClient:=OB Get:C1224($o_ftpParameters;"showProgressOnClient")
$t_registeredClient:=OB Get:C1224($o_ftpParameters;"registeredClient")


$t_siteName:=ST_GetWord ($t_remotePath;1;"/")
$r_documentSize:=Get document size:C479($t_localPath)
$t_fileName:=SYS_Path2FileName (OB Get:C1224($o_ftpParameters;"localPath"))



$l_error:=FTP_Login ($t_siteName;\
$t_user;\
$t_password;\
$l_connectionId\
)

If ($l_error=0)
	OB SET:C1220($o_ftpParameters;"connectionId";$l_connectionId)
	OB SET:C1220($o_ftpParameters;"fileName";$t_fileName)
	OB SET:C1220($o_ftpParameters;"uploadSize";$r_documentSize)
	OB SET:C1220($o_ftpParameters;"callbackAction";"sendFileProgress")
	
	
	TRACE:C157
	If ((Application type:C494#4D Remote mode:K5:5) & ($b_showProgressOnServer))
		$l_process:=New process:C317("FTP2_CallBack";0;"FTP sender";$o_ftpParameters)
	End if 
	
	If ((Application type:C494=4D Server:K5:6) & ($b_showProgressOnClient))
		EXECUTE ON CLIENT:C651($t_registeredClient;"FTP2_CallBack";$o_ftpParameters)
	End if 
	
	$t_remotePath:=OB Get:C1224($o_ftpParameters;"$t_remotePath")
	$l_error:=FTP_Send ($l_connectionId;$t_localPath;$t_remotePath)
	$l_error:=FTP_Logout ($l_connection)
End if 




