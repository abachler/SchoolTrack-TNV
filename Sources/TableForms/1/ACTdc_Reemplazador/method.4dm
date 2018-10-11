Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTinit_LoadFdPago 
		ACTcfg_LoadBancos 
		  //ARRAY TEXT(aACT_DocsReemp;0)
		  //ARRAY LONGINT(alACT_IdFormasdePago;0)
		  //COPY ARRAY(atACT_FormasdePago;aACT_DocsReemp)
		  //COPY ARRAY(alACT_FormasdePagoID;alACT_IDFormasdePago)
		  //C_LONGINT(vl_indiceFormasDePago)
		  //C_LONGINT(vlACT_idFormaDePagoOrg)
		  //C_TEXT(vtACT_TCNumero)
		  //vl_indiceFormasDePago:=4
		  //vlACT_idFormaDePagoOrg:=0
		  //AT_Insert (1;vl_indiceFormasDePago-1;->aACT_DocsReemp;->alACT_IDFormasdePago)
		  //aACT_DocsReemp{1}:=__ ("Mismo cheque")
		  //aACT_DocsReemp{2}:=__ ("Varios cheques")
		  //aACT_DocsReemp{3}:="(-"
		  //alACT_IDFormasdePago{1}:=0
		  //alACT_IDFormasdePago{2}:=0
		  //alACT_IDFormasdePago{3}:=0
		
		  //ASM 20140320 Para cargar las formas de pagos de los reemplazos de documentos (imprimir)
		ACTdc_CargaArregloFDP ("CargaArreglos")
		TipoTarjeta:=AT_array2text (-><>atACT_TarjetasCredito)
		Bancos:=AT_array2text (->atACT_BankName)
		vsACT_DocsReemp:=aACT_DocsReemp{vl_indiceFormasDePago}
		aACT_DocsReemp:=vl_indiceFormasDePago
		vlACT_ReempPor:=vl_indiceFormasDePago
		i_Doc:=1
		ACTdc_CargaDatosDCartera 
		DocsReemp:=AT_array2text (->aACT_DocsReemp)
		
		i_Doc:=1
		  //ACTdc_OpcionesReemplazoMasivo ("SetNextIngresar")
		
		vACT_BancoNombre:=""
		vACT_BancoCodigo:=""
		
		ACTpgs_InitArraysDocumentar ("DeclaraArrays")
		xALSet_ACT_DocumentarReemp 
		ACTcfg_OpcionesRecargosCaja ("InitVars")
		
		  //  //**** para asignar otro estado...
		  //20120728 RCH Se pasa a ACTdc_CargaDatosDCartera
		  //ACTdc_OpcionesGenerales ("CargaArregloEstadosXFdP";->vlACT_idFormaDePago;->vlACT_idEstadoFormaDePago)
		
		
		ACTdc_OpcionesReemplazoMasivo ("OnLoadList")
		ACTdc_OpcionesReemplazoMasivo ("SetObjectVisible")
		  //setea objetos
		ACTdc_OpcionesReemplazoMasivo ("SetNextIngresar")
		
		ACTdc_OpcionesReemplazoVariosD ("SetDeleteIcon")
		  //varios pagos
		
		
	: (Form event:C388=On Close Box:K2:21)
		ARRAY TEXT:C222(atACT_estadosReemp;0)
		ARRAY LONGINT:C221(alACT_estadosIDReemp;0)
		
		ACTdc_OpcionesReemplazoMasivo ("OnCloseBox")
		
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Clicked:K2:4)
		  //ACTdc_OpcionesGenerales ("CargaArregloEstadosXFdP";->vlACT_idFormaDePago;->vlACT_idEstadoFormaDePago)
		
End case 