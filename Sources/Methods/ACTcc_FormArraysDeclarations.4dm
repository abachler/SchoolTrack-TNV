//%attributes = {}
  //ACTcc_FormArraysDeclarations

C_TEXT:C284($vt_accion)
If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 

ARRAY LONGINT:C221(aIDCta;0)

Case of 
	: ($vt_accion="ArreglosAvisos")
		ARRAY LONGINT:C221(aACT_CtasDCNoComprobante;0)
		ARRAY DATE:C224(aACT_CtasDCFechaEmision;0)
		ARRAY REAL:C219(aACT_CtasDCTotal;0)
		ARRAY REAL:C219(aACT_CtasDCNeto;0)
		ARRAY TEXT:C222(aACT_CtasDCMoneda;0)
		ARRAY REAL:C219(aACT_CtasDCPagos;0)
		ARRAY REAL:C219(aACT_CtasDCSaldo;0)
		ARRAY LONGINT:C221(aACT_CtasDCID;0)
		ARRAY REAL:C219(aACT_CtasDCIntereses;0)
		
	: ($vt_accion="ArreglosPagos")
		  //Arreglos para input Ctas xALP_Pagos
		ARRAY DATE:C224(aACT_CtasPFecha;0)
		ARRAY TEXT:C222(aACT_CtasPGlosa;0)
		ARRAY REAL:C219(aACT_CtasPMonto;0)
		ARRAY REAL:C219(aACT_CtasPSaldo;0)
		ARRAY LONGINT:C221(aACT_CtasPIDPagos;0)
		ARRAY BOOLEAN:C223(aACT_CtasPNulo;0)
		
	: ($vt_accion="ArreglosDetallePagos")
		  //Arreglos para input Ctas xALP_DesglosePago
		ARRAY DATE:C224(aACT_CtasDPFecha;0)
		ARRAY TEXT:C222(aACT_CtasDPPeriodo;0)
		ARRAY REAL:C219(aACT_CtasDPMonto;0)
		ARRAY REAL:C219(aACT_CtasDPSaldoCargo;0)
		ARRAY REAL:C219(aACT_CtasDPPagadoCargo;0)
		ARRAY LONGINT:C221(aACT_CtasDPIDItem;0)
		ARRAY TEXT:C222(aACT_CtasDPGlosaCargo;0)
		
	: ($vt_accion="ArreglosTerceros")
		  //Arreglos para terceros asociados ala cuenta
		ARRAY TEXT:C222(atACT_TerceroNombre;0)
		ARRAY TEXT:C222(atACT_TerceroTipo;0)
		ARRAY TEXT:C222(atACT_TerceroRUT;0)
		ARRAY LONGINT:C221(alACT_TerceroRecNum;0)
		
	: ($vt_accion="CargosAvisos")
		ACTpp_FormArraysDeclarations ("DetallePagos")
		
	Else 
		
		  //Arreglos para el input Ctas xALP_Documentos
		ACTcc_FormArraysDeclarations ("ArreglosAvisos")
		
		
		  //Arreglos para input Ctas ALP_CargosXPagar
		ACTcc_FormArraysDeclarations ("CargosAvisos")
		
		
		  //Arreglos para input Ctas xALP_Transacciones
		
		ARRAY DATE:C224(aACT_CtasTFecha;0)
		ARRAY TEXT:C222(aACT_CtasTPeriodo;0)
		ARRAY TEXT:C222(aACT_CtasTGlosa;0)
		ARRAY REAL:C219(aACT_CtasTDebito;0)
		ARRAY REAL:C219(aACT_CtasTCredito;0)
		ARRAY TEXT:C222(aACT_CtasTMoneda;0)
		ARRAY TEXT:C222(aACT_CtasTBoleta;0)
		ARRAY LONGINT:C221(aACT_CtasTRefItem;0)
		ARRAY PICTURE:C279(apACT_CtasTAfecta;0)
		ARRAY LONGINT:C221(aACT_ItemIDs;0)
		_O_ARRAY STRING:C218(6;aACT_TipoTransaccion;0)
		ARRAY LONGINT:C221(aTransWidths;0)
		
		  //Arreglos para input Ctas xALP_Pagos
		ACTcc_FormArraysDeclarations ("ArreglosPagos")
		
		  //Arreglos para input Ctas xALP_DesglosePago
		ACTcc_FormArraysDeclarations ("ArreglosDetallePagos")
		
		  //Arreglos para input ctas xALP_Observaciones
		ARRAY DATE:C224(adACT_FechaObs;0)
		ARRAY TEXT:C222(atACT_Observacion;0)
		ARRAY LONGINT:C221(alACT_IDObs;0)
		
		ACTcc_FormArraysDeclarations ("ArreglosTerceros")
End case 