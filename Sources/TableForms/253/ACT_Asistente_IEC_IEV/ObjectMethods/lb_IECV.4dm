Case of 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Double Clicked:K2:5))
		C_LONGINT:C283($l_col;$l_line)
		LISTBOX GET CELL POSITION:C971(*;"lb_IECV";$l_col;$l_line)
		If ($l_line>0)
			vt_Motivo:=atACTie_ErrorDetalle{$l_line}
		End if 
		  //ACTmnu_OpcionesGeneracionIECV 
		  //ACTdte_OpcionesGeneralesIE
		
	: (Form event:C388=On Data Change:K2:15)
		ACTmnu_OpcionesGeneracionIECV ("ValidaDatos")
		
End case 