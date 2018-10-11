//%attributes = {}
  //ACTdte_Alertas
C_TEXT:C284($t_periodo;$t_textoCuerpo)
C_LONGINT:C283($l_indiceRS)
C_TEXT:C284($from;$mailAddress;$subject;$body;$userName;$password;$replyto;$ccMail;$ccoMail)
C_BOOLEAN:C305($b_enviarMail)
C_DATE:C307($d_fechaActual;$d_fechaComp;$d_dtsUltimaEjecucion)
C_REAL:C285($r_periodo;$r_periodoValidacion)
C_BOOLEAN:C305($b_continuar)
C_LONGINT:C283($l_idRS)

C_TEXT:C284($t_uuid;$t_Encabezado;$t_descripcion)
ARRAY TEXT:C222($atACT_RazonSocial;0)
ARRAY TEXT:C222($atACT_descripcionMensaje;0)
ARRAY TEXT:C222($atACT_recomendacionMensaje;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_Colores;0)

C_BOOLEAN:C305($b_mostrarAlerta)

If (Count parameters:C259>=1)
	$b_mostrarAlerta:=$1
End if 

$ccoMail:="rcatalan@colegium.com"

  //alerta de envio de libros
  //si no se ha enviado el libro de compras y o ventas, se envia un mail.

  //r_alertarIEC:=1  //preferencias que se leen desde la configuracion
  //r_alertarIEV:=1  //preferencias que se leen desde la configuracion
  //r_alertarFolios:=1  //preferencias que se leen desde la configuracion
  //
  //r_alertarDiaIEC:=25
  //r_alertarDiaIEV:=25



ARRAY LONGINT:C221($alACT_RazonSocial;0)

READ ONLY:C145([ACT_IECV:253])
READ ONLY:C145([ACT_RazonesSociales:279])
READ ONLY:C145([ACT_FoliosDT:293])
READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([Profesores:4])
If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	If (<>gCountryCode="cl")  //verificaciones solo para cl
		
		
		  //20150202 RCH Ejecuta por cada razon social.
		READ ONLY:C145([ACT_RazonesSociales:279])
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
		LONGINT ARRAY FROM SELECTION:C647([ACT_RazonesSociales:279];$alACT_RazonSocial;"")
		
		For ($l_indiceRS;1;Size of array:C274($alACT_RazonSocial))
			GOTO RECORD:C242([ACT_RazonesSociales:279];$alACT_RazonSocial{$l_indiceRS})
			$l_idRS:=[ACT_RazonesSociales:279]id:1
			
			$b_continuar:=True:C214
			If ($b_mostrarAlerta)
				$b_continuar:=False:C215
				Case of 
					: (USR_GetUserID =[ACT_RazonesSociales:279]encargadoDTE_id:31)  //si es el encargado, revisa
						$b_continuar:=True:C214
					: (USR_GetUserID =-1026)  //si es Rafael, se valida
						$b_continuar:=True:C214
				End case 
			End if 
			
			If ($b_continuar)
				ACTdte_AlertasOpciones ("LeeBlob";->$l_idRS)
				  //verificar ultima fecha de ejecucion y ejecutar si ha cambiado el dia
				$d_fechaActual:=Current date:C33(*)
				$d_dtsUltimaEjecucion:=DTS_GetDate (dts_ultimaEjecucion)
				
				$d_ultimaFechaMsj:=DTS_GetDate (dts_ultimaEjecucionMsj)
				
				
				If ($d_fechaActual>$d_dtsUltimaEjecucion)  // la validacion se realiza una vez al dia y si es que la fecha actual es superior a la ultima ejecucion
					
					  //If ($d_ultimaFechaMsj>$d_dtsUltimaEjecucion)  //si no se ha enviado el correo, muestro un mensaje al entrar.
					
					  //QUERY([ACT_RazonesSociales];[ACT_RazonesSociales]emisor_electronico=True)
					  //LONGINT ARRAY FROM SELECTION([ACT_RazonesSociales];$alACT_RazonSocial;"")
					
					If ((Day number:C114($d_fechaActual)>1) & (Day number:C114($d_fechaActual)<7))  //para alertar solo dias de la semana
						  //For ($l_indiceRS;1;Size of array($alACT_RazonSocial))
						  //GOTO RECORD([ACT_RazonesSociales];$alACT_RazonSocial{$l_indiceRS})
						If (SMTP_VerifyEmailAddress ([ACT_RazonesSociales:279]encargadoDTE_mail:32;False:C215)#"")
							$body:="Estimado(a) "+KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31;->[Profesores:4]Apellidos_y_nombres:28)+", "+"\r\r"
							$b_enviarMail:=False:C215
							
							
							If (r_alertarIEC=1)
								
								QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS)
								QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]tipo_operacion:5 ?? 0)
								ORDER BY:C49([ACT_IECV:253];[ACT_IECV:253]periodo:6;<)
								If (Records in selection:C76([ACT_IECV:253])>0)
									$d_fechaComp:=DT_GetDateFromDayMonthYear (1;Num:C11(Substring:C12([ACT_IECV:253]periodo:6;6;2));Num:C11(Substring:C12([ACT_IECV:253]periodo:6;1;4)))
								Else 
									$d_fechaComp:=$d_fechaActual
								End if 
								$t_periodo:=String:C10(Year of:C25($d_fechaComp))+"-"+String:C10(Month of:C24($d_fechaComp);"00")
								$r_periodo:=Num:C11(String:C10(Year of:C25($d_fechaComp))+String:C10(Month of:C24($d_fechaComp);"00"))
								
								$l_mes:=Month of:C24($d_fechaActual)-1
								$l_year:=Year of:C25($d_fechaActual)
								
								If ($l_mes=0)
									$l_mes:=12
									$l_year:=$l_year-1
								End if 
								
								$r_periodoValidacion:=Num:C11(String:C10($l_year)+String:C10($l_mes;"00"))
								While ($r_periodo<=$r_periodoValidacion)  // se valida hasta el mes anterior
									
									  // Modificado por: Saúl Ponce (05/10/2017),Ticket 187901 para que no se alerte en periodos superiores a 2017-07
									If ($r_periodo<=201707)  // 20180911 RCH Ticket 216438
										
										If (($r_periodo<$r_periodoValidacion) | (Day of:C23($d_fechaActual)>=r_alertarDiaIEC))
											QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS;*)
											QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]periodo:6=$t_periodo)
											QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]estado:14 ?? 4)
											QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]tipo_operacion:5 ?? 0)
											If (Records in selection:C76([ACT_IECV:253])=0)
												$t_textoCuerpo:="Según lo registrado en el sistema, no se ha realizado el envío del libro de compras electrónico al SII para el período "+$t_periodo+"."
												$body:=$body+$t_textoCuerpo+"\r\r"
												$b_enviarMail:=True:C214
												
												APPEND TO ARRAY:C911($atACT_RazonSocial;[ACT_RazonesSociales:279]razon_social:2)
												APPEND TO ARRAY:C911($atACT_descripcionMensaje;$t_textoCuerpo)
												APPEND TO ARRAY:C911($atACT_recomendacionMensaje;"Envíe el libro de compras electrónico para el período "+$t_periodo+".")
												
												APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
												APPEND TO ARRAY:C911($al_Colores;Black:K11:16)
												
											End if 
										End if 
										
									End if 
									
									$d_fechaComp:=Add to date:C393($d_fechaComp;0;1;0)
									$t_periodo:=String:C10(Year of:C25($d_fechaComp))+"-"+String:C10(Month of:C24($d_fechaComp);"00")
									$r_periodo:=Num:C11(String:C10(Year of:C25($d_fechaComp))+String:C10(Month of:C24($d_fechaComp);"00"))
								End while 
								
							End if 
							
							If (r_alertarIEV=1)
								
								QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS)
								QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]tipo_operacion:5 ?? 1)
								ORDER BY:C49([ACT_IECV:253];[ACT_IECV:253]periodo:6;<)
								If (Records in selection:C76([ACT_IECV:253])>0)
									$d_fechaComp:=DT_GetDateFromDayMonthYear (1;Num:C11(Substring:C12([ACT_IECV:253]periodo:6;6;2));Num:C11(Substring:C12([ACT_IECV:253]periodo:6;1;4)))
								Else 
									$d_fechaComp:=$d_fechaActual
								End if 
								$t_periodo:=String:C10(Year of:C25($d_fechaComp))+"-"+String:C10(Month of:C24($d_fechaComp);"00")
								$r_periodo:=Num:C11(String:C10(Year of:C25($d_fechaComp))+String:C10(Month of:C24($d_fechaComp);"00"))
								
								$l_mes:=Month of:C24($d_fechaActual)-1
								$l_year:=Year of:C25($d_fechaActual)
								
								If ($l_mes=0)
									$l_mes:=12
									$l_year:=$l_year-1
								End if 
								
								$r_periodoValidacion:=Num:C11(String:C10($l_year)+String:C10($l_mes;"00"))
								While ($r_periodo<=$r_periodoValidacion)  // se valida hasta el mes anterior
									
									  // Modificado por: Saúl Ponce (05/10/2017),Ticket 187901 para que no se alerte en periodos superiores a 2017-07
									If ($r_periodo<=201707)  // 20180911 RCH Ticket 216438
										
										If (($r_periodo<$r_periodoValidacion) | (Day of:C23($d_fechaActual)>=r_alertarDiaIEV))
											QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS;*)
											QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]periodo:6=$t_periodo)
											QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]estado:14 ?? 4)
											QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]tipo_operacion:5 ?? 1)
											If (Records in selection:C76([ACT_IECV:253])=0)
												$t_textoCuerpo:="Según lo registrado en el sistema, no se ha realizado el envío del libro de ventas electrónico al SII para el período "+$t_periodo+"."
												$body:=$body+$t_textoCuerpo+"\r\r"
												$b_enviarMail:=True:C214
												
												APPEND TO ARRAY:C911($atACT_RazonSocial;[ACT_RazonesSociales:279]razon_social:2)
												APPEND TO ARRAY:C911($atACT_descripcionMensaje;$t_textoCuerpo)
												APPEND TO ARRAY:C911($atACT_recomendacionMensaje;"Envíe el libro de ventas electrónico para el período "+$t_periodo+".")
												
												APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
												APPEND TO ARRAY:C911($al_Colores;Black:K11:16)
												
											End if 
										End if 
										
									End if 
									
									$d_fechaComp:=Add to date:C393($d_fechaComp;0;1;0)
									$t_periodo:=String:C10(Year of:C25($d_fechaComp))+"-"+String:C10(Month of:C24($d_fechaComp);"00")
									$r_periodo:=Num:C11(String:C10(Year of:C25($d_fechaComp))+String:C10(Month of:C24($d_fechaComp);"00"))
								End while 
								
							End if 
							
							  //alerta de folios disponibles
							If (r_alertarFolios=1)
								  //se calcula el promedio mensual de folios utilizados por tipo y se envia una alerta para que carguen.
								C_LONGINT:C283($l_tipoDTE;$l_diasARevisar)
								C_DATE:C307($d_fechaInicioV)
								ARRAY LONGINT:C221($alACT_tiposDTE;0)
								ARRAY LONGINT:C221($alACT_recNumFolios;0)
								
								$l_diasARevisar:=30
								$d_fechaInicioV:=Add to date:C393($d_fechaActual;0;0;$l_diasARevisar*-1)  //se obtendran los dt emitidos en los ultimos $l_diasARevisar dias para comprar on los folios diponibles
								
								QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]id_razonSocial:8=$l_idRS)
								CREATE SET:C116([ACT_FoliosDT:293];"setFoliosRS")
								DISTINCT VALUES:C339([ACT_FoliosDT:293]tipo_dteSII:7;$alACT_tiposDTE)
								
								For ($l_tipoDTE;1;Size of array:C274($alACT_tiposDTE))
									USE SET:C118("setFoliosRS")
									QUERY SELECTION:C341([ACT_FoliosDT:293];[ACT_FoliosDT:293]tipo_dteSII:7=$alACT_tiposDTE{$l_tipoDTE};*)
									QUERY SELECTION:C341([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1)
									$r_foliosDisponibles:=0
									LONGINT ARRAY FROM SELECTION:C647([ACT_FoliosDT:293];$alACT_recNumFolios;"")
									For ($l_indiceFolios;1;Size of array:C274($alACT_recNumFolios))
										GOTO RECORD:C242([ACT_FoliosDT:293];$alACT_recNumFolios{$l_indiceFolios})
										$r_foliosDisponibles:=[ACT_FoliosDT:293]hasta:5-[ACT_FoliosDT:293]folio_disponible:6+1
									End for 
									
									SET QUERY DESTINATION:C396(Into variable:K19:4;$r_documentosEmitidos)
									QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=String:C10($alACT_tiposDTE{$l_tipoDTE});*)
									QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]DTS_Creacion:22>=DTS_MakeFromDateTime ($d_fechaInicioV))
									SET QUERY DESTINATION:C396(Into current selection:K19:1)
									
									If ($r_documentosEmitidos>$r_foliosDisponibles)  //si los documentos emitidos son mayores a los folios disponibles, se genera la alerta
										$t_documentoSIICod:=String:C10($alACT_tiposDTE{$l_tipoDTE})
										$t_documentoSII:=ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$t_documentoSIICod)
										
										$t_textoCuerpo:="Hay "+String:C10($r_foliosDisponibles)+" folios disponibles para el tipo de documento: "+$t_documentoSIICod+" ("+$t_documentoSII+"). Durante los últimos "+String:C10($l_diasARevisar)+" días fueron usados: "+String:C10($r_documentosEmitidos)+" folios."
										
										$body:=$body+$t_textoCuerpo+"\r\r"
										$b_enviarMail:=True:C214
										APPEND TO ARRAY:C911($atACT_RazonSocial;[ACT_RazonesSociales:279]razon_social:2)
										APPEND TO ARRAY:C911($atACT_descripcionMensaje;$t_textoCuerpo)
										APPEND TO ARRAY:C911($atACT_recomendacionMensaje;"Descargue desde el SII folios del tipo "+$t_documentoSIICod+" y carguelos en AccountTrack.")
										APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
										APPEND TO ARRAY:C911($al_Colores;Red:K11:4)
										
									End if 
									
									
									
								End for 
								SET_ClearSets ("setFoliosRS")
							End if 
							
							  //20180116 RCH INICIO Actualiza estados CAF Vencidos
							ARRAY LONGINT:C221($al_idsCAF;0)
							ARRAY LONGINT:C221($al_idsCAF2Cambiar;0)
							ARRAY BLOB:C1222($ax_CAFS;0)
							
							C_TEXT:C284($t_temp)
							C_LONGINT:C283($l_indice)
							C_BOOLEAN:C305($b_res)
							C_DATE:C307($d_fecha;$d_fecha2Comparar)
							C_TEXT:C284($t_fecha)
							
							  //busco caf para RS, activos y no boletas
							READ ONLY:C145([ACT_FoliosDT:293])
							QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]estado:3=1;*)
							QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]id_razonSocial:8=$l_idRS;*)
							QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]tipo_dteSII:7#"39";*)
							QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]tipo_dteSII:7#"41")
							
							SELECTION TO ARRAY:C260([ACT_FoliosDT:293]id:1;$al_idsCAF;[ACT_FoliosDT:293]CAF_SII:9;$ax_CAFS)
							For ($l_indice;1;Size of array:C274($al_idsCAF))
								ARRAY TEXT:C222($atACTdte_DatosCAF;0)
								ARRAY TEXT:C222($atACTdte_DatosCAF;10)
								
								  //Creo archivo temporal para leer caf
								$t_temp:="ACT_caf_"+String:C10($al_idsCAF{$l_indice})+".xml"
								BLOB TO DOCUMENT:C526($t_temp;$ax_CAFS{$l_indice})
								
								$b_res:=ACTdte_CargarCAF ($t_temp;->$atACTdte_DatosCAF)
								If ($b_res)
									  //Valido que el CAF no sea antiguo
									$t_fecha:=$atACTdte_DatosCAF{6}
									$d_fecha:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fecha;9;2));Num:C11(Substring:C12($t_fecha;6;2));Num:C11(Substring:C12($t_fecha;1;4)))
									$d_fecha2Comparar:=Add to date:C393(Current date:C33(*);0;-18;0)
									If (($d_fecha<$d_fecha2Comparar) & ($d_fecha#!00-00-00!))
										APPEND TO ARRAY:C911($al_idsCAF2Cambiar;$al_idsCAF{$l_indice})
									End if 
								End if 
								
								  //elimino temporal
								EM_ErrorManager ("Install")
								EM_ErrorManager ("SetMode";"")
								DELETE DOCUMENT:C159($t_temp)
								EM_ErrorManager ("Clear")
							End for 
							
							  //Cambio estados de CAF
							If (Size of array:C274($al_idsCAF2Cambiar)>0)
								READ WRITE:C146([ACT_FoliosDT:293])
								QUERY WITH ARRAY:C644([ACT_FoliosDT:293]id:1;$al_idsCAF2Cambiar)
								APPLY TO SELECTION:C70([ACT_FoliosDT:293];[ACT_FoliosDT:293]estado:3:=3)
								KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
								LOG_RegisterEvt ("Cambio de estado a folios vencidos. Fecha autorización inferior a "+String:C10($d_fecha2Comparar)+". Ids CAF modificados: "+AT_array2text (->$al_idsCAF2Cambiar;", ";"#########")+".")
							End if 
							  //20180116 RCH FIN Actualiza estados CAF Vencidos
							
							
							  //alerta de fecha de vencimiento de firma. Obligatoria
							GOTO RECORD:C242([ACT_RazonesSociales:279];$alACT_RazonSocial{$l_indiceRS})
							If ([ACT_RazonesSociales:279]firma_fecha_vencimiento:23#!00-00-00!)
								$l_diasParaVencer:=[ACT_RazonesSociales:279]firma_fecha_vencimiento:23-$d_fechaActual
								If ($l_diasParaVencer<=20)
									If ($l_diasParaVencer>=0)
										$t_textoCuerpo:="Faltan "+String:C10($l_diasParaVencer)+" día(s) para que venza la firma electrónica cargada en el sistema."
									Else 
										$t_textoCuerpo:="La firma electrónica lleva "+String:C10(Abs:C99($l_diasParaVencer))+" día(s) vencida."
									End if 
									$t_textoCuerpo:=$t_textoCuerpo+" Renueve la firma digital desde la configuración inicial DTE/Cargar firma."  //20180821 RCH
									$body:=$body+$t_textoCuerpo+"\r\r"
									$b_enviarMail:=True:C214
									APPEND TO ARRAY:C911($atACT_RazonSocial;[ACT_RazonesSociales:279]razon_social:2)
									APPEND TO ARRAY:C911($atACT_descripcionMensaje;$t_textoCuerpo)
									APPEND TO ARRAY:C911($atACT_recomendacionMensaje;"Obtenga una nueva firma y cárguela al sistema.")
									APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
									APPEND TO ARRAY:C911($al_Colores;Red:K11:4)
								End if 
							End if 
							
							  //20150514 RCH alerta documentos tributarios no enviados a dte (sin folio)
							READ ONLY:C145([ACT_Boletas:181])
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0;*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214;*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=$l_idRS;*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
							
							If (Records in selection:C76([ACT_Boletas:181])>0)
								$t_textoCuerpo:="Hay "+String:C10(Records in selection:C76([ACT_Boletas:181]))+" documento(s) tributario(s) no enviado(s) al servidor DTENet. Por favor envíelo(s) o anúlelo(s)."
								$body:=$body+$t_textoCuerpo+"\r\r"
								$b_enviarMail:=True:C214
								APPEND TO ARRAY:C911($atACT_RazonSocial;[ACT_RazonesSociales:279]razon_social:2)
								APPEND TO ARRAY:C911($atACT_descripcionMensaje;$t_textoCuerpo)
								APPEND TO ARRAY:C911($atACT_recomendacionMensaje;"Busque los documentos electrónicos con folio 0 y envíelos a DTENet mediante las opciones disponibles en el popup lateral de la pestaña Documentos Tributarios.")
								APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
								APPEND TO ARRAY:C911($al_Colores;Red:K11:4)
							End if 
							
							If ($b_enviarMail)
								
								If (Not:C34($b_mostrarAlerta))
									$userName:="appSchoolTrack@colegium.com"
									$password:="quasimodo"
									$from:=ST_Qte ("AccountTrack")+"<AccountTrack@colegium.com>"
									$mailAddress:=[ACT_RazonesSociales:279]encargadoDTE_mail:32
									$subject:="Alerta DTE "+String:C10(DTS_GetDate (DTS_MakeFromDateTime ))
									
									$body:=$body+"Revise las recomendaciones en el Centro de Notificaciones."+"\r\r"
									$body:=$body+"Atentamente,"+"\r\r"
									$body:=$body+"AccountTrack"
									
									  //envio de correo por alertas de DTENET
									$err:=SMTP_Send_Text ("mail.colegium.com";$from;$mailAddress;$subject;$body;$userName;$password;1;$replyto;$ccMail;$ccoMail)
								Else 
									If ($d_fechaActual>$d_ultimaFechaMsj)  //si no se ha enviado el correo, muestro un mensaje al entrar.
										$body:="¡ALERTA DOCUMENTOS TRIBUTARIOS ELECTRÓNICOS!"+"\r\r"+$body
										CD_Dlog (0;$body)
									End if 
								End if 
							End if 
							
						Else 
							  //crear alerta en centro de notificaciones
							APPEND TO ARRAY:C911($atACT_RazonSocial;[ACT_RazonesSociales:279]razon_social:2)
							APPEND TO ARRAY:C911($atACT_descripcionMensaje;"El correo electrónico del encargado está vacío")
							APPEND TO ARRAY:C911($atACT_recomendacionMensaje;"Vaya a la configuración de los Documentos Tributarios Electrónicos y complete el campo Email encargado.")
							
							APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
							APPEND TO ARRAY:C911($al_Colores;Red:K11:4)
							
						End if 
						
						If (Not:C34($b_mostrarAlerta))
							If (Size of array:C274($atACT_RazonSocial)>0)
								$t_Encabezado:="Alerta Documentos Tributarios Electrónicos día "+String:C10(DTS_GetDate (DTS_MakeFromDateTime ))
								$t_descripcion:="Todos los días hábiles se verifica el correcto funcionamiento de los Documentos Tributarios Electrónicos. Si algún problema o posible problema es detectado, se genera esta alerta.\r\rPor favor revise el detalle encontrado."
								
								ARRAY TEXT:C222($at_TitulosColumnas;0)
								APPEND TO ARRAY:C911($at_TitulosColumnas;"Razón Social")
								APPEND TO ARRAY:C911($at_TitulosColumnas;"Mensaje")
								APPEND TO ARRAY:C911($at_TitulosColumnas;"Recomendación")
								
								$t_uuid:=NTC_CreaMensaje ("AccountTrack";$t_Encabezado;$t_descripcion;[ACT_RazonesSociales:279]encargadoDTE_id:31)
								NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$atACT_RazonSocial;->$atACT_descripcionMensaje;->$atACT_recomendacionMensaje)
								NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
								  //$t_mensajeFalla:="Se detectaron inconsistencias en las propiedades de consolidación de calificaciones.\r\rEl detalle será mostrado en el centro de notificaciones."
								  //$t_mensajeExito:="No se detectó ninguna inconsistencia en las propiedades de consolidación de calificaciones."
								  //NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name;$t_mensajeFalla;$t_mensajeExito)
							End if 
						End if 
					End if 
					
					If (Not:C34($b_mostrarAlerta))
						dts_ultimaEjecucion:=DTS_MakeFromDateTime 
					Else 
						dts_ultimaEjecucionMsj:=DTS_MakeFromDateTime 
					End if 
					ACTdte_AlertasOpciones ("GuardaBlob";->$l_idRS)
					
					  //End if 
					
				End if 
			End if 
		End for 
		
	End if 
End if 