If ([ACT_Boletas:181]MX_pathFile:32#"")
	C_TEXT:C284($vt_documentName;$vt_propiedad;$vt_rutaCliente)
	ACTcfdi_OpcionesGenerales ("LeeConf";->[ACT_Boletas:181]ID_RazonSocial:25)
	
	$vt_documentName:=SYS_Path2FileName ([ACT_Boletas:181]MX_pathFile:32)
	$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
	$vt_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
	$vt_documentName:=$vt_rutaCliente+$vt_documentName
	
	$vt_retorno:=ACTcfdi_OpcionesGenerales ("ObtieneArchivoDesdeServer";->[ACT_Boletas:181]MX_pathFile:32;->$vt_documentName)
	Case of 
		: ($vt_retorno="1")
			SHOW ON DISK:C922(document)
			If (ok=0)
				CD_Dlog (0;__ ("Se produjo un error al intentar abrir la carpeta que contiene el archivo."))
			End if 
		: ($vt_retorno="-1")
			CD_Dlog (0;__ ("El archivo no pudo ser creado."))
			
		: ($vt_retorno="-2")
			CD_Dlog (0;__ ("El archivo no pudo ser encontrado en el servidor."))
			
	End case 
	
End if 

  //
  //If ([ACT_Boletas]MX_pathFile#"")
  //C_BLOB($xBlob)
  //ACTcfdi_OpcionesGenerales ("LeeConf";->[ACT_Boletas]ID_RazonSocial)
  //
  //$xBlob:=KRL_GetFileFromServer ([ACT_Boletas]MX_pathFile;True)
  //
  //If (BLOB size($xBlob)>0)
  //$vt_documentName:=SYS_Path2FileName ([ACT_Boletas]MX_pathFile)
  //$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
  //$vt_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
  //$vt_documentName:=$vt_rutaCliente+$vt_documentName
  //
  //EM_ErrorManager ("Install")
  //EM_ErrorManager ("SetMode";"")
  //SYS_CreateFolder ($vt_rutaCliente)
  //$ref:=Create document($vt_documentName)
  //If (ok=1)
  //CLOSE DOCUMENT($ref)
  //BLOB TO DOCUMENT(document;$xBlob)
  //SHOW ON DISK(document)
  //If (ok=0)
  //CD_Dlog (0;__ ("Se produjo un error al intentar abrir la carpeta que contiene el archivo."))
  //End if 
  //Else 
  //CD_Dlog (0;__ ("El archivo no pudo ser creado."))
  //End if 
  //EM_ErrorManager ("Clear")
  //Else 
  //CD_Dlog (0;__ ("El archivo no pudo ser encontrado en el servidor."))
  //End if 
  //End if 
