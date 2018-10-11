//%attributes = {}
  //ACTepr_EnviaMailPR
READ ONLY:C145([Personas:7])

ARRAY LONGINT:C221(alACTepr_ApoderadoID2Enviar;0)
ARRAY REAL:C219(arACTepr_ApoMontoRechaEnviar;0)
ARRAY TEXT:C222(atACTepr_EmailApoderadoEnviar;0)

C_TEXT:C284($t_TextoCuerpo)
ACTepr_OpcionesGenerales ("DeclaraVariables")
ACTepr_OpcionesGenerales ("InicializaVariables")

TRACE:C157

  //20141029 RCH
  //vt_IdApoderados:=$1
  //vt_MontosRechazados:=$2
  //vt_eMail:=$3
  //
  //AT_Text2Array (->alACTepr_ApoderadoID2Enviar;vt_IdApoderados;"__/__")
  //AT_Text2Array (->arACTepr_ApoMontoRechaEnviar;vt_MontosRechazados;"__/__")
  //AT_Text2Array (->atACTepr_EmailApoderadoEnviar;vt_eMail;"__/__")
C_BLOB:C604($xBlob)
$xBlob:=$1
BLOB_Blob2Vars (->$xBlob;0;->alACTepr_ApoderadoID2Enviar;->arACTepr_ApoMontoRechaEnviar;->atACTepr_EmailApoderadoEnviar)

  // Modificado por: Saul Ponce (26/02/2018) Ticket 136131 
If (Count parameters:C259>=2)
	
	C_OBJECT:C1216($ob_dataArchivo)
	
	C_LONGINT:C283($vl_idModoPago)
	C_BOOLEAN:C305($vb_guardaObsRechazo)
	C_TEXT:C284($vt_fName;$vt_Tipo;$vt_user;$vt_ImpRealDate)
	C_DATE:C307($vd_ImpRealDate)
	
	
	$ob_dataArchivo:=$2
	$vb_guardaObsRechazo:=True:C214
	
	$vt_user:=OB Get:C1224($ob_dataArchivo;"usuario")
	$vt_Tipo:=OB Get:C1224($ob_dataArchivo;"tipoArchivo")
	$vt_fName:=OB Get:C1224($ob_dataArchivo;"nombreArchivo")
	$vl_idModoPago:=OB Get:C1224($ob_dataArchivo;"modoPago")
	$vt_ImpRealDate:=OB Get:C1224($ob_dataArchivo;"fechaReal")
	$vd_ImpRealDate:=Date:C102($vt_ImpRealDate)
	
End if 

$ccMail:=""
$ccO:=SMTP_VerifyEmailAddress (vtACTepr_CopiaOculta;False:C215)
$replyto:=SMTP_VerifyEmailAddress (vtACTepr_ResponderA;False:C215)
$subject:=vtACTepr_Asunto
$from:=ST_Qte (Substring:C12(<>gCustom;1;30))+"<AccountTrack@colegium.com>"

If (SYS_IsWindows )
	ARRAY TEXT:C222($tempTextArray;0)
	$error:=sys_GetNetworkInfo ($networkInfo)
	AT_Text2Array (->$tempTextArray;$networkInfo;",")
	$domaine:=$tempTextArray{2}
Else 
	$domaine:=""
End if 
$userName:=Current system user:C484
$machineName:=Current machine:C483

If (Size of array:C274(alACTepr_ApoderadoID2Enviar)>0)
	LOG_RegisterEvt ("Inicio proceso de envío de Pago automático rechazado por e-mail")
	
	$currentErrorHandler:=SN3_SetErrorHandler ("set")
	vb_ModoEnvio:=True:C214  //requerido por SN3_BuildFileHeader
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";5005;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;5005;"templeta";False:C215;True:C214)
	SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;"AC"+"."+<>gRolBD+"."+ST_Uppercase (<>vtXS_CountryCode)+".html")
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	SAX_CreateNode ($refXMLDoc;"correos")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Enviando cartas de cobranza por correo electrónico…"))
	For ($i;1;Size of array:C274(alACTepr_ApoderadoID2Enviar))
		QUERY:C277([Personas:7];[Personas:7]No:1=alACTepr_ApoderadoID2Enviar{$i})
		
		$t_textoCuerpo:=vtACTepr_Cuerpo
		$mailAddress:=atACTepr_EmailApoderadoEnviar{$i}
		$userName:="appSchoolTrack@colegium.com"
		$password:="quasimodo"
		
		ACTepr_OpcionesGenerales ("ProcesaTextoCuerpo";->$t_textoCuerpo;->alACTepr_ApoderadoID2Enviar{$i};->arACTepr_ApoMontoRechaEnviar{$i})
		If (SMTP_VerifyEmailAddress ($mailAddress;False:C215)#"")
			$t_textoCuerpo:=Replace string:C233($t_textoCuerpo;"\r";"<br />")
			SAX_CreateNode ($refXMLDoc;"correo")
			SAX_CreateNode ($refXMLDoc;"nombre_colegio";True:C214;<>gCustom;True:C214)
			SAX_CreateNode ($refXMLDoc;"de";True:C214;$from;True:C214)
			SAX_CreateNode ($refXMLDoc;"para";True:C214;$mailAddress;True:C214)
			SAX_CreateNode ($refXMLDoc;"cc";True:C214;$ccMail;True:C214)
			SAX_CreateNode ($refXMLDoc;"cco";True:C214;$ccO;True:C214)
			SAX_CreateNode ($refXMLDoc;"replyto";True:C214;$replyto;True:C214)
			SAX_CreateNode ($refXMLDoc;"asunto";True:C214;$subject;True:C214)
			SAX_CreateNode ($refXMLDoc;"cuerpo";True:C214;$t_textoCuerpo;True:C214)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			  // Modificado por: Saul Ponce (26/02/2018) Ticket 136131 crear la observación que se guarda en el apoderado
			If ($vb_guardaObsRechazo)
				C_TEXT:C284($vt_obs)
				$vt_obs:="Envío de carta de rechazo por correo electrónico a la casilla: "+$mailAddress+". E-mail generado en el proceso de importación de pagos de tipo: "
				$vt_obs:=$vt_obs+$vt_Tipo+" ("+String:C10($vl_idModoPago)+") iniciado el: "+$vt_ImpRealDate+". El archivo importado fue: "
				$vt_obs:=$vt_obs+$vt_fName+" utilizado por el usuario "+$vt_user+", en el equipo "+$machineName+"."
				ACTpp_CreateObs ([Personas:7]No:1;$vt_obs;$vd_ImpRealDate)
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACTepr_ApoderadoID2Enviar))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	
	$ftpDirectory:="/SchoolFiles3/"
	$ftpConnectionID:=0
	$vt_FileName:=Replace string:C233($vt_FileName;".snt";".zip")
	$filePath:=$vt_FileName
	$hostPath:=$ftpDirectory+SYS_Path2FileName ($vt_FileName)
	SN3_LoadGeneralSettings 
	$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$filePath;$hostPath;True:C214;->$ftpConnectionID;True:C214)
	If ($errorString#"")
		SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+SYS_Path2FileName ($vt_FileName)+" no pudo ser transferido a causa de un error FTP: "+$errorString)
	Else 
		SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+SYS_Path2FileName ($vt_FileName)+" ha sido transferido exitósamente.")
	End if 
	SN3_SetErrorHandler ("clear";$currentErrorHandler)
	
	LOG_RegisterEvt ("Término de proceso de envío de Pago automático rechazado por e-mail")
	
End if 

