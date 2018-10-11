Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(vt_ruta)
		C_REAL:C285(cs_windows;cs_mac;cs_documentoDigital;cs_detallar)
		ACTcfg_LoadConfigData (8)
		
		  //razones sociales
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		
		cs_windows:=1
		cs_mac:=0
		
		cs_documentoDigital:=1
		cs_detallar:=0
		cs_detallar:=1  //20160322 RCH
		
		vt_ruta:=""
End case 