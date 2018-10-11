Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*;"genEjemplo@";False:C215)
		XS_SetInterface 
		ACTtf_DeclareArrays 
		
		ACTinit_LoadFdPago 
		
		  //Preferencias por defecto
		C_TEXT:C284(vNombreOldModelo)
		C_TEXT:C284(vNombreNewModelo;vNombreOldModeloTB;vNombreOldModeloC)
		C_TEXT:C284(viNameFile)
		C_REAL:C285(vi_PageNumber)
		_O_C_INTEGER:C282(vi_NoPagina)
		C_LONGINT:C283(WTrf_ac1;WTrf_tb1)
		C_BOOLEAN:C305(vb_testImport)  //botón para probar importación
		vb_testImport:=False:C215
		_O_DISABLE BUTTON:C193(bTestImport)
		C_TEXT:C284(vsTipoArchivo)
		C_REAL:C285(cs_usarComoTexto)  //20180817 RCH ticket 214673
		
		vsTipoArchivo:=""
		vNombreOldModelo:=""
		vNombreNewModelo:=""
		vNombreOldModeloAB:=""
		vNombreOldModeloC:=""
		
		bto_Exportacion:=1
		bto_Importacion:=0
		
		PWTrf_Ptb1:=1  //archivo de transferencia bancaria
		WTrf_tb2:=1  //Nuevo archivo TB
		WTrf_tb3:=0  //Viejo archivo TB
		PWTrf_Pac1:=0  //archivo decontabilidad
		WTrf_ac2:=0  //nuevo AC
		WTrf_ac3:=0  //editar archivo ac
		
		  //WTrf_Tipo:=1
		vlACT_id_modo_pago:=-10
		atACT_FormasdePagoNew:=Find in array:C230(alACT_FormasdePagoID;vlACT_id_modo_pago)
		vt_tipoArchivo:=atACT_FormasdePagoNew{atACT_FormasdePagoNew}
		viTypeFile:=vt_tipoArchivo
		
		  //WTrf_Tipo1:=1  //PAC
		  //WTrf_Tipo2:=0  //PAT
		  //WTrf_Tipo3:=0  //`CUp
		PWTrf_h2:=1  //archivo Plano
		PWTrf_h1:=0  //Delimitado
		WTrf_s1:=0  //TAB
		WTrf_s2:=0  //punto y coma
		cs_encabezado:=0  //para encabezado pag 5
		cs_registroControl:=0  //para pie, pag 6
		
		viNameFile:=""  //Nombre del archvo para mostrarlo en la ultima pagina
		  //viTypeFile:=""  //Tipo archivo para mostrarlo en ultima pagina
		viFormatFile:=""  //formato archivo para mostrarlo en ultima pagina
		
		C_LONGINT:C283(WTrf_s1;WTrf_S2;WTrf_s3;WTrf_s4)
		C_TEXT:C284(WTrf_s4_CaracterOtro)
		
		IT_SetButtonState (False:C215;->WTrf_s1;->WTrf_S2;->WTrf_s3;->WTrf_s4)  //delimitadores
		
		_O_DISABLE BUTTON:C193(*;"bModelo@")  //Pop up modelos
		OBJECT SET VISIBLE:C603(bModeloTB;False:C215)  //imagen pop up
		OBJECT SET VISIBLE:C603(bModelosC;False:C215)  //imagen pop up
		IT_SetButtonState ((PWTrf_Pac1=1);->WTrf_ac2;->WTrf_ac3;->WTrf_ac1)
		IT_SetButtonState ((PWTrf_Ptb1=1);->WTrf_tb2;->WTrf_tb3;->WTrf_tb1)
		
		_O_DISABLE BUTTON:C193(vNombreOldModelo)  //solo se permitira seleccionar de lista desplegable
		vi_PageNumber:=1  //Numero de Pagina
		vi_NoPagina:=1
		
		vt_ICodApr:=""
		
		LOC_LoadIdenNacionales 
		ARRAY TEXT:C222(at_IIdentificador;0)
		APPEND TO ARRAY:C911(at_IIdentificador;"1_"+<>at_IDNacional_Names{1}+"_apoderado")
		APPEND TO ARRAY:C911(at_IIdentificador;"2_"+<>at_IDNacional_Names{2}+"_apoderado")
		APPEND TO ARRAY:C911(at_IIdentificador;"3_"+<>at_IDNacional_Names{3}+"_apoderado")
		APPEND TO ARRAY:C911(at_IIdentificador;"Código interno apoderado")
		APPEND TO ARRAY:C911(at_IIdentificador;"Pasaporte apoderado")
		APPEND TO ARRAY:C911(at_IIdentificador;"Rut titular Cuenta Corriente")
		APPEND TO ARRAY:C911(at_IIdentificador;"Rut titular Tarjeta de Crédito")
		APPEND TO ARRAY:C911(at_IIdentificador;"Código mandato PAC")
		APPEND TO ARRAY:C911(at_IIdentificador;"Código mandato PAT")
		APPEND TO ARRAY:C911(at_IIdentificador;"Código de familia")
		
		APPEND TO ARRAY:C911(at_IIdentificador;"Código interno Cuenta Corriente")
		APPEND TO ARRAY:C911(at_IIdentificador;"1_"+<>at_IDNacional_Names{1}+"_alumno")
		APPEND TO ARRAY:C911(at_IIdentificador;"2_"+<>at_IDNacional_Names{2}+"_alumno")
		APPEND TO ARRAY:C911(at_IIdentificador;"3_"+<>at_IDNacional_Names{3}+"_alumno")
		APPEND TO ARRAY:C911(at_IIdentificador;"Código interno alumno")  //codigo SchoolTrack
		
		APPEND TO ARRAY:C911(at_IIdentificador;"Número de Aviso de Cobranza")
		
		  //vIIdentificador:=at_IIdentificador{1}
		vIIdentificador:=""
		
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		If (Undefined:C82(vb_editarArchivoTf))
			C_BOOLEAN:C305(vb_editarArchivoTf)
		End if 
		If (Not:C34(vb_editarArchivoTf))
			FORM GOTO PAGE:C247(1)
			
			If (<>GCOUNTRYCODE="mx")  //20180816 RCH Para dar soporte al comportamiento actual
				cs_usarComoTexto:=1
			End if 
			
		Else 
			
			If ([xxACT_ArchivosBancarios:118]ImpExp:5=False:C215)
				bto_Importacion:=0
				bto_Exportacion:=1
			Else 
				bto_Importacion:=1
				bto_Exportacion:=0
			End if 
			Case of 
					  //: ([xxACT_ArchivosBancarios]Tipo="PAC")
				: ([xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-10)
					WTrf_tb3:=1
					WTrf_ac3:=0
					PWTrf_Ptb1:=1
					PWTrf_Pac1:=0
					WTrf_tb2:=0
					  //: ([xxACT_ArchivosBancarios]Tipo="PAT")
				: ([xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-9)
					WTrf_tb3:=1
					WTrf_ac3:=0
					PWTrf_Ptb1:=1
					PWTrf_Pac1:=0
					WTrf_tb2:=0
					  //: ([xxACT_ArchivosBancarios]Tipo="Cuponera")
				: ([xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-11)
					WTrf_tb3:=1
					WTrf_ac3:=0
					PWTrf_Ptb1:=1
					PWTrf_Pac1:=0
					WTrf_tb2:=0
					  //: ([xxACT_ArchivosBancarios]Tipo="Cheque")
				: ([xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-4)
					WTrf_tb3:=0
					WTrf_ac3:=1
					PWTrf_Ptb1:=0
					PWTrf_Pac1:=1
					WTrf_ac2:=0
					  //: ([xxACT_ArchivosBancarios]Tipo="Efectivo")
				: ([xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-3)
					WTrf_tb3:=0
					WTrf_ac3:=1
					PWTrf_Ptb1:=0
					PWTrf_Pac1:=1
					WTrf_ac2:=0
					  //: ([xxACT_ArchivosBancarios]Tipo="Tarjeta de crédito")
				: ([xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-6)
					WTrf_tb3:=0
					WTrf_ac3:=1
					PWTrf_Ptb1:=0
					PWTrf_Pac1:=1
					WTrf_ac2:=0
				: ([xxACT_ArchivosBancarios:118]Tipo:6="Contabilidad")
					WTrf_tb3:=0
					WTrf_ac3:=1
					PWTrf_Ptb1:=0
					PWTrf_Pac1:=1
					WTrf_ac2:=0
				Else 
					WTrf_tb3:=1
					WTrf_ac3:=0
					PWTrf_Ptb1:=1
					PWTrf_Pac1:=0
					WTrf_tb2:=0
			End case 
			  //End if 
			
			viNameFile:=[xxACT_ArchivosBancarios:118]Nombre:3
			vlACT_id_modo_pago:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
			vt_tipoArchivo:=[xxACT_ArchivosBancarios:118]Tipo:6
			viTypeFile:=[xxACT_ArchivosBancarios:118]Tipo:6
			atACT_FormasdePagoNew:=Find in array:C230(alACT_FormasdePagoID;vlACT_id_modo_pago)
			
			vi_NoPagina:=3
			vi_PageNumber:=3
			POST KEY:C465(Character code:C91("+");256)  //para que se ejecute el código del botón
		End if 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		Case of 
			: (vi_PageNumber=8)
				IT_SetButtonState (vb_testImport;->bTestImport)
				If ((bto_Importacion=1) & (PWTrf_Pac1=1) & (PWTrf_h1=1) & ((vlACT_id_modo_pago=-10) | (vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-11)))
					OBJECT SET VISIBLE:C603(*;"genEjemplo@";True:C214)
				End if 
			: (vi_PageNumber=7)
				alProEvt:=AL_GetLine (xALP_ExportBankFiles)
				If (alProEvt=0)
					_O_DISABLE BUTTON:C193(bDeleteLine)
				Else 
					_O_ENABLE BUTTON:C192(bDeleteLine)
				End if 
				If ((alProEvt=0) | (alProEvt=1))
					_O_DISABLE BUTTON:C193(bSubirLineaExp)
				Else 
					_O_ENABLE BUTTON:C192(bSubirLineaExp)
				End if 
				If ((alProEvt=0) | (alProEvt=Size of array:C274(al_Numero)))
					_O_DISABLE BUTTON:C193(bBajarLineaExp)
				Else 
					_O_ENABLE BUTTON:C192(bBajarLineaExp)
				End if 
				_O_ENABLE BUTTON:C192(bInsertLine)
				
			: (vi_PageNumber=6)
				alProEvt:=AL_GetLine (xALP_ExportBankFilesF)
				If (alProEvt=0)
					_O_DISABLE BUTTON:C193(bDeleteLine)
				Else 
					_O_ENABLE BUTTON:C192(bDeleteLine)
				End if 
				If ((alProEvt=0) | (alProEvt=1))
					_O_DISABLE BUTTON:C193(bSubirLineaExp)
				Else 
					_O_ENABLE BUTTON:C192(bSubirLineaExp)
				End if 
				If ((alProEvt=0) | (alProEvt=Size of array:C274(al_Numero)))
					_O_DISABLE BUTTON:C193(bBajarLineaExp)
				Else 
					_O_ENABLE BUTTON:C192(bBajarLineaExp)
				End if 
				IT_SetButtonState ((cs_registroControl=1);->bInsertLine)
				
			: (vi_PageNumber=5)
				alProEvt:=AL_GetLine (xALP_ExportBankFilesH)
				If (alProEvt=0)
					_O_DISABLE BUTTON:C193(bDeleteLine)
				Else 
					_O_ENABLE BUTTON:C192(bDeleteLine)
				End if 
				If ((alProEvt=0) | (alProEvt=1))
					_O_DISABLE BUTTON:C193(bSubirLineaExp)
				Else 
					_O_ENABLE BUTTON:C192(bSubirLineaExp)
				End if 
				If ((alProEvt=0) | (alProEvt=Size of array:C274(al_Numero)))
					_O_DISABLE BUTTON:C193(bBajarLineaExp)
				Else 
					_O_ENABLE BUTTON:C192(bBajarLineaExp)
				End if 
				IT_SetButtonState ((cs_encabezado=1);->bInsertLine)
			: (vi_PageNumber=4)
			: (vi_PageNumber=2)
				If (PWTrf_Ptb1=1)
					If (WTrf_tb2=1)
						_O_ENABLE BUTTON:C192(bNext)
					Else 
						_O_DISABLE BUTTON:C193(bNext)
						If ((WTrf_tb3=1) & (vNombreOldModeloAB#""))
							_O_ENABLE BUTTON:C192(bNext)
						End if 
					End if 
				Else 
					If (PWTrf_Pac1=1)
						If (WTrf_ac2=1)
							_O_ENABLE BUTTON:C192(bNext)
						Else 
							_O_DISABLE BUTTON:C193(bNext)
							If ((WTrf_ac3=1) & (vNombreOldModeloC#""))
								_O_ENABLE BUTTON:C192(bNext)
							End if 
						End if 
					End if 
				End if 
				If (WTrf_tb3#1)
					vNombreOldModeloAB:=""
				End if 
				If (WTrf_ac3#1)
					vNombreOldModeloC:=""
				End if 
			: (vi_PageNumber=1)
				
		End case 
End case 
IT_SetButtonState ((PWTrf_Pac1=1);->WTrf_ac2;->WTrf_ac3;->WTrf_ac1)
IT_SetButtonState ((PWTrf_Ptb1=1);->WTrf_tb2;->WTrf_tb3;->WTrf_tb1)
IT_SetButtonState ((PWTrf_h1=1);->WTrf_s1;->WTrf_S2;->WTrf_s3;->WTrf_s4)  //delimitadores
If (WTrf_s4=1)
	OBJECT SET ENTERABLE:C238(WTrf_s4_CaracterOtro;True:C214)
Else 
	WTrf_s4_CaracterOtro:=""
	OBJECT SET ENTERABLE:C238(WTrf_s4_CaracterOtro;False:C215)
End if 