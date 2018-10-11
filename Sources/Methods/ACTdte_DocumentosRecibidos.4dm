//%attributes = {}
  //ACTdte_DocumentosRecibidos
C_LONGINT:C283($l_indiceRS;vlACT_RSSel)
C_BLOB:C604($xBlob_respuesta)
C_BOOLEAN:C305($0;$b_ejecutado)

If (ACT_AccountTrackInicializado )
	ACTcfg_OpcionesRazonesSociales ("LoadConfig")
	For ($l_indiceRS;1;Size of array:C274(atACTcfg_Razones))
		vlACT_RSSel:=alACTcfg_Razones{$l_indiceRS}
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->vlACT_RSSel)
		ACTcfdi_OpcionesGenerales ("LeeConf";->vlACT_RSSel)
		
		  //20161216 RCH Se cambia ya que algunos colegios emiten boletas después de ser emisores electrónicos.
		  //If (cs_emitirCFDI=1)
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 7)
			
			C_TEXT:C284($t_elem)
			C_BOOLEAN:C305($b_continuar)
			C_DATE:C307($vd_fechaEjecucion)
			C_TEXT:C284($t_rutRS)
			
			C_TEXT:C284($value)
			
			$vd_fechaEjecucion:=Current date:C33(*)
			
			ARRAY TEXT:C222($atACT_rutEmisor;0)
			ARRAY TEXT:C222($atACT_razonSocialEmisor;0)
			ARRAY TEXT:C222($atACT_rutReceptor;0)
			ARRAY TEXT:C222($atACT_tipoDTE;0)
			ARRAY TEXT:C222($atACT_folioDTE;0)
			ARRAY TEXT:C222($atACT_fechaEmision;0)
			ARRAY TEXT:C222($atACT_fechaRegistro;0)
			ARRAY TEXT:C222($atACT_montoExento;0)
			ARRAY TEXT:C222($atACT_montoNeto;0)
			ARRAY TEXT:C222($atACT_montoIVA;0)
			ARRAY TEXT:C222($atACT_montoTotal;0)
			ARRAY TEXT:C222($atACT_estadoSII;0)
			
			ARRAY POINTER:C280($ay_arreglos;0)
			
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_rutEmisor)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_razonSocialEmisor)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_rutReceptor)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_tipoDTE)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_folioDTE)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_fechaEmision)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_fechaRegistro)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_montoExento)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_montoNeto)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_montoIVA)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_montoTotal)
			APPEND TO ARRAY:C911($ay_arreglos;->$atACT_estadoSII)
			
			ARRAY TEXT:C222($aNombresNodo;12)
			$aNombresNodo{1}:="rutEmisor"
			$aNombresNodo{2}:="razonSocialEmisor"
			$aNombresNodo{3}:="rutReceptor"
			$aNombresNodo{4}:="tipoDTE"
			$aNombresNodo{5}:="folioDTE"
			$aNombresNodo{6}:="fechaEmision"
			$aNombresNodo{7}:="fechaRegistro"
			$aNombresNodo{8}:="montoExento"
			$aNombresNodo{9}:="montoNeto"
			$aNombresNodo{10}:="montoIVA"
			$aNombresNodo{11}:="montoTotal"
			$aNombresNodo{12}:="estadoSII"
			
			$t_rutRS:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)
			$xBlob_respuesta:=WSact_ObtieneDTEsRecibidos ([ACT_RazonesSociales:279]RUT:3)
			
			If (BLOB size:C605($xBlob_respuesta)#0)
				
				C_TEXT:C284($t_refXML)
				C_LONGINT:C283($l_estado)
				C_TEXT:C284($t_nodo)
				C_TEXT:C284($t_siguiente_XML_Ref;$t_primer_XML_Ref)
				
				$t_refXML:=DOM Parse XML variable:C720($xBlob_respuesta)
				If (ok=1)
					  //ACTdte_CargarCAF
					$t_elem:=DOM Find XML element:C864($t_refXML;"ns2:doConsultaDTEResponse/estadoProcesamiento")
					If (OK=0)
						$b_continuar:=False:C215
					Else 
						DOM GET XML ELEMENT VALUE:C731($t_elem;$l_estado)
					End if 
					
					If ($l_estado=1)
						$t_primer_XML_Ref:=DOM Find XML element:C864($t_refXML;"ns2:doConsultaDTEResponse/dteConsulta")
						  //$t_primer_XML_Ref:=DOM Get first child XML element($t_primer_XML_Ref)
						$t_siguiente_XML_Ref:=$t_primer_XML_Ref
						While (ok=1)
							
							For ($l_indiceCampos;1;Size of array:C274($ay_arreglos))
								$t_nodo:=$aNombresNodo{$l_indiceCampos}
								If (ok=1)
									$t_elem:=DOM Find XML element:C864($t_siguiente_XML_Ref;"dteConsulta/"+$t_nodo)
									If (OK=0)
										$b_continuar:=False:C215
									Else 
										DOM GET XML ELEMENT VALUE:C731($t_elem;$value)
										
										If (($t_nodo="rutEmisor") | ($t_nodo="rutReceptor"))
											$value:=Replace string:C233($value;"-";"")
											$value:=Replace string:C233($value;".";"")
										End if 
										
										APPEND TO ARRAY:C911($ay_arreglos{$l_indiceCampos}->;$value)
										
									End if 
								End if 
							End for 
							$t_siguiente_XML_Ref:=DOM Get next sibling XML element:C724($t_siguiente_XML_Ref)
						End while 
					End if 
					DOM CLOSE XML:C722($t_refXML)
					
					C_LONGINT:C283($l_indiceFilas)
					For ($l_indiceFilas;1;Size of array:C274($atACT_rutEmisor))
						
						If ($t_rutRS=$atACT_rutReceptor{$l_indiceFilas})
							
							READ ONLY:C145([ACT_DTEs_Recibidos:238])
							
							QUERY:C277([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]rut_emisor:2=$atACT_rutEmisor{$l_indiceFilas};*)
							QUERY:C277([ACT_DTEs_Recibidos:238]; & ;[ACT_DTEs_Recibidos:238]rut_receptor:4=$atACT_rutReceptor{$l_indiceFilas};*)
							QUERY:C277([ACT_DTEs_Recibidos:238]; & ;[ACT_DTEs_Recibidos:238]tipo_dte:5=$atACT_tipoDTE{$l_indiceFilas};*)
							QUERY:C277([ACT_DTEs_Recibidos:238]; & ;[ACT_DTEs_Recibidos:238]folio_dte:6=$atACT_folioDTE{$l_indiceFilas})
							
							If (Records in selection:C76([ACT_DTEs_Recibidos:238])=0)
								C_LONGINT:C283($l_year;$l_mes;$l_dia)
								
								CREATE RECORD:C68([ACT_DTEs_Recibidos:238])
								
								[ACT_DTEs_Recibidos:238]id:1:=SQ_SeqNumber (->[ACT_DTEs_Recibidos:238]id:1)
								While (Find in field:C653([ACT_DTEs_Recibidos:238]id:1;[ACT_DTEs_Recibidos:238]id:1)>=0)
									[ACT_DTEs_Recibidos:238]id:1:=SQ_SeqNumber (->[ACT_DTEs_Recibidos:238]id:1)
								End while 
								[ACT_DTEs_Recibidos:238]rut_emisor:2:=$atACT_rutEmisor{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]razon_social_emiror:3:=$atACT_razonSocialEmisor{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]rut_receptor:4:=$atACT_rutReceptor{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]tipo_dte:5:=$atACT_tipoDTE{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]folio_dte:6:=$atACT_folioDTE{$l_indiceFilas}
								$l_year:=Num:C11(Substring:C12($atACT_fechaEmision{$l_indiceFilas};1;4))
								$l_mes:=Num:C11(Substring:C12($atACT_fechaEmision{$l_indiceFilas};6;2))
								$l_dia:=Num:C11(Substring:C12($atACT_fechaEmision{$l_indiceFilas};9;2))
								[ACT_DTEs_Recibidos:238]fecha_emision:7:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_year)
								$l_year:=Num:C11(Substring:C12($atACT_fechaRegistro{$l_indiceFilas};1;4))
								$l_mes:=Num:C11(Substring:C12($atACT_fechaRegistro{$l_indiceFilas};6;2))
								$l_dia:=Num:C11(Substring:C12($atACT_fechaRegistro{$l_indiceFilas};9;2))
								[ACT_DTEs_Recibidos:238]fecha_registro:8:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_year)
								[ACT_DTEs_Recibidos:238]monto_exento:9:=Num:C11($atACT_montoExento{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]monto_neto:10:=Num:C11($atACT_montoNeto{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]monto_iva:11:=Num:C11($atACT_montoIVA{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]monto_total:12:=Num:C11($atACT_montoTotal{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]estado_sii:13:=$atACT_estadoSII{$l_indiceFilas}
								SAVE RECORD:C53([ACT_DTEs_Recibidos:238])
								
								KRL_UnloadReadOnly (->[ACT_DTEs_Recibidos:238])
								
							End if 
						End if 
					End for 
					PREF_Set (0;"ACT_DTEs_recibidos";DTS_MakeFromDateTime ($vd_fechaEjecucion))
					
					$b_ejecutado:=True:C214
				Else 
					LOG_RegisterEvt ("No fue posible analizar la respuesta.")
				End if 
			Else 
				LOG_RegisterEvt ("Error al consultar documentos recibidos.")
			End if 
		End if 
	End for 
End if 

$0:=$b_ejecutado