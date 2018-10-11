//%attributes = {}
  // ACTmnu_ImprimeEnviaAvisos()
  //
  //
  // modificado por: Alberto Bachler Klein: 25-12-16, 17:29:23
  // - revisión de la lógica de ejecución del código
  // - simplificacion del código
  // - unificacion de codigo para cliente, servidor y aplicacion local
  // - eliminación de miles de peticiones inncesarias al servidor en le caso de impresione masivas
  // - normalización de rutas
  // - declaración de variables
  // - standarizacion de codigo, eliminación de código basura y repeticiones
  // -----------------------------------------------------------
C_BLOB:C604($x_blob;$x_pdf)
C_BOOLEAN:C305($b_continuar;$b_envio_a_SNT;$b_hecho;$b_imprimirPDFs;$b_relations_MANY;$b_relations_ONE)
C_LONGINT:C283($i;$l_error;$l_idApoderado;$l_idAviso;$l_idProceso;$l_recnumModelo)
C_TEXT:C284($t_carpetaImpresionPDF;$t_dts;$t_error;$t_modeloAviso;$t_msj;$t_parametro;$t_rutaCarpetaPDF;$t_rutaCarpetaPDF_mail;$t_rutaCarpetaPDF_SNT;$t_rutaDocumento;$t_RutaCarpetaAvisosPDF;$t_RutaAvisoPDF;$t_informeXML;$t_impresora)

ARRAY LONGINT:C221($al_recNumAvisos;0)
ARRAY TEXT:C222($at_ArchivosPendientes;0)


If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTac_Impresor";0;4;__ ("Envío o Impresión de Avisos de Cobranza");"wdw_CloseDlog")
	DIALOG:C40([xxSTR_Constants:1];"ACTac_Impresor")
	CLOSE WINDOW:C154
	If (ok=1)
		Case of 
			: (b1=1)
				SET_UseSet ("Selection")
				ARRAY LONGINT:C221(alACT_AvisosImprimir;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];alACT_AvisosImprimir)  //MONO ticket 176163
				ACTcc_ImprimeAvisos (1)
				
			: (b2=1)
				  //20130905 RCH Se agregan semaforos para controlar que no se incien 2 procesos a la vez ni que se cambie la confirguracion...
				If (Semaphore:C143("GeneracionPDFAvisoXEmail"))
					CD_Dlog (0;__ ("En estos momentos hay un proceso de generación de PDFs en curso o se está accediendo a la configuración de envío de avisos por mail."+"\r\r"+"Intente realizar la operación más tarde."))
				Else 
					If (Test semaphore:C652("EnvioPDFAvisoXEmail"))
						CD_Dlog (0;__ ("En estos momentos hay un proceso de envío de e-Mail en curso o se está accediendo a la configuración de envío de avisos por mail."+"\r\r"+"Intente realizar la operación más tarde."))
					Else 
						
						  //20160222 RCH Se muestra mensaje si no se está en server oficial o si se está trabajando con super usuario
						$b_continuar:=True:C214
						If (bPDF2Mail=1)
							If (Not:C34(ACT_VerificaInicioProceso (__ ("Si continúa se enviarán Correos Electrónicos a las cuentas asociadas a los apoderados."))))
								$b_continuar:=False:C215
							End if 
						Else 
							If (Not:C34(ACT_VerificaInicioProceso (__ ("Si continúa se publicarán Avisos de Cobranza en SchoolNet."))))
								$b_continuar:=False:C215
							End if 
						End if 
						
						If ($b_continuar)
							  // RUTAS CARPETAS IMPRESION, ENVIO SCHOOLNET Y ENVIO MAIL
							  // determino la carpeta para la impresión de avisos
							If (Application type:C494=4D Remote mode:K5:5)
								  // si estamos en un cliente imprimo en la carpeta temporal
								$t_carpetaImpresionPDF:=Temporary folder:C486+"AvisosPDF"+Folder separator:K24:12
								If (Test path name:C476($t_carpetaImpresionPDF)=Is a folder:K24:2)
									DELETE FOLDER:C693($t_carpetaImpresionPDF;Delete with contents:K24:24)
								End if 
							Else 
								  // si estamos en servidor o aplicación local imprimo directamente en la carpeta AvisosPorEnviar
								$t_carpetaImpresionPDF:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"AvisosPDF"+SYS_FolderDelimiterOnServer   //uso de rutas estandar para almacenamiento de datos asociados
							End if 
							CREATE FOLDER:C475($t_carpetaImpresionPDF;*)
							
							  //20170228 RCH Se copia a archivo para dejar disponible el PDF en la ficha del AC
							$t_RutaCarpetaAvisosPDF:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"AvisosPDF"+SYS_FolderDelimiterOnServer 
							SYS_CreateFolderOnServer ($t_RutaCarpetaAvisosPDF)
							
							  // determino la carpeta en la que se almacenan los pdf para envio a SchoolNet
							$t_rutaCarpetaPDF_SNT:=SYS_CarpetaAplicacion (CLG_Intercambios_SNT)+"AvisosPDF4SN"+SYS_FolderDelimiterOnServer 
							SYS_CreateFolderOnServer ($t_rutaCarpetaPDF_SNT)
							
							  // carpeta para envio de avisos por mail
							$t_rutaCarpetaPDF_mail:=SYS_CarpetaAplicacion (CLG_Intercambios_ACT)+"AvisosPorEnviar"+SYS_FolderDelimiterOnServer   //uso de rutas estandar para almacenamiento de datos asociados
							SYS_CreateFolderOnServer ($t_rutaCarpetaPDF_mail)  // creacion de la carpeta si no existe
							
							  // vaciado de archivos preexistente de la carpeta para envio por mail
							SYS_DocumentListOnServer ($t_rutaCarpetaPDF_mail;->$at_ArchivosPendientes;Absolute path:K24:14)
							If (Size of array:C274($at_ArchivosPendientes)>0)
								CD_Dlog (0;"Existen "+String:C10(Size of array:C274($at_ArchivosPendientes))+" archivo(s) de avisos de cobranza que no fueron enviados en un proceso de envío anterior.\rPosiblemente estos archivos pdf se encuentran obsoletos. Por seguridad se eliminarán para dar paso al nuevo proceso de envío.\rPuede revisar el registro de act"+"ividades para verificar los avisos eliminados.")
								$t_error:=SYS_DeleteFolderOnServer ($t_rutaCarpetaPDF_mail;Delete with contents:K24:24)  // eliminación de la carpeta completa en un solo llamado con ejeución en el servidor
								If ($t_error#"")
									ModernUI_Notificacion (__ ("Error de ejecucion");$t_error)  // notificación detallada del error incluyendo la ruta del documento o carpeta que impide eliminación de la carpeta
								Else 
									For ($i;1;Size of array:C274($at_ArchivosPendientes))
										$t_msj:=__ ("El archivo PDF, para el aviso de cobranza ^0, fue eliminado. Debido a que quedó pendiente de un proceso de envío anterior.")
										LOG_RegisterEvt (Replace string:C233($t_msj;"^0";$at_ArchivosPendientes{$i}))  // registro en log localizable
									End for 
									AT_Initialize (->$at_ArchivosPendientes)
								End if 
								SYS_CreateFolderOnServer ($t_rutaCarpetaPDF_mail)  // creacion de la carpeta si no existe
							End if 
							
							  // determino si se envian archivos a SchoolNet
							$b_envio_a_SNT:=LICENCIA_esModuloAutorizado (1;SchoolNet)
							
							  // determino si hay registros a imprmir y preparo la impresión
							If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
								ACTac_Sort4Printing 
								SRACTac_InitPrintingVariables 
								$b_imprimirPDFs:=UTIL_ImpresoraPDF (->$t_impresora)
							End if 
							
							If ($b_imprimirPDFs)
								If (OrdenCurNivNom=1)
									ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
								End if 
								LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAvisos)
								
								
								$t_modeloAviso:=atACT_ModelosAviso{atACT_ModelosAviso}
								READ ONLY:C145([xShell_Reports:54])
								QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1;*)
								QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=$t_modeloAviso)
								$l_recnumModelo:=Record number:C243([xShell_Reports:54])
								yBWR_currentTable:=->[ACT_Avisos_de_Cobranza:124]
								vlSR_RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
								  // 20180123 Patricio Aliaga Modificacion 1 de 2 ticket N° 195176 
								  //$x_blob:=[xShell_Reports]xReportData_
								$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")
								
								ARRAY TEXT:C222(aDeletedNames;0)
								ARRAY TEXT:C222(aMotivo;0)
								
								For ($i;1;Size of array:C274($al_recNumAvisos))
									KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$al_recNumAvisos{$i};False:C215)
									$l_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
									$l_idApoderado:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
									vb_HideColsCtas:=False:C215
									vb_HideColAfecto:=False:C215
									SRACTac_CargaCargos (1)
									SRACTac_HideNonUsedObjects 
									$t_rutaDocumento:=$t_carpetaImpresionPDF+"AC_"+String:C10($l_idAviso)+".pdf"
									
									GET AUTOMATIC RELATIONS:C899($b_relations_ONE;$b_relations_MANY)
									  // 20180123 Patricio Aliaga Modificacion 2 de 2 ticket N° 195176 
									  //$l_error:=SR SetDestination (SR PrintDestination File;$t_rutaDocumento)
									  //$l_error:=SR Print Report ($x_blob;SRP_Print_DestinationPDF+SRP_Print_WinPDFNoFonts;SR All Sections)
									
									$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPDF;$t_rutaDocumento;0;$t_impresora)
									
									SET AUTOMATIC RELATIONS:C310($b_relations_ONE;$b_relations_MANY)
									SRACTac_EndAviso (1)
									
									  // Modificado por: Saúl Ponce (06-03-2017) Ticket 175688. Espera a que el documento esté correctamente creado con todos sus datos antes de copiar a las demás carpetas.
									PDF_VerificaCreacionDocumento ($t_rutaDocumento)
									
									  // si la impresión no arrojo error y el documento existe en la ruta de destino  lo copio a las carpetas de envio a SNT y mail
									If (($l_error=0) & (Test path name:C476($t_rutaDocumento)=Is a document:K24:1))
										DOCUMENT TO BLOB:C525($t_rutaDocumento;$x_pdf)
										If (bPDF2Mail=1)
											KRL_SendFileToServer ($t_rutaCarpetaPDF_mail+SYS_Path2FileName ($t_rutaDocumento);$x_pdf;True:C214)
										End if 
										
										If ($b_envio_a_SNT)
											KRL_SendFileToServer ($t_rutaCarpetaPDF_SNT+SYS_Path2FileName ($t_rutaDocumento);$x_pdf;True:C214)
										End if 
										
										  //20170228 RCH
										$t_RutaAvisoPDF:=$t_RutaCarpetaAvisosPDF+SYS_Path2FileName ($t_rutaDocumento)
										KRL_SendFileToServer ($t_RutaAvisoPDF;$x_pdf;True:C214)
										
										$t_dts:=DTS_MakeFromDateTime 
										$t_parametro:=String:C10($al_recNumAvisos{$i})+";"+DTS_MakeFromDateTime 
										$b_hecho:=ACTac_CreaDTSPDF ($t_parametro)
										If (Not:C34($b_hecho))
											BM_CreateRequest ("ACT_escribeDTSPDF";$t_parametro;String:C10($al_recNumAvisos{$i}))
										End if 
										
									Else 
										  // si no fue posible imprimir el aviso en pdf agrefgo sus referencias para informar al usuario al final del método
										$t_msj:=__ ("El archivo PDF, para el aviso de cobranza ID ^0, no pudo ser generado. Posiblemente el usuario de la máquina no tiene los permisos necesarios.")
										$t_msj:=Replace string:C233($t_msj;"^0";String:C10($l_idAviso))
										LOG_RegisterEvt ($t_msj)
										KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApoderado;False:C215)
										APPEND TO ARRAY:C911(aDeletedNames;[Personas:7]Apellidos_y_nombres:30)
										APPEND TO ARRAY:C911(aMotivo;$t_msj)
									End if 
								End for 
								
								
								If (bPDF2Mail=1)
									
									C_LONGINT:C283($l_enviarApCuenta;$l_enviarApAcademico;$l_enviarResponsable)
									If (cb_SepararCargosXPct=0)  //se lee de la conf
										$l_enviarApCuenta:=Num:C11(((r_opMail1_AC=1) | (r_opMail3_Ambos=1)))
										$l_enviarApAcademico:=Num:C11(((r_opMail2_AA=1) | (r_opMail3_Ambos=1)))
										$l_enviarResponsable:=0
									Else 
										$l_enviarApCuenta:=Num:C11(cs_opMail1_AC=1)
										$l_enviarApAcademico:=Num:C11(cs_opMail2_AA=1)
										$l_enviarResponsable:=Num:C11(cs_opMail3Responsable=1)
									End if 
									
									  //$l_idProceso:=Execute on server("PCSrun_ACT_MailSender";256000;"Envio de Avisos de Cobranza";r_opMail1_AC;r_opMail2_AA;r_opMail3_Ambos)
									$l_idProceso:=Execute on server:C373("PCSrun_ACT_MailSender";256000;"Envio de Avisos de Cobranza";$l_enviarApCuenta;$l_enviarApAcademico;$l_enviarResponsable)
								End if 
								
								
								  // si no fue posible imprimir algunos avisos informo al usuario
								If (Size of array:C274(aDeletedNames)>0)
									vReportTitle:="Archivos PDF no generados"
									vBtnTitle:="Ok"
									vbACT_AllowGeneration:=False:C215
									vbACT_MostrarBoton:=False:C215
									vbACT_formPDFs:=True:C214
									SORT ARRAY:C229(aDeletedNames;aMotivo;>)
									WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;__ ("PDFs no generados"))
									DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
									CLOSE WINDOW:C154
									vbACT_formPDFs:=False:C215
								End if 
							End if 
							
							
						Else 
							CD_Dlog (0;__ ("No hay avisos para las cuentas y el período seleccionados."))
						End if 
						
					End if 
				End if 
				CLEAR SEMAPHORE:C144("GeneracionPDFAvisoXEmail")
		End case 
	End if 
End if 