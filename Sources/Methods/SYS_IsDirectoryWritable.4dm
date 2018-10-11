//%attributes = {}
  // MÉTODO: SYS_IsDirectoryWritable
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/06/11, 19:03:49
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // SYS_IsDirectoryWritable()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
$t_folderPath:=$1


  // CODIGO PRINCIPAL
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

$OK:=SYS_CreateFolder ($t_folderPath)

If (Test path name:C476($t_folderPath+"writeCheck.txt")=Is a document:K24:1)
	$h_docRef:=Open document:C264($t_folderPath+"writeCheck.txt")
Else 
	$h_docRef:=Create document:C266($t_folderPath+"writeCheck.txt")
End if 
If (error=0)
	SEND PACKET:C103($h_docRef;"writeCheck")
	CLOSE DOCUMENT:C267($h_docRef)
	DELETE DOCUMENT:C159(document)
End if 
If (($h_docRef#?00:00:00?) & (error=0))
	$0:=True:C214
Else 
	$0:=False:C215
End if 
EM_ErrorManager ("Clear")



