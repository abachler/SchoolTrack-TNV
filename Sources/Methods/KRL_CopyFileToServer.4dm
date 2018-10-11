//%attributes = {}
  // KRL_CopyFileToServer (rutaLocal:T ; rutaServidor:T)
  // descarga el documento cuya ruta se pasa en rutaServidor y lo copia en rutaLocal en la máquina local
  //
  // creado por: Alberto Bachler Klein: 26-12-16, 15:24:01
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_error;$t_metodoOnErr;$t_rutaLocal;$t_rutaServer)
C_BOOLEAN:C305($b_absoluta)

If (False:C215)
	C_TEXT:C284(KRL_CopyFileToServer ;$0)
	C_TEXT:C284(KRL_CopyFileToServer ;$1)
	C_TEXT:C284(KRL_CopyFileToServer ;$2)
End if 

$t_rutaLocal:=$1
$t_rutaServer:=$2
If (Count parameters:C259>=3)
	$b_absoluta:=$3
End if 

$t_metodoOnErr:=Method called on error:C704
ON ERR CALL:C155("ERR_GenericOnError")

If (Test path name:C476($t_rutaLocal)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($t_rutaLocal;$x_blob)
End if 

Case of 
	: (BLOB size:C605($x_blob)>0)
		  // Modificado por: Saúl Ponce (20-02-2017) - Ticket Nº 175361 Ruta absoluta
		  //$t_error:=KRL_SendFileToServer ($t_rutaServer;$x_blob)
		$t_error:=KRL_SendFileToServer ($t_rutaServer;$x_blob;$b_absoluta)
		
	: (BLOB size:C605($x_blob)=0)
		$t_error:=__ ("El documento no existe o está vacío.")
End case 

If (error#0)
	$t_error:=ERR_LogExecutionError 
End if 

ON ERR CALL:C155($t_metodoOnErr)

$0:=$t_error