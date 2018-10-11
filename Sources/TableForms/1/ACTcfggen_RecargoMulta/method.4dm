Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(vtACT_moneda)
		If (vlACTcfg_SelectedItemAut#0)
			vtACT_moneda:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemAut;->[xxACT_Items:179]Moneda:10)
		Else 
			vtACT_moneda:=""
		End if 
		
		If ((<>gCountryCode="cl") & (vtACT_moneda="UF@"))
			OBJECT SET FORMAT:C236(vrACT_recargoMulta1;"|Despliegue_UF")
		Else 
			OBJECT SET FORMAT:C236(vrACT_recargoMulta1;"|Despliegue_ACT")
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		vtACT_moneda:=""
		CANCEL:C270
		
	: (Form event:C388=On Outside Call:K2:11)
		
		
	: (Form event:C388=On Deactivate:K2:10)
		If (vlACTcfg_SelectedItemAut#0)
			vtACT_moneda:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemAut;->[xxACT_Items:179]Moneda:10)
		Else 
			vtACT_moneda:=""
		End if 
		CANCEL:C270
End case 