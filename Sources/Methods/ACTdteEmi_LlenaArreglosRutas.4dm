//%attributes = {}
  //ACTdteEmi_LlenaArreglosRutas

C_LONGINT:C283($l_indice)
C_DATE:C307($d_fechaEmision)
C_TEXT:C284($t_ruta;$t_tipo;$t_rutEmisor;$t_tipoArchivo;$t_tipoDocumento)
C_REAL:C285($r_folio)
C_BOOLEAN:C305($b_cedible;$b_cedible2)

$t_rutEmisor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)
$b_cedible:=(bACT_PDFcedible=1)

For ($l_indice;1;Size of array:C274(alACT_IdDteEmi))
	
	$d_fechaEmision:=adACT_FechaEmisionEmi{$l_indice}
	$t_tipo:=atACT_TipoEmi{$l_indice}
	$r_folio:=Num:C11(alACT_FolioEmi{$l_indice})
	$t_tipoArchivo:=Substring:C12($t_tipo;1;Position:C15(":";$t_tipo)-1)
	If (($t_tipoArchivo="56") | ($t_tipoArchivo="61"))
		$b_cedible2:=$b_cedible
	Else 
		$b_cedible2:=False:C215
	End if 
	$b_cedible3:=False:C215  //para obtener ruta de PDF no cedible
	$t_tipoDocumento:="pdf"
	$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible3;->adACT_FechaEmisionEmi{$l_indice};->$t_tipo;->$r_folio)
	If (SYS_TestPathName ($t_ruta)=Is a document:K24:1)
		atACT_PDFEmi{$l_indice}:=__ ("Ver")
	Else 
		atACT_PDFEmi{$l_indice}:=""
	End if 
	atACT_PDF_rutaEmi{$l_indice}:=$t_ruta
	
	$t_tipoDocumento:="xml"
	$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible2;->adACT_FechaEmisionEmi{$l_indice};->$t_tipo;->$r_folio)
	If (SYS_TestPathName ($t_ruta)=Is a document:K24:1)
		atACT_XMLEmi{$l_indice}:=__ ("Ver")
	Else 
		atACT_XMLEmi{$l_indice}:=""
	End if 
	atACT_XML_rutaEmi{$l_indice}:=$t_ruta
	
	$t_tipoDocumento:="pdf"
	If (($t_tipoArchivo="56") | ($t_tipoArchivo="61"))
		$b_cedible2:=False:C215
		atACT_PDFCCEmi{$l_indice}:=""
		atACT_PDFCC_rutaEmi{$l_indice}:=""
	Else 
		$b_cedible2:=True:C214
		
		$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible2;->adACT_FechaEmisionEmi{$l_indice};->$t_tipo;->$r_folio)
		If (SYS_TestPathName ($t_ruta)=Is a document:K24:1)
			atACT_PDFCCEmi{$l_indice}:=__ ("Ver")
		Else 
			atACT_PDFCCEmi{$l_indice}:=""
		End if 
		atACT_PDFCC_rutaEmi{$l_indice}:=$t_ruta
	End if 
End for 