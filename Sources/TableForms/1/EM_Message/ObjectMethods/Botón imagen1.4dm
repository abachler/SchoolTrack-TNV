C_TEXT:C284($errorString)

$schooltrackUser:=<>tUSR_CurrentUser
$pID:=IT_UThermometer (1;0;__ ("Enviando correo...");-1)

SMTP_ErrorCheck ("Init")
  //$errorString:=SMTP_ErrorCheck ("SMTP_GetPrefs";SMTP_GetPrefs ($lineFeeds;$bodyType;$lineLength))
  //$errorString:=SMTP_ErrorCheck ("SMTP_SetPrefs";SMTP_SetPrefs (1;1;0))

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_New";SMTP_New ($smtp_ID))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Host";SMTP_Host ($smtp_ID;"mail.colegium.com"))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($smtp_ID;"Content-Type:";"text/plain;charset=iso-8859-1";0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrack:";SYS_LeeVersionEstructura ;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackUser:";$schooltrackUser;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventID:";vtTS_EventID;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_Comments";SMTP_Comments ($SMTP_ID;"Enviado desde SchoolTrack"))
End if 

If ($errorString="")
	$userName:=vtWS_ftpLoginName+"@colegium.com"
	$errorString:=SMTP_ErrorCheck ("SMTP_Auth";SMTP_Auth ($smtp_ID;$userName;vtWS_ftpPassword;1))
End if 

If ($errorString="")
	If (vtMAIL_address#"")
		vtMAIL_address:=$schooltrackUser+"<"+vtMAIL_address+">"
		$errorString:=SMTP_ErrorCheck ("SMTP_From";SMTP_From ($smtp_ID;vtMAIL_address))
	Else 
		$userName:=vtWS_ftpLoginName+"@colegium.com"
		$errorString:=SMTP_ErrorCheck ("SMTP_From";SMTP_From ($smtp_ID;$userName))
	End if 
End if 

If ($errorString="")
	If (vtMAIL_address#"")
		$errorString:=SMTP_ErrorCheck ("SMTP_ReplyTo";SMTP_ReplyTo ($smtp_ID;$schooltrackUser+" <"+vtMAIL_address+">"))
	Else 
		$genericMailAccount:=vtWS_ftpLoginName+"@colegium.com"
		$errorString:=SMTP_ErrorCheck ("SMTP_ReplyTo";SMTP_ReplyTo ($smtp_ID;$schooltrackUser+" <"+$genericMailAccount+">"))
	End if 
End if 


If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Subject";SMTP_Subject ($smtp_ID;_O_Mac to ISO:C519(vtEM4D_subject)))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($smtp_ID;_O_Mac to ISO:C519(vtEM4D_Body)))
End if 

If ($errorString="")
	$mailAddresses:=ST_CountWords (vtEM4D_To;1;";")
	For ($i;1;$mailAddresses)
		$mailbox:=ST_GetWord (vtEM4D_To;$i;";")
		$errorString:=SMTP_ErrorCheck ("SMTP_to";SMTP_To ($smtp_ID;$mailbox))
		If ($errorString#"")
			$i:=$mailAddresses+1
		End if 
	End for 
	$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_To ($smtp_ID;vtEM4D_To))
End if 

$mailAddresses:=ST_CountWords (vtEM4D_CC;1;";")
For ($i;1;$mailAddresses)
	$mailbox:=ST_GetWord (vtEM4D_CC;$i;";")
	$errorString:=SMTP_ErrorCheck ("SMTP_Cc";SMTP_Cc ($smtp_ID;$mailbox))
	If ($errorString#"")
		$i:=$mailAddresses+1
	End if 
End for 

$mailAddresses:=ST_CountWords (vtEM4D_BCC;1;";")
For ($i;1;$mailAddresses)
	$mailbox:=ST_GetWord (vtEM4D_BCC;$i;";")
	$errorString:=SMTP_ErrorCheck ("SMTP_BCc";SMTP_Bcc ($smtp_ID;$mailbox))
	If ($errorString#"")
		$i:=$mailAddresses+1
	End if 
End for 
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_BCc";SMTP_Bcc ($smtp_ID;"mailschoolnet@colegium.com"))
End if 

For ($i;1;Size of array:C274(atEM4D_Attachments))
	$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;atEM4D_Attachments_PATHS{$i};1))
End for 

  //si ahora todas las partes del mail fueron creadas bien . lo mando
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Send";SMTP_Send ($smtp_ID))
	$ignore:=SMTP_ErrorCheck ("SMTP_Clear";SMTP_Clear ($smtp_ID))
	vtSMTP_LastError:=""
Else 
End if 

IT_UThermometer (-2;$pID)