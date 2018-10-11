
C_TEXT:C284($t_itemText)
C_REAL:C285($r_itemRef)
GET LIST ITEM:C378(hlACT_FiltroDte;*;$r_itemRef;$t_itemText)

If ($r_itemRef>0)
	
	AT_Initialize (->alACT_IdDteEmi;->atACT_TipoEmi;->alACT_FolioEmi;->adACT_FechaEmisionEmi;->arACT_MontoTotalEmi;->atACT_PDFEmi;->atACT_PDF_rutaEmi;->atACT_XMLEmi;->atACT_XML_rutaEmi)
	
	ARRAY LONGINT:C221($al_result;0)
	C_LONGINT:C283($l_indiceFor)
	C_BOOLEAN:C305($b_continuar)
	$b_continuar:=True:C214
	Case of 
		: ($r_itemRef=1)
			COPY ARRAY:C226(alACT_IdDteEmiTemp;alACT_IdDteEmi)
			COPY ARRAY:C226(atACT_TipoEmiTemp;atACT_TipoEmi)
			COPY ARRAY:C226(alACT_FolioEmiTemp;alACT_FolioEmi)
			COPY ARRAY:C226(adACT_FechaEmisionEmiTemp;adACT_FechaEmisionEmi)
			COPY ARRAY:C226(arACT_MontoTotalEmiTemp;arACT_MontoTotalEmi)
			COPY ARRAY:C226(atACT_PDFEmiTemp;atACT_PDFEmi)
			COPY ARRAY:C226(atACT_PDF_rutaEmiTemp;atACT_PDF_rutaEmi)
			
			COPY ARRAY:C226(atACT_XMLEmiTemp;atACT_XMLEmi)
			COPY ARRAY:C226(atACT_XML_rutaEmiTemp;atACT_XML_rutaEmi)
			
		: ($r_itemRef<20000)
			atACT_TipoEmiTemp{0}:=$t_itemText
			AT_SearchArray (->atACT_TipoEmiTemp;"=";->$al_result)
			
		: ($r_itemRef<30000)
			alACT_FolioEmiTemp{0}:=Num:C11($t_itemText)
			AT_SearchArray (->alACT_FolioEmiTemp;"=";->$al_result)
			
		: ($r_itemRef<40000)
			adACT_FechaEmisionEmiTemp{0}:=Date:C102($t_itemText)
			AT_SearchArray (->adACT_FechaEmisionEmiTemp;"=";->$al_result)
			
		Else 
			$b_continuar:=False:C215
	End case 
	
	If ($b_continuar)
		
		For ($l_indiceFor;1;Size of array:C274($al_result))
			
			APPEND TO ARRAY:C911(alACT_IdDteEmi;alACT_IdDteEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_TipoEmi;atACT_TipoEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(alACT_FolioEmi;alACT_FolioEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(adACT_FechaEmisionEmi;adACT_FechaEmisionEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(arACT_MontoTotalEmi;arACT_MontoTotalEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_PDFEmi;atACT_PDFEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_PDF_rutaEmi;atACT_PDF_rutaEmiTemp{$al_result{$l_indiceFor}})
			
			APPEND TO ARRAY:C911(atACT_XMLEmi;atACT_XMLEmiTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_XML_rutaEmi;atACT_XML_rutaEmiTemp{$al_result{$l_indiceFor}})
			
		End for 
		
		ACTdteEmi_ColoreaListBox 
		
		
	End if 
	
End if 