//%attributes = {}
TRACE:C157
  //ACTdte_enviaPDFXMail
C_LONGINT:C283($l_idBoleta;$1;$l_proc)
C_BOOLEAN:C305($b_hecho;$0)
C_TEXT:C284($t_obsDocTrib)
C_POINTER:C301($3;$y_pointer1)
C_BOOLEAN:C305($b_Error)
C_TEXT:C284($t_dirCCO)
C_TEXT:C284($vtACTdte_ResponderA)
C_BOOLEAN:C305($b_ambienteCertificacion;$b_probarEnvio)  //20160609 RCH Se agregan validaciones

$b_ambienteCertificacion:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=1)
$b_probarEnvio:=(Num:C11(PREF_fGet (0;"ACT_PROBAR_ENVIO_MAIL_DTE";"0"))=1)
  //If ((Not($b_ambienteCertificacion)) | ($b_probarEnvio))

  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilité UY en la comparación
  // If ((Not($b_ambienteCertificacion)) | ($b_probarEnvio) | (<>gCountryCode="ar"))  //20160728 RCH Factura AR
If ((Not:C34($b_ambienteCertificacion)) | ($b_probarEnvio) | (<>gCountryCode="ar") | (<>gCountryCode="uy"))
	
	$userName:="appSchoolTrack@colegium.com"
	$password:="quasimodo"
	$body:=""
	$ccMail:=""
	ACTdte_EnvioPDFXMail ("InicializaVariables")
	
	ACTdte_OpcionesManeja ("LeeBlob")
	
	$l_idBoleta:=$1
	If (Count parameters:C259>=2)
		$l_proc:=$2
	End if 
	If (Count parameters:C259>=3)
		$y_pointer1:=$3
	End if 
	
	READ ONLY:C145([ACT_Boletas:181])
	READ ONLY:C145([ACT_Terceros:138])
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_RazonesSociales:279])
	
	KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta)
	
	KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
	KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25)
	KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
	
	ACTcfg_LeeConfRS ([ACT_Boletas:181]ID_RazonSocial:25)  //20170109 RCH
	
	If ($l_proc=0)
		$l_proceso:=IT_UThermometer (1;0;"")
	Else 
		$l_proceso:=$l_proc
	End if 
	
	$t_tipoArchivo:=[ACT_Boletas:181]codigo_SII:33
	$r_folio:=[ACT_Boletas:181]Numero:11
	
	If (([Personas:7]ACT_DTE_Enviar_Mail:110) | ([ACT_Terceros:138]DTE_enviar_por_mail:74))
		If (([Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111#"") | ([ACT_Terceros:138]DTE_email_envio_dte:75#""))
			
			IT_UThermometer (0;$l_proceso;"Enviando documento número "+String:C10([ACT_Boletas:181]Numero:11)+"...")
			
			$from:=ST_Qte (Substring:C12([ACT_RazonesSociales:279]razon_social:2;1;40))+"<AccountTrack@colegium.com>"
			
			If ([ACT_Boletas:181]ID_Tercero:21#0)
				$mailAddress:=[ACT_Terceros:138]DTE_email_envio_dte:75
			Else 
				$mailAddress:=[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111
			End if 
			
			  //$subject:="Envio DTE "+<>atXS_MonthNames{Month of([ACT_Boletas]FechaEmision)}+" "+String(Year of([ACT_Boletas]FechaEmision))+" No"+String([ACT_Boletas]Numero)
			$subject:=vtACTdte_Asunto
			ACTdte_EnvioPDFXMail ("ProcesaTexto";->$subject;->[ACT_Boletas:181]ID:1)
			
			$body:=vtACTdte_Cuerpo
			ACTdte_EnvioPDFXMail ("ProcesaTexto";->$body;->[ACT_Boletas:181]ID:1)
			
			ARRAY TEXT:C222($at_smtpTo;0)
			AT_Text2Array (->$at_smtpTo;$mailAddress;";")
			
			$b_continuar:=False:C215
			$t_dir:=""
			For ($l_indiceMail;1;Size of array:C274($at_smtpTo))
				If (SMTP_VerifyEmailAddress ($at_smtpTo{$l_indiceMail};False:C215)#"")
					$t_dir:=Choose:C955($t_dir="";"";$t_dir+";")+$at_smtpTo{$l_indiceMail}
					$b_continuar:=True:C214
				End if 
			End for 
			
			$t_dirCCO:=""
			If (vtACTdte_CopiaOculta#"")
				ARRAY TEXT:C222($at_smtpCCO;0)
				AT_Text2Array (->$at_smtpCCO;vtACTdte_CopiaOculta;";")
				$b_continuar:=False:C215
				For ($l_indiceMail;1;Size of array:C274($at_smtpCCO))
					If (SMTP_VerifyEmailAddress ($at_smtpCCO{$l_indiceMail};False:C215)#"")
						$t_dirCCO:=Choose:C955($t_dirCCO="";"";$t_dirCCO+";")+$at_smtpCCO{$l_indiceMail}
						$b_continuar:=True:C214
					End if 
				End for 
			End if 
			
			$vtACTdte_ResponderA:=""
			If (vtACTdte_ResponderA#"")
				ARRAY TEXT:C222($at_smtpReply;0)
				AT_Text2Array (->$at_smtpReply;vtACTdte_ResponderA;";")
				$b_continuar:=False:C215
				For ($l_indiceMail;1;Size of array:C274($at_smtpReply))
					If (SMTP_VerifyEmailAddress ($at_smtpReply{$l_indiceMail};False:C215)#"")
						$vtACTdte_ResponderA:=Choose:C955($vtACTdte_ResponderA="";"";$vtACTdte_ResponderA+";")+$at_smtpReply{$l_indiceMail}
						$b_continuar:=True:C214
					End if 
				End for 
			End if 
			
			If ($b_continuar)
				  //obtiene path al pdf
				
				$t_rutEmisor:=[ACT_RazonesSociales:279]RUT:3
				  //20170109 RCH
				
				  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilité UY en la comparación
				  // If (<>gCountryCode="ar")
				If ((<>gCountryCode="ar") | (<>gCountryCode="uy"))
					If ($t_rutEmisor="")
						$t_rutEmisor:=vtACT_CUIT
					End if 
				End if 
				$t_tipoDocumento:="pdf"
				If (<>gCountryCode="cl")
					$b_cedible2:=(r_obtieneCopiaCedible=1)
				Else 
					$b_cedible2:=False:C215
				End if 
				$d_fechaEmision:=[ACT_Boletas:181]FechaEmision:3
				$t_tipoArchivo:=[ACT_Boletas:181]codigo_SII:33
				$t_tipo:=[ACT_Boletas:181]codigo_SII:33+":"+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->[ACT_Boletas:181]codigo_SII:33)
				$r_folio:=[ACT_Boletas:181]Numero:11
				$t_archivo:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible2;->$d_fechaEmision;->$t_tipo;->$r_folio)
				
			End if 
			
			  //TRACE
			If ($b_continuar)
				
				$go:=False:C215  //para CL se valida que exista el PDF
				  //si el documento no ha sido descargado, se intenta descargar antes de hacer el envio
				If (Test path name:C476($t_archivo)#Is a document:K24:1)
					TRACE:C157
					Case of 
							  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilité UY en la comparación
							  // : (<>gCountryCode="ar")
						: (<>gCountryCode="ar") | (<>gCountryCode="uy")
							  //Imprime PDF
							If (alACTbol_Informes{atACTbol_Informes}#-1)
								READ ONLY:C145([xShell_Reports:54])
								QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ID:7=alACTbol_Informes{atACTbol_Informes})
								
								If (Records in selection:C76([xShell_Reports:54])>=1)
									
									KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta)
									  //COPY NAMED SELECTION([ACT_Boletas];"◊Editions")
									CUT NAMED SELECTION:C334([ACT_Boletas:181];"◊Editions")  //20170315 RCH La selección se crea con CUT
									
									$r_recNumReporte:=Record number:C243([xShell_Reports:54])
									ARRAY TEXT:C222($aFiles;0)
									$t_folderPDF:=SYS_GetFolderNam ($t_archivo)
									SYS_CreateFolder ($t_folderPDF)
									  //QR_PrintSuperReport($r_recNumReporte;False;6;vpXS_IconModule;vsBWR_CurrentModule;False;True;False;->$aFiles;->[ACT_Boletas]ID;$t_folderPDF;$t_archivo)
									TRACE:C157  //probar y reimplementar
									$t_destinoImpresion:="pdf"
									  //$t_expresionNombreDocumento:="string([Personas]No)"
									ARRAY TEXT:C222($at_rutaDocumentos;0)
									  // Modificado por: Saúl Ponce (18-04-2017) Ticket 168412, el recNum del reporte estaba en cero.
									  // QR_ImprimeInformeSRP ($r_reportRecNum;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento;->$at_rutaDocumentos)
									QR_ImprimeInformeSRP ($r_recNumReporte;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento;->$at_rutaDocumentos)
									If (Size of array:C274($at_rutaDocumentos)>0)
										  // Modificado por: Saúl Ponce (18-04-2017) Ticket 168412, copio la ruta para encontrar el documento PDF más abajo
										  // COPY DOCUMENT($at_rutaDocumentos{1};$t_archivo)
										$t_archivo:=$at_rutaDocumentos{1}
									End if 
									
									If (Test path name:C476($t_archivo)=Is a document:K24:1)
										$go:=True:C214
									End if 
								End if 
							End if 
						Else 
							ACTdteEmi_ObtienePDF ($t_rutEmisor;$t_tipoArchivo;$r_folio;$b_cedible2;$t_archivo;$t_tipoDocumento)
					End case 
				End if 
				
				If ((Test path name:C476($t_archivo)=Is a document:K24:1) | ($go))
					TRACE:C157
					$b_hecho:=True:C214  //se considera hecho. Si hay error se registra en el log
					$err:=SMTP_Send_Text ("mail.colegium.com";$from;$t_dir;$subject;$body;$userName;$password;1;$vtACTdte_ResponderA;$ccMail;$t_dirCCO;"";$t_archivo)
					If ($err="")
						C_TEXT:C284($t_observacion)
						$t_observacion:="Documento tributario tipo: "+$t_tipoArchivo+", folio: "+String:C10($r_folio)+" enviado al receptor "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)+", a la cuenta "+$t_dir+"."
						LOG_RegisterEvt ($t_observacion)
						
						If (cs_ACTdte_RegistrarObs=1)
							If ([ACT_Boletas:181]ID_Apoderado:14#0)
								ACTpp_CreateObs ([ACT_Boletas:181]ID_Apoderado:14;$t_observacion;Current date:C33(*))
							End if 
						End if 
						$t_obsDocTrib:="Documento Tributario enviado a la cuenta: "+$t_dir+"."
						
						  // Modificado por: Saúl Ponce (18-04-2017) Ticket 168412, si no es CL, se borra el documento PDF.
						If (<>gCountryCode#"cl")
							If (Test path name:C476($t_archivo)=Is a document:K24:1)
								DELETE DOCUMENT:C159($t_archivo)
							End if 
						End if 
					Else 
						LOG_RegisterEvt ("Tipo: "+$t_tipoArchivo+", folio: "+String:C10($r_folio)+". No fue posible enviar el documento tributario al receptor "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)+" debido a un error en el servidor. Error: "+$err+".")
						$b_Error:=True:C214
						$t_obsDocTrib:="No fue posible enviar el documento tributario por email debido a un error. Error: "+$err+"."
					End if 
				Else 
					LOG_RegisterEvt ("Tipo: "+$t_tipoArchivo+", folio: "+String:C10($r_folio)+". No fue posible enviar el documento tributario al receptor "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)+" debido a que el pdf no fue encontrado.")
					$b_Error:=True:C214
					$t_obsDocTrib:="No fue posible enviar el documento tributario por email debido a que no se pudo obtener el PDF."
				End if 
			Else 
				LOG_RegisterEvt ("Tipo: "+$t_tipoArchivo+", folio: "+String:C10($r_folio)+". No fue posible enviar el documento tributario al receptor "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)+" debido a que el mail ingresado no es válido.")
				$b_Error:=True:C214
				$t_obsDocTrib:="No fue posible enviar el documento tributario por email debido a que el destinatario o la copia oculta no tienen una cuenta de correo válida ingresada."
			End if 
		Else 
			LOG_RegisterEvt ("Tipo: "+$t_tipoArchivo+", folio: "+String:C10($r_folio)+". No fue posible enviar el documento tributario al receptor "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)+" debido a que no hay mail ingresado.")
			$b_Error:=True:C214
			$t_obsDocTrib:="No fue posible enviar el documento tributario por email debido a que no hay email para DTE ingresado."
			$b_hecho:=True:C214  //20180308 RCH Ticket 199728. Habían tareas que quedaban pegadas
		End if 
	Else 
		$b_hecho:=True:C214
	End if 
	
	If ($l_proc=0)
		IT_UThermometer (-2;$l_proceso)
	End if 
	
	If (Not:C34(Is nil pointer:C315($y_pointer1)))
		$y_pointer1->:=$b_Error
	End if 
	
	$l_error:=Num:C11($b_Error)
	$t_obsDocTrib:=Replace string:C233($t_obsDocTrib;";";", ")
	$t_obsDocTrib:=DTS_MakeFromDateTime +": "+$t_obsDocTrib
	$t_parametro:=ST_Concatenate (";";->$l_error;->$l_idBoleta;->$t_obsDocTrib)
	If (Not:C34(ACTbol_AgregaObs ($t_parametro)))
		BM_CreateRequest ("ACT_AgregaObservaciones";$t_parametro)
	End if 
Else 
	
	
	If ($b_ambienteCertificacion)
		$t_observacion:="Envio de Email no fue realizado esta marcado el ambiente de certificación."
		LOG_RegisterEvt ($t_observacion)
	Else 
		If ($b_probarEnvio)
			$t_observacion:="Envio de Email no fue realizado no esta activado el envio."
			LOG_RegisterEvt ($t_observacion)
		End if 
	End if 
	
	
	  //en pruebas no se envia mail.
	$b_hecho:=True:C214
End if 

$0:=$b_hecho
