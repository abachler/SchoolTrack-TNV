//%attributes = {}
  //ACTdte_ImportaFacturas

C_LONGINT:C283($vl_idCargoMayor)

$vr_montoEnCargos:=0
$vr_montoBoletas:=0
$vr_montoBoleta:=0
$b_hayError:=False:C215

If (USR_GetMethodAcces (Current method name:C684))
	$vb_go:=ACTbol_ValidaInicioEmision (2)
	If ($vb_go)
		WDW_OpenFormWindow (->[ACT_Boletas:181];"ImportacionTerceros";-1;4;__ ("Asistente"))
		DIALOG:C40([ACT_Boletas:181];"ImportacionTerceros")
		CLOSE WINDOW:C154
		C_REAL:C285($r_idRS)
		$r_idRS:=alACTcfg_Razones{atACTcfg_Razones}
		
		If (ok=1)
			If (KRL_GetBooleanFieldData (->[ACT_RazonesSociales:279]id:1;->$r_idRS;->[ACT_RazonesSociales:279]emisor_electronico:30))
				C_TIME:C306($ref)
				
				ARRAY TEXT:C222($at_posDatos;0)
				
				ARRAY BOOLEAN:C223(ab_documentoAfecto;0)  //para contar documentos afectos y exentos
				
				  //C_BOOLEAN($vb_rutOK;$vb_giroOK;$vb_refOK;$vb_montoOK;$vb_detalleOK;$b_montosTotalesOK;$b_foliosDisponibles;$b_detallesOK)
				C_BOOLEAN:C305($vb_rutOK;$vb_giroOK;$vb_refOK;$vb_montoOK;$vb_detalleOK;$b_montosTotalesOK;$b_foliosDisponibles;$b_detallesOK;$b_direccionOK;$b_comunaOK;$b_ciudadOK;$b_emailOK;$b_encabezadosOK)
				
				If (USR_checkRights ("M";->[ACT_Terceros:138]))
					$vb_readWrite:=True:C214
					ACTcfg_OpcionesRazonesSociales ("CargaByID";->$r_idRS;->$vb_readWrite)
					$vb_estado:=[ACT_RazonesSociales:279]emisor_electronico:30
					If (cs_documentoDigital=1)
						[ACT_RazonesSociales:279]emisor_electronico:30:=True:C214
					Else 
						[ACT_RazonesSociales:279]emisor_electronico:30:=False:C215
					End if 
					SAVE RECORD:C53([ACT_RazonesSociales:279])
					KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
					
					EM_ErrorManager ("Install")
					EM_ErrorManager ("SetMode";"")
					
					$ref:=Open document:C264(vt_ruta;"TEXT";Read mode:K24:5)
					If (ok=1)
						QR_DeclareGenericArrays 
						
						ACTdte_OpcionesGenerales ("EncabezadosImportacionDT";->$at_posDatos)
						ARRAY TEXT:C222($at_datos;0)
						
						  //tipo de dcto a importar. Se debe elegir, por ahora es -3
						$vl_tipoDcto:=alACT_IDsCats{atACT_Categorias}
						  //$vl_tipoDcto:=-3
						
						If (cs_windows=1)
							USE CHARACTER SET:C205("windows-1252";1)
						Else 
							USE CHARACTER SET:C205("MacRoman";1)
						End if 
						
						
						$delimiter:=ACTabc_DetectDelimiter (document)
						RECEIVE PACKET:C104($ref;$text;$delimiter)
						  //$text:=Win to Mac($text)
						
						  //variable utilizada durante la emision
						C_REAL:C285(vrACT_MontoPago;vrACT_MontoAdeudado)
						ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
						ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
						bAvisoAlumno:=0
						
						ARRAY TEXT:C222($at_posDatosFile;0)
						ARRAY TEXT:C222($at_encabezados;0)
						
						If ($text#"")
							$document:=document
							
							AT_Text2Array (->$at_posDatosFile;$text;"\t")
							
							  //elimino filas sin encabezado
							For ($i;Size of array:C274($at_posDatosFile);1;-1)
								If ($at_posDatosFile{$i}="")
									AT_Delete ($i;1;->$at_posDatosFile)
								End if 
							End for 
							$vl_columnas:=Size of array:C274($at_posDatosFile)
							$vl_columnasFijas:=Size of array:C274($at_posDatos)
							$vl_contador:=0
							$vr_sumaMontos:=0
							$vb_montoOK:=True:C214
							
							COPY ARRAY:C226($at_posDatosFile;$at_encabezados)
							
							If ($vl_columnas>=$vl_columnasFijas)
								$ref2:=Create document:C266(SYS_GetParentNme (document)+"InformeImportacion"+DTS_MakeFromDateTime +".txt")
								If (ok=1)
									$vl_detalles:=Trunc:C95(($vl_columnas-$vl_columnasFijas)/2;0)
									
									$vl_posTotal:=Find in array:C230($at_posDatos;"Total")
									$vl_posFolio:=Find in array:C230($at_posDatos;"Numero")
									If (Dec:C9(($vl_columnas-$vl_columnasFijas)/2)=0)
										RECEIVE PACKET:C104($ref;$text;$delimiter)
										  //$text:=Win to Mac($text)
										$vl_proc:=IT_UThermometer (1;0;__ ("Leyendo archivo txt..."))
										While ($text#"")
											$vr_sumaBoleta:=0
											ARRAY TEXT:C222($at_posDatosFile;0)
											AT_Text2Array (->$at_posDatosFile;$text;"\t")
											AT_RedimArrays ($vl_columnas;->$at_posDatosFile)  //se redimensiona al tamaño del encabezado
											If ($vl_columnas>=$vl_columnasFijas)
												  //For ($i;1;$vl_columnasFijas+$vl_columnas)
												For ($i;1;$vl_columnas)
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($i))
													If ($i<=Size of array:C274($at_posDatosFile))
														$vt_valor:=ST_GetCleanString ($at_posDatosFile{$i})
														If (($i=1) & ($vt_valor=""))
															  //si no viene el folio no se importa la linea
															$i:=$vl_columnasFijas+$vl_columnas
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Línea sin folio. La línea no fue importada."+"\r\n")
															
															$vb_sumar:=False:C215
														Else 
															If ($i=1)
																$vl_contador:=$vl_contador+1
															End if 
															APPEND TO ARRAY:C911($vy_pointer->;$vt_valor)
															If (($i>$vl_columnasFijas) & ($i<=($vl_columnas-$vl_detalles)))
																  //If ($i=$vl_posTotal)
																$vr_sumaBoleta:=$vr_sumaBoleta+Num:C11($vy_pointer->{$vl_contador})
															End if 
															$vb_sumar:=True:C214
														End if 
													End if 
												End for 
												
												If ($vb_sumar)
													$vl_posIVA:=Find in array:C230($at_posDatos;"IVA")
													$vy_pointerIVA:=Get pointer:C304("aQR_Text"+String:C10($vl_posIVA))
													$vr_montoBoleta:=$vr_sumaBoleta+Num:C11($vy_pointerIVA->{$vl_contador})
													
													$vy_pointerTotal:=Get pointer:C304("aQR_Text"+String:C10($vl_posTotal))
													If (Num:C11($vy_pointerTotal->{$vl_contador})#$vr_montoBoleta)
														$vb_montoOK:=False:C215
														$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posFolio))
														$b_hayError:=True:C214
														IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Monto documento incorrecto para folio "+$vy_pointer->{$vl_contador}+". Proceso interrumpido."+"\r\n")
													End if 
													
													$vr_sumaMontos:=$vr_sumaMontos+$vr_montoBoleta
												End if 
												RECEIVE PACKET:C104($ref;$text;$delimiter)
												  //$text:=Win to Mac($text)
											End if 
										End while 
										CLOSE DOCUMENT:C267($ref)
										IT_UThermometer (-2;$vl_proc)
										
										  //valida encabezados
										If (Not:C34($b_hayError))
											$b_encabezadosOK:=True:C214
											  //$vl_columnas:=Size of array($at_posDatosFile)
											  //$vl_columnasFijas:=Size of array($at_posDatos)
											For ($l_indice;1;Size of array:C274($at_posDatos))
												If ($at_posDatos{$l_indice}#$at_encabezados{$l_indice})
													$b_encabezadosOK:=False:C215
													$b_hayError:=True:C214
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"No fueron encontrados todos los encabezados en el archivo a importar. Encabezado: "+$at_posDatos{$l_indice}+" no encontrado en la posición "+String:C10($l_indice)+". Proceso interrumpido."+"\r\n")
													$l_indice:=Size of array:C274($at_posDatos)
												End if 
											End for 
										End if 
										
										If (Not:C34($b_hayError))
											  //validando rut
											$vb_rutOK:=True:C214
											$vl_posRUT:=Find in array:C230($at_posDatos;"RUT")
											$vl_posFolio:=Find in array:C230($at_posDatos;"Numero")
											$vl_posTotal:=Find in array:C230($at_posDatos;"Total")
											If (($vl_posRUT>0) & ($vl_posFolio>0))
												For ($i;1;Size of array:C274(aQR_Text1))
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posTotal))
													$vr_total:=Num:C11($vy_pointer->{$i})
													
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
													$vy_pointer->{$i}:=Replace string:C233(Replace string:C233(Replace string:C233($vy_pointer->{$i};".";"");"-";"");"#N/A";"")
													$vy_pointer->{$i}:=Replace string:C233($vy_pointer->{$i};" ";"")
													$vt_rutFile:=$vy_pointer->{$i}
													$vt_rut:=CTRY_CL_VerifRUT ($vt_rutFile;False:C215)
													If ($vt_rut="") & ($vr_total>0)
														$vb_rutOK:=False:C215
														$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posFolio))
														$b_hayError:=True:C214
														IO_SendPacket ($ref2;"[ERROR]"+"\t"+"RUT "+$vt_rutFile+" incorrecto para folio "+$vy_pointer->{$i}+". Proceso interrumpido."+"\r\n")
													End if 
												End for 
											Else 
												$vb_rutOK:=False:C215
											End if 
										End if 
										
										  //validando giro, direccion, comuna y ciudad -datos necesario para emitir DTEs-
										If (Not:C34($b_hayError))
											$vb_giroOK:=True:C214
											
											$b_direccionOK:=True:C214
											$b_comunaOK:=True:C214
											$b_ciudadOK:=True:C214
											$b_emailOK:=True:C214
											
											$vy_pointerRUT:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
											$vl_posGiro:=Find in array:C230($at_posDatos;"Giro")
											
											$l_posDireccion:=Find in array:C230($at_posDatos;"Direccion")
											$l_posComuna:=Find in array:C230($at_posDatos;"Comuna")
											$l_posCiudad:=Find in array:C230($at_posDatos;"Ciudad")
											
											$b_continuar:=True:C214
											Case of 
												: ($vl_posGiro=-1)
													$b_continuar:=False:C215
													$vb_giroOK:=False:C215
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Posición para Giro "+$vt_rut+" no encontrada en archivo a importar "+String:C10($i)+". Proceso interrumpido."+"\r\n")
													
												: ($l_posDireccion=-1)
													$b_continuar:=False:C215
													$b_direccionOK:=False:C215
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Posición para Dirección "+$vt_rut+" no encontrada en archivo a importar "+String:C10($i)+". Proceso interrumpido."+"\r\n")
													
												: ($l_posComuna=-1)
													$b_continuar:=False:C215
													$b_comunaOK:=False:C215
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Posición para Comuna "+$vt_rut+" no encontrada en archivo a importar "+String:C10($i)+". Proceso interrumpido."+"\r\n")
													
												: ($l_posCiudad=-1)
													$b_continuar:=False:C215
													$b_ciudadOK:=False:C215
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Posición para Ciudad "+$vt_rut+" no encontrada en archivo a importar "+String:C10($i)+". Proceso interrumpido."+"\r\n")
													
											End case 
											
											If ($b_continuar)
												For ($i;1;Size of array:C274(aQR_Text1))
													  //giro
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posGiro))
													$vy_pointer->{$i}:=Replace string:C233($vy_pointer->{$i};"#N/A";"")
													If ($vy_pointer->{$i}="")
														$vt_rut:=$vy_pointerRUT->{$i}
														$vl_find:=Find in field:C653([ACT_Terceros:138]RUT:4;$vt_rut)
														If ($vl_find<0)  // si ya existe se puede continuar...
															$vb_giroOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Giro "+$vt_rut+" vacío para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
														End if 
													End if 
													
													  //direccion
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($l_posDireccion))
													$vy_pointer->{$i}:=Replace string:C233($vy_pointer->{$i};"#N/A";"")
													If ($vy_pointer->{$i}="")
														$vt_rut:=$vy_pointerRUT->{$i}
														$vl_find:=Find in field:C653([ACT_Terceros:138]RUT:4;$vt_rut)
														If ($vl_find<0)  // si ya existe se puede continuar...
															$b_direccionOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Dirección "+$vt_rut+" vacía para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
														End if 
													End if 
													
													  //comuna
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($l_posComuna))
													$vy_pointer->{$i}:=Replace string:C233($vy_pointer->{$i};"#N/A";"")
													If ($vy_pointer->{$i}="")
														$vt_rut:=$vy_pointerRUT->{$i}
														$vl_find:=Find in field:C653([ACT_Terceros:138]RUT:4;$vt_rut)
														If ($vl_find<0)  // si ya existe se puede continuar...
															$b_comunaOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Comuna "+$vt_rut+" vacía para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
														End if 
													End if 
													
													  //ciudad
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($l_posCiudad))
													$vy_pointer->{$i}:=Replace string:C233($vy_pointer->{$i};"#N/A";"")
													If ($vy_pointer->{$i}="")
														$vt_rut:=$vy_pointerRUT->{$i}
														$vl_find:=Find in field:C653([ACT_Terceros:138]RUT:4;$vt_rut)
														If ($vl_find<0)  // si ya existe se puede continuar...
															$b_ciudadOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Ciudad "+$vt_rut+" vacía para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
														End if 
													End if 
													
													  //20150107 RCH mail invalido
													$l_posEmail:=Find in array:C230($at_posDatos;"MailEnvioDTE")
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($l_posEmail))
													$vy_pointer->{$i}:=Replace string:C233($vy_pointer->{$i};"#N/A";"")
													If ($vy_pointer->{$i}#"")
														C_TEXT:C284($t_mail)
														$vt_rut:=$vy_pointerRUT->{$i}
														$t_mail:=ACTdte_VerificaEmail ($vy_pointer->{$i};False:C215)
														If ($t_mail="")
															$b_emailOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Cuenta de email envío PDF "+$vt_rut+" inválida para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
														Else 
															$vy_pointer->{$i}:=$t_mail
														End if 
													End if 
													
													
												End for 
											End if 
										End if 
										
										If (Not:C34($b_hayError))
											$vb_refOK:=True:C214
											$vy_pointerRUT:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
											  //validando referencias
											$vl_posTipoDoc:=Find in array:C230($at_posDatos;"TipoDocRef")
											$vl_posFolio:=Find in array:C230($at_posDatos;"FolioDocRef")
											$vl_posCodRef:=Find in array:C230($at_posDatos;"CodigRef")
											$vl_posRRef:=Find in array:C230($at_posDatos;"RazonRef")
											$vl_posFechaRef:=Find in array:C230($at_posDatos;"FechaRef")
											If ($vl_posTipoDoc>0)
												For ($i;1;Size of array:C274(aQR_Text1))
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posTipoDoc))
													$vy_pointer2:=Get pointer:C304("aQR_Text"+String:C10($vl_posFolio))
													$vy_pointer3:=Get pointer:C304("aQR_Text"+String:C10($vl_posCodRef))
													$vy_pointer4:=Get pointer:C304("aQR_Text"+String:C10($vl_posRRef))
													$vy_pointer6:=Get pointer:C304("aQR_Text"+String:C10($vl_posFechaRef))
													$vy_pointer->{$i}:=ST_Boolean2Str ($vy_pointer->{$i}="0";"";$vy_pointer->{$i})
													$vy_pointer2->{$i}:=ST_Boolean2Str ($vy_pointer2->{$i}="0";"";$vy_pointer2->{$i})
													$vy_pointer3->{$i}:=ST_Boolean2Str ($vy_pointer3->{$i}="0";"";$vy_pointer3->{$i})
													$vy_pointer4->{$i}:=ST_Boolean2Str ($vy_pointer4->{$i}="0";"";$vy_pointer4->{$i})
													$vy_pointer6->{$i}:=ST_Boolean2Str ($vy_pointer6->{$i}="0";"";$vy_pointer6->{$i})
													
													  //C_TEXT($t_tipo;$t_folio;$t_codigoRef;$t_razonRef;$t_fechaRef)
													  //C_LONGINT($l_cantidadRef)
													
													If (($vy_pointer->{$i}#"") | ($vy_pointer2->{$i}#"") | ($vy_pointer3->{$i}#"") | ($vy_pointer4->{$i}#""))
														If (($vy_pointer->{$i}="") | ($vy_pointer2->{$i}="") | ($vy_pointer3->{$i}="") | ($vy_pointer4->{$i}=""))
															$vb_refOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Referencias "+$vy_pointerRUT->{$i}+" vacío para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
														Else 
															
															READ ONLY:C145([ACT_Boletas:181])
															QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=$vy_pointer->{$i};*)
															QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=$vy_pointer2->{$i})
															If (Records in selection:C76([ACT_Boletas:181])#1)
																IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Referencias "+$vy_pointerRUT->{$i}+",línea "+String:C10($i)+". No se encuentra el documento de referencia en la base. Tipo: "+$vy_pointer->{$i}+", Folio: "+$vy_pointer2->{$i}+". El documento se importará de todas maneras."+"\r\n")
															Else 
																$vy_pointer5:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
																If ([ACT_Boletas:181]ID_Tercero:21#0)
																	KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
																	$t_rutComp:=[ACT_Terceros:138]RUT:4
																Else 
																	KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
																	$t_rutComp:=[Personas:7]RUT:6
																End if 
																If ($t_rutComp#$vy_pointer5->{$i})
																	$vb_refOK:=False:C215
																	$b_hayError:=True:C214
																	IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Referencias "+$vy_pointerRUT->{$i}+" inconsistentes para línea "+String:C10($i)+". EL rut del documento no corresponde al rut a importar. Proceso interrumpido."+"\r\n")
																Else 
																	If ($vy_pointer6->{$i}#"")
																		If ([ACT_Boletas:181]FechaEmision:3#Date:C102($vy_pointer6->{$i}))
																			$vb_refOK:=False:C215
																			$b_hayError:=True:C214
																			IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Fecha indicada en el archivo es diferente a la fecha del documento en la base de datos para RUT "+$vy_pointerRUT->{$i}+", para línea "+String:C10($i)+". Proceso interrumpido."+"\r\n")
																		End if 
																	End if 
																End if 
															End if 
														End if 
													End if 
												End for 
											Else 
												$vb_refOK:=False:C215
											End if 
										End if 
										
										  //validando largo de detalles
										If (Not:C34($b_hayError))
											$vb_detalleOK:=True:C214
											$vy_pointerRUT:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
											For ($i;1;Size of array:C274(aQR_Text1))
												For ($j;1;$vl_detalles)
													$vy_pointerDetalle:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+$vl_detalles+$j))
													If ($i<=Size of array:C274($vy_pointerDetalle->))
														
														  //Elimina "0" de detalle
														If ($vy_pointerDetalle->{$i}="0")
															$vy_pointerDetalle->{$i}:=""
														End if 
														
														If (Length:C16($vy_pointerDetalle->{$i})>80)
															$vb_detalleOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Largo de detalle para RUT: "+$vy_pointerRUT->{$i}+" supera los 80 caracteres. Proceso interrumpido."+"\r\n")
														End if 
														
														  //valida que no haya ";"
														If (Position:C15(";";$vy_pointerDetalle->{$i})>0)
															$vb_detalleOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"En el detalle hay un caracter "+ST_Qte (";")+". Dicho caracter es usado para separar la información, por lo tanto no está permitido como parte del detalle. RUT: "+$vy_pointerRUT->{$i}+". Proceso interrumpido."+"\r\n")
														End if 
														
													End if 
												End for 
											End for 
										End if 
										
										  //20130404 RCH Se agregan validaciones de monto y de folios disponibles. Fue agregada una columna a la plantilla de importacion...
										  //valido montos neto, exento, iva y total
										If (Not:C34($b_hayError))
											$b_montosTotalesOK:=True:C214
											$vl_posNeto:=Find in array:C230($at_posDatos;"Neto")
											$vl_posExento:=Find in array:C230($at_posDatos;"Exento")
											$vl_posIVA:=Find in array:C230($at_posDatos;"IVA")
											$vl_posTotal:=Find in array:C230($at_posDatos;"Total")
											$vy_pointerRUT:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
											If (($vl_posNeto#-1) & ($vl_posExento#-1) & ($vl_posIVA#-1) & ($vl_posTotal#-1))
												$vy_pointerNeto:=Get pointer:C304("aQR_Text"+String:C10($vl_posNeto))
												$vy_pointerExento:=Get pointer:C304("aQR_Text"+String:C10($vl_posExento))
												$vy_pointerIVA:=Get pointer:C304("aQR_Text"+String:C10($vl_posIVA))
												$vy_pointerTotal:=Get pointer:C304("aQR_Text"+String:C10($vl_posTotal))
												For ($i;1;Size of array:C274(aQR_Text1))
													If ((Num:C11($vy_pointerNeto->{$i})+Num:C11($vy_pointerExento->{$i})+Num:C11($vy_pointerIVA->{$i}))#Num:C11($vy_pointerTotal->{$i}))
														$b_montosTotalesOK:=False:C215
														$b_hayError:=True:C214
														IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Monto Neto más Exento más IVA es diferente a Monto total para RUT: "+$vy_pointerRUT->{$i}+". Proceso interrumpido."+"\r\n")
													End if 
													If (Num:C11($vy_pointerIVA->{$i})>0)
														APPEND TO ARRAY:C911(ab_documentoAfecto;True:C214)
													Else 
														APPEND TO ARRAY:C911(ab_documentoAfecto;False:C215)
													End if 
												End for 
											Else 
												$b_montosTotalesOK:=False:C215
												$b_hayError:=True:C214
												IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Línea para RUT: "+$vy_pointerRUT->{$i}+" no existe Neto, Exento, IVA. Proceso interrumpido."+"\r\n")
											End if 
										End if 
										
										  //valido que existan CAF disponibles para la importacion
										If (Not:C34($b_hayError))
											$b_foliosDisponibles:=True:C214
											If (cs_documentoDigital=1)
												ARRAY LONGINT:C221($DA_Return;0)
												ab_documentoAfecto{0}:=True:C214
												$l_afectos:=AT_SearchArray (->ab_documentoAfecto;"=";->$DA_Return)
												ab_documentoAfecto{0}:=False:C215
												$l_exentos:=AT_SearchArray (->ab_documentoAfecto;"=";->$DA_Return)
												$l_tipoSII:=0
												If ($l_afectos>0)
													Case of 
														: (($vl_tipoDcto=-1) | ($vl_tipoDcto>0))
															$l_tipoSII:=39
														: ($vl_tipoDcto=-3)
															$l_tipoSII:=33
														: ($vl_tipoDcto=-4)
															$l_tipoSII:=61
														: ($vl_tipoDcto=-5)
															$l_tipoSII:=56
														Else 
															$l_tipoSII:=0
													End case 
													If ($l_tipoSII#0)
														ARRAY LONGINT:C221($al_recNumFolios;0)
														READ ONLY:C145([ACT_FoliosDT:293])
														QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]tipo_dteSII:7=$l_tipoSII;*)
														QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]id_razonSocial:8=$r_idRS;*)
														QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1)
														LONGINT ARRAY FROM SELECTION:C647([ACT_FoliosDT:293];$al_recNumFolios;"")
														$l_foliosDisponibles:=0
														For ($l_folios;1;Size of array:C274($al_recNumFolios))
															GOTO RECORD:C242([ACT_FoliosDT:293];$al_recNumFolios{$l_folios})
															$l_foliosDisponibles:=$l_foliosDisponibles+([ACT_FoliosDT:293]hasta:5-[ACT_FoliosDT:293]folio_disponible:6)+1
														End for 
														If ($l_afectos>$l_foliosDisponibles)
															$b_foliosDisponibles:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"No hay folios disponibles suficientes, para el tipo "+ST_Qte (String:C10($l_tipoSII))+", para emitir los documentos. Folios necesarios: "+String:C10($l_afectos)+", folios disponibles: "+String:C10($l_foliosDisponibles)+". Proceso interrumpido."+"\r\n")
														End if 
													Else 
														$b_foliosDisponibles:=False:C215
														$b_hayError:=True:C214
														IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Código SII para tipo de documento "+String:C10($vl_tipoDcto)+"no reconocido. Proceso interrumpido."+"\r\n")
													End if 
												End if 
												If ($l_exentos>0)
													Case of 
														: (($vl_tipoDcto=-1) | ($vl_tipoDcto>0))
															$l_tipoSII:=41
														: ($vl_tipoDcto=-3)
															$l_tipoSII:=34
														: ($vl_tipoDcto=-4)
															$l_tipoSII:=61
														: ($vl_tipoDcto=-5)
															$l_tipoSII:=56
														Else 
															$l_tipoSII:=0
													End case 
													If ($l_tipoSII#0)
														READ ONLY:C145([ACT_FoliosDT:293])
														QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]tipo_dteSII:7=$l_tipoSII;*)
														QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]id_razonSocial:8=$r_idRS;*)
														QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1)
														LONGINT ARRAY FROM SELECTION:C647([ACT_FoliosDT:293];$al_recNumFolios;"")
														$l_foliosDisponibles:=0
														For ($l_folios;1;Size of array:C274($al_recNumFolios))
															GOTO RECORD:C242([ACT_FoliosDT:293];$al_recNumFolios{$l_folios})
															$l_foliosDisponibles:=$l_foliosDisponibles+([ACT_FoliosDT:293]hasta:5-[ACT_FoliosDT:293]folio_disponible:6)+1
														End for 
														If ($l_exentos>$l_foliosDisponibles)
															$b_foliosDisponibles:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"No hay folios disponibles suficientes, para el tipo "+ST_Qte (String:C10($l_tipoSII))+", para emitir los documentos. Folios necesarios: "+String:C10($l_exentos)+", folios disponibles: "+String:C10($l_foliosDisponibles)+". Proceso interrumpido."+"\r\n")
														End if 
													Else 
														$b_foliosDisponibles:=False:C215
														$b_hayError:=True:C214
														IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Código SII para tipo de documento "+String:C10($vl_tipoDcto)+"no reconocido. Proceso interrumpido."+"\r\n")
													End if 
												End if 
											End if 
										End if 
										
										
										  //valida que para el codigo de referencia 2 vengan los textos Donde dice, debe decir
										  //centralizar validaciones SII
										
										  //valida detalles con montos
										If (Not:C34($b_hayError))
											$b_detallesOK:=True:C214
											$l_detalles:=($vl_columnas-$vl_columnasFijas)/2
											$vy_pointerRUT:=Get pointer:C304("aQR_Text"+String:C10($vl_posRUT))
											For ($i;1;Size of array:C274(aQR_Text1))
												For ($j;$vl_columnasFijas+1;$vl_columnas-$l_detalles)
													$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($j))  //monto
													$vy_pointer2:=Get pointer:C304("aQR_Text"+String:C10($j+$l_detalles))  //glosa
													If (($i<=Size of array:C274($vy_pointer->)) & ($i<=Size of array:C274($vy_pointer2->)))
														If ((Num:C11($vy_pointer->{$i})#0) & ($vy_pointer2->{$i}=""))
															$b_detallesOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Líneas de montos sin glosas para RUT: "+$vy_pointerRUT->{$i}+". Proceso interrumpido."+"\r\n")
														End if 
													Else 
														
													End if 
												End for 
											End for 
										End if 
										
										  //20160505 RCSe verifica emision de ND
										  //valido montos neto, exento, iva y total
										If (Not:C34($b_hayError))
											$b_ndOK:=True:C214
											If ($vl_tipoDcto=-5)
												$vy_pointerIVA:=Get pointer:C304("aQR_Text"+String:C10($vl_posIVA))
												$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posTipoDoc))
												For ($i;1;Size of array:C274(aQR_Text1))
													If ($vy_pointer->{$i}#"")
														If ((Num:C11($vy_pointerIVA->{$i})#0) & (($vy_pointer->{$i}="34") | ($vy_pointer->{$i}="41")))
															$b_ndOK:=False:C215
															$b_hayError:=True:C214
															IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Nota de débito afecta para un documento exento para rut: "+$vy_pointerRUT->{$i}+". Proceso interrumpido."+"\r\n")
														End if 
													End if 
												End for 
											End if 
										End if 
										
										TRACE:C157
										
										  //If (($vb_rutOK) & ($vb_giroOK) & ($vb_refOK) & ($vb_montoOK) & ($vb_detalleOK) & ($b_montosTotalesOK) & ($b_foliosDisponibles) & ($b_detallesOK))
										If (($vb_rutOK) & ($vb_giroOK) & ($vb_refOK) & ($vb_montoOK) & ($vb_detalleOK) & ($b_montosTotalesOK) & ($b_foliosDisponibles) & ($b_detallesOK) & ($b_direccionOK) & ($b_comunaOK) & ($b_ciudadOK) & ($b_emailOK) & ($b_encabezadosOK))
											
											  //If (($vb_rutOK) & ($vb_giroOK) & ($vb_montoOK) & ($vb_detalleOK) & ($b_montosTotalesOK) & ($b_foliosDisponibles))
											$vl_resp:=CD_Dlog (0;"Se procesará(n) "+String:C10($vl_contador)+" registro(s) de "+ST_Qte (ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$l_tipoSII))+", por un monto total de "+String:C10($vr_sumaMontos;"|Despliegue_ACT_Pagos")+"."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
											If ($vl_resp=1)
												  //se setean variables a utilizar en el metodo que genera la deuda
												
												IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Inicio procesamiento de archivo: "+ST_Qte ($document)+"."+"\r\n")
												
												C_LONGINT:C283(RNTercero)
												ptrACTpgs_Table:=->[ACT_Terceros:138]
												ptrACTpgs_FieldID:=->[ACT_Terceros:138]Id:1
												ptrACTpgs_VarRecNum:=->RNTercero
												ptrACTpgs_FieldDT:=->[ACT_Terceros:138]id_CatDocTrib:55
												
												  //para validar montos emitidos en avisos...
												READ ONLY:C145([ACT_Cargos:173])
												ALL RECORDS:C47([ACT_Cargos:173])
												$vl_idCargoMayor:=Max:C3([ACT_Cargos:173]ID:1)
												
												$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando documento para el folio ")
												For ($i;1;Size of array:C274(aQR_Text1))
													
													ACTpgs_OpcionesVR ("ACT_initArrays")
													
													  // datos del documento
													$l_posFolio:=Find in array:C230($at_posDatos;"Número")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posFolio))
													$vl_folioDT:=Num:C11(vQR_Pointer1->{$i})
													
													$l_posFecha:=Find in array:C230($at_posDatos;"Fecha")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posFecha))
													$vd_fechaDT:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(vQR_Pointer1->{$i};1;2));Num:C11(Substring:C12(vQR_Pointer1->{$i};4;2));Num:C11(Substring:C12(vQR_Pointer1->{$i};7;4)))
													
													$l_posMontoNeto:=Find in array:C230($at_posDatos;"Neto")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posMontoNeto))
													$vt_monto:=Num:C11(vQR_Pointer1->{$i})
													
													$l_posIVA:=Find in array:C230($at_posDatos;"IVA")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posIVA))
													$vt_iva:=Num:C11(vQR_Pointer1->{$i})
													
													$l_posTotal:=Find in array:C230($at_posDatos;"Total")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posTotal))
													$vr_total:=Num:C11(vQR_Pointer1->{$i})
													
													$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Text1);"Generando documento para el folio "+String:C10($vl_folioDT)+"...")
													
													  //si ya existe un documento con el mismo folio, no importo el registro.
													$vl_records:=0  //20130206 RCH No se valida. Con fines de pruebas.
													  //If ($vl_folioDT>0)
													  //SET QUERY DESTINATION(Into variable;$vl_records)
													  //QUERY([ACT_Boletas];[ACT_Boletas]ID_Categoria=$vl_tipoDcto;*)
													  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_RazonSocial=$r_idRS;*)
													  //If (cs_documentoDigital=1)
													  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]documento_electronico=True;*)
													  //Else 
													  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]documento_electronico=False;*)
													  //End if 
													  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]Numero=$vl_folioDT)
													  //SET QUERY DESTINATION(Into current selection)
													  //End if 
													$l_posRazonSocial:=Find in array:C230($at_posDatos;"Razón Social")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posRazonSocial))
													$vt_rs:=ST_GetCleanString (vQR_Pointer1->{$i})
													
													$l_posRUT:=Find in array:C230($at_posDatos;"RUT")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posRUT))
													$vt_rut:=ST_GetCleanString (Replace string:C233(Replace string:C233(vQR_Pointer1->{$i};".";"");"-";""))
													
													$l_posDir:=Find in array:C230($at_posDatos;"Dirección")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posDir))
													$vt_direccion:=ST_GetCleanString (vQR_Pointer1->{$i})
													
													$l_posComuna:=Find in array:C230($at_posDatos;"Comuna")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posComuna))
													$vt_comuna:=ST_GetCleanString (vQR_Pointer1->{$i})
													
													$l_posCiudad:=Find in array:C230($at_posDatos;"Ciudad")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posCiudad))
													$vt_ciudad:=ST_GetCleanString (vQR_Pointer1->{$i})
													
													$l_posGiro:=Find in array:C230($at_posDatos;"Giro")
													vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posGiro))
													$vt_giro:=ST_GetCleanString (vQR_Pointer1->{$i})
													
													If ($vl_records=0)
														  //datos del receptor
														$vb_esEmpresa:=True:C214
														  //valida receptor, si no existe lo crea
														vlACT_idTercero:=0
														If ($vt_rut#"")
															READ ONLY:C145([ACT_Terceros:138])
															QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4=$vt_rut)
															If (Records in selection:C76([ACT_Terceros:138])=0)
																  //datos del receptor
																$vl_ok:=ACTter_CreateRecord ($vt_rut;$vt_rs;$vb_esEmpresa;$vt_direccion;$vt_comuna;$vt_ciudad;$vt_giro)
																
																QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4=$vt_rut)
																vlACT_idTercero:=[ACT_Terceros:138]Id:1
																Case of 
																	: ($vl_ok=1)
																		  //vlACT_idTercero
																		IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Tercero "+$vt_rs+" creado."+"\r\n")
																	: ($vl_ok=-1)
																		$b_hayError:=True:C214
																		IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Faltan datos para crear el tercero."+"\r\n")
																	Else 
																		$b_hayError:=True:C214
																		IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Tercero "+$vt_rs+" no creado."+"\r\n")
																End case 
															Else 
																vlACT_idTercero:=[ACT_Terceros:138]Id:1
																READ WRITE:C146([ACT_Terceros:138])
																KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vlACT_idTercero;True:C214)
																
																If ($vt_rs#"")
																	[ACT_Terceros:138]Razon_Social:3:=ST_GetCleanString ($vt_rs)
																End if 
																If ($vt_direccion#"")
																	[ACT_Terceros:138]Direccion:5:=ST_GetCleanString ($vt_direccion)
																End if 
																If ($vt_comuna#"")
																	[ACT_Terceros:138]Comuna:6:=ST_GetCleanString ($vt_comuna)
																End if 
																If ($vt_ciudad#"")
																	[ACT_Terceros:138]Ciudad:7:=ST_GetCleanString ($vt_ciudad)
																End if 
																If ($vt_giro#"")
																	[ACT_Terceros:138]Giro:8:=ST_GetCleanString ($vt_giro)
																End if 
																
																ACTter_ActualizaNombreCompleto 
																
																SAVE RECORD:C53([ACT_Terceros:138])
																
																KRL_ReloadAsReadOnly (->[ACT_Terceros:138])
																
															End if 
															
															KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vlACT_idTercero;True:C214)
															$l_posMailDTE:=Find in array:C230($at_posDatos;"MailEnvioDTE")
															vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($l_posMailDTE))
															[ACT_Terceros:138]DTE_email_envio_dte:75:=ST_GetCleanString (vQR_Pointer1->{$i})
															If ([ACT_Terceros:138]DTE_email_envio_dte:75#"")
																[ACT_Terceros:138]DTE_enviar_por_mail:74:=True:C214
															Else 
																[ACT_Terceros:138]DTE_enviar_por_mail:74:=False:C215
															End if 
															If (KRL_FieldChanges (->[ACT_Terceros:138]DTE_enviar_por_mail:74))
																IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Tercero "+[ACT_Terceros:138]Nombre_Completo:9+", rut: "+[ACT_Terceros:138]RUT:4+", tenía el campo para enviar dte por correo electrónico en "+String:C10(Old:C35([ACT_Terceros:138]DTE_enviar_por_mail:74))+" y quedó en: "+String:C10([ACT_Terceros:138]DTE_enviar_por_mail:74)+" "+$vt_rs+" creado."+"\r\n")
															End if 
															SAVE RECORD:C53([ACT_Terceros:138])
															KRL_ReloadAsReadOnly (->[ACT_Terceros:138])
															
														End if 
														If (vlACT_idTercero>0)
															KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vlACT_idTercero;True:C214)
															RNTercero:=Record number:C243([ACT_Terceros:138])
															$vl_tipoDocTercero:=[ACT_Terceros:138]id_CatDocTrib:55
															[ACT_Terceros:138]id_CatDocTrib:55:=$vl_tipoDcto
															SAVE RECORD:C53([ACT_Terceros:138])
															
															  //si es afecto se deja todo en una linea por la tasa de interes
															$vl_posIVA:=Find in array:C230($at_posDatos;"IVA")
															$vy_pointerIVA:=Get pointer:C304("aQR_Text"+String:C10($vl_posIVA))
															If (Num:C11($vy_pointerIVA->{$i})>0)
																
																If (cs_detallar=0)
																	$vr_montoAcumulado:=0
																	For ($j;1;$vl_detalles)
																		$vy_pointerMonto:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+$j))
																		If (Num:C11($vy_pointerMonto->{$i})>0)
																			$vr_montoAcumulado:=$vr_montoAcumulado+Num:C11($vy_pointerMonto->{$i})
																		End if 
																	End for 
																	$vy_pointerMonto:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+1))
																	$vy_pointerDetalle:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+1+$vl_detalles))
																	$vy_pointerMonto->{$i}:=String:C10($vr_montoAcumulado+Round:C94($vr_montoAcumulado*(<>VRACT_TASAIVA/100);<>vlACT_Decimales))
																	  //$vy_pointerDetalle->{$i}:="Asesorias Colegium + IVA"
																	  //$vy_pointerDetalle->{$i}:="Asesorias Colegium"
																	  //$vy_pointerDetalle->{$i}:=$vy_pointerDetalle->
																	TRACE:C157
																	$vl_iteracion:=1
																	$vb_afecto:=True:C214
																Else 
																	$vr_montoIVADocto:=0
																	For ($j;1;$vl_detalles)
																		$vy_pointerMonto:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+$j))
																		If (Num:C11($vy_pointerMonto->{$i})>0)
																			$vr_montoIVALinea:=Round:C94(Num:C11($vy_pointerMonto->{$i})*(<>VRACT_TASAIVA/100);<>vlACT_Decimales)
																			$vr_montoIVADocto:=$vr_montoIVADocto+$vr_montoIVALinea
																			$vy_pointerMonto->{$i}:=String:C10(Num:C11($vy_pointerMonto->{$i})+$vr_montoIVALinea)
																		End if 
																	End for 
																	
																	$vl_iteracion:=$vl_detalles
																	$vb_afecto:=True:C214
																	
																	If (Num:C11($vy_pointerIVA->{$i})#$vr_montoIVADocto)
																		$b_hayError:=True:C214
																		IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Error en cálculo de monto IVA. El detalle no corresponde al total del IVA."+"\r\n")
																	End if 
																	
																End if 
															Else 
																$vl_iteracion:=$vl_detalles
																$vb_afecto:=False:C215
															End if 
															
															
															
															  //detalles
															  //For ($j;1;$vl_detalles)
															  //$t_detalleNC:=""
															ARRAY TEXT:C222($at_detalleNC;0)
															For ($j;1;$vl_iteracion)
																
																$vy_pointerMonto:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+$j))
																$vy_pointerDetalle:=Get pointer:C304("aQR_Text"+String:C10($vl_columnasFijas+$j+$vl_detalles))
																
																If ((Num:C11($vy_pointerMonto->{$i})>0) | ($vy_pointerDetalle->{$i}#""))
																	  //If ((Num($vy_pointerMonto->{$i})>0) | (($l_tipoSII=61) & ($vy_pointerDetalle->{$i}#"")))
																	READ ONLY:C145([xxACT_Items:179])
																	
																	$vt_glosa:=ST_GetCleanString (Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233($vy_pointerDetalle->{$i};"(";"[");")";"]");"/";"_");"\\";"_"))
																	
																	  //se busca el item de cargo, si no existe, se crea.
																	  //$vb_afecto:=(Position("+ IVA";$vt_glosa)>0)
																	
																	  //If ($l_tipoSII=61)
																	
																	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Glosa:2=$vt_glosa;*)
																	QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]Afecto_IVA:12=$vb_afecto)
																	If (Records in selection:C76([xxACT_Items:179])=0)
																		If ($vy_pointerDetalle->{$i}#"")
																			If (Length:C16($vy_pointerDetalle->{$i})<=80)  //para validar que se importen los caracteres correctos.
																				  //$vb_afecto:=(Position("+ IVA";$vt_glosa)>0)
																				$vb_esDescuento:=False:C215
																				$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
																				  //$vr_monto:=0
																				$vr_monto:=Num:C11($vy_pointerMonto->{$i})
																				$vt_ctaContable:=""
																				$vt_ctaAuxiliar:=""
																				$vt_centroCosto:=""
																				$vt_cctaContable:=""
																				$vt_cctaAuxiliar:=""
																				$vt_ccentroCosto:=""
																				$vb_noIncluirDT:=False:C215
																				$vt_obs:=__ ("Creado por proceso de importación realizado por ")+<>tUSR_CurrentUser+__ (" el ")+String:C10(Current date:C33(*);7)+__ (" a las ")+String:C10(Current time:C178(*);2)
																				  //$vl_idRecord:=ACTitem_CreateRecord ($vt_glosa;$vb_afecto;$vb_esDescuento;$vt_moneda;$vr_monto;$vt_ctaContable;$vt_ctaAuxiliar;$vt_centroCosto;$vt_cctaContable;$vt_cctaAuxiliar;$vt_ccentroCosto;$vb_noIncluirDT;$vt_obs)
																				$vl_idRecord:=ACTitem_CreateRecord ($vt_glosa;$vb_afecto;$vb_esDescuento;$vt_moneda;$vr_monto;$vt_ctaContable;$vt_ctaAuxiliar;$vt_centroCosto;$vt_cctaContable;$vt_cctaAuxiliar;$vt_ccentroCosto;$vb_noIncluirDT;$vt_obs;False:C215;False:C215;False:C215;False:C215;0;False:C215;"";0;"";$r_idRS)  //20150408 RCH Habian problemas con la importacion para otra razon social
																				IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Ítem de cargo creado id: "+String:C10($vl_idRecord)+". "+$vt_obs+"\r\n")
																				$vb_continua:=True:C214
																				
																			Else 
																				$b_hayError:=True:C214
																				$vt_obs:="[ERROR]"+"\t"+"Ítem de cargo no creado porque el largo supera los 80 caracteres."+"\r\n"
																				IO_SendPacket ($ref2;$vt_obs)
																				$vb_continua:=False:C215
																			End if 
																		Else 
																			$b_hayError:=True:C214
																			$vt_obs:="[ERROR]"+"\t"+"Ítem de cargo no creado porque el cargo no tiene glosa."+"\r\n"
																			IO_SendPacket ($ref2;$vt_obs)
																			$vb_continua:=False:C215
																		End if 
																	Else 
																		$vl_idRecord:=[xxACT_Items:179]ID:1
																		$vt_glosa:=[xxACT_Items:179]Glosa:2
																		$vt_obs:=""
																		$vb_continua:=True:C214
																	End if 
																	  //Else 
																	  //ACTqry_CargoEspecial (8)
																	  //KRL_ReloadAsReadOnly (->[xxACT_Items])
																	  //$vl_idRecord:=[xxACT_Items]ID
																	  //$vt_obs:=""
																	  //$vb_continua:=True
																	  //End if 
																	
																	If ($vb_continua)
																		
																		
																		If ($l_tipoSII=61)
																			  //$t_detalleNC:=$t_detalleNC+$vt_glosa+<>crlf
																			APPEND TO ARRAY:C911($at_detalleNC;$vt_glosa)
																		End if 
																		
																		vdACT_FechaPago:=$vd_fechaDT
																		vdACT_FechaE:=$vd_fechaDT
																		
																		APPEND TO ARRAY:C911(arACT_PgsVRCantidad;1)
																		APPEND TO ARRAY:C911(atACT_PgsVRDetalle;$vt_glosa)
																		  //If ($l_tipoSII#"61")
																		APPEND TO ARRAY:C911(arACT_PgsVRMonto;Num:C11($vy_pointerMonto->{$i}))
																		APPEND TO ARRAY:C911(arACT_PgsVRTotal;Num:C11($vy_pointerMonto->{$i}))
																		  //Else 
																		  //APPEND TO ARRAY(arACT_PgsVRMonto;Num($vy_pointerMonto->{$i})*-1)
																		  //APPEND TO ARRAY(arACT_PgsVRTotal;Num($vy_pointerMonto->{$i})*-1)
																		  //End if 
																		APPEND TO ARRAY:C911(alACT_PgsVRIDItem;$vl_idRecord)
																	Else 
																		$j:=$vl_iteracion
																	End if 
																End if 
															End for 
															
															If ($vb_continua)
																  //genera avisos utilizando el codigo de las ventas directas
																$vb_mostrarThermo:=False:C215
																$b_generaMonto0:=True:C214
																ACTpgs_OpcionesVR ("GeneraAvisos";->$vb_mostrarThermo;->$b_generaMonto0)
																If (Size of array:C274(alACT_PgsVDRecNumCargos)>0)
																	IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Avisos emitidos correctamente. Folio: "+String:C10($vl_folioDT)+$vt_obs+"\r\n")
																	
																	
																	  //emision de documentos tributarios
																	READ ONLY:C145([ACT_Cargos:173])
																	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
																	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
																	
																	$vr_montoEnCargos:=$vr_montoEnCargos+ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->alACT_PgsVDRecNumCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
																	
																	CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];alACT_PgsVDRecNumCargos;"")
																	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
																	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
																	
																	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
																	vdACT_FEmisionBol:=vdACT_FechaE
																	vtACT_FEmisionBol:=String:C10(vdACT_FEmisionBol)
																	f1:=1
																	f2:=0
																	
																	i1:=0
																	i2:=1
																	  //para quien
																	e1:=0
																	e2:=0
																	e3:=1  //terceros
																	  //periodos
																	h1:=0
																	  // month year
																	s1:=1
																	s2:=0
																	  // month year?
																	h2:=0
																	h3:=1  // se emite una boleta por aviso
																	
																	vbACT_noGuardarNum:=True:C214
																	
																	ARRAY LONGINT:C221(alACT_idsBoletasEmitidas;0)
																	vbACT_RegistrarIDSBoletas:=True:C214
																	ACTbol_EMasivaDocTribs (False:C215)
																	IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Documento emitido correctamente. Folio: "+String:C10($vl_folioDT)+$vt_obs+"\r\n")
																	
																	  // asigna el folio al documento generado. 
																	  //Se comenta porque el folio lo asigna dtenet
																	  //For ($r;1;Size of array(aSetsDT))
																	  //If (Records in set(aSetsDT{$r})>0)
																	For ($r;1;Size of array:C274(alACT_idsBoletasEmitidas))
																		READ WRITE:C146([ACT_Boletas:181])
																		  //USE SET(aSetsDT{$r})
																		  //LOAD RECORD([ACT_Boletas])
																		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->alACT_idsBoletasEmitidas{$r};True:C214)
																		[ACT_Boletas:181]orden_interno:36:=$vl_folioDT
																		SAVE RECORD:C53([ACT_Boletas:181])
																		KRL_UnloadReadOnly (->[ACT_Boletas:181])
																		
																		$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($vl_posTipoDoc))
																		$vy_pointer2:=Get pointer:C304("aQR_Text"+String:C10($vl_posFolio))
																		$vy_pointer3:=Get pointer:C304("aQR_Text"+String:C10($vl_posCodRef))
																		$vy_pointer4:=Get pointer:C304("aQR_Text"+String:C10($vl_posRRef))
																		$vy_pointer6:=Get pointer:C304("aQR_Text"+String:C10($vl_posFechaRef))
																		
																		If ($vy_pointer->{$i}#"")
																			READ ONLY:C145([ACT_Boletas:181])
																			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=$vy_pointer->{$i};*)
																			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=$vy_pointer2->{$i})
																			If (Records in selection:C76([ACT_Boletas:181])=1)
																				$b_existeEnBD:=True:C214
																				$vl_idBoleta:=[ACT_Boletas:181]ID:1
																			Else 
																				$b_existeEnBD:=False:C215
																			End if 
																			READ WRITE:C146([ACT_Boletas:181])
																			KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->alACT_idsBoletasEmitidas{$r};True:C214)
																			  //TRACE
																			  //[ACT_Boletas]ID_DctoAsociado=
																			If ($b_existeEnBD)
																				[ACT_Boletas:181]ID_DctoAsociado:19:=$vl_idBoleta
																			Else 
																				[ACT_Boletas:181]Referencia_TipoDocumento:37:=$vy_pointer->{$i}
																				[ACT_Boletas:181]Referencia_FolioDocumento:38:=$vy_pointer2->{$i}
																				[ACT_Boletas:181]Referencia_FechaDocumento:39:=Date:C102($vy_pointer6->{$i})
																			End if 
																			[ACT_Boletas:181]codigo_referencia:31:=Num:C11($vy_pointer3->{$i})
																			[ACT_Boletas:181]Referencia_Razon:40:=$vy_pointer4->{$i}
																			
																			  //se debe llenar este campo con el detalle de la NC. Maximo 255.
																			If (([ACT_Boletas:181]codigo_referencia:31=2) & ([ACT_Boletas:181]codigo_SII:33="61"))
																				$l_offSet:=BLOB_Variables2Blob (->[ACT_Boletas:181]xDetalleNC:41;0;->$at_detalleNC)
																				  //[ACT_Boletas]Detalle_NC:=$t_detalleNC
																			End if 
																			
																			SAVE RECORD:C53([ACT_Boletas:181])
																		Else 
																			READ ONLY:C145([ACT_Boletas:181])
																			KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->alACT_idsBoletasEmitidas{$r};True:C214)
																		End if 
																		
																		$vr_montoBoletas:=$vr_montoBoletas+Sum:C1([ACT_Boletas:181]Monto_Total:6)
																		SET_ClearSets (aSetsDT{$r})
																		
																		KRL_UnloadReadOnly (->[ACT_Boletas:181])
																		
																		  //End if 
																	End for 
																	  //ACTmnu_Boletas
																	
																	AT_Initialize (->alACT_idsBoletasEmitidas)
																	vbACT_RegistrarIDSBoletas:=False:C215
																	
																Else 
																	$b_hayError:=True:C214
																	IO_SendPacket ($ref2;"[Error]"+"\t"+"Avisos no emitidos. Folio: "+String:C10($vl_folioDT)+$vt_obs+"\r\n")
																End if 
															Else 
																$b_hayError:=True:C214
																IO_SendPacket ($ref2;"[Error]"+"\t"+"Avisos no emitidos. Folio: "+String:C10($vl_folioDT)+$vt_obs+"\r\n")
															End if 
															
															  //retorna el id de la categoria que tenia
															KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vlACT_idTercero;True:C214)
															[ACT_Terceros:138]id_CatDocTrib:55:=$vl_tipoDocTercero
															SAVE RECORD:C53([ACT_Terceros:138])
															KRL_UnloadReadOnly (->[ACT_Terceros:138])
															
															SET_ClearSets ("Selection")
														Else 
															If ($vr_total=0)
																C_BOOLEAN:C305($vb_aviso)
																If (Not:C34($vb_aviso))
																	TRACE:C157
																	  //generar metodo para importar facturas nulas
																	$vb_aviso:=True:C214
																End if 
																  //ACTbol_CreaBoletaNula
															Else 
																$b_hayError:=True:C214
																IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Documento tipo "+atACT_Categorias{atACT_Categorias}+", folio "+String:C10($vl_folioDT)+". El tercero no pudo ser creado. El registro no fue importado."+"\r\n")
															End if 
														End if 
														
													Else 
														$b_hayError:=True:C214
														IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Documento tipo "+atACT_Categorias{atACT_Categorias}+", folio "+String:C10($vl_folioDT)+" ya existe en la base de datos. El registro no fue importado."+"\r\n")
													End if 
												End for 
												$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
												
												  //validacion montos importados
												C_TEXT:C284($vt_msj)
												If (($vr_sumaMontos=$vr_montoBoletas) & ($vr_sumaMontos=$vr_montoEnCargos))
													  //importacion ok
													IO_SendPacket ($ref2;"[Mensaje]"+"\t"+"Montos importados: Monto a importar: "+String:C10($vr_sumaMontos)+". Monto en cargos: "+String:C10($vr_montoEnCargos)+". Monto en Documentos tributarios: "+String:C10($vr_montoBoletas)+"."+"\r\n")
													$vt_msj:="Proceso terminado."
												Else 
													  //Problema
													$b_hayError:=True:C214
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Montos importados no corresponden. Monto a importar: "+String:C10($vr_sumaMontos)+". Monto en cargos: "+String:C10($vr_montoEnCargos)+". Monto en Documentos tributarios: "+String:C10($vr_montoBoletas)+"."+"\r\n")
													$vt_msj:="Proceso terminado con error. Revise el archivo de importación."
												End if 
												
												READ ONLY:C145([ACT_Cargos:173])
												QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1>$vl_idCargoMayor)
												$vr_montoCargosEmitidos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
												If ($vr_sumaMontos#$vr_montoCargosEmitidos)
													$b_hayError:=True:C214
													IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Montos importados no corresponden. Monto a importar: "+String:C10($vr_sumaMontos)+". Monto en Avisos de Cobranza: "+String:C10($vr_montoCargosEmitidos)+"\r\n")
													$vt_msj:=Choose:C955($vt_msj="";"";"Proceso terminado con error. Revise el archivo de importación.")
												End if 
												
											End if 
										Else 
											$vl_resp:=1
											$vt_msj:="Proceso con error!!!"+"\r\n"+"\r\n"+"Revise el archivo de resultados."+ST_Boolean2Str ($vb_rutOK;"";" RUT con problemas.")+ST_Boolean2Str ($vb_giroOK;"";" Giro vacío para algunos documentos.")+ST_Boolean2Str ($vb_refOK;"";" Problema en las referencias.")+ST_Boolean2Str ($vb_montoOK;"";" Problema con montos.")
										End if 
									Else 
										  // no es par monto v/s detalle
										$vl_resp:=1
										$vt_msj:="Proceso con error!!!"+"\r\n"+"\r\n"+"Revise el archivo de resultados."+ST_Boolean2Str ($vb_rutOK;"";" RUT con problemas.")+ST_Boolean2Str ($vb_giroOK;"";" Giro vacío para algunos documentos.")+ST_Boolean2Str ($vb_refOK;"";" Problema en las referencias.")+ST_Boolean2Str ($vb_montoOK;"";" Problema con montos.")
										$b_hayError:=True:C214
										IO_SendPacket ($ref2;"[ERROR]"+"\t"+"Número de columnas a importar erróneo. No coinciden los montos con los detalles. Genere un archivo con encabezados y verifique que existe la misma cantidad de columnas fijas. Proceso interrumpido."+"\r\n")
										
									End if 
									CLOSE DOCUMENT:C267($ref2)
									  // si se cancela no se muestra el mensaje...
									If ($vl_resp=1)
										ACTcd_DlogWithShowOnDisk (document;0;$vt_msj+"\r"+"Encontrará un registro de la importación en el archivo "+ST_Qte (SYS_Path2FileName (document))+", ubicado en "+ST_Qte (SYS_GetParentNme (document))+"."+Choose:C955($b_hayError;"\r\n"+"\r\n"+"¡¡¡En el archivo hay errores detallados!!!";""))
									Else 
										DELETE DOCUMENT:C159(document)
									End if 
								Else 
									  //error al crear el informe
									CD_Dlog (0;"No fue posible crear el informe de importación. Proceso interrumpido.")
								End if 
							Else 
								  //no hay datos
								CD_Dlog (0;"No se encontraron datos a importar.")
							End if 
						Else 
							  // no hay datos
							CD_Dlog (0;"No se encontraron datos a importar.")
						End if 
						
						CLOSE DOCUMENT:C267($ref)
						USE CHARACTER SET:C205(*;1)
					End if 
					EM_ErrorManager ("Clear")
					
					  //restauro propiedad de emisor electronico de la razon social...
					$vb_readWrite:=True:C214
					ACTcfg_OpcionesRazonesSociales ("CargaByID";->$r_idRS;->$vb_readWrite)
					[ACT_RazonesSociales:279]emisor_electronico:30:=$vb_estado
					SAVE RECORD:C53([ACT_RazonesSociales:279])
					KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
					
					  //asigno ciudad desde comuna
					ACTdte_AsignaCiudadDesdeComunaT 
					
				Else 
					CD_Dlog (0;"Usuario no tiene privilegios para crear registros de Terceros. La importación fue interrumpida.")
				End if 
			Else 
				CD_Dlog (0;"La razón social "+atACTcfg_Razones{atACTcfg_Razones}+" no está coonfigurada como emisor electrónico. La importación fue interrumpida.")
			End if 
		End if 
		
	End if 
End if 