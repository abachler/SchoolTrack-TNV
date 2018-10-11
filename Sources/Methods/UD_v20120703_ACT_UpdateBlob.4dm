//%attributes = {}
  //UD_v20120703_ACT_UpdateBlob

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283(cs_emitirCFDI;$vl_idRS;cs_generarArchivoIP;cs_asignarFolio;$i;cs_imprimirDocumento)
	C_BLOB:C604($vy_blob)
	ARRAY TEXT:C222(at_proveedores;0)
	
	ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
	
	
	For ($i;1;Size of array:C274(alACTcfg_Razones))
		cs_emitirCFDI:=0
		at_proveedores:=1
		cs_generarArchivoIP:=0
		cs_asignarFolio:=0
		$vl_idRS:=alACTcfg_Razones{$i}
		cs_imprimirDocumento:=0
		
		ACTcfdi_OpcionesGenerales ("ArmaBlob";->$vy_blob)
		  //BLOB_Variables2Blob (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio;->cs_imprimirDocumento)
		$vy_blob:=PREF_fGetBlob (0;"ACT_CFG_BlobEmisor_"+String:C10($vl_idRS);$vy_blob)
		BLOB_Blob2Vars (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio)
		ACTcfdi_OpcionesGenerales ("ArmaBlob";->$vy_blob)
		PREF_SetBlob (0;"ACT_CFG_BlobEmisor_"+String:C10($vl_idRS);$vy_blob)
	End for 
	
End if 