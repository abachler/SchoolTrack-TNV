//%attributes = {}
  //ACTdteRec_LlenaArreglosRutas

C_LONGINT:C283($l_indice)
C_DATE:C307($d_fechaEmision)
C_TEXT:C284($t_ruta;$t_rutReceptor;$t_rutEmisor;$t_tipo)
C_REAL:C285($r_folio)

$t_rutReceptor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)
For ($l_indice;1;Size of array:C274(alACT_IdDteRec))
	
	$d_fechaEmision:=adACT_FechaEmision{$l_indice}
	$t_rutEmisor:=atACT_EmisorRUT{$l_indice}
	$t_tipo:=atACT_Tipo{$l_indice}
	$r_folio:=Num:C11(atACT_Folio{$l_indice})
	
	$t_ruta:=ACTdteRec_Generales ("ObtieneRUTADocumentos";->$d_fechaEmision;->$t_rutReceptor;->$t_rutEmisor;->$t_tipo;->$r_folio)
	
	If (SYS_TestPathName ($t_ruta)=Is a document:K24:1)
		atACT_PDF{$l_indice}:=__ ("Ver")
	Else 
		atACT_PDF{$l_indice}:=""
	End if 
	atACT_PDF_ruta{$l_indice}:=$t_ruta
End for 