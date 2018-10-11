C_LONGINT:C283($l_col;$l_linea)
C_POINTER:C301($vy_pointer)
C_TEXT:C284($t_var)
C_LONGINT:C283($l_campo;$l_tabla)
C_TEXT:C284($t_ruta)

LISTBOX GET CELL POSITION:C971(lb_dtesEmitidos;$l_col;$l_linea;$vy_pointer)

If ($l_col>0)
	RESOLVE POINTER:C394($vy_pointer;$t_var;$l_tabla;$l_campo)
	Case of 
		: ($t_var="atACT_PDFEmi")
			If (atACT_PDFEmi{$l_linea}=__ ("Ver"))
				  //SHOW ON DISK(atACT_PDF_rutaEmi{$l_linea})
				$t_ruta:=atACT_PDF_rutaEmi{$l_linea}
			End if 
			
		: ($t_var="atACT_XMLEmi")
			If (atACT_XMLEmi{$l_linea}=__ ("Ver"))
				  //SHOW ON DISK(atACT_XML_rutaEmi{$l_linea})
				$t_ruta:=atACT_XML_rutaEmi{$l_linea}
			End if 
			
		: ($t_var="atACT_PDFCCEmi")
			If (atACT_PDFCCEmi{$l_linea}=__ ("Ver"))
				  //SHOW ON DISK(atACT_PDFCC_rutaEmi{$l_linea})
				$t_ruta:=atACT_PDFCC_rutaEmi{$l_linea}
			End if 
			
	End case 
	
	If ($t_ruta#"")
		SHOW ON DISK:C922($t_ruta)
		If (r_abrirDcto=1)
			OPEN URL:C673($t_ruta;*)
		End if 
	End if 
End if 
