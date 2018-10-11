//%attributes = {}
  //SMTP_ErrorCheck


C_TEXT:C284($0;$1;$command;vtSMTP_LastError)

$command:=$1
If (Count parameters:C259=2)
	$error:=$2
End if 
If ($command="Init")
	vtSMTP_LastError:=""
Else 
	$ErrorMsg:=IT_ErrorText ($Error)
	If ($error#0)
		vtSMTP_LastError:="ERROR -- "+"\r"+"Comando: "+$Command+"\r"+"Código Error:"+String:C10($Error)+"\r"+"Descripción: "+$ErrorMsg
	End if 
End if 
$0:=vtSMTP_LastError


