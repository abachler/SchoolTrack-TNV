//%attributes = {}
  //UD_v20130306_ACT_UpdateBlob

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283(cs_emitirCFDI;vlACT_RSSel;cs_generarArchivoIP;cs_asignarFolio;$i;cs_imprimirDocumento)
	C_BLOB:C604($vy_blob)
	ARRAY TEXT:C222(at_proveedores;0)
	
	ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
	
	
	For ($i;1;Size of array:C274(alACTcfg_Razones))
		vlACT_RSSel:=alACTcfg_Razones{$i}
		ACTcfdi_OpcionesGenerales ("ArmaBlob";->$vy_blob)
		$vy_blob:=PREF_fGetBlob (0;"ACT_CFG_BlobEmisor_"+String:C10(vlACT_RSSel);$vy_blob)
		BLOB_Blob2Vars (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio;->cs_imprimirDocumento)
		If (cs_emitirCFDI=0)
			ARRAY TEXT:C222(at_proveedores;0)
			cs_generarArchivoIP:=0
			cs_asignarFolio:=0
			cs_imprimirDocumento:=0
			ACTdte_OpcionesGenerales ("CargaProveedores";->at_proveedores)
			at_proveedores:=0
		End if 
		ACTcfdi_OpcionesGenerales ("ArmaBlob";->$vy_blob)
		PREF_SetBlob (0;"ACT_CFG_BlobEmisor_"+String:C10(vlACT_RSSel);$vy_blob)
	End for 
	
End if 