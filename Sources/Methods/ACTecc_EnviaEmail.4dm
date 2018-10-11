//%attributes = {}
  //ACTecc_EnviaEmail
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_semaforo)
C_LONGINT:C283($i;$l_idAp;$l_idModeloInforme)
C_TIME:C306($refXMLDoc)
C_TEXT:C284($domaine;$folderPDF;$t_idAp;$t_mailCC;$t_mailCCO;$t_mailFrom;$t_mailReplayTo;$t_mailSubject;$t_nombreAC;$t_rutaCartasCobranzaSNT)
C_TEXT:C284($t_textoBase64;$t_textoCuerpo;$vt_FileName;$vt_obs)

ARRAY TEXT:C222($aDocuments;0)
ARRAY TEXT:C222($tempTextArray;0)

If (False:C215)
	C_TEXT:C284(ACTecc_EnviaEmail ;$1)
	C_LONGINT:C283(ACTecc_EnviaEmail ;$2)
End if 
TRACE:C157


$b_semaforo:=Semaphore:C143("EnvioPDFCartaCXEmail")

ACTecc_OpcionesGenerales ("InicializaVariables")

READ ONLY:C145([Personas:7])

$t_nombreAC:=$1
$l_idModeloInforme:=$2

$t_mailCC:=""
$t_mailCCO:=SMTP_VerifyEmailAddress (vtACTecc_CopiaOculta;False:C215)
$t_mailReplayTo:=SMTP_VerifyEmailAddress (vtACTecc_ResponderA;False:C215)
$t_mailSubject:=vtACTecc_Asunto
$t_mailFrom:=ST_Qte (Substring:C12(<>gCustom;1;30))+"<AccountTrack@colegium.com>"

ACTinit_LoadPrefs 
If (SYS_IsWindows )
	$error:=sys_GetNetworkInfo ($networkInfo)
	AT_Text2Array (->$tempTextArray;$networkInfo;",")
	$domaine:=$tempTextArray{2}
Else 
	$domaine:=""
End if 
$userName:=Current system user:C484
$machineName:=Current machine:C483

  // Modificado por: Saúl Ponce (20-02-2017) - Ticket Nº 175361 cambio hacia la ruta donde se generaron los archivos
  //$t_rutaCartasCobranzaSNT:=SYS_CarpetaAplicacion (CLG_Intercambios_ACT)+"CartasCobranzaPDF4SN"+SYS_FolderDelimiterOnServer 
$t_rutaCartasCobranzaSNT:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"ACT"+SYS_FolderDelimiterOnServer +"CartasCobranzaPDF"+SYS_FolderDelimiterOnServer 
If (Test path name:C476($t_rutaCartasCobranzaSNT)=Is a folder:K24:2)
	DOCUMENT LIST:C474($t_rutaCartasCobranzaSNT;$aDocuments;Absolute path:K24:14)
	
	If (Size of array:C274($aDocuments)>0)
		LOG_RegisterEvt ("Inicio proceso de envío de "+String:C10(Size of array:C274($aDocuments))+" Cartas de Cobranza por e-mail")
		
		$currentErrorHandler:=SN3_SetErrorHandler ("set")
		vb_ModoEnvio:=True:C214  //requerido por SN3_BuildFileHeader
		$vt_FileName:=SN3_CreateFile2Send ("crear";"";5005;"sax";->$refXMLDoc)
		SN3_BuildFileHeader ($refXMLDoc;5005;"templeta";False:C215;True:C214)
		SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;"AC"+"."+<>gRolBD+"."+ST_Uppercase (<>vtXS_CountryCode)+".html")
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		SAX_CreateNode ($refXMLDoc;"correos")
		
		CD_THERMOMETREXSEC (1;0;__ ("Enviando cartas de cobranza por correo electrónico…"))
		For ($i;1;Size of array:C274($aDocuments))
			$t_nombrePDF:=SYS_Path2FileName ($aDocuments{$i})
			
			If (ST_CountWords ($t_nombrePDF;0;"_")=2)
				$t_idAp:=ST_GetWord ($t_nombrePDF;2;"_")
				$t_idAp:=ST_GetWord ($t_idAp;2;".")
				$l_idAp:=Num:C11($t_idAp)
				  //$l_idAp:=Num(ST_GetWord ($aDocuments{$i};2;"_"))
				
				QUERY:C277([Personas:7];[Personas:7]No:1=$l_idAp)
				If (Records in selection:C76([Personas:7])=1)
					$mailAddress:=[Personas:7]eMail:34
					
					If (($userName="aBachler") | ($userName="Jaime") | ($machineName="Colegium-@") | ($domaine="lester.colegium.com") | ($machineName="U2") | (Not:C34(Is compiled mode:C492)))
						If (Position:C15("@colegium.com";$mailAddress)>0)
							$t_mailCC:="rcatalan@colegium.com"
						Else 
							$mailAddress:="rcatalan@colegium.com"
						End if 
						$body:=$machineName+", "+$userName+". Base: "+SYS_GetDataPath +"\r\r"+$body
					End if 
					$userName:="appSchoolTrack@colegium.com"
					$password:="quasimodo"
					
					ACTecc_OpcionesGenerales ("ProcesaTextoCuerpo";->$t_textoCuerpo;->$l_idAp)
					
					If (SMTP_VerifyEmailAddress ($mailAddress;False:C215)#"")
						$err:=""
						
						$t_textoCuerpo:=Replace string:C233($t_textoCuerpo;"\r";"<br />")
						SAX_CreateNode ($refXMLDoc;"correo")
						SAX_CreateNode ($refXMLDoc;"nombre_colegio";True:C214;<>gCustom;True:C214)
						SAX_CreateNode ($refXMLDoc;"de";True:C214;$t_mailFrom;True:C214)
						SAX_CreateNode ($refXMLDoc;"para";True:C214;$mailAddress;True:C214)
						SAX_CreateNode ($refXMLDoc;"cc";True:C214;$t_mailCC;True:C214)
						SAX_CreateNode ($refXMLDoc;"cco";True:C214;$t_mailCCO;True:C214)
						SAX_CreateNode ($refXMLDoc;"replyto";True:C214;$t_mailReplayTo;True:C214)
						SAX_CreateNode ($refXMLDoc;"asunto";True:C214;$t_mailSubject;True:C214)
						SAX_CreateNode ($refXMLDoc;"cuerpo";True:C214;$t_textoCuerpo;True:C214)
						SAX_CreateNode ($refXMLDoc;"adjuntos")
						SAX_CreateNode ($refXMLDoc;"adjunto")
						$nombre:=$t_nombrePDF
						$nombre:=ST_GetWord ($nombre;2;"_")
						$nombre:=<>vtXS_CountryCode+"."+<>gRolBD+"."+$nombre
						SAX_CreateNode ($refXMLDoc;"nombre";True:C214;$nombre;True:C214)
						DOCUMENT TO BLOB:C525($aDocuments{$i};$x_blob)
						BASE64 ENCODE:C895($x_blob;$t_textoBase64)
						SAX_CreateNode ($refXMLDoc;"contenido";True:C214;$t_textoBase64;True:C214)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						
						DELETE DOCUMENT:C159($aDocuments{$i})
						
						If (cs_ACTecc_RegistrarObs=1)
							  //$vt_obs:="Envío de carta de cobranza por correo electrónico. Modelo de informe utilizado: "+atACTecc_Informes{atACTecc_Informes}+" id: "+String(alACTecc_Informes{atACTecc_Informes})
							  //20140417 RCH Para no perder el modelo
							$vt_obs:="Envío de carta de cobranza por correo electrónico a la casilla: "+$mailAddress+". Modelo de informe utilizado: "+$t_nombreAC+" id: "+String:C10($l_idModeloInforme)+"."
							ACTpp_CreateObs ($l_idAp;$vt_obs;Current date:C33(*))
						End if 
					End if 
				Else 
					  //no se encuentra el apdo
				End if 
			Else 
				  //no tiene formato correcto el nombre del archivo
			End if 
			CD_THERMOMETREXSEC (0;$i/Size of array:C274($aDocuments)*100)
		End for 
		CD_THERMOMETREXSEC (-1)
		
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
		
		TRACE:C157
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
		
		LOG_RegisterEvt ("Término de proceso de envío de "+String:C10(Size of array:C274($aDocuments))+" Cartas de Cobranza por e-mail")
	End if 
	
	CLEAR SEMAPHORE:C144("EnvioPDFCartaCXEmail")
	ACTecc_OpcionesGenerales ("DeclaraVariables")
End if 