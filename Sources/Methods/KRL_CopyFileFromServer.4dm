//%attributes = {}
  // KRL_CopyFileFromServer(rutaServidor:T ; rutaLocal:T)
  // descarga el documento cuya ruta se pasa en rutaServidor y lo copia en rutaLocal en la máquina local
  //
  // creado por: Alberto Bachler Klein: 26-12-16, 11:21:42
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_error;$t_metodoOnErr;$t_rutaLocal;$t_rutaServer)


If (False:C215)
	C_TEXT:C284(KRL_CopyFileFromServer ;$0)
	C_TEXT:C284(KRL_CopyFileFromServer ;$1)
	C_TEXT:C284(KRL_CopyFileFromServer ;$2)
End if 

$t_rutaServer:=$1
$t_rutaLocal:=$2

$t_metodoOnErr:=Method called on error:C704
ON ERR CALL:C155("ERR_GenericOnError")
$x_blob:=KRL_GetFileFromServer ($t_rutaServer)

Case of 
	: (BLOB size:C605($x_blob)>0)
		BLOB TO DOCUMENT:C526($t_rutaLocal;$x_blob)
		
	: (BLOB size:C605($x_blob)=0)
		$t_error:=__ ("El documento no existe o está vacío.")
End case 

If (error#0)
	$t_error:=ERR_LogExecutionError 
End if 

ON ERR CALL:C155($t_metodoOnErr)

$0:=$t_error