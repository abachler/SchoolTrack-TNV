Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_REAL:C285(vi_PageNumber)
		
		ACTmnu_OpcionesGeneracionIECV ("DeclaraVarsForm")
		ACTmnu_OpcionesGeneracionIECV ("InicializaVarsForm")
		
		ACTmnu_OpcionesGeneracionIECV ("GeneraPreferenciaPrincipal")
		
		ACTmnu_OpcionesGeneracionIECV ("CargaModelosImportacion")
		
		ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")
		
		vi_PageNumber:=1
		_O_DISABLE BUTTON:C193(cb_TieneEncabezado)  //siempre debe tener encabezado
		
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->alACTcfg_Razones{atACTcfg_Razones})
		
		POST KEY:C465(Character code:C91("+");256)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 