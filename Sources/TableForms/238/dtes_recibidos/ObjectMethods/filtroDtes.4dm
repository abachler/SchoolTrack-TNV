
C_TEXT:C284($t_itemText)
C_REAL:C285($r_itemRef)
GET LIST ITEM:C378(hlACT_FiltroDte;*;$r_itemRef;$t_itemText)

If ($r_itemRef>0)
	
	AT_Initialize (->alACT_IdDteRec;->atACT_Tipo;->atACT_Emisor;->atACT_Folio;->adACT_FechaEmision;->arACT_MontoTotal)
	AT_Initialize (->atACT_EmisorRUT;->adACT_recepcionFecha;->atACT_PDF;->atACT_PDF_ruta)
	
	ARRAY LONGINT:C221($al_result;0)
	C_LONGINT:C283($l_indiceFor)
	C_BOOLEAN:C305($b_continuar)
	$b_continuar:=True:C214
	Case of 
		: ($r_itemRef=1)
			COPY ARRAY:C226(alACT_IdDteRecTemp;alACT_IdDteRec)
			COPY ARRAY:C226(atACT_TipoTemp;atACT_Tipo)
			COPY ARRAY:C226(atACT_EmisorTemp;atACT_Emisor)
			COPY ARRAY:C226(atACT_EmisorRUTTemp;atACT_EmisorRUT)
			COPY ARRAY:C226(atACT_FolioTemp;atACT_Folio)
			COPY ARRAY:C226(adACT_FechaEmisionTemp;adACT_FechaEmision)
			COPY ARRAY:C226(arACT_MontoTotalTemp;arACT_MontoTotal)
			COPY ARRAY:C226(adACT_recepcionFechaTemp;adACT_recepcionFecha)
			COPY ARRAY:C226(atACT_PDFTemp;atACT_PDF)
			COPY ARRAY:C226(atACT_PDF_rutaTemp;atACT_PDF_ruta)
			
		: ($r_itemRef<20000)
			atACT_TipoTemp{0}:=$t_itemText
			AT_SearchArray (->atACT_TipoTemp;"=";->$al_result)
			
		: ($r_itemRef<30000)
			atACT_EmisorTemp{0}:=$t_itemText
			AT_SearchArray (->atACT_EmisorTemp;"=";->$al_result)
			
		: ($r_itemRef<40000)
			atACT_EmisorRUTTemp{0}:=$t_itemText
			AT_SearchArray (->atACT_EmisorRUTTemp;"=";->$al_result)
			
		: ($r_itemRef<50000)
			atACT_FolioTemp{0}:=$t_itemText
			AT_SearchArray (->atACT_FolioTemp;"=";->$al_result)
			
		: ($r_itemRef<60000)
			adACT_FechaEmisionTemp{0}:=Date:C102($t_itemText)
			AT_SearchArray (->adACT_FechaEmisionTemp;"=";->$al_result)
			
		: ($r_itemRef<70000)
			adACT_recepcionFechaTemp{0}:=Date:C102($t_itemText)
			AT_SearchArray (->adACT_recepcionFechaTemp;"=";->$al_result)
			
		Else 
			$b_continuar:=False:C215
	End case 
	
	If ($b_continuar)
		
		For ($l_indiceFor;1;Size of array:C274($al_result))
			APPEND TO ARRAY:C911(alACT_IdDteRec;alACT_IdDteRecTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_Tipo;atACT_TipoTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_Emisor;atACT_EmisorTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_Folio;atACT_FolioTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(adACT_FechaEmision;adACT_FechaEmisionTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(arACT_MontoTotal;arACT_MontoTotalTemp{$al_result{$l_indiceFor}})
			
			APPEND TO ARRAY:C911(atACT_EmisorRUT;atACT_EmisorRUTTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(adACT_recepcionFecha;adACT_recepcionFechaTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_PDF;atACT_PDFTemp{$al_result{$l_indiceFor}})
			APPEND TO ARRAY:C911(atACT_PDF_ruta;atACT_PDF_rutaTemp{$al_result{$l_indiceFor}})
			
		End for 
		
		ACTdteRec_ColoreaListBox 
		
		
	End if 
	
End if 