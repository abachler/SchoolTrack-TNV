//%attributes = {}
  //ACTbol_PrintBoletasVR

  //REGISTO DE CAMBIOS
  //20080418 RCH En el incidente 62955 reportaron un problema de desorden al momento de imprimir los dctos tributarios.
  //SOLUCIÓN IMPLEMENTADA. Después de usar el set reordeno los registros en la selección.

C_LONGINT:C283($Proxima)
C_LONGINT:C283($0)
C_LONGINT:C283($table)
C_TEXT:C284($currPrinter)
C_BOOLEAN:C305(cs_utilizaImpSel)
C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)
C_BOOLEAN:C305(vbACT_noHayCAF;vbACT_noHayFDE)
C_TEXT:C284(vtACT_RazonSocialDctoDuplicado)
C_BOOLEAN:C305($b_esEmisorColegium)
C_REAL:C285(r_generaDTEAlIngresarPago)  //propiedad que sera leida desde a configuracion
C_REAL:C285($r_generaDTEAlIngresarPago;$r_abrirDTEAlIngresarPago;$r_enviarDTEAlIngresarPago)

$Documentos:=$1  //set con los documentos a imprimir
$massivePrinting:=$2  //indica si es impresion masiva
$ID_Doc:=$3  //documento para la impresion
$DoNumbering:=True:C214
If (Count parameters:C259=4)
	$PrintRecibo:=$4
Else 
	$PrintRecibo:=False:C215
End if 
If (Count parameters:C259=5)
	$PrintRecibo:=$4
	$DoNumbering:=$5
End if 
If (Count parameters:C259=6)
	$PrintRecibo:=$4
	$DoNumbering:=$5
	$Proxima:=$6
End if 
If (Count parameters:C259=7)
	$PrintRecibo:=$4
	$DoNumbering:=$5
	$Proxima:=$6
	$xBlob:=$7->
End if 
If (Count parameters:C259=10)
	$PrintRecibo:=$4
	$DoNumbering:=$5
	$Proxima:=$6
	$xBlob:=$7->
	$r_generaDTEAlIngresarPago:=$8
	$r_abrirDTEAlIngresarPago:=$9
	$r_enviarDTEAlIngresarPago:=$10
End if 
$0:=1
$PrintDocs:=True:C214
If (Not:C34($PrintRecibo))
	If (SYS_IsWindows )
		$err:=sys_GetDefPrinter ($currPrinter)
	End if 
	$index:=Find in array:C230(alACT_IDDT;$ID_Doc)
	If ($index#-1)
		$WhereModelo:=Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})
		$WherePrinter:=Find in array:C230(atACT_Impresoras;atACT_Impresora{$index})
		If ($WherePrinter#-1)
			$Printer:=atACT_Impresoras{$WherePrinter}
		Else 
			If (SYS_IsWindows )
				  //$Printer:=Get current printer
				$Printer:=$currPrinter
			Else 
				$Printer:="la impresora por defecto"
			End if 
		End if 
		If ($WhereModelo#-1)
			$ModID:=alACT_ModelosDocID{$WhereModelo}
			$DocName:=atACT_NombreDoc{$index}
		Else 
			$PrintDocs:=False:C215
			READ ONLY:C145([ACT_Boletas:181])
			USE SET:C118($Documentos)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0)
			$msg:="No se encuentra el modelo de impresión de documentos tributarios. Revise la confi"+"guración e intente imprimir otra vez."
			If (Records in selection:C76([ACT_Boletas:181])>0)
				$msg:=$msg+"\r\r"+"Fueron generados Documentos Tributarios con folio 0. Por favor revise los documen"+"tos tributarios asociado"+"s y si es necesario modifíquelos a través del asistente correspondiente."
			End if 
			CD_Dlog (0;$msg)
		End if 
	Else 
		$PrintDocs:=False:C215
	End if 
End if 

If (Records in set:C195($Documentos)>0)
	If ($PrintDocs)
		READ WRITE:C146([ACT_Boletas:181])
		USE SET:C118($Documentos)
		If ($DoNumbering)
			
			  //20150325 RCH Si el proceso era iniciado desde 2 maquinas diferentes, el folio se podría duplicar.
			While (Semaphore:C143("CreacionDT"))
				DELAY PROCESS:C323(Current process:C322;20)
			End while 
			
			$Proxima:=ACTbol_Numbering ($index;"seleccion")
			
			CLEAR SEMAPHORE:C144("CreacionDT")
			
			If ($Proxima=-2)
				$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
				$format:="# ### ###"
				vtACT_logEmisionNC:=__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon
				Case of 
					: (vbACT_noHayCAF)
						vbACT_noHayCAF:=False:C215
						CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión"))
					: (vbACT_noHayFDE)
						vbACT_noHayFDE:=False:C215
						CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
					Else 
						CD_Dlog (0;vtACT_logEmisionNC)
				End case 
				$0:=-2
			Else 
				If (BLOB size:C605($xBlob)#0)
					ARRAY LONGINT:C221(al_idsTransacciones;0)
					C_LONGINT:C283(id_boleta)
					BLOB_Blob2Vars (->$xBlob;0;->id_boleta;->al_idsTransacciones)
					$ok:=ACTtra_AsignaIdBoleta ($xBlob)
					
					If ($ok)
						If (ACTbol_ValidaEmisionDT (id_boleta))
							$b_esEmisorColegium:=ACTdte_EsEmisorColegium (KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->id_boleta;->[ACT_Boletas:181]ID_RazonSocial:25))
						Else 
							$0:=-3
							$Proxima:=-2
						End if 
					Else 
						$0:=-4
					End if 
					
				End if 
			End if 
		End if 
		  //If ($Proxima#-2)
		If ($0=1)
			C_BOOLEAN:C305($go)
			$go:=True:C214
			If (cb_BoletaSubvencionada=1)
				ARRAY TEXT:C222($aSubvencionados;5)
				ARRAY TEXT:C222($at_nombreCat;0)
				$aSubvencionados{1}:="Derecho de Matrícula"
				$aSubvencionados{2}:="Cobro Mensual"
				$aSubvencionados{3}:="Exención Sistema de Becas"
				$aSubvencionados{4}:="Aportes o Donaciones"
				$aSubvencionados{5}:="Cuotas Extraordinarias Centro de Padres"
				READ ONLY:C145([xxACT_ItemsCategorias:98])
				  // Modificado por: Saúl Ponce (08/02/2018) Ticket Nº 198592, lo dejo así porque al cargar el formulario [xxACT_Items].Categorizacion
				  // se estaba creando un registro en [xxACT_ItemsCategorias] para "items sin categoría". Acá encontraba 6 categorías y no dejaba imprimir subvencionados.
				  // ALL RECORDS([xxACT_ItemsCategorias])
				QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2#0)
				SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Nombre:1;$at_nombreCat)
				If (Size of array:C274($at_nombreCat)#5)
					CD_Dlog (0;__ ("El número de categorías configurado es distinto de lo estándar (5)");"";__ ("OK"))
					$go:=False:C215
				Else 
					For ($r;1;Size of array:C274($aSubvencionados))
						$el:=Find in array:C230($aSubvencionados;$at_nombreCat{$r})
						If ($el=-1)
							$go:=False:C215
							CD_Dlog (0;__ ("La configuración de las categorías no es la estándar para las boletas subvencionadas. \rModifique la configuración de las categorías con los nombres estándar (Control + d) e imprima la boleta desde la pestaña Documentos tributarios");"";__ ("OK"))
							$r:=Size of array:C274($aSubvencionados)
						End if 
					End for 
				End if 
			End if 
			If ($go)
				  // Modificado por: Saúl Ponce (19-06-2017) Ticket Nº 182634, ACT solicitaba establecer la impresora aún cuando existía una predeterminada para boletas.
				  //$currP:=Find in array(atACT_PrinterNames;ST_GetWord ($Printer;1;","))
				$currP:=Find in array:C230(atACT_Impresoras;ST_GetWord ($Printer;1;","))
				If ($currP#-1)
					If (SYS_IsWindows )
						If (Not:C34(cs_utilizaImpSel))
							$err:=sys_SetDefPrinter (atACT_Impresoras{$currP})
						Else 
							  //Modificado por: Saúl Ponce (19-06-2017) Ticket Nº 182634, para mostrar el nombre de la impresora que realizará el proceso. Cuando se cambiaba en el asistente no se mostraba la correcta.
							$Printer:=vtACT_Printer
						End if 
					Else 
						
					End if 
				End if 
				
				  //20111116 RCH Si es documento digital no imprime 
				  //If (aiACT_Tipo{$index}#2)
				  //20120703 RCH Se agrega propiedad para imprimir documento
				$vb_continuar:=True:C214
				If (aiACT_Tipo{$index}=2)
					If ($r_generaDTEAlIngresarPago=0)  //20150713 RCH Si está marcada la opción se continua.
						$b_esEmisorColegium:=False:C215  //si no tiene marcada la opcion no se debe emitir el DT
						If (cs_imprimirDocumento=0)
							$vb_continuar:=False:C215
						End if 
					End if 
				End if 
				If ($vb_continuar)
					
					If ($b_esEmisorColegium)
						$r:=1
					Else 
						$r:=CD_Dlog (0;__ ("Por favor haga clic en el botón Lista cuando la impresora esté lista para imprimir ")+$DocName+__ (".\r\rEl próximo documento a imprimir es el Nº ")+String:C10($Proxima)+__ ("\r\rEl documento será impreso en ")+$Printer+__ (".");"";__ ("Lista");__ ("Terminar sin imprimir"))
					End if 
					
					If ($r=1)
						READ ONLY:C145([ACT_Boletas:181])
						USE SET:C118($Documentos)
						ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12;>;[ACT_Boletas:181]ID_Documento:13;>;[ACT_Boletas:181]Numero:11;>)
						  //APPLY TO SELECTION([ACT_Boletas];[ACT_Boletas]Impresa:=True)
						
						$Table:=Table:C252(->[ACT_Boletas:181])*-1
						QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
						QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=$ModID)
						
						$reportRecNum:=Record number:C243([xShell_Reports:54])
						
						READ ONLY:C145(*)
						GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
						$reportName:=[xShell_Reports:54]FormName:17
						$specialConfig:=[xShell_Reports:54]SpecialParameter:18
						$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
						$tablePointer:=Table:C252($tableNumber)
						yBWR_currentTable:=$tablePointer
						xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
						$RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
						If ($RegXPagina=0)
							$RegXPagina:=1
						End if 
						
						COPY NAMED SELECTION:C331([ACT_Boletas:181];"?Editions")
						  //If ((Not(SYS_IsWindows )) & ($Printer#""))
						  //SET CURRENT PRINTER($Printer)
						  //End if 
						
						If (Records in selection:C76([ACT_Boletas:181])>0)
							  //vb_Hide2:=False
							  //$dh:=ACTbol_ImpresionDocsTrib ($reportRecNum)
							If (Not:C34($b_esEmisorColegium))
								SRACTbol_InitPrintingVariables 
								  //MONO Ticket 179726
								
								  // Modificado por: Saúl Ponce (06-07-2017) Ticket 182634, para cargar el blob del reporte con los cambios efectuados dentro del método
								  // SRP_ValidaAjustesImpresion ($reportRecNum)
								xSR_ReportBlob:=SRP_ValidaAjustesImpresion ($reportRecNum)
								
								  //If (SR Validate (xSR_ReportBlob)=0)
								  //OK:=SR Page Setup (xSR_ReportBlob)
								  //If (OK=1)
								  //READ WRITE([xShell_Reports])
								  //LOAD RECORD([xShell_Reports])
								  //[xShell_Reports]xReportData_:=xSR_ReportBlob
								  //SAVE RECORD([xShell_Reports])
								  //KRL_ReloadAsReadOnly (->[xShell_Reports])
								  //End if 
								  //Else 
								  //OK:=1
								  //End if 
							Else 
								OK:=1
							End if 
							<>stopExec:=False:C215
							If ((OK=1) & (Not:C34(<>stopExec)))
								vb_HideColsCtas:=False:C215
								ARRAY LONGINT:C221($aRecNumsBoletas;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$aRecNumsBoletas;"")
								$seleccionados:=Size of array:C274($aRecNumsBoletas)
								If (Not:C34($b_esEmisorColegium))
									$Loops:=Int:C8($seleccionados/$RegXPagina)
								Else 
									$Loops:=1
								End if 
								$BloquesProcesados:=0
								$LinearIndex:=0
								CD_Msg ("";6)
								For ($i;1;$Loops)
									If (Not:C34(<>stopExec))
										If (Not:C34($b_esEmisorColegium))
											sMess:="Imprimiendo documentos tributarios.\r\rCuantos de "+String:C10($seleccionados)+".\r\rNúmeros Total."
											
											$numDoc:=""
											For ($j;1;$RegXPagina)
												GOTO RECORD:C242([ACT_Boletas:181];$aRecNumsBoletas{$LinearIndex+$j})
												$numDoc:=$numDoc+", "+String:C10([ACT_Boletas:181]Numero:11)
												SRACTbol_CargaCargos ($j)
												GOTO RECORD:C242([ACT_Boletas:181];$aRecNumsBoletas{$LinearIndex+$j})
												If ([ACT_Boletas:181]Impresa:10)
													ACTcfg_OpcionesReimpBoletas ("BuscaDeudaCreaCargo")
												End if 
											End for 
											$numDoc:=Substring:C12($numDoc;3)
											sMess:=Replace string:C233(sMess;"Cuantos";String:C10($LinearIndex+$RegXPagina))
											sMess:=Replace string:C233(sMess;"Total";$numDoc)
											DISPLAY RECORD:C105([xShell_Dialogs:114])
											SRACTbol_HideNonUsedObjects 
											GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
											  //$err:=SR Print Report(xSR_ReportBlob;4;65535) `en algunas impresoras la impresión salía gigante
											  //$err:=SR Print Report(xSR_ReportBlob;2;65535) `en impresión masiva por cada hoja aparecía el cuadro de selección de impresora
											GET AUTOMATIC RELATIONS:C899($one;$many)
											If ($massivePrinting)
												$err:=SR Print Report (xSR_ReportBlob;4;65535)  //en algunas impresoras la impresión salía gigante
											Else 
												$err:=SR Print Report (xSR_ReportBlob;2;65535)
											End if 
											SET AUTOMATIC RELATIONS:C310($one;$many)
											For ($j;1;$RegXPagina)
												SRACTbol_EndBoleta ($j)
											End for 
											$BloquesProcesados:=$BloquesProcesados+1
											$LinearIndex:=$LinearIndex+$RegXPagina
											
										Else 
											sMess:="Emitiendo documentos tributarios electrónicos."
											DISPLAY RECORD:C105([xShell_Dialogs:114])
											
											READ WRITE:C146([ACT_Boletas:181])
											GOTO RECORD:C242([ACT_Boletas:181];$aRecNumsBoletas{Size of array:C274($aRecNumsBoletas)})
											$l_idBoleta:=[ACT_Boletas:181]ID:1
											[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1
											SAVE RECORD:C53([ACT_Boletas:181])
											
											$b_receptorElectronico:=KRL_GetBooleanFieldData (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]ACT_DTE_Enviar_Mail:110)
											$b_receptorElectronicoT:=KRL_GetBooleanFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]DTE_enviar_por_mail:74)
											
											KRL_UnloadReadOnly (->[ACT_Boletas:181])
											
											$vl_procesados:=ACTdte_EmiteDocumento ($l_idBoleta)
											If ($vl_procesados=1)  //si se emitio se obtiene el PDF
												$t_ruta:=ACTdte_ObtienePDFDT ($l_idBoleta)
												If ($t_ruta#"")
													If ($r_abrirDTEAlIngresarPago=1)
														$b_abrir:=True:C214
														If (r_abrirDTEIngresoPagoNoReceptor=1)  // solo se abre el PDF si el receptor no es electronico
															If (($b_receptorElectronico) | ($b_receptorElectronicoT))
																$b_abrir:=False:C215
															End if 
														End if 
														If ($b_abrir)
															OPEN URL:C673($t_ruta;*)
														End if 
													End if 
													
													If ($r_enviarDTEAlIngresarPago=1)
														C_BLOB:C604($xBlobParam)
														BM_CreateRequest ("ACT_EnviaMailDTE";String:C10($l_idBoleta);String:C10($l_idBoleta);$xBlobParam;Current machine:C483+"/"+Current system user:C484)
													End if 
												End if 
											Else 
												$0:=-5
											End if 
											
										End if 
										
									End if 
									GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
									xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
								End for 
								If (Not:C34($b_esEmisorColegium))
									$faltan:=$seleccionados-($BloquesProcesados*$RegXPagina)
									If ((Not:C34(<>stopExec)) & ($faltan>0))
										$arrayIndex:=Size of array:C274($aRecNumsBoletas)-$faltan
										sMess:="Imprimiendo documentos tributarios.\r\rCuantos de "+String:C10($seleccionados)+".\r\rNúmero(s) Total."
										$numDoc:=""
										For ($i;1;$faltan)
											GOTO RECORD:C242([ACT_Boletas:181];$aRecNumsBoletas{$arrayIndex+$i})
											$numDoc:=$numDoc+", "+String:C10([ACT_Boletas:181]Numero:11)
											SRACTbol_CargaCargos ($i)
											GOTO RECORD:C242([ACT_Boletas:181];$aRecNumsBoletas{$arrayIndex+$i})
											If ([ACT_Boletas:181]Impresa:10)
												ACTcfg_OpcionesReimpBoletas ("BuscaDeudaCreaCargo")
											End if 
										End for 
										$numDoc:=Substring:C12($numDoc;3)
										sMess:=Replace string:C233(sMess;"Cuantos";String:C10($faltan))
										sMess:=Replace string:C233(sMess;"Total";$numDoc)
										DISPLAY RECORD:C105([xShell_Dialogs:114])
										For ($i;$faltan+1;4)
											SRACTbol_HideNonUsedObjects ($i)
										End for 
										SRACTbol_HideNonUsedObjects 
										GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
										  //$err:=SR Print Report(xSR_ReportBlob;4;65535) `en algunas impresoras la impresión salía gigante
										  //$err:=SR Print Report(xSR_ReportBlob;2;65535) `en impresión masiva por cada hoja aparecía el cuadro de selección de impresora
										GET AUTOMATIC RELATIONS:C899($one;$many)
										If ($massivePrinting)
											$err:=SR Print Report (xSR_ReportBlob;4;65535)  //en algunas impresoras la impresión salía gigante
										Else 
											$err:=SR Print Report (xSR_ReportBlob;2;65535)
										End if 
										SET AUTOMATIC RELATIONS:C310($one;$many)
										For ($i;1;$faltan)
											SRACTbol_EndBoleta ($i)
										End for 
									End if 
								End if 
								CLOSE WINDOW:C154
							End if 
							
							READ WRITE:C146([ACT_Boletas:181])
							USE SET:C118($Documentos)
							APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Impresa:10:=True:C214)
							KRL_UnloadReadOnly (->[ACT_Boletas:181])
						End if 
						
					End if 
				End if 
				
				If (SYS_IsWindows )
					$err:=sys_SetDefPrinter ($currPrinter)
				End if 
				
			End if 
		End if 
	Else 
		$0:=-1
	End if 
End if 