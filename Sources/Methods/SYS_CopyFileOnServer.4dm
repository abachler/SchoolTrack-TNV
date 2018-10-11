//%attributes = {"executedOnServer":true}
  //SYS_CopyFileOnServer
  //metodo para copiar y/o mover archivos en el servidor
  // se ejecuta en el server. Las  rutas deben ser validas

C_TEXT:C284($vt_origen;$vt_destino)
C_BOOLEAN:C305($vb_eliminaOrigen)

$vt_origen:=$1
$vt_destino:=$2
If (Count parameters:C259=3)
	$vb_eliminaOrigen:=$3
End if 

ok:=1
If (Test path name:C476($vt_origen)=Is a document:K24:1)
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	COPY DOCUMENT:C541($vt_origen;$vt_destino;*)
	If ($vb_eliminaOrigen)
		DELETE DOCUMENT:C159($vt_origen)
	End if 
	EM_ErrorManager ("Clear")
Else 
	
End if 
$0:=ok