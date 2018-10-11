Case of 
	: (Form event:C388=On Close Box:K2:21)
		If (vl_indexLC>0)
			ACTcfg_LoadConfigData (8)
			alACT_Proxima{vl_indexLC}:=vlACT_LCFolio  //para cuando se saque la transaccion
			ACTcfg_SaveConfig (8)
		End if 
		  //CANCEL TRANSACTION
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_Documentar)
		  //20130103 RCH
		  //CFG_SetMenuBar 
		ACT_SetMenuBar 
		
		If (Not:C34(<>bAccountTrackIsRunning))
			  //CANCEL TRANSACTION
			CANCEL:C270
		End if 
	: (Form event:C388=On Activate:K2:9)
		XS_SetInterface 
		ALP_SetInterface (xALP_Documentar)
		  //20130103 RCH
		  //CFG_SetMenuBar 
		ACT_SetMenuBar 
		PREF_Set (<>lUSR_CurrentUserID;"lastModule";"3")
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		  //20130103 RCH
		  //CFG_SetMenuBar 
		ACT_SetMenuBar 
		ACTinit_LoadPrefs 
		vb_AuthorizedDesctos:=USR_GetMethodAcces ("ACTpgs_CreaCargoDesctoEspecial";0)
		ACTusr_AllowChange ("onLoad";->vdACT_FechaPago)
		ACTpgs_LoadIdentificadoresNac 
		OBJECT SET VISIBLE:C603(cb_OcupaSaldos;False:C215)
		ACTpgs_InitArraysDocumentar ("DeclaraArrays")
		ACTpgs_DeclareArraysInterfaz 
		vdACT_FechaPago:=Current date:C33(*)
		C_BOOLEAN:C305(vb_interesBorrado)
		C_BOOLEAN:C305(vb_descuentoBorrado)  //20170714 RCH
		_O_DISABLE BUTTON:C193(bIngresarPago)
		
		ACTpgs_ArreglosAvisos ("DeclaraArreglos")
		
		ARRAY REAL:C219(arACT_LCFolio;0)
		ARRAY TEXT:C222(atACT_LCRut;0)
		ARRAY TEXT:C222(atACT_LCAceptante;0)
		ARRAY DATE:C224(adACT_LCEmision;0)
		ARRAY DATE:C224(adACT_LCVencimiento;0)
		ARRAY REAL:C219(arACT_LCMonto;0)
		ARRAY REAL:C219(arACT_LCImpuesto;0)
		ARRAY BOOLEAN:C223(abACT_LCModificados;0)
		
		C_LONGINT:C283(vlACT_LCFolio)
		C_DATE:C307(vdACT_LCFechaEDocumento;vdACT_LCFechaVDocumento)
		C_TEXT:C284(vtACT_LCFechaEDocumento;vtACT_LCFechaVDocumento)
		C_REAL:C285(vrACT_LCMontoPrimero)
		C_LONGINT:C283(vl_indexLC)
		C_BOOLEAN:C305(cambioLC)
		C_BOOLEAN:C305(vb_documentando)
		
		vrACT_MontoDesctoAfecto:=0
		vrACT_MontoDesctoExento:=0
		vrACT_MontoDescto:=0
		
		vrACT_MontoAdeudado:=0
		vrACT_MontoAdeudadoAfecto:=0
		vrACT_MontoAdeudadoExento:=0
		vrACT_MontoPago:=vrACT_MontoAdeudado
		vrACT_MontoAPagarAfecto:=0
		vrACT_MontoAPagarExento:=0
		vrACT_MontoAPagar:=0
		vrACT_MontoAPagarApdo:=0
		
		vrACT_MontoPrimero:=0
		ACTpgs_ClearDlogVars 
		AL_UpdateArrays (xALP_Documentar;0)
		btn_apdo:=1
		btn_tercero:=0
		
		ACTpgs_DeclareArraysCargos 
		ARRAY LONGINT:C221(alACT_RecNumsCargosTemp;0)
		
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
				ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
				ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
				ACTpgs_DocumentarInit 
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
				ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
				ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
				ACTpgs_DocumentarInit 
				
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
				ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
				ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
				ACTpgs_DocumentarInit 
				
			Else 
				IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
		End case 
		
		ACTpgs_DeclaraArreglosCargosT 
		FORM GOTO PAGE:C247(1)
		ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar")
		AL_UpdateArrays (xALP_Documentar;-2)
		
		GOTO OBJECT:C206(vrACT_MontoAPagarApdo)
		vtACT_NoSerie:=""
		vb_Pagando:=False:C215
		$Fecha:=String:C10(Current date:C33(*);7)
		$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($Fecha;1;2));Num:C11(Substring:C12($Fecha;4;2));Num:C11(Substring:C12($Fecha;7)))
		vtACT_FechaDocumento:=$Fecha
		vdACT_FechaDocumento:=Current date:C33(*)
		vlACT_Cuotas:=10
		vlACT_OldCuotas:=vlACT_Cuotas
		
		$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
		OBJECT SET FILTER:C235(vrACT_MontoAPagar;$filter)
		OBJECT SET FILTER:C235(vrACT_MontoDesctoAfecto;$filter)
		OBJECT SET FILTER:C235(vrACT_MontoDesctoExento;$filter)
		OBJECT SET FILTER:C235(vrACT_MontoPrimero;$filter)
		vtACT_LCFechaEDocumento:=$Fecha
		vtACT_LCFechaVDocumento:=$Fecha
		vdACT_FechaPagoIni:=vdACT_FechaPago
		vbACT_ModOrderAvisos:=False:C215
		modCargos:=False:C215
		vb_documentando:=False:C215  //para que mensajes aparezcan solo una vez al ingresar varios pagos
		
		xALSet_ACT_Documentar 
		xALSet_ACT_DocumentarLetra 
		rCheques:=1
		IT_SetButtonState (False:C215;->bImprimir;->bIngresarPago;->bImprimirLista)
		
		cbImprimirBoletas:=Num:C11((cb_GenerarBoletaCaja=1))
		OBJECT SET VISIBLE:C603(*;"Boletas@";(cb_GenerarBoletaCaja=1))
		IT_SetButtonState ((cb_GenerarBoletaCaja=1);->fUnaBoletaporDocumento;->fUnaBoleta)
		fUnaBoleta:=Num:C11((cb_GenerarBoletaCaja=1))
		fUnaBoletaporDocumento:=0
		vsACT_LugardePago:=""
		ACTcfg_OpcionesFormasDePago ("InitVarsCtas")
		OBJECT SET VISIBLE:C603(*;"cta@";(cb_PermitePorCta=1))
		
		ACTpgs_CargaModelosRecibos ("Documentar")
		IT_SetButtonState ((Size of array:C274(alACT_RecNumsAvisos)>0);->bIngresarPago)
		ACTcfg_OpcionesRecargosCaja ("CargaDatosMulta")
		ACTcfg_OpcionesRecargosCaja ("ValidacionesFormDocumentar")
		ACTfdp_OpcionesRecargos ("CargaMontoRecargoDocumentar")
		ACTcfg_OpcionesCondonacion ("LeeBlob")
		ACTcfg_ItemsMatricula ("InicializaYLee")
		ACTpgs_LimpiaVarsInterfaz ("SeteaObjetos")
		
		ACTdesc_OpcionesGenerales ("CalculaDesdeIngresoPago")  //20170506 RCH
End case 