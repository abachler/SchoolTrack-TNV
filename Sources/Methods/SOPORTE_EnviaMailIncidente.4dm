//%attributes = {}
  //SOPORTE_EnviaMailIncidente
  //Modifcado por ABK, 17/07/2008, 12:23:04
  //Cambié el argumento $1 para recibir una lista separada por comas con direcciones de correo adicionales
  //Todos los llamados a este método fueron modificados 
  //20180619 RCH Se quitan mac to iso y se deja la codificación utf-8

C_TEXT:C284($errorString)
C_TEXT:C284($msg)
C_LONGINT:C283($i;$0)
C_BLOB:C604($blob1;$4;$blob2;$4;$blob3;$4)
C_TEXT:C284($1;$2;$3;$copyTo;$msg;$tipoSolicitud)

$copyTO:=$1
$msg:=$2
$tipoSolicitud:="D"

Case of 
	: (Count parameters:C259=6)
		$blob3:=$5
		$blob2:=$5
		$blob1:=$4
		$tipoSolicitud:=$3
	: (Count parameters:C259=5)
		$blob2:=$5
		$blob1:=$4
		$tipoSolicitud:=$3
	: (Count parameters:C259=4)
		$blob1:=$4
		$tipoSolicitud:=$3
	: (Count parameters:C259=3)
		$tipoSolicitud:=$3
End case 

If ($tipoSolicitud="D")
	$categoriaDefecto:="Cierre o bloqueo"  //aunque no se produzca el cierre o bloqueo, como es un defecto reportado automaticamente por SchoolTrack  se registra así para darle máxima urgencia
Else 
	$categoriaDefecto:=""
End if 



  //If (◊tUSR_CurrentUserName#"")
vtEM4D_To:="incidentes_schooltrack@colegium.com"

$OS:=SYS_GetOS 
$appVersion:=SYS_LeeVersionEstructura 
$schooltrackUser:=<>tUSR_CurrentUserName
$schooltrackUserID:=String:C10(<>lUSR_RelatedTableUserID)
$userName:="appSchoolTrack@colegium.com"
$password:="quasimodo"

$pID:=IT_UThermometer (1;0;__ ("Enviando notificación al departamento técnico de Colegium...");-1)

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
	vtTS_EventID:="NEW"
	  //$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($smtp_ID;"Content-Type:";"text/plain;charset=iso-8859-1";0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($smtp_ID;"Content-Type:";"text/plain;charset=utf-8";0))  //20180619 RCH Se quitan mac to iso y se deja utf-8
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventUSERNAME:";$schooltrackUser;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventUSERID:";$schooltrackUserID;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventEMAIL:";<>tUSR_CurrentUserEmail;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventDOCTYPE:";"TSevent";0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventSCHOOLCODE:";<>gRolBd;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventCOUNTRYCODE:";<>vtXS_CountryCode;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventID:";vtTS_EventID;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventAPP:";vsBWR_CurrentModule;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventTIPO:";$tipoSolicitud;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventCAT:";$categoriaDefecto;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventOS:";$os;0))
	$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventVERS:";$appVersion;0))
	If (Application type:C494=4D Remote mode:K5:5)
		$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventAPPTYPE:";"Cliente/Servidor";0))
	Else 
		$errorString:=SMTP_ErrorCheck ("SMTP_AddHeader";SMTP_AddHeader ($SMTP_ID;"X-SchoolTrackEventAPPTYPE:";"Monousuario";0))
	End if 
	$errorString:=SMTP_ErrorCheck ("SMTP_Comments";SMTP_Comments ($SMTP_ID;"Enviado desde SchoolTrack"))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Auth";SMTP_Auth ($smtp_ID;$userName;$password;1))
End if 

If ($errorString="")
	$mailAddress:="appSchoolTrack@colegium.com"
	$errorString:=SMTP_ErrorCheck ("SMTP_From";SMTP_From ($smtp_ID;$mailAddress))
End if 

If ($errorString="")
	  //$errorString:=SMTP_ErrorCheck ("SMTP_ReplyTo";SMTP_ReplyTo ($smtp_ID;Mac to ISO($schooltrackUser)+" <"+◊tUSR_CurrentUserEmail+">"))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Subject";SMTP_Subject ($smtp_ID;SMTP_EncodeSubject ("[SchoolTrack] Reporte de Ticket")))
End if 

If ($errorString="")
	vtEM4D_Body:="COLEGIO: "+<>gCustom
	vtEM4D_Body:=vtEM4D_Body+"\r"+"ROLBD "+<>gRolBD
	vtEM4D_Body:=vtEM4D_Body+"\r"+"PAIS: "+<>gPais
	vtEM4D_Body:=vtEM4D_Body+"\r"+"MODULO: "+vsBWR_CurrentModule
	vtEM4D_Body:=vtEM4D_Body+"\r"+"PROBLEMA DETECTADO:\r"+$msg
	$errorString:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($smtp_ID;vtEM4D_Body))
End if 

If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_To ($smtp_ID;vtEM4D_To))
	$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;vtEM4D_To))
	If ($copyTO#"")
		$number:=ST_CountWords ($copyTO;1;",")
		For ($i;1;$number)
			$emailAdress:=ST_GetWord ($copyTO;$i;",")
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;$emailAdress))
		End for 
	End if 
	Case of 
		: ((vsBWR_CurrentModule="SchoolTrack") | (vsBWR_CurrentModule="MediaTrack") | (vsBWR_CurrentModule=""))
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;"abachler@colegium.com"))
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;"desarrollo@colegium.com"))
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;"qa@colegium.com"))
		: ((vsBWR_CurrentModule="AccountTrack") | (vsBWR_CurrentModule="AdmissionTrack"))
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;"jherreros@colegium.com"))
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;"desarrollo@colegium.com"))
			$errorString:=SMTP_ErrorCheck ("SMTP_To";SMTP_Cc ($smtp_ID;"qa@colegium.com"))
	End case 
End if 


If (BLOB size:C605($blob1)>0)
	$ref:=Create document:C266("Adjunto"+String:C10($i)+".txt")
	CLOSE DOCUMENT:C267($ref)
	BLOB TO DOCUMENT:C526(document;$blob1)
	$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;document;0))
	
	DELETE DOCUMENT:C159(document)  //20170609 RCH
End if 

If (BLOB size:C605($blob2)>0)
	$ref:=Create document:C266("Adjunto"+String:C10($i)+".txt")
	CLOSE DOCUMENT:C267($ref)
	BLOB TO DOCUMENT:C526(document;$blob2)
	$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;document;0))
	
	DELETE DOCUMENT:C159(document)  //20170609 RCH
End if 

If (BLOB size:C605($blob3)>0)
	$ref:=Create document:C266("Adjunto"+String:C10($i)+".txt")
	CLOSE DOCUMENT:C267($ref)
	BLOB TO DOCUMENT:C526(document;$blob3)
	$errorString:=SMTP_ErrorCheck ("SMTP_Attachment";SMTP_Attachment ($smtp_ID;document;0))
	
	DELETE DOCUMENT:C159(document)  //20170609 RCH
End if 


  //si ahora todas las partes del mail fueron creadas bien . lo mando
If ($errorString="")
	$errorString:=SMTP_ErrorCheck ("SMTP_Send";SMTP_Send ($smtp_ID))
	$ignore:=SMTP_ErrorCheck ("SMTP_Clear";SMTP_Clear ($smtp_ID))
	vtSMTP_LastError:=""
Else 
End if 

  //If (BLOB size(vx_Blob)>0) //Se mueve al if de creación de cada archivo.
  //DELETE DOCUMENT(document)
  //End if 

IT_UThermometer (-2;$pID)


If ($errorString#"")
	$0:=0
Else 
	$0:=1
End if 
  //End if 