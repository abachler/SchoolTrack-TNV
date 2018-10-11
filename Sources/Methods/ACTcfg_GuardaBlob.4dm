//%attributes = {}
  //ACTcfg_GuardaBlob

C_TEXT:C284($vt_accion;$1)
C_BLOB:C604(xBlob)
$vt_accion:=$1
SET BLOB SIZE:C606(xBlob;0)
C_OBJECT:C1216($ob_conf)

Case of 
	: ($vt_accion="ACTcfg_MonedasYTasas")
		BLOB_Variables2Blob (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
		PREF_SetBlob (0;"ACT_Monedas";xBlob)
		
	: ($vt_accion="ACTcfg_AlertasYOtros")
		BLOB_Variables2Blob (->xBlob;0;->cbAlertaEmisionAvisos;->vtACTcfg_MailTo;->vtACTcfg_MailCC;->vtACTcfg_MailBCC)
		PREF_SetBlob (0;"ACTcfg_Alertas";xBlob)
		
	: ($vt_accion="ACTcfg_MultasRecargos")
		BLOB_Variables2Blob (->xBlob;0;->cbMultaXProtesto;->vtACTcfg_SelectedItemName;->vlACTcfg_SelectedItemId;->b_MultaProtFija;->b_MultaProtPorc;->vr_PctMontoMulta;->cbMultaPermiteMod)
		PREF_SetBlob (0;"ACTcfg_Multas";xBlob)
		
	: ($vt_accion="ACTcfg_Condonaciones")
		BLOB_Variables2Blob (->xBlob;0;->cbSolicitaMotivoCondonacion;->cbCondonacionDescuento;->cbCondonacionCargo;->cbCondonacionAviso;->cb_condonaDesdeMenu)
		PREF_SetBlob (0;"ACTcfg_Condonaciones";xBlob)
		
	: ($vt_accion="ACTcfg_ReimpresionBoletas")
		BLOB_Variables2Blob (->xBlob;0;->cbMultaXReimprimir;->vtACTcfg_SelectedItemName;->vlACTcfg_SelectedItemId;->btn_MultaProtFija;->btn_MultaProtPorc;->vr_PctMontoMulta;->cbMultaPermiteMod)
		PREF_SetBlob (0;"ACTcfg_ReimprimirBoletas";xBlob)
		
	: ($vt_accion="ACTcfg_CalculoNoHijo_NoCargas")
		BLOB_Variables2Blob (->xBlob;0;->ai_nivelesConsideradoNoHijo;->ai_nivelesConsideradoNoCarga)
		PREF_SetBlob (0;"ACTcfg_CalculoNoHijo_NoCargas";xBlob)
		
	: ($vt_accion="ACTcfg_MultasXCaja")
		BLOB_Variables2Blob (->xBlob;0;->cbMultaXCaja;->vtACTcfg_SelectedItemNCaja;->vlACTcfg_SelectedItemIdCaja;->a_MultaCajaFija;->a_MultaCajaPorc;->vr_PctMontoMultaCaja;->cbMultaCajaPermiteMod)
		PREF_SetBlob (0;"ACTcfg_MultasXCaja";xBlob)
		
		BLOB_Variables2Blob (->xBlob;0;->cs_multiplicarMontoRXC;->cs_considerarAvisosDesde;->vdACT_FechaRXC;->cs_considerarPCTAvisosMorosoRXC;->vr_PctAvisosMorosos)
		PREF_SetBlob (0;"ACTcfg_MultasXCaja2";xBlob)
		
	: ($vt_accion="ACTcfg_MultasRecargosAut")
		ACTcfg_OpcionesRecargosAut ("CreaBlob";->xBlob)
		PREF_SetBlob (0;"ACTcfg_MultasAut";xBlob)
		
	: ($vt_accion="ACTcfg_TareasFinDia")
		ACTcfg_OpcionesTareasFinDia ("CreaBlob")
		PREF_SetBlob (0;$vt_accion;xBlob)
		
	: ($vt_accion="ACTcfg_CuerpoMail")
		ACTcfg_OpcionesTextoMail ("CreaBlob")
		PREF_SetBlob (0;$vt_accion;xBlob)
		
	: ($vt_accion="ACTcfg_DetallePagos")
		ACTcfg_OpcionesDetallePagos ("ArmaBlob";->xBlob)
		PREF_SetBlob (0;$vt_accion;xBlob)
		
	: ($vt_accion="ACT_CorrelativoPago")
		ACTcfg_OpcionesCorrelativoPago ("ArmaBlob";->xBlob)
		PREF_SetBlob (0;$vt_accion;xBlob)
		
	: ($vt_accion="ACT_DivisionCargosEnEmision")
		$ob_conf:=ACTcc_DividirEmision ("ArmaObjeto")
		PREF_SetObject (0;$vt_accion;$ob_conf)
		
	: ($vt_accion="ACT_OpcionesImpresion")
		$ob_conf:=ACTcfg_OpcionesGenRecibo ("ArmaObjeto")
		PREF_SetObject (0;$vt_accion;$ob_conf)
		
	: ($vt_accion="ACT_DescuentosPorTramo")
		$ob_conf:=ACTpgs_DescuentosXTramo ("ArmaObjetoAlGuardar")
		PREF_SetObject (0;$vt_accion;$ob_conf)
		
End case 
SET BLOB SIZE:C606(xBlob;0)
