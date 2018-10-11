//%attributes = {}
  //ACTter_InitVariablesForm

C_TEXT:C284($vt_accion)
If (Count parameters:C259=1)
	$vt_accion:=$1
End if 
Case of 
	: ($vt_accion="")
		C_LONGINT:C283(vlACT_PaginaFormTerceros;hlTab_ACT_TercerosGen)
		C_DATE:C307(vdACTTer_FechaC;vdACTTer_FechaM;vd_TransDesde;vd_TransHasta)
		C_TEXT:C284(vtACTTer_IdentPAT;vtACTTer_IdentPAC;vtACT_NumTC)
		
		  //pag generales
		ARRAY TEXT:C222(aUFItmName;0)
		ARRAY TEXT:C222(aUFItmVal;0)
		
		ARRAY TEXT:C222(aYearsACT;0)
		
		vlACT_PaginaFormTerceros:=0
		vdACTTer_FechaC:=!00-00-00!
		vdACTTer_FechaM:=!00-00-00!
		ACTter_InitVariablesForm ("Cuentas")
		ACTter_InitVariablesForm ("Items")
		ACTter_InitVariablesForm ("CuentasXItems")
		ACTter_InitVariablesForm ("Transacciones")
		ACTter_InitVariablesForm ("Avisos")
		ACTter_InitVariablesForm ("ArreglosPagos")
		ACTter_InitVariablesForm ("ArreglosDetallePagos")
		  //Pages infos para pagos
		vtACTTer_IdentPAT:=""
		vtACTTer_IdentPAC:=""
		vtACT_NumTC:=""
		
	: ($vt_accion="Cuentas")
		C_LONGINT:C283(vl_cantidadCtas)
		ARRAY TEXT:C222(atACT_TerCurso;0)
		ARRAY TEXT:C222(atACT_TerAlumno;0)
		ARRAY LONGINT:C221(alACT_TerIdCtaCte;0)
		
	: ($vt_accion="Items")
		C_LONGINT:C283(vl_cantidadItems)
		ARRAY LONGINT:C221(alACT_TerIdItem;0)
		ARRAY TEXT:C222(atACT_TerGlosaItem;0)
		ARRAY REAL:C219(arACT_TerMontoItem;0)
		ARRAY TEXT:C222(atACT_TerMonedaItem;0)
		
	: ($vt_accion="CuentasXItems")
		ARRAY PICTURE:C279(apACT_ActivoCXI;0)
		ARRAY TEXT:C222(atACT_GlosaCXI;0)
		ARRAY TEXT:C222(atACT_CtaCursoCXI;0)
		ARRAY TEXT:C222(atACT_CtaCXI;0)
		ARRAY REAL:C219(arACT_MontoFijoCXI;0)
		ARRAY REAL:C219(arACT_MontoPctCXI;0)
		ARRAY LONGINT:C221(alACT_IdCXI;0)
		ARRAY BOOLEAN:C223(abACT_RelativoCXI;0)
		ARRAY BOOLEAN:C223(abACT_ActivoCXI;0)
		
	: ($vt_accion="Transacciones")
		_O_ARRAY STRING:C218(6;asACT_TipoTransaccion;0)
		ARRAY DATE:C224(adACT_TerTFecha;0)
		_O_ARRAY STRING:C218(20;asACT_TerTPeriodo;0)
		_O_ARRAY STRING:C218(80;asACT_TerTGlosa;0)
		ARRAY REAL:C219(arACT_TerTDebito;0)
		ARRAY REAL:C219(arACT_TerTCredito;0)
		ARRAY TEXT:C222(atACT_TerTMoneda;0)
		ARRAY PICTURE:C279(apACT_TerTAfecta;0)
		ARRAY LONGINT:C221(alACT_TerTBoleta;0)
		ARRAY LONGINT:C221(alACT_TerTRefItem;0)
		ARRAY LONGINT:C221(alACT_ItemIDs;0)
		
	: ($vt_accion="Avisos")
		ARRAY LONGINT:C221(aACT_ApdosDCNoComprobante;0)
		ARRAY DATE:C224(aACT_ApdosDCFechaEmision;0)
		ARRAY REAL:C219(aACT_ApdosDCTotal;0)
		ARRAY REAL:C219(aACT_ApdosDCNeto;0)
		ARRAY TEXT:C222(aACT_ApdosDCMoneda;0)
		ARRAY REAL:C219(aACT_ApdosDCPagos;0)
		ARRAY REAL:C219(aACT_ApdosDCSaldo;0)
		ARRAY LONGINT:C221(aACT_ApdosDCID;0)
		ARRAY REAL:C219(aACT_ApdosDCIntereses;0)
		
		ARRAY DATE:C224(adACT_CFechaEmision;0)
		ARRAY DATE:C224(adACT_CFechaVencimiento;0)
		ARRAY TEXT:C222(atACT_CAlumno;0)
		ARRAY TEXT:C222(atACT_CGlosa;0)
		ARRAY REAL:C219(arACT_CMontoNeto;0)
		ARRAY REAL:C219(arACT_CIntereses;0)
		ARRAY REAL:C219(arACT_CSaldo;0)
		ARRAY LONGINT:C221(alACT_RecNumsCargos;0)
		ARRAY LONGINT:C221(alACT_CRefs;0)
		ARRAY LONGINT:C221(alACT_CIDCtaCte;0)
		_O_ARRAY STRING:C218(2;asACT_Marcas;0)
		ARRAY REAL:C219(arACT_MontoMoneda;0)
		ARRAY TEXT:C222(atACT_MonedaCargo;0)
		ARRAY TEXT:C222(atACT_MonedaSimbolo;0)
		
	: ($vt_accion="ArreglosPagos")
		  //Arreglos para el input Apdos xALP_Pagos
		ARRAY DATE:C224(aACT_ApdosPFecha;0)
		ARRAY TEXT:C222(aACT_ApdosPGlosa;0)
		ARRAY REAL:C219(aACT_ApdosPMonto;0)
		ARRAY REAL:C219(aACT_ApdosPSaldo;0)
		ARRAY LONGINT:C221(aACT_ApdosPIDPagos;0)
		ARRAY BOOLEAN:C223(aACT_ApdosPNulo;0)
		
	: ($vt_accion="ArreglosDetallePagos")
		  //Arreglos para el input Apdos xALP_DesglosePago
		ARRAY DATE:C224(aACT_ApdosDPFecha;0)
		ARRAY TEXT:C222(aACT_ApdosDPPeriodo;0)
		ARRAY TEXT:C222(aACT_ApdosDPAlumno;0)
		ARRAY REAL:C219(aACT_ApdosDPMonto;0)
		ARRAY REAL:C219(aACT_ApdosDPSaldoCargo;0)
		ARRAY REAL:C219(aACT_ApdosDPPagadoCargo;0)
		ARRAY LONGINT:C221(aACT_ApdosDPIDItem;0)
		ARRAY TEXT:C222(aACT_ApdosDPGlosaCargo;0)
		
End case 







