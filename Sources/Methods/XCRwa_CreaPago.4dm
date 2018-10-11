//%attributes = {}
  //XCRwa_CreaPago
C_TEXT:C284($root)
C_REAL:C285($r_error)
C_TEXT:C284($t_json;$0;$json)
C_LONGINT:C283($l_idApdo)
C_TEXT:C284($t_app;$t_obs)

C_LONGINT:C283(cbSolicitaMotivoCondonacion)

If (Count parameters:C259>=1)
	$t_json:=$1
Else 
	$t_json:=XCRwa_TestsJSONXCR 
End if 

If (Semaphore:C143("ACT_IngresoXCR";300))
	$r_error:=-22
End if 

If ($r_error=0)
	  //$root:=JSON Parse text ($t_json)
	  //If (($root#"0") & ($root#"false"))
	  //If (($root#"0") & ($root#"false") & ($root#""))  //20170321 RCH
	
	If (Valida_json ($t_json))
		
		C_REAL:C285($r_montoTotal;$r_ordenCompra)
		C_TEXT:C284($t_uuidT;$t_fechaP;$t_ApdoUuid;$t_ApdoNombre;$t_ApdoApellido1;$t_ApdoApellido2)
		C_TEXT:C284($t_llave)
		C_TEXT:C284($t_uuidAl;$t_uuidAlKey)
		C_TEXT:C284($t_detalleVenta)
		
		ARRAY TEXT:C222(atXCR_uuidXCR;0)
		ARRAY TEXT:C222(atXCR_uuidAL;0)
		ARRAY TEXT:C222(atXCR_nombre;0)
		ARRAY TEXT:C222(atXCR_nombres;0)
		ARRAY TEXT:C222(atXCR_ap1;0)
		ARRAY TEXT:C222(atXCR_ap2;0)
		ARRAY REAL:C219(arXCR_montos;0)
		ARRAY REAL:C219(arXCR_idACT;0)
		
		ARRAY TEXT:C222(at_nodes;0)
		ARRAY LONGINT:C221(al_tipos;0)
		ARRAY TEXT:C222(at_nombres;0)
		ARRAY TEXT:C222(at_nodes2;0)
		ARRAY LONGINT:C221(al_tipos2;0)
		ARRAY TEXT:C222(at_nombres2;0)
		C_LONGINT:C283($l_agregaGlosa;$l_emiteBoleta)
		C_BOOLEAN:C305($b_esEmisorColegium)
		
		ARRAY LONGINT:C221($alACT_idRS;0)  //ids razones sociales de cargos
		ARRAY LONGINT:C221($alACT_idApdoCuenta;0)  //id apdo cta
		ARRAY LONGINT:C221($alACT_idsPagos;0)  //ids pagos
		
		
		
		C_REAL:C285($r_montoTotal)
		C_TEXT:C284($t_uuidT;$t_fechaP;$t_ApdoUuid;$t_ApdoNombre;$t_ApdoApellido1;$t_ApdoApellido2;$t_llave;$t_app;$t_detalleVenta)
		C_LONGINT:C283($l_agregaGlosa;$l_emiteBoleta)
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //TICKET 179869
		  //cambio de plugin a comando nativo
		
		
		$ob_raiz:=OB_Create 
		$ob_raiz:=JSON Parse:C1218($t_json;Is object:K8:27)
		
		OB_GET ($ob_raiz;->$r_montoTotal;"monto_total")
		OB_GET ($ob_raiz;->$t_uuidT;"uuid_transaccion")
		OB_GET ($ob_raiz;->$t_fechaP;"fecha_pago")
		OB_GET ($ob_raiz;->$r_ordenCompra;"orden_compra")
		OB_GET ($ob_raiz;->$t_ApdoUuid;"uuid_pagador")
		OB_GET ($ob_raiz;->$t_ApdoNombre;"nombres_pagador")
		OB_GET ($ob_raiz;->$t_ApdoApellido1;"apellido1_pagador")
		OB_GET ($ob_raiz;->$t_ApdoApellido2;"apellido2_pagador")
		OB_GET ($ob_raiz;->$l_agregaGlosa;"agregar_glosa")
		OB_GET ($ob_raiz;->$l_emiteBoleta;"emitir_boleta")
		OB_GET ($ob_raiz;->$t_llave;"llave")
		OB_GET ($ob_raiz;->$t_app;"aplicacion")
		OB_GET ($ob_raiz;->$t_detalleVenta;"detalle_venta")  //20160525 RCH
		
		
		  //JSON_ExtraeValor ($root;"monto_total";->$r_montoTotal)
		  //JSON_ExtraeValor ($root;"uuid_transaccion";->$t_uuidT)
		  //JSON_ExtraeValor ($root;"fecha_pago";->$t_fechaP)
		  //JSON_ExtraeValor ($root;"orden_compra";->$r_ordenCompra)
		  //JSON_ExtraeValor ($root;"uuid_pagador";->$t_ApdoUuid)
		  //JSON_ExtraeValor ($root;"nombres_pagador";->$t_ApdoNombre)
		  //JSON_ExtraeValor ($root;"apellido1_pagador";->$t_ApdoApellido1)
		  //JSON_ExtraeValor ($root;"apellido2_pagador";->$t_ApdoApellido2)
		  //JSON_ExtraeValor ($root;"agregar_glosa";->$l_agregaGlosa)
		  //JSON_ExtraeValor ($root;"emitir_boleta";->$l_emiteBoleta)
		  //JSON_ExtraeValor ($root;"llave";->$t_llave)
		  //JSON_ExtraeValor ($root;"aplicacion";->$t_app)
		  //JSON_ExtraeValor ($root;"detalle_venta";->$t_detalleVenta)  //20160525 RCH
		ARRAY OBJECT:C1221($ao_DPagos;0)
		OB_GET ($ob_raiz;->$ao_DPagos;"datos_pagos")
		
		
		
		C_TEXT:C284($t_uuid_detalle_extracurricular;$t_uuidAlKey;$t_uuid_alumno;$t_nombre;$t_nombres_alumno;$t_apellido1_alumno;$t_apellido2_alumno)
		C_REAL:C285($r_monto;$r_id_act)
		
		
		For ($i;1;Size of array:C274($ao_DPagos))
			OB_GET ($ao_DPagos{$i};->$t_uuid_detalle_extracurricular;"uuid_detalle_extracurricular")
			OB_GET ($ao_DPagos{$i};->$t_uuid_alumno;"uuid_alumno")
			OB_GET ($ao_DPagos{$i};->$t_nombre;"nombre")
			OB_GET ($ao_DPagos{$i};->$t_nombres_alumno;"nombres_alumno")
			OB_GET ($ao_DPagos{$i};->$t_apellido1_alumno;"apellido1_alumno")
			OB_GET ($ao_DPagos{$i};->$t_apellido2_alumno;"apellido2_alumno")
			OB_GET ($ao_DPagos{$i};->$r_monto;"monto")
			OB_GET ($ao_DPagos{$i};->$r_id_act;"id_act")
			
			APPEND TO ARRAY:C911(atXCR_uuidXCR;$t_uuid_detalle_extracurricular)
			APPEND TO ARRAY:C911(atXCR_uuidAL;$t_uuid_alumno)
			
			$t_uuidAlKey:=$t_uuidAlKey+atXCR_uuidAL{Size of array:C274(atXCR_uuidAL)}
			
			APPEND TO ARRAY:C911(atXCR_nombre;$t_nombre)
			APPEND TO ARRAY:C911(atXCR_nombres;$t_nombres_alumno)
			APPEND TO ARRAY:C911(atXCR_ap1;$t_apellido1_alumno)
			APPEND TO ARRAY:C911(atXCR_ap2;$t_apellido2_alumno)
			APPEND TO ARRAY:C911(arXCR_montos;$r_monto)
			APPEND TO ARRAY:C911(arXCR_idACT;$r_id_act)
		End for 
		
		  //$t_jsonDP:=JSON Get child by name ($root;"datos_pagos";JSON_CASE_INSENSITIVE)
		  //JSON GET CHILD NODES ($t_jsonDP;at_nodes;al_tipos;at_nombres)
		  //For ($i;1;Size of array(at_nodes))
		  //JSON GET CHILD NODES (at_nodes{$i};at_nodes2;al_tipos2;at_nombres2)
		  //For ($j;1;Size of array(at_nodes2))
		  //Case of 
		  //: (at_nombres2{$j}="uuid_detalle_extracurricular")
		  //APPEND TO ARRAY(atXCR_uuidXCR;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="uuid_alumno")
		  //APPEND TO ARRAY(atXCR_uuidAL;JSON Get text (at_nodes2{$j}))
		  //$t_uuidAlKey:=$t_uuidAlKey+atXCR_uuidAL{Size of array(atXCR_uuidAL)}
		  //: (at_nombres2{$j}="nombre")
		  //APPEND TO ARRAY(atXCR_nombre;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="nombres_alumno")
		  //APPEND TO ARRAY(atXCR_nombres;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="apellido1_alumno")
		  //APPEND TO ARRAY(atXCR_ap1;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="apellido2_alumno")
		  //APPEND TO ARRAY(atXCR_ap2;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="monto")
		  //APPEND TO ARRAY(arXCR_montos;JSON Get real (at_nodes2{$j}))
		  //: (at_nombres2{$j}="id_act")
		  //APPEND TO ARRAY(arXCR_idACT;JSON Get real (at_nodes2{$j}))
		  //End case 
		  //End for 
		  //End for 
		  //JSON CLOSE ($root)
	Else 
		$r_error:=-10
	End if 
	
	  //validaciones generales
	If ($r_error=0)
		  //verifica llave vacía
		If ($t_llave="")
			If (Is compiled mode:C492)
				$r_error:=-18
			End if 
		End if 
	End if 
	If ($r_error=0)
		  //verifica que llave conincida
		If ($t_llave#XCRwa_GeneraLlave ($t_ApdoUuid;$t_uuidAlKey;String:C10($r_montoTotal)))
			$r_error:=-3
		End if 
	End if 
	If ($r_error=0)
		  //verifica que se hayan obtenido correctamente las extracurriculares
		If (Size of array:C274(arXCR_idACT)=0)
			$r_error:=-11
		End if 
	End if 
	If ($r_error=0)
		  //verifica que monto de extracurriculares sea igual a monto de pago
		If ((AT_GetSumArray (->arXCR_montos)#$r_montoTotal) & ($r_montoTotal#0))
			$r_error:=-5
		End if 
	End if 
	If ($r_error=0)
		  //verifica fecha de pago
		$d_fechaP:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fechaP;9;2));Num:C11(Substring:C12($t_fechaP;6;2));Num:C11(Substring:C12($t_fechaP;1;4)))
		If (($d_fechaP<=Add to date:C393(Current date:C33(*);-1;0;0)) | ($d_fechaP>=Add to date:C393(Current date:C33(*);1;0;0)))
			$r_error:=-12
		End if 
	End if 
	If ($r_error=0)
		  //verifica que venga una orden de compra
		If (($r_montoTotal#0) & ($r_ordenCompra=0))
			$r_error:=-20
		End if 
	End if 
	If ($r_error=0)
		  //verifica que la orden de compra no exista en la base
		If (Find in field:C653([ACT_Pagos:172]ID_WebpayOC:32;$r_ordenCompra)#-1)
			$r_error:=-21
		End if 
	End if 
	
	If ($r_error=0)
		  //verifica items
		For ($l_indiceXCR;1;Size of array:C274(arXCR_idACT))
			If ($r_error=0)
				READ ONLY:C145([xxACT_Items:179])
				KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->arXCR_idACT{$l_indiceXCR})
				If (Records in selection:C76([xxACT_Items:179])#1)
					$r_error:=-6
					$l_indiceXCR:=Size of array:C274(arXCR_idACT)
				Else 
					APPEND TO ARRAY:C911($alACT_idRS;[xxACT_Items:179]ID_RazonSocial:36)
				End if 
			End if 
			  //verifica alumnos
			If ($r_error=0)
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Alumnos:2])
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atXCR_uuidAL{$l_indiceXCR})
				If (Records in selection:C76([Alumnos:2])=1)
					APPEND TO ARRAY:C911($alACT_idApdoCuenta;[Alumnos:2]Apoderado_Cuentas_Número:28)
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
					If (Records in selection:C76([ACT_CuentasCorrientes:175])#1)
						$r_error:=-8
						$l_indiceXCR:=Size of array:C274(arXCR_idACT)
					End if 
				Else 
					$r_error:=-7
					$l_indiceXCR:=Size of array:C274(arXCR_idACT)
				End if 
			End if 
			
		End for 
		
		If ($r_error=0)
			  //si emite boleta, verifica que los cargos esten asociados a razones sociales que emiten DTE
			If ($l_emiteBoleta=1)
				AT_DistinctsArrayValues (->$alACT_idRS)
				For ($l_indiceRS;1;Size of array:C274($alACT_idRS))
					$b_esEmisorColegium:=ACTdte_EsEmisorColegium ($alACT_idRS{$l_indiceRS})
					If (Not:C34($b_esEmisorColegium))
						$l_indiceRS:=Size of array:C274($alACT_idRS)
					End if 
				End for 
				If (Not:C34($b_esEmisorColegium))
					$r_error:=-24
				End if 
			End if 
		End if 
		
		If ($r_error=0)
			AT_DistinctsArrayValues (->$alACT_idApdoCuenta)
			If (Size of array:C274($alACT_idApdoCuenta)=1)
				$l_idApdo:=$alACT_idApdoCuenta{1}
				
				READ ONLY:C145([Personas:7])
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
				If (Records in selection:C76([Personas:7])#1)
					$r_error:=-9
				End if 
				
			Else 
				$r_error:=-25
			End if 
		End if 
		
	End if 
	
	  //si pasa las validaciones, se procesa la petición
	If ($r_error=0)
		START TRANSACTION:C239
		ARRAY LONGINT:C221($alACT_recNumsCargos;0)
		ARRAY LONGINT:C221($alACT_idsAC;0)
		ARRAY LONGINT:C221($alACT_idsAlumnos;0)
		C_TEXT:C284($t_idsAvisos)
		
		  //crear cargo
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([xxACT_Items:179])
		READ ONLY:C145([ACT_Cargos:173])
		
		  //Crea cargos
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
		vdACT_FechaPago:=$d_fechaP
		vdACT_FechaE:=$d_fechaP
		C_REAL:C285(RNApdo)
		C_LONGINT:C283(RNTercero)
		C_REAL:C285(vrACT_MontoAdeudado)
		C_LONGINT:C283($l_recNumCargo)
		vrACT_MontoAdeudado:=0
		
		ptrACTpgs_Table:=->[Personas:7]
		ptrACTpgs_FieldID:=->[Personas:7]No:1
		ptrACTpgs_VarRecNum:=->RNApdo
		ptrACTpgs_FieldDT:=->[Personas:7]ACT_DocumentoTributario:45
		ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
		ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
		ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
		
		C_BOOLEAN:C305($b_mismoAviso;$b_enBoleta)
		$l_idCargo:=0
		For ($i;1;Size of array:C274(atXCR_uuidAL))
			$t_uuidAl:=atXCR_uuidAL{$i}
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->$t_uuidAl)
			APPEND TO ARRAY:C911($alACT_idsAlumnos;[Alumnos:2]numero:1)
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
			If ((Records in selection:C76([ACT_CuentasCorrientes:175])=1) & (Records in selection:C76([Personas:7])=1))
				  //$l_idApdo:=[Personas]No
				If ($i=1)
					$b_mismoAviso:=False:C215
				Else 
					$b_mismoAviso:=True:C214
				End if 
				$b_enBoleta:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->arXCR_idACT{$i};->[xxACT_Items:179]No_incluir_en_DocTributario:31)
				
				$l_recNumCargo:=ACTac_CreateCargoDocCargoImp (True:C214;arXCR_idACT{$i};Num:C11(arXCR_montos{$i});Current date:C33(*);$b_mismoAviso;[ACT_CuentasCorrientes:175]ID:1;[Personas:7]No:1;$b_enBoleta;False:C215;0;False:C215;$l_idCargo;True:C214)
				If ($l_recNumCargo>=0)
					APPEND TO ARRAY:C911($alACT_recNumsCargos;$l_recNumCargo)
					KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumsCargos{Size of array:C274($alACT_recNumsCargos)};True:C214)
					If (ok=1)
						[ACT_Cargos:173]Venta_Directa:59:=False:C215
						If ($l_agregaGlosa=1)
							[ACT_Cargos:173]Glosa:12:=[ACT_Cargos:173]Glosa:12+" "+atXCR_nombre{$i}
						End if 
						$l_idCargo:=[ACT_Cargos:173]ID:1
						SAVE RECORD:C53([ACT_Cargos:173])
					Else 
						$r_error:=-13
						$i:=Size of array:C274(atXCR_uuidAL)
					End if 
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
				Else 
					$r_error:=-23
					$i:=Size of array:C274(atXCR_uuidAL)
				End if 
			Else 
				$r_error:=-13
				$i:=Size of array:C274(atXCR_uuidAL)
			End if 
		End for 
		
		If ($r_error=0)
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$alACT_recNumsCargos;"")
			
			If (Records in selection:C76([ACT_Cargos:173])>0)
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
				SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAC)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#1)
					$r_error:=-14
				Else 
					$t_idsAvisos:=AT_array2text (->$alACT_idsAC;",";"############")
				End if 
			Else 
				$r_error:=-13
			End if 
		End if 
		
		If ($r_error=0)
			If ($t_idsAvisos="")
				$r_error:=-14
			End if 
		End if 
		
		  //crea pago
		If ($r_error=0)
			
			
			$t_obs:="Pago ingresado por "+$t_app+__ (", el ")+String:C10(Current date:C33(*);5)+"."
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
			$json:=ACTwa_IngresaPago ($r_montoTotal;$t_idsAvisos;$d_fechaP;"";False:C215;"";$t_detalleVenta;0;String:C10($r_ordenCompra);"";$t_obs)
			
			
			
			
			C_TEXT:C284($root;$nodeErr;$nodeErrCod)
			C_REAL:C285($r_procesado)
			C_REAL:C285($r_ordenCompraACT)
			C_LONGINT:C283($l_idPago)
			ARRAY TEXT:C222($atACT_jsonNodos;0)
			ARRAY LONGINT:C221($alACT_tipos;0)
			ARRAY TEXT:C222($atACT_nombres;0)
			ARRAY TEXT:C222($atACT_jsonNodos2;0)
			ARRAY LONGINT:C221($alACT_tipos2;0)
			ARRAY TEXT:C222($atACT_nombres2;0)
			ARRAY LONGINT:C221($alACT_ordenCompra;0)
			ARRAY LONGINT:C221($alACT_idPago;0)
			
			If (Valida_json ($json))
				C_OBJECT:C1216($ob;$ob_error)
				ARRAY OBJECT:C1221($ao_Pagos;0)
				C_TEXT:C284($t_idPago)
				C_REAL:C285($r_procesado;$r_ordenCompraACT)
				
				$ob:=JSON Parse:C1218($json;Is object:K8:27)
				OB_GET ($ob;->$ob_error;"estado")
				OB_GET ($ob_error;->$r_procesado;"codigo")
				
				
				If ($r_procesado=0)
					OB_GET ($ob;->$ao_Pagos;"pagos")
					For ($i;1;Size of array:C274($ao_Pagos))
						OB_GET ($ao_Pagos{$i};->$r_ordenCompraACT;"ordencompra")
						If ($r_ordenCompraACT#0)
							APPEND TO ARRAY:C911($alACT_ordenCompra;$r_ordenCompraACT)
							OB_GET ($ao_Pagos{$i};->$t_idPago;"idpago")
							APPEND TO ARRAY:C911($alACT_idPago;Num:C11($t_idPago))
						End if 
					End for 
				Else 
					$r_error:=-15
				End if 
			Else 
				$r_error:=-16
			End if 
			
			If ($r_error=0)
				$l_existe:=Find in array:C230($alACT_ordenCompra;$r_ordenCompra)
				If ($l_existe=-1)
					$r_error:=-19
				Else 
					APPEND TO ARRAY:C911($alACT_idsPagos;$alACT_idPago{$l_existe})
				End if 
			End if 
		End if 
		
		If ($r_error=0)
			If (Size of array:C274($alACT_idsPagos)=1)
				If (KRL_GetNumericFieldData (->[ACT_Pagos:172]ID:1;->$alACT_idsPagos{1};->[ACT_Pagos:172]Saldo:15)>0)
					$r_error:=-28
				End if 
			Else 
				$r_error:=-27
			End if 
		End if 
		
		If ($r_error=0)
			If ($l_emiteBoleta=1)
				If (Size of array:C274($alACT_idsPagos)#1)
					$r_error:=-26
				End if 
			End if 
		End if 
		
		If ($r_error=0)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
		
		If ($r_error=0)
			If ($l_emiteBoleta=1)
				  //emitir boleta
				  //si es emisor de boletas electronicas, se emitir
				If ($b_esEmisorColegium)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
					cbImprimirBoletas:=1
					cbImprimirRecPago:=0
					ACTpgs_EmitirBoletasDocumentar (->$alACT_idsPagos;->[Personas:7]No:1;0;"";False:C215)
				End if 
			End if 
		End if 
	End if 
End if 
  //$json:=XCRwa_RespuestaError ($r_error)

If ($r_error#0)  //20180813 RCH
	$json:=XCRwa_RespuestaError ($r_error)
Else 
	C_OBJECT:C1216($ob_raiz;$ob_datos;$ob_datosPago)
	OB SET:C1220($ob_datos;"codigo";0)
	OB SET:C1220($ob_datos;"descripcion";"ok.")
	OB SET:C1220($ob_raiz;"estado";$ob_datos)
	OB SET:C1220($ob_datosPago;"id_act";$alACT_idsPagos{1})
	OB SET:C1220($ob_datosPago;"oc";$r_ordenCompra)
	OB SET:C1220($ob_raiz;"estado";$ob_datos)
	OB SET:C1220($ob_raiz;"datosdepago";$ob_datosPago)
	$json:=JSON Stringify:C1217($ob_raiz)
End if 

CLEAR SEMAPHORE:C144("ACT_IngresoXCR")

$0:=$json
