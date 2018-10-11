Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		C_DATE:C307(vdACT_FechaDocumento)
		C_TEXT:C284(vtNombre)
		C_BOOLEAN:C305(vb_imprimirLetra)
		C_BOOLEAN:C305(vbACT_PagoVD)
		C_TEXT:C284(vtACT_textoIdentificador)
		
		C_BOOLEAN:C305(vb_MontoModificado)
		vb_MontoModificado:=False:C215
		ACTfdp_OpcionesRecargos ("DeclaraVars")  // declaracion de variables.
		ACTcfgmyt_OpcionesGenerales ("InicializaVars")
		vtACTpgs_Moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		ACTinit_LoadFdPago 
		
		vrACT_MontoPago:=vrACT_MontoAPagar
		vrACT_MontoSeleccionado:=vrACT_MontoPago
		vrACTpgs_MontoAPagar:=vrACT_MontoAPagar
		vb_imprimirLetra:=False:C215
		vtACT_textoIdentificador:=<>vt_IDNacional1_name
		
		XS_SetInterface 
		WDW_SlideDrawer (->[ACT_Pagos:172];"FormadePago")
		$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
		OBJECT SET FILTER:C235(vrACT_MontoPago;$filter)
		ACTcfg_OpcionesRecargosCaja ("CargaDatosMulta")
		ACTcfg_OpcionesRecargosCaja ("ValidacionesFormIngPagos")
		OBJECT SET VISIBLE:C603(cbImprimirBoletas;(cb_GenerarBoletaCaja=1))
		cbImprimirBoletas:=Num:C11((cb_GenerarBoletaCaja=1))
		If (<>vtXS_CountryCode="pe")
			If (cb_GenerarBoletaCaja=1)
				ACTcfg_ArregloDocsTribs (->[Personas:7]ACT_DocumentoTributario:45)
				OBJECT SET VISIBLE:C603(*;"CatBol@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"CatBol@";False:C215)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"CatBol@";False:C215)
		End if 
		GOTO OBJECT:C206(vrACT_MontoPago)
		$el:=Find in array:C230(alACT_FormasdePagoID;-12)
		If ($el#-1)
			  //AT_Delete ($el;1;->atACT_FormasdePago)
			  //ACTcfg_OpcionesFormasDePago ("EliminaElementoArreglo")
			ACTcfg_OpcionesFormasDePago ("EliminaElementoArreglo";->$el)  //20130710 RCH
		End if 
		
		vtACT_PagoMsg:=__ ("Para el pago con ")+atACT_FormasdePagoNew{1}+__ (" no se requieren datos adicionales.")
		ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
		ACTcfg_OpcionesFormasDePago ("GOTOPAGE";->vlACT_FormasdePago)
		
		ACTpgs_CargaModelosRecibos 
		ACTpp_CRYPTTC ("seteaEstadoObjetosFormPagos";->viACT_campoModificable;->vtACT_TCNumero)
		
		  // Modificado por: Saúl Ponce (29-08-2018) Ticket Nº 215524, al ingresar valores en el dialogo, cerrarlo y volver a ingresar
		  // e intentar modificar el nro de tarjeta no lo permitía. Con esta línea quedaron iguales los comportamientos debito y credito
		ACTpp_CRYPTTC ("seteaEstadoObjetosFormPagos";->viACT_campoModificable;->vtACT_TDNumero)
		
		ACTcfgmyt_OpcionesGenerales ("OpcionesFormulario")
		ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
		
		  //20120709 ASM código agregado  por nueva funcionalidad "Recargo en formas de Pago"
		ACTfdp_OpcionesRecargos ("CargaVariables";->vlACT_FormasdePago)
		ACTfdp_OpcionesRecargos ("SumaMontos")
		If (crPermitirRecargoItem=1)
			vrACT_MontoRecargo:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->vlACT_FormasdePago;->vrACT_MontoAPagar)
			ACTfdp_OpcionesRecargos ("SumaMontos")
			OBJECT SET VISIBLE:C603(*;"multaCfg4";True:C214)
			OBJECT SET VISIBLE:C603(*;"multaCfg7";True:C214)
			OBJECT SET VISIBLE:C603(*;"multaCfg3";True:C214)
			OBJECT SET VISIBLE:C603(*;"multaCfg2";True:C214)
			If (crPermitirModificarMonto=1)
				OBJECT SET ENTERABLE:C238(*;"multaCfg2";True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(*;"multaCfg2";False:C215)
			End if 
		Else 
			  //OBJECT SET VISIBLE(*;"multaCfg7";False)
			  //OBJECT SET VISIBLE(*;"multaCfg4";False)
			OBJECT SET VISIBLE:C603(*;"multaCfg3";False:C215)
			OBJECT SET VISIBLE:C603(*;"multaCfg2";False:C215)
		End if 
		
End case 
