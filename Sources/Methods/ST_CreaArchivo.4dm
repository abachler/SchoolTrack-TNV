//%attributes = {}
  // ST_CreaArchivo()
  //
  //
  // modificado por: Alberto Bachler Klein: 11/02/17, 17:08:39
  // - normalización, declaración de variables, limpieza.
  // - documentos se almacenan desde ahora en carpeta Documentos del sistema para facilitar el acceso al usuario.
  // -----------------------------------------------------------
C_TIME:C306($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TIME:C306($ref)
C_TEXT:C284($folderName;$t_claseDocumento;$t_nombreDocumento;$t_rutaCarpeta;$t_rutaCarpetaDocumentos;$t_rutaDocumento;$t_rutaSubCarpeta)

If (False:C215)
	C_TIME:C306(ST_CreaArchivo ;$0)
	C_TEXT:C284(ST_CreaArchivo ;$1)
	C_TEXT:C284(ST_CreaArchivo ;$2)
End if 

C_TEXT:C284(vtACT_document)

$t_claseDocumento:=$1
$t_nombreDocumento:=$2
$t_rutaCarpetaDocumentos:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)

$t_rutaSubCarpeta:="Informes"
If (Count parameters:C259>=3)
	$t_rutaSubCarpeta:=$3
End if 

$t_rutaCarpeta:=$t_rutaCarpetaDocumentos+$t_rutaSubCarpeta+Folder separator:K24:12+$t_claseDocumento+Folder separator:K24:12
$t_rutaDocumento:=$t_rutaCarpeta+$t_nombreDocumento
CREATE FOLDER:C475($t_rutaDocumento;*)
OK:=Choose:C955(Test path name:C476($t_rutaCarpeta)#Is a folder:K24:2;0;1)

$t_rutaDocumento:=$t_rutaCarpeta+$t_nombreDocumento
SYS_DeleteFile ($t_rutaDocumento)

$ref:=Create document:C266($t_rutaDocumento;"TEXT")
vtACT_document:=$t_rutaDocumento

$0:=$ref