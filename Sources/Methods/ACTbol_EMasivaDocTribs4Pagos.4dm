//%attributes = {}
  //ACTbol_EMasivaDocTribs4Pagos
C_OBJECT:C1216($ob_resultado)
C_LONGINT:C283($l_error)
ARRAY OBJECT:C1221($ao_objetosResultados;0)

If (Records in set:C195("Selection")>0)
	ACTcfg_LoadConfigData (8)
	ARRAY LONGINT:C221($al_recNumsPagos;0)
	ARRAY LONGINT:C221($al_RecNumApdos;0)
	C_BOOLEAN:C305(vbACT_noHayCAF;vbACT_noHayFDE)
	C_LONGINT:C283($l_idTerceroPG)
	
	USE SET:C118("Selection")
	
	Case of 
		: (e3=1)
			
			ARRAY LONGINT:C221($al_idsTerceros;0)
			  //20120712 RCH Podia dar error si el tercero no tenia idcatdoctrib
			ARRAY LONGINT:C221($al_idCatDocTrib;0)
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26#0)
			DISTINCT VALUES:C339([ACT_Pagos:172]ID_Tercero:26;$al_idsTerceros)
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
			$ptr_field:=->[ACT_Pagos:172]ID_Tercero:26
			
		: (e4=1)
			h1:=0
			h2:=1
			h3:=0
			READ ONLY:C145([ACT_Terceros:138])
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Es_publico_general:79=True:C214)
			
			If (Records in selection:C76([ACT_Terceros:138])=1)
				
				$l_idTerceroPG:=[ACT_Terceros:138]Id:1
				
				SELECTION TO ARRAY:C260([ACT_Terceros:138];$al_RecNumApdos;[ACT_Terceros:138]id_CatDocTrib:55;$al_idCatDocTrib)
				ACTbol_validaInfo ("verificaIdCatEnTerceros";->$al_idCatDocTrib;->$al_RecNumApdos)  //20120712 RCH asigna cat x def
				ACTbol_validaInfo ("ACTbolLlenaArreglos";->$al_RecNumApdos;->[ACT_Terceros:138];->[ACT_Terceros:138]id_CatDocTrib:55)
				
				USE SET:C118("Selection")
				KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;"")
				QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_ReceptorDT_Tipo:112=3)
				SELECTION TO ARRAY:C260([Personas:7]No:1;$alACT_idsPersonas)
				REDUCE SELECTION:C351([Personas:7];1)
				
				$ptr_apYNom:=->[ACT_Terceros:138]Nombre_Completo:9
				$ptr_idTabla:=->[ACT_Terceros:138]Id:1
				$ptr_idDocTrib:=->[ACT_Terceros:138]id_CatDocTrib:55
				$ptr_table:=->[ACT_Terceros:138]
				$ptr_field:=->[ACT_Pagos:172]ID_Tercero:26
				
			Else 
				REDUCE SELECTION:C351([Personas:7];0)
			End if 
			
		Else 
			SELECTION TO ARRAY:C260([ACT_Pagos:172];$al_recNumsPagos)
			ACTbol_validaInfo ("IdCatEnPersonasDesdePagos";->$al_recNumsPagos)
			
			  //20151110 RCH Se perdia el orden al hacer esta busqueda. Se cambia a arreglos. Ticket 151834
			  //QUERY SELECTION([Personas];[Personas]ACT_ReceptorDT_Tipo<3)
			  //
			  //SELECTION TO ARRAY([Personas];$al_RecNumApdos)
			ARRAY LONGINT:C221($alACT_receptor;0)
			ARRAY LONGINT:C221($alACT_pos;0)
			SELECTION TO ARRAY:C260([Personas:7];$al_RecNumApdos;[Personas:7]ACT_ReceptorDT_Tipo:112;$alACT_receptor)
			$alACT_receptor{0}:=2
			AT_SearchArray (->$alACT_receptor;">";->$alACT_pos)
			For ($l_indice;Size of array:C274($alACT_pos);1;-1)
				AT_Delete ($alACT_pos{$l_indice};1;->$al_RecNumApdos;->$alACT_receptor)
			End for 
			
			ACTbol_validaInfo ("ACTbolLlenaArreglos";->$al_RecNumApdos;->[Personas:7];->[Personas:7]ACT_DocumentoTributario:45)
			$ptr_apYNom:=->[Personas:7]Apellidos_y_nombres:30
			$ptr_idTabla:=->[Personas:7]No:1
			$ptr_idDocTrib:=->[Personas:7]ACT_DocumentoTributario:45
			$ptr_table:=->[Personas:7]
			$ptr_field:=->[ACT_Pagos:172]ID_Apoderado:3
	End case 
	
	CREATE SET:C116([ACT_Pagos:172];"Selection")
	
	  //20140916 RCH valido creacion de 
	$b_continuar:=ACTbol_ValidaEmisionDTE ("pagos";"Selection")
	If ($b_continuar)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generado documentos para "))
		For ($i;1;Size of array:C274($al_RecNumApdos))
			USE SET:C118("Selection")
			
			If (e4=1)
				
				QUERY SELECTION WITH ARRAY:C1050([ACT_Pagos:172]ID_Apoderado:3;$alACT_idsPersonas)
				
			Else 
				GOTO RECORD:C242($ptr_table->;$al_RecNumApdos{$i})
				
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNumApdos);__ ("Emitiendo documentos para ")+[Personas:7]Apellidos_y_nombres:30)
				QUERY SELECTION:C341([ACT_Pagos:172];$ptr_field->=$ptr_idTabla->)
				CREATE SET:C116([ACT_Pagos:172];"PagosApdo")
				
			End if 
			
			Case of 
				: (h1=1)
					Case of 
						: (s1=1)
							ARRAY DATE:C224($aFechasPagos;0)
							ARRAY LONGINT:C221($aAñosPagos;1)
							DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;$aFechasPagos)
							$aAñosPagos{1}:=Year of:C25($aFechasPagos{1})
							For ($hh;2;Size of array:C274($aFechasPagos))
								$found:=Find in array:C230($aAñosPagos;Year of:C25($aFechasPagos{$hh}))
								If ($found=-1)
									INSERT IN ARRAY:C227($aAñosPagos;Size of array:C274($aAñosPagos)+1;1)
									$aAñosPagos{Size of array:C274($aAñosPagos)}:=Year of:C25($aFechasPagos{$hh})
								End if 
							End for 
							For ($r;1;Size of array:C274($aAñosPagos))
								USE SET:C118("PagosApdo")
								$date1:=DT_GetDateFromDayMonthYear (1;1;$aAñosPagos{$r})
								$date2:=DT_GetDateFromDayMonthYear (31;12;$aAñosPagos{$r})
								QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date1;*)
								QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$date2)
								CREATE SET:C116([ACT_Pagos:172];"Año")
								ARRAY INTEGER:C220($aMesesPagos;1)
								$aMesesPagos{1}:=Month of:C24($aFechasPagos{1})
								For ($hh;1;Size of array:C274($aFechasPagos))
									$found:=Find in array:C230($aMesesPagos;Month of:C24($aFechasPagos{$hh}))
									If ($found=-1)
										INSERT IN ARRAY:C227($aMesesPagos;Size of array:C274($aMesesPagos)+1;1)
										$aMesesPagos{Size of array:C274($aMesesPagos)}:=Month of:C24($aFechasPagos{$hh})
									End if 
								End for 
								For ($y;1;Size of array:C274($aMesesPagos))
									USE SET:C118("Año")
									$last:=DT_GetLastDay ($aMesesPagos{$y};$aAñosPagos{$r})
									$date1:=DT_GetDateFromDayMonthYear (1;$aMesesPagos{$y};$aAñosPagos{$r})
									$date2:=DT_GetDateFromDayMonthYear ($last;$aMesesPagos{$y};$aAñosPagos{$r})
									QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date1;*)
									QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$date2)
									
									ARRAY LONGINT:C221(al_idSeleccionado;0)
									ARRAY LONGINT:C221(al_idRazonSocial;0)
									If (e2=1)
										KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
										KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
										AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
										$vb_emiteXCuenta:=True:C214
									Else 
										  //AT_DistinctsFieldValues (->[ACT_Pagos]ID_Apoderado;->al_idSeleccionado)
										  // 20120322 RCH Cuando se emitia para un tercero habia un error.
										AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
										$vb_emiteXCuenta:=False:C215
									End if 
									ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1)
									CREATE SET:C116([ACT_Pagos:172];"Mes "+String:C10($aMesesPagos{$y})+" "+String:C10($aAñosPagos{$r}))
									For ($k;1;Size of array:C274(al_idRazonSocial))
										
										  //  //20150725 RCH Lee configuraciones para la razon social
										  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
										  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
										  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
										
										  //  //20130903 RCH
										  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
										ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
										
										For ($x;1;Size of array:C274(al_idSeleccionado))
											
											$t_set:="Mes "+String:C10($aMesesPagos{$y})+" "+String:C10($aAñosPagos{$r})
											
											al_idSeleccionado{0}:=al_idSeleccionado{$x}
											al_idRazonSocial{0}:=al_idRazonSocial{$k}
											$vl_identificador:=al_idSeleccionado{$x}
											$vl_idRazonSocial:=al_idRazonSocial{$k}
											
											ACTbol_FiltraItemsCategoria ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
											
											  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
											
											For ($v;1;Size of array:C274(alACT_idsCategorias))
												alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
												
												ACTbol_FiltraItemsMoneda ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
												
												For ($l_moneda;1;Size of array:C274(atACT_Monedas))
													atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
													
													ACTbol_FiltraItemsResponsable ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0)
													
													ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
													For ($l_responsables;1;Size of array:C274(alACT_Responsables))
														alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
														
														  //$emitidas:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
														  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
														  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
														
														$ob_resultado:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
														APPEND TO ARRAY:C911($ao_objetosResultados;$ob_resultado)
														$l_error:=OB Get:C1224($ob_resultado;"num_error_validacion")
														If ($l_error<0)
															$vl_mes:=$aMesesPagos{$y}
															$vl_year:=$aAñosPagos{$r}
															$x:=Size of array:C274(al_idSeleccionado)
															$k:=Size of array:C274(al_idRazonSocial)
															$y:=Size of array:C274($aMesesPagos)
															$r:=Size of array:C274($aAñosPagos)
															$i:=Size of array:C274($al_RecNumApdos)
															$v:=Size of array:C274(alACT_idsCategorias)
															$l_moneda:=Size of array:C274(atACT_Monedas)
															$l_responsables:=Size of array:C274(alACT_Responsables)
															Case of 
																: (vbACT_noHayCAF)
																	vbACT_noHayCAF:=False:C215
																	CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión"))
																: (vbACT_noHayFDE)
																	vbACT_noHayFDE:=False:C215
																	CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
																Else 
																	If ($l_error=-8)
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
									CLEAR SET:C117("Mes "+String:C10($aMesesPagos{$y})+" "+String:C10($aAñosPagos{$r}))
									SET_ClearSets ($t_set)
								End for 
							End for 
							CLEAR SET:C117("Año")
						: (s2=1)
							ARRAY DATE:C224($aFechasPagos;0)
							ARRAY LONGINT:C221($aAñosPagos;1)
							DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;$aFechasPagos)
							$aAñosPagos{1}:=Year of:C25($aFechasPagos{1})
							For ($hh;2;Size of array:C274($aFechasPagos))
								$found:=Find in array:C230($aAñosPagos;Year of:C25($aFechasPagos{$hh}))
								If ($found=-1)
									INSERT IN ARRAY:C227($aAñosPagos;Size of array:C274($aAñosPagos)+1;1)
									$aAñosPagos{Size of array:C274($aAñosPagos)}:=Year of:C25($aFechasPagos{$hh})
								End if 
							End for 
							For ($r;1;Size of array:C274($aAñosPagos))
								USE SET:C118("PagosApdo")
								$date1:=DT_GetDateFromDayMonthYear (1;1;$aAñosPagos{$r})
								$date2:=DT_GetDateFromDayMonthYear (31;12;$aAñosPagos{$r})
								QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date1;*)
								QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$date2)
								ARRAY LONGINT:C221(al_idSeleccionado;0)
								ARRAY LONGINT:C221(al_idRazonSocial;0)
								If (e2=1)
									KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
									KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
									AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
									$vb_emiteXCuenta:=True:C214
								Else 
									  //AT_DistinctsFieldValues (->[ACT_Pagos]ID_Apoderado;->al_idSeleccionado)
									  // 20120322 RCH Cuando se emitia para un tercero habia un error.
									AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
									$vb_emiteXCuenta:=False:C215
								End if 
								ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1)
								CREATE SET:C116([ACT_Pagos:172];"Año "+String:C10($aAñosPagos{$r}))
								For ($k;1;Size of array:C274(al_idRazonSocial))
									
									  //  //20150725 RCH Lee configuraciones para la razon social
									  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
									  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
									  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
									
									  //  //20130903 RCH
									  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
									ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
									
									For ($x;1;Size of array:C274(al_idSeleccionado))
										
										$t_set:="Año "+String:C10($aAñosPagos{$r})
										
										al_idSeleccionado{0}:=al_idSeleccionado{$x}
										al_idRazonSocial{0}:=al_idRazonSocial{$k}
										$vl_identificador:=al_idSeleccionado{$x}
										$vl_idRazonSocial:=al_idRazonSocial{$k}
										
										ACTbol_FiltraItemsCategoria ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
										
										  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
										
										For ($v;1;Size of array:C274(alACT_idsCategorias))
											alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
											
											ACTbol_FiltraItemsMoneda ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
											
											For ($l_moneda;1;Size of array:C274(atACT_Monedas))
												atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
												
												ACTbol_FiltraItemsResponsable ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0)
												
												ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
												For ($l_responsables;1;Size of array:C274(alACT_Responsables))
													alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
													
													  //$emitidas:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
													  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
													  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$ob_resultado)
													  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
													
													$ob_resultado:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
													APPEND TO ARRAY:C911($ao_objetosResultados;$ob_resultado)
													$l_error:=OB Get:C1224($ob_resultado;"num_error_validacion")
													If ($l_error<0)
														$vl_year:=$aAñosPagos{$r}
														$x:=Size of array:C274(al_idSeleccionado)
														$k:=Size of array:C274(al_idRazonSocial)
														$r:=Size of array:C274($aAñosPagos)
														$i:=Size of array:C274($al_RecNumApdos)
														$v:=Size of array:C274(alACT_idsCategorias)
														$l_moneda:=Size of array:C274(atACT_Monedas)
														$l_responsables:=Size of array:C274(alACT_Responsables)
														Case of 
															: (vbACT_noHayCAF)
																vbACT_noHayCAF:=False:C215
																CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión"))
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
								  //CLEAR SET("Año "+String($aAñosPagos{$r}))
								SET_ClearSets ($t_set)
							End for 
					End case 
				: (h2=1)
					ARRAY LONGINT:C221(al_idSeleccionado;0)
					ARRAY LONGINT:C221(al_idRazonSocial;0)
					If (e2=1)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
						$vb_emiteXCuenta:=True:C214
					Else 
						  //AT_DistinctsFieldValues (->[ACT_Pagos]ID_Apoderado;->al_idSeleccionado)
						  // 20120322 RCH Cuando se emitia para un tercero habia un error.
						  //AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
						If (e4=1)
							APPEND TO ARRAY:C911(al_idSeleccionado;$l_idTerceroPG)
							QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Es_publico_general:79=True:C214)
						Else 
							AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
						End if 
						$vb_emiteXCuenta:=False:C215
					End if 
					ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1)
					CREATE SET:C116([ACT_Pagos:172];"UnDocumento")
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
							
							ACTbol_FiltraItemsCategoria ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
							
							  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
							
							For ($v;1;Size of array:C274(alACT_idsCategorias))
								alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
								
								ACTbol_FiltraItemsMoneda ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
								
								For ($l_moneda;1;Size of array:C274(atACT_Monedas))
									atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
									
									ACTbol_FiltraItemsResponsable ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0)
									
									ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
									For ($l_responsables;1;Size of array:C274(alACT_Responsables))
										alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
										
										  //$emitidas:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
										  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
										  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$ob_resultado)
										  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
										$ob_resultado:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
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
													CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión"))
												: (vbACT_noHayFDE)
													vbACT_noHayFDE:=False:C215
													CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
												Else 
													If (($l_error=4) | ($l_error=5))
														$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
														$format:="# ### ###"
														CD_Dlog (0;__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon)
													Else 
														CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+$ptr_apYNom->+". "+"El proceso fue interrumpido."+" "+"Intente nuevamente.")
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
					LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRecNums;"")
					For ($u;1;Size of array:C274($aRecNums))
						GOTO RECORD:C242([ACT_Pagos:172];$aRecNums{$u})
						ARRAY LONGINT:C221(al_idSeleccionado;0)
						ARRAY LONGINT:C221(al_idRazonSocial;0)
						If (e2=1)
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->al_idSeleccionado)
							$vb_emiteXCuenta:=True:C214
						Else 
							  //AT_DistinctsFieldValues (->[ACT_Pagos]ID_Apoderado;->al_idSeleccionado)
							  // 20120322 RCH Cuando se emitia para un tercero habia un error.
							AT_DistinctsFieldValues ($ptr_field;->al_idSeleccionado)
							$vb_emiteXCuenta:=False:C215
						End if 
						ACTcfg_OpcionesRazonesSociales ("CargaArreglo";->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1)
						CREATE SET:C116([ACT_Pagos:172];"Pago")
						For ($k;1;Size of array:C274(al_idRazonSocial))
							
							  //  //20150725 RCH Lee configuraciones para la razon social
							  //vlACT_RSSel:=Choose(al_idRazonSocial{$k}=0;-1;al_idRazonSocial{$k})
							  //ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
							  //ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
							
							  //  //20130903 RCH
							  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->vlACT_RSSel)
							ACTcfg_LeeConfRS (al_idRazonSocial{$k})  //20161105 RCH
							
							For ($x;1;Size of array:C274(al_idSeleccionado))
								
								$t_set:="Pago"
								
								al_idSeleccionado{0}:=al_idSeleccionado{$x}
								al_idRazonSocial{0}:=al_idRazonSocial{$k}
								$vl_identificador:=al_idSeleccionado{$x}
								$vl_idRazonSocial:=al_idRazonSocial{$k}
								
								ACTbol_FiltraItemsCategoria ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
								
								  //ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
								
								For ($v;1;Size of array:C274(alACT_idsCategorias))
									alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
									
									ACTbol_FiltraItemsMoneda ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial)
									
									For ($l_moneda;1;Size of array:C274(atACT_Monedas))
										atACT_Monedas{0}:=atACT_Monedas{$l_moneda}
										
										ACTbol_FiltraItemsResponsable ("pagos";$t_set;al_idSeleccionado{0};$vl_idRazonSocial;0)
										
										ACTbol_validaInfo ("ACTbolLlenaVariables";$ptr_idDocTrib;->$vl_identificador;->$vl_idRazonSocial)
										For ($l_responsables;1;Size of array:C274(alACT_Responsables))
											alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
											
											  //$emitidas:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
											  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$emitidas)
											  //ACTbol_validaInfo ("ACTbolLlenaArreglosForm";->$ob_resultado)
											  //If (($emitidas=4) | ($emitidas=5) | ($emitidas=6) | ($emitidas=8))
											
											$ob_resultado:=ACTbol_EmitirDocumentos4Pagos ($t_set;vt_DocAfecto;vt_DocExento;vl_proximaAfecto;vl_proximaExento;vl_IndexAfecto;vl_IndexExento;vt_setafecto;vt_setExento;vl_IDCat;"pagos")
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
														CD_Dlog (0;__ ("No hay código de autorización de folios disponible para la emisión"))
													: (vbACT_noHayFDE)
														vbACT_noHayFDE:=False:C215
														CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
													Else 
														If (($l_error=4) | ($l_error=5))
															$razon:=ST_Boolean2Str ((vtACT_RazonSocialDctoDuplicado="");"";"\r"+"Razón Social: "+vtACT_RazonSocialDctoDuplicado)
															$format:="# ### ###"
															CD_Dlog (0;__ ("El siguiente documento tributario a emitir generaría un documento con folio duplicado, el proceso fue interrumpido. Por favor revise la configuración antes de continuar.\r\rDatos del documento ya emitido:\r\rTipo de documento: ")+vtACT_tipoDctoDuplicado+__ ("\rNúmero de documento: ")+String:C10(vlACT_numeroDctoDuplicado;$format)+$razon)
														Else 
															CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+$ptr_apYNom->+". "+"El proceso fue interrumpido."+" "+"Intente nuevamente.")
														End if 
												End case 
											End if 
										End for 
									End for 
								End for 
							End for 
						End for 
					End for 
					  //CLEAR SET("Pago")
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
	xALP_Set_ACT_Docs2Print 
	CLEAR SET:C117("PagosApdo")
	AT_Initialize (->alACT_idsCategorias)
End if 