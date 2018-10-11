//%attributes = {}
  //ACTpgs_ClearDlogVars


vrACT_MontoDesctoAfecto:=0
vrACT_MontoDesctoExento:=0
vrACT_MontoDescto:=0

vrACT_MontoAdeudado:=0
vrACT_MontoAdeudadoAfecto:=0
vrACT_MontoAdeudadoExento:=0
vrACT_MontoPago:=0
vrACT_MontoAPagarAfecto:=0
vrACT_MontoAPagarExento:=0
vrACT_MontoAPagar:=0
vrACT_SaldoDisp:=0
vrACT_SeleccionadoAfecto:=0
vrACT_SeleccionadoExento:=0
vrACT_SeleccionadoAPagar:=0

vtACT_BancoNombre:=""
vtACT_BancoCodigo:=""
vtACT_BancoCuenta:=""
vtACT_BancoTitular:=""
vtACT_BancoRUTTitular:=""
vtACT_NoSerie:=""
vtACT_FechaDocumento:=""
vsACT_NomApellido:=""
vsACT_RUTApoderado:=""
vsACT_NomApellidoCta:=""
vsACT_RUTCta:=""
vsACT_RUTTercero:=""
vsACT_NomApellidoTer:=""

vtACT_ObservacionesPago:=""
  //vsACT_CtaContablePago:=""
  //vsACT_CentroContablePago:=""
  //vsACT_CCtaContablePago:=""
  //vsACT_CCentroContablePago:=""
  //vsACT_CodAuxCtaPago:=""
  //vsACT_CodAuxCCtaPago:=""
ACTcfg_OpcionesFormasDePago ("InitVarsCtas")

vsACT_LugardePago:=""

vt_MsgApdo:=""
vt_MsgCta:=""

vbACT_ModOrderAvisos:=False:C215
modcargos:=False:C215
chequesGenerados:=False:C215

  //UNLOAD RECORD([Personas])
  //READ ONLY([Personas])

  //***** INICIO 20131105 RCH Ses limpian variables para evitar errores. ticket 126537
KRL_UnloadReadOnly (->[Personas:7])
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[ACT_Terceros:138])

  //20130127 RCH No las limpio por el error en el CHMD. Ticket 129266
  //vbACT_PagoXApdo:=False
  //vbACT_PagoXCuenta:=False
  //vbACTpgs_PagoXTercero:=False

ACTpgs_ArreglosAvisos ("DeclaraArreglos")
ACTpgs_ArreglosItems ("DeclaraArreglos")
ACTpgs_ArreglosCuentas ("DeclaraArreglos")
ACTpgs_ArreglosAgrupado ("DeclaraArreglos")
  //***** FIN 20131105 RCH Ses limpian variables para evitar errores. ticket 126537

AT_Initialize (->aCtasApdo)

IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
IT_SetEnterable (False:C215;0;->vrACT_MontoAPagarApdo;->vlACT_Cuotas)
IT_SetButtonState (False:C215;->bIngresarPago;->bImprimirLista)
IT_SetEnterable (False:C215;0;->vtACT_BancoNombre;->vtACT_BancoCuenta;->vtACT_BancoTitular;->vtACT_BancoRUTTitular;->vtACT_NoSerie;->vdACT_FechaDocumento;->vrACT_MontoPrimero)
PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
OBJECT SET VISIBLE:C603(cb_OcupaSaldos;False:C215)
Case of 
	: ($ProcName="Ingreso de Pagos")
		vtACT_TCTipo:=""
		vtACT_TCNumero:=""
		vtACT_TCCodigo:=""
		vtACT_TCTitular:=""
		vtACT_TCRUTTitular:=""
		vtACT_TCMesVencimiento:=""
		vtACT_TCAgnoVencimiento:=""
		vtACT_TCBancoEmisor:=""
		vtACT_TCDocumento:=""
		vtACT_RDocumento:=""
		vtACT_LFechaEmision:=""
		vtACT_LFechaVencimiento:=""
		vtACT_LTitular:=""
		vtACT_LRUTTitular:=""
		vtACT_LDocumento:=""
		vrACT_MontoPago:=0
		AL_UpdateArrays (ALP_AvisosXPagar;0)
	: ($ProcName="Documentar Deudas")
		vrACT_MontoPrimero:=0
		vlACT_Cuotas:=10
		vrACT_MontoAPagarApdo:=0
		
		vlACT_FormasdePago:=0
		vsACT_FormasdePago:=""
		vrACT_MontoPago:=0
		vdACT_LFechaEmision:=!00-00-00!
		vdACT_LFechaVencimiento:=!00-00-00!
		vtACT_LTitular:=""
		vtACT_LRUTTitular:=""
		vtACT_LDocumento:=""
		vrACT_LImpuesto:=0
		vtACT_LIndiceLetras:=""
		vtACT_ObservacionesPago:=""
		
		AL_UpdateArrays (xALP_Documentar;0)
End case 
vlACT_LCFolio:=0
vdACT_LCFechaEDocumento:=!00-00-00!
vdACT_LCFechaVDocumento:=!00-00-00!
vrACT_LCMontoPrimero:=0
vl_indexLC:=-1

ACTcfgmyt_OpcionesGenerales ("InicializaVars")

C_LONGINT:C283(vlACT_idACIntereses)
vlACT_idACIntereses:=0

ACTpgs_OpcionesCargosEliminados ("InitVars")

ACTfdp_OpcionesRecargos ("InicializaVars")  //20120725 ASM Para inicializar variables de los recargos para las formas de pago
