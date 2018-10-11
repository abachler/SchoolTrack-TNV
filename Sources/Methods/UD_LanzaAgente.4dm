//%attributes = {}
  // UD_LanzaAgente()
  // Por: Alberto Bachler: 12/07/13, 12:02:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



  //Preparación de directorios de descarga e instalacion
Case of 
	: (SYS_IsWindows )
		$t_rutaAplicacion:=Application file:C491
		$t_rutaAplicacion:=SYS_GetParentNme ($t_rutaAplicacion)
		$t_DirectorioSchoolTrack:=SYS_GetParentNme ($t_rutaAplicacion)
		$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack"
		
	: (SYS_IsMacintosh )
		$t_rutaAplicacion:=Application file:C491
		$t_DirectorioSchoolTrack:=SYS_GetParentNme ($t_rutaAplicacion)
		$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack.app"
End case 
$t_directorioDescargas:=$t_DirectorioSchoolTrack+"Descargas"+Folder separator:K24:12
$t_rutaVersionAnterior:=$t_DirectorioSchoolTrack+"VersionAnterior"+Folder separator:K24:12



  // ****** PARA TEST FIJO EL DIRECTORIO DONDE SON  INSTALADAS LAS APLICACIONES POR DEFECTO ******
$t_DirectorioSchoolTrack:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12
$t_rutaVersionAnterior:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12+"VersionAnterior"+Folder separator:K24:12
$t_directorioDescargas:=$t_DirectorioSchoolTrack+"Descargas"+Folder separator:K24:12
Case of 
	: (SYS_IsMacintosh )
		$t_rutaAplicacion:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12+"SchoolTrack 11 Server.app"
		$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack.app"
	: (SYS_IsWindows )
		$t_rutaAplicacion:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12+"SchoolTrack 11 Server"
		$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack"
End case 
$t_rutaArchivoActualizacion:=$t_directorioDescargas+"SchoolTrackInstall.zip"


$t_rutaBaseDatos:=Data file:C490
BLOB_Variables2Blob (->$x_blob;0;->$t_rutaAplicacion;->$t_rutaBaseDatos;->$t_rutaArchivoActualizacion)
$t_rutaDocumentoActualización:=Get 4D folder:C485(Active 4D Folder:K5:10)+"STK_UpdateParameters.blb"
$h_ref:=Create document:C266($t_rutaDocumentoActualización)
CLOSE DOCUMENT:C267($h_ref)
BLOB TO DOCUMENT:C526($t_rutaDocumentoActualización;$x_blob)

$t_comando:="open "+LEP_Escape_path ($t_RutaAgente)
LEP_EjecutaComando ($t_comando)

