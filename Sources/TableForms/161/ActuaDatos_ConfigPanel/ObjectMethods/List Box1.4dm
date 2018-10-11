C_POINTER:C301($colPtr)
Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_REAL:C285($col;$row)
		ab_NivelModificado{aiADT_NivNo}:=True:C214
		LISTBOX GET CELL POSITION:C971(lb_Relaciones;$col;$row;$colPtr)
		If ($col=2)
			SN3_EditaRF{$row}:=SN3_PublicaRF{$row}
		End if 
		$msg:=ST_Boolean2Str (SN3_PublicaRF{$row};"Activada";"Desactivada")+", solicitud del dato "+SN3_ListaCamposRF{$row}+" de relaciones familiares, para el nivel "+at_IDNivel{aiADT_NivNo}
		LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
		
End case 