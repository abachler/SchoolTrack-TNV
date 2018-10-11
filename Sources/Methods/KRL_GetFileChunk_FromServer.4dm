//%attributes = {"executedOnServer":true}
  // MÉTODO: KRL_GetFileChunk_FromServer
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/06/11, 20:34:37
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // KRL_GetFileChunk_FromServer()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($filePath;$t_Text)
C_BOOLEAN:C305($absolutePath;$3)
C_LONGINT:C283($l_DocumentPosition;$2)
C_BLOB:C604($x_Blob;$0)

$filePath:=$1
$l_DocumentPosition:=$2

$filePath:=Replace string:C233($filePath;":";Folder separator:K24:12)
$filePath:=Replace string:C233($filePath;"\\";Folder separator:K24:12)
If (SYS_IsWindows )
	$filePath:=Replace string:C233($filePath;"\\\\";":\\")
End if 

$l_chunkSize:=1024*1024


If (Count parameters:C259=3)
	$absolutePath:=$3
End if 

  // Código principal
If (Not:C34($absolutePath))
	$serverPath:=SYS_GetFolderNam (Structure file:C489)+$filePath
Else 
	$serverPath:=$filePath
End if 
If (Test path name:C476($filePath)=1)
	$h_DocRef:=Open document:C264($filePath)
	SET DOCUMENT POSITION:C482($h_docRef;$l_DocumentPosition;1)
	RECEIVE PACKET:C104($h_DocRef;$x_Blob;$l_chunkSize)
	CLOSE DOCUMENT:C267($h_DocRef)
End if 
$0:=$x_Blob



