Case of 
	: (Form event:C388=On Load:K2:1)
		vt_CargoSeleccionado:=""
		vt_MontoCargo:=""
		vl_IdItemSeleccionado:=-1
		ACTfdp_OpcionesRecargos ("InicializaVars")
		ACTfdp_OpcionesRecargos ("CargaVariables";->vlACT_idFormaDePago)
		ADTcfg_LoadItemsACT 
		If (crPermitirRecargoItem=1)
			vl_IdItemSeleccionado:=KRL_GetNumericFieldData (->[ACT_Formas_de_Pago:287]id:1;->vlACT_idFormaDePago;->[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15)
			vt_MontoCargo:=String:C10(KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->vl_IdItemSeleccionado;->[xxACT_Items:179]Monto:7))
			vb_EsRelativo:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->vl_IdItemSeleccionado;->[xxACT_Items:179]EsRelativo:5)
			If (vb_EsRelativo)
				vt_MontoCargo:=vt_MontoCargo+"%"
			End if 
			OBJECT SET ENTERABLE:C238(*;"MontoRecargo";True:C214)
			OBJECT SET ENTERABLE:C238(*;"CargoSeleccionado";True:C214)
			OBJECT SET ENTERABLE:C238(*;"Binvisible";True:C214)
			OBJECT SET ENABLED:C1123(*;"ItemSeleccionado";True:C214)
			OBJECT SET ENABLED:C1123(*;"MontoSeleccionado";True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*;"MontoRecargo";False:C215)
			OBJECT SET ENTERABLE:C238(*;"CargoSeleccionado";False:C215)
			OBJECT SET ENTERABLE:C238(*;"Binvisible";False:C215)
			OBJECT SET ENABLED:C1123(*;"ItemSeleccionado";False:C215)
			OBJECT SET ENABLED:C1123(*;"MontoSeleccionado";False:C215)
		End if 
		OBJECT SET ENABLED:C1123(*;"BotónAceptarFDP";False:C215)
		
	: (Form event:C388=On Clicked:K2:4)
		Case of 
			: (vl_IdItemSeleccionado>0) & (cs_ItemSeleccionado=1)
				OBJECT SET ENABLED:C1123(*;"BotónAceptarFDP";True:C214)
			: (cs_MontoSeleccionado=1) & (vr_MontoRecargo>0) & (vl_IdItemSeleccionado>0)
				OBJECT SET ENABLED:C1123(*;"BotónAceptarFDP";True:C214)
			: (crPermitirRecargoItem=0)
				OBJECT SET ENABLED:C1123(*;"BotónAceptarFDP";True:C214)
			Else 
				OBJECT SET ENABLED:C1123(*;"BotónAceptarFDP";False:C215)
		End case 
End case 