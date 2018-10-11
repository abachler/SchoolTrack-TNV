Case of 
	: (vi_PageNumber=1)
		vi_NoPagina:=2
		vi_PageNumber:=2
	: (vi_PageNumber=2)
		vi_NoPagina:=3
		vi_PageNumber:=3
	: (vi_PageNumber=3)
		vi_NoPagina:=4
		vi_PageNumber:=4
	: (vi_PageNumber=4)
		vi_NoPagina:=5
		vi_PageNumber:=5
	: (vi_PageNumber=5)
		vi_NoPagina:=6
		vi_PageNumber:=6
	: (vi_PageNumber=6)
		vi_NoPagina:=7
		vi_PageNumber:=7
End case 
POST KEY:C465(Character code:C91("+");256)
  //If (vi_PageNumber=3)
  //If ((PWTrf_Pac1=1) & (WTrf_ac2=1) & (bto_Exportacion=1))  `en cuponera me salto la pagina de selección de archivo bancario
  //vi_PageNumber:=4
  //vi_NoPagina:=3
  //viTypeFile:="Contabilidad"
  //End if 
  //If ((WTrf_tb3=1) | (WTrf_ac3=1))
  //READ WRITE([xxACT_ArchivosBancarios])
  //QUERY([xxACT_ArchivosBancarios];[xxACT_ArchivosBancarios]ID=vI_RecordNumber)
  //viNameFile:=[xxACT_ArchivosBancarios]Nombre
  //vt_tipoArchivo:=[xxACT_ArchivosBancarios]Tipo
  //WTrf_Tipo1:=0
  //WTrf_Tipo2:=0
  //WTrf_Tipo3:=0
  //If ([xxACT_ArchivosBancarios]ImpExp=False)
  //If (vt_tipoArchivo="PAC")
  //WTrf_Tipo1:=1
  //Else 
  //If (vt_tipoArchivo="PAT")
  //WTrf_Tipo2:=1
  //Else 
  //If (vt_tipoArchivo="Cuponera")
  //WTrf_Tipo3:=1
  //Else 
  //viTypeFile:="Contabilidad"
  //End if 
  //End if 
  //End if 
  //Else 
  //If ((vt_tipoArchivo="PAC") | (vt_tipoArchivo="Cheque"))
  //WTrf_Tipo1:=1
  //Else 
  //If ((vt_tipoArchivo="PAT") | (vt_tipoArchivo="Efectivo"))
  //WTrf_Tipo2:=1
  //Else 
  //If ((vt_tipoArchivo="Cuponera") | (vt_tipoArchivo="Tarjeta de crédito"))
  //WTrf_Tipo3:=1
  //End if 
  //End if 
  //End if 
  //End if 
  //
  //If (WTrf_tb3=1)
  //vNombreOldModeloTB:=viNameFile
  //Else 
  //vNombreOldModeloC:=viNameFile
  //End if 
  //If ([xxACT_ArchivosBancarios]ImpExp=False)
  //C_BLOB(xBlob)
  //C_BLOB(xBlobH)
  //C_BLOB(xBlobF)
  //SET BLOB SIZE(xBlob;0)
  //SET BLOB SIZE(xBlobH;0)
  //SET BLOB SIZE(xBlobF;0)
  //xBlob:=[xxACT_ArchivosBancarios]xData
  //xBlobH:=[xxACT_ArchivosBancarios]xDataHeader
  //xBlobF:=[xxACT_ArchivosBancarios]xDataFooter
  //BLOB_Blob2Vars (->xBlob;0;->al_recordTablePointersExpTemp;->al_recordFieldPointersExpTemp;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3)
  //BLOB_Blob2Vars (->xBlobH;0;->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe;->cs_encabezado)
  //BLOB_Blob2Vars (->xBlobF;0;->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo;->cs_registroControl)
  //SET BLOB SIZE(xBlob;0)
  //SET BLOB SIZE(xBlobH;0)
  //SET BLOB SIZE(xBlobF;0)
  //viFormatFile:=ST_Boolean2Str ((PWTrf_h2=1);"Archivo Plano";ST_Boolean2Str ((WTrf_s1=1);"Delimitado por Tabulación.";ST_Boolean2Str ((WTrf_s2=1);"Delimitado por Punto y Coma.";ST_Boolean2Str ((WTrf_s3=1);"Delimitado por Coma"))))
  //Else 
  //C_BLOB(xBlob)
  //SET BLOB SIZE(xBlob;0)
  //xBlob:=[xxACT_ArchivosBancarios]xData
  //BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->vIFormatoCA)
  //SET BLOB SIZE(xBlob;0)
  //viFormatFile:=ST_Boolean2Str ((PWTrf_h2=1);"Archivo Plano";ST_Boolean2Str ((WTrf_s1=1);"Delimitado por Tabulación.";ST_Boolean2Str ((WTrf_s2=1);"Delimitado por Punto y Coma.";ST_Boolean2Str ((WTrf_s3=1);"Delimitado por Coma"))))
  //DISABLE BUTTON(bVolver)
  //vb_testImport:=True
  //End if 
  //vi_PageNumber:=5
  //vi_NoPagina:=5
  //End if 
  //
  //If (bto_Exportacion=1)
  //BUTTON TEXT(WTrf_Tipo1;"PAC")
  //BUTTON TEXT(WTrf_Tipo2;"PAT")
  //BUTTON TEXT(WTrf_Tipo3;"CUP")
  //vt_pg3_1:="El nuevo archivo será para exportar según modo de pago Pago Automático de Cuentas"
  //vt_pg3_2:="El nuevo archivo será para exportar según modo de pago Pago Automático con Tarjet"+"a de Crédito."
  //vt_pg3_3:="El nuevo archivo será para exportar según modo de pago Cuponera."
  //Else 
  //If (bto_Importacion=1)
  //If (WTrf_tb2=1)
  //BUTTON TEXT(WTrf_Tipo1;"PAC")
  //BUTTON TEXT(WTrf_Tipo2;"PAT")
  //BUTTON TEXT(WTrf_Tipo3;"CUP")
  //vt_pg3_1:="El nuevo archivo será para importar según modo de pago Pago Automático de Cuentas"
  //vt_pg3_2:="El nuevo archivo será para importar según modo de pago Pago Automático con Tarjet"+"a de Crédito."
  //vt_pg3_3:="El nuevo archivo será para importar según modo de pago Cuponera."
  //Else 
  //BUTTON TEXT(WTrf_Tipo1;"Cheques")
  //BUTTON TEXT(WTrf_Tipo2;"Efectivo")
  //BUTTON TEXT(WTrf_Tipo3;"Tarjeta de crédito")
  //vt_pg3_1:="El nuevo archivo será para importar según modo de pago Cheque."
  //vt_pg3_2:="El nuevo archivo será para importar según modo de pago Efetivo."
  //vt_pg3_3:="El nuevo archivo será para importar según modo de pago Tarjeta de Crédito."
  //End if 
  //End if 
  //End if 
  //End if 
  //If (vi_PageNumber=5)
  //C_TEXT($vt_typeFileTemp;$vt_formatFile)
  //$vt_typeFileTemp:=viTypeFile
  //$vt_formatFile:=viFormatFile
  //Case of 
  //: (bto_Exportacion=1)
  //If (PWTrf_Ptb1=1)
  //If (WTrf_Tipo1=1)
  //viTypeFile:="PAC"
  //Else 
  //If (WTrf_Tipo2=1)
  //viTypeFile:="PAT"
  //Else 
  //If (WTrf_Tipo3=1)
  //viTypeFile:="CUP"
  //Else 
  //End if 
  //End if 
  //End if 
  //Else 
  //viTypeFile:="Contabilidad"
  //End if 
  //: (bto_Importacion=1)
  //  `Else 
  //If (PWTrf_Ptb1=1)
  //If (WTrf_Tipo1=1)
  //viTypeFile:="PAC"
  //vIIdentificador:=at_IIdentificador{2}
  //Else 
  //If (WTrf_Tipo2=1)
  //viTypeFile:="PAT"
  //vIIdentificador:=at_IIdentificador{3}
  //Else 
  //If (WTrf_Tipo3=1)
  //viTypeFile:="CUP"
  //vIIdentificador:=at_IIdentificador{1}
  //Else 
  //End if 
  //End if 
  //End if 
  //Else 
  //If (WTrf_Tipo1=1)
  //viTypeFile:="Cheque"
  //vIIdentificador:=at_IIdentificador{1}
  //Else 
  //If (WTrf_Tipo2=1)
  //viTypeFile:="Efectivo"
  //vIIdentificador:=at_IIdentificador{1}
  //Else 
  //If (WTrf_Tipo3=1)
  //viTypeFile:="T.C."
  //vIIdentificador:=at_IIdentificador{1}
  //End if 
  //End if 
  //End if 
  //End if 
  //End case 
  //If (PWTrf_h2=1)
  //viFormatFile:="Archivo Plano"
  //Else 
  //If (PWTrf_h1=1)
  //viFormatFile:="Delimitado por "+ST_Boolean2Str (WTrf_s1=1;"Tabulación.";ST_Boolean2Str (WTrf_s2=1;"Punto y Coma.";ST_Boolean2Str (WTrf_s3=1;"Coma";"")))
  //End if 
  //End if 
  //C_BOOLEAN($modificado)
  //If (($vt_typeFileTemp#viTypeFile) | ($vt_formatFile#viFormatFile) & (WTrf_tb3=0) & (WTrf_ac3=0))
  //AL_UpdateArrays (xALP_ImportPagos;0)
  //ACTtf_DeclareArrays 
  //AL_UpdateArrays (xALP_ImportPagos;-2)
  //AL_RemoveArrays (xALP_ImportPagos;20)
  //$modificado:=True
  //End if 
  //End if 
  //
  //Case of 
  //: (bto_Exportacion=1)  `export
  //If (vi_PageNumber=5)
  //xALP_ACT_ExportBankFiles (1)
  //IT_SetButtonState ((cs_encabezado=1);->bInsertLine)
  //End if 
  //If (vi_PageNumber=6)
  //If (Size of array(al_NumeroHe)=0)  `si no hay líneasme aseguro de desmarcar que el archivo tiene encabezado
  //cs_encabezado:=0
  //End if 
  //xALP_ACT_ExportBankFiles (2)
  //IT_SetButtonState ((cs_registroControl=1);->bInsertLine)
  //End if 
  //If (vi_PageNumber=7)
  //If (Size of array(al_NumeroFo)=0)  `si no hay líneasme aseguro de desmarcar que el archivo tiene encabezado
  //cs_registroControl:=0
  //End if 
  //If ((WTrf_tb3=1) | (WTrf_ac3=1))  `modificacion archivo bancario
  //SORT ARRAY(al_Numero;at_Descripcion;al_PosIni;al_Largo;al_PosFinal;at_formato;at_Alineado;at_Relleno;at_TextoFijo;al_recordTablePointersExpTemp;al_recordFieldPointersExpTemp;>)
  //ARRAY LONGINT(al_recordTablePointersExpTemp;Size of array(al_Numero))
  //ARRAY LONGINT(al_recordFieldPointersExpTemp;Size of array(al_Numero))
  //SET BLOB SIZE(xBlob;0)
  //End if 
  //xALP_ACT_ExportBankFiles (3)
  //AL_UpdateArrays (xALP_ExportBankFiles;-2)
  //IT_SetButtonState (False;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine)
  //alProEvt:=AL_GetLine (xALP_ExportBankFiles)  `porque al pasar con doble clic a esta página no se actualiza el estado del botón para eliminar.
  //If (alProEvt=0)
  //DISABLE BUTTON(bDeleteLine)
  //Else 
  //ENABLE BUTTON(bDeleteLine)
  //End if 
  //If ((alProEvt=0) | (alProEvt=1))
  //DISABLE BUTTON(bSubirLineaExp)
  //Else 
  //ENABLE BUTTON(bSubirLineaExp)
  //End if 
  //If ((alProEvt=0) | (alProEvt=Size of array(al_Numero)))
  //DISABLE BUTTON(bBajarLineaExp)
  //Else 
  //ENABLE BUTTON(bBajarLineaExp)
  //End if 
  //ENABLE BUTTON(bInsertLine)
  //End if 
  //
  //If (((vi_PageNumber=3) | (vi_PageNumber=5)) & ((WTrf_tb3=1) | (WTrf_ac3=1)))
  //DISABLE BUTTON(bPrev)
  //Else 
  //ENABLE BUTTON(bPrev)
  //End if 
  //: (bto_Importacion=1)  `import
  //Case of 
  //: (vi_PageNumber=5)  `import
  //If (((PWTrf_Ptb1=1) & (WTrf_tb2=1)) | ((PWTrf_Pac1=1) & (WTrf_ac2=1)))  `archivo nuevo
  //If ($modificado)
  //xALP_ACT_ExportBankFiles (4)
  //AL_UpdateArrays (xALP_ImportPagos;0)
  //Case of 
  //: ((WTrf_Tipo1=1) & (PWTrf_Ptb1=1))  `PAC
  //If (PWTrf_h2=1)
  //AT_Insert (1;3;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
  //Else 
  //AT_Insert (1;3;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
  //End if 
  //at_Descripcion{1}:="Monto"
  //at_Descripcion{2}:="Identificador único"
  //at_Descripcion{3}:="Descripción respuesta"
  //: ((WTrf_Tipo2=1) & (PWTrf_Ptb1=1))  `PAT
  //If (PWTrf_h2=1)
  //AT_Insert (1;6;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
  //Else 
  //AT_Insert (1;6;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
  //End if 
  //at_Descripcion{1}:="Monto"
  //at_Descripcion{2}:="Número tarjeta de crédito"
  //at_Descripcion{3}:="Nombre"
  //at_Descripcion{4}:="Identificador único"
  //at_Descripcion{5}:="Código respuesta"
  //at_Descripcion{6}:="Descripción respuesta"
  //: ((WTrf_Tipo3=1) & (PWTrf_Ptb1=1))  `CUP
  //If (PWTrf_h2=1)
  //AT_Insert (1;2;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
  //Else 
  //AT_Insert (1;2;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
  //End if 
  //at_Descripcion{1}:="Monto"
  //at_Descripcion{2}:="Identificador único"
  //: ((WTrf_Tipo1=1) & (PWTrf_Pac1=1))  `cheque
  //If (PWTrf_h2=1)
  //AT_Insert (1;8;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
  //Else 
  //AT_Insert (1;8;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
  //End if 
  //at_Descripcion{1}:="Fecha de pago"
  //at_Descripcion{2}:="Identificador único"
  //at_Descripcion{3}:="Monto"
  //at_Descripcion{4}:="Banco"
  //at_Descripcion{5}:="Serie"
  //at_Descripcion{6}:="Cuenta"
  //at_Descripcion{7}:="Fecha documento"
  //at_Descripcion{8}:="Lugar de pago"
  //: ((WTrf_Tipo2=1) & (PWTrf_Pac1=1))  `efectivo
  //If (PWTrf_h2=1)
  //AT_Insert (1;4;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
  //Else 
  //AT_Insert (1;4;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
  //End if 
  //at_Descripcion{1}:="Fecha de pago"
  //at_Descripcion{2}:="Identificador único"
  //at_Descripcion{3}:="Monto"
  //at_Descripcion{4}:="Lugar de pago"
  //: ((WTrf_Tipo3=1) & (PWTrf_Pac1=1))  `tarjeta de credito
  //If (PWTrf_h2=1)
  //AT_Insert (1;6;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
  //Else 
  //AT_Insert (1;6;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)  `
  //End if 
  //at_Descripcion{1}:="Fecha de pago"
  //at_Descripcion{2}:="Identificador único"
  //at_Descripcion{3}:="Monto"
  //at_Descripcion{4}:="Número tarjeta"
  //at_Descripcion{5}:="Lugar de pago"
  //at_Descripcion{6}:="Número de operación"
  //End case 
  //End if 
  //Else 
  //xALP_ACT_ExportBankFiles (4)  `inicializa arreglos a utilizar
  //End if 
  //AL_UpdateArrays (xALP_ImportPagos;-2)
  //vi_PageNumber:=8
  //vi_NoPagina:=6
  //End case 
  //ENABLE BUTTON(bPrev)
  //End case 
  //GOTO PAGE(vi_PageNumber)
  //GOTO PAGE(vi_PageNumber)