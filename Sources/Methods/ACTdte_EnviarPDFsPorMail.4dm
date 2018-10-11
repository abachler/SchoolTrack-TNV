//%attributes = {}
  //ACTdte_EnviarPDFsPorMail 
TRACE:C157
  //se debe depurar el metodo, declarar variables y reescribir la parte del envio de correos
  //If (LICENCIA_esModuloAutorizado (1;12))

  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilité UY en la comparación 
  // If ((LICENCIA_esModuloAutorizado (1;12)) | (<>gCountryCode="ar"))  //20160609 RCH

If ((LICENCIA_esModuloAutorizado (1;12)) | (<>gCountryCode="ar") | (<>gCountryCode="uy"))
	  //If (USR_GetMethodAcces (Current method name))
	If ((Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181])) & (vsBWR_CurrentModule="AccountTrack"))
		
		If (Semaphore:C143("EnvioPDFXEmail"))
			CD_Dlog (0;__ ("En estos momentos hay un proceso de envío de PDFs en curso."+"\r\r"+"Intente realizar la operación más tarde."))
		Else 
			C_LONGINT:C283($l_proc)
			C_BOOLEAN:C305($go)
			
			$go:=True:C214
			$l_encontrados:=BWR_SearchRecords 
			If ($l_encontrados#-1)
				
				ARRAY LONGINT:C221(alACTdte_ID2Enviar;0)
				
				READ ONLY:C145([ACT_Terceros:138])
				READ ONLY:C145([ACT_Boletas:181])
				
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
				Case of 
						  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilité UY en la comparación y restrinjo el QUERY SELECTION, para que UY envíe cualquier documento tributario
						  //: (<>gCountryCode="ar")
					: (<>gCountryCode="ar") | (<>gCountryCode="uy")
						If (<>gCountryCode="ar")
							QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
							QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]AR_CAEcodigo:48#"")
						End if 
						$go:=SYS_VerificaGeneracionPDF 
					Else 
						QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];(([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 3) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 4))))
				End case 
				
				If ($go)
					If (Records in selection:C76([ACT_Boletas:181])>0)
						TRACE:C157
						  //probar filtro de boletas de terceros y apdos
						CREATE SET:C116([ACT_Boletas:181];"DTEsAEnviar")
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Tercero:21#0)
						KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;"")
						  //enviar copia cedile?
						QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]DTE_enviar_por_mail:74=True:C214)
						KRL_RelateSelection (->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]Id:1;"")
						CREATE SET:C116([ACT_Boletas:181];"DTEsDeTercerosAEnviar")
						
						  //personas
						USE SET:C118("DTEsAEnviar")
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Apoderado:14#0)
						KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;"")
						  //enviar copia cedile?
						QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_DTE_Enviar_Mail:110=True:C214)
						KRL_RelateSelection (->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]No:1;"")
						CREATE SET:C116([ACT_Boletas:181];"DTEsDePersonasAEnviar")
						
						INTERSECTION:C121("DTEsAEnviar";"DTEsDeTercerosAEnviar";"DTEsAEnviarT")
						
						INTERSECTION:C121("DTEsAEnviar";"DTEsDePersonasAEnviar";"DTEsAEnviarP")
						
						UNION:C120("DTEsAEnviarT";"DTEsAEnviarP";"DTEsAEnviarT")
						
						USE SET:C118("DTEsAEnviarT")
						SET_ClearSets ("DTEsAEnviar";"DTEsDeTercerosAEnviar";"DTEsDePersonasAEnviar";"DTEsAEnviarP";"DTEsAEnviarT")
						
						  //descargar PDFs si no estan...
						  //TRACE
						If (Records in selection:C76([ACT_Boletas:181])>0)
							ARRAY LONGINT:C221($alACT_idsBoletas;0)
							SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$alACT_idsBoletas)
							  //SET TEXT TO PASTEBOARD(AT_array2text (->$alACT_idsBoletas;<>cr;"############"))
							
							WDW_OpenFormWindow (->[ACT_Boletas:181];"EnvioPDFsXMail";-1;4;__ ("Enviar PDFs de DTEs por correo electrónico"))
							DIALOG:C40([ACT_Boletas:181];"EnvioPDFsXMail")
							CLOSE WINDOW:C154
							If (ok=1)
								  //guarda prefs...
								ACTdte_EnvioPDFXMail ("GuardaBlob")
								
								  //QUERY WITH ARRAY([ACT_Boletas]ID;alACTdte_ID)
								QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;alACTdte_ID2Enviar)  //20140903 RCH
								
								  //$l_resp:=CD_Dlog (0;"Se enviarán "+String(Records in selection([ACT_Boletas]))+" documentos por mail."+<>cr+<>cr+"¿Desea continuar?";"";"Si";"No")
								
								If (Records in selection:C76([ACT_Boletas:181])>0)
									  //enviar correo
									ARRAY LONGINT:C221($alACT_NumsBoletas;0)
									ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7;>;[ACT_Boletas:181]Numero:11;>)
									SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACT_NumsBoletas)
									
									$b_mostrarMensajeError:=False:C215
									
									$l_proc:=IT_UThermometer (1;0;"")
									For ($l_indice;1;Size of array:C274($alACT_NumsBoletas))
										ACTdte_enviaPDFXMail ($alACT_NumsBoletas{$l_indice};$l_proc;->$b_mostrarMensajeError)
									End for 
									
									IT_UThermometer (-2;$l_proc)
									
									If ($b_mostrarMensajeError)
										CD_Dlog (0;__ ("Proceso terminado. Revise el registro de actividades debido a que algunos correos no pudieron ser enviados."))
									Else 
										CD_Dlog (0;__ ("Proceso terminado con éxito."))
										
									End if 
									
								End if 
							End if 
							ACTdte_EnvioPDFXMail ("DeclaraVariables")
						Else 
							CD_Dlog (0;__ ("No hay destinatarios que reciban los documentos electrónicos."))
						End if 
					Else 
						CD_Dlog (0;__ ("No documentos electrónicos para enviar."))
					End if 
				End if 
				
			Else 
				CD_Dlog (0;__ ("Seleccione los documentos a enviar en el explorador."))
			End if 
			
			CLEAR SEMAPHORE:C144("EnvioPDFXEmail")
		End if 
		
	Else 
		CD_Dlog (0;__ ("Ejecute esta opción desde Documentos Tributarios en AccountTrack."))
	End if 
	
	  //End if 
	
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 