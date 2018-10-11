C_LONGINT:C283($l_indice)
C_TEXT:C284($t_rutReceptor;$t_rutEmisor;$t_tipo;$t_carpeta;$t_rutaCompleta;$t_tipoGen)
C_REAL:C285($r_folio)
C_BOOLEAN:C305($b_cedible;$b_cedible2)
C_LONGINT:C283($l_proc)
C_LONGINT:C283($l_total;$l_contador)

$l_proc:=IT_UThermometer (1;0;"Obteniendo PDFs...")
$t_rutReceptor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)

$t_rutEmisor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)

$t_tipoGen:=Choose:C955((bACT_PDF=1);"pdf";"xml")
$b_cedible:=(bACT_PDFcedible=1)

ARRAY LONGINT:C221($alACT_resultado1;0)
ARRAY LONGINT:C221($alACT_resultado2;0)
ARRAY LONGINT:C221($alACT_resultado3;0)

Case of 
	: (($t_tipoGen="pdf") & ($b_cedible))
		atACT_PDFCCEmi{0}:=""
		AT_SearchArray (->atACT_PDFCCEmi;"=";->$alACT_resultado1)
	: ($t_tipoGen="pdf")
		atACT_PDFEmi{0}:=""
		AT_SearchArray (->atACT_PDFEmi;"=";->$alACT_resultado1)
	Else 
		atACT_XMLEmi{0}:=""
		AT_SearchArray (->atACT_XMLEmi;"=";->$alACT_resultado1)
End case 
lb_dtesEmitidos{0}:=True:C214
AT_SearchArray (->lb_dtesEmitidos;"=";->$alACT_resultado2)
AT_intersect (->$alACT_resultado1;->$alACT_resultado2;->$alACT_resultado3)
$l_total:=Size of array:C274($alACT_resultado3)

For ($l_indice;1;Size of array:C274($alACT_resultado3))
	  //If (lb_dtesEmitidos{$l_indice})
	$b_continuar:=False:C215
	Case of 
		: (($t_tipoGen="pdf") & ($b_cedible))
			If (atACT_PDFCCEmi{$alACT_resultado3{$l_indice}}="")
				$b_continuar:=True:C214
			End if 
		: ($t_tipoGen="pdf")
			If (atACT_PDFEmi{$alACT_resultado3{$l_indice}}="")
				$b_continuar:=True:C214
			End if 
		Else 
			If (atACT_XMLEmi{$alACT_resultado3{$l_indice}}="")
				$b_continuar:=True:C214
			End if 
	End case 
	
	If ($b_continuar)
		$l_contador:=$l_contador+1
		IT_UThermometer (0;$l_proc;"Recibiendo documento "+String:C10($l_contador)+" de "+String:C10($l_total)+"...")
		$r_folio:=Num:C11(alACT_FolioEmi{$alACT_resultado3{$l_indice}})
		$t_tipo:=atACT_TipoEmi{$alACT_resultado3{$l_indice}}
		$t_tipoArchivo:=Substring:C12($t_tipo;1;Position:C15(":";$t_tipo)-1)
		If (($t_tipoArchivo="56") | ($t_tipoArchivo="61"))
			$b_cedible2:=False:C215
		Else 
			$b_cedible2:=$b_cedible
		End if 
		
		$t_rutaCompleta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoGen;->$b_cedible2;->adACT_FechaEmisionEmi{$alACT_resultado3{$l_indice}};->$t_tipo;->$r_folio)
		  //ACTdteRec_ObtienePDF ($t_rutEmisor;$t_rutReceptor;$t_tipoArchivo;$r_folio;$t_ruta)
		  //ACTdteEmi_ObtienePDF ($t_rutEmisor;$t_tipoArchivo;$r_folio;$b_cedible;$t_rutaCompleta;$t_tipoGen)
		  //ACTdteEmi_ObtienePDF ($t_rutEmisor;$t_tipoArchivo;$r_folio;$b_cedible2;$t_rutaCompleta;$t_tipoGen)  //20140516 RCH
		$l_emitido:=ACTdteEmi_ObtienePDF ($t_rutEmisor;$t_tipoArchivo;$r_folio;$b_cedible2;$t_rutaCompleta;$t_tipoGen)  //20151114 RCH
		
		If ($l_emitido=0)
			$l_indice:=Size of array:C274($alACT_resultado3)
		End if 
		
	End if 
	  //End if 
End for 

ACTdteEmi_LlenaArreglosRutas 

IT_UThermometer (-2;$l_proc)

If (Size of array:C274($alACT_resultado2)>0)
	Case of 
		: ($b_cedible2)
			$t_rutaCompleta:=atACT_PDFCC_rutaEmi{$alACT_resultado2{Size of array:C274($alACT_resultado2)}}
		: ($t_tipoGen="pdf")
			$t_rutaCompleta:=atACT_PDF_rutaEmi{$alACT_resultado2{Size of array:C274($alACT_resultado2)}}
		: ($t_tipoGen="xml")
			$t_rutaCompleta:=atACT_XML_rutaEmi{$alACT_resultado2{Size of array:C274($alACT_resultado2)}}
	End case 
End if 

If (Test path name:C476($t_rutaCompleta)=Is a document:K24:1)
	SHOW ON DISK:C922($t_rutaCompleta)
	If (r_abrirDcto=1)
		OPEN URL:C673($t_rutaCompleta;*)
	End if 
End if 
