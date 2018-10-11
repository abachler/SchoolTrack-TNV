//%attributes = {}
  //SCRIPT IMPORTA TXT SET DE PRUEBAS BOLETAS ELECTRÓNICAS
  //ACTdte_GeneraSetDePruebaBoleta
  //verifica que exista SII
C_BOOLEAN:C305($b_error)
C_LONGINT:C283($l_idTercero)
C_REAL:C285($r_error)

  //lectura archivo
C_TEXT:C284($delimiterM;$text)
C_TIME:C306($ref)
C_LONGINT:C283($l_caso)
C_TEXT:C284($t_item;$t_obs)
C_REAL:C285($r_cantidad;$r_precio)
C_BOOLEAN:C305($b_afecto)

ARRAY LONGINT:C221($al_refItem;0)
ARRAY LONGINT:C221($al_caso;0)
ARRAY TEXT:C222($at_item;0)
ARRAY REAL:C219($ar_cantidad;0)
ARRAY REAL:C219($ar_precio;0)
ARRAY TEXT:C222($at_observaciones;0)

  //casos unicos
ARRAY LONGINT:C221($alACT_casosUnicos;0)

  //folios
C_REAL:C285($r_foliosDisponibles)

  //razones sociales
ARRAY LONGINT:C221($al_razones;0)
ARRAY TEXT:C222($at_razones;0)
ARRAY TEXT:C222($at_rut;0)
C_REAL:C285($r_idRS)

  // /genera avisos
ARRAY LONGINT:C221($al_recNumCargos;0)
ARRAY LONGINT:C221($al_recNumCargosT;0)

  //para boletas
C_BOOLEAN:C305(vbACT_RegistrarIDSBoletas)
ARRAY LONGINT:C221(alACT_idsBoletasEmitidas;0)
vbACT_RegistrarIDSBoletas:=False:C215

ARRAY LONGINT:C221($alACT_idsDocsOK;0)

  //solo para Chile
If (<>gCountryCode="cl")
	  //selecciona razon social
	READ ONLY:C145([ACT_RazonesSociales:279])
	ALL RECORDS:C47([ACT_RazonesSociales:279])
	While (Not:C34(End selection:C36([ACT_RazonesSociales:279])))
		If (ACTdte_EsEmisorColegium ([ACT_RazonesSociales:279]id:1))
			APPEND TO ARRAY:C911($al_razones;[ACT_RazonesSociales:279]id:1)
			APPEND TO ARRAY:C911($at_razones;[ACT_RazonesSociales:279]razon_social:2)
			APPEND TO ARRAY:C911($at_rut;SR_FormatoRUT2 ([ACT_RazonesSociales:279]RUT:3))
		End if 
		NEXT RECORD:C51([ACT_RazonesSociales:279])
	End while 
	
	If (Size of array:C274($al_razones)>0)
		If (Size of array:C274($al_razones)>1)
			C_POINTER:C301($y_pointer)
			SRtbl_ShowChoiceList (0;"Seleccione RS";-MAXINT:K35:1;->$y_pointer;False:C215;->$al_razones;->$at_razones;->$at_rut)
			If (ok=1)
				$r_idRS:=$al_razones{choiceidx}
			Else 
				$r_error:=1
			End if 
		Else 
			$r_idRS:=$al_razones{1}
		End if 
	Else 
		$r_error:=1
	End if 
	
	  //verifica conf boletas y NC
	ACTcfg_LoadConfigData (8)
	For ($i;1;Size of array:C274(alACT_IDsCats))
		$b_error:=Not:C34(ACTcfg_SearchCatDocs (alACT_IDsCats{$i}))
		If (Not:C34($b_error))
			APPEND TO ARRAY:C911($alACT_idsDocsOK;alACT_IDsCats{$i})
		Else 
			$r_error:=4
		End if 
	End for 
	
	If ($r_error=0)
		ARRAY LONGINT:C221($DA_Return;0)
		$alACT_idsDocsOK{0}:=0
		AT_SearchArray (->$alACT_idsDocsOK;">";->$DA_Return)
		If (Size of array:C274($DA_Return)=0)  //bol sin id
			If (Find in array:C230(alACT_IDsCats;-1)=-1)  //Bol
				$r_error:=2
			End if 
		End if 
		
		If (Find in array:C230(alACT_IDsCats;-4)=-1)  //NC
			$r_error:=3
		End if 
		
	End if 
	
	If ($r_error=0)
		ACTdte_EsEmisorColegium ($r_idRS)
		If (Not:C34(bACT_emisorAutorizadoCLG))
			$r_error:=20
		End if 
	Else 
		$r_error:=21
	End if 
	
	If ($r_error=0)
		READ ONLY:C145([ACT_Terceros:138])
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4="666666666")
		If (Records in selection:C76([ACT_Terceros:138])>0)
			QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]Nombre_Completo:9#"SII")
			If (Records in selection:C76([ACT_Terceros:138])>0)
				$r_error:=22
			End if 
		End if 
	End if 
	
	  //lee archivo
	If ($r_error=0)
		If (Is compiled mode:C492)
			$t_ruta:=xfGetFileName 
		Else 
			C_TEXT:C284(<>tACT_rutaSet)
			If (<>tACT_rutaSet="")
				<>tACT_rutaSet:=xfGetFileName 
			End if 
			$t_ruta:=<>tACT_rutaSet
		End if 
		
		If (ok=1)
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("Windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
			$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
			
			$ref:=Open document:C264($t_ruta;"";Read mode:K24:5)
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			While ($text#"")
				$l_caso:=Num:C11(ST_GetWord ($text;1;"\t"))
				$t_item:=ST_GetWord ($text;2;"\t")
				$r_cantidad:=Num:C11(ST_GetWord ($text;3;"\t"))
				
				If ($l_caso=1)
					If ($t_item="@koyak el chupete@")
						$b_afecto:=True:C214
					Else 
						$b_afecto:=False:C215
					End if 
				End if 
				
				If ($b_afecto)
					$r_precio:=Num:C11(ST_GetWord ($text;4;"\t"))
				Else 
					$r_precio:=Num:C11(ST_GetWord ($text;5;"\t"))
				End if 
				$t_obs:=ST_GetWord ($text;5;"\t")
				
				If (($r_cantidad#0) | ($r_precio#0))
					If ($l_caso#0)
						APPEND TO ARRAY:C911($al_caso;$l_caso)
					Else 
						APPEND TO ARRAY:C911($al_caso;$al_caso{Size of array:C274($al_caso)})
					End if 
					If (Position:C15(Char:C90(34);$t_item)#0)
						$t_item:=Replace string:C233($t_item;Char:C90(34);"")
						$t_item:=$t_item+Char:C90(34)
					End if 
					APPEND TO ARRAY:C911($at_item;$t_item)
					APPEND TO ARRAY:C911($ar_cantidad;$r_cantidad)
					APPEND TO ARRAY:C911($ar_precio;$r_precio)
					APPEND TO ARRAY:C911($at_observaciones;$t_obs)
				End if 
				RECEIVE PACKET:C104($ref;$text;$delimiter)
			End while 
			CLOSE DOCUMENT:C267($ref)
			
			USE CHARACTER SET:C205(*;1)
		Else 
			$r_error:=5
		End if 
	End if 
	
	If ($r_error=0)
		If (Size of array:C274($at_item)=0)
			$r_error:=5
		Else 
			COPY ARRAY:C226($al_caso;$alACT_casosUnicos)
			AT_DistinctsArrayValues (->$alACT_casosUnicos)
		End if 
	End if 
	
	
	  //verifica carga de folios
	If ($r_error=0)
		READ ONLY:C145([ACT_FoliosDT:293])
		QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]id_razonSocial:8=$r_idRS;*)
		If (Size of array:C274($alACT_casosUnicos)=5)  //caso exenta
			QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]tipo_dteSII:7=41;*)
		Else   //caso afecta
			QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]tipo_dteSII:7=39;*)
		End if 
		QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1)
		
		$r_foliosDisponibles:=0
		While (Not:C34(End selection:C36([ACT_FoliosDT:293])))
			$r_foliosDisponibles:=[ACT_FoliosDT:293]hasta:5-[ACT_FoliosDT:293]folio_disponible:6+1
			NEXT RECORD:C51([ACT_FoliosDT:293])
		End while 
		
		If (Size of array:C274($alACT_casosUnicos)=5)
			If ($r_foliosDisponibles#5)
				$r_error:=6
			End if 
		Else 
			If ($r_foliosDisponibles#10)
				$r_error:=6
			End if 
		End if 
	End if 
	
	
	START TRANSACTION:C239
	  //verifica si tercero existe. Si no existe se crea
	If ($r_error=0)
		READ ONLY:C145([ACT_Terceros:138])
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4="666666666")
		If (Records in selection:C76([ACT_Terceros:138])=0)
			C_TEXT:C284(vtACT_NumTC)
			$ok:=ACTter_CreateRecord ("666666666";"SII";True:C214;"Teatinos 120";"Santiago";"Santiago";"Servicio de Impuestos Internos")
			If ($ok=1)
				QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4="666666666")
				If (Records in selection:C76([ACT_Terceros:138])=1)
					$l_idTercero:=[ACT_Terceros:138]Id:1
				Else 
					$r_error:=7
				End if 
			End if 
		Else 
			If ([ACT_Terceros:138]Nombre_Completo:9="SII")
				$l_idTercero:=[ACT_Terceros:138]Id:1
			Else 
				$r_error:=12
			End if 
		End if 
	End if 
	
	
	  //me aseguro de emitir para el SII
	If ($r_error=0)
		KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero;True:C214)
		If (ok=1)
			[ACT_Terceros:138]ReceptorDT_tipo:76:=0
			[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=0
			[ACT_Terceros:138]ReceptorDT_id_tercero:77:=0
			SAVE RECORD:C53([ACT_Terceros:138])
		Else 
			If ([ACT_Terceros:138]ReceptorDT_tipo:76#0)
				$r_error:=8
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Terceros:138])
		
	End if 
	
	  //crea ítems de cargo
	If ($r_error=0)
		For ($l_indice;1;Size of array:C274($at_item))
			READ ONLY:C145([xxACT_Items:179])
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Glosa:2=$at_item{$l_indice};*)
			QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]Monto:7=$ar_precio{$l_indice};*)
			QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]VentaRapida:3=True:C214)
			If (Records in selection:C76([xxACT_Items:179])=0)
				$l_idItem:=ACTitem_CreateRecord ($at_item{$l_indice};Choose:C955((Size of array:C274($alACT_casosUnicos)=5);False:C215;Not:C34((Position:C15("exento";$at_item{$l_indice})>0)));False:C215;ST_GetWord (ACT_DivisaPais ;1;";");$ar_precio{$l_indice})
				APPEND TO ARRAY:C911($al_refItem;$l_idItem)
				KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem;True:C214)
				[xxACT_Items:179]VentaRapida:3:=True:C214
				Case of 
					: ([xxACT_Items:179]Glosa:2="@Clavo@")
						[xxACT_Items:179]Unidad_de_Medida:46:="Kg"
					: ([xxACT_Items:179]Glosa:2="Servicios educacionales de docencia")
						[xxACT_Items:179]Unidad_de_Medida:46:="mensual"
					Else 
						If (Size of array:C274($alACT_casosUnicos)=5)
							[xxACT_Items:179]Unidad_de_Medida:46:="u."
						End if 
				End case 
				SAVE RECORD:C53([xxACT_Items:179])
				KRL_UnloadReadOnly (->[xxACT_Items:179])
			Else 
				APPEND TO ARRAY:C911($al_refItem;[xxACT_Items:179]ID:1)
			End if 
		End for 
		
		If (Size of array:C274($at_item)#Size of array:C274($al_refItem))
			$r_error:=9
		End if 
		
	End if 
	
	  //genera avisos de cobranza
	If ($r_error=0)
		ACTcfg_LoadConfigData (1)
		C_REAL:C285(vrACT_MontoAdeudado)
		
		For ($l_indice;1;Size of array:C274($alACT_casosUnicos))
			If ($r_error=0)
				  //limpia arreglos
				RNApdo:=-1
				RNTercero:=KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero)
				vsACT_NomApellido:=[ACT_Terceros:138]Nombre_Completo:9
				vdACT_FechaPago:=Current date:C33(*)
				vdACT_FechaE:=vdACT_FechaPago
				vrACT_MontoAdeudado:=0
				
				ACTpgs_OpcionesVR ("ACT_initArrays")
				
				btn_apdo:=0
				btn_tercero:=1
				ACTpgs_OpcionesVR ("SetPointers")
				
				  //llena arreglos
				ARRAY LONGINT:C221($alACT_posiciones;0)
				$al_caso{0}:=$alACT_casosUnicos{$l_indice}
				AT_SearchArray (->$al_caso;"=";->$alACT_posiciones)
				For ($l_pos;1;Size of array:C274($alACT_posiciones))
					APPEND TO ARRAY:C911(arACT_PgsVRCantidad;$ar_cantidad{$alACT_posiciones{$l_pos}})
					APPEND TO ARRAY:C911(atACT_PgsVRDetalle;$at_item{$alACT_posiciones{$l_pos}})
					APPEND TO ARRAY:C911(arACT_PgsVRMonto;$ar_precio{$alACT_posiciones{$l_pos}})
					APPEND TO ARRAY:C911(arACT_PgsVRTotal;$ar_cantidad{$alACT_posiciones{$l_pos}}*$ar_precio{$alACT_posiciones{$l_pos}})
					APPEND TO ARRAY:C911(alACT_PgsVRIDItem;$al_refItem{$alACT_posiciones{$l_pos}})
				End for 
				vr_Total:=AT_GetSumArray (->arACT_PgsVRTotal)
				  //verifica emision
				$vb_go:=ACTpgs_OpcionesVR ("ValidaSoloEmitir")
				If ($vb_go)
					ACTpgs_OpcionesVR ("GeneraAvisos")
					
					  //genero arreglo con todos los cargos
					COPY ARRAY:C226($al_recNumCargos;$al_recNumCargosT)
					AT_Union (->alACT_PgsVDRecNumCargos;->$al_recNumCargosT;->$al_recNumCargos)
					
					ACTpgs_OpcionesVR ("ACT_initArrays")
					ACTpgs_OpcionesVR ("LimpiaVarsForm")
				Else 
					$r_error:=10
					$l_indice:=Size of array:C274($alACT_casosUnicos)
				End if 
			End if 
		End for 
	End if 
	
	  //verifica emision de AC
	If ($r_error=0)
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_recNumCargos;"")
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
		
		If (Size of array:C274($alACT_casosUnicos)=5)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#5)
				$r_error:=11
			End if 
		Else 
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#10)
				$r_error:=11
			End if 
		End if 
	End if 
	
	  //verifico errores
	  //antes de la emision de las boletas se valida o cancela la transaccion puesto que se inicia una nueva dentro del metodo de emisión de D.T.
	
	  //valido o cancelo transaccion
	If ($r_error#0)
		CANCEL TRANSACTION:C241
		Case of 
			: ($r_error=20)
				CD_Dlog (0;"La base está configurada pero no tiene licencia.")
			: ($r_error=21)
				CD_Dlog (0;"Complete la configuración inicial.")
			: ($r_error=22)
				CD_Dlog (0;"Ya existe un Tercero con el RUT del SII.")
			: ($r_error=6)
				CD_Dlog (0;"No hay folios disponible cargados. Para el archivo leido, se deben descargar: "+Choose:C955((Size of array:C274($alACT_casosUnicos)=5);"5";"10")+" folios tipo: "+Choose:C955((Size of array:C274($alACT_casosUnicos)=5);"41";"39")+".")
			: ($r_error=7)
				CD_Dlog (0;"Error al crear tercero SII.")
			: ($r_error=9)
				CD_Dlog (0;"Error al crear ítems de cargo.")
			: ($r_error=10)
				CD_Dlog (0;"Error al generar cargos.")
			: ($r_error=1)
				CD_Dlog (0;"Error al obtener Razón Social.")
			: ($r_error=11)
				CD_Dlog (0;"Error al emitir Avisos de Cobranza.")
			: ($r_error=2)
				CD_Dlog (0;"Error en configuración de Boletas.")
			: ($r_error=3)
				CD_Dlog (0;"Error en configuración de Notas de Crédito.")
			: ($r_error=4)
				CD_Dlog (0;"Error en configuración de Documentos Tributarios.")
			: ($r_error=5)
				CD_Dlog (0;"Error al leer archivo de texto.")
			: ($r_error=8)
				CD_Dlog (0;"Error en configuración de Receptor de DT para el tercero SII.")
			: ($r_error=12)
				CD_Dlog (0;"Error, Tercero 666666666 no es SII.")
			Else 
				CD_Dlog (0;"Error.")
				
		End case 
		
	Else 
		VALIDATE TRANSACTION:C240
	End if 
	
	
	  //emite boletas electrónicas
	If ($r_error=0)
		
		  //20151230 RCH
		ACTcfg_LoadConfigData (8)
		$cb_ImprimirCeros:=cb_ImprimirCeros
		$cbUsarCategorias:=cbUsarCategorias
		$cbAgruparBoletas:=cbAgruparBoletas
		$cb_BoletaSubvencionada:=cb_BoletaSubvencionada
		cb_ImprimirCeros:=0
		cbUsarCategorias:=0
		cbAgruparBoletas:=0
		cb_BoletaSubvencionada:=0
		ACTcfg_SaveConfig (8)
		
		vbACT_RegistrarIDSBoletas:=True:C214
		
		vdACT_FEmisionBol:=Current date:C33(*)
		  //emitir e imprimir
		b1:=1
		b2:=0
		b3:=0
		  //los seleccionados
		f1:=1
		f2:=0
		  //total avisos
		i2:=1
		i1:=0
		  //para tercero
		e1:=0
		e2:=0
		e3:=1
		e4:=0
		  //un documento por total
		h1:=0
		s1:=0
		s2:=0
		h2:=0
		h3:=1
		ACTbol_EMasivaDocTribs 
		
		
		SET_ClearSets ("Selection")
		
		  //verifico boletas emitidas
		If (Size of array:C274($alACT_casosUnicos)=5)
			If (Size of array:C274(alACT_idsBoletasEmitidas)#5)
				$r_error:=12
			End if 
		Else 
			If (Size of array:C274(alACT_idsBoletasEmitidas)#10)
				$r_error:=12
			End if 
		End if 
		
		
		  //obtiene PDFs
		If ($r_error=0)
			  //alACT_idsBoletasEmitidas
			READ ONLY:C145([ACT_Boletas:181])
			
			  //20150812 RCH lee pref para ver si quiere la copia cedible
			ACTdte_OpcionesManeja ("LeeBlob")
			  //
			TRACE:C157
			  //hay un error porque se estan emitiendo al reves
			For ($l_indice;1;Size of array:C274(alACT_idsBoletasEmitidas))
				READ WRITE:C146([ACT_Boletas:181])
				$l_idBoleta:=alACT_idsBoletasEmitidas{$l_indice}
				KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta)
				
				  //validacion
				If (Size of array:C274($alACT_casosUnicos)=5)
					
				Else 
					Case of 
						: ($l_indice=1)
							If ([ACT_Boletas:181]Monto_Total:6#23040)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=2)
							If ([ACT_Boletas:181]Monto_Total:6#86710)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=3)
							If ([ACT_Boletas:181]Monto_Total:6#37920)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=4)
							If ([ACT_Boletas:181]Monto_Total:6#28180)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=5)
							If ([ACT_Boletas:181]Monto_Total:6#20280)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=6)
							If ([ACT_Boletas:181]Monto_Total:6#20125)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=7)
							If ([ACT_Boletas:181]Monto_Total:6#1700)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=8)
							If ([ACT_Boletas:181]Monto_Total:6#21590)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=9)
							If ([ACT_Boletas:181]Monto_Total:6#12400)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
						: ($l_indice=10)
							If ([ACT_Boletas:181]Monto_Total:6#2698)
								CD_Dlog (0;"Revisar boletas porque al parecer fueron emitidas en orden diferente o por montos diferentes")
							End if 
							
					End case 
				End if 
				
				If ([ACT_Boletas:181]Numero:11=0)  //si no se encuentra el documento
					If ([ACT_Boletas:181]documento_electronico:29)  //si el documento es electrónico
						If ([ACT_Boletas:181]DTE_estado_id:24 ?? 0)  //si es emisor CLG
							If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2))  //Si no ha sido enviado
								
								If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 1))
									[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1
									SAVE RECORD:C53([ACT_Boletas:181])
								End if 
								$vl_procesados:=ACTdte_EmiteDocumento ($l_idBoleta)
								$t_ruta:=ACTdte_ObtienePDFDT ($l_idBoleta)
							End if 
						End if 
					End if 
				End if 
				KRL_UnloadReadOnly (->[ACT_Boletas:181])
			End for 
			
			  //  //20151230 RCH
			  //ACTcfg_LoadConfigData (8)
			  //cb_ImprimirCeros:=$cb_ImprimirCeros
			  //cbUsarCategorias:=$cbUsarCategorias
			  //cbAgruparBoletas:=$cbAgruparBoletas
			  //cb_BoletaSubvencionada:=$cb_BoletaSubvencionada
			  //ACTcfg_SaveConfig (8)
			
			TRACE:C157
			  //FALTA
			  //1. emite NC electronicas
			
			  //2. crear servicio para generar el consumo de folios para la base actual y obtener el trackid del envío
			
			  //3. crear servicio para enviar el consumo de folios para la base actual
			
			  //4. crear servicio para generar el libro de boletas para para la base actual, para el periodo deseado
			
			
			
			If (Test path name:C476($t_ruta)=Is a document:K24:1)
				SHOW ON DISK:C922($t_ruta)
			End if 
			
		Else 
			CD_Dlog (0;"Error al emitir los Documentos. Algunos documentos podría haber sido emitidos.")
		End if 
	End if 
End if 

vbACT_RegistrarIDSBoletas:=False:C215

