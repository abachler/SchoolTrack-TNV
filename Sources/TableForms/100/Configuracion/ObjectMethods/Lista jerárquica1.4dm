Case of 
	: (Form event:C388=On Clicked:K2:4)
		$el:=Selected list items:C379(Self:C308->)
		If ($el>0)
			CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
			CFG_STR_PeriodosEscolares_NEW ("LoadConfig")
		End if 
	: (Form event:C388=On Data Change:K2:15)
		GET LIST ITEM:C378(hl_Configuraciones;Selected list items:C379(hl_Configuraciones);$l_IdConfiguracion;vt_NombreConfig)
End case 