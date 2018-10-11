C_LONGINT:C283($l_indice)
C_TEXT:C284($t_rutReceptor;$t_rutEmisor;$t_tipo;$t_carpeta;$t_ruta)
C_REAL:C285($r_folio)
C_BOOLEAN:C305($vb_cedible;$vb_cedible2)
C_LONGINT:C283($l_proc)
C_LONGINT:C283($l_total;$l_contador)

$l_proc:=IT_UThermometer (1;0;"Recibiendo documentos...")
$t_rutReceptor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)

ARRAY LONGINT:C221($alACT_resultado1;0)
ARRAY LONGINT:C221($alACT_resultado2;0)
ARRAY LONGINT:C221($alACT_resultado3;0)
atACT_PDF{0}:=""
AT_SearchArray (->atACT_PDF;"=";->$alACT_resultado1)
lb_dtesRecibidos{0}:=True:C214
AT_SearchArray (->lb_dtesRecibidos;"=";->$alACT_resultado2)
AT_intersect (->$alACT_resultado1;->$alACT_resultado2;->$alACT_resultado3)
$l_total:=Size of array:C274($alACT_resultado3)

For ($l_indice;1;Size of array:C274($alACT_resultado3))
	  //If (lb_dtesRecibidos{$l_indice})
	If (atACT_PDF{$alACT_resultado3{$l_indice}}="")
		$l_contador:=$l_contador+1
		IT_UThermometer (0;$l_proc;"Recibiendo documento "+String:C10($l_contador)+" de "+String:C10($l_total)+"...")
		
		$t_rutEmisor:=atACT_EmisorRUT{$alACT_resultado3{$l_indice}}
		$t_tipo:=atACT_Tipo{$alACT_resultado3{$l_indice}}
		$r_folio:=Num:C11(atACT_Folio{$alACT_resultado3{$l_indice}})
		$t_tipoArchivo:=Substring:C12($t_tipo;1;Position:C15(":";$t_tipo)-1)
		$t_ruta:=ACTdteRec_Generales ("ObtieneRUTADocumentos";->adACT_FechaEmision{$alACT_resultado3{$l_indice}};->$t_rutReceptor;->$t_rutEmisor;->$t_tipo;->$r_folio)
		ACTdteRec_ObtienePDF ($t_rutEmisor;$t_rutReceptor;$t_tipoArchivo;$r_folio;$t_ruta)
	End if 
	  //End if 
End for 

ACTdteRec_LlenaArreglosRutas 

IT_UThermometer (-2;$l_proc)

If (Size of array:C274($alACT_resultado2)>0)
	If (atACT_PDF_ruta{$alACT_resultado2{1}}#"")
		SHOW ON DISK:C922(atACT_PDF_ruta{$alACT_resultado2{1}})
	End if 
End if 