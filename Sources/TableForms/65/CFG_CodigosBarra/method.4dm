C_LONGINT:C283($l_lectoresConIDNacional1;$l_lectoresConIDNacional2;$l_lectoresConIDNacional3)


Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		BBLcfg_Listbox_CodigosBarra 
		
		OBJECT SET RGB COLORS:C628(*;"fondo";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		
		OBJECT SET TITLE:C194(*;"l1_IdentificadorInterno";"Identificador interno")
		OBJECT SET TITLE:C194(*;"l2_IdentificadorNacional";<>at_IDNacional_Names{1})
		OBJECT SET TITLE:C194(*;"l3_IdentificadorNacional";<>at_IDNacional_Names{2})
		OBJECT SET TITLE:C194(*;"l4_IdentificadorNacional";<>at_IDNacional_Names{3})
		
		Case of 
			: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]ID:1))
				l1_IdentificadorInterno:=1
			: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]RUT:7))
				l2_IdentificadorNacional:=1
			: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]IDNacional_2:33))
				l3_IdentificadorNacional:=1
			: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]IDNacional_3:34))
				l4_IdentificadorNacional:=1
		End case 
		
		Case of 
			: ([xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27=Field:C253(->[BBL_Registros:66]ID:3))
				r1_IdentificadorInterno:=1
			: ([xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27=Field:C253(->[BBL_Registros:66]No_Registro:25))
				r2_NumeroRegistro:=1
		End case 
		
		OBJECT SET ENTERABLE:C238(Mti_BarCode;False:C215)
		_O_DISABLE BUTTON:C193(bDelMedia)
		_O_DISABLE BUTTON:C193(bDelGrupoLectores)
		
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectoresConIDNacional1)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]RUT:7#"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectoresConIDNacional2)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]IDNacional_2:33#"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectoresConIDNacional3)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]IDNacional_3:34#"")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		
		OBJECT SET VISIBLE:C603(*;"l2_IdentificadorNacional";$l_lectoresConIDNacional1>0)
		OBJECT SET VISIBLE:C603(*;"l3_IdentificadorNacional";$l_lectoresConIDNacional2>0)
		OBJECT SET VISIBLE:C603(*;"l4_IdentificadorNacional";$l_lectoresConIDNacional3>0)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		<>bBBL_NumeroRegistroEditable:=[xxBBL_Preferencias:65]Registros_BarcodeConPrefijo:12
		<>bBBL_BarcodeRegistroConPrefijo:=[xxBBL_Preferencias:65]Registro_BarCodeConPrefijo:32
		<>bBBL_BarcodeLectorConPrefijo:=[xxBBL_Preferencias:65]Lector_BarCodeConPrefijo:35
		<>lBBL_refCampoBarcodeLector:=[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33
		<>lBBL_refCampoBarcodeDocumento:=[xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 