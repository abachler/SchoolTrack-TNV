_O_C_STRING:C293(80;vsACT_CtaContablePago;vsACT_CentroContablePago;vsACT_LugardePago;vsACT_CCtaContablePago;vsACT_CCentroContablePago)

Case of 
	: (Form event:C388=On Close Box:K2:21)
		  //CANCEL TRANSACTION
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (ALP_AvisosXPagar)
		  //20130103 RCH
		  //CFG_SetMenuBar 
		ACT_SetMenuBar 
		
		If (Not:C34(<>bAccountTrackIsRunning))
			  //CANCEL TRANSACTION
			CANCEL:C270
		End if 
	: (Form event:C388=On Activate:K2:9)
		XS_SetInterface 
		ALP_SetInterface (ALP_AvisosXPagar)
		  //20130103 RCH
		  //CFG_SetMenuBar 
		ACT_SetMenuBar 
		PREF_Set (<>lUSR_CurrentUserID;"lastModule";"3")
		If (Test semaphore:C652("ConfigACT"))
			CD_Dlog (0;__ ("No es posible ingresar pagos en este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intentelo de nuevo más tarde."))
			  //CANCEL TRANSACTION
			CANCEL:C270
		End if 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		  //20130103 RCH
		  //CFG_SetMenuBar 
		ACT_SetMenuBar 
		BRING TO FRONT:C326(Current process:C322)
		ACTinit_LoadPrefs 
		ACTusr_AllowChange ("onLoad";->vdACT_FechaPago)
		ACTpgs_LoadIdentificadoresNac 
		ACTpgs_DeclareArraysInterfaz 
		C_LONGINT:C283(hlACT_IngresoPagos)
		hlACT_IngresoPagos:=LOC_LoadList ("ACT_PaginasIngresoPago")
		vbACT_IngresandoPagos:=True:C214
		OBJECT SET FORMAT:C236(vsACT_RUTApoderado;"")
		OBJECT SET FORMAT:C236(vsACT_RUTCta;"")
		
		ARRAY TEXT:C222(aCtasApdo;0)
		
		C_BOOLEAN:C305(vb_imprimirLetra)
		vb_imprimirLetra:=False:C215
		$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
		OBJECT SET FILTER:C235(vrACT_MontoDesctoAfecto;$filter)
		OBJECT SET FILTER:C235(vrACT_MontoDesctoExento;$filter)
		<>testJHB:=True:C214
		vbACT_ModOrderAvisos:=False:C215
		modCargos:=False:C215
		
		vdACT_FechaPago:=Current date:C33(*)
		vdACT_FechaPagoIni:=vdACT_FechaPago
		vtACT_FechaDocumento:=""
		vtACT_LFechaEmision:=""
		vtACT_LFechaVencimiento:=""
		ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
		ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
		vsACT_LugardePago:=""
		
		ACTpgs_LoadInteresRecord 
		vtACT_LabelPlanillaInt:="Detalle de "+[xxACT_Items:179]Glosa:2
		UNLOAD RECORD:C212([xxACT_Items:179])
		
		btn_apdo:=1
		btn_tercero:=0
		xALSet_ACT_AvisosPagos 
		ACTpgs_ClearDlogVars 
		
		  //C_LONGINT($choice)
		  //$choice:=Find in array(atACT_FormasdePago;vsACT_FormasdePago)
		  //If ($choice>0)
		  //vsACT_CtaContablePago:=Substring(atACT_FdPCtaContable{$choice};1;80)
		  //vsACT_CentroContablePago:=Substring(atACT_FdPCentroCostos{$choice};1;80)
		  //vsACT_CCtaContablePago:=Substring(atACT_FdPCCtaContable{$choice};1;80)
		  //vsACT_CCentroContablePago:=Substring(atACT_FdPCCentroCostos{$choice};1;80)
		  //vsACT_CodAuxCtaPago:=Substring(atACT_FdPCtaCodAux{$choice};1;80)
		  //vsACT_CodAuxCCtaPago:=Substring(atACT_FdPCCtaCodAux{$choice};1;80)
		  //End if 
		
		vb_AuthorizedDesctos:=USR_GetMethodAcces ("ACTpgs_CreaCargoDesctoEspecial";0)
		OBJECT SET VISIBLE:C603(cb_OcupaSaldos;False:C215)
		
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		
		C_BOOLEAN:C305(vb_interesBorrado)
		C_BOOLEAN:C305(vb_descuentoBorrado)  //20170714 RCH
		ACTpgs_DeclareArraysCargos 
		Case of 
			: (RNApdo#-1)
				GOTO RECORD:C242([Personas:7];RNApdo)
				For ($i;1;Size of array:C274(aPtrsApdos))
					If (Not:C34(Is nil pointer:C315(aPtrsApdos{$i})))
						If (aPtrsApdos{$i}->#"")
							vsACT_RUTApoderado:=aPtrsApdos{$i}->
							vt_MsgApdo:="Encontrado en "+at_IDNacional_NamesApdos{$i}
							$i:=Size of array:C274(aPtrsApdos)+1
						End if 
					End if 
				End for 
				ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
			: (RNCta#-1)
				GOTO RECORD:C242([ACT_CuentasCorrientes:175];RNCta)
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
				For ($i;1;Size of array:C274(aPtrsCtas))
					If (Not:C34(Is nil pointer:C315(aPtrsCtas{$i})))
						If (aPtrsCtas{$i}->#"")
							vsACT_RUTCta:=aPtrsCtas{$i}->
							vt_MsgCta:="Encontrado en "+at_IDNacional_NamesCtas{$i}
							$i:=Size of array:C274(aPtrsCtas)+1
						End if 
					End if 
				End for 
				ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
			: (RNTercero#-1)
				READ ONLY:C145([ACT_Terceros:138])
				GOTO RECORD:C242([ACT_Terceros:138];RNTercero)
				For ($i;1;Size of array:C274(aPtrsTerceros))
					If (Not:C34(Is nil pointer:C315(aPtrsTerceros{$i})))
						If (aPtrsTerceros{$i}->#"")
							vsACT_RUTTercero:=aPtrsTerceros{$i}->
							vt_MsgApdo:="Encontrado en "+at_IDNacional_NamesApdos{$i}
							$i:=Size of array:C274(aPtrsTerceros)+1
						End if 
					End if 
				End for 
				ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
				
			Else 
				IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
		End case 
		ACTpgs_OpcionesVR ("SetPointers")
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
		AL_SetLine (ALP_AvisosXPagar;0)
		IT_SetButtonState (False:C215;->bSubirAviso;->bBajarAviso)
		
		  //20130130 RCH
		  //IT_SetButtonState (True;->bIngresarPago)
		OBJECT SET ENABLED:C1123(bIngresarPago;((RNApdo#-1) | (RNCta#-1) | (RNTercero#-1)))
		
		OBJECT SET VISIBLE:C603(*;"cta@";(cb_PermitePorCta=1))
		C_BOOLEAN:C305(vb_documentando)  //se utiliza al ingresar el pago
		vb_documentando:=False:C215
		
		  //20131220 ASM
		If ((Not:C34(vbACT_PagoXApdo)) & (Not:C34(vbACT_PagoXCuenta)) & (Not:C34(vbACTpgs_PagoXTercero)))  //20170315 ASM Ticket 176936
			vbACT_PagoXApdo:=Choose:C955(cbDatosApdo=1;True:C214;False:C215)
			vbACT_PagoXCuenta:=Choose:C955(cbDatosApdo=1;False:C215;True:C214)
		End if 
		
		xALSet_ACT_ItemsPagos 
		xALSet_ACT_AlumnosPagos 
		ACTpgs_ArreglosAgrupado ("SetAreaList")
		C_LONGINT:C283($page)
		ACTpgs_LimpiaVarsInterfaz ("SeteaObjetosYSelPage";->$page)
		$vb_bool:=False:C215
		ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
		ACTcfg_OpcionesCondonacion ("LeeBlob")
		ACTcfg_ItemsMatricula ("InicializaYLee")
		ACTpgs_LimpiaVarsInterfaz ("SeteaTodasFlechas")
		
		ACTdesc_OpcionesGenerales ("OnLoadVentanaPagos")  //20170507 RCH
End case 