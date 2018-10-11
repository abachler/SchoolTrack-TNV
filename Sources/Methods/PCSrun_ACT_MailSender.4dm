//%attributes = {}
  //PCSrun_ACT_MailSender
TRACE:C157

$b_semaforo:=Semaphore:C143("EnvioPDFAvisoXEmail")  //20130905 RCH Para no iniciar 2 procesos a la vez

ACTinit_LoadPrefs 
SN3_LoadGeneralSettings 
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

C_LONGINT:C283($b_enviarAC;$b_enviarAA;$b_enviarAmbos)
C_TEXT:C284($t_mailApodAcad;$t_mailApodCta)

ARRAY TEXT:C222($at_archivos2Enviar;0)
ARRAY TEXT:C222($aDocuments;0)
ARRAY TEXT:C222($aDocuments2;0)
C_LONGINT:C283($l_AC2incluir;$l_ACIncluidos)

$l_enviarAC:=$1
$l_enviarAA:=$2
$l_enviarResponsable:=$3

If (($l_enviarAC=0) & ($l_enviarAA=0) & ($l_enviarResponsable=0))  // si no tienen marcada o tienen marcada mas de una
	$l_enviarAC:=1
End if 

$sn:=LICENCIA_esModuloAutorizado (1;SchoolNet)

$t_rutaCarpetaPDF_mail:=SYS_CarpetaAplicacion (CLG_Intercambios_ACT)+"AvisosPorEnviar"+SYS_FolderDelimiterOnServer 
SYS_CreateFolder ($t_rutaCarpetaPDF_mail)
ARRAY TEXT:C222($aDocuments;0)
DOCUMENT LIST:C474($t_rutaCarpetaPDF_mail;$aDocuments)

  //20120102 RCH Para saber que el proceso comienza.
If (Size of array:C274($aDocuments)>0)
	LOG_RegisterEvt ("Inicio proceso de envío de "+String:C10(Size of array:C274($aDocuments))+" Avisos de Cobranza por e-mail")
	
	ARRAY TEXT:C222($aDocuments2;0)
	COPY ARRAY:C226($aDocuments;$aDocuments2)
	$l_AC2incluir:=50  //maximo de AC incluidos por envio
	
	While (Size of array:C274($aDocuments2)>0)
		$l_ACIncluidos:=0
		If ($sn)
			COPY ARRAY:C226($aDocuments2;$aDocuments)
			If (Size of array:C274($aDocuments)>$l_AC2incluir)
				AT_RedimArrays ($l_AC2incluir;->$aDocuments)  // se redimensiona arreglo solo si tamaño es mayor al máximo
			End if 
			AT_Delete (1;$l_AC2incluir;->$aDocuments2)  // se eliminan del arreglo base los elementos que se procesarán en este ciclo
		Else 
			AT_Initialize (->$aDocuments2)  //si no se usa SN, solo se pasa una vez
		End if 
		
		If ($sn)
			$currentErrorHandler:=SN3_SetErrorHandler ("set")
			C_TIME:C306($refXMLDoc)
			vb_ModoEnvio:=True:C214  //requerido por SN3_BuildFileHeader
			$vt_FileName:=SN3_CreateFile2Send ("crear";"";5005;"sax";->$refXMLDoc)
			SN3_BuildFileHeader ($refXMLDoc;5005;"templeta";False:C215;True:C214)
			SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;"AC"+"."+<>gRolBD+"."+ST_Uppercase (<>vtXS_CountryCode)+".html")
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			SAX_CreateNode ($refXMLDoc;"correos")
		End if 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Enviando avisos por correo electrónico…"))
		For ($i;1;Size of array:C274($aDocuments))
			If (ST_CountWords ($aDocuments{$i};0;"_")=2)
				$idAviso:=ST_GetWord ($aDocuments{$i};2;"_")
				$idAvisoLong:=Num:C11($idAviso)
				
				$idApdo:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$idAvisoLong;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				$mes:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$idAvisoLong;->[ACT_Avisos_de_Cobranza:124]Mes:6)
				$year:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$idAvisoLong;->[ACT_Avisos_de_Cobranza:124]Agno:7)
				
				$mesStr:=String:C10($mes;"00")
				$yearStr:=String:C10($year;"0000")
				$rnApdo:=Find in field:C653([Personas:7]No:1;$idApdo)
				If ($rnApdo#-1)
					$vt_nombreArchivo:=String:C10($idAvisoLong)+"_"+String:C10($idApdo)+"_"+$mesStr+"_"+$yearStr+".pdf"
					$body:=ACTcfg_OpcionesTextoMail ("ProcesaCuerpoMail";->$vt_nombreArchivo)
					$t_mailApodAcad:=""  //20160303 RCH
					$t_mailApodCta:=""  //20160303 RCH
					$t_mailAddress:=""  //20170712 RCH
					If ($l_enviarAC=1)
						$t_mailAddress:=ACTdte_VerificaEmail (KRL_GetTextFieldData (->[Personas:7]No:1;->$idApdo;->[Personas:7]eMail:34);False:C215)
					End if 
					
					If ($l_enviarAA=1)
						READ ONLY:C145([ACT_Transacciones:178])
						READ ONLY:C145([ACT_CuentasCorrientes:175])
						READ ONLY:C145([Alumnos:2])
						READ ONLY:C145([Personas:7])
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$idAvisoLong)  //20160303 RCH
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
						KRL_RelateSelection (->[Personas:7]No:1;->[Alumnos:2]Apoderado_académico_Número:27;"")
						While (Not:C34(End selection:C36([Personas:7])))
							$t_mailApodAcad:=Choose:C955($t_mailApodAcad="";"";$t_mailApodAcad+";")+ACTdte_VerificaEmail ([Personas:7]eMail:34;False:C215)
							NEXT RECORD:C51([Personas:7])
						End while 
						$t_mailAddress:=Choose:C955($t_mailAddress="";"";$t_mailAddress+";")+$t_mailApodAcad
					End if 
					
					If ($l_enviarResponsable=1)  //20170712 RCH
						C_LONGINT:C283($l_idResp)
						ARRAY LONGINT:C221($alACT_idsApdos;0)
						
						READ ONLY:C145([Personas:7])
						READ ONLY:C145([ACT_Cargos:173])
						READ ONLY:C145([ACT_Transacciones:178])
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$idAvisoLong)
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						QUERY SELECTION BY ATTRIBUTE:C1424([ACT_Cargos:173];[ACT_Cargos:173]OB_Responsable:70;"id_responsable";>;0)
						ACTcc_DividirEmision ("ObtieneIdsResponsablesDesdeCargo";->$alACT_idsApdos)
						For ($l_indiceApdo;1;Size of array:C274($alACT_idsApdos))
							$l_idResp:=$alACT_idsApdos{$l_indiceApdo}
							If ($l_idResp>0)
								QUERY:C277([Personas:7];[Personas:7]No:1=$l_idResp)
								If (Records in selection:C76([Personas:7])>0)
									$t_mailAddress:=Choose:C955($t_mailAddress="";"";$t_mailAddress+";")+ACTdte_VerificaEmail ([Personas:7]eMail:34;False:C215)
								End if 
							End if 
						End for 
					End if 
					
					  //elimina valores duplicados
					ARRAY TEXT:C222($at_direcciones;0)
					AT_Text2Array (->$at_direcciones;$t_mailAddress;";")
					AT_DistinctsArrayValues (->$at_direcciones)
					$t_mailAddress:=AT_array2text (->$at_direcciones;";")
					
					$ccMail:=""
					$ccO:=""
					$ccO:=vtACTmail_CCO  //20131106 RCH
					
					If (($userName="aBachler") | ($userName="Jaime") | ($machineName="Colegium-@") | ($domaine="lester.colegium.com") | ($machineName="U2") | (Not:C34(Is compiled mode:C492)))
						$ccMail:="rcatalan@colegium.com"
						$body:=$machineName+", "+$userName+". Base: "+SYS_GetDataPath +"\r\r"+"Copia oculta a:"+$ccO+"\r\r"+$body
						$ccO:=""
					End if 
					$userName:="appSchoolTrack@colegium.com"
					$password:="quasimodo"
					
					If (ACTdte_VerificaEmail ($t_mailAddress;False:C215)#"")  //20160118 RCH. Ticket 155327
						$from:=ST_Qte (vtACTmail_NombreDe)+"<AccountTrack@colegium.com>"
						$subject:=ST_Boolean2Text ((vtACTmail_AsuntoMail="");"Aviso de Cobranza";vtACTmail_AsuntoMail)
						$replyto:=vtACTmail_ResponderA
						$err:=""
						If ($sn)
							$body:=Replace string:C233($body;"\r";"<br />")
							SAX_CreateNode ($refXMLDoc;"correo")
							SAX_CreateNode ($refXMLDoc;"nombre_colegio";True:C214;<>gCustom;True:C214)
							SAX_CreateNode ($refXMLDoc;"de";True:C214;$from;True:C214)
							SAX_CreateNode ($refXMLDoc;"para";True:C214;$t_mailAddress;True:C214)
							SAX_CreateNode ($refXMLDoc;"cc";True:C214;$ccMail;True:C214)
							SAX_CreateNode ($refXMLDoc;"cco";True:C214;$ccO;True:C214)
							SAX_CreateNode ($refXMLDoc;"replyto";True:C214;$replyto;True:C214)
							SAX_CreateNode ($refXMLDoc;"asunto";True:C214;$subject;True:C214)
							SAX_CreateNode ($refXMLDoc;"cuerpo";True:C214;$body;True:C214)
							SAX_CreateNode ($refXMLDoc;"adjuntos")
							SAX_CreateNode ($refXMLDoc;"adjunto")
							$nombre:=$aDocuments{$i}
							$nombre:=ST_GetWord ($nombre;2;"_")
							$nombre:=<>vtXS_CountryCode+"."+<>gRolBD+"."+$nombre
							SAX_CreateNode ($refXMLDoc;"nombre";True:C214;$nombre;True:C214)
							C_BLOB:C604($blob)
							C_TEXT:C284($text)
							DOCUMENT TO BLOB:C525($t_rutaCarpetaPDF_mail+$aDocuments{$i};$blob)
							BASE64 ENCODE:C895($blob;$text)
							SAX_CreateNode ($refXMLDoc;"contenido";True:C214;$text;True:C214)
							SAX CLOSE XML ELEMENT:C854($refXMLDoc)
							SAX CLOSE XML ELEMENT:C854($refXMLDoc)
							SAX CLOSE XML ELEMENT:C854($refXMLDoc)
							$l_ACIncluidos:=$l_ACIncluidos+1
						Else 
							TRACE:C157
							  // Modificado por: Saúl Ponce (23-05-2018) Ticket Nº 207328 - Nunca se estaba enviando la copia oculta porque el parámetro #11 siempre estaba vacío.
							  //$err:=SMTP_Send_Text ("mail.colegium.com";$from;$t_mailAddress;$subject;$body;$userName;$password;1;$replyto;$ccMail;"";"";$t_rutaCarpetaPDF_mail+$aDocuments{$i})
							$err:=SMTP_Send_Text ("mail.colegium.com";$from;$t_mailAddress;$subject;$body;$userName;$password;1;$replyto;$ccMail;$ccO;"";$t_rutaCarpetaPDF_mail+$aDocuments{$i})
						End if 
						If ($err="")
							DELETE DOCUMENT:C159($t_rutaCarpetaPDF_mail+$aDocuments{$i})  //20180404 RCH Se descomenta línea
						Else 
							LOG_RegisterEvt ("Error en envío de Avisos de Cobranza por eMail. El archivo "+$aDocuments{$i}+" no pudo ser enviado a causa del error: "+$err+".")
						End if 
					Else 
						LOG_RegisterEvt ("No fue encontrado en destinatario de correo válido. El archivo "+$aDocuments{$i}+" no pudo ser enviado y fue eliminado del directorio de envíos.")
						DELETE DOCUMENT:C159($t_rutaCarpetaPDF_mail+$aDocuments{$i})  //20180404 RCH se elimina archivo ya que no puede ser enviado
					End if 
				Else 
					LOG_RegisterEvt ("Aviso para Tercero. El archivo "+$aDocuments{$i}+" no pudo ser enviado y fue eliminado del directorio de envíos.")
					DELETE DOCUMENT:C159($t_rutaCarpetaPDF_mail+$aDocuments{$i})  //20180404 RCH se elimina archivo ya que no puede ser enviado
				End if 
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aDocuments))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		TRACE:C157
		If ($sn)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
			$vt_FileName:=Replace string:C233($vt_FileName;".snt";".zip")
			APPEND TO ARRAY:C911($at_archivos2Enviar;$vt_FileName)
			If ($l_ACIncluidos=0)  //en pruebas habia AC para terceros o apdos sin mail y se generaba un archivo sin AC
				DELETE DOCUMENT:C159($vt_FileName)
			Else 
				$ftpDirectory:="/SchoolFiles3/"
				$ftpConnectionID:=0
				$vt_FileName:=Replace string:C233($vt_FileName;".snt";".zip")
				$filePath:=$vt_FileName
				$hostPath:=$ftpDirectory+SYS_Path2FileName ($vt_FileName)
				$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$filePath;$hostPath;True:C214;->$ftpConnectionID;True:C214)
				If ($errorString#"")
					SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+SYS_Path2FileName ($vt_FileName)+" no pudo ser transferido a causa de un error FTP: "+$errorString)
				Else 
					SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+SYS_Path2FileName ($vt_FileName)+" ha sido transferido exitósamente.")
				End if 
			End if 
			SN3_SetErrorHandler ("clear";$currentErrorHandler)
		End if 
	End while 
	
	If ($sn)
		For ($l_indice;1;Size of array:C274($at_archivos2Enviar))
			If (Test path name:C476($at_archivos2Enviar{$l_indice})=Is a document:K24:1)
				$vt_FileName:=$at_archivos2Enviar{$l_indice}
				$ftpDirectory:="/SchoolFiles3/"
				$ftpConnectionID:=0
				$filePath:=$vt_FileName
				$hostPath:=$ftpDirectory+SYS_Path2FileName ($vt_FileName)
				$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$filePath;$hostPath;True:C214;->$ftpConnectionID;True:C214)
				If ($errorString#"")
					SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+SYS_Path2FileName ($vt_FileName)+" no pudo ser transferido a causa de un error FTP: "+$errorString)
				Else 
					SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+SYS_Path2FileName ($vt_FileName)+" ha sido transferido exitósamente.")
				End if 
			End if 
		End for 
	End if 
	LOG_RegisterEvt ("Término de proceso de envío de "+String:C10(Size of array:C274($aDocuments))+" Avisos de Cobranza por e-mail")
End if 

CLEAR SEMAPHORE:C144("EnvioPDFAvisoXEmail")