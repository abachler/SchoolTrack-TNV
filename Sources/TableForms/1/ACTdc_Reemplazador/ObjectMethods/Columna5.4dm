Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($vl_idApdoAsignado)
		C_LONGINT:C283($vl_col;$vl_line)
		LISTBOX GET CELL POSITION:C971(lb_doc2Reemp;$vl_col;$vl_line)
		
		ACTdc_OpcionesGenerales ("CargaArregloEstadosXFdP";->alACTlb_IDFP{$vl_line};->alACTlb_IDFPE{$vl_line})
		$vt_text:=AT_array2text (->atACT_estadosReemp;"\r")
		$vl_choice:=Pop up menu:C542($vt_text)
		If ($vl_choice>0)
			atACTlb_Estado2Asignar{$vl_line}:=atACT_estadosReemp{$vl_choice}
			alACTlb_EstadoID2Asignar{$vl_line}:=alACT_estadosIDReemp{$vl_choice}
		End if 
		
End case 