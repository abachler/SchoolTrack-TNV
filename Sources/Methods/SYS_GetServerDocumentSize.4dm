//%attributes = {"executedOnServer":true}
  // MÉTODO: SYS_GetServerDocumentSize
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 09/06/11, 10:42:17
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // SYS_GetServerDocumentSize()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($x_Blob)
C_TEXT:C284($1;$t_serverFilePath)
C_BOOLEAN:C305($2;$absolutePath)
$t_serverFilePath:=$1


  // CODIGO PRINCIPAL
$t_serverFilePath:=$1
$t_serverFilePath:=Replace string:C233($t_serverFilePath;":";Folder separator:K24:12)
$t_serverFilePath:=Replace string:C233($t_serverFilePath;"\\";Folder separator:K24:12)
If (SYS_IsWindows )
	$t_serverFilePath:=Replace string:C233($t_serverFilePath;"\\\\";":\\")
End if 



If (Count parameters:C259=2)
	$absolutePath:=$2
End if 

If (Not:C34($absolutePath))
	$serverPath:=SYS_CarpetaAplicacion (CLG_Estructura)+$t_serverFilePath
Else 
	$serverPath:=$t_serverFilePath
End if 

$0:=Get document size:C479($t_serverFilePath)