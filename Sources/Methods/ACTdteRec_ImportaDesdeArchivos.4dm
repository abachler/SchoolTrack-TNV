//%attributes = {}
  //ACTdteRec_ImportaDesdeArchivos
C_LONGINT:C283($l_indiceRS;vlACT_RSSel;$l_indiceCampos)
C_BLOB:C604($xBlob_respuesta)
C_TEXT:C284($t_path)
C_LONGINT:C283($l_indiceFilas;$l_resp;$l_docs;$l_pid)
C_LONGINT:C283($l_idRS)

$l_idRS:=$1

$l_resp:=CD_Dlog (0;"A continuación serán cargados los documentos tributarios electrónicos recibidos."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
If ($l_resp=1)
	If (ACTdte_EsEmisorColegium ($l_idRS))
		C_TEXT:C284($t_elem)
		C_BOOLEAN:C305($b_continuar)
		C_TEXT:C284($t_rutRS)
		
		C_TEXT:C284($value)
		
		ARRAY TEXT:C222(aQR_Text1;0)
		ARRAY TEXT:C222(aQR_Text2;0)
		ARRAY TEXT:C222(aQR_Text3;0)
		ARRAY TEXT:C222(aQR_Text4;0)
		ARRAY TEXT:C222(aQR_Text5;0)
		ARRAY TEXT:C222(aQR_Text6;0)
		ARRAY TEXT:C222(aQR_Text7;0)
		ARRAY TEXT:C222(aQR_Text8;0)
		ARRAY TEXT:C222(aQR_Text9;0)
		ARRAY TEXT:C222(aQR_Text10;0)
		ARRAY TEXT:C222(aQR_Text11;0)
		ARRAY TEXT:C222(aQR_Text12;0)
		ARRAY TEXT:C222(aQR_Text13;0)
		ARRAY TEXT:C222(aQR_Text14;0)
		
		ARRAY POINTER:C280(aQR_Pointer1;0)
		
		ARRAY LONGINT:C221(aQR_Longint1;0)
		
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text1)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text2)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text3)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text4)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text5)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text6)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text7)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text8)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text9)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text10)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text11)
		APPEND TO ARRAY:C911(aQR_Pointer1;->aQR_Text12)
		
		ARRAY TEXT:C222(aQR_Text13;12)
		aQR_Text13{1}:="rutEmisor"
		aQR_Text13{2}:="razonSocialEmisor"
		aQR_Text13{3}:="rutReceptor"
		aQR_Text13{4}:="tipoDTE"
		aQR_Text13{5}:="folioDTE"
		aQR_Text13{6}:="fechaEmision"
		aQR_Text13{7}:="fechaRegistro"
		aQR_Text13{8}:="montoExento"
		aQR_Text13{9}:="montoNeto"
		aQR_Text13{10}:="montoIVA"
		aQR_Text13{11}:="montoTotal"
		aQR_Text13{12}:="estadoSII"
		
		$t_rutRS:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$l_idRS;->[ACT_RazonesSociales:279]RUT:3)
		
		C_TEXT:C284($t_folder)
		C_LONGINT:C283($l_errorBlob;$l_errorAnalisisRespuesta)
		$t_folder:=xfGetDirName 
		If ($t_folder#"")
			
			ARRAY TEXT:C222(aQR_Text14;0)
			DOCUMENT LIST:C474($t_folder;aQR_Text14)
			
			If (Find in array:C230(aQR_Text14;".DS_Store")>0)
				AT_Delete (Find in array:C230(aQR_Text14;".DS_Store");1;->aQR_Text14)
			End if 
			
			aQR_Text14{0}:=".xml"
			AT_SearchArray (->aQR_Text14;"@";->aQR_Longint1)
			
			If (Size of array:C274(aQR_Text14)=Size of array:C274(aQR_Longint1))
				$l_pid:=IT_UThermometer (1;0;"Leyendo archivos")
				For ($l_indiceFilas;1;Size of array:C274(aQR_Text14))
					
					SET BLOB SIZE:C606($xBlob_respuesta;0)
					$t_path:=$t_folder+aQR_Text14{$l_indiceFilas}
					If ($t_path#"")
						DOCUMENT TO BLOB:C525($t_path;$xBlob_respuesta)
					End if 
					
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
									
									For ($l_indiceCampos;1;Size of array:C274(aQR_Pointer1))
										$t_nodo:=aQR_Text13{$l_indiceCampos}
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
												
												  //APPEND TO ARRAY(aQR_Pointer1{$l_indiceCampos}->;$value) //no funcionó en compilado con footrunner
												If ($t_nodo="rutEmisor")
													APPEND TO ARRAY:C911(aQR_Text1;$value)
												End if 
												If ($t_nodo="razonSocialEmisor")
													APPEND TO ARRAY:C911(aQR_Text2;$value)
												End if 
												If ($t_nodo="rutReceptor")
													APPEND TO ARRAY:C911(aQR_Text3;$value)
												End if 
												If ($t_nodo="tipoDTE")
													APPEND TO ARRAY:C911(aQR_Text4;$value)
												End if 
												If ($t_nodo="folioDTE")
													APPEND TO ARRAY:C911(aQR_Text5;$value)
												End if 
												If ($t_nodo="fechaEmision")
													APPEND TO ARRAY:C911(aQR_Text6;$value)
												End if 
												If ($t_nodo="fechaRegistro")
													APPEND TO ARRAY:C911(aQR_Text7;$value)
												End if 
												If ($t_nodo="montoExento")
													APPEND TO ARRAY:C911(aQR_Text8;$value)
												End if 
												If ($t_nodo="montoNeto")
													APPEND TO ARRAY:C911(aQR_Text9;$value)
												End if 
												If ($t_nodo="montoIVA")
													APPEND TO ARRAY:C911(aQR_Text10;$value)
												End if 
												If ($t_nodo="montoTotal")
													APPEND TO ARRAY:C911(aQR_Text11;$value)
												End if 
												If ($t_nodo="estadoSII")
													APPEND TO ARRAY:C911(aQR_Text12;$value)
												End if 
											End if 
										End if 
									End for 
									$t_siguiente_XML_Ref:=DOM Get next sibling XML element:C724($t_siguiente_XML_Ref)
								End while 
								
							End if 
							DOM CLOSE XML:C722($t_refXML)
							
						Else 
							$l_errorAnalisisRespuesta:=1
							$l_indiceFilas:=Size of array:C274(aQR_Text14)
						End if 
					Else 
						$l_errorBlob:=1
						$l_indiceFilas:=Size of array:C274(aQR_Text14)
					End if 
					
				End for 
				IT_UThermometer (-2;$l_pid)
				
				If (($l_errorBlob=0) & ($l_errorAnalisisRespuesta=0))
					
					AT_RedimArrays (Size of array:C274(aQR_Text1);->aQR_Text12)  //20171030 RCH No todos los dtes tienen estado
					
					$l_pid:=IT_UThermometer (1;0;"Procesando datos...")
					For ($l_indiceFilas;1;Size of array:C274(aQR_Text1))
						
						If ($t_rutRS=aQR_Text3{$l_indiceFilas})
							
							READ ONLY:C145([ACT_DTEs_Recibidos:238])
							
							QUERY:C277([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]rut_emisor:2=aQR_Text1{$l_indiceFilas};*)
							QUERY:C277([ACT_DTEs_Recibidos:238]; & ;[ACT_DTEs_Recibidos:238]rut_receptor:4=aQR_Text3{$l_indiceFilas};*)
							QUERY:C277([ACT_DTEs_Recibidos:238]; & ;[ACT_DTEs_Recibidos:238]tipo_dte:5=aQR_Text4{$l_indiceFilas};*)
							QUERY:C277([ACT_DTEs_Recibidos:238]; & ;[ACT_DTEs_Recibidos:238]folio_dte:6=aQR_Text5{$l_indiceFilas})
							
							If (Records in selection:C76([ACT_DTEs_Recibidos:238])=0)
								C_LONGINT:C283($l_year;$l_mes;$l_dia)
								$l_docs:=$l_docs+1
								CREATE RECORD:C68([ACT_DTEs_Recibidos:238])
								
								[ACT_DTEs_Recibidos:238]id:1:=SQ_SeqNumber (->[ACT_DTEs_Recibidos:238]id:1)
								While (Find in field:C653([ACT_DTEs_Recibidos:238]id:1;[ACT_DTEs_Recibidos:238]id:1)>=0)
									[ACT_DTEs_Recibidos:238]id:1:=SQ_SeqNumber (->[ACT_DTEs_Recibidos:238]id:1)
								End while 
								[ACT_DTEs_Recibidos:238]rut_emisor:2:=aQR_Text1{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]razon_social_emiror:3:=aQR_Text2{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]rut_receptor:4:=aQR_Text3{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]tipo_dte:5:=aQR_Text4{$l_indiceFilas}
								[ACT_DTEs_Recibidos:238]folio_dte:6:=aQR_Text5{$l_indiceFilas}
								$l_year:=Num:C11(Substring:C12(aQR_Text6{$l_indiceFilas};1;4))
								$l_mes:=Num:C11(Substring:C12(aQR_Text6{$l_indiceFilas};6;2))
								$l_dia:=Num:C11(Substring:C12(aQR_Text6{$l_indiceFilas};9;2))
								[ACT_DTEs_Recibidos:238]fecha_emision:7:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_year)
								$l_year:=Num:C11(Substring:C12(aQR_Text7{$l_indiceFilas};1;4))
								$l_mes:=Num:C11(Substring:C12(aQR_Text7{$l_indiceFilas};6;2))
								$l_dia:=Num:C11(Substring:C12(aQR_Text7{$l_indiceFilas};9;2))
								[ACT_DTEs_Recibidos:238]fecha_registro:8:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_year)
								[ACT_DTEs_Recibidos:238]monto_exento:9:=Num:C11(aQR_Text8{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]monto_neto:10:=Num:C11(aQR_Text9{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]monto_iva:11:=Num:C11(aQR_Text10{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]monto_total:12:=Num:C11(aQR_Text11{$l_indiceFilas})
								[ACT_DTEs_Recibidos:238]estado_sii:13:=aQR_Text12{$l_indiceFilas}
								SAVE RECORD:C53([ACT_DTEs_Recibidos:238])
								
								KRL_UnloadReadOnly (->[ACT_DTEs_Recibidos:238])
								
							End if 
						End if 
					End for 
					IT_UThermometer (-2;$l_pid)
					LOG_RegisterEvt ("Importación de documentos recibidos. Se procesaron los archivos: "+AT_array2text (->aQR_Text14)+", desde la ruta: "+$t_folder+"")
					CD_Dlog (0;String:C10($l_docs)+" documentos recibidos fueron importados.")
				Else 
					CD_Dlog (0;"Se produjo un error.")
				End if 
			Else 
				CD_Dlog (0;"El directorio debe contener solo documentos .xml")
			End if 
		Else 
			
		End if 
	End if 
	
	
	AT_Initialize (->aQR_Text1;->aQR_Text2;->aQR_Text3;->aQR_Text4;->aQR_Text5;->aQR_Text6;->aQR_Text7;->aQR_Text8;->aQR_Text9;->aQR_Text10;->aQR_Text11;->aQR_Text12;->aQR_Text13;->aQR_Text14;->aQR_Pointer1;->aQR_Longint1)
	
End if 