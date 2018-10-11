//%attributes = {}
  //ACTbol_EMasivaDocTribs

C_OBJECT:C1216($ob_resultado)
C_LONGINT:C283($l_error)
ARRAY OBJECT:C1221($ao_objetosResultados;0)

If (Records in set:C195("Selection")>0)
	ACTcfg_LoadConfigData (8)
	
	ARRAY LONGINT:C221($al_recNumsAvisos;0)
	ARRAY LONGINT:C221($al_RecNumApdos;0)
	C_BOOLEAN:C305(vbACT_noHayCAF;vbACT_noHayFDE)
	USE SET:C118("Selection")
	
	If (e3=0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos)
		ACTbol_validaInfo ("IdCatEnPersonasDesdeAvisos";->$al_recNumsAvisos)
		
		If (e4=1)
			QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_ReceptorDT_Tipo:112=3)
		Else 
			QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_ReceptorDT_Tipo:112<3)
		End if 
		
		SELECTION TO ARRAY:C260([Personas:7];$al_RecNumApdos)
		ACTbol_validaInfo ("ACTbolLlenaArreglos";->$al_RecNumApdos;->[Personas:7];->[Personas:7]ACT_DocumentoTributario:45)
		$ptr_apYNom:=->[Personas:7]Apellidos_y_nombres:30
		$ptr_idTabla:=->[Personas:7]No:1
		$ptr_idDocTrib:=->[Personas:7]ACT_DocumentoTributario:45
		$ptr_table:=->[Personas:7]
		$ptr_field:=->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
	Else 
		ARRAY LONGINT:C221($al_idsTerceros;0)
		  //20120712 RCH Podia dar error si el tercero no tenia idcatdoctrib
		ARRAY LONGINT:C221($al_idCatDocTrib;0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
		DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_Tercero:26;$al_idsTerceros)
		QRY_QueryWithArray (->[ACT_Terceros:138]Id:1;->$al_idsTerceros)
		  //SELECTION TO ARRAY([ACT_Terceros];$al_RecNumApdos)
		
		QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]ReceptorDT_tipo:76<3)
		
		SELECTION TO ARRAY:C260([ACT_Terceros:138];$al_RecNumApdos;[ACT_Terceros:138]id_CatDocTrib:55;$al_idCatDocTrib)
		ACTbol_validaInfo ("verificaIdCatEnTerceros";->$al_idCatDocTrib;->$al_RecNumApdos)  //20120712 RCH asigna cat x def
		ACTbol_validaInfo ("ACTbolLlenaArreglos";->$al_RecNumApdos;->[ACT_Terceros:138];->[ACT_Terceros:138]id_CatDocTrib:55)
		
		$ptr_apYNom:=->[ACT_Terceros:138]Nombre_Completo:9
		$ptr_idTabla:=->[ACT_Terceros:138]Id:1
		$ptr_idDocTrib:=->[ACT_Terceros:138]id_CatDocTrib:55
		$ptr_table:=->[ACT_Terceros:138]
		$ptr_field:=->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
	End if 
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
	
	  //20140916 RCH valido creacion de 
	$b_continuar:=ACTbol_ValidaEmisionDTE ("avisos";"Selection")
	If ($b_continuar)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generado documentos para "))
		For ($i;1;Size of array:C274($al_RecNumApdos))
			USE SET:C118("Selection")
			GOTO RECORD:C242($ptr_table->;$al_RecNumApdos{$i})
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNumApdos);__ ("Emitiendo documentos para ")+$ptr_apYNom->)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];$ptr_field->=$ptr_idTabla->)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosApdo")
			Case of 
				: (h1=1)
					Case of 
						: (s1=1)
							ARRAY LONGINT:C221($aAñosAvisos;0)
							DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Agno:7;$aAñosAvisos)
							For ($r;1;Size of array:C274($aAñosAvisos))
								USE SET:C118("AvisosApdo")
								QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$aAñosAvisos{$r})
								CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Año")
								ARRAY INTEGER:C220($aMesesAvisos;0)
								DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Mes:6;$aMesesAvisos)
								For ($y;1;Size of array:C274($aMesesAvisos))
									USE SET:C118("Año")
									QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$aMesesAvisos{$y})
									CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Mes "+String:C10($aMesesAvisos{$y})+" "+String:C10($aAñosAvisos{$r}))
									ARRAY LONGINT:C221(al_idSeleccionado;0)
									ARRAY LONGINT:C221(al_idRazonSocial;0)
									
									If (e2=1)
										KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
										KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
										AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
									Else 
										  //AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza]ID_Apoderado;->al_idSeleccionado)
										  // 20120322 RCH Cuando se emitia para un tercero habia un error.
										AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
									End if 
									ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
									
									CREATE SET:C116([ACT_Cargos:173];"setCargos")
									
									For ($k;1;Size of array:C274(al_idRazonSocial))
										
										  //  //20150725 RCH Lee configuraciones para la razon social
										  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
										  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
										  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
										
										  //  //20130903 RCH
										  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
										ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
										
										
										
										For ($x;1;Size of array:C274(al_idSeleccionado))
											
											$t_set:="Mes "+String:C10($aMesesAvisos{$y})+" "+String:C10($aAñosAvisos{$r})
											
											al_idSeleccionado{0}:=al_idSeleccionado{$x}
											al_idRazonSocial{0}:=al_idRazonSocial{$k}
											$vl_identificador:=al_idSeleccionado{$x}
											$vl_idRazonSocial:=al_idRazonSocial{$k}
											
											ACTbol_FiltraItemsCategoria ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
											
											For ($v;1;Size of array:C274(alACT_idsCategorias))
												alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
												
												ACTbol_FiltraItemsMoneda ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0})
												
												  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
												For ($l_moneda;1;Size of array:C274(atACT_Monedas))
													atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
													
													ACTbol_FiltraItemsResponsable ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0};atACT_Monedas{0})
													
													ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
													For ($l_responsables;1;Size of array:C274(alACT_Responsables))
														alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
														  //$emitidas:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
														  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
														  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
														
														$ob_resultado:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
														APPEND TO ARRAY:C911($ao_objetosResultados;$ob_resultado)
														$l_error:=OB Get:C1224($ob_resultado;"num_error_validacion")
														If ($l_error<0)
															
															$vl_mes:=$aMesesAvisos{$y}
															$vl_year:=$aAñosAvisos{$r}
															$x:=Size of array:C274(al_idSeleccionado)
															$k:=Size of array:C274(al_idRazonSocial)
															$y:=Size of array:C274($aMesesAvisos)
															$r:=Size of array:C274($aAñosAvisos)
															$i:=Size of array:C274($al_RecNumApdos)
															$v:=Size of array:C274(alACT_idsCategorias)
															$l_moneda:=Size of array:C274(atACT_Monedas)
															$l_responsables:=Size of array:C274(alACT_Responsables)
															Case of 
																: (vbACT_noHayCAF)
																	vbACT_noHayCAF:=False:C215
																	CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión. El proceso fue interrumpido."))
																: (vbACT_noHayFDE)
																	vbACT_noHayFDE:=False:C215
																	CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
																Else 
																	If (($l_error=4) | ($l_error=5) | ($l_error=-8))  // Modificado por: Saúl Ponce (26-03-2018) Ticket Nº 201286. Agregué -8
																		$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
																		$format:="# ### ###"
																		CD_Dlog (0;__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon)
																	Else 
																		CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+$ptr_apYNom->+", "+__ ("para el período ")+String:C10($vl_year)+String:C10($vl_mes;"00")+". "+"El proceso fue interrumpido."+" "+"Intente nuevamente.")
																	End if 
															End case 
														End if 
													End for 
												End for 
												
											End for 
										End for 
									End for 
									
									SET_ClearSets ("setCargos")
									
									  //CLEAR SET("Mes "+String($aMesesAvisos{$y})+" "+String($aAñosAvisos{$r}))
									SET_ClearSets ($t_set)
								End for 
							End for 
							CLEAR SET:C117("Año")
						: (s2=1)
							ARRAY LONGINT:C221($aAñosAvisos;0)
							DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Agno:7;$aAñosAvisos)
							For ($r;1;Size of array:C274($aAñosAvisos))
								USE SET:C118("AvisosApdo")
								QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$aAñosAvisos{$r})
								CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Año "+String:C10($aAñosAvisos{$r}))
								ARRAY LONGINT:C221(al_idSeleccionado;0)
								ARRAY LONGINT:C221(al_idRazonSocial;0)
								If (e2=1)
									KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
									KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
									AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
								Else 
									  //AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza]ID_Apoderado;->al_idSeleccionado)
									  // 20120322 RCH Cuando se emitia para un tercero habia un error.
									AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
								End if 
								ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
								For ($k;1;Size of array:C274(al_idRazonSocial))
									
									  //  //20150725 RCH Lee configuraciones para la razon social
									  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
									  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
									  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
									
									  //  //20130903 RCH
									  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
									ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
									
									For ($x;1;Size of array:C274(al_idSeleccionado))
										
										$t_set:="Año "+String:C10($aAñosAvisos{$r})
										
										al_idSeleccionado{0}:=al_idSeleccionado{$x}
										al_idRazonSocial{0}:=al_idRazonSocial{$k}
										$vl_identificador:=al_idSeleccionado{$x}
										$vl_idRazonSocial:=al_idRazonSocial{$k}
										
										ACTbol_FiltraItemsCategoria ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
										
										  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
										
										For ($v;1;Size of array:C274(alACT_idsCategorias))
											alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
											
											ACTbol_FiltraItemsMoneda ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0})
											
											  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
											  //For ($l_moneda;1;Size of array(atACT_Monedas))
											  //atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
											
											For ($l_moneda;1;Size of array:C274(atACT_Monedas))
												atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
												
												ACTbol_FiltraItemsResponsable ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0};atACT_Monedas{0})
												
												ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
												For ($l_responsables;1;Size of array:C274(alACT_Responsables))
													alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
													
													  //$emitidas:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
													  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
													  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
													
													$ob_resultado:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
													APPEND TO ARRAY:C911($ao_objetosResultados;$ob_resultado)
													$l_error:=OB Get:C1224($ob_resultado;"num_error_validacion")
													If ($l_error<0)
														
														$vl_year:=$aAñosAvisos{$r}
														$x:=Size of array:C274(al_idSeleccionado)
														$k:=Size of array:C274(al_idRazonSocial)
														$r:=Size of array:C274($aAñosAvisos)
														$i:=Size of array:C274($al_RecNumApdos)
														$v:=Size of array:C274(alACT_idsCategorias)
														$l_moneda:=Size of array:C274(atACT_Monedas)
														$l_responsables:=Size of array:C274(alACT_Responsables)
														Case of 
															: (vbACT_noHayCAF)
																vbACT_noHayCAF:=False:C215
																CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión. El proceso fue interrumpido."))
															: (vbACT_noHayFDE)
																vbACT_noHayFDE:=False:C215
																CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
															Else 
																If (($l_error=4) | ($l_error=5))
																	$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
																	$format:="# ### ###"
																	CD_Dlog (0;__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon)
																Else 
																	CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+$ptr_apYNom->+", "+__ ("para el año ")+String:C10($vl_year)+". "+"El proceso fue interrumpido."+" "+"Intente nuevamente.")
																End if 
														End case 
													End if 
												End for 
											End for 
										End for 
									End for 
								End for 
								  //CLEAR SET("Año "+String($aAñosAvisos{$r}))
								SET_ClearSets ($t_set)
							End for 
					End case 
				: (h2=1)
					ARRAY LONGINT:C221(al_idSeleccionado;0)
					ARRAY LONGINT:C221(al_idRazonSocial;0)
					If (e2=1)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
					Else 
						  //AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza]ID_Apoderado;->al_idSeleccionado)
						  // 20120322 RCH Cuando se emitia para un tercero habia un error.
						AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
					End if 
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"UnDocumento")
					ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					For ($k;1;Size of array:C274(al_idRazonSocial))
						
						  //  //20150725 RCH Lee configuraciones para la razon social
						  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
						  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
						  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
						
						  //  //20130903 RCH
						  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
						ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
						
						For ($x;1;Size of array:C274(al_idSeleccionado))
							
							$t_set:="UnDocumento"
							
							al_idSeleccionado{0}:=al_idSeleccionado{$x}
							al_idRazonSocial{0}:=al_idRazonSocial{$k}
							$vl_identificador:=al_idSeleccionado{$x}
							$vl_idRazonSocial:=al_idRazonSocial{$k}
							
							ACTbol_FiltraItemsCategoria ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
							
							  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
							
							For ($v;1;Size of array:C274(alACT_idsCategorias))
								alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
								
								ACTbol_FiltraItemsMoneda ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0})
								
								For ($l_moneda;1;Size of array:C274(atACT_Monedas))
									atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
									
									ACTbol_FiltraItemsResponsable ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0};atACT_Monedas{0})
									
									ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
									For ($l_responsables;1;Size of array:C274(alACT_Responsables))
										alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
										
										  //$emitidas:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
										  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
										  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
										
										$ob_resultado:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
										APPEND TO ARRAY:C911($ao_objetosResultados;$ob_resultado)
										$l_error:=OB Get:C1224($ob_resultado;"num_error_validacion")
										If ($l_error<0)
											
											$x:=Size of array:C274(al_idSeleccionado)
											$k:=Size of array:C274(al_idRazonSocial)
											$i:=Size of array:C274($al_RecNumApdos)
											$v:=Size of array:C274(alACT_idsCategorias)
											$l_moneda:=Size of array:C274(atACT_Monedas)
											$l_responsables:=Size of array:C274(alACT_Responsables)
											Case of 
												: (vbACT_noHayCAF)
													vbACT_noHayCAF:=False:C215
													CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión. El proceso fue interrumpido."))
												: (vbACT_noHayFDE)
													vbACT_noHayFDE:=False:C215
													CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
												Else 
													If (($l_error=4) | ($l_error=5))
														$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
														$format:="# ### ###"
														CD_Dlog (0;__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon)
													Else 
														CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+$ptr_apYNom->+". "+__ ("El proceso fue interrumpido.")+" "+__ ("Intente nuevamente."))
													End if 
											End case 
										End if 
									End for 
								End for 
							End for 
						End for 
					End for 
					  //CLEAR SET("UnDocumento")
					SET_ClearSets ($t_set)
				: (h3=1)
					ARRAY LONGINT:C221($aRecNums;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNums;"")
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"todos")
					CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];"desctos")
					For ($kj;1;Size of array:C274($aRecNums))
						GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNums{$kj})
						If ([ACT_Avisos_de_Cobranza:124]Monto_Neto:11<0)
							ADD TO SET:C119([ACT_Avisos_de_Cobranza:124];"desctos")
						End if 
					End for 
					DIFFERENCE:C122("todos";"desctos";"todos")
					USE SET:C118("todos")
					ARRAY LONGINT:C221($aRecNums;0)
					
					  //20150504 RCH Para facilitar generación de DTES en certificación de boletas.
					  //ORDER BY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado;>)
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)  //20151027 RCH...
					
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNums;"")
					CLEAR SET:C117("todos")
					For ($u;1;Size of array:C274($aRecNums))
						GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNums{$u})
						CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Aviso")
						ARRAY LONGINT:C221(al_idSeleccionado;0)
						ARRAY LONGINT:C221(al_idRazonSocial;0)
						If (e2=1)
							KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
						Else 
							  //AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza]ID_Apoderado;->al_idSeleccionado)
							  // 20120322 RCH Cuando se emitia para un tercero habia un error.
							AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
						End if 
						ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
						For ($k;1;Size of array:C274(al_idRazonSocial))
							
							  //  //20150725 RCH Lee configuraciones para la razon social
							  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
							  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
							  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
							
							  //  //20130903 RCH
							  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
							ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
							
							For ($x;1;Size of array:C274(al_idSeleccionado))
								
								$t_set:="Aviso"
								
								al_idSeleccionado{0}:=al_idSeleccionado{$x}
								al_idRazonSocial{0}:=al_idRazonSocial{$k}
								$vl_identificador:=al_idSeleccionado{$x}
								$vl_idRazonSocial:=al_idRazonSocial{$k}
								
								ACTbol_FiltraItemsCategoria ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
								
								  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
								USE SET:C118("Aviso")
								
								For ($v;1;Size of array:C274(alACT_idsCategorias))
									alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
									
									ACTbol_FiltraItemsMoneda ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0})
									
									For ($l_moneda;1;Size of array:C274(atACT_Monedas))
										atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
										
										ACTbol_FiltraItemsResponsable ("avisos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0;alACT_idsCategorias{0};atACT_Monedas{0})
										
										ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
										For ($l_responsables;1;Size of array:C274(alACT_Responsables))
											alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
											
											  //$emitidas:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
											  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
											  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
											
											$ob_resultado:=ACTbol_EmitirDocumentos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;$vl_idRazonSocial)
											APPEND TO ARRAY:C911($ao_objetosResultados;$ob_resultado)
											$l_error:=OB Get:C1224($ob_resultado;"num_error_validacion")
											If ($l_error<0)
												
												$x:=Size of array:C274(al_idSeleccionado)
												$k:=Size of array:C274(al_idRazonSocial)
												$u:=Size of array:C274($aRecNums)
												$i:=Size of array:C274($al_RecNumApdos)
												$v:=Size of array:C274(alACT_idsCategorias)
												$l_moneda:=Size of array:C274(atACT_Monedas)
												$l_responsables:=Size of array:C274(alACT_Responsables)
												Case of 
													: (vbACT_noHayCAF)
														vbACT_noHayCAF:=False:C215
														CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión. El proceso fue interrumpido."))
													: (vbACT_noHayFDE)
														vbACT_noHayFDE:=False:C215
														CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
													Else 
														If (($l_error=4) | ($l_error=5))
															  //CD_Dlog (0;"El siguiente documento tributario a emitir generaría un documento con folio dupli"+"cado, el p"+"roceso fue interrumpido. Por favor revise la configuración antes de continuar."+<>cr+<>cr+"Datos del documento ya emitido:"+<>cr+<>cr+"Tipo de documento: "+vtACT_tipoDctoDuplicado+<>cr+"Número de documento: "+String(vlACT_numeroDctoDuplicado;"# ### ###"))
															$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
															$format:="# ### ###"
															CD_Dlog (0;__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon)
														Else 
															CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+$ptr_apYNom->+". "+__ ("El proceso fue interrumpido.")+" "+__ ("Intente nuevamente."))
														End if 
												End case 
											End if 
										End for 
									End for 
								End for 
							End for 
						End for 
					End for 
					  //CLEAR SET("Aviso")
					SET_ClearSets ($t_set)
			End case 
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	  //Procesa objetos
	ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$ao_objetosResultados)
	
	COPY ARRAY:C226(at_Categorias;atCategorias)
	COPY ARRAY:C226(at_Documentos2Print;atDocumentos2Print)
	COPY ARRAY:C226(al_HowMany;alHowMany)
	COPY ARRAY:C226(al_DesdeDT;aDesdeDT)
	COPY ARRAY:C226(al_HastaDT;aHastaDT)
	COPY ARRAY:C226(at_SetsDT;aSetsDT)
	COPY ARRAY:C226(al_IDDT;alIDDT)
	$Zero:=Find in array:C230(alHowMany;0)
	While ($Zero#-1)
		CLEAR SET:C117(aSetsDT{$Zero})
		AT_Delete ($Zero;1;->atCategorias;->atDocumentos2Print;->alHowMany;->aDesdeDT;->aHastaDT;->aSetsDT;->alIDDT)
		$Zero:=Find in array:C230(alHowMany;0)
	End while 
	ARRAY BOOLEAN:C223(abDoPrint;Size of array:C274(alHowMany))
	ARRAY PICTURE:C279(apDoPrint;Size of array:C274(alHowMany))
	For ($i;1;Size of array:C274(alHowMany))
		abDoPrint{$i}:=True:C214
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apDoPrint{$i})
		LOG_RegisterEvt ("Emisión de "+atDocumentos2Print{$i}+" del "+String:C10(aDesdeDT{$i})+" al "+String:C10(aHastaDT{$i}))
	End for 
	AT_Initialize (->alACT_idsCategorias)
	
	CLEAR SET:C117("AvisosApdo")
End if 