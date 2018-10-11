If (vi_PageNumber=3)
	If ((PWTrf_Pac1=1) & (WTrf_ac2=1) & (bto_Exportacion=1))  //en cuponera me salto la pagina de selección de archivo bancario
		vi_PageNumber:=4
		vi_NoPagina:=3
		  //viTypeFile:="Contabilidad"
		  //20121124 RCH
		vlACT_id_modo_pago:=-17
		vt_tipoArchivo:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_id_modo_pago)
		viTypeFile:=vt_tipoArchivo  // por compatibilidad
	End if 
	If ((WTrf_tb3=1) | (WTrf_ac3=1))
		READ WRITE:C146([xxACT_ArchivosBancarios:118])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=vI_RecordNumber)
		viNameFile:=[xxACT_ArchivosBancarios:118]Nombre:3
		vt_tipoArchivo:=[xxACT_ArchivosBancarios:118]Tipo:6
		WTrf_Tipo1:=0
		WTrf_Tipo2:=0
		WTrf_Tipo3:=0
		If ([xxACT_ArchivosBancarios:118]ImpExp:5=False:C215)
			If (vt_tipoArchivo="PAC")
				WTrf_Tipo1:=1
			Else 
				If (vt_tipoArchivo="PAT")
					WTrf_Tipo2:=1
				Else 
					If (vt_tipoArchivo="Cuponera")
						WTrf_Tipo3:=1
					Else 
						viTypeFile:="Contabilidad"
					End if 
				End if 
			End if 
		Else 
			If ((vt_tipoArchivo="PAC") | (vt_tipoArchivo="Cheque"))
				WTrf_Tipo1:=1
			Else 
				If ((vt_tipoArchivo="PAT") | (vt_tipoArchivo="Efectivo"))
					WTrf_Tipo2:=1
				Else 
					If ((vt_tipoArchivo="Cuponera") | (vt_tipoArchivo="Tarjeta de crédito"))
						WTrf_Tipo3:=1
					End if 
				End if 
			End if 
		End if 
		
		If (WTrf_tb3=1)
			vNombreOldModeloTB:=viNameFile
		Else 
			vNombreOldModeloC:=viNameFile
		End if 
		If ([xxACT_ArchivosBancarios:118]ImpExp:5=False:C215)
			C_BLOB:C604(xBlob)
			C_BLOB:C604(xBlobH)
			C_BLOB:C604(xBlobF)
			SET BLOB SIZE:C606(xBlob;0)
			SET BLOB SIZE:C606(xBlobH;0)
			SET BLOB SIZE:C606(xBlobF;0)
			xBlob:=[xxACT_ArchivosBancarios:118]xData:2
			xBlobH:=[xxACT_ArchivosBancarios:118]xDataHeader:10
			xBlobF:=[xxACT_ArchivosBancarios:118]xDataFooter:11
			BLOB_Blob2Vars (->xBlob;0;->al_recordTablePointersExpTemp;->al_recordFieldPointersExpTemp;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->WTrf_s4;->WTrf_s4_CaracterOtro)
			BLOB_Blob2Vars (->xBlobH;0;->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe;->cs_encabezado)
			BLOB_Blob2Vars (->xBlobF;0;->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo;->cs_registroControl)
			SET BLOB SIZE:C606(xBlob;0)
			SET BLOB SIZE:C606(xBlobH;0)
			SET BLOB SIZE:C606(xBlobF;0)
			viFormatFile:=ST_Boolean2Str ((PWTrf_h2=1);"Archivo Plano";ST_Boolean2Str ((WTrf_s1=1);"Delimitado por Tabulación.";ST_Boolean2Str ((WTrf_s2=1);"Delimitado por Punto y Coma.";ST_Boolean2Str ((WTrf_s3=1);"Delimitado por Coma";ST_Boolean2Str ((WTrf_s4=1);"Delimitado por "+WTrf_s4_CaracterOtro)))))
		Else 
			C_BLOB:C604(xBlob)
			SET BLOB SIZE:C606(xBlob;0)
			xBlob:=[xxACT_ArchivosBancarios:118]xData:2
			  //BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro)
			BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH ticket 214673
			SET BLOB SIZE:C606(xBlob;0)
			viFormatFile:=ST_Boolean2Str ((PWTrf_h2=1);"Archivo Plano";ST_Boolean2Str ((WTrf_s1=1);"Delimitado por Tabulación.";ST_Boolean2Str ((WTrf_s2=1);"Delimitado por Punto y Coma.";ST_Boolean2Str ((WTrf_s3=1);"Delimitado por Coma";ST_Boolean2Str ((WTrf_s4=1);"Delimitado por "+WTrf_s4_CaracterOtro)))))
			_O_DISABLE BUTTON:C193(bVolver)
			vb_testImport:=True:C214
			
			If (Size of array:C274(at_Descripcion)=Size of array:C274(at_idsTextos))
				For ($i;1;Size of array:C274(at_idsTextos))
					at_Descripcion{$i}:=ACTtf_OpcionesTextosImp (2;at_idsTextos{$i};<>vtXS_CountryCode)  //"Monto"
				End for 
			End if 
			  //BUTTON TEXT(bGuardar;"Guardar")
		End if 
		vi_PageNumber:=5
		vi_NoPagina:=5
	End if 
	
	If (bto_Exportacion=1)
		OBJECT SET TITLE:C194(WTrf_Tipo1;__ ("PAC"))
		OBJECT SET TITLE:C194(WTrf_Tipo2;__ ("PAT"))
		OBJECT SET TITLE:C194(WTrf_Tipo3;__ ("CUP"))
		vt_pg3_1:=__ ("El nuevo archivo será para exportar según modo de pago Pago Automático de Cuentas")
		vt_pg3_2:=__ ("El nuevo archivo será para exportar según modo de pago Pago Automático con Tarjeta de Crédito.")
		vt_pg3_3:=__ ("El nuevo archivo será para exportar según modo de pago Cuponera.")
		vsTipoArchivo:=__ ("Tipo de Exportador")
	Else 
		If (bto_Importacion=1)
			If (WTrf_tb2=1)
				OBJECT SET TITLE:C194(WTrf_Tipo1;__ ("PAC"))
				OBJECT SET TITLE:C194(WTrf_Tipo2;__ ("PAT"))
				OBJECT SET TITLE:C194(WTrf_Tipo3;__ ("CUP"))
				vt_pg3_1:=__ ("El nuevo archivo será para importar según modo de pago Pago Automático de Cuentas")
				vt_pg3_2:=__ ("El nuevo archivo será para importar según modo de pago Pago Automático con Tarjeta de Crédito.")
				vt_pg3_3:=__ ("El nuevo archivo será para importar según modo de pago Cuponera.")
			Else 
				OBJECT SET TITLE:C194(WTrf_Tipo1;__ ("Cheques"))
				OBJECT SET TITLE:C194(WTrf_Tipo2;__ ("Efectivo"))
				OBJECT SET TITLE:C194(WTrf_Tipo3;__ ("Tarjeta de crédito"))
				vt_pg3_1:=__ ("El nuevo archivo será para importar según modo de pago Cheque.")
				vt_pg3_2:=__ ("El nuevo archivo será para importar según modo de pago Efetivo.")
				vt_pg3_3:=__ ("El nuevo archivo será para importar según modo de pago Tarjeta de Crédito.")
			End if 
			vsTipoArchivo:=__ ("Tipo de Importador")
		End if 
	End if 
	IT_SetEnterable (False:C215;0;->vt_pg3_1;->vt_pg3_2;->vt_pg3_3)
End if 
If (vi_PageNumber=5)
	C_TEXT:C284($vt_typeFileTemp;$vt_formatFile)
	$vt_typeFileTemp:=viTypeFile
	$vt_formatFile:=viFormatFile
	Case of 
		: (bto_Exportacion=1)
			  //If (bto_Exportacion=1)  `tipo de archivo
			If (PWTrf_Ptb1=1)
				
			Else 
				viTypeFile:="Contabilidad"
			End if 
		: (bto_Importacion=1)
			  //Else
			If (vIIdentificador="")
				Case of 
					: (vlACT_id_modo_pago=-9)
						vIIdentificador:=at_IIdentificador{7}
					: (vlACT_id_modo_pago=-10)
						vIIdentificador:=at_IIdentificador{6}
					Else 
						vIIdentificador:=at_IIdentificador{1}
				End case 
			End if 
	End case 
	  //End if 
	If (PWTrf_h2=1)
		viFormatFile:="Archivo Plano"
	Else 
		If (PWTrf_h1=1)
			viFormatFile:="Delimitado por "+ST_Boolean2Str (WTrf_s1=1;"Tabulación.";ST_Boolean2Str (WTrf_s2=1;"Punto y Coma.";ST_Boolean2Str (WTrf_s3=1;"Coma";ST_Boolean2Str (WTrf_s4=1;"Otro";""))))
		End if 
	End if 
	C_BOOLEAN:C305(vb_modificadoTf)
	If (($vt_typeFileTemp#viTypeFile) | ($vt_formatFile#viFormatFile) & (WTrf_tb3=0) & (WTrf_ac3=0))
		AL_UpdateArrays (xALP_ImportPagos;0)
		AL_UpdateArrays (xALP_ExportBankFilesH;0)
		AL_UpdateArrays (xALP_ExportBankFilesF;0)
		ACTtf_DeclareArrays 
		AL_UpdateArrays (xALP_ExportBankFilesH;-2)
		AL_UpdateArrays (xALP_ExportBankFilesF;-2)
		AL_UpdateArrays (xALP_ImportPagos;-2)
		AL_RemoveArrays (xALP_ImportPagos;20)
		vb_modificadoTf:=True:C214
	End if 
End if 

Case of 
	: (bto_Exportacion=1)  //export
		If (vi_PageNumber=5)
			xALP_ACT_ExportBankFiles (1)
			IT_SetButtonState ((cs_encabezado=1);->bInsertLine)
		End if 
		If (vi_PageNumber=6)
			If (Size of array:C274(al_NumeroHe)=0)  //si no hay líneasme aseguro de desmarcar que el archivo tiene encabezado
				cs_encabezado:=0
			End if 
			xALP_ACT_ExportBankFiles (2)
			IT_SetButtonState ((cs_registroControl=1);->bInsertLine)
		End if 
		If (vi_PageNumber=7)
			If (Size of array:C274(al_NumeroFo)=0)  //si no hay líneasme aseguro de desmarcar que el archivo tiene encabezado
				cs_registroControl:=0
			End if 
			If ((WTrf_tb3=1) | (WTrf_ac3=1))  //modificacion archivo bancario
				SORT ARRAY:C229(al_Numero;at_Descripcion;al_PosIni;al_Largo;al_PosFinal;at_formato;at_Alineado;at_Relleno;at_TextoFijo;al_recordTablePointersExpTemp;al_recordFieldPointersExpTemp;>)
				ARRAY LONGINT:C221(al_recordTablePointersExpTemp;Size of array:C274(al_Numero))
				ARRAY LONGINT:C221(al_recordFieldPointersExpTemp;Size of array:C274(al_Numero))
				SET BLOB SIZE:C606(xBlob;0)
			End if 
			xALP_ACT_ExportBankFiles (3)
			AL_UpdateArrays (xALP_ExportBankFiles;-2)
			IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine)
			alProEvt:=AL_GetLine (xALP_ExportBankFiles)  //porque al pasar con doble clic a esta página no se actualiza el estado del botón para eliminar.
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
		End if 
		
		If (((vi_PageNumber=3) | (vi_PageNumber=5)) & ((WTrf_tb3=1) | (WTrf_ac3=1)))
			_O_DISABLE BUTTON:C193(bPrev)
		Else 
			_O_ENABLE BUTTON:C192(bPrev)
		End if 
	: (bto_Importacion=1)  //import
		Case of 
			: (vi_PageNumber=5)  //import
				If (((PWTrf_Ptb1=1) & (WTrf_tb2=1)) | ((PWTrf_Pac1=1) & (WTrf_ac2=1)))  //archivo nuevo
					If (vb_modificadoTf)
						xALP_ACT_ExportBankFiles (4)
						C_TEXT:C284($largo)
						AL_UpdateArrays (xALP_ImportPagos;0)
						$largo:=ACTtf_OpcionesTextosImp (3;String:C10(vlACT_id_modo_pago))
						  //Case of 
						  //: ((WTrf_Tipo1=1) & (PWTrf_Ptb1=1))  //PAC
						  //$largo:=ACTtf_OpcionesTextosImp (3;"PAC")
						  //: ((WTrf_Tipo2=1) & (PWTrf_Ptb1=1))  //PAT
						  //$largo:=ACTtf_OpcionesTextosImp (3;"PAT")
						  //: ((WTrf_Tipo3=1) & (PWTrf_Ptb1=1))  //CUP
						  //$largo:=ACTtf_OpcionesTextosImp (3;"Cuponera")
						  //: ((WTrf_Tipo1=1) & (PWTrf_Pac1=1))  //cheque
						  //$largo:=ACTtf_OpcionesTextosImp (3;"Cheque")
						  //: ((WTrf_Tipo2=1) & (PWTrf_Pac1=1))  //efectivo
						  //$largo:=ACTtf_OpcionesTextosImp (3;"Efectivo")
						  //: ((WTrf_Tipo3=1) & (PWTrf_Pac1=1))  //tarjeta de credito
						  //$largo:=ACTtf_OpcionesTextosImp (3;"Tarjeta de crédito")
						  //End case 
						If (Size of array:C274(at_Descripcion)>0)
							AT_Initialize (->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
							AT_Initialize (->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
						End if 
						If (PWTrf_h2=1)
							AT_Insert (1;Num:C11($largo);->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
						Else 
							AT_Insert (1;Num:C11($largo);->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
						End if 
						For ($i;1;Num:C11($largo))
							at_Descripcion{$i}:=ACTtf_OpcionesTextosImp (2;at_idsTextos{$i};<>vtXS_CountryCode)
						End for 
					End if 
				Else 
					xALP_ACT_ExportBankFiles (4)  //inicializa arreglos a utilizar
				End if 
				AL_UpdateArrays (xALP_ImportPagos;-2)
				vi_PageNumber:=8
				vi_NoPagina:=6
		End case 
		_O_ENABLE BUTTON:C192(bPrev)
End case 
FORM GOTO PAGE:C247(vi_PageNumber)
FORM GOTO PAGE:C247(vi_PageNumber)