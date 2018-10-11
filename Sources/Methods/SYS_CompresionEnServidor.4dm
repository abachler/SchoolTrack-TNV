//%attributes = {"executedOnServer":true}
  // SYS_CompresionEnServidor()
  // Por: Alberto Bachler K.: 21-10-14, 13:12:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_POINTER:C301($4)
C_BOOLEAN:C305($5)

C_BOOLEAN:C305($b_eliminarOriginal)
C_POINTER:C301($y_resultado)
C_TEXT:C284($t_password;$t_rutaDestino;$t_rutaOrigen)


If (False:C215)
	C_BOOLEAN:C305(SYS_CompresionEnServidor ;$0)
	C_TEXT:C284(SYS_CompresionEnServidor ;$1)
	C_TEXT:C284(SYS_CompresionEnServidor ;$2)
	C_TEXT:C284(SYS_CompresionEnServidor ;$3)
	C_POINTER:C301(SYS_CompresionEnServidor ;$4)
	C_BOOLEAN:C305(SYS_CompresionEnServidor ;$5)
End if 
TRACE:C157
$t_rutaOrigen:=$1

Case of 
	: (Count parameters:C259=2)
		$t_rutaDestino:=$2
	: (Count parameters:C259=3)
		$t_rutaDestino:=$2
		$t_password:=$3
	: (Count parameters:C259=4)
		$t_rutaDestino:=$2
		$t_password:=$3
		$y_resultado:=$4
	: (Count parameters:C259=5)
		$t_rutaDestino:=$2
		$t_password:=$3
		$y_resultado:=$4
		$b_eliminarOriginal:=$5
End case 

Case of 
	: (SYS_IsWindows )
		$t_rutaOrigen:=Replace string:C233($t_rutaOrigen;":";Folder separator:K24:12)
		$t_rutaOrigen:=Replace string:C233($t_rutaOrigen;"\\\\";":\\")
		$t_rutaDestino:=Replace string:C233($t_rutaDestino;":";Folder separator:K24:12)
		$t_rutaDestino:=Replace string:C233($t_rutaDestino;"\\\\";":\\")
	: (SYS_IsMacintosh )
		$t_rutaOrigen:=Replace string:C233($t_rutaOrigen;"\\";Folder separator:K24:12)
		$t_rutaDestino:=Replace string:C233($t_rutaDestino;"\\";Folder separator:K24:12)
End case 
$0:=SYS_CompresionDescompresion ($t_rutaOrigen;$t_rutaDestino;$t_password;$y_resultado;$b_eliminarOriginal)