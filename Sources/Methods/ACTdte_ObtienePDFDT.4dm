//%attributes = {}
  //ACTdte_ObtienePDFDT
C_LONGINT:C283($l_idBoleta;$1)
C_TEXT:C284($0;$t_retorno)
C_TEXT:C284($0)

$l_idBoleta:=$1

KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta)

If (ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25))
	If (([ACT_Boletas:181]documento_electronico:29) & ([ACT_Boletas:181]Numero:11#0))
		C_LONGINT:C283($l_proc)
		C_REAL:C285($r_folio)
		C_TEXT:C284($t_tipoArchivo;$t_tipo;$t_rutaCompleta)
		C_BOOLEAN:C305($b_cedible)
		
		$l_proc:=IT_UThermometer (1;0;"Obteniendo PDF desde servidor...")
		
		$t_rutEmisor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]RUT:3)
		$t_tipoDocumento:="pdf"
		$b_cedible:=(r_obtieneCopiaCedible=1)
		$d_fechaE:=[ACT_Boletas:181]FechaEmision:3
		  //$t_tipo:=[ACT_Boletas]codigo_SII+":"+[ACT_Boletas]TipoDocumento
		$t_tipo:=[ACT_Boletas:181]codigo_SII:33+":"+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->[ACT_Boletas:181]codigo_SII:33)
		$r_folio:=[ACT_Boletas:181]Numero:11
		$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible;->$d_fechaE;->$t_tipo;->$r_folio)
		
		$t_tipoArchivo:=[ACT_Boletas:181]codigo_SII:33
		$t_rutaCompleta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible;->$d_fechaE;->$t_tipo;->$r_folio)
		$l_obtenido:=ACTdteEmi_ObtienePDF ($t_rutEmisor;$t_tipoArchivo;$r_folio;$b_cedible;$t_rutaCompleta;$t_tipoDocumento)
		If ($l_obtenido=1)
			$t_retorno:=$t_ruta
		End if 
		IT_UThermometer (-2;$l_proc)
	End if 
End if 

$0:=$t_retorno