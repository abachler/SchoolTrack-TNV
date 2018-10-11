//%attributes = {}
  //20120103 RCH Esto va solo para 11.0

  //  //UD_v20120103_ACT_UpdateBlob
  //
  //If (ACT_AccountTrackInicializado )
  //C_LONGINT(cs_emitirCFDI;$vl_idRS;cs_generarArchivoIP;cs_asignarFolio;$i)
  //C_BLOB($vy_blob)
  //ARRAY TEXT(at_proveedores;0)
  //
  //ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
  //
  //For ($i;1;Size of array(alACTcfg_Razones))
  //cs_emitirCFDI:=0
  //at_proveedores:=1
  //cs_generarArchivoIP:=0
  //cs_asignarFolio:=0
  //$vl_idRS:=alACTcfg_Razones{$i}
  //
  //BLOB_Variables2Blob (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio)
  //$vy_blob:=PREF_fGetBlob (0;"ACT_CFG_BlobEmisor_"+String($vl_idRS);$vy_blob)
  //BLOB_Blob2Vars (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP)
  //BLOB_Variables2Blob (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio)
  //PREF_SetBlob (0;"ACT_CFG_BlobEmisor_"+String($vl_idRS);$vy_blob)
  //End for 
  //
  //End if 