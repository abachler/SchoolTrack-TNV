Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //busqueda
		
		C_REAL:C285(vrACT_folio)
		C_DATE:C307(vdACT_fechaEmision)
		C_DATE:C307(vdACT_fechaEmisionH)
		C_LONGINT:C283(vlACT_RSSel)
		C_REAL:C285(bACT_PDFcedible;bACT_PDF;bACT_XML)
		ARRAY LONGINT:C221($alACT_idsRazonesSociales;0)
		
		C_REAL:C285(r_abrirDcto)  //20150725 RCH Se permite elegir si se quiere abrir el archivo o no.
		
		C_LONGINT:C283(l_totalListado)
		
		bACT_PDFcedible:=0
		bACT_PDF:=1
		bACT_XML:=0
		
		  //20150331 RCH Carga la RS según las boletas seleccionadas
		  //ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		  //vlACT_RSSel:=alACTcfg_Razones{aTACTcfg_Razones}
		If (Records in selection:C76([ACT_Boletas:181])>0)
			DISTINCT VALUES:C339([ACT_Boletas:181]ID_RazonSocial:25;$alACT_idsRazonesSociales)
		End if 
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		If (Size of array:C274($alACT_idsRazonesSociales)=1)
			$l_existe:=Find in array:C230(alACTcfg_Razones;$alACT_idsRazonesSociales{1})
			If ($l_existe>0)
				aTACTcfg_Razones:=$l_existe
			End if 
		End if 
		vlACT_RSSel:=alACTcfg_Razones{aTACTcfg_Razones}
		
		  //20150908 RCH carga pref opcion copia cedible
		ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
		
		ACTdteEmi_LlenaArreglos (vlACT_RSSel;0;!00-00-00!;!00-00-00!;"";vbACT_sobreSeleccion)
		
		ACTdteEmi_CreaArreglosBusqueda 
		
		ACTdteEmi_Generales ("InicializaOpcionesBusqueda")
		
		r_abrirDcto:=1
		r_abrirDcto:=Num:C11(PREF_fGet (0;"ACT_AbrirArchivo";String:C10(r_abrirDcto)))
		
		bACT_PDFcedible:=r_obtieneCopiaCedible  //20150813 RCH Nueva opción
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(bACT_PDFcedible;bACT_PDF=1)
		If (bACT_PDF=0)
			bACT_PDFcedible:=0
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		ACTcfg_DeclaraArreglos ("ACTdteEmitidos_Listado")
		ACTcfg_DeclaraArreglos ("ACTdteEmitidos_Busqueda")
		CANCEL:C270
End case 
