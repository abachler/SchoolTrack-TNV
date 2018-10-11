//%attributes = {}
  //ACTcfg_DeclaraArreglos

C_TEXT:C284($t_accion;$1)

$t_accion:=$1

Case of 
	: ($t_accion="ACTcfgitems_CentroCostoXNivel")
		ARRAY BOOLEAN:C223(abACT_CCXN_UsarConfItem;0)
		ARRAY TEXT:C222(atACT_CCXN_Nivel;0)
		ARRAY TEXT:C222(atACT_CCXN_CentroCosto;0)
		ARRAY TEXT:C222(atACT_CCXN_CentroCostoContra;0)
		ARRAY LONGINT:C221(alACT_CCXN_NivelID;0)
		
		  // Modificado por: Saúl Ponce (30-11-2016)
		  // Permiten utilizar Codigos Auxiliares o Codigos de planes de cuenta por nivel.
		ARRAY TEXT:C222(atACT_CCXN_CodAux;0)
		ARRAY TEXT:C222(atACT_CCXN_CodAuxCC;0)
		ARRAY TEXT:C222(atACT_CCXN_CodPlanCtas;0)
		ARRAY TEXT:C222(atACT_CCXN_CodPlanCCtas;0)
		
	: ($t_accion="ACTdteRecibidos_Listado")
		  //listado
		ARRAY LONGINT:C221(alACT_IdDteRec;0)
		ARRAY TEXT:C222(atACT_Tipo;0)
		ARRAY TEXT:C222(atACT_Emisor;0)
		ARRAY TEXT:C222(atACT_EmisorRUT;0)
		ARRAY TEXT:C222(atACT_Folio;0)
		ARRAY DATE:C224(adACT_FechaEmision;0)
		ARRAY REAL:C219(arACT_MontoTotal;0)
		ARRAY DATE:C224(adACT_recepcionFecha;0)
		ARRAY TEXT:C222(atACT_PDF;0)
		ARRAY TEXT:C222(atACT_PDF_ruta;0)
		
		  //temporales para filtro
		ARRAY LONGINT:C221(alACT_IdDteRecTemp;0)
		ARRAY TEXT:C222(atACT_TipoTemp;0)
		ARRAY TEXT:C222(atACT_EmisorTemp;0)
		ARRAY TEXT:C222(atACT_EmisorRUTTemp;0)
		ARRAY TEXT:C222(atACT_FolioTemp;0)
		ARRAY DATE:C224(adACT_FechaEmisionTemp;0)
		ARRAY REAL:C219(arACT_MontoTotalTemp;0)
		ARRAY DATE:C224(adACT_recepcionFechaTemp;0)
		ARRAY TEXT:C222(atACT_PDFTemp;0)
		ARRAY TEXT:C222(atACT_PDF_rutaTemp;0)
		
	: ($t_accion="ACTdteRecibidos_Busqueda")
		ARRAY TEXT:C222(atACTdteRec_RazonSocial;0)
		ARRAY TEXT:C222(atACTdteRec_RutEmisor;0)
		ARRAY TEXT:C222(atACTdteRec_Periodo;0)
		ARRAY TEXT:C222(atACTdteRec_Recepcion;0)
		
	: ($t_accion="ACTdteEmitidos_Listado")
		  //listado
		ARRAY LONGINT:C221(alACT_IdDteEmi;0)
		ARRAY TEXT:C222(atACT_TipoEmi;0)
		ARRAY LONGINT:C221(alACT_FolioEmi;0)
		ARRAY DATE:C224(adACT_FechaEmisionEmi;0)
		ARRAY REAL:C219(arACT_MontoTotalEmi;0)
		ARRAY TEXT:C222(atACT_PDFEmi;0)
		ARRAY TEXT:C222(atACT_PDF_rutaEmi;0)
		ARRAY TEXT:C222(atACT_XMLEmi;0)
		ARRAY TEXT:C222(atACT_XML_rutaEmi;0)
		ARRAY TEXT:C222(atACT_PDFCCEmi;0)
		ARRAY TEXT:C222(atACT_PDFCC_rutaEmi;0)
		
		  //temporales para filtro
		ARRAY LONGINT:C221(alACT_IdDteEmiTemp;0)
		ARRAY TEXT:C222(atACT_TipoEmiTemp;0)
		ARRAY LONGINT:C221(alACT_FolioEmiTemp;0)
		ARRAY DATE:C224(adACT_FechaEmisionEmiTemp;0)
		ARRAY REAL:C219(arACT_MontoTotalEmiTemp;0)
		ARRAY TEXT:C222(atACT_PDFEmiTemp;0)
		ARRAY TEXT:C222(atACT_PDF_rutaEmiTemp;0)
		
		ARRAY TEXT:C222(atACT_XMLEmiTemp;0)
		ARRAY TEXT:C222(atACT_XML_rutaEmiTemp;0)
		ARRAY TEXT:C222(atACT_PDFCCEmiTemp;0)
		ARRAY TEXT:C222(atACT_PDFCC_rutaEmiTemp;0)
		
		
	: ($t_accion="ACTdteEmitidos_Busqueda")
		ARRAY TEXT:C222(atACTdteEmi_Periodo;0)
		
End case 