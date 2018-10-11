
  // Modificado por: Saúl Ponce (17-06-2017) Ticket 182058, para asignar codigo SII a documentos tributarios antigüos.
If ([ACT_Boletas:181]codigo_SII:33="")
	ACTbol_AsignaCodigoSII 
	SAVE RECORD:C53([ACT_Boletas:181])
End if 

C_LONGINT:C283(vlACT_IdCategoriaNC)
ACTcfg_LoadConfigData (8)
ACTbol_LeeListaDocsTribs ("LeeLista")
ACTbol_CargaDiasVencimiento   //20161024 RCH
If (Size of array:C274(atACT_CategoriasDctos)>0)
	vlACT_IdCategoriaNC:=-4
	$pos:=Find in array:C230(alACT_CategoriasDctos;vlACT_IdCategoriaNC)
	$ok:=ACTcfg_SearchCatDocs (vlACT_IdCategoriaNC)
	If ($ok)
		$vl_recNum:=Record number:C243([ACT_Boletas:181])
		ARRAY INTEGER:C220(ai_selectedLines;0)
		ARRAY LONGINT:C221(al_recNumsCargos;0)
		ARRAY LONGINT:C221($al_recNumsCargos;0)
		$err:=AL_GetSelect (ALP_CargosBoleta;ai_selectedLines)
		For ($i;1;Size of array:C274(ai_selectedLines))
			ARRAY LONGINT:C221($al_recNumsCargos2;0)
			AT_Text2Array (->$al_recNumsCargos2;atACT_RecNumsCargosAgr{ai_selectedLines{$i}};";")
			COPY ARRAY:C226(al_recNumsCargos;$al_recNumsCargos)
			AT_Union (->$al_recNumsCargos;->$al_recNumsCargos2;->al_recNumsCargos)
		End for 
		
		If (Size of array:C274(al_recNumsCargos)>0)
			If ([ACT_Boletas:181]Numero:11#0)  //20130705 RCH
				  //20171221 RCH
				  //If (Not([ACT_Boletas]Es_Publico_General))
				$b_continuar:=True:C214
				If ([ACT_Boletas:181]Es_Publico_General:46)
					$l_resp:=CD_Dlog (0;"Este documento está emitido para Público General."+"\r\r"+"¿Desea continuar con la generación del documento?";"";"Si";"No")
					If ($l_resp=2)
						$b_continuar:=False:C215
					End if 
				End if 
				If ($b_continuar)
					
					  //20150904 RCH Validaciones para no emitir un documento si ya fue anulado y para avisar que ya existe un documento asociado
					C_BOOLEAN:C305($b_continuar)
					C_LONGINT:C283($l_idBol;$l_docsAsociados;$l_resp)
					$b_continuar:=True:C214
					$l_idBol:=[ACT_Boletas:181]ID:1
					
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_docsAsociados)
					  //20171112 RCH
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$l_idBol;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_referencia:31=1;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($l_docsAsociados>0)
						CD_Dlog (0;"Este documento ya fue anulado mediante una Nota de Crédito. No es posible emitir otro documento.")
						$b_continuar:=False:C215
					End if 
					
					If ($b_continuar)
						
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_docsAsociados)
						  //20171112 RCH
						QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$l_idBol;*)
						QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($l_docsAsociados>0)
							$l_resp:=CD_Dlog (0;"Este documento ya tiene emitido un documento asociado."+"\r\r"+"¿Desea continuar con la generación del documento?";"";"Si";"No")
							If ($l_resp=2)
								$b_continuar:=False:C215
							End if 
						End if 
						
						If ($b_continuar)
							
							If ([ACT_Boletas:181]ID_Tercero:21#0)
								If ([ACT_Boletas:181]codigo_SII:33#"61")
									C_TEXT:C284($t_rutTerceroAsoc)
									C_LONGINT:C283($l_idTipoReceptorDT)
									$t_rutTerceroAsoc:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]RUT:4)
									If ($t_rutTerceroAsoc="666666666")  //rut SII
										$l_idTipoReceptorDT:=KRL_GetNumericFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]ReceptorDT_tipo:76)
										If ($l_idTipoReceptorDT=0)
											$b_continuar:=False:C215
											CD_Dlog (0;__ ("Debe emitir el Documento Tributario a un Tercero distinto al SII. Configure un Receptor diferente en la ficha del Tercero SII."))
										End if 
									End if 
								End if 
							End if 
							
							If ($b_continuar)
								C_TEXT:C284($t_rut)  //20160512 RCH Para no emitir una NC al SII
								C_LONGINT:C283($l_idRecTercero;$l_idRecApoderado)
								$t_rut:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]RUT:4)
								$l_idRecTercero:=KRL_GetNumericFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]ReceptorDT_id_tercero:77)
								$l_idRecApoderado:=KRL_GetNumericFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]ReceptorDT_id_apoderado:78)
								If ($t_rut="666666666")
									If (($l_idRecTercero=0) & ($l_idRecApoderado=0))
										CD_Dlog (0;"No es posible emitir una Nota de Crédito al receptor rut: "+$t_rut+". Seleccione un receptor diferente antes intentar emitir este tipo de documento.")
										IT_MODIFIERS 
										If ((Not:C34(<>Shift)) & (Not:C34(<>Command)))
											$b_continuar:=False:C215
										End if 
									End if 
								End if 
								If ($b_continuar)
									WDW_OpenFormWindow (->[ACT_Boletas:181];"NotasCreditoDebito";-1;4;__ ("Nota de crédito para el documento número: ")+String:C10([ACT_Boletas:181]Numero:11;"# ### ##0"))
									DIALOG:C40([ACT_Boletas:181];"NotasCreditoDebito")
									CLOSE WINDOW:C154
									GOTO RECORD:C242([ACT_Boletas:181];$vl_recNum)
									ACTbol_OnRecordLoad 
								End if 
							End if 
						End if 
					End if 
					
				Else 
					  //CD_Dlog (0;__ ("No es posible emitir un documento asociado a un documento emitido para público general."))
				End if 
			Else 
				CD_Dlog (0;__ ("No es posible emitir un documento asociado a un Documento Tributario con folio 0."))
			End if 
		Else 
			CD_Dlog (0;__ ("Debe seleccionar alguno de los cargos incluidos en el Documento Tributario."))
		End if 
	Else 
		CD_Dlog (0;__ ("No han sido creadas todas las definiciones para la categoría de documento tributario: ")+ST_Qte (atACT_CategoriasDctos{$pos})+__ (". No es posible generar el documento."))
	End if 
End if 