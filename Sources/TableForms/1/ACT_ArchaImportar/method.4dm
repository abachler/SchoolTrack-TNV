Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		$visible:=ACTusr_AllowChange ("onLoad";->vdACT_ImpRealDate)
		$visible:=ACTusr_AllowChange ("visible";->bCalendar1;$visible)
		ARRAY LONGINT:C221(alACT_ABArchivoID;0)
		ARRAY TEXT:C222(atACT_ABArchivoNombre;0)
		
		ARRAY TEXT:C222(atACT_formas_de_pago;0)
		ACTinit_LoadFdPago 
		COPY ARRAY:C226(atACT_FormasdePagoNew;atACT_formas_de_pago)
		vlACT_id_modo_pago:=-9
		vlACT_Exportador:=0
		vImportador:=__ ("Seleccionar...")
		vlACT_ImportadorID:=0
		atACT_formas_de_pago:=Find in array:C230(alACT_FormasdePagoID;vlACT_id_modo_pago)
		
		$vb_importador:=True:C214
		$vb_retorno:=ACTac_OpcionesGenerales ("BuscaExportadoArchivoTransferencia";->$vb_importador;->vlACT_id_modo_pago;->vImportador;->vlACT_ImportadorID)
		
		vt_ruta:=""
		typeWin:=1
		typeMac:=0
		vdACT_ImpRealDate:=Current date:C33(*)
		vd_FechaUF:=vdACT_ImpRealDate
		vt_FechaUF:=String:C10(vd_FechaUF)
		_O_DISABLE BUTTON:C193(bCont)
		OBJECT SET VISIBLE:C603(*;"pagos@";False:C215)
		If (Application type:C494=4D Remote mode:K5:5)
			cb_ImportOnServer:=1
			OBJECT SET VISIBLE:C603(cb_ImportOnServer;True:C214)
		Else 
			cb_ImportOnServer:=0
			OBJECT SET VISIBLE:C603(cb_ImportOnServer;False:C215)
		End if 
		
		  //20131113 RCH
		C_REAL:C285(cb_emitirDT;cb_listarPagos)
		cb_emitirDT:=0
		cb_listarPagos:=Num:C11(PREF_fGet (0;"ACT_PreferenciaListarPagosEnImportacion";String:C10(cb_listarPagos)))
		cb_emitirDT:=Num:C11(PREF_fGet (0;"ACT_PreferenciaEmitirDTEnImportacion";String:C10(cb_emitirDT)))
		
		C_BOOLEAN:C305(vAOptions)
		vAOptions:=False:C215
		
		ARRAY TEXT:C222(atACT_ItemNames2Charge;0)
		ARRAY LONGINT:C221(alACT_ItemIds2Charge;0)
		C_REAL:C285(vi_SelectedMonth)
		C_BOOLEAN:C305(vb_selectionMonth2Pay)
		C_BOOLEAN:C305(vb_selectionItems2Pay)
		C_BOOLEAN:C305(vb_selectionOrder2PayItems)
		C_BOOLEAN:C305(vb_importSoloCuadrado)
		C_BOOLEAN:C305(vb_crearCargoAut)
		C_BOOLEAN:C305(vb_utilizarIECargoXMoneda;vb_crearIEDctoXMoneda)
		C_TEXT:C284(vsACT_SelectedItemName)
		C_TEXT:C284(vt_ItemNames)
		C_REAL:C285(vlACT_selectedItemId)
		C_BOOLEAN:C305(vb_crearCargoAutCUP)
		C_LONGINT:C283(vl_maximoDcto)
		C_LONGINT:C283(vl_generaIntereses)
		C_LONGINT:C283(vlACTimp_Year)
		vlACTimp_Year:=Year of:C25(Current date:C33(*))
		vb_crearCargoAutCUP:=False:C215
		vlACT_selectedItemId:=0
		vt_ItemNames:=""
		vsACT_SelectedItemName:=""
		vb_crearCargoAut:=False:C215
		vb_importSoloCuadrado:=False:C215
		vb_selectionOrder2PayItems:=False:C215
		vb_selectionItems2Pay:=False:C215
		vb_selectionMonth2Pay:=False:C215
		vi_SelectedMonth:=0
		vl_maximoDcto:=0
		vb_utilizarIECargoXMoneda:=False:C215
		vb_crearIEDctoXMoneda:=False:C215
		vb_fechaPago:=False:C215
		vl_generaIntereses:=0
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]VentaRapida:3=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1>0)
		If (Records in selection:C76([xxACT_Items:179])>0)
			SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_ItemNames2Charge;[xxACT_Items:179]ID:1;alACT_ItemIds2Charge)
			SORT ARRAY:C229(atACT_ItemNames2Charge;alACT_ItemIds2Charge;>)
		End if 
		vt_ItemNames:=AT_array2text (->atACT_ItemNames2Charge)
		
		POST KEY:C465(Character code:C91("+");256)
	: (Form event:C388=On Clicked:K2:4)
		IT_SetButtonState (vb_selectionMonth2Pay;-><>atXS_MonthNames)
		
		IT_SetButtonState (Not:C34(vb_utilizarIECargoXMoneda);->bMuestraItem)
		IT_SetEnterable (Not:C34(vb_utilizarIECargoXMoneda);0;->vsACT_SelectedItemName)
		If (vb_utilizarIECargoXMoneda)
			vsACT_SelectedItemName:=""
		Else 
			IT_SetButtonState (vb_crearCargoAut;->bMuestraItem)
			IT_SetEnterable (vb_crearCargoAut;0;->vsACT_SelectedItemName)
		End if 
		IT_SetButtonState (vb_crearCargoAut;->vb_utilizarIECargoXMoneda)
		IT_SetEnterable (vb_crearIEDctoXMoneda;0;->vl_maximoDcto)
		If (Not:C34(vb_crearIEDctoXMoneda))
			vl_maximoDcto:=0
		End if 
		If (Not:C34(vb_crearCargoAut))
			vsACT_SelectedItemName:=""
			vb_utilizarIECargoXMoneda:=False:C215
		End if 
		If ((vlACT_id_modo_pago#-9) & (vlACT_id_modo_pago#-10) & (vlACT_id_modo_pago#-11) & (vAOptions))
			vAOptions:=False:C215
		End if 
		If (vb_selectionItems2Pay)
			_O_ENABLE BUTTON:C192(vl_generaIntereses)
		Else 
			vl_generaIntereses:=0
			_O_DISABLE BUTTON:C193(vl_generaIntereses)
		End if 
		OBJECT SET VISIBLE:C603(vAOptions;((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10) | (vlACT_id_modo_pago=-11)))
		  // Modificado por: Saúl Ponce (28-04-2017) Ticket 177342, Estas formas de pago no deben presentar la opción de "importar según la fecha de pago leída desde el archivo"
		  //OBJECT SET VISIBLE(vb_fechaPago;((vlACT_id_modo_pago#-9) & (vlACT_id_modo_pago#-10) & (vlACT_id_modo_pago#-11)))
		
		  //If (((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10) | (vlACT_id_modo_pago=-11)) & (vlACT_ImportadorID#0))  //20180828 RCH Ticket 214674
		  //READ ONLY([xxACT_ArchivosBancarios])
		  //QUERY([xxACT_ArchivosBancarios];[xxACT_ArchivosBancarios]ID=vlACT_ImportadorID)
		  //If ([xxACT_ArchivosBancarios]CreadoPorAsistente)
		  //C_LONGINT(PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2;WTrf_s3;cs_IEncabezado;cs_IPie)
		  //C_LONGINT(WTrf_s4)
		  //C_TEXT(WTrf_s4_CaracterOtro)
		  //C_TEXT(vt_ICodApr;vIIdentificador;vIFormatoCA)
		  //SET BLOB SIZE(xBlob;0)
		  //xBlob:=[xxACT_ArchivosBancarios]xData
		  //BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH
		  //SET BLOB SIZE(xBlob;0)
		  //$l_pos:=Find in array(at_idsTextos;"7")
		  //If ($l_pos>0)
		  //Case of 
		  //: (PWTrf_h1=1)
		  //OBJECT SET VISIBLE(vb_fechaPago;(al_Numero{$l_pos}>0))
		  //: (PWTrf_h2=1)
		  //OBJECT SET VISIBLE(vb_fechaPago;(al_PosIni{$l_pos}>0))
		  //End case 
		  //If (Not(b_valorModificado))
		  //vb_fechaPago:=True
		  //End if 
		  //End if 
		  //End if 
		  //End if 
		  //20180912 RCH No puedo crear ticket. Se deja visible fecha y se valida al tratar de usar
		OBJECT SET VISIBLE:C603(vb_fechaPago;True:C214)  //20180912 RCH
		
End case 
