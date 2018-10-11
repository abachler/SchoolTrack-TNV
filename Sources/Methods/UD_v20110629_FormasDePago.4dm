//%attributes = {}
  //UD_v20110629_FormasDePago

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($vl_proc)
	
	$vl_proc:=IT_UThermometer (1;0;"Actualizando formas de pago...")
	
	IT_UThermometer (0;$vl_proc;"Verificando formas de pago por defecto...")
	STR_ReadGlobals 
	ACTfdp_CargaFormasDePago 
	ACTcfgfdp_OpcionesGenerales ("VerificaFormasDePagoXDef")
	
	  // me aseguro de que se ejecute la actualización de la contabilidad
	UD_v20110628_CtasContables 
	ACTcfg_LoadConfigData (10)
	
	C_BLOB:C604(xBlob)
	SET BLOB SIZE:C606(xBlob;0)
	xBlob:=PREF_fGetBlob (0;"ACT_CodesFdPago";xBlob)
	ARRAY TEXT:C222(atACT_FormasdePago;0)
	ARRAY TEXT:C222(atACT_FdPCodes;0)
	ARRAY TEXT:C222(atACT_FdPCtaContable;0)
	ARRAY TEXT:C222(atACT_FdPCtaCodAux;0)
	ARRAY TEXT:C222(atACT_FdPCentroCostos;0)
	ARRAY TEXT:C222(atACT_FdPCCtaContable;0)
	ARRAY TEXT:C222(atACT_FdPCCtaCodAux;0)
	ARRAY TEXT:C222(atACT_FdPCCentroCostos;0)
	ARRAY TEXT:C222(atACT_FdPCodInterno;0)
	_O_C_STRING:C293(80;vtACT_CICAFecha)
	
	BLOB_Blob2Vars (->xBlob;0;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->vtACT_CPCAFecha;->vtACT_CCCAFecha;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->vtACT_CCPCAFecha;->vtACT_CCCCAFecha;->vtACT_CAUXCCAFecha;->vtACT_CAUXCCCAFecha;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno;->vtACT_CICAFecha)
	
	$maxsize:=AT_ReturnMaxSize (->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
	AT_RedimArrays ($maxsize;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
	
	  //se inserta cheque a fecha...
	AT_Insert (0;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
	atACT_FormasdePago{Size of array:C274(atACT_FormasdePago)}:="Cheque a fecha"
	atACT_FdPCodes{Size of array:C274(atACT_FormasdePago)}:="CHF"
	atACT_FdPCtaContable{Size of array:C274(atACT_FormasdePago)}:=vtACT_CPCAFecha
	atACT_FdPCentroCostos{Size of array:C274(atACT_FormasdePago)}:=vtACT_CCCAFecha
	atACT_FdPCCtaContable{Size of array:C274(atACT_FormasdePago)}:=vtACT_CCPCAFecha
	atACT_FdPCCentroCostos{Size of array:C274(atACT_FormasdePago)}:=vtACT_CCCCAFecha
	atACT_FdPCtaCodAux{Size of array:C274(atACT_FormasdePago)}:=vtACT_CAUXCCAFecha
	atACT_FdPCCtaCodAux{Size of array:C274(atACT_FormasdePago)}:=vtACT_CAUXCCCAFecha
	atACT_FdPCodInterno{Size of array:C274(atACT_FormasdePago)}:=vtACT_CICAFecha
	
	$vb_log:=False:C215
	
	For ($i;1;Size of array:C274(atACT_FormasdePago))
		IT_UThermometer (0;$vl_proc;"Verificando forma de pago "+atACT_FormasdePago{$i})
		READ WRITE:C146([ACT_Formas_de_Pago:287])
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]forma_de_pago_old:2=atACT_FormasdePago{$i})
		If (Records in selection:C76([ACT_Formas_de_Pago:287])=0)
			$vl_idFormaPago:=Num:C11(ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->atACT_FormasdePago{$i};->atACT_FdPCodes{$i};->atACT_FdPCodInterno{$i}))
			READ WRITE:C146([ACT_Formas_de_Pago:287])
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$vl_idFormaPago)
		End if 
		[ACT_Formas_de_Pago:287]codigo_ingreso:3:=atACT_FdPCodes{$i}
		[ACT_Formas_de_Pago:287]codigo_interno:8:=atACT_FdPCodInterno{$i}
		
		$vl_existe:=Find in array:C230(<>asACT_CuentaCta;atACT_FdPCtaContable{$i})
		If ($vl_existe>0)
			[ACT_Formas_de_Pago:287]id_cuenta_plan:4:=<>alACT_idCta{$vl_existe}
		Else 
			[ACT_Formas_de_Pago:287]id_cuenta_plan:4:=0
			If (atACT_FdPCtaContable{$i}#"")
				$vb_log:=True:C214
				LOG_RegisterEvt ("Revise la configuración de las formas de pago para la forma de pago: "+[ACT_Formas_de_Pago:287]forma_de_pago_old:2+" (Plan de cuenta).")
			End if 
		End if 
		$vl_existe:=Find in array:C230(<>asACT_Centro;atACT_FdPCentroCostos{$i})
		If ($vl_existe>0)
			[ACT_Formas_de_Pago:287]id_centro_plan:5:=<>alACT_idCentro{$vl_existe}
		Else 
			[ACT_Formas_de_Pago:287]id_centro_plan:5:=0
			If (atACT_FdPCentroCostos{$i}#"")
				$vb_log:=True:C214
				LOG_RegisterEvt ("Revise la configuración de las formas de pago para la forma de pago: "+[ACT_Formas_de_Pago:287]forma_de_pago_old:2+" (Centro de costo).")
			End if 
		End if 
		$vl_existe:=Find in array:C230(<>asACT_CuentaCta;atACT_FdPCCtaContable{$i})
		If ($vl_existe>0)
			[ACT_Formas_de_Pago:287]id_cuenta_contra:6:=<>alACT_idCta{$vl_existe}
		Else 
			[ACT_Formas_de_Pago:287]id_cuenta_contra:6:=0
			If (atACT_FdPCCtaContable{$i}#"")
				$vb_log:=True:C214
				LOG_RegisterEvt ("Revise la configuración de las formas de pago para la forma de pago: "+[ACT_Formas_de_Pago:287]forma_de_pago_old:2+" (Plan de cuenta contra).")
			End if 
		End if 
		$vl_existe:=Find in array:C230(<>asACT_Centro;atACT_FdPCCentroCostos{$i})
		If ($vl_existe>0)
			[ACT_Formas_de_Pago:287]id_centro_contra:7:=<>alACT_idCentro{$vl_existe}
		Else 
			[ACT_Formas_de_Pago:287]id_centro_contra:7:=0
			If (atACT_FdPCCentroCostos{$i}#"")
				$vb_log:=True:C214
				LOG_RegisterEvt ("Revise la configuración de las formas de pago para la forma de pago: "+[ACT_Formas_de_Pago:287]forma_de_pago_old:2+" (Centro de costo contra).")
			End if 
		End if 
		$vt_formaDePago:=[ACT_Formas_de_Pago:287]forma_de_pago_old:2
		$vl_id:=[ACT_Formas_de_Pago:287]id:1
		$vt_glosaNew:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
		ACTpgs_SaveFormasDePago 
		
		IT_UThermometer (0;$vl_proc;"Actualizando nuevos campos de pago para forma de pago "+atACT_FormasdePago{$i})
		READ WRITE:C146([ACT_Pagos:172])
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7=$vt_formaDePago)
		APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30:=$vl_id)
		APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]forma_de_pago_new:31:=$vt_glosaNew)
		KRL_UnloadReadOnly (->[ACT_Pagos:172])
		
		IT_UThermometer (0;$vl_proc;"Actualizando nuevos campos de documentos de pago para forma de pago "+atACT_FormasdePago{$i})
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Tipodocumento:5=$vt_formaDePago)
		APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=$vl_id)
		APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=$vt_glosaNew)
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		
		IT_UThermometer (0;$vl_proc;"Actualizando nuevos campos de documentos en cartera para forma de pago "+atACT_FormasdePago{$i})
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Tipo_Doc:4=$vt_formaDePago)
		APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=$vl_id)
		APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]forma_de_pago_new:20:=$vt_glosaNew)
		KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
		
		
		IT_UThermometer (0;$vl_proc;"Actualizando nuevos campos de archivos bancarios para forma de pago "+atACT_FormasdePago{$i})
		READ WRITE:C146([xxACT_ArchivosBancarios:118])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Tipo:6=$vt_formaDePago)
		APPLY TO SELECTION:C70([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=$vl_id)
		APPLY TO SELECTION:C70([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Tipo:6:=$vt_glosaNew)
		KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
		
		
		$vb_procesar:=False:C215
		Case of 
			: ($vl_id=-2)
				If (<>gCountryCode="mx")
					$vt_formaDePago:="Por caja"
				Else 
					$vt_formaDePago:="En el Colegio"
				End if 
				$vb_procesar:=True:C214
			: ($vl_id=-10)
				$vt_formaDePago:="Pago Automático de Cuenta"
				$vb_procesar:=True:C214
			: ($vl_id=-9)
				$vt_formaDePago:="Cargo a Tarjeta de Crédito"
				$vb_procesar:=True:C214
			: ($vl_id=-11)
				$vb_procesar:=True:C214
		End case 
		
		If ($vb_procesar)
			IT_UThermometer (0;$vl_proc;"Actualizando nuevos campos de personas para forma de pago "+atACT_FormasdePago{$i})
			READ WRITE:C146([Personas:7])
			QUERY:C277([Personas:7];[Personas:7]ACT_Modo_de_pago:39=$vt_formaDePago)
			APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_id_modo_de_pago:94:=$vl_id)
			APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_modo_de_pago_new:95:=$vt_glosaNew)
			KRL_UnloadReadOnly (->[Personas:7])
		End if 
		
		
	End for 
	
	  //20121005 RCH
	ACTcfgfdp_OpcionesGenerales ("ActualizaIDEnElColegio")
	
	
	IT_UThermometer (0;$vl_proc;"Actualizando modo de pago por defecto...")
	  // preferencia de modo de pago por defecto...
	C_LONGINT:C283(cbFPXDefecto)
	C_TEXT:C284(vt_FormadePagoXDef)
	C_LONGINT:C283(vl_FormadePagoXDef)
	C_BLOB:C604(xBlob)
	SET BLOB SIZE:C606(xBlob;0)
	cbFPXDefecto:=0
	vt_FormadePagoXDef:=<>atACT_FormasDePago2D{2}{1}
	BLOB_Variables2Blob (->xBlob;0;->cbFPXDefecto;->vt_FormadePagoXDef)
	xBlob:=PREF_fGetBlob (0;"FormaDePagoXDefecto";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->cbFPXDefecto;->vt_FormadePagoXDef)
	SET BLOB SIZE:C606(xBlob;0)
	
	READ WRITE:C146([ACT_Formas_de_Pago:287])
	$vl_index:=Find in field:C653([ACT_Formas_de_Pago:287]forma_de_pago_old:2;vt_FormadePagoXDef)
	If ($vl_index>=0)
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10=True:C214)
		APPLY TO SELECTION:C70([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10:=False:C215)
		GOTO RECORD:C242([ACT_Formas_de_Pago:287];$vl_index)
	Else 
		Case of 
			: (<>gCountryCode="mx")
				QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=-15)
			Else 
				QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=-2)
		End case 
	End if 
	[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10:=True:C214
	vl_FormadePagoXDef:=[ACT_Formas_de_Pago:287]id:1
	vt_FormadePagoXDef:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
	ACTpgs_SaveFormasDePago 
	ACTcfgfdp_OpcionesGenerales ("savecfg_FdPXDef")
	
	SET BLOB SIZE:C606(xBlob;0)
	IT_UThermometer (-2;$vl_proc)
	
	If ($vb_log)
		CD_Dlog (0;"Al finalizar la actualización verifique la configuración de las formas de pago, revisando el registro de actividades.")
	End if 
End if 