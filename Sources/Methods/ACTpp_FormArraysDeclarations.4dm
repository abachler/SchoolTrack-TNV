//%attributes = {}
  //ACTpp_FormArraysDeclarations

  //Para todos en Apdos y Ctas
C_TEXT:C284($vt_accion)
If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 

ARRAY LONGINT:C221(aIDCta;0)

Case of 
	: ($vt_accion="ArreglosAvisos")
		  //Arreglos para input Apdos xALP_Documentos
		ARRAY LONGINT:C221(aACT_ApdosDCNoComprobante;0)
		ARRAY DATE:C224(aACT_ApdosDCFechaEmision;0)
		ARRAY REAL:C219(aACT_ApdosDCTotal;0)
		ARRAY REAL:C219(aACT_ApdosDCNeto;0)
		ARRAY TEXT:C222(aACT_ApdosDCMoneda;0)
		ARRAY REAL:C219(aACT_ApdosDCPagos;0)
		ARRAY REAL:C219(aACT_ApdosDCSaldo;0)
		ARRAY LONGINT:C221(aACT_ApdosDCID;0)
		ARRAY REAL:C219(aACT_ApdosDCIntereses;0)
		ARRAY LONGINT:C221(alACT_ApdosDCPagares;0)
		
	: ($vt_accion="DetallePagos")
		  //Arreglos para input Apdos ALP_CargosXPagar
		ARRAY DATE:C224(adACT_CFechaEmision;0)
		ARRAY DATE:C224(adACT_CFechaVencimiento;0)
		ARRAY TEXT:C222(atACT_CAlumno;0)
		ARRAY TEXT:C222(atACT_CGlosa;0)
		ARRAY REAL:C219(arACT_CMontoNeto;0)
		ARRAY REAL:C219(arACT_CIntereses;0)
		ARRAY REAL:C219(arACT_CSaldo;0)
		ARRAY LONGINT:C221(alACT_RecNumsCargos;0)
		ARRAY LONGINT:C221(alACT_CRefs;0)
		ARRAY LONGINT:C221(alACT_IDCtaCte;0)
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
		ARRAY LONGINT:C221(aACT_IDsFormasPagos;0)  // ASM 20150908 Ticket 149621 
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
		
	: ($vt_accion="ArreglosBoletas")
		  //Arreglos para xALP_DocsTributarios
		ARRAY LONGINT:C221(alACT_ApdosDTNumero;0)
		ARRAY TEXT:C222(atACT_ApdosDTTipo;0)
		ARRAY TEXT:C222(atACT_ApdosDTEstado;0)
		ARRAY DATE:C224(adACT_ApdosDTFecha;0)
		ARRAY REAL:C219(arACT_ApdosDTMontoAfecto;0)
		ARRAY REAL:C219(arACT_ApdosDTMontoIVA;0)
		ARRAY REAL:C219(arACT_ApdosDTMontoTotal;0)
		ARRAY LONGINT:C221(alACT_ApdosDTID;0)
		ARRAY BOOLEAN:C223(abACT_ApdosDTNula;0)
		
	: ($vt_accion="ArreglosAlumnos")
		ARRAY TEXT:C222(atACT_CCCurso;0)
		ARRAY TEXT:C222(atACT_CCAlumno;0)
		ARRAY REAL:C219(arACT_CCFacturado;0)
		ARRAY REAL:C219(arACT_CCVencido;0)
		ARRAY REAL:C219(arACT_CCSaldo;0)
		ARRAY TEXT:C222(atACT_CCModoPago;0)
		
	: ($vt_accion="ArreglosDocDep")
		  //Arreglos para el input Apdos xALP_DocsDepositados
		ARRAY LONGINT:C221(aACT_ApdosDDID;0)
		ARRAY DATE:C224(aACT_ApdosDDFechaDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDDNumeroDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDDBancoDoc;0)
		ARRAY REAL:C219(aACT_ApdosDDMontoDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDDTipoDcto;0)
		
	: ($vt_accion="ArreglosTerceros")
		ARRAY LONGINT:C221(aACT_ApdosTercAsocRN;0)
		ARRAY TEXT:C222(aACT_ApdosTercAsocNombre;0)
		ARRAY TEXT:C222(aACT_ApdosTercAsocRUT;0)
		
	Else 
		  //Arreglos para input Apdos xALP_Documentos
		ACTpp_FormArraysDeclarations ("ArreglosAvisos")
		
		  //Arreglos para input Apdos ALP_CargosXPagar
		ACTpp_FormArraysDeclarations ("DetallePagos")
		
		  //Arreglos para input Apdos xALP_Transacciones
		
		ARRAY DATE:C224(aACT_ApdosTFecha;0)
		ARRAY TEXT:C222(aACT_ApdosTPeriodo;0)
		ARRAY TEXT:C222(aACT_ApdosTGlosa;0)
		ARRAY TEXT:C222(aACT_ApdosTAlumno;0)
		ARRAY TEXT:C222(aACT_ApdosTCurso;0)
		ARRAY REAL:C219(aACT_ApdosTDebito;0)
		ARRAY REAL:C219(aACT_ApdosTCredito;0)
		ARRAY TEXT:C222(aACT_ApdosTMoneda;0)
		ARRAY TEXT:C222(aACT_ApdosTBoleta;0)
		ARRAY LONGINT:C221(aACT_ApdosTRefItem;0)
		ARRAY PICTURE:C279(apACT_ApdosTAfecta;0)
		ARRAY LONGINT:C221(aACT_ItemIDs;0)
		_O_ARRAY STRING:C218(6;aACT_TipoTransaccion;0)
		ARRAY LONGINT:C221(aTransWidths;0)
		
		  //Arreglos para el input Apdos xALP_Pagos
		ACTpp_FormArraysDeclarations ("ArreglosPagos")
		
		  //Arreglos para el input Apdos xALP_DesglosePago
		ACTpp_FormArraysDeclarations ("ArreglosDetallePagos")
		
		  //Arreglos para el input Apdos xALP_DocsenCarteraCh
		ARRAY LONGINT:C221(aACT_ApdosDCarID;0)
		ARRAY LONGINT:C221(aACT_ApdosDCarIDDocPago;0)
		ARRAY DATE:C224(aACT_ApdosDCarFechaDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDCarNumeroDoc;0)
		ARRAY REAL:C219(aACT_ApdosDCarMontoDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDCarUbicacionDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDCarEstado;0)
		ARRAY DATE:C224(aACT_ApdosDCarFechaVenc;0)
		ARRAY DATE:C224(aACT_ApdosDCarProtestadoel;0)
		ARRAY DATE:C224(aACT_ApdosDCarDepDesde;0)
		ARRAY DATE:C224(aACT_ApdosDCarDepHasta;0)
		ARRAY TEXT:C222(aACT_ApdosDCarTipoDoc;0)
		ARRAY TEXT:C222(aACT_ApdosDCarBancoDoc;0)
		ARRAY LONGINT:C221(aACT_ApdosDCarRecNum;0)
		
		  //Arreglos para el input Apdos xALP_DocsDepositados
		ACTpp_FormArraysDeclarations ("ArreglosDocDep")
		
		  //Arreglos para input ctas xALP_Observaciones
		ARRAY DATE:C224(adACT_FechaObsApdo;0)
		ARRAY TEXT:C222(atACT_ObservacionApdo;0)
		ARRAY LONGINT:C221(alACT_IDObsApdo;0)
		
		  //Arreglos para xALP_FamsApdo
		ARRAY TEXT:C222(atACT_NombreFam;0)
		ARRAY TEXT:C222(atACT_CodigoFam;0)
		
		  //Arreglos para xALP_DocsTributarios
		ACTpp_FormArraysDeclarations ("ArreglosBoletas")
		
		ACTpp_FormArraysDeclarations ("ArreglosTerceros")
		
		  // Arreglos para Alumnos
		ACTpp_FormArraysDeclarations ("ArreglosAlumnos")
		
End case 