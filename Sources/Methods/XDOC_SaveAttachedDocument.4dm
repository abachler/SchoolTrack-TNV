//%attributes = {}
  // XDOC_SaveAttachedDocument()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 04/12/12, 17:05:12
  // ---------------------------------------------
C_LONGINT:C283($l_recNum)
C_TEXT:C284($t_carpetaDocumentos;$t_extensionArchivo;$t_nombreDocumento;$t_rutaArchivoTemporal;$t_rutaCarpeta;$t_rutaDescarga)


  // CÓDIGO
$l_recNum:=$1
READ ONLY:C145([xShell_Documents:91])
GOTO RECORD:C242([xShell_Documents:91];$l_recNum)
$t_rutaCarpeta:=xfGetDirName ("Seleccione el directorio para guardar el archivo")
If ($t_rutaCarpeta#"")
	$t_extensionArchivo:=[xShell_Documents:91]DocumentType:5
	If ($t_extensionArchivo#"")
		$t_nombreDocumento:=String:C10([xShell_Documents:91]DocID:9)+"."+$t_extensionArchivo
	Else 
		$t_nombreDocumento:=String:C10([xShell_Documents:91]DocID:9)
	End if 
	$t_carpetaDocumentos:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
	$t_rutaArchivoTemporal:=SYS_RetrieveFile_v11 ($t_carpetaDocumentos;$t_nombreDocumento;$t_rutaCarpeta)
	$t_rutaDescarga:=$t_rutaCarpeta+[xShell_Documents:91]DocumentName:3
	If (SYS_TestPathName ($t_rutaDescarga)=Is a document:K24:1)
		DELETE DOCUMENT:C159($t_rutaDescarga)
	End if 
	MOVE DOCUMENT:C540($t_rutaArchivoTemporal;$t_rutaDescarga)
	If (SYS_IsMacintosh )
		_O_SET DOCUMENT CREATOR:C531($t_rutaDescarga;[xShell_Documents:91]DocumentCreator:8)
	End if 
	SHOW ON DISK:C922($t_rutaDescarga)
End if 

