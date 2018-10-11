//%attributes = {}
  //SMTP_Send_Blob

If (False:C215)
	
	  //SMTP_Send_Blob
	  // Module: 
	  // Purpose:
	  //Syntax: SNT_SendMail(Host,From,To,Subject,BodyBlob;{username;{$password;{$authMode;{ReplyTo;{CopyTo;{BlibCopyTo;{InReplyTo;{file1;{file2;{File3) 
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 2/13/01  10:34, by Felipe Fernández
	  // 
	  // Created on: `04/04/2005, 18:08:07 por Alberto Bachler
	  //inserté parametros para autenticación en $6 (userName), $7 (password), $8 (autenticación)
End if 

  // DECLARATIONS
  // ============================================
C_TEXT:C284($Host;$From;$To;$Subject;$ReplyTo;$CC;$BCC;$InReplyTo;$FiletoAttach1;$FiletoAttach2;$FiletoAttach3;$userName;$password;$errorString)
C_TEXT:C284($1;$2;$3;$4;$6;$7;$9;$10;$11;$12)
C_LONGINT:C283($smtp_ID;$8;$authMode)
C_BOOLEAN:C305($OK)
C_BLOB:C604($5;$Body)
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

  //ahora creo el mail  sin errores 
SMTP_ErrorCheck ("Init")
$errorString:=SMTP_ErrorCheck ("SMTP_GetPrefs";SMTP_GetPrefs ($lineFeeds;$bodyType;$lineLength))
$errorString:=SMTP_ErrorCheck ("SMTP_SetPrefs";SMTP_SetPrefs (-1;1;-1))

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
	$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_To ($smtp_ID;ST_ReplaceAccentedChars ($To)))
End if 
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Subject";SMTP_Subject ($smtp_ID;SMTP_EncodeSubject ($Subject)))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($smtp_ID;"Content-Type:";"text/plain;charset=iso-8859-1";1))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrack";SYS_LeeVersionEstructura ))
	$errorString:=SMTP_ErrorCheck ("SMTP_Comments";SMTP_Comments ($SMTP_ID;"Enviado desde SchoolTrack"))
End if 

If ((Count parameters:C259>=6) & ($errorString=""))
	If (($userName#"") & ($password#""))
		$errorString:=SMTP_ErrorCheck ("SMTP_Auth";SMTP_Auth ($smtp_ID;$userName;$password;$authMode))
	End if 
End if 

  //`Se debe recibir un Blob y transformarlo a texto, hay que concatenar 
BLOB PROPERTIES:C536($Body;$Compress;$expandedSize;$sizeBlob)
If ($sizeBlob<=32000)
	$body_Mail:=BLOB to text:C555($Body;Mac text without length:K22:10)
	If ($errorString="")
		$errorString:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($smtp_ID;_O_Mac to ISO:C519($body_Mail)))
	End if 
Else 
	If ($Compress=0)
		$Loop:=Mod:C98($sizeBlob;32000)
	Else 
		$Loop:=Mod:C98($expandedSize;32000)
	End if 
	$LengthText:=32000
	$offset:=0
	For ($i;1;$Loop)
		$body_Mail:=BLOB to text:C555($Body;Mac text with length:K22:9;$offset;$LengthText)
		If ($errorString="")
			$errorString:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($smtp_ID;_O_Mac to ISO:C519($body_Mail);2))
		End if 
	End for 
End if 


  //ahora veo si hay argumetos opcionales y creo el contenido de estos en el mail
If ((Count parameters:C259>=9) & ($errorString=""))
	If ($9#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_ReplyTo";SMTP_ReplyTo ($smtp_ID;$ReplyTo))
	End if 
End if 
If ((Count parameters:C259>=10) & ($errorString=""))
	If ($10#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Cc";SMTP_Cc ($smtp_ID;ST_ReplaceAccentedChars ($CC)))
	End if 
End if 
If ((Count parameters:C259>=11) & ($errorString=""))
	If ($11#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Bcc";SMTP_Bcc ($smtp_ID;ST_ReplaceAccentedChars ($BCC)))
	End if 
End if 
If ((Count parameters:C259>=12) & ($errorString=""))
	If ($12#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_InReplyTo";SMTP_InReplyTo ($smtp_ID;$InReplyTo))
	End if 
End if 
If ((Count parameters:C259>=13) & ($errorString=""))
	If ($13#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;$FiletoAttach1;1))
	End if 
End if 
If ((Count parameters:C259>=14) & ($errorString=""))
	If ($14#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;$FiletoAttach2;1))
	End if 
End if 
If ((Count parameters:C259>=15) & ($errorString=""))
	If ($15#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;$FiletoAttach3;1))
	End if 
End if 

  //si ahora todas las partes del mail fueron creadas bien . lo mando
If (($errorString="") & (SMTP_ErrorCheck ("SMTP_Send";SMTP_Send ($smtp_ID))=""))
	$ignore:=SMTP_ErrorCheck ("SMTP_Clear";SMTP_Clear ($smtp_ID))
	$0:=""
Else 
	$0:=vtSMTP_LastError
End if 