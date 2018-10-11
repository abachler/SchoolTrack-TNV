Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTcfg_LoadBancos 
		ARRAY TEXT:C222(aTiposArchivosText;0)
		ARRAY LONGINT:C221(alTiposArchivosText;0)
		
		COPY ARRAY:C226(atACT_FormasdePagoNew;aTiposArchivosText)
		COPY ARRAY:C226(alACT_FormasdePagoID;alTiposArchivosText)
		
		  //ARRAY TEXT(aTiposArchivosText;7)
		  //aTiposArchivosText{1}:="PAT"
		  //aTiposArchivosText{2}:="PAC"
		  //aTiposArchivosText{3}:="Cuponera"
		  //aTiposArchivosText{4}:="-"
		  //aTiposArchivosText{5}:="Cheque"
		  //aTiposArchivosText{6}:="Efectivo"
		  //aTiposArchivosText{7}:="Tarjeta de crédito"
		vBanco:=""
		If (Is new record:C668([xxACT_ArchivosBancarios:118]))
			vTipo:=""
			[xxACT_ArchivosBancarios:118]Codigo_Pais:7:=<>vtXS_CountryCode
			[xxACT_ArchivosBancarios:118]Rol_BD:8:=<>gRolBD
		Else 
			vTipo:=[xxACT_ArchivosBancarios:118]Tipo:6
			vlTipo:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
			vBanco:=ACTcfg_OpcionesArchivoBancario ("RetornaNombreBanco";->[xxACT_ArchivosBancarios:118]CodBancoAsociado:12)
		End if 
		IT_SetButtonState ((BLOB size:C605([xxACT_ArchivosBancarios:118]xData:2)>0);->bEdit)
		vArchivoPath:=""
		If ((USR_GetUserID >=0) | ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214))
			_O_DISABLE BUTTON:C193(bTrapType)
		Else 
			_O_ENABLE BUTTON:C192(bTrapType)
		End if 
		If (([xxACT_ArchivosBancarios:118]ID:1#0) & (Records in selection:C76([xxACT_ArchivosBancarios:118])=1))
			_O_ENABLE BUTTON:C192(bSaveModel)
		Else 
			_O_DISABLE BUTTON:C193(bSaveModel)
		End if 
		
		  // MOD Ticket N° 196415 20180203 Patricio Aliaga
		OBJECT SET ENABLED:C1123(*;"btnFTP";((Not:C34([xxACT_ArchivosBancarios:118]ImpExp:5)) & (Not:C34([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9))))
		
End case 
