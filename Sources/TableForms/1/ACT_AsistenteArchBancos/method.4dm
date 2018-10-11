Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_PageNumber:=1
		vi_step:=1
		_O_DISABLE BUTTON:C193(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		cbPAC:=0
		cbPAT:=0
		cbCuponera:=0
		b1:=0
		b2:=1
		b3:=0
		b4:=0
		cbMontoAPagar:=1
		cbMontoNeto:=0
		viAño:=Year of:C25(Current date:C33(*))
		viAño2:=Year of:C25(Current date:C33(*))
		IT_SetButtonState (True:C214;->bMes)
		IT_SetEnterable (True:C214;0;->viAño)
		IT_SetEnterable (False:C215;0;->viAño2)
		vi_SelectedMonth:=Month of:C24(Current date:C33(*))
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vt_Mes:=aMeses{vi_SelectedMonth}
		IT_SetEnterable (False:C215;0;->vt_Fecha1;->vt_Fecha2)
		IT_SetButtonState (False:C215;->bCalendar1;->bCalendar2)
		vd_Fecha1:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vd_Fecha2:=Current date:C33(*)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		vd_Fecha3:=Current date:C33(*)
		vt_Fecha3:=String:C10(vd_Fecha3;7)
		vl_DiaApdo:=Day of:C23(Current date:C33(*))
		vl_MesApdo:=Month of:C24(Current date:C33(*))
		vl_AñoApdo:=Year of:C25(Current date:C33(*))
		
		C_LONGINT:C283(vl_ExportXCuentas;vlACT_Exportador)
		C_TEXT:C284(vExportador)
		ARRAY TEXT:C222(atACT_formas_de_pago;0)
		
		ACTinit_LoadFdPago 
		ACTcfg_OpcionesGenABancarios ("LeeBlob")
		
		COPY ARRAY:C226(atACT_FormasdePagoNew;atACT_formas_de_pago)
		vlACT_id_modo_pago:=-9
		vlACT_Exportador:=0
		atACT_formas_de_pago:=Find in array:C230(alACT_FormasdePagoID;vlACT_id_modo_pago)
		vl_ExportXCuentas:=csACTcfg_ModosPagoXCuenta
		$vb_importador:=False:C215
		$vb_retorno:=ACTac_OpcionesGenerales ("BuscaExportadoArchivoTransferencia";->$vb_importador;->vlACT_id_modo_pago;->vExportador;->vlACT_Exportador)
		
		If (vl_ExportXCuentas=1)
			_O_ENABLE BUTTON:C192(vl_ExportXCuentas)
		Else 
			_O_DISABLE BUTTON:C193(vl_ExportXCuentas)
		End if 
		
		If ($vb_retorno)
			_O_ENABLE BUTTON:C192(bNext)
		Else 
			_O_DISABLE BUTTON:C193(bNext)
		End if 
		
		
		  //IT_SetButtonState (False;->bExportadoresPAT;->bExportadoresPAC;->bExportadoresCUP)
		cb_DiaApdo:=0
		cb_GenerarXDiaCargo:=0
		cb_LoadUniFile:=0
		btn_Internacional:=0
		btn_Nacional:=0
		_O_DISABLE BUTTON:C193(cb_GenerarXDiaCargo)
		OBJECT SET VISIBLE:C603(*;"vt_seleccion";vb_utilizarRecSelected)
		
		  //pág 3, referente a la exportación en monedas
		C_LONGINT:C283(vl_otrasMonedas;vl_ExportXAC)
		C_DATE:C307(vd_FechaUF)
		C_TEXT:C284(vt_FechaUF;vt_aviso;vt_aviso2)
		vl_otrasMonedas:=0
		vl_ExportXAC:=0
		vd_FechaUF:=Current date:C33(*)
		vt_FechaUF:=String:C10(vd_FechaUF)
		vt_aviso:=__ ("AVISO: Si la opción ")+ST_Qte (__ ("Forzar la exportación de montos en moneda nacional"))+__ (" no es marcada, los montos se exportarán en la moneda por defecto de la base de datos")+" ("+ST_Uppercase (<>vsACT_MonedaColegio)+")."
		vt_aviso2:=""
		If (cb_IncluirSaldosAnteriores=0)
			_O_ENABLE BUTTON:C192(vl_ExportXAC)
		Else 
			_O_DISABLE BUTTON:C193(vl_ExportXAC)
		End if 
		C_LONGINT:C283(vl_SeleccionItem)
		vl_SeleccionItem:=0
		
End case 
