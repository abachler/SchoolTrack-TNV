Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($l_columna;$l_fila;$l_result)
		C_POINTER:C301($vy_arreglo)
		C_BOOLEAN:C305($b_solicitaXML;$b_muestraXML)
		C_LONGINT:C283($l_idDTE)
		C_BLOB:C604($x_xml)
		C_TEXT:C284($t_xml;$t_tipo;$t_ref;$t_dir;$t_periodo)
		
		LISTBOX GET CELL POSITION:C971(lb_listaIECV;$l_columna;$l_fila;$vy_arreglo)
		
		If ($l_fila>0)
			C_TEXT:C284($varName1)
			C_LONGINT:C283($tableNum1;$fieldNum1)
			RESOLVE POINTER:C394($vy_arreglo;$varName1;$tableNum1;$fieldNum1)
			
			READ ONLY:C145([ACT_IECV:253])
			$l_idIECV:=alACTiecv_id{$l_fila}
			KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_idIECV)
			If (ok=1)
				
				$l_idDTE:=alACTiecv_idDTE{$l_fila}
				$t_tipo:=alACTiecv_operacion{$l_fila}
				$t_rut:=atACTiecv_rut{$l_fila}
				$t_periodo:=atACTiecv_periodo{$l_fila}
				
				Case of 
						  //: ($l_columna=7)  //xml apACTiecv_xml
					: ($varName1="apACTiecv_xml")
						If ($t_rut#"")
							If (BLOB size:C605([ACT_IECV:253]xml:3)#0)
								$t_ref:=DOM Parse XML variable:C720([ACT_IECV:253]xml:3)
								If (ok=1)
									DOM EXPORT TO VAR:C863($t_ref;$t_xml)
									DOM CLOSE XML:C722($t_ref)
									$b_muestraXML:=True:C214
								Else 
									$b_solicitaXML:=True:C214
								End if 
							Else 
								If ($l_idDTE#0)
									$b_solicitaXML:=True:C214
								Else 
									CD_Dlog (0;__ ("No existe XML en DTENet"))
								End if 
							End if 
							
							If ($b_solicitaXML)
								$l_result:=WSact_ObtieneLibroContable ($t_rut;ST_Lowercase ($t_tipo);$l_idDTE)
								If ($l_result=1)
									SET TEXT TO PASTEBOARD:C523(vtWS_xml)
									$t_ref:=DOM Parse XML variable:C720(vtWS_xml)
									If (ok=1)
										DOM EXPORT TO VAR:C863($t_ref;$x_xml)
										DOM EXPORT TO VAR:C863($t_ref;$t_xml)
										DOM CLOSE XML:C722($t_ref)
										  //guardo para no pedir la proxima vez
										KRL_ReloadInReadWriteMode (->[ACT_IECV:253])
										If (Not:C34(Locked:C147([ACT_IECV:253])))
											[ACT_IECV:253]xml:3:=$x_xml
											SAVE RECORD:C53([ACT_IECV:253])
										End if 
										KRL_UnloadReadOnly (->[ACT_IECV:253])
										$b_muestraXML:=True:C214
									End if 
								Else 
									CD_Dlog (0;"No fue posible obtener el libro.")
								End if 
							End if 
							
							If ($b_muestraXML)
								C_TEXT:C284($t_nombreArchivo)
								C_TEXT:C284($t_year;$t_mes)
								$t_nombreArchivo:=$t_rut+"_"+$t_tipo+"_"+$t_periodo+"_"+String:C10($l_idDTE)+".xml"
								$t_year:=Substring:C12($t_periodo;1;4)
								$t_mes:=Substring:C12($t_periodo;6;2)
								
								$ref:=ACTabc_CreaDocumento ("DTE"+Folder separator:K24:12+Replace string:C233($t_rut;"-";"")+Folder separator:K24:12+"libros"+Folder separator:K24:12+$t_tipo+Folder separator:K24:12+$t_year+Folder separator:K24:12+$t_mes;$t_nombreArchivo)
								
								If ($ref#?00:00:00?)
									CLOSE DOCUMENT:C267($ref)
									
									CONVERT FROM TEXT:C1011($t_xml;"LATIN1";$x_xml)
									BLOB TO DOCUMENT:C526(document;$x_xml)
									
									ACTcd_DlogWithShowOnDisk (document;0;"Archivo: "+ST_Qte ($t_nombreArchivo)+" generado.")
								End if 
								
							End if 
						Else 
							CD_Dlog (0;"No hay Razón Social asociada.")
						End if 
						
						
						  //: ($l_columna=8)  //sii apACTiecv_sii
					: ($varName1="apACTiecv_sii")
						
						If (Not:C34([ACT_IECV:253]estado:14 ?? 4))
							  //si esta emitido y no esta recibido, se solicita
							If ([ACT_IECV:253]estado:14 ?? 1)
								If (Not:C34([ACT_IECV:253]estado:14 ?? 2))
									ACTiecv_obtieneEstadoDesdeDTE ($l_idIECV)
								End if 
								
								If (([ACT_IECV:253]estado:14 ?? 2) & Not:C34([ACT_IECV:253]estado:14 ?? 3))
									CD_Dlog (0;"Archivo con error de validación. No es posible enviarlo al SII.")
								Else 
									
									If (BLOB size:C605([ACT_IECV:253]xml:3)#0)
										  //envio al sii
										$l_result:=WSact_EnviaLibroContable ($t_rut;ST_Lowercase ($t_tipo);$l_idDTE)
										If ($l_result=1)
											$l_estado:=4
											If (Not:C34(ACTiecv_actualizaEstado ($l_idIECV;$l_estado)))
												$t_parametro:=ST_Concatenate ("";->$l_estado;->$l_estado)
												BM_CreateRequest ("ACT_ActualizaEstadoLibro";$t_parametro;$t_parametro)
											End if 
											
											  //actualiza nuevo estado de libro
											ACTiecv_cargaArreglosListado ("ActualizaGlosaArreglo";->$l_idIECV;->$l_fila)
											
											  //log
											LOG_RegisterEvt ("Información electrónica de compra y venta enviada al SII. Libro de "+alACTiecv_operacion{$l_fila}+", para el período"+atACTiecv_periodo{$l_fila}+".")
											
											CD_Dlog (0;"Verifique el estado del libro en www.sii.cl.")
										Else 
											  //CD_Dlog (0;"El libro no pudo ser enviado a www.sii.cl.")
											CD_Dlog (0;"El libro no pudo ser enviado a www.sii.cl. Error: "+vtWS_glosa+".")
										End if 
									Else 
										CD_Dlog (0;"Antes de enviar el libro al SII, revise que el XML esté correcto.")
									End if 
								End if 
							End if 
						Else 
							CD_Dlog (0;"Libro ya enviado al SII.")
						End if 
				End case 
			End if 
		End if 
		
End case 