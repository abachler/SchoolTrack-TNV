Case of 
	: (Form event:C388=On Load:K2:1)
		C_REAL:C285(btn_total;btn_seleccionado;vr_pctDscto;vl_tipoDcto;vrACT_MontoDesctoAfecto;vrACT_MontoDesctoExento)
		C_TEXT:C284(vt_montoTotal;vt_montoSel)
		If (vrACT_SeleccionadoAPagar=0)
			btn_total:=1
			btn_seleccionado:=0
		Else 
			btn_total:=0
			btn_seleccionado:=1
		End if 
		vr_pctDscto:=0
		
		OBJECT SET FORMAT:C236(vr_pctDscto;"##0"+<>tXS_RS_DecimalSeparator+"00")
		
		Case of 
			: (vl_tipoDcto=1)
				If (vrACT_SeleccionadoAfecto=0)
					_O_DISABLE BUTTON:C193(btn_seleccionado)
				Else 
					_O_ENABLE BUTTON:C192(btn_seleccionado)
				End if 
				
				If (vrACT_MontoAdeudadoAfecto=0)
					_O_DISABLE BUTTON:C193(btn_total)
				Else 
					_O_ENABLE BUTTON:C192(btn_total)
				End if 
				
				If (vrACT_SeleccionadoAfecto=0) & (vrACT_MontoAdeudadoAfecto=0)
					OBJECT SET ENTERABLE:C238(vr_pctDscto;False:C215)
				Else 
					OBJECT SET ENTERABLE:C238(vr_pctDscto;True:C214)
				End if 
				vt_montoTotal:="("+String:C10(vrACT_MontoAdeudadoAfecto;"|Despliegue_ACT_Pagos")+")"
				vt_montoSel:="("+String:C10(vrACT_SeleccionadoAfecto;"|Despliegue_ACT_Pagos")+")"
				
			: (vl_tipoDcto=2)
				If (vrACT_SeleccionadoExento=0)
					_O_DISABLE BUTTON:C193(btn_seleccionado)
				Else 
					_O_ENABLE BUTTON:C192(btn_seleccionado)
				End if 
				
				If (vrACT_MontoAdeudadoExento=0)
					_O_DISABLE BUTTON:C193(btn_total)
				Else 
					_O_ENABLE BUTTON:C192(btn_total)
				End if 
				
				If (vrACT_SeleccionadoExento=0) & (vrACT_MontoAdeudadoExento=0)
					OBJECT SET ENTERABLE:C238(vr_pctDscto;False:C215)
				Else 
					OBJECT SET ENTERABLE:C238(vr_pctDscto;True:C214)
				End if 
				
				vt_montoTotal:="("+String:C10(vrACT_MontoAdeudadoExento;"|Despliegue_ACT_Pagos")+")"
				vt_montoSel:="("+String:C10(vrACT_SeleccionadoExento;"|Despliegue_ACT_Pagos")+")"
				
		End case 
		
		
End case 