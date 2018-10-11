//%attributes = {}
  //SMTP_Send_Text

If (False:C215)
	
	  //Método: SMTP_Send_Text
	  // Module: 
	  // Purpose:
	  // Syntax: SMTP_Send_Text(Host,From,To,Subject,BodyText;{username;{$password;{$authMode;{ReplyTo;{CopyTo;{BlibCopyTo;{InReplyTo;{file1;{file2;{File3)
	  // Parameters: 
	  // Result: None
	
	  // HISTORY
	  // ============================================`
	  //Created on:  `04/04/2005, 18:08:07 por Alberto Bachler
End if 


  // DECLARATIONS
  // ============================================
C_TEXT:C284($Host;$From;$To;$Subject;$ReplyTo;$CC;$BCC;$InReplyTo;$FiletoAttach1;$FiletoAttach2;$FiletoAttach3)
C_TEXT:C284($1;$2;$3;$4;$5;$6;$7;$9;$10;$11;$12;$errorString)
C_LONGINT:C283($smtp_ID;$8)
C_LONGINT:C283($l_timeout)
C_BOOLEAN:C305(K;$OK)
<>ShowErrors:=True:C214
$errorString:=""
$Host:=$1
$From:=$2
$To:=$3
$Subject:=$4
$Body:=$5
$userName:=$6
$password:=$7
$authMode:=1
Case of 
	: (Count parameters:C259=9)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
	: (Count parameters:C259=10)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
		$CC:=$10
	: (Count parameters:C259=11)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
		$CC:=$10
		$BCC:=$11
	: (Count parameters:C259=12)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
		$CC:=$10
		$BCC:=$11
		$InReplyTo:=$12
	: (Count parameters:C259=13)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
		$CC:=$10
		$BCC:=$11
		$InReplyTo:=$12
		$FileToAttach1:=$13
	: (Count parameters:C259=14)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
		$CC:=$10
		$BCC:=$11
		$InReplyTo:=$12
		$FileToAttach1:=$13
		$FileToAttach2:=$14
	: (Count parameters:C259=15)
		$userName:=$6
		$password:=$7
		$authMode:=$8
		$ReplyTo:=$9
		$CC:=$10
		$BCC:=$11
		$InReplyTo:=$12
		$FileToAttach1:=$13
		$FileToAttach2:=$14
		$FileToAttach3:=$15
End case 
  //$body:=Replace string($body;"\r";"\r"+Char(10))

  //ahora creo el mail  sin errores 

SMTP_ErrorCheck ("Init")
  //$errorString:=SMTP_ErrorCheck ("SMTP_GetPrefs";SMTP_GetPrefs ($lineFeeds;$bodyType;$lineLength))
  //$errorString:=SMTP_ErrorCheck ("SMTP_SetPrefs";SMTP_SetPrefs (1;1;0))

  //20130228 RCH Se aumenta timeout de 30 a 90
$errIT:=IT_GetTimeOut ($l_timeout)
$errIT:=IT_SetTimeOut (90)

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_New";SMTP_New ($smtp_ID))
End if 
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Host";SMTP_Host ($smtp_ID;$Host))
End if 
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_From";SMTP_From ($smtp_ID;ST_ReplaceAccentedChars ($From)))
End if 
If ($errorString="")
	  //$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_To ($smtp_ID;ST_ReplaceAccentedChars ($To)))
	ARRAY TEXT:C222($at_smtpTo;0)
	AT_Text2Array (->$at_smtpTo;$To;";")
	For ($i;1;Size of array:C274($at_smtpTo))
		$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_To ($smtp_ID;ST_ReplaceAccentedChars ($at_smtpTo{$i})))
	End for 
End if 
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Subject";SMTP_Subject ($smtp_ID;SMTP_EncodeSubject ($subject)))
End if 
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($smtp_ID;"Content-Type:";"text/plain;charset=iso-8859-1";1))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrack:";SYS_LeeVersionEstructura ;1))
	  // Modificado por: Saúl Ponce (25/08/2017) Ticket 186647, identificar en la cabecera del mensaje el equipo que realizó el envío
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackMaquina:";Current machine:C483;1))
	$errorString:=SMTP_ErrorCheck ("SMTP_Comments";SMTP_Comments ($SMTP_ID;"Enviado desde SchoolTrack"))
End if 

  //$errorString:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($smtp_ID;Mac to ISO($body)))
  //SMTP_SetPrefs (1;1;0)  //2010827 RCH SOLO v11. Habian problemas con acentos. Se agregaros estas 2 lineas y se quito un mac to iso
  //$err:=SMTP_Charset (1;1)
  //20170517 ticket 181247 Para evitar problema de simbolos y tíldes. 
$err:=SMTP_SetPrefs (1;6;76)
$err:=SMTP_Charset (0;1)
$errorString:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($smtp_ID;$body))

If ((Count parameters:C259>=6) & ($errorString=""))
	If (($userName#"") & ($password#""))
		$errorString:=SMTP_ErrorCheck ("SMTP_Auth";SMTP_Auth ($smtp_ID;$userName;$password;$authMode))
	End if 
End if 

  //ahora veo si hay argumetos opcionales y creo el contenido de estos en el mail
If ((Count parameters:C259>=9) & ($errorString=""))
	If ($9#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_ReplyTo";SMTP_ReplyTo ($smtp_ID;$ReplyTo))
	End if 
End if 
If ((Count parameters:C259>=10) & ($errorString=""))
	If ($10#"")
		  //$errorString:=SMTP_ErrorCheck ("SMTP_Cc";SMTP_Cc ($smtp_ID;ST_ReplaceAccentedChars ($CC)))
		ARRAY TEXT:C222($at_smtpCC;0)
		AT_Text2Array (->$at_smtpCC;$CC;";")
		For ($i;1;Size of array:C274($at_smtpCC))
			$errorString:=SMTP_ErrorCheck ("SMTP_Cc";SMTP_Cc ($smtp_ID;ST_ReplaceAccentedChars ($at_smtpCC{$i})))
		End for 
	End if 
End if 
If ((Count parameters:C259>=11) & ($errorString=""))
	If ($11#"")
		  //$errorString:=SMTP_ErrorCheck ("SMTP_Bcc";SMTP_Bcc ($smtp_ID;ST_ReplaceAccentedChars ($BCC)))
		ARRAY TEXT:C222($at_smtpBCC;0)
		AT_Text2Array (->$at_smtpBCC;$BCC;";")
		For ($i;1;Size of array:C274($at_smtpBCC))
			$errorString:=SMTP_ErrorCheck ("SMTP_Bcc";SMTP_Bcc ($smtp_ID;ST_ReplaceAccentedChars ($at_smtpBCC{$i})))
		End for 
	End if 
End if 
If ((Count parameters:C259>=12) & ($errorString=""))
	If ($12#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_InReplyTo";SMTP_InReplyTo ($smtp_ID;$InReplyTo))
	End if 
End if 
If ((Count parameters:C259>=13) & ($errorString=""))
	If ($13#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;$FiletoAttach1;2))  //base64 encoding
	End if 
End if 
If ((Count parameters:C259>=14) & ($errorString=""))
	If ($14#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;$FiletoAttach2;2))  //base64 encoding
	End if 
End if 
If ((Count parameters:C259>=15) & ($errorString=""))
	If ($15#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;$FiletoAttach3;2))  //base64 encoding
	End if 
End if 

  //si ahora todas las partes del mail fueron creadas bien . lo mando
If (($errorString="") & (SMTP_ErrorCheck ("SMTP_Send";SMTP_Send ($smtp_ID))=""))
	$ignore:=SMTP_ErrorCheck ("SMTP_Clear";SMTP_Clear ($smtp_ID))
	$0:=""
Else 
	$0:=vtSMTP_LastError
End if 

$errIT:=IT_SetTimeOut ($l_timeout)