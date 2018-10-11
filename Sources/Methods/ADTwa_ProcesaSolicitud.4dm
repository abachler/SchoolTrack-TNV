//%attributes = {}
  //ADTwa_ProcesaSolicitud

C_TEXT:C284($root)
C_REAL:C285($r_error)
C_TEXT:C284($t_json;$json)
C_TEXT:C284($0)
C_LONGINT:C283($l_idApdo)
C_TEXT:C284($t_app;$t_obs)
C_LONGINT:C283($l_indiceItem;$l_emiteBoleta;$l_ingresarPagoSII)
C_REAL:C285($r_ordenCompra)
C_REAL:C285($r_formaDePago)
ARRAY LONGINT:C221($alACT_idsPagos;0)
C_TEXT:C284($t_uuidTransaccion;$t_uuidPost)

C_LONGINT:C283(cbSolicitaMotivoCondonacion)

If (Count parameters:C259>=1)
	$t_json:=$1
Else 
	  //$t_json:=ADTwa_TestsJSON
End if 

If (Semaphore:C143("ADT_ProcesoEnCurso";300))
	$r_error:=-23
End if 

ARRAY LONGINT:C221($alACT_idRS;0)

If ($r_error=0)
	
	  //$root:=JSON Parse text ($t_json)
	
	  //If (($root#"0") & ($root#"false"))
	
	If (Valida_json ($t_json))
		
		
		  //SET TEXT TO PASTEBOARD(JSON Export to text ($root;JSON_WITH_WHITE_SPACE))
		$vl_idRazon:=-1
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->$vl_idRazon)
		
		C_REAL:C285($r_orden_compra)
		C_TEXT:C284($t_fechaP)
		C_DATE:C307($d_fechaP)
		C_REAL:C285($r_montoTotal)
		C_TEXT:C284($t_app)
		C_TEXT:C284($t_rutPaga;$t_nombresPaga;$t_apPaternoPaga;$t_apMaternoPaga;$t_direccion;$t_comuna;$t_ciudad)
		C_LONGINT:C283($l_agregaGlosa)
		C_TEXT:C284($t_jsonWP)
		
		ARRAY TEXT:C222($at_cargosGlosa;0)
		ARRAY REAL:C219($ar_cargosIds;0)
		ARRAY REAL:C219($ar_cargosMontos;0)
		ARRAY TEXT:C222($at_cargosNombres;0)
		ARRAY TEXT:C222($at_cargosApPaterno;0)
		ARRAY TEXT:C222($at_cargosApMaterno;0)
		ARRAY TEXT:C222($at_cargosApRut;0)
		ARRAY TEXT:C222($at_cargosPasaporte;0)
		C_TEXT:C284($t_llave)
		
		  // Modificado por: Alexis Bustamante (12-06-2017)
		  //TICKET 179869
		
		
		C_OBJECT:C1216($ob;$ob_pagador)
		ARRAY OBJECT:C1221($ao_pagos;0)
		
		$ob:=OB_Create 
		$ob_pagador:=OB_Create 
		$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
		
		
		OB_GET ($ob;->$t_llave;"llave")
		OB_GET ($ob;->$l_emiteBoleta;"emite_boleta")
		OB_GET ($ob;->$l_ingresarPagoSII;"asociar_sii_siempre")
		OB_GET ($ob;->$r_orden_compra;"orden_compra")
		OB_GET ($ob;->$t_fechaP;"fecha_pago")
		$d_fechaP:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fechaP;9;2));Num:C11(Substring:C12($t_fechaP;6;2));Num:C11(Substring:C12($t_fechaP;1;4)))
		OB_GET ($ob;->$r_montoTotal;"monto_total")
		OB_GET ($ob;->$t_app;"aplicacion")
		OB_GET ($ob;->$l_agregaGlosa;"agrega_datos_alumno")
		OB_GET ($ob;->$r_ordenCompra;"orden_compra")
		OB_GET ($ob;->$r_formaDePago;"id_forma_pago")
		OB_GET ($ob;->$t_jsonWP;"detalle_venta")
		OB_GET ($ob;->$t_uuidTransaccion;"id_transaccion")
		OB_GET ($ob;->$t_uuidPost;"id_postulacion")
		
		  //JSON_ExtraeValor ($root;"llave";->$t_llave)
		  //JSON_ExtraeValor ($root;"emite_boleta";->$l_emiteBoleta)
		  //JSON_ExtraeValor ($root;"asociar_sii_siempre";->$l_ingresarPagoSII)
		  //JSON_ExtraeValor ($root;"orden_compra";->$r_orden_compra)
		  //JSON_ExtraeValor ($root;"fecha_pago";->$t_fechaP)
		  //$d_fechaP:=DT_GetDateFromDayMonthYear (Num(Substring($t_fechaP;9;2));Num(Substring($t_fechaP;6;2));Num(Substring($t_fechaP;1;4)))
		  //JSON_ExtraeValor ($root;"monto_total";->$r_montoTotal)
		  //JSON_ExtraeValor ($root;"aplicacion";->$t_app)
		  //JSON_ExtraeValor ($root;"agrega_datos_alumno";->$l_agregaGlosa)
		  //JSON_ExtraeValor ($root;"orden_compra";->$r_ordenCompra)
		  //JSON_ExtraeValor ($root;"id_forma_pago";->$r_formaDePago)
		  //JSON_ExtraeValor ($root;"detalle_venta";->$t_jsonWP)
		  //JSON_ExtraeValor ($root;"id_transaccion";->$t_uuidTransaccion)
		  //JSON_ExtraeValor ($root;"id_postulacion";->$t_uuidPost)
		
		If ($r_formaDePago=0)
			$r_formaDePago:=-18
		End if 
		OB_GET ($ob;->$ob_pagador;"datos_pagador")
		
		  //$t_nodoPaga:=JSON Get child by name ($root;"datos_pagador";JSON_CASE_INSENSITIVE)
		  //XCRwa_CreaPago
		
		  //Pagador
		OB_GET ($ob_pagador;->$t_rutPaga;"rut_pagador")
		OB_GET ($ob_pagador;->$t_nombresPaga;"nombres_pagador")
		OB_GET ($ob_pagador;->$t_apPaternoPaga;"apepat_pagador")
		OB_GET ($ob_pagador;->$t_apMaternoPaga;"apemat_pagador")
		OB_GET ($ob_pagador;->$t_direccion;"direccion_pagador")
		OB_GET ($ob_pagador;->$t_comuna;"comuna")
		OB_GET ($ob_pagador;->$t_ciudad;"ciudad")
		
		  //  //Pagador
		  //JSON_ExtraeValor ($t_nodoPaga;"rut_pagador";->$t_rutPaga)
		  //JSON_ExtraeValor ($t_nodoPaga;"nombres_pagador";->$t_nombresPaga)
		  //JSON_ExtraeValor ($t_nodoPaga;"apepat_pagador";->$t_apPaternoPaga)
		  //JSON_ExtraeValor ($t_nodoPaga;"apemat_pagador";->$t_apMaternoPaga)
		  //JSON_ExtraeValor ($t_nodoPaga;"direccion_pagador";->$t_direccion)
		  //JSON_ExtraeValor ($t_nodoPaga;"comuna";->$t_comuna)
		  //JSON_ExtraeValor ($t_nodoPaga;"ciudad";->$t_ciudad)
		
		OB_GET ($ob;->$ao_pagos;"pagos")  // Modificado por: Saúl Ponce (13/10/2017) Ticket 189512, obtener el nodo de pagos
		  //OB_GET ($ob_pagador;->$ao_pagos;"pagos") 
		
		
		C_LONGINT:C283($nodo)
		
		C_TEXT:C284($t_nombre_cargo;$t_nombre_postulante;$t_apepat_postulante;$t_apemat_postulante;$t_rut_postulante;$t_pasaporte_postulante)
		C_REAL:C285($r_id_accountrack;$r_monto)
		For ($nodo;1;Size of array:C274($ao_pagos))
			OB_GET ($ao_pagos{$nodo};->$t_nombre_cargo;"nombre_cargo")
			OB_GET ($ao_pagos{$nodo};->$r_id_accountrack;"id_accountrack")
			OB_GET ($ao_pagos{$nodo};->$r_monto;"monto")
			OB_GET ($ao_pagos{$nodo};->$t_nombre_postulante;"nombre_postulante")
			OB_GET ($ao_pagos{$nodo};->$t_apepat_postulante;"apepat_postulante")
			OB_GET ($ao_pagos{$nodo};->$t_apemat_postulante;"apemat_postulante")
			OB_GET ($ao_pagos{$nodo};->$t_rut_postulante;"rut_postulante")
			OB_GET ($ao_pagos{$nodo};->$t_pasaporte_postulante;"pasaporte_postulante")
			APPEND TO ARRAY:C911($at_cargosGlosa;$t_nombre_cargo)
			APPEND TO ARRAY:C911($ar_cargosIds;$r_id_accountrack)
			APPEND TO ARRAY:C911($ar_cargosMontos;$r_monto)
			APPEND TO ARRAY:C911($at_cargosNombres;$t_nombre_postulante)
			APPEND TO ARRAY:C911($at_cargosApPaterno;$t_apepat_postulante)
			APPEND TO ARRAY:C911($at_cargosApMaterno;$t_apemat_postulante)
			APPEND TO ARRAY:C911($at_cargosApRut;$t_rut_postulante)
			APPEND TO ARRAY:C911($at_cargosPasaporte;$t_pasaporte_postulante)
		End for 
		
		  //$t_nodoPaga:=JSON Get child by name ($root;"pagos";JSON_CASE_INSENSITIVE)
		  //JSON GET CHILD NODES ($t_nodoPaga;at_nodes;al_tipos;at_nombres)
		  //For ($i;1;Size of array(at_nodes))
		  //JSON GET CHILD NODES (at_nodes{$i};at_nodes2;al_tipos2;at_nombres2)
		  //For ($j;1;Size of array(at_nodes2))
		  //Case of 
		  //: (at_nombres2{$j}="nombre_cargo")
		  //APPEND TO ARRAY($at_cargosGlosa;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="id_accountrack")
		  //APPEND TO ARRAY($ar_cargosIds;JSON Get real (at_nodes2{$j}))
		  //: (at_nombres2{$j}="monto")
		  //APPEND TO ARRAY($ar_cargosMontos;JSON Get real (at_nodes2{$j}))
		  //: (at_nombres2{$j}="nombre_postulante")
		  //APPEND TO ARRAY($at_cargosNombres;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="apepat_postulante")
		  //APPEND TO ARRAY($at_cargosApPaterno;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="apemat_postulante")
		  //APPEND TO ARRAY($at_cargosApMaterno;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="rut_postulante")
		  //APPEND TO ARRAY($at_cargosApRut;JSON Get text (at_nodes2{$j}))
		  //: (at_nombres2{$j}="pasaporte_postulante")
		  //APPEND TO ARRAY($at_cargosPasaporte;JSON Get text (at_nodes2{$j}))
		  //End case 
		  //End for 
		  //End for 
		
		  //JSON CLOSE ($root)
	Else 
		$r_error:=-24
	End if 
End if 

  //validaciones generales
If ($r_error=0)
	  //verifica que se hayan obtenido correctamente los arreglos de cargos
	If (Size of array:C274($at_cargosGlosa)=0)
		$r_error:=-25
	End if 
End if 

If ($r_error=0)
	  //verifica que llave conincida
	If (($t_uuidPost="") | ($t_uuidTransaccion=""))  //se usa misma llave de XCR
		$r_error:=-44
	End if 
End if 

If ($r_error=0)
	  //verifica que llave conincida
	If ($t_llave#XCRwa_GeneraLlave ($t_uuidPost;$t_uuidTransaccion))  //se usa misma llave de XCR
		$r_error:=-2
	End if 
End if 

If ($r_error=0)
	  //verifica que monto sea mayor a 0
	If (AT_GetSumArray (->$ar_cargosMontos)=0)
		$r_error:=-43
	End if 
End if 

If ($r_error=0)
	  //verifica que monto sea igual a monto de pago
	If ((AT_GetSumArray (->$ar_cargosMontos)#$r_montoTotal) & ($r_montoTotal#0))
		$r_error:=-26
	End if 
End if 
If ($r_error=0)
	  //verifica fecha de pago
	If (($d_fechaP<=Add to date:C393(Current date:C33(*);-1;0;0)) | ($d_fechaP>=Add to date:C393(Current date:C33(*);1;0;0)))
		$r_error:=-27
	End if 
End if 
If ($r_error=0)
	  //verifica que venga una orden de compra
	If (($r_montoTotal#0) & ($r_ordenCompra=0) & ($r_formaDePago=-18))
		$r_error:=-28
	End if 
End if 
If ($r_error=0)
	  //verifica que la orden de compra no exista en la base
	If (Find in field:C653([ACT_Pagos:172]ID_WebpayOC:32;$r_ordenCompra)#-1)
		$r_error:=-29
	End if 
End if 

If ($r_error=0)
	If ($t_rutPaga#"")
		$t_rutPaga:=CTRY_CL_VerifRUT ($t_rutPaga;False:C215)
		If ($t_rutPaga="")
			$r_error:=-16
		End if 
	End if 
End if 

If ($r_error=0)
	  //verifica items
	For ($l_indiceItem;1;Size of array:C274($ar_cargosIds))
		If ($r_error=0)
			READ ONLY:C145([xxACT_Items:179])
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$ar_cargosIds{$l_indiceItem})
			If (Records in selection:C76([xxACT_Items:179])#1)
				$r_error:=-30
				$l_indiceItem:=Size of array:C274($ar_cargosIds)
			Else 
				APPEND TO ARRAY:C911($alACT_idRS;[xxACT_Items:179]ID_RazonSocial:36)
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
				$r_error:=-31
			End if 
		End if 
	End if 
End if 

If ($r_error=0)
	  //Si responsable de pago existe como tercero, se usa. Si no se emite al SII. Se usa $l_ingresarPagoSII
	C_LONGINT:C283($l_idTercero)
	If ($l_ingresarPagoSII=1)
		
		READ ONLY:C145([ACT_Terceros:138])
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4="666666666")
		If (Records in selection:C76([ACT_Terceros:138])=0)
			$ok:=ACTter_CreateRecord ("666666666";"SII";True:C214;"Teatinos 120";"Santiago";"Santiago";"Servicio de Impuestos Internos")
			If ($ok=1)
				READ ONLY:C145([ACT_Terceros:138])
				QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4="666666666")
				If (Records in selection:C76([ACT_Terceros:138])=1)
					$l_idTercero:=[ACT_Terceros:138]Id:1
				Else 
					$r_error:=-34
				End if 
			Else 
				$r_error:=-35
			End if 
		Else 
			  //If (Records in selection([ACT_Terceros])=1)
			  //$l_idTercero:=[ACT_Terceros]Id
			  //End if 
			If (Records in selection:C76([ACT_Terceros:138])=1)
				If (<>gCountryCode="cl")  //Si es Chile es obligatorio tener el tercero llamado SII.
					If ([ACT_Terceros:138]Nombre_Completo:9="SII")  //20170818 RCH
						$l_idTercero:=[ACT_Terceros:138]Id:1
					Else 
						$r_error:=-51
					End if 
				Else 
					$l_idTercero:=[ACT_Terceros:138]Id:1
				End if 
			Else 
				$r_error:=-50
			End if 
			
		End if 
		
	Else 
		If ($t_rutPaga#"")
			$l_index:=Find in field:C653([ACT_Terceros:138]RUT:4;$t_rutPaga)
			If ($l_index=-1)
				  //crea tercero
				
				If (($t_direccion="") | ($t_comuna="") | ($t_ciudad=""))
					STR_ReadGlobals 
					If ($t_direccion="")
						$t_direccion:=<>GDIRECCION
					End if 
					If ($t_comuna="")
						$t_comuna:=<>GCOMUNA
					End if 
					If ($t_ciudad="")
						$t_ciudad:=<>GCIUDAD
					End if 
				End if 
				
				  //If (($t_nombresPaga#"") & ($t_apPaternoPaga#"") & ($t_apMaternoPaga#"") & ($t_direccion#"") & ($t_comuna#"") & ($t_ciudad#""))
				If (($t_nombresPaga#"") & ($t_apPaternoPaga#"") & ($t_direccion#"") & ($t_comuna#"") & ($t_ciudad#""))  //20180310 RCH se quita ap materno
					C_TEXT:C284(vtACT_NumTC)
					vtACT_NumTC:=""
					$ok:=ACTter_CreateRecord ($t_rutPaga;"";False:C215;$t_direccion;$t_comuna;$t_ciudad;"Persona natural";$t_apPaternoPaga;$t_apMaternoPaga;$t_nombresPaga)
					If ($ok=1)
						READ ONLY:C145([ACT_Terceros:138])
						QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4=$t_rutPaga)
						If (Records in selection:C76([ACT_Terceros:138])=1)
							$l_idTercero:=[ACT_Terceros:138]Id:1
						Else 
							$r_error:=-36
						End if 
					Else 
						$r_error:=-32
					End if 
				Else 
					  //Si viene algun dato como para crear el tercero, devuelvo error. Si no, asocio a SII
					If (($t_nombresPaga#"") | ($t_apPaternoPaga#"") | ($t_apMaternoPaga#"") | ($t_direccion#"") | ($t_comuna#"") | ($t_ciudad#""))
						$r_error:=-33
						  //Else 
						  //No se crea el tercero ya que vendría un RUT...
						  //
						  //READ ONLY([ACT_Terceros])
						  //QUERY([ACT_Terceros];[ACT_Terceros]RUT="666666666")
						  //If (Records in selection([ACT_Terceros])=0)
						  //$ok:=ACTter_CreateRecord ("666666666";"SII";True;"Teatinos 120";"Santiago";"Santiago";"Servicio de Impuestos Internos")
						  //If ($ok=1)
						  //READ ONLY([ACT_Terceros])
						  //QUERY([ACT_Terceros];[ACT_Terceros]RUT="666666666")
						  //If (Records in selection([ACT_Terceros])=1)
						  //$l_idTercero:=[ACT_Terceros]Id
						  //Else 
						  //$r_error:=-34
						  //End if 
						  //Else 
						  //$r_error:=-35
						  //End if 
						  //Else 
						  //If (Records in selection([ACT_Terceros])=1)
						  //$l_idTercero:=[ACT_Terceros]Id
						  //End if 
						  //End if 
					End if 
				End if 
			Else 
				GOTO RECORD:C242([ACT_Terceros:138];$l_index)  //20170818 RCH Se comentan las líneas siguientes porque no debería verificarse el nombre ya que no se usa el sii.
				$l_idTercero:=[ACT_Terceros:138]Id:1
				  //If ((Records in selection([ACT_Terceros])=1) & ([ACT_Terceros]Nombre_Completo="SII"))  //20160602 RCH
				  //$l_idTercero:=[ACT_Terceros]Id
				  //Else 
				  //$r_error:=-50
				  //End if 
			End if 
		Else 
			$r_error:=-49
		End if 
	End if 
End if 

If ($r_error=0)
	READ ONLY:C145([ACT_Terceros:138])
	QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$l_idTercero)
	If (Records in selection:C76([ACT_Terceros:138])=0)
		$r_error:=-37
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
	READ ONLY:C145([ACT_Terceros:138])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Cargos:173])
	
	  //Crea cargos
	  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_idApdo)
	KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero)
	
	vdACT_FechaPago:=$d_fechaP
	vdACT_FechaE:=$d_fechaP
	C_REAL:C285(RNApdo)
	C_LONGINT:C283(RNTercero)
	C_REAL:C285(vrACT_MontoAdeudado)
	C_LONGINT:C283($l_recNumCargo)
	vrACT_MontoAdeudado:=0
	
	  //ptrACTpgs_Table:=->[Personas]
	  //ptrACTpgs_FieldID:=->[Personas]No
	  //ptrACTpgs_VarRecNum:=->RNApdo
	  //ptrACTpgs_FieldDT:=->[Personas]ACT_DocumentoTributario
	
	ptrACTpgs_Table:=->[ACT_Terceros:138]
	ptrACTpgs_FieldID:=->[ACT_Terceros:138]Id:1
	ptrACTpgs_VarRecNum:=->RNTercero
	ptrACTpgs_FieldDT:=->[ACT_Terceros:138]id_CatDocTrib:55
	ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
	ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
	ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
	
	C_BOOLEAN:C305($b_mismoAviso;$b_enBoleta)
	$l_idCargo:=0
	
	C_TEXT:C284($t_USR_CurrentUser)  //para log...
	$t_USR_CurrentUser:=<>tUSR_CurrentUser
	<>tUSR_CurrentUser:=$t_app
	
	For ($i;1;Size of array:C274($ar_cargosIds))
		KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero)
		
		  //$l_idApdo:=[Personas]No
		If ($i=1)
			$b_mismoAviso:=False:C215
		Else 
			$b_mismoAviso:=True:C214
		End if 
		$b_enBoleta:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$ar_cargosIds{$i};->[xxACT_Items:179]No_incluir_en_DocTributario:31)
		
		$l_recNumCargo:=ACTac_CreateCargoDocCargoImp (True:C214;$ar_cargosIds{$i};Num:C11($ar_cargosMontos{$i});Current date:C33(*);$b_mismoAviso;0;0;$b_enBoleta;False:C215;[ACT_Terceros:138]Id:1;False:C215;$l_idCargo;True:C214)
		If ($l_recNumCargo>=0)
			APPEND TO ARRAY:C911($alACT_recNumsCargos;$l_recNumCargo)
			KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumsCargos{Size of array:C274($alACT_recNumsCargos)};True:C214)
			If (ok=1)
				[ACT_Cargos:173]Venta_Directa:59:=False:C215
				If ($l_agregaGlosa=1)
					[ACT_Cargos:173]Glosa:12:=[ACT_Cargos:173]Glosa:12+" "+$at_cargosApPaterno{$i}+" "+$at_cargosApMaterno{$i}+" "+$at_cargosNombres{$i}
				End if 
				$l_idCargo:=[ACT_Cargos:173]ID:1
				SAVE RECORD:C53([ACT_Cargos:173])
			Else 
				$r_error:=-11
				  //$i:=Size of array($t_rutPaga)
				$i:=Size of array:C274($ar_cargosIds)  //20160715 RCH
			End if 
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		Else 
			$r_error:=-11
			  //$i:=Size of array($t_rutPaga)
			$i:=Size of array:C274($ar_cargosIds)  //20160526 RCH
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
				$r_error:=-10
			Else 
				
				  //Escribo observacion para que sepa de que alumno es
				
				
				$t_idsAvisos:=AT_array2text (->$alACT_idsAC;",";"############")
			End if 
		Else 
			$r_error:=-11
		End if 
	End if 
	
	If ($r_error=0)
		If ($t_idsAvisos="")
			$r_error:=-10
		End if 
	End if 
	
	  //crea pago
	If ($r_error=0)
		$t_obs:="Pago ingresado por "+$t_app+__ (", el ")+String:C10(Current date:C33(*);5)+"."
		  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_idApdo)
		KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero)
		$json:=ACTwa_IngresaPago ($r_montoTotal;$t_idsAvisos;$d_fechaP;"";False:C215;"";$t_jsonWP;0;String:C10($r_ordenCompra);"";$t_obs)
		
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
		
		  //$root:=JSON Parse text ($json)
		  //SET TEXT TO PASTEBOARD(JSON Export to text ($root;JSON_WITH_WHITE_SPACE))
		  //If (($root#"0") & ($root#"false"))
		If (Valida_json ($json))
			C_OBJECT:C1216($ob1;$ob_estado)
			ARRAY OBJECT:C1221($ao_pagos1;0)
			
			$ob1:=OB_Create 
			$ob_estado:=OB_Create 
			$ob1:=JSON Parse:C1218($json;Is object:K8:27)
			OB_GET ($ob1;->$ob_estado;"estado")
			OB_GET ($ob_estado;->$r_procesado;"codigo")
			If ($r_procesado=0)
				  //$nodeErr:=JSON Get child by name ($root;"pagos")
				  //JSON GET CHILD NODES ($nodeErr;$atACT_jsonNodos2;$alACT_tipos2;$atACT_nombres2)
				OB_GET ($ob1;->$ao_pagos1;"pagos")
				For ($i;1;Size of array:C274($ao_pagos1))
					$r_ordenCompraACT:=0
					OB_GET ($ao_pagos1{$i};->$r_ordenCompraACT;"ordencompra")
					If ($r_ordenCompraACT#0)
						APPEND TO ARRAY:C911($alACT_ordenCompra;$r_ordenCompraACT)
						C_TEXT:C284($t_idPago)
						OB_GET ($ao_pagos1{$i};->$t_idPago;"idpago")
						APPEND TO ARRAY:C911($alACT_idPago;Num:C11($t_idPago))
					End if 
				End for 
				
				  //$nodeErr:=JSON Get child by name ($root;"estado")
				  //$nodeErrCod:=JSON Get child by name ($nodeErr;"codigo")
				  //$r_procesado:=JSON Get real ($nodeErrCod)
				  //If ($r_procesado=0)
				  //$nodeErr:=JSON Get child by name ($root;"pagos")
				  //JSON GET CHILD NODES ($nodeErr;$atACT_jsonNodos2;$alACT_tipos2;$atACT_nombres2)
				  //For ($i;1;Size of array($atACT_jsonNodos2))
				  //$r_ordenCompraACT:=0
				  //JSON_ExtraeValor ($atACT_jsonNodos2{$i};"ordencompra";->$r_ordenCompraACT)
				  //If ($r_ordenCompraACT#0)
				  //APPEND TO ARRAY($alACT_ordenCompra;$r_ordenCompraACT)
				  //C_TEXT($t_idPago)
				  //JSON_ExtraeValor ($atACT_jsonNodos2{$i};"idpago";->$t_idPago)
				  //APPEND TO ARRAY($alACT_idPago;Num($t_idPago))
				  //End if 
				  //End for 
			Else 
				
				Case of 
					: ($r_procesado=-6)
						$r_error:=-39
					: ($r_procesado=-5)
						$r_error:=-40
					: ($r_procesado=-4)
						$r_error:=-41
					: ($r_procesado=-2)
						$r_error:=-42
					Else 
						$r_error:=-38
				End case 
				
			End if 
		Else 
			$r_error:=-45
		End if 
		  //JSON CLOSE ($root)
		
		If ($r_error=0)
			$l_existe:=Find in array:C230($alACT_ordenCompra;$r_ordenCompra)
			If ($l_existe=-1)
				$r_error:=-19
			Else 
				APPEND TO ARRAY:C911($alACT_idsPagos;$alACT_idPago{$l_existe})
			End if 
		End if 
	End if 
	
	<>tUSR_CurrentUser:=$t_USR_CurrentUser
	
	
	  //20150826 RCH Se verifica que no quede el pago con saldo
	If ($r_error=0)
		If (Size of array:C274($alACT_idsPagos)=1)
			If (KRL_GetNumericFieldData (->[ACT_Pagos:172]ID:1;->$alACT_idsPagos{1};->[ACT_Pagos:172]Saldo:15)>0)
				$r_error:=-47
			End if 
		Else 
			$r_error:=-46
		End if 
	End if 
	
	If ($r_error=0)
		If ($l_emiteBoleta=1)
			If (Size of array:C274($alACT_idsPagos)#1)
				$r_error:=-48
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
			  //analizar para enviar a emitir a otro proceso y responder
			If (<>gCountryCode="cl")
				  //emitir boleta
				  //si es emisor de boletas electronicas, se emitir
				  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_idApdo)
				If (bACT_emisorAutorizadoCLG)
					KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero)
					cbImprimirBoletas:=1
					cbImprimirRecPago:=0
					
					$l_idApdo:=0
					$l_idTercero:=[ACT_Terceros:138]Id:1
					ACTpgs_EmitirBoletasDocumentar (->$alACT_idsPagos;->$l_idApdo;$l_idTercero;"";False:C215)
					
					QUERY SELECTION WITH ARRAY:C1050([ACT_Pagos:172]ID:1;$alACT_idsPagos)
					KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
					If (Records in selection:C76([ACT_Boletas:181])=1)
						
						$b_readOnly:=Read only state:C362([ACT_Boletas:181])
						$l_idBoleta:=[ACT_Boletas:181]ID:1
						
						  //20150812 RCH lee pref para ver si quiere la copia cedible
						ACTdte_OpcionesManeja ("LeeBlob")
						
						  //20151003 RCH Si no se ha emitido, se intenta emitir si es que tiene permisos
						If ([ACT_Boletas:181]Numero:11=0)  //si no se encuentra el documento
							If ([ACT_Boletas:181]documento_electronico:29)  //si el documento es electrónico
								If ([ACT_Boletas:181]DTE_estado_id:24 ?? 0)  //si es emisor CLG
									If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2))  //Si no ha sido enviado
										If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 1))
											[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1
											SAVE RECORD:C53([ACT_Boletas:181])
										End if 
										$vl_procesados:=ACTdte_EmiteDocumento ($l_idBoleta)
										If ($vl_procesados=0)  //error
											$r_error:=5
										End if 
										KRL_ResetPreviousRWMode (->[ACT_Boletas:181];$b_readOnly)
										KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta)
										
									End if 
								End if 
							End if 
						End if 
						If ($r_error=0)
							If (Records in selection:C76([ACT_Boletas:181])=1)  //si hay error la boleta puede eliminarse 
								If ([ACT_Boletas:181]Numero:11#0)
									$t_rutEmisor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]RUT:3)
									$t_tipoDocumento:="PDF"
									$b_cedible3:=(r_obtieneCopiaCedible=1)
									$d_fechaE:=[ACT_Boletas:181]FechaEmision:3
									$t_tipo:=[ACT_Boletas:181]codigo_SII:33+":"+[ACT_Boletas:181]TipoDocumento:7
									$r_folio:=[ACT_Boletas:181]Numero:11
									$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible3;->$d_fechaE;->$t_tipo;->$r_folio)
									
									  //20150710 RCH Si no se ha obtenido el PDF, se intenta obtener
									If (Test path name:C476($t_ruta)#Is a document:K24:1)
										ACTdte_ObtienePDFDT ([ACT_Boletas:181]ID:1)
										If (Test path name:C476($t_ruta)#Is a document:K24:1)
											$r_error:=3
										Else 
											  //documento generado
										End if 
									End if 
								Else 
									$r_error:=4
								End if 
							Else 
								$r_error:=2
							End if 
						End if 
						
					Else 
						$r_error:=1
					End if 
					
				End if 
			End if 
		End if 
	End if 
End if 

CLEAR SEMAPHORE:C144("ADT_ProcesoEnCurso")

  //$0:=$json
  //$0:=$r_error
  //$0:=ADTwa_RespuestaError ($r_error)
  //ALERT($json)

If ($r_idError#0)  //20180806 RCH
	$0:=ADTwa_RespuestaError ($r_error)
Else 
	C_OBJECT:C1216($ob_raiz;$ob_datos;$ob_datosPago)
	OB SET:C1220($ob_datos;"codigo";$r_error)
	OB SET:C1220($ob_datos;"descripcion";"ok.")
	OB SET:C1220($ob_datosPago;"id_act";$alACT_idsPagos{1})
	OB SET:C1220($ob_datosPago;"oc";$r_ordenCompra)
	OB SET:C1220($ob_raiz;"estado";$ob_datos)
	OB SET:C1220($ob_raiz;"datosdepago";$ob_datosPago)
	$0:=JSON Stringify:C1217($ob_raiz)
End if 
